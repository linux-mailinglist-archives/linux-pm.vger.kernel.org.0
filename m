Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9498F7AF1A4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjIZRSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIZRSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 13:18:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D79F127
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 10:18:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32320381a07so5236537f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695748715; x=1696353515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/873jRuHIB8KVUpv9XQXwxtjHGUlH2X/UtfyeX7Noc=;
        b=Si3HMSDUoMibWMXh853mDl3QfwMuqGLorOYRp1vZM2s632lwxSSsTvWvGtinclTLrq
         6bUIfKKCv1SKG9Vcyx0wkv+H1gO4ggTp31oEtA3svMVjfltYFAAYQ490NFeEjcbTmQQ9
         qsOqiZQB2EDJElqx+pfG485zisQtEYd/atnR4y7uK65BJHZbrRxAdVdEt/ghc5fIGw+A
         bZRXSwVo2AjP+LWCWTAHxXUwfiSERRY9Vm4gzZLwj2x6w8W6gjZ+jvbxhoTXkGBgm9s2
         t0LSdj3Dg0DfbDQaKIvSovxSXMcn5wf5i7nENX1pZFS4SBkllKN29iZXFLIR8KGRcXRx
         vTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748715; x=1696353515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/873jRuHIB8KVUpv9XQXwxtjHGUlH2X/UtfyeX7Noc=;
        b=fPtjFxry32j28cYthRNTfSkZGxEo860mZszwgibavHOJ1tdhGxjhqqAdyblXC6N8ly
         ePWQw3u/g+3fzpEQ+tMjv8aIAL+SOU2efSpjpdkLVy1KOx9zScRduaJxwLsLQdzJMR/o
         Tv8So7wZ8+gNvZ6XociqrUjfgUD8WuVlBOuL0+NsWlfVmf4XhfioxfP7VKyieyBkpI0r
         QPDHe1QLh8VrKlX5dVkGeTvSKIlONrxIwg1W7QwdJtGb98clyKdBol2zBvQOmN0StW3a
         if+sQ49ecQHH9f7EsBQDST8bSvkNuxENpdk7m1BHs/Nktv7SV9Or2rKT5acyJdn+jGjx
         SNRQ==
X-Gm-Message-State: AOJu0Yxa1ajXDGERrKG8ookqfBXMh3nPG9M0VcAi72+4EDO6wS0OVJG4
        3fqkqNQ/+NljxSQ8F4V/lSd9uZkKN6a2+eA1+QY=
X-Google-Smtp-Source: AGHT+IEDQG3OiHowx9com9DgvI1ed+w0oyedIjlgxDirS7OxkA2/EvHN12Z6TpEqao+AYEtYtRfpDw==
X-Received: by 2002:a5d:6d87:0:b0:323:3ab5:990c with SMTP id l7-20020a5d6d87000000b003233ab5990cmr1828775wrs.44.1695748714652;
        Tue, 26 Sep 2023 10:18:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id h17-20020a5d5051000000b003197c7d08ddsm15139853wrt.71.2023.09.26.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:18:34 -0700 (PDT)
Message-ID: <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org>
Date:   Tue, 26 Sep 2023 19:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update
 functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3534976.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplication, merge update_passive_devices() and
> update_active_devices() into one function called update_trip_devices()
> that will be used for updating both the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 33 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -43,6 +43,8 @@
>   #define ACPI_THERMAL_MAX_ACTIVE		10
>   #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
>   
> +#define ACPI_THERMAL_TRIP_PASSIVE	(-1)
> +
>   /*
>    * This exception is thrown out in two cases:
>    * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> @@ -202,18 +204,25 @@ static void acpi_thermal_update_passive_
>   		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
>   }
>   
> -static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
> +static bool update_trip_devices(struct acpi_thermal *tz,
> +				struct acpi_thermal_trip *acpi_trip,
> +				int index, bool compare)
>   {
> -	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
>   	struct acpi_handle_list devices;
> +	char method[] = "_PSL";
>   	acpi_status status;
>   
> +	if (index != ACPI_THERMAL_TRIP_PASSIVE) {
> +		method[1] = 'A';
> +		method[2] = 'L';
> +		method[3] = '0' + index;
> +	}

Could be index > 9 ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

