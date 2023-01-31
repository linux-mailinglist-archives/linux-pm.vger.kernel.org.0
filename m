Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF468321A
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAaQCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 11:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAaQCt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 11:02:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D694E505
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 08:02:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8158920wms.4
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdMGPgA5Z+kE+bOJxrk1w++j7n82pnWUSu1/WHQUxqw=;
        b=u6d2uhUXHbyBWtehUzCGiwYSlD5sXIWoR8f6tKVVQYp6zCzGdesUi3PsMlUYNZ2Tm5
         hdrwVd64uoNOEBLh3C7TeiYVVnyhpR4XKo6EmngrJUCt4Sc8uscq/b8d779MvRO4w7sa
         8q39h/vH4NySvYXym6FhyVAZE6j0UpwoONggX5w4hKR3ueTQMdEUqpU3NKrw1v7dMtKd
         ebq1XDxiIuN2IwZvu95GZU7IzXu7yQejKla9nElOeFBVBDsmtE3aKDLgCgGs8bGI1Ivc
         +vzg+JmOJzyBOzvSwI2SzqVpsVKLET/UgXTsLepCJvRWA4Ep35WaQWiwbZzI0TzAaHgk
         kO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdMGPgA5Z+kE+bOJxrk1w++j7n82pnWUSu1/WHQUxqw=;
        b=M+q9KvPc5f+etPNz9qwdV3wEvH0CZK38Xm1pDFvKBdm3tt9Ld/fbLDD8MAlQ2h3ESi
         pdp6wTp17AqJrAGJIqpEuIzOv3hzPVTWhxoV+vPQC+9vDRKLQ/e3L8fGZsCyCp6L3SIG
         nW/rZQOOvPAD2FSNkhxTVUKxRrzvmIR79lWDdEXlk6dWFQ4Oy53ABYGPYe7h2K+gIdB2
         YtD1Cj9AWrElYKXtnZ8D33ndt0qVIWiuz6mjLLk06iVy9/JDqrJP360AzIa4AkHbsTxO
         rHJdSn7zxBMSflic7vrng5Q3BUCQzqKom8TcoV4YMn8EeIPhjFMkf53jnhPLLK4opBD4
         nTDg==
X-Gm-Message-State: AO0yUKX8GVHB4ajMZZo7XiZI96Kv2gsguOtiSLCs6L/wiyWK82Y3AT19
        43gzoKkS+c0RNlIj6eBFXAPtmg==
X-Google-Smtp-Source: AK7set+eFxCCoBppFXrc0Sm6MzRKo/b8M7EJxaLgIpYy/8zhGhrkBo6l2qaunHUvuKoHj7494kts8A==
X-Received: by 2002:a05:600c:5028:b0:3dd:1982:4ce0 with SMTP id n40-20020a05600c502800b003dd19824ce0mr5912287wmr.16.1675180966899;
        Tue, 31 Jan 2023 08:02:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h13-20020a05600c314d00b003db2b81660esm6773316wmo.21.2023.01.31.08.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:02:46 -0800 (PST)
Message-ID: <03b7e4ae-04b6-42ca-cad0-7828797f7bf9@linaro.org>
Date:   Tue, 31 Jan 2023 17:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 8/8] thermal: intel: intel_pch: Refer to thermal zone
 name directly
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <837557782.0ifERbkFSE@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <837557782.0ifERbkFSE@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/01/2023 20:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pch_thermal_probe() use a const char pointer instead of
> a struct board_info one for accessing the thermal zone name.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> BTW, Srinivas, I'm wondering if user space would be terribly confused by
> changing this driver to use "Intel PCH" as the thermal zone name of all
> of the supported platforms?
> 
> ---
>   drivers/thermal/intel/intel_pch_thermal.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> @@ -175,7 +175,7 @@ static int intel_pch_thermal_probe(struc
>   				   const struct pci_device_id *id)
>   {
>   	enum pch_board_ids board_id = id->driver_data;
> -	const struct board_info *bi = &board_info[board_id];
> +	const char *zone_name = board_info[board_id].name;

Assuming you will change 'board_info[board_id].name' by
'board_info[board_id]'

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>   	struct pch_thermal_device *ptd;
>   	u16 trip_temp;
>   	int nr_trips;
> @@ -249,12 +249,12 @@ read_trips:
>   
>   	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
>   
> -	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
> +	ptd->tzd = thermal_zone_device_register_with_trips(zone_name, ptd->trips,
>   							   nr_trips, 0, ptd,
>   							   &tzd_ops, NULL, 0, 0);
>   	if (IS_ERR(ptd->tzd)) {
>   		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
> -			bi->name);
> +			zone_name);
>   		err = PTR_ERR(ptd->tzd);
>   		goto error_cleanup;
>   	}
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

