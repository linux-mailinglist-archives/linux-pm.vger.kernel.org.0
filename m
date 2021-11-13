Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21744F4A9
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhKMS6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhKMS6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 13:58:30 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38FC061766
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 10:55:37 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id o83so25052197oif.4
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEaoQk4S2VEKJUWN86163Buqvqi3IEqLz/+vozzoOP4=;
        b=TW/Ad79WaYF4EY3jQBBipTw3TfDqUwRUflKXpjIunx6UOui1ILIWRVQBUhVDCCm/et
         +tJBp2SGpjrFmHJVw//MrMWKsGahuwAeSyNkqlV24EZt9YSwUi0Qpnn4+W3DIZERjNPb
         ubrqU5qqTw4VP2j86wlzb188PRvKcudMgRncMNJXWtcfvQXm6Bk68/EA8Hyq5sH98mBi
         NcAcCxW8G/JCVcJtC4kRIbgqkra0IbefUiCqN4eIovjHQfJUE2y6Dnr8AjOyQwkbp5Ys
         Pwp/LitZ939vqRYOBD70ru9jttzvsR8sWt49Qcjr7tueohKYxD7rSnWQ84hSXUUjFBT1
         POyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEaoQk4S2VEKJUWN86163Buqvqi3IEqLz/+vozzoOP4=;
        b=purXtEGWx4/ZkP1geUR+LKk20Y0LSuAlTc+i/hn7QcehSwbkK0ZLfc8g8k96Iz6sN7
         y8Uor9/JLrUsVyH+cHeUz3/ukkF8gJzzx9TJEUnda5WtrGy70k3yDK9Z7wYeaoczH9Sp
         xU8t1I9PTcvuyouLxwNq4KUQrv8WNNreg2HedTN1t+VSMNARWrOQEUe9SFj0JPwaWbU2
         N+S9gBxPUlL6B0gapenyutH+aSjg9gPaSu7QRM8+ZAWMiHq4fm74kQuBF/i4E8nCAmOb
         XePpECUtidsruuObMkWGwNEQbcM/GmmOU7+XX9Q154NPi84HebiRIgEriBJLmSC7KdyN
         kESw==
X-Gm-Message-State: AOAM530ZHgZB7CriQzSyNWGuMkebjeniUkDdiGj5gcxkDSLRHAjsd69O
        dB92TO1MFJbG0VsX0DbCA5hj9g==
X-Google-Smtp-Source: ABdhPJxPEAu48dyuGhj2JUv8X/eJPmCFi7hIHbunZ2UyNUnWMWOO3GwDSrehXn9dqGOnXR99HpouBQ==
X-Received: by 2002:aca:b386:: with SMTP id c128mr35777005oif.161.1636829737116;
        Sat, 13 Nov 2021 10:55:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s2sm589548otr.69.2021.11.13.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 10:55:36 -0800 (PST)
Date:   Sat, 13 Nov 2021 12:55:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH 1/3][RESEND] cpufreq: qcom-cpufreq-hw: Avoid stack buffer
 for IRQ name
Message-ID: <YZAKJKEN5VejME5Z@builder.lan>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
 <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
 <3711b990-a00a-9fce-0e08-657070d0a990@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3711b990-a00a-9fce-0e08-657070d0a990@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 12 Nov 14:16 CST 2021, Dmitry Baryshkov wrote:

> On 11/11/2021 18:48, Vladimir Zapolskiy wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Registering an IRQ requires the string buffer containing the name to
> > remain allocated, as the name is not copied into another buffer.
> > 
> > So let's add a irq_name field to the data struct instead, which is
> > guaranteed to have the appropriate lifetime.
> > 
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> > ---
> > vzapolskiy: rebased, added all collected tags and resend the change from Ard
> > 
> >   drivers/cpufreq/qcom-cpufreq-hw.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index a2be0df7e174..3b5835336658 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -46,6 +46,7 @@ struct qcom_cpufreq_data {
> >   	 */
> >   	struct mutex throttle_lock;
> >   	int throttle_irq;
> > +	char irq_name[15];
> >   	bool cancel_throttle;
> >   	struct delayed_work throttle_work;
> >   	struct cpufreq_policy *policy;
> > @@ -375,7 +376,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
> >   {
> >   	struct qcom_cpufreq_data *data = policy->driver_data;
> >   	struct platform_device *pdev = cpufreq_get_driver_data();
> > -	char irq_name[15];
> >   	int ret;
> >   	/*
> > @@ -392,11 +392,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
> >   	mutex_init(&data->throttle_lock);
> >   	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
> > -	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
> > +	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
> 
> It might be easier to use devm_kasprintf() here.
> 

Yes, in itself that would be nice. But this function might be called > 1
times per device, in which case we would end up with N unused copies of
the string on the heap, until the device is removed.

I'm working on some patches where these things are allocated at probe
time, with those in place it makes more sense to just devm_kasprintf()
this and "forget" about the pointer.

Regards,
Bjorn

> >   	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
> > -				   IRQF_ONESHOT, irq_name, data);
> > +				   IRQF_ONESHOT, data->irq_name, data);
> >   	if (ret) {
> > -		dev_err(&pdev->dev, "Error registering %s: %d\n", irq_name, ret);
> > +		dev_err(&pdev->dev, "Error registering %s: %d\n", data->irq_name, ret);
> >   		return 0;
> >   	}
> > 
> 
> 
> -- 
> With best wishes
> Dmitry
