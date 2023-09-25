Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910987ADB38
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjIYPUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIYPUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 11:20:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CD103
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 08:20:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3226b8de467so5345805f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695655225; x=1696260025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwdRv5aVN9xU2mSH7g7d6aBuPnLFDsHKoLa5WhXFbCE=;
        b=y7od0ohrht64GM+Ikt4PU16+Ju+V0IVLfMk+6AXwo7X8swsMOeBFfmK1cWM2okF1Rj
         MM9SQd+wmSw+vwH7F7K1C4RwuDv8VS/VNCGG0b5KfRv9fKBqZA0CTQVABR44S65KbBJ6
         oyPgfEUbsB7iTv5ZXGQgdrESOcydTrRO+If3UyBReF/6IJ4Cm39Q/zcKbsKj47r/dfl7
         wv+ly9vGKAhMltZ0hLNVkY+2oOdWvn1OUW9gP9m1F8EeO9Z9dkhpZ4MCstPm4ZE2lrSy
         GDX2wyjqqZcG0QTn/9uZn/DI3kmRxWmFpl7fFpHzcTMdTvYSQaFRjlKUps0eU1s2FFtr
         31jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655225; x=1696260025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwdRv5aVN9xU2mSH7g7d6aBuPnLFDsHKoLa5WhXFbCE=;
        b=fsIp/gy7ONVsOZHoj5p/6b/0Wd/TAkOWkPPJrTt+nGS6DqUF4+3pFQbewY1UrHO4Te
         6vCpVpakju3ddGFco2rC4aUsqWJPHTolX4Yl4bYpQNsBzQu/kiUAGUKQZPKTPWuu1nHM
         XuAZEcHNGeMAUe8ru/h+ItrwWocDV/o+JMzKd/PoECaZoWpmmKFeUjIqng6Ku7J1eX65
         Bno+LhtVwfvR29AJYs4w0QAsAZszmQPUrJdgJ4Z1APAV3M+HD+b9AcEX/SsccIx2M6w7
         C0lSVF+ixF+0EWGmVRWaLm5uS/4n3EJw24XcBBn6JbOdB8dAOWeMbFBHKC63I6Ygy5cx
         J7oA==
X-Gm-Message-State: AOJu0YzP/mEHTLpRMuev2LpC1RkvAw7J/h8P/r5S2P7X0dB1L8VVbqBb
        N7uyPa70QWpl2CiVr9gWhQH4lA==
X-Google-Smtp-Source: AGHT+IEyqtvyt8M63600CsswwYaGAw+I840ewLcBmPaTTvcNX1ue3/W4c1jbBAzGZBzNMOz4IjxoHQ==
X-Received: by 2002:a05:6000:1048:b0:31f:e980:df87 with SMTP id c8-20020a056000104800b0031fe980df87mr5715145wrx.38.1695655225062;
        Mon, 25 Sep 2023 08:20:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id w12-20020a5d608c000000b003179d5aee67sm12152132wrt.94.2023.09.25.08.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:20:24 -0700 (PDT)
Message-ID: <acb102d2-c44b-f9a6-671f-d157d1827468@linaro.org>
Date:   Mon, 25 Sep 2023 17:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/9] ACPI: thermal: Simplify initialization of critical
 and hot trips
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <4858652.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4858652.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2023 20:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the observation that the critical and hot trip points are never
> updated by the ACPI thermal driver, because the flags passed from
> acpi_thermal_notify() to acpi_thermal_trips_update() do not include
> ACPI_TRIPS_CRITICAL or ACPI_TRIPS_HOT, to move the initialization
> of those trip points directly into acpi_thermal_get_trip_points() and
> reduce the size of __acpi_thermal_trips_update().
> 
> Also make the critical and hot trip points initialization code more
> straightforward and drop the flags that are not needed any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[ ... ]

> +static void acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
> +{
> +	unsigned long long tmp;
> +	acpi_status status;
> +
> +	if (crt > 0) {
> +		tmp = celsius_to_deci_kelvin(crt);
> +		goto set;
> +	}
> +	if (crt == -1) {
> +		acpi_handle_debug(tz->device->handle, "Critical threshold disabled\n");
> +		goto fail;
> +	}
> +
> +	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
> +		goto fail;
> +	}
> +	if (tmp <= 2732) {
> +		/*
> +		 * Below zero (Celsius) values clearly aren't right for sure,
> +		 * so discard them as invalid.
> +		 */
> +		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
> +		goto fail;
> +	}
> +
> +set:
> +	tz->trips.critical.valid = true;
> +	tz->trips.critical.temperature = tmp;
> +	acpi_handle_debug(tz->device->handle, "Critical threshold [%lu]\n",
> +			  tz->trips.critical.temperature);
> +	return;
> +
> +fail:

nit: 'notset' may be more adequate

> +	tz->trips.critical.valid = false;
> +	tz->trips.critical.temperature = THERMAL_TEMP_INVALID;
> +}

Other than that,

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

