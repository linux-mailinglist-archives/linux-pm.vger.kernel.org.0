Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA52FAE89
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 02:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbhASB5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 20:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387889AbhASB5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 20:57:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA87C061573
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 17:56:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so696505pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1BhqLN64XSevTkLdXufW4kqzYTM3iysk6wH7Gij994=;
        b=EId4DXRCDyZtmTjha+Gyr7ue3DpJhyB/tvJCnOb3pb+TGA5uZGRNwNj4w4CfPRgzic
         U6QXj2/s1LV8ZaJGqJUJDvQUUlUAmlk/3Czpea+yUGDPr1plFzz/KeqHYTlPZzZ57eO1
         V/7iuS3ApTxcue5pT5kxW3sDiVLIDkyKTA/MiMBEDFpLnDm9HRWXmPG3K1MWx9/osbdJ
         5KRTpcdOw9ESs/qTbBBa0LPNBuwAizMKouyFfyhuUZKwWyHxzikuxgRRn8ZZreNSdm8k
         jeTHW7uTQ9eP3kL/ROVAKUZZqqzOt+1tsJqXFWWh8HA0LUW7aznVYZVBM9Ey82gNkjNU
         +W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1BhqLN64XSevTkLdXufW4kqzYTM3iysk6wH7Gij994=;
        b=UK/o0+cMJQW9YWfH8v7vHrvB0+yKR0nv4GLMsD5ELDW33WINuzhPfLW5KPeAIVkEPV
         FFczzobApxWJ2bidJiiCCOf0GA+CGvD8ZLwiogXb/fwVRr5iwH+JltFImCYkmBV23aUx
         IsY3o4oS/9EiSqYHJHrq+P76aQ+AkKLpQBXeM0O0Toi6VdEA8ClgRZMnAAp9z02y/Nw5
         J9b2NaBGqs4s2te3VEpQM2HmcbP+LIb+D3smxi+KRh7ElaizuMLK5SIXOTTG6uTOzOm8
         TzB/VrQpDzXLjrxGaJQUBcpjk+RwmHJtkZbZdYxe9c7Qry46tjESeBc0ljLjrjuUV9EJ
         YExQ==
X-Gm-Message-State: AOAM533V7W60r9DTnWuiaEt5soo24Wjj20ibCGz9xg3T8cXhXqHT4per
        YsF+uHlJBRwA5mfgL+otUxPQ4Q==
X-Google-Smtp-Source: ABdhPJzxuRg/AlkwIx2egrd1Q3zznzL19m3+GHhL2ShFF5AsybQmyH8ZOOx3W2zF8i3iBvecxPuPSA==
X-Received: by 2002:a17:902:9a02:b029:dc:3481:3ff1 with SMTP id v2-20020a1709029a02b02900dc34813ff1mr2264038plp.28.1611021404442;
        Mon, 18 Jan 2021 17:56:44 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id w20sm14044834pga.90.2021.01.18.17.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jan 2021 17:56:43 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:56:38 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: drop devm_xxx() calls from init/exit
 hooks
Message-ID: <20210119015637.GA17701@dragon>
References: <20210118130603.16176-1-shawn.guo@linaro.org>
 <20210118153823.GA3310@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118153823.GA3310@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 18, 2021 at 03:38:23PM +0000, Ionela Voinescu wrote:
> Hi,
> 
> On Monday 18 Jan 2021 at 21:06:03 (+0800), Shawn Guo wrote:
> > Commit f17b3e44320b ("cpufreq: qcom-hw: Use
> > devm_platform_ioremap_resource() to simplify code") introduces
> > a regression on platforms using the driver, by failing to initialise
> > a policy, when one is created post hotplug.
> > 
> > When all the CPUs of a policy are hoptplugged out, the call to .exit()
> > and later to devm_iounmap() does not release the memory region that was
> > requested during devm_platform_ioremap_resource().  Therefore,
> > a subsequent call to .init() will result in the following error, which
> > will prevent a new policy to be initialised:
> > 
> > [ 3395.915416] CPU4: shutdown
> > [ 3395.938185] psci: CPU4 killed (polled 0 ms)
> > [ 3399.071424] CPU5: shutdown
> > [ 3399.094316] psci: CPU5 killed (polled 0 ms)
> > [ 3402.139358] CPU6: shutdown
> > [ 3402.161705] psci: CPU6 killed (polled 0 ms)
> > [ 3404.742939] CPU7: shutdown
> > [ 3404.765592] psci: CPU7 killed (polled 0 ms)
> > [ 3411.492274] Detected VIPT I-cache on CPU4
> > [ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> > [ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> > [ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]
> > 
> > With that being said, the original code was tricky and skipping memory
> > region request intentionally to hide this issue.  The true cause is that
> > those devm_xxx() device managed functions shouldn't be used for cpufreq
> > init/exit hooks, because &pdev->dev is alive across the hooks and will
> > not trigger auto resource free-up.  Let's drop the use of device managed
> > functions and manually allocate/free resources, so that the issue can be
> > fixed properly.
> > 
> > Fixes: f17b3e44320b ("cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code")
> > Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> > I took some of the commit log from Ionela.
> > 
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 43 ++++++++++++++++++++++++-------
> >  1 file changed, 33 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 9ed5341dc515..b529b49649e0 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -32,6 +32,7 @@ struct qcom_cpufreq_soc_data {
> >  
> >  struct qcom_cpufreq_data {
> >  	void __iomem *base;
> > +	struct resource *res;
> >  	const struct qcom_cpufreq_soc_data *soc_data;
> >  };
> >  
> > @@ -280,6 +281,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  	struct of_phandle_args args;
> >  	struct device_node *cpu_np;
> >  	struct device *cpu_dev;
> > +	struct resource *res;
> >  	void __iomem *base;
> >  	struct qcom_cpufreq_data *data;
> >  	int ret, index;
> > @@ -303,18 +305,33 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  
> >  	index = args.args[0];
> >  
> > -	base = devm_platform_ioremap_resource(pdev, index);
> > -	if (IS_ERR(base))
> > -		return PTR_ERR(base);
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> >  
> 
> Nit: you could move this allocation after all resource reservation and
> mapping below, possibly to avoid doing it unless the base address and
> the memory resource is actually valid. Or you can keep it here and
> remove the use of the local variables, especially the "base" variable.

It's a reasonable suggestion.  I will send a new version to kill `base`
variable, but still want to keep `res` as it saves some two level
indirection.

Shawn
