Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C404A364E94
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 01:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhDSXX3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhDSXX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 19:23:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A50C06138A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 16:22:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u16so19866046oiu.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZL8naNYW6+lQXsNwg4wa0reXC9U90f82sYjKZ1TEVfg=;
        b=lTYqQB87lrkthc2zaFVsrnngpUwM/bE6ADojNZ8AnZ86bGhfIVaGCf5I+IB7K64wFm
         bEvBqBGiBa1vz5m5u2RXlWexGoz47jkdj8v6FPsMdx4RHsSMgKsLeOeKN6vC1Wt1Dv2A
         IT1iGKb/4Z4/1v4/5nOhb8bjOS/kuXGeY0ilKnMHxlIK2s9t6h2B2wYj916oeP3jIO+F
         RLUiTXq4xd3t1ytVVL1V8HEW66UQMejHOtoI76Al6gKbQB+JZZSpdhhPXRq9Nz4Hj8I/
         1ugfXXOlvdblQcxp68El6gutRL+DdYztw6ZKVklNT67lCxpUrskn6vK4yR5NQPgy9ufm
         ryHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZL8naNYW6+lQXsNwg4wa0reXC9U90f82sYjKZ1TEVfg=;
        b=KaN689Ih2vuntKdq7W+PDkkQLiLKP8bR+PL1IqEKi+MaJwF9sYotDcO3Iq6rvnZKk7
         RvHamYSh8MlFpG98tV/tDV1NyNLrbbLNjBpzmxDO4HiFb6NpWDzyQ2BYaySFfjvZimQB
         XiY8jOMjGlLlGkEFNS5yfeeIJhS+COl1L2lmAVTsE9swq/2q2Ezygtkbsy1v3EMZdKX9
         osbECCCPiz2GZjdOkbr1MnziulWbMLYOiph/dCYebAvkP98RyEUY4XQwXAqtj2ztsGcq
         BtFBK413q2AO3wwtzuq81oebqzR+Z1sGbXkYcH3lFICQqq0BtUDWd5aqSvA87riPoLos
         /nbA==
X-Gm-Message-State: AOAM5333J80woIq4GdIaC8OuBqa4txpTN0hLCdfBSfSI4h+ZoNQgGev/
        Ylbvc9tCBj3rJdeTVqymFRv+tA==
X-Google-Smtp-Source: ABdhPJzJBZHzx45B2l5HoTJYouZf0YYV2op+G/HwUYciFdnEwwrICxLjS7ofpfvnLtqzJC619tgCYw==
X-Received: by 2002:aca:ed50:: with SMTP id l77mr1029626oih.13.1618874576101;
        Mon, 19 Apr 2021 16:22:56 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c12sm3134418oou.26.2021.04.19.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 16:22:55 -0700 (PDT)
Date:   Mon, 19 Apr 2021 18:22:53 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 5/7] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
Message-ID: <20210419232253.GW1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-6-angelogioacchino.delregno@somainline.org>
 <20210419185203.GQ1538589@yoga>
 <e486d752-b99a-3479-b2ae-b37cdb3edd9a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e486d752-b99a-3479-b2ae-b37cdb3edd9a@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 19 Apr 15:59 CDT 2021, AngeloGioacchino Del Regno wrote:

> Il 19/04/21 20:52, Bjorn Andersson ha scritto:
> > On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:
[..]
> > > +static int qcom_cpufreq_hw_acd_init(struct device *cpu_dev,
> > > +				    struct cpufreq_policy *policy,
> > > +				    int index)
> > > +{
[..]
> > > +	acd_resname = kasprintf(GFP_KERNEL, "osm-acd%d", index);
> > 
> > How about just sprintf() into a 10 byte array on the stack?
> > 
> 
> My motto, apart the clearly possible chance to get 1000 clusters in the
> future (lol), is to free the (very little) memory as soon as I'm done with
> it.
> 
> Was I too much paranoid there again? :)))
> 

Feel free to waste a couple of extra bytes in that array then ;)

[..]
> > >   static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
[..]
> > > +		/*
> > > +		 * If the power domain device is not registered yet, then
> > > +		 * defer probing this driver until that is available.
> > > +		 */
> > > +		pd_dev = of_find_device_by_node(pd_node);
> > > +		if (!pd_dev || !pd_dev->dev.driver ||
> > > +		    !device_is_bound(&pd_dev->dev))
> > > +			return -EPROBE_DEFER;
> > 
> > I wonder if there's a more appropriate way to probe defer on resources
> > described in the CPU nodes...
> > 
> 
> I was wondering the same. I had nightmares about this one.
> If there's any better way... please, let me know!
> 

Let's see if Viresh has any good suggestions, otherwise let's stick with
this for now.

> 
> P.S.: There is a v5 of this (and CPR3) set(s) that I had sent immediately
> after this v4, back in January, addressing the big abuse of the OPP API that
> is present in the v4 (this) version of the driver.
> 

May I ask for you to incorporate the changes I pointed out here and post
a v6 instead of me re-reviewing v5? I'll make sure to prioritize the
next round.

Thanks,
Bjorn
