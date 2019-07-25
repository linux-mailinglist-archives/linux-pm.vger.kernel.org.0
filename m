Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3A74510
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 07:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403954AbfGYFi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 01:38:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42256 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403937AbfGYFi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 01:38:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so22964653plb.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KbxETKIL10GKxcPRBcaESnVSFrDSXJGz52Sgbzz7TY=;
        b=QVIvWHfpVoQwjxa/sbG+597puJK/8e4mjlXaInhXoeUlj86gGaA2JdXs7ym/gt6i0B
         B4hBuxUbCKgnit1c2mY0EXEpoq40XwGdXtEjvj0JUFw0io5OWUfK2/B2sCW+o2RMIoRg
         0SFhPVb8Gh0GPk8QBNiRwoG68RDyG+1UX8G1u/Q8TxzSyeU5VfgEYBTcTwvRoOhUuii3
         piUEjzodony2/N3PvNdf1Gr7EWpLC/BBG+q1r3nfaurq2Thy6D+QHS0yDZHyqKURVOCl
         IN4cbnD8wSlft20sXgkEuRpj64YfEqV0XR/ixrIsExBjkozjqgBTciqXMQTOeoB8751v
         kvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KbxETKIL10GKxcPRBcaESnVSFrDSXJGz52Sgbzz7TY=;
        b=tMuKA1ta/tYxTxWyMY//bpWQIj9BhndVDY/F8GKvx8Y732Nr3vQx5vfKp2Fpw4wu1z
         pjJFQcsVYxj4QUY9nsPLlJF0wuv2jecw0WC+UfNmyKoKqQp4VowAdqb3DXtwA37Db3bE
         9U1DwhIQrl+p8wY7anD/oUuDFP/pbVSsmAsgoOlGsNBTb9yXP2Gr8L44F8y3Vd9bW4UZ
         fOiyd93Q/VHRfC6MRowznGA/fTmEatZw0m9xnp9Gu3+rFSEDvJEJnXNBP0KRa+j/vHz3
         jM1c8QFfKSnTYtPVZg68xdMBALOQOFxzv5JiY3WxnzgPRwubFLHsnXY2olFJ4y/pp1cW
         JEIA==
X-Gm-Message-State: APjAAAXmh+qCGk3GPs621E5NoVaRwT0BDOzJCoctDZ/wbce7LKGDO0rE
        rEU2RGV0x/u+qXECDgEX6jpg3490Mg8=
X-Google-Smtp-Source: APXvYqy2oP17uAmGByW/mG2EYEfPXeuWrnrPxGE0ocCWmuE/cKB+F9KVRpeYqx2tU6r6lDZnp0bQ3Q==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr90071191pll.321.1564033105968;
        Wed, 24 Jul 2019 22:38:25 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o11sm80515271pfh.114.2019.07.24.22.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 22:38:25 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:08:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
Message-ID: <20190725053823.yqaxnk2a7geebmqw@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-3-saravanak@google.com>
 <20190723095316.t5ltprixxd5veuj7@vireshk-i7>
 <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
 <20190725025849.y2xyxmqmgorrny6k@vireshk-i7>
 <CAGETcx8r3C_=Y0vSwqekCZPUeYkNQ6EOUDK4bUJksDHG6zPUjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8r3C_=Y0vSwqekCZPUeYkNQ6EOUDK4bUJksDHG6zPUjA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-07-19, 20:46, Saravana Kannan wrote:
> On Wed, Jul 24, 2019 at 7:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 23-07-19, 17:23, Saravana Kannan wrote:

> > > I almost said "not sure. Let me just compare pointers".
> > > I think (not sure) it has to do with the same OPP table being used to
> > > create multiple OPP table copies if the "shared OPP table" flag isn't
> > > set?
> > > Can you confirm if this makes sense? If so, I can add a comment patch
> > > that adds comments to the existing code and then copies it into this
> > > function in this patch.
> >
> > Right, that was the reason but we also need to fix ...
> 
> I know I gave that explanation but I'm still a bit confused by the
> existing logic. If the same DT OPP table is used to create multiple in
> memory OPP tables, how do you device which in memory OPP table is the
> right one to point to?

This is a bit broken actually, we don't see any problems right now but
may eventually have to fix it someday.

We pick the first in-memory OPP table that was created using the DT
OPP table. This is done because the DT doesn't provide any explicit
linking to the required-opp device right now.

Right now the required-opps is only used for power domains and so it
is working fine. It may work fine for your case as well. But once we
have a case we want to use required-opps in a single OPP table for
both power-domains and master/slave thing you are proposing, we may
see more problems.

> > > > > +                     break;
> > > > > +     }
> > > > > +
> > > > > +     if (unlikely(i == src_table->required_opp_count)) {
> > > > > +             pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> > > > > +                    __func__, src_table, dst_table);
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     mutex_lock(&src_table->lock);
> > > > > +
> > > > > +     list_for_each_entry(opp, &src_table->opp_list, node) {
> > > > > +             if (opp == src_opp) {
> >
> > ... this as well. We must be comparing node pointers here as well.
> 
> Not really, if an in memory OPP entry is not part of an in memory OPP
> table list, I don't think it should be considered part of the OPP
> table just because the node pointer is the same. I think that's
> explicitly wrong and the above code is correct as is.

I understand what you are saying, but because we match the very first
OPP table that was there in the list we need to match the DT node here
as well.

Or somehow we make sure to have the correct in-memory OPP table being
pointed by the required-opp-table array. Then we don't need the node
pointer anywhere here.

-- 
viresh
