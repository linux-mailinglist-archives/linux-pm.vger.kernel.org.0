Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40B105D22
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKUX0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 18:26:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34388 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUX0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 18:26:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id h13so2307548plr.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 15:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UX7iTTjdEU6lqyPY0tdERChAcK++ceGU6xfKYB18y8I=;
        b=GtnKPuU9EgPu/SgU2WO2jNbdA5pWvEvvOK1/EldWI5kBU9l6FNzbF0Fk9GDCHwkh5O
         xxif0RbtbgB6EJV320EBZBOCIg2mrw3xJAUz+BXbD/envo9Fot81JfRq9IMlyRBV0apS
         INq4MvOLzB1laIhW1ZPur/7mGB9urU0b4yWNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UX7iTTjdEU6lqyPY0tdERChAcK++ceGU6xfKYB18y8I=;
        b=H9tAk0bnLQAHcXrz+Qwk9Zw2sLrX2dgHoSAoMYD3t27I4RsAgZsa4SeBCq2tPe1X4f
         s7uN56yB6WbRkfbEydGCx+mNF09AbyWnhPfsDhlbStutDT8wC+2kM+sNBnv+HEmll2+8
         mozV5QgWIa34KJDZT4qFQIG0ZD43RuQ3x6k4pOyOjpoxbhR/hkChGiRKKW5E+yiGQDoT
         YlUEbr8WPl3N4air54b7OAtc7oanq+ioGnonnNl7F4SatEgA181WU3RHxkMenO6d6KoC
         ryHII31kRhYFnjebe0JiiQBgwaypHWylJBQXGkkIJii6Z/QWgfaqLZs2tYLryS4d6WuV
         3jhg==
X-Gm-Message-State: APjAAAXI4upVvTvd0L1X910OTKm31+KSQzMIne19KatQyocILnMeH3Xo
        2yv2vhHOzzMxQXHHXB1tG9wYpQ==
X-Google-Smtp-Source: APXvYqy0vKRAnpb7KD8cpjJndNdBddLXVI+1W6QNmfivkdzdkG3eE9L+doyZcnfC7F8T3fFVdGXxBw==
X-Received: by 2002:a17:90a:a483:: with SMTP id z3mr14146346pjp.55.1574378777576;
        Thu, 21 Nov 2019 15:26:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z7sm4125300pgk.10.2019.11.21.15.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:26:16 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:26:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>, Angus Ainslie <angus@akkea.ca>,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 2/2] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Message-ID: <20191121232615.GL27773@google.com>
References: <cover.1574116684.git.leonard.crestez@nxp.com>
 <7190da59fb8fbb12538d2b28b87e1ee420cbb705.1574116684.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7190da59fb8fbb12538d2b28b87e1ee420cbb705.1574116684.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On Tue, Nov 19, 2019 at 12:56:43AM +0200, Leonard Crestez wrote:
> Support for adding per-device frequency limits was removed in commit
> 2aac8bdf7a0f ("PM: QoS: Drop frequency QoS types from device PM QoS")
> after cpufreq switched to use a new "freq_constraints" construct.
> 
> Restore support for per-device freq limits but base this upon
> freq_constraints. This is primarily meant to be used by the devfreq
> subsystem.
> 
> This removes the "static" marking on freq_qos_apply but does not export
> it for modules.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>
> ...
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 9105f47f5195..5193915913fe 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -32,10 +32,12 @@ enum pm_qos_flags_status {
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
> +#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
> +#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	(-1)

The value of -1 is problematic, as reported on
https://patchwork.kernel.org/patch/11252413/#23017003.

dev_pm_qos_read_value(dev, DEV_PM_QOS_MAX_FREQUENCY) returns the smallest
value of all requests, which is PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE / -1
unless all requests have set an actual constraint.

I'd suggest to change the default max value to S32_MAX or similar.
