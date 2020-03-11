Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A850A181059
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgCKGGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 02:06:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38799 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKGGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 02:06:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so690169pfn.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VD15hEVyVLaO06R8soxT+wdeQAWi6jWDprT4gENa4Pk=;
        b=BXuEks7icu5+J5qHi20hsEXmiCS9E/ow1l+ZYZM9dxF94vzf71w5/CXBQ/elTEp2KY
         sK8PCWAC3CzcAsApi7PogMStwLY/F4bznDnaXJEdBmhw68CVuyf9vg0GSasdNXWi1ZwT
         7hT/PuFLEvpc89BNSLsKiNMtvhjH4ARqGRItPC1FZ5eS88OofdfR+fvzxCiIw9RNVbBH
         DKPTCJAE4h7KiuM6zOg9g0+3oavV1W+RM5RX6EcvpwmUgcS5BSDXSw+8pyqe4yxY6HxW
         YO+gCM+xBLjl9wjlLUpYgIyOjYjSmeSVRwCpR+CVEmmjBcyduqs/JiHWgwd69myM0ZN/
         bKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VD15hEVyVLaO06R8soxT+wdeQAWi6jWDprT4gENa4Pk=;
        b=jneB6F0R3+bBKkTAtWngNnpire4SSOP5jdVhXIsv3MmSGz8a/Zdg35jfHjScbzJ11W
         DZccirSZfLoVKmKv18HsFDkMIuHGqLOgtKUl8Srju1tPl7Zt9Gc48+JJo09q1xNCeFyT
         5FZn7PNoPFJMTHB+ZVtPwhylv72LAu6VCWhqdE35rcSmjAQEJ5iChNktlTDnRPagZidE
         TjSCWHQ8Mp/e5Jtk7/eTVeE7td0DUs9jOvSm4/vFyVEIi+qCwZQBb0ApJYAz9seeAkAD
         F+RPtK3thg90rdKdS7wwgZXQefQm+VUVSaYIGv5X/VtvTV94sEbrgMpir7gVDjoU8OoM
         PvIA==
X-Gm-Message-State: ANhLgQ1Pc7aui9Fji7+PB1algGbVfhs8qV1QxXwJBgctLvP6c/Q+hW1X
        Um4KB4Uymr3gbEghZvBb6lcKSw==
X-Google-Smtp-Source: ADFU+vtUcWmiYBhCHp72xQGkMofh54beImT2nmLF78jXNh6JeBSFkkPXyzzpZemY6U8GEERnxtK6Bg==
X-Received: by 2002:a63:a055:: with SMTP id u21mr1300692pgn.100.1583906780227;
        Tue, 10 Mar 2020 23:06:20 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id i5sm31347131pfo.173.2020.03.10.23.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 23:06:19 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:36:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v5, PATCH 4/5] cpufreq: mediatek: add opp notification for SVS
 support
Message-ID: <20200311060616.62nh7sfwtjwvrjfr@vireshk-i7>
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1574769046-28449-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20191127083619.etocnhpyyut3hzwq@vireshk-i7>
 <1575874588.13494.4.camel@mtksdaap41>
 <20191210064319.f4ksrxozp3gv4xry@vireshk-i7>
 <1583827865.4840.1.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583827865.4840.1.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-03-20, 16:11, andrew-sh.cheng wrote:
> On Tue, 2019-12-10 at 14:43 +0800, Viresh Kumar wrote:
> > On 09-12-19, 14:56, andrew-sh.cheng wrote:
> > > On Wed, 2019-11-27 at 14:06 +0530, Viresh Kumar wrote:
> > > > On 26-11-19, 19:50, Andrew-sh.Cheng wrote:
> > > > > +		if (!IS_ERR(opp_item))
> > > > > +			dev_pm_opp_put(opp_item);
> > > > > +		else
> > > > > +			freq = 0;
> > > > > +
> > > > 
> > > > What is the purpose of the above code ?
> > > When dev_pm_opp_find_freq_ceil() doesn't find matching opp item, freq
> > > value won't be set.
> > > Set it as 0 for below checking
> > > > 
> > > > > +		/* case of current opp is disabled */
> > > > > +		if (freq == 0 || freq != info->opp_freq) {
> > > > > +			// find an enable opp item
> > > > > +			freq = 1;
> > > > > +			opp_item = dev_pm_opp_find_freq_ceil(info->cpu_dev,
> > > > > +							     &freq);
> > > > > +			if (!IS_ERR(opp_item)) {
> > > > > +				dev_pm_opp_put(opp_item);
> > > > > +				policy = cpufreq_cpu_get(info->opp_cpu);
> > > > > +				if (policy) {
> > > > > +					cpufreq_driver_target(policy,
> > > > > +						freq / 1000,
> > > > > +						CPUFREQ_RELATION_L);
> > > > 
> > > > Why don't you simply call this instead of all the code in the else
> > > > block ?
> > > These else code is used to check "current opp item is disabled or not".
> > > If not, do nothing.
> > > If current opp item is disabled, need to find an not-disabled opp item,
> > > and set frequency to it.
> > 
> > Right. So this notifier helper of yours receive the opp which is getting
> > disabled, why don't you compare its frequency directly to see if the current OPP
> > is getting disabled ?
> Sorry to overlook your question.
> This is because when the opp is disabled,
> we cannot use dev_pm_opp_get_freq() to get frequency of that opp.
> There is a check:
> 	if (IS_ERR_OR_NULL(opp) || !opp->available) {

I think we can remove the available check here, as we are jut trying
to find frequency of an OPP we already have. Send a patch for that
please.

> 		pr_err("%s: Invalid parameters\n", __func__);
> 		return 0;
> 
> > 
> 

-- 
viresh
