Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B509772279
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjHGLe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjHGLdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 07:33:37 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864D525D
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 04:31:17 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31783d02093so3876728f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691407509; x=1692012309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmKgbF75SppH/Nt4NtFgEsnrqh7a9v81WiBucQ7ae8E=;
        b=nIevyibAozWaGB4C9czRN/LjurbUuQPVCZe6w4q4oGjfzg+0qceylElM66uk+ewfIB
         NPxS8LlhxWDrxNYBnJBIqkVO5VT+RWvCCDxyHEu++QJon5tY7rlIsOTY2XbZ1MC9EP1u
         TN6ct1rkB0BNLgsLDAU9vAJsSqWu4oe61BFkg8L5vcKujARIC0/9mof0CS3nxdH6hZHF
         snnjikSPd6+PLmnYlxAgCSetXxCVm3aNiUNgdI45wB457QbbZ9Y4Y2b15IUIMmcuap1L
         Wr0ZNEtGL5k4OoAGbbJkEQjs3dMTvHwQq1fRa02Ss1tPzpwEW08CypdOz+92lbw+QLOF
         C/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407509; x=1692012309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmKgbF75SppH/Nt4NtFgEsnrqh7a9v81WiBucQ7ae8E=;
        b=eL4BwB9BkzvSAiALtq+YhrBbyCIs2KQaosbq9bohKBvGg/eLVZKg8XYBx0SqMKUFC2
         niZf1UpGlI9jc3aXCJej6qTVvjYgXoS1Wo0U68lReRC25ur8Y8rhOodbZ7TX2w62Aw1A
         Lgw0mZmKDK8P5ZAIZpent/7p2n4N0/ogdTovProtvlQBa+vKcxM7WvwjOgKXMhNxreNE
         +X9/gHfFmmQQblr0VQa1zvKgfICJSddTZoXigQvheZXL5sVZl5eOAXy27iAWHZFP4bTF
         pSuSe4h5CeAiGXcr1yjH27GAsisbtGDTwNSvbhafGrl7V0x5S3pkthnHVsN6iZqbSDOV
         Axkw==
X-Gm-Message-State: AOJu0Yyx/vNV7CkbKtSWpzxbSjZllHivI3XYVjHg/MUnubxgLFc4S2eN
        Un5RCEAOlHmVV6cT0iLlS1/iUw==
X-Google-Smtp-Source: AGHT+IEPpzkc/DAbzHkYSpjysVSVkw7nXi/fDtwrWGbOxDvNtoJbO2SLShFhqkvMhuro04eef8dq9A==
X-Received: by 2002:a5d:4e0f:0:b0:317:6513:da7e with SMTP id p15-20020a5d4e0f000000b003176513da7emr6712284wrt.36.1691407509399;
        Mon, 07 Aug 2023 04:25:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g11-20020adff3cb000000b00317731a6e07sm8695427wrp.62.2023.08.07.04.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:25:08 -0700 (PDT)
Message-ID: <570761cf-960b-0905-ad06-ec18bd75936d@linaro.org>
Date:   Mon, 7 Aug 2023 13:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/10] thermal: core: Do not handle trip points with
 invalid temperature
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <4850902.GXAFRqVoOG@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4850902.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/08/2023 23:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Trip points with temperature set to THERMAL_TEMP_INVALID are as good as
> disabled, so make handle_thermal_trip() ignore them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> v3 -> v4: No changes.
> 
> v2 -> v3: No changes.
> 
> v1 -> v2: No changes.
> 
> ---
>   drivers/thermal/thermal_core.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -348,7 +348,8 @@ static void handle_thermal_trip(struct t
>   	struct thermal_trip trip;
>   
>   	/* Ignore disabled trip points */
> -	if (test_bit(trip_id, &tz->trips_disabled))
> +	if (test_bit(trip_id, &tz->trips_disabled) ||
> +	    trip.temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
>   	__thermal_zone_get_trip(tz, trip_id, &trip);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

