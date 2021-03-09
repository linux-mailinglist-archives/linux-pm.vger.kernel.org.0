Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783F5332525
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhCIMPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 07:15:33 -0500
Received: from foss.arm.com ([217.140.110.172]:52280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhCIMPH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 07:15:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2C21042;
        Tue,  9 Mar 2021 04:15:06 -0800 (PST)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A607D3F70D;
        Tue,  9 Mar 2021 04:15:04 -0800 (PST)
Date:   Tue, 9 Mar 2021 12:14:56 +0000
From:   Beata Michalska <beata.michalska@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210309121455.GA13095@e120325.cambridge.arm.com>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
 <20210308181446.GA26783@e120325.cambridge.arm.com>
 <20210309043121.546mlvl4jmshogor@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309043121.546mlvl4jmshogor@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 09, 2021 at 10:01:21AM +0530, Viresh Kumar wrote:
> On 08-03-21, 18:14, Beata Michalska wrote:
> > > -bool _opp_remove_all_static(struct opp_table *opp_table)
> > > +/*
> > > + * Can't remove the OPP from under the lock, debugfs removal needs to happen
> > > + * lock less to avoid circular dependency issues. This must be called without
> > > + * the opp_table->lock held.
> > > + */
> > > +static int _opp_drain_list(struct opp_table *opp_table, bool dynamic)
> > >  {
> > > -	struct dev_pm_opp *opp;
> > > +	struct dev_pm_opp *opp, *current_opp = NULL;
> > > +	int count = 0;
> > > +
> > > +	while ((opp = _opp_get_next(opp_table, dynamic))) {
> > > +		if (opp_table->current_opp == opp) {
> > > +			/*
> > > +			 * Reached at current OPP twice, no other OPPs left. The
> > > +			 * last reference to current_opp is dropped from
> > > +			 * _opp_table_kref_release().
> > > +			 */
> > > +			if (current_opp)
> > > +				break;
> > > +
> > > +			current_opp = opp;
> > > +		}
> > Having a quick look at the code ...
> > Shouldn't the current_opp be moved at the end of the list ?
> > Otherwise there is a risk of leaving unreferenced opps (and opp_table).
> 
> How exactly ? Note that it is expected that the OPP table isn't being
> used by anyone anymore at this point and all the users went away.
>
With the current version, once the _opp_get_next returns opp
that is the current_opp, the while loop will break, leaving all
the opps that are on the list after current_opp: _opp_get_next
is not actually getting the *next* entry from the list. If it
reaches the current_opp, the _next_ one will still be the same opp
as it will not be removed from the list at this point
( _opp_get_next is a simple for_each_entry and until the first entry
gets removed from the list it will always return the same one).
If the opp_table->current_opp gets pushed at the end of the list,
it should be safe to assume that if it gets reached for the second time,
it's the last one on the list).

The dev_pm_opp_remove_all_dynamic depends on the number of dynamic
opps removed from the list to drop the according number of references
on the opp_table. If the count does not correspond to number of calls
to dev_pm_opp_add, the final refcount on opp_table might not drop to
the point when the table will actually get released. And if the while
loop above drops earlier - this might be the case.

Also, I am not sure how probable is the case, but if the current_opp
has more references that the initial one and one from current_opp,
it might not get released properly either.

Or am I missing smth ?

> > Might be also worth adding warning (?)
> > 
> >     WARN_ONCE(!list_is_singular())
> 
> It is allowed for the list to contain both static and dynamic OPPs,
> and so the list may have more OPPs here.
> 

True, jumped to the idea too early and the _opp_table_kref_release
already warns on list not being empty.

---
BR.
B.
> -- 
> viresh
