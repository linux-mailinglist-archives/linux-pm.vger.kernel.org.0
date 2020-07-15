Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD532202F8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGODic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGODib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:38:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C03C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:38:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so1308238pfc.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DC+j4EVae4RnLgJTCnOM6IjTjMXDQK4HU4GWa3Ol4iw=;
        b=xCm6WtGghrzZIHVeAIpX3VeTjOAkwZB6Fpfm+5q+peTbvNwBqUgp7IbGuiU9enBs7U
         5uHg40id4ZeaRWExKahikfXjxTSRsayAf1OXtEwF2YY1M2ucllTGBKph8FxkHmFxe9vX
         O4cr4qQvAn05YFGyDunY/3YCeP+Fd45IrYqMrp7lpgFgs6OPtGQ7lBFkQN3WJMca2jI4
         weeg3jYtK8YO9eKuAFpTmBWVhXHH+aGK3hPDr8f7e7c8uRK7rQaD6SLQvBduNO269v1/
         EC7201KifvPXfG5MRO0gKp3lv2JdU7+45Diuj4RBonHUhLB9rEMeHspt+9KUb9i8jkQa
         FNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DC+j4EVae4RnLgJTCnOM6IjTjMXDQK4HU4GWa3Ol4iw=;
        b=p4tdJEOlfh8exsev0zwDVbbuTc0XDtzHwTUvatIQunrXVH6SEPKQvM/GVY6CFhigE6
         7+VWr+sCqIGqQMiPN5m3bm9CktLUrZn1Jn23X5gwoKDTCrxJfo7Eu6nyejdr59TJrDkY
         idD/FKDAf8jvQc4nkbQQ+pWUoQAqJYYFiioDepYO51UsRkP2NZIRPphDzyjZduzmN2aA
         tu4ftVKMt+1pJ+tSQuNSqbyxwDcf/6+QLOfA+TwRk5c5B8EoxeIFjJ+REQ4uITIZVKV7
         iJdByD8VUalvO7Acm1a2IkJh/eY7IOORv+a5biK/M5FnFagHcuN7xgSl+qkdUBp2jocX
         dTYw==
X-Gm-Message-State: AOAM533sspEgu+IBzHBtfyrEK45YY5yNOFXQSZ/Dlw8FAabcLW306VPB
        UKvS88uwEPQk4I3BhqgHmh4bfw==
X-Google-Smtp-Source: ABdhPJxrD9asMf+2w6YPcEVsiXhZteYoAJngfCjvTBomN8Y7B2D79FF9MwHPqmVmjskvbysGwmnbwQ==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr7531416pfn.143.1594784310954;
        Tue, 14 Jul 2020 20:38:30 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id m26sm302796pff.84.2020.07.14.20.38.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:38:30 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v7 2/8] cpufreq: mediatek: Enable clock and regulator
Message-ID: <20200715033828.zzjavbzg32dxkga4@vireshk-i7>
References: <1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1594348284-14199-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <20200713093909.676v7wxjzsz4vbxv@vireshk-i7>
 <1594732689.24540.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594732689.24540.4.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 21:18, andrew-sh.cheng wrote:
> On Mon, 2020-07-13 at 15:09 +0530, Viresh Kumar wrote:
> > On 10-07-20, 10:31, Andrew-sh.Cheng wrote:
> > > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > > 
> > > Need to enable regulator,
> > > so that the max/min requested value will be recorded
> > > even it is not applied right away.
> > > 
> > > Intermediate clock is not always enabled by ccf in different projects,
> > > so cpufreq should enable it by itself.
> > > 
> > > Change-Id: I9f4c8b1ea793794f5f9cdc65427daad1393f5df8
> > 
> > You are on V7 right now, these should have been gone long back.
> 
> Hi Viresh, 
> Sorry for forgetting to remove the change-ID message.
> 
> > 
> > > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > > ---
> > >  drivers/cpufreq/mediatek-cpufreq.c | 33 +++++++++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > > index 0c98dd08273d..4b479c110cc9 100644
> > > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > > @@ -350,6 +350,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> > >  		ret = PTR_ERR(proc_reg);
> > >  		goto out_free_resources;
> > >  	}
> > > +	ret = regulator_enable(proc_reg);
> > > +	if (ret) {
> > > +		pr_warn("enable vproc for cpu%d fail\n", cpu);
> > > +		goto out_free_resources;
> > > +	}
> > 
> > This is already done by the OPP core now.
> 
> Do you mean I can use dev_pm_opp_set_regulators() and
> dev_pm_opp_set_rate() to do dvfs?
> Due to mediatek-cpufreq may change Vproc and Vsram by special flow, that
> is not suitable.

Sorry about that. I completely missed that you aren't using
dev_pm_opp_set_rate().

-- 
viresh
