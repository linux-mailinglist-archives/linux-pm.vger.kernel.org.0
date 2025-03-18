Return-Path: <linux-pm+bounces-24245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5302A672AD
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E3518997B4
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276320ADEC;
	Tue, 18 Mar 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwc619uM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3C208983;
	Tue, 18 Mar 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297174; cv=none; b=OEL8BvXefViHtIUBSxayyRTzwFgDHORaNCFcE4RzhmOAayMXBDXTMNWFQPrUEN4JaomVZjYKDgVzU8CFxtUBH8+H17WZbr4JAfYlBVAYF7TTWPMNHnnzxMOWR10xTtBsbLsPaRcaLuGUjIHwr/48aO7uehQEVrouYQbYgIG2ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297174; c=relaxed/simple;
	bh=V0jgOiffCLkxm0OMAOIqhoH49dNtMd4X/16OaH5jjwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyFEVI4kl/fqFGFatVVfbPAbtMj2uTnh1aB4Sd7IQXWLhAbbVoyAujd056tT6e3af9FF2elrEkes2LZ6hPZGs84jMuQcWy6N1qQpelrBYv9JvONxil2Xcxqx0GP3wX5p6YT4nMFHxj+aU2b5WFTCBsYTPPDWa5g82TA4K1yMbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwc619uM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so49816211fa.2;
        Tue, 18 Mar 2025 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297171; x=1742901971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btQLCq7XpQDCc3ShAJyVvb50nNp5mbjOUHKo263Hklw=;
        b=Fwc619uMrsu3Jipz5SvwUQwnB5NL29rjeOYjkGMjdhF1YclFhqcsuVRgMkcJNyJDce
         Lxbrr0WUrtooOvyiJLIhBu+uGe8RNSEP38Ffn6oT4/HqP9uCn0K1fYA8H64n9WZLr2u2
         WziM+SI8X/Gungp3ssqW/g/KHe6LDxJuysXmVW5m9tZIf7KkVkH9i0zDIjCYqyC/Fj/M
         BfYqJ8765kGAVc7HSOvAoSPy2s3uDJVrrlrnOh5vdtT8xZ7/kgowHSou9IRpggWqEawh
         Os+7heNDtSzKoF5tGLx6pLbTy7TMoxkMb14KmWT0rcZz2B4tgtTMmSHUAEut4uZ7R2qR
         +t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297171; x=1742901971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btQLCq7XpQDCc3ShAJyVvb50nNp5mbjOUHKo263Hklw=;
        b=VdjGzQIlGr5RiEuYCWLSBT0ccTmAOQ5Qapb8oiCdq86LBha30irN2ss+5pV/+O9a60
         VucL57j0E5jVuR1R4+t4BNlV4SYqQBY/SRgZ+KwtFJS+CygQ2miYfWdNjK+d+CEibn3T
         jbm93AzrPGqwk/TK6Ge3mGZm4oCQzKWGpjXsC/Xgxw4s82CSv4YciYRSpeS8fMeLbfAK
         y+gb2OadxNJB/pFpx1vfix8wvSWnxCi9C6ASR/GZQGs4VF1n5OIbseCOIyULp2bVndW5
         pNQ2R3KsdvRX9Uqt25hnLcMGCDYLo43FbPFs10ltF72rTKXHCY5lINTDA2d8dsEM3KpT
         4Daw==
X-Forwarded-Encrypted: i=1; AJvYcCWmGeWNg+50hHchegDwsXodnTfYsJAOVhxFg7scX5+vUyCicTgjlN+F6XWA3JfeIC0g3xV1jL1jf6UURcg=@vger.kernel.org, AJvYcCXvtiL4HfROvJIlH/cLXmKJPvlaNaPmWzbG7Gml6NEZHi1GTr/2s1iJcxk4nfuAUZEn1f4Sxvpcgqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweM5m0FYm5ULxW1gkke/28lKpt3C/vn5NqE/mxScpL7rv/z5Ja
	umBggMiqKwznrD447NaM+ZXMEzvbIXAMM4Jjv2pLH4uh1v/5P9ye
X-Gm-Gg: ASbGncu112zwzH/Uu6wX5ju+OT0XyMEQX+4vDL9/Os7DHy7ODL3U2Mr6uVdcF/HGBre
	M4i9M9kCoaYszv/DGuaz2MhvGrwGariAnB+hgIOwxxjuFxYudCfr1osYtLVAgBlA2e+o6NXU4mQ
	4RgDd1o2U73UMlUEiZryYc0W4WBl6hQx2R/phPtHxjs8aoI6EovO4buu+IR69NOMIcD51Ge90FK
	tSY5tBoHzlQqMDpPBXazJTwOkEAzeoEBIfRx+8sJap84xK+9cV2Ae0NpfEFCErVZ0koCKzZc/gA
	08fjWpOlRKFlw98tkFeJ2sYkeAN8YvpgbNGtmRl67xFrEHQq8KsZdfmEaA==
X-Google-Smtp-Source: AGHT+IHzlAWaDOts8D3ujQUd5J6woXe3kP3cM1wyrozycFymsmVYWCH0d8Z8sZUCZAPAcv22hhV2VQ==
X-Received: by 2002:a2e:8844:0:b0:30c:514d:92ed with SMTP id 38308e7fff4ca-30c514d9327mr82647391fa.14.1742297170547;
        Tue, 18 Mar 2025 04:26:10 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c306esm19038491fa.72.2025.03.18.04.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:26:10 -0700 (PDT)
Message-ID: <e87c1389-c173-47ee-8b01-cb0764a55afc@gmail.com>
Date: Tue, 18 Mar 2025 13:26:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-3-o.rempel@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250318094716.3053546-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 11:47, Oleksij Rempel wrote:
> Prepares the kernel for the Power State Change Reason (PSCR) recorder,
> which will store shutdown and reboot reasons in persistent storage.
> 
> Instead of using string-based reason descriptions, which are often too
> large to fit within limited storage spaces (e.g., RTC clocks with only 8
> bits of battery-backed storage), we introduce `enum psc_reason`. This
> enumerates predefined reasons for power state changes, making it
> efficient to store and retrieve shutdown causes.
> 
> Key changes:
> - Introduced `enum psc_reason`, defining structured reasons for power state
>    changes.
> - Replaced string-based shutdown reasons with `psc_reason` identifiers.
> - Implemented `get_psc_reason()` and `set_psc_reason()` for tracking the
>    last shutdown cause.
> - Added `psc_reason_to_str()` to map enum values to human-readable strings.
> - Updated `hw_protection_trigger()` to use `psc_reason` instead of string
>    parameters.
> - Updated all consumers of `hw_protection_trigger()` to pass an appropriate
>    `psc_reason` value instead
>    of a string.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> +
> +/**
> + * enum psc_reason - Enumerates reasons for power state changes.
> + *
> + * This enum defines various reasons why a system might transition into a
> + * shutdown, reboot, or kexec state. While originally intended for hardware
> + * protection events, `psc_reason` can be extended to track other system
> + * transitions, such as controlled reboots triggered by software or
> + * maintenance operations.
> + *
> + * The values in this enumeration provide structured and standardized
> + * identifiers that replace free-form string descriptions. They are designed
> + * to be stored efficiently, making them suitable for use in environments
> + * with limited storage, such as battery-backed RTC registers, non-volatile
> + * memory, or bootloader communication mechanisms.
> + *
> + * Importantly, the order of these values **must remain stable**, as
> + * bootloaders, user-space tools, or post-mortem investigation utilities
> + * may rely on their numerical representation for consistent behavior.

Oh, here is the comment I was asking for in the other patch. So, this is 
all fine - please ignore my comment in the other patch.

> + *
> + * @PSCR_UNKNOWN: Unknown or unspecified reason for the power state change.
> + *	This value serves as a default when no explicit cause is recorded.
> + *
> + * @PSCR_UNDER_VOLTAGE: Shutdown or reboot triggered due to supply voltage
> + *      dropping below a safe threshold. This helps prevent instability or
> + *      corruption caused by insufficient power.
> + *
> + * @PSCR_OVER_CURRENT: System shutdown or reboot due to excessive current draw,
> + *      which may indicate a short circuit, an overloaded power rail, or other
> + *      hardware faults requiring immediate action.
> + *
> + * @PSCR_REGULATOR_FAILURE: A critical failure in a voltage regulator, causing
> + *      improper power delivery. This may be due to internal component failure,
> + *      transient conditions, or external load issues requiring mitigation.
> + *
> + * @PSCR_OVER_TEMPERATURE: System shutdown or reboot due to excessive thermal
> + *	conditions. This attempts to prevent hardware damage when temperature
> + *	sensors detect unsafe levels, often impacting CPUs, GPUs, or power
> + *	components.
> + *
> + * @PSCR_EC_PANIC: Shutdown or reboot triggered by an Embedded Controller (EC)
> + *	panic. The EC is a microcontroller responsible for low-level system
> + *	management, including power sequencing, thermal control, and battery
> + *	management. An EC panic may indicate critical firmware issues, power
> + *	management errors, or an unrecoverable hardware fault requiring
> + *	immediate response.
> + *
> + * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
> + *	value is useful for range checking and potential future extensions
> + *	while maintaining compatibility.
> + */
> +enum psc_reason {
> +	PSCR_UNKNOWN,
> +	PSCR_UNDER_VOLTAGE,
> +	PSCR_OVER_CURRENT,
> +	PSCR_REGULATOR_FAILURE,
> +	PSCR_OVER_TEMPERATURE,
> +	PSCR_EC_PANIC,
> +
> +	/* Number of reasons */
> +	PSCR_REASON_COUNT,
> +};

