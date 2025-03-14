Return-Path: <linux-pm+bounces-24034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E521FA610C7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851D47A53E4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C71FCFE3;
	Fri, 14 Mar 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcHTK4Mc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4BB67F;
	Fri, 14 Mar 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954969; cv=none; b=GT3dour12Scp3yNMwJuZce2UxsFhCo3RAtO2rlTNp+E2to4OrpGs4T6h91rl/IPL7hBB1okHKbnLIL2df9B0pRTNosrx3ndvLMr8MVoJPqewH02pO0lPDDzlo6vFFSPKYGSFiN6KpmV7MZrH7Vi+E2XTiJo2E6Wt55icQr4Ot7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954969; c=relaxed/simple;
	bh=XOkBCRF4fPWiEwhz3wTVytovSusd2orQZZzDz4mYZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhm3eZwjAv39WBdIixcup0ELPoQBKTHE5njaL45PvXFkYlk+zZQuKSuo1G9RabAMJoX4LGY6ajTVy5PY4xro1BBeX/EmwDnHCnuM9lSvGZdSdLzehUWy7TRZqCwxhhJqaKjB1Ie6Jsj0cnG/iZkrrym3OFpY9Zwb6sijNgkyr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcHTK4Mc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499bd3084aso2040219e87.0;
        Fri, 14 Mar 2025 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741954965; x=1742559765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry2RdRxaIEj6R0WcfwppEn7IhChq0ONiN9TM0ey9o88=;
        b=lcHTK4McL2zVIzBPcfu0BGGfOlEscLNMm5ilNAEMjx6DPMEwqYCZNLC9nKubAEUNC5
         Yvk6WPZvQLZKZSw3up+VGoxTvRFucV75yYSOixbD6fzS2pDz/gN5Zl9L0Joyde9kt9wc
         Mnuzl8JIqJTIQsqzmsy8hyt8Kq7AFmc/xYZzalBiKX1KNMNwVB/UaewBWSvX0FVvLV4/
         iyawsWrn3ROWYj2QKOqTgyHzc9fn1nOk2KBAWuH988mwSVqxzEv9Lh7ZwhXwVSnfbWgb
         i+uFe+6pauqq4eKJws7NXC14vf7ol+mFGsZuyTdBV/Zb3M7Na3K0yJb55nq7KekRR60p
         abtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954965; x=1742559765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry2RdRxaIEj6R0WcfwppEn7IhChq0ONiN9TM0ey9o88=;
        b=qDm5Ihjp1yE/E7dEM15CyTYt4daao5UtO/CDDvJKdj5QI95WGzGEz7LBhjhI1v5inb
         fqtX/1cHVff4Iq1okMZ1LxSELN53yFIHFOZvfFkNGqsIHCiN+SNZ8IKy5+924b15qqah
         1+zRRqtD4gPKCCLB9ALjRAwovPT7lRF/zEnL/P1kOtTKzE0GPkbNTVyZWZsYQ+L3YLDA
         y6FLYXmhdaJwRPpUErXoiGT+3aEJl0yYwAkOehTBUYlO9cC0WCho12sed3zdDWCZIPmv
         qW9v7Hiznptp7wjOEqZwuFD7MRcwZN/iYSyKgqr2pj18Pknh/jSd6PVmdYj5/3c9Caz5
         EDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmLAL0rAAc4SMmk/uxkgX3g51edWz2zcZuAeGc849N5OCJ8LyK+uqF1XdRU0DlyVwi6kcoV78gKJLNx/w=@vger.kernel.org, AJvYcCWMzYs344kxEG49AmMU1sP6+peQ7LG0UM8O97ss0U6A/Q9RnZ5u4abHQ8gfBou2NlZ/2xsqQjhNamc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiJD89yjIlEHhQXZHlY5zC789TBS2bqGwknf27U6EgL9Dpn1s
	pq3nQUsX7j2IIpP3eo5vTkXNDknBKfZwjgIAcnw7fEwlIyizXGUc
X-Gm-Gg: ASbGncu+nKjcyHhbgEvY/58Li0cgqI8Hm9UxM7jAbZHtN+5kPbW6S1/Wxj6bz5VZS40
	Gopwe0soGt0wGwHyzLpC1dVaEJtUPgW382tSgKeMGgHsnM5aBzeAXL86nDIMxSkId3cM+vQiC0o
	06GzSk71U7ROiKS+AckrcmLCpzu+B4QNfrrOoZBmiJJJNtQauqRmmmmezIcZxdgURWrc42ACflf
	VqnsQC0bR7s5z83rzVfkwnDnUx/WkfuOwdjpByL/l6YoREpfneJOBGIuIJXNgjsnJ6RoPIhoDN9
	PJ6wgub9EGDRg79F+PufDiBxAhFoWj6k5lO6xB/IETHqEYiCV/m0X6imcfDeQr5axRGKoRtHjG1
	OARzwOpTM/jvg8ZmopkJpY53fcw==
X-Google-Smtp-Source: AGHT+IF2n2QrYzrJyXMDAPimkCx+4Qfg2BIZON+iQVvMQCrSsEtdz43VKcbb2wXM0ULY60GxnyX72w==
X-Received: by 2002:a05:6512:159a:b0:546:2f7a:38c4 with SMTP id 2adb3069b0e04-549c38e2ecfmr656026e87.13.1741954964411;
        Fri, 14 Mar 2025 05:22:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864c1dsm514246e87.119.2025.03.14.05.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:22:42 -0700 (PDT)
Message-ID: <58e19481-530c-4465-aec5-1f44462eaf5f@gmail.com>
Date: Fri, 14 Mar 2025 14:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
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
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
 <20250314113604.1776201-4-o.rempel@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250314113604.1776201-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho Oleksij,

On 14/03/2025 13:36, Oleksij Rempel wrote:
> This commit introduces the Power State Change Reasons Recording (PSCRR)
> framework into the kernel. The framework is vital for systems where
> PMICs or watchdogs cannot provide information on power state changes. It
> stores reasons for system shutdowns and reboots, like under-voltage or
> software-triggered events, in non-volatile hardware storage. This
> approach is essential for postmortem analysis in scenarios where
> traditional storage methods (block devices, RAM) are not feasible. The
> framework aids bootloaders and early-stage system components in recovery
> decision-making, although it does not cover resets caused by hardware
> issues like system freezes or watchdog timeouts.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

I see you're already at v6, so I am probably slightly late... I think I 
hadn't noticed this before. Thus, feel free to treat my comments as mere 
suggestions.

All in all, I do like this series. Looks mostly very good to me :) Just 
wondering if we could utilize this same for standardizing reading the 
reset reason registers which are included in many PMICs?

> ---

...

> +int pscrr_core_init(const struct pscrr_backend_ops *ops)
> +{
> +	enum psc_reason stored_val = PSCR_UNKNOWN;
> +	int ret;
> +
> +	mutex_lock(&pscrr_lock);
> +
> +	if (g_pscrr) {
> +		pr_err("PSCRR: Core is already initialized!\n");
> +		ret = -EBUSY;
> +		goto err_unlock;
> +	}
> +
> +	if (!ops->read_reason || !ops->write_reason) {
> +		pr_err("PSCRR: Backend must provide read and write callbacks\n");

Why both are required?

I can easily envision integrating the some PMIC's 'boot reason' register 
reading to the PSCRR. Benefit would be that user-space could use this 
same interface when reading the reset reason on a system where reason is 
stored using mechanisms provided by this series - and when reset reason 
is automatically stored by the HW (for example to a PMIC).

In a PMIC case the write_reason might not be needed, right?

> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	g_pscrr = kzalloc(sizeof(*g_pscrr), GFP_KERNEL);
> +	if (!g_pscrr) {
> +		ret = -ENOMEM;
> +		goto err_unlock;
> +	}
> +
> +	g_pscrr->ops = ops;
> +	g_pscrr->last_boot_reason = PSCR_UNKNOWN;
> +
> +	ret = ops->read_reason(&stored_val);
> +	if (!ret) {
> +		g_pscrr->last_boot_reason = stored_val;
> +		pr_info("PSCRR: Initial read_reason: %d (%s)\n",
> +			stored_val, psc_reason_to_str(stored_val));
> +	} else {
> +		pr_warn("PSCRR: read_reason failed, err=%pe\n",
> +			ERR_PTR(ret));
> +	}

...

> +/**
> + * struct pscrr_backend_ops - Backend operations for storing power state change
> + *			      reasons.
> + *
> + * This structure defines the interface for backend implementations that handle
> + * the persistent storage of power state change reasons. Different backends
> + * (e.g., NVMEM, EEPROM, battery-backed RAM) can implement these operations to
> + * store and retrieve shutdown reasons across reboots.

Maybe we should support / mention also a case where the PMIC driver 
could just register the read-callback and provide the reset reason 
stored by the PMIC to users. In this case the write_reason might not be 
needed.

> + *
> + * @write_reason: Function pointer to store the specified `psc_reason` in
> + *		  persistent storage. This function is called before a reboot
> + *		  to record the last power state change reason.
> + * @read_reason:  Function pointer to retrieve the last stored `psc_reason`
> + *		  from persistent storage. This function is called at boot to
> + *		  restore the shutdown reason.
> + */
> +struct pscrr_backend_ops {
> +	int (*write_reason)(enum psc_reason reason);
> +	int (*read_reason)(enum psc_reason *reason);
> +};

Yours,
	-- Matti


