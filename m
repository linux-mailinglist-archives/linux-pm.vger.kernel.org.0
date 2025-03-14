Return-Path: <linux-pm+bounces-24061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FAA612E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617EB189C518
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5A1FF603;
	Fri, 14 Mar 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eITjjaqA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1F1FECA2;
	Fri, 14 Mar 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959542; cv=none; b=aYW/U/jemHgmS7ZlHa7m5rJaJT4tYme/k/bTdm2m/zgJOx9ikeXyDA1jTC13KHlQgiw5PXD6Xp9Ap3Q8McST5Q572WA83b1BlQOqKyZ6owyKYXOsE3qpfc/+838SxqByTODUIEUXDYXkD1R0h7UQlpoTChbZ6JJr/wnV/P4mZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959542; c=relaxed/simple;
	bh=hCH0QbOU7YEFPetxxX91L6YysqIx/EQog2etLguJj28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snp8BZ46eBrdPPDeXJZPjCXivKNyB0tIb5RxSZOpUa5R1TY627dsyvrrAssKNzLDioikTCMscz5s48RVn9g3MEzbeJ7U2gNrGZTvLstMdiECuYoH6J8ZD31BtRTfKB60qCsfxcMHUpErTgQ3Aq3o8Sgp5mb4l00LR+PKxhOkVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eITjjaqA; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54998f865b8so1876887e87.3;
        Fri, 14 Mar 2025 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741959539; x=1742564339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhzCTWJ98QeetX0Lqy44K0mjT6jwPvVzdYi9tkPlycc=;
        b=eITjjaqAGeDI5YJO5zJAVJttv0yqg8+mYlIX+IwAgFLsZ358lIF/gu+rSgMrGLGuxN
         TTVaFZelesMv+TsFeqs6dtsA882yLave9qfoOZMZmEChers98eZ+0qiFw9SnsoqjFDyD
         o18PvZRfU46AFT6YBg8zUhqB8/vFhIVNurJpD+rtYPzYQbiiGjsfqBksbhA6eHpd0VjR
         3yVyLJ+f1SAGnbfitdXkqmsXfS1gfuLCtXlh+rrbY9NEQYQkS8vEEqcSzXEmzvQkFcXp
         hDbzDj4U6UQ5zXzXX7PhoIu3TdFxRaE/LxHejd11vJuMnYFzfig5Aq7ITEtpmnvKKkRc
         UdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959539; x=1742564339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhzCTWJ98QeetX0Lqy44K0mjT6jwPvVzdYi9tkPlycc=;
        b=vFSiNbkExVefTI4pFQmDVlOlSaRP9oHGU+2a4tO4NlznQALGYdmyCzYIV3i+uuS5uR
         SFogtu8dYnJd25Z9JHRAKXgEZiYFJliG/hdEsii3dO+FJhPcYuDbe9vA+LwZUozo1ZlE
         f38EJ+W5ezs4iH42bc4y//DOgdvJy8PwfTW16Ya6oS4ZxGqvwPbbir44vTrAmzQU8Rqb
         gDlqsBM3aa/C+LiR6kCuucoY5l4tYN6p345B9B93ZYfXIeklWxZZf76csvgR1bzUPsk8
         qq+5JGZS2dapD/P7Rth22xoout5vWFOjAmkpCknAQrbnfhCLCgx0+xAaJ9i6bM0ym8ib
         jScg==
X-Forwarded-Encrypted: i=1; AJvYcCWL1ZiGNlQ2o/e4x49ueJXF0VnP0/9ucYc1Vs4x2VxauibkgYaHMOxlKFJwdS3psWORAsHy0hEJ/G4=@vger.kernel.org, AJvYcCXBnsuazmhz7WtYyOA2/3uBQ2UDhnscSK6efg1W9OmmXiLSVVXgBo04ePzocZM9dYAkKZKqdehUqEzKZIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMDHLuiXKP8qeh8Pbgj6T3AlWZePvZz4k7ot1+qqdkPu1HA2c
	bjkBk/F/B2zdapEunh4q939B1c9Ao3QpfRRxntDZDiuxTuPx0qoE
X-Gm-Gg: ASbGncueaYtXPDCJcQcL0KCV+N7jC8GdN8UiTO3jxU6OgVQSJ1re/ZLVkcAITXkaZTD
	zrb2eX2pFPYIgepFBqh2gWte4ut6s8D3hVdLbFoXufr5yTaJ6Kl49b/5sShOLuZ0ngYWMRx9HJS
	+rpJ0zMdSMNofa6w3hV9mJV11wfmh+PaoL9COaUp31+e9lfNOEfkhazOc5p/Gl+th6osfpc4gch
	552bhoVGJVA7ec9BCbYCcSb8NUMLndr2F2CQrNa5IAUkxul/kBEj0VdqIEc8PdyItPz8uJFCOJH
	hDBdWfB/H8AtaYrdAHBnAOn3UKLZ9Z4ikTPE1IMlv288wL0C12YY5HjuKYhpHupVFog+aA02YNB
	EAN9ReGbLjSTdYlwU0uRO7q4cxw==
X-Google-Smtp-Source: AGHT+IH1My44mUZhsIp30MFzqw7ymCnGpSbaC4sDTDo0UIMwA5zmXEolpYiOvBXwOInnJCKMdYyptw==
X-Received: by 2002:a05:6512:b0e:b0:545:3032:bc50 with SMTP id 2adb3069b0e04-549c38fb8f3mr1052670e87.19.1741959538508;
        Fri, 14 Mar 2025 06:38:58 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba881f66sm525666e87.178.2025.03.14.06.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 06:38:56 -0700 (PDT)
Message-ID: <a8f76dd0-56be-46a5-9cc1-2d17d013127d@gmail.com>
Date: Fri, 14 Mar 2025 15:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
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
 <20250314113604.1776201-8-o.rempel@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250314113604.1776201-8-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 13:36, Oleksij Rempel wrote:
> Add documentation for the Power State Change Reason Recorder (PSCRR)
> sysfs interface, which allows tracking of system shutdown and reboot
> reasons. The documentation provides details on available sysfs entries
> under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
> and how they interact with different backend storage options (e.g., NVMEM).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   .../ABI/testing/sysfs-kernel-reboot-pscrr     | 46 +++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> new file mode 100644
> index 000000000000..7cc643f89675
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> @@ -0,0 +1,46 @@
> +What:		/sys/kernel/pscrr/reason
> +Date:		April 2025
> +KernelVersion:  6.15
> +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> +Description:
> +		This file provides access to the last recorded power state
> +		change reason. The storage backend is configurable and, if
> +		supported, the reason may be stored persistently in an
> +		NVMEM cell or another backend.
> +
> +		Reading this file returns an integer representing the last
> +		recorded shutdown or reboot cause.
> +
> +		Writing an integer value to this file sets the reason to be
> +		stored and recorded for system analysis.
> +
> +		Example usage (values are for illustration and may not reflect
> +		actual reasons used in a given system):
> +		  Read:
> +			$ cat /sys/kernel/pscrr/reason
> +			3   # (Example: Power loss event, may differ per system)
> +
> +		  Write:
> +			$ echo 5 > /sys/kernel/pscrr/reason
> +			# Sets the reason to 5 (Example: User-triggered reboot,
> +			# this may not be a real value in your system)
> +
> +		Values are defined in:
> +		  - `include/linux/reboot.h` (enum psc_reason)

Is it possible to provide the reason (also) as string?

I believe we should fix the meaning of the numbers so the ABI is not 
changing for the users. Hence we could as well document the meaning of 
the values(?) If I read the suggestion right, we will in any case have 
predefined set of reasons in the kernel side.

Or, am I missing something?

> +
> +What:		/sys/kernel/pscrr/reason_boot
> +Date:		April 2025
> +KernelVersion:  6.15
> +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> +Description:
> +		This file provides the last recorded power state change reason
> +		from before the current system boot. If a supported backend
> +		(e.g., NVMEM) is configured, this value is retained across
> +		reboots.
> +
> +		Example usage (values are for illustration and may not reflect
> +		actual reasons used in a given system):
> +		  Read:
> +			$ cat /sys/kernel/pscrr/reason_boot
> +			2   # (Example: Over-temperature shutdown, may differ per system)
> +


