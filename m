Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF624C2797
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiBXJD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiBXJD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:03:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C82189A8A
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso5147907pjk.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCM78YTn8/YVxRCZhQXtEB9THICvyOh286lVLbqQpaE=;
        b=rkNBMDEf/SqUajws9FmdO9tKxMTm17pN9iH5SFB3gRCwM2E/eKIRZYeJPNmzSHSaOn
         lQY9sO/8Lh9xsPcM21Be3q8LV+jNC3t5Shq3Wf+CHC2hs4Zr0++3/KHap3GXDNgMyRhV
         IIHAEfFwRnt6J3UTutGiUM6M6Nm6bNLWAOLmXMratd5dozz6PJ3ySy+BFTdOhAvgzIYM
         NAkwU21Z9Xvq0/Yh3VKrAd7o2FcKtHSCkAfaaLraoItjRSejXUzTq29jlNz2e5qC048e
         6lsjUmkGODO9k+pvJ7+gkSlX6OrzKaCOD2MHIMkPZo4/ugAm7XYufKmfcLTC1dePgyH2
         KRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCM78YTn8/YVxRCZhQXtEB9THICvyOh286lVLbqQpaE=;
        b=72J0w5ggCgf5a26BK/AyoBlfm9LJPECOZ+eN7zto+hEnbTALdeaawPv5E867ZYNNFv
         R7e0Ktwoc/EmNe6kUwCCBDEnQhb8g6aOEk1w23hVHjRMMM4jcw7+A/Bxf93Trz5zmL6V
         yS4pNugPQt3zpgKh5u+RUsDVXJz8pyhKi6tBvE0Y6M13E/VBz3cN3EmfFLhGUaFsUouj
         zjGK2tDRxayR7Pd1z4BY2SVuqIAL3FnIpECwfkspuuuvP95Uz4nDc39WLiDrRSv7sYLx
         IvfKBugPazx9mR1kIJIsIN85aCXKJKR2huYcJ4jfch7MFFffkArUQnFG45qO2LFJfxLi
         /i8Q==
X-Gm-Message-State: AOAM530YzXrbottoqeLesRENvQBhK89KyNkllwwWLS7PdsIVSAxOD6S9
        LGhGxkdVSmB/mGIoD0hn9vUIWA==
X-Google-Smtp-Source: ABdhPJwGsYnvGBr1SzToJDWL3pbvTkdogMi/iHWJErfg6U8NpfHn2UG+e2zDs4MEgNGGgWVU0CzSlQ==
X-Received: by 2002:a17:902:c20c:b0:150:11df:9918 with SMTP id 12-20020a170902c20c00b0015011df9918mr1526277pll.76.1645693407502;
        Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id g18sm2507892pfc.108.2022.02.24.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:33:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Message-ID: <20220224090325.m4pl36ma3uettxvg@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-3-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> +/**
> + * dev_pm_opp_get_power() - Gets the power corresponding to an opp
> + * @opp:	opp for which power has to be returned for
> + *
> + * Return: power in micro watt corresponding to the opp, else
> + * return 0
> + *
> + * This is useful only for devices with single power supply.
> + */
> +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
> +{
> +	if (IS_ERR_OR_NULL(opp)) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	return opp->supplies[0].u_watt;

What about returning the total of all u_watts for this OPP here ?
Surely it doesn't make sense to do the same for voltage and current,
but power is different.

-- 
viresh
