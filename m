Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2071A2046E7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgFWB4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 21:56:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:25133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbgFWB4P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 21:56:15 -0400
IronPort-SDR: mnkc2gtWSsxFihg+R3qdq6HCEDl8N/UZMcAlzPMH16Lh1MVKp9mCezzojnpxs1ZjfBgxn0DlDp
 ed5UFuSkVONA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209123801"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="209123801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 18:55:26 -0700
IronPort-SDR: c7fQlezvt9UUct1YKe9X4P7jCCWicimvxVRgDSFVd67T7uaPCDncj+d4Pj/U1iCPzJcXiRB+Bo
 qePFxiETuZeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="452047841"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2020 18:55:24 -0700
Date:   Tue, 23 Jun 2020 09:56:28 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
Subject: Re: [PATCH][v2] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
Message-ID: <20200623015628.GA28671@chenyu-office.sh.intel.com>
References: <20200616040442.21515-1-yu.c.chen@intel.com>
 <CAJZ5v0gBVBAjdCOXsM-Fa-iAkuv2JMi2mVkG5w7ADcg9dWencA@mail.gmail.com>
 <20200622171759.GA26527@chenyu-office.sh.intel.com>
 <CAJZ5v0grJZyOX7fFx_nNjtOLT1NGyu1L10H3TY+e0HR3+T8JZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0grJZyOX7fFx_nNjtOLT1NGyu1L10H3TY+e0HR3+T8JZA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 09:45:35PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 22, 2020 at 7:16 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi Rafael,
> > On Mon, Jun 22, 2020 at 06:19:35PM +0200, Rafael J. Wysocki wrote:
> > [cut]
> > > > +{
> > > > +       if (!current_clr_polling_and_test())
> > > > +               s2idle_enter(drv, dev, index);
> > > > +
> > > > +       return index;
> > >
> > > Is the value returned here used at all?
> > >
> > It is not used for now IMO.
> > > >          */
> > > >         index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > > >         if (index > 0)
> > > > -               enter_s2idle_proper(drv, dev, index);
> > > > +               call_s2idle(drv, dev, index);
> > >
> > > I'm wondering why this can't be
> > >
> > >     if (index > 0 && !current_clr_polling_and_test())
> > >             enter_s2idle_proper(drv, dev, index);
> > >
> > Yes, it should be simpler, but I guess Peter was trying to
> > make call_s2idle() consistent with call_cpuidle(),
> > and also s2idle_enter() is analogous to cpuidle_enter().
> 
> So IMO it would be better to do the simplest fix first and then do the
> cleanup on top of it.
>
Okay, I'll do that.

Thanks,
Chenyu
