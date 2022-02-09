Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5B4AEA4B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 07:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiBIG2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 01:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiBIG1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 01:27:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F6AC0612C3
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 22:27:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so1305315pjh.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Feb 2022 22:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZptq99McEmSTWKDkacQuJxWYVLFif45IaPqyzpBkjk=;
        b=ZYxOJU1r53Sj8pg5AZsbPSGhkjg65dtEt1RJxdfnMMiKHKUSYkSld3E8PHY94rLMI0
         fsv2eFO8TFjNH00vk1vlHcQIpT5R7n9+eWE2+KexOeiGjc3tLt/yYfxW+4l4gpm2jKIO
         G7rHKbofp1DvplhR4iUO3ti5njWGnVzsDQ1Ziet+vixWy+lW7VKrR3LG2OcWNzSU4Z11
         stynxqFXBQj8a+sC3/Fg5+lGdTYUj3FlWvqNAjIYRFksQUqJZ6IUrF0Vu+noMn6L5Ny9
         3J369+2GtHNcseI4qk2HeWyGd07eHutnjoqLM1iENmOaBrJEQJr+l0YjG5cC+Y2wz+CS
         WvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZptq99McEmSTWKDkacQuJxWYVLFif45IaPqyzpBkjk=;
        b=oUgGnkG9OtxH1Jg4PGFXLkxnAzKNAUVYTHrIVeinR26M6RASoJhkhOAUKvDyRgg8yn
         pytznPqJ0POB3v7tKMZ4yqoBQHUzeu47k5TnaDF/CWRJiCiVziSdQhxCO1ndNiZ+WYaj
         NHdh5Yf0EWYS/2XpsdcTtU3UGxizNzOXK0z5xxnUZ3WU1urvme+6ERxexTCMjbPARHNR
         qneO0fBB/b89e1jDheuhAVKGX19qDC2pKdDc3gKOxhiWwmYt+jC+FNvncIdSpxvfPvuI
         2Gryr9Vlc6jMTqIBcWaUT1OIgs7k61deL6h7tH/YRn7+yYFY2eb/ErePrmPK23g6I4Ie
         GpDg==
X-Gm-Message-State: AOAM533LhohcipheDqududgVAuhwNBeO5OScOwxMSc5HcWjTjq4TTToL
        1Md00/qUN/VYVMsZboIGl3g9GYWwCTH//Q==
X-Google-Smtp-Source: ABdhPJy8WOCryenGRsq0jVJwJojuWywhhTwy7/5rrmGD0U9AQtw2NK+Q2eas+0f64dbEjH9qRfCTkQ==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr899349pjb.162.1644388032609;
        Tue, 08 Feb 2022 22:27:12 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id g12sm1029213pfj.148.2022.02.08.22.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:27:11 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:57:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: longhaul: Replace acpi_bus_get_device()
Message-ID: <20220209062710.5fwg52fjb2jkerzr@vireshk-i7>
References: <4700827.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4700827.GXAFRqVoOG@kreacher>
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

On 26-01-22, 20:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/longhaul.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/longhaul.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/longhaul.c
> +++ linux-pm/drivers/cpufreq/longhaul.c
> @@ -668,9 +668,9 @@ static acpi_status longhaul_walk_callbac
>  					  u32 nesting_level,
>  					  void *context, void **return_value)
>  {
> -	struct acpi_device *d;
> +	struct acpi_device *d = acpi_fetch_acpi_dev(obj_handle);
>  
> -	if (acpi_bus_get_device(obj_handle, &d))
> +	if (!d)
>  		return 0;
>  
>  	*return_value = acpi_driver_data(d);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
