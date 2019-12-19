Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778501270EA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 23:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLSWvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 17:51:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38760 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSWvG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:51:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so3236149plj.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DG6xcgyW2GVicpyRt2gmN/KY5yjhrBbeiiYyH1tVOxA=;
        b=JC0w/mFvpWPFGTPZZW5h9IV8pWE9NUlF5A4wfNBDp6AtRuCdzLMtAwHdTLvQjuW/zE
         yZ+MFSFarNw0iemHySBDjRjz4eFjTtwfUMc7dZqT83HVC0sfdmQq/NcxSLVPsR962es9
         EU+pD5F9GNhtcZNaeJoQKF5oy1/TNqw2SSiSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DG6xcgyW2GVicpyRt2gmN/KY5yjhrBbeiiYyH1tVOxA=;
        b=qcyarHEUS68+CiaZwExWA1m8eYZfQ8bCJuB5E1EJ1g+IexN7AyuY0zOvOPBt10zzm9
         RYBf/2uPxrF5vRv5xNMcsF7MFMOTo+ZH7wqqfamOf2yvWPYb9UCzFSptk5f3Qad5SYWj
         l0Z1LwdABGyjMhxsaRjhd6hxWJPfuzb//aYO23eQwgD9sQvGKoFhrroY29V4Nj3s1Wlc
         P2ns1DMObwDhqYalprjMrPKLq1JnNP0k+2BOWUGkY/BNC5C+NEEseFXgcedhD/Tcyk4k
         Uz2K7IWNVl2RjhDXRHPrXpL+Pmiy+56PhnnU0Ooc4mTNRRGv3uad9gst40M+yoffsdLp
         4Vzg==
X-Gm-Message-State: APjAAAXIMx1juiwtKO7kEFu6QMijiKI0rQ2LAcYS1Z+QRGGLxVtWWsV2
        yAdn89Rr8mdie0N126sBSGU2Pw==
X-Google-Smtp-Source: APXvYqwtAvBp8clqCMJ1/rZElEJYIsxR4NtPjP3jPnPmmo/8iTTd0xXXooWeSNm2NOUx0z1WcebZpQ==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr12553412pjc.16.1576795865208;
        Thu, 19 Dec 2019 14:51:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q7sm8033126pjd.3.2019.12.19.14.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:51:04 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:51:03 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: cpuidle: Register cpuidle cooling device
Message-ID: <20191219225103.GZ228856@google.com>
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
 <20191219221932.15930-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219221932.15930-2-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Thu, Dec 19, 2019 at 11:19:28PM +0100, Daniel Lezcano wrote:
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
> 
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/dt_idle_states.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index d06d21a9525d..34bd65197342 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) "DT idle-states: " fmt
>  
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/errno.h>
> @@ -205,6 +206,13 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  			err = -EINVAL;
>  			break;
>  		}
> +
> +		if (of_find_property(state_node, "#cooling-cells", NULL)) {
> +			err = cpuidle_of_cooling_register(state_node, drv);

cpuidle_of_cooling_register() returns a struct thermal_cooling_device *,
so you probably want to use PTR_ERR() here.

Could it be a problem that the cooling device isn't unregistered even when all
associated cores are taken offline?
