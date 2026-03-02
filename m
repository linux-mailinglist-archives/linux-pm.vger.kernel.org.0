Return-Path: <linux-pm+bounces-43391-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PRNMwhWpWnR9AUAu9opvQ
	(envelope-from <linux-pm+bounces-43391-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 10:19:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E561D56A0
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 10:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97153004C4E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE638D011;
	Mon,  2 Mar 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eA3tzMte"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A8379EC0
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443000; cv=none; b=bNCBSt0PGpXiFC6Gi0ihqWX+PuMIm2TvbylEW3C31UL0gEr7ZS1tGSUngfYOCb5i/Ebcyk9lQ44fw2oz5WIyPLA+4RPEy5+pMsFvpGN2unBn3pD1xjn93rVq6dIB1hkQrXmVXJT7DrmugoQfbZtnXK/HKyOHAGapYLZmBOiT39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443000; c=relaxed/simple;
	bh=nIBLLWlywvbDHJl1jfJUWtsRmZwWr5mgqYdTBQwVYCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgUiUJCAmzcOKQAAp+lw2sxi7RFcAj2HX+udlAnv2ZnXdiTrqgvqfVkrLzI5t7nDh5TNOztWD36j61jPiAfYVjsgCOs/jY8hqqotNjE8aMU8JdbAL6cnciJIMI+O5bChIj9AgWONkCeFFYU0cKTkv/EiXwXQodlDqZ0EEKo09Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eA3tzMte; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso35882935e9.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 01:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772442997; x=1773047797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ktr/JNOB3fV/EZRd7szBfJ+V3eeHkmzO1vLTnQ/4sY=;
        b=eA3tzMteMsy6Qn5yTXt1XNfp/jsXQuQqtqn8ZHsbkm9xoROdFgvh/uUxZjk7lWWNoF
         6YonUW19js4ImCBLcllImRvplTXbHYw6siG+C7mc8UMU7TeG1Q7prmseBXN7Hb0xlI+p
         xvUcIkJzN7naTb3ooxwsOe0W24aIQuqtOQU8OfIfHNauPzZMxAHvrtZSLabQcy5r+0zN
         1tCvM6QDSN8eGHHIZxL1qOjxUNohORBCh4b7SxGHE4INptectyS4hFALbil9Q3yeAUBq
         geZzV19VyWPjvpVHHn3No2KDd2nsMfBuxOB9PIMUjBRaXceh4KcIY1KOgPjumQJbI/Dl
         Qcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442997; x=1773047797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ktr/JNOB3fV/EZRd7szBfJ+V3eeHkmzO1vLTnQ/4sY=;
        b=Ql/XQz3nnSWAdh4mYUVrx4UT87uV9eKNg5hTD4uSSdJ6Em/2OwUfLpuQAEoH8UBhrV
         U3F5Zn5hgF+0mErseVK6J96ES7d8pzQvs6Q+Pz2Bfe4m6HXcJ5xGffwP/G1Ftb5f8cey
         DD55pf9ZXIbiZifgW6RDS95KLO4O/dPMCy2wwNJew2IZc1d9m3T9X3r6CYs8cLfkfltx
         lbLMGxffjoJgMF/cVFB8FRlsHv8dt6tBF69ws/Tkcr8MLMV5fBdNnvi6vFR8A8spvN6H
         1DDKYnQxmTnjK0YwbFn7HX3HATCU+wg3rwEtv+Ik9z+6WrwHBvdU2qnpJ+HAoYK/YHfV
         4IDw==
X-Forwarded-Encrypted: i=1; AJvYcCWD7bIvnMnwRXYPqauVEnddipzaWw659Hqquk5wQX9xG97nN3yxhHb471dvHJNzRwsluzVj5BxmSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwavDwf3v31alFsFXZlKY08HUi+Z1n+g1Dycu5mgtEQroijClOv
	vNBAGTBQPPWqREnFwgkEmx0uqAwTQ6mu5YFg0RO2flTSyV/xO0nVzPTT+YVwalqgQGw=
X-Gm-Gg: ATEYQzww7yHAKABMeIzhErVdPXh5y75rypHIfL12MganNg3OxiFx1rYf21MPKFpTNVR
	oMaLE5Y+bSzohx+M3DRfgMHVVpg/dBFtbcf5evVa40Sr73avYtOkW+/bifqjH+ac2b8haiLXqek
	1nSJ7d3/MGhUosJa/zpqkDVhPmEBIVsYe17Iw/kuzKRJCKQATBDN7QQB96H/DGgqxG1uJzVYM1B
	LL5cfc6+s0gtezcO4c413paXIac3uog0FByJZ+iQt1+K2I54YVJul6PKTn8e34e7cURbQ6e6HCP
	EWzECCMF9tah6VcdbdMkSZHpaRu/8oJSEN2aEnivmagdR7LckjGaTZYnY0VUm8bwPwFZvOGV+F6
	Lu2tYQp8z4J/4+nmuvcS/aPiaQKIFpAwBr344D6DG26tSwkRsPvObtffeVr8zYs3kjXIalDZZNB
	F/BTPFD3hRJEWGxBDTndqM0zrMyaAActI=
X-Received: by 2002:a05:600c:4eca:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483c9beac6cmr219764705e9.16.1772442997213;
        Mon, 02 Mar 2026 01:16:37 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfabb84esm389964955e9.0.2026.03.02.01.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:16:35 -0800 (PST)
Message-ID: <488f9257-94fd-4c5f-ba41-c9216bf0f7e5@linaro.org>
Date: Mon, 2 Mar 2026 11:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] thermal: samsung: Add support for GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <20260119-acpm-tmu-v2-4-e02a834f04c6@linaro.org>
 <DGR4OFNJXOI2.3QACIHMM1V429@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DGR4OFNJXOI2.3QACIHMM1V429@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43391-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,intel.com,arm.com,samsung.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29E561D56A0
X-Rspamd-Action: no action



On 3/1/26 5:33 AM, Alexey Klimov wrote:
> On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
>> Add the thermal driver for the Google GS101 SoC.
> 
> Is this driver for GS101 platforms only or for all Exynos-based
> platforms where we have deal with thermal unit via ACPM?

The driver can be extended for other Samsung Exynos SoCs.

> 
>> The GS101 TMU utilizes a hybrid management model shared between the
>> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
>> firmware. The driver maintains direct memory-mapped access to the TMU
>> interrupt pending registers to identify thermal events, while delegating
>> functional tasks - such as sensor initialization, threshold configuration,
>> and temperature acquisition - to the ACPM firmware via the ACPM IPC
>> protocol.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/thermal/samsung/Kconfig    |  16 +
>>  drivers/thermal/samsung/Makefile   |   2 +
>>  drivers/thermal/samsung/acpm-tmu.c | 643 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 661 insertions(+)
>>
>> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
>> index f4eff5a41a84ce02b12abb85d6a0f8818031d0dc..5679dfa85f4079c7d40317ac231bd6a1af93c7e7 100644
>> --- a/drivers/thermal/samsung/Kconfig
>> +++ b/drivers/thermal/samsung/Kconfig
>> @@ -9,3 +9,19 @@ config EXYNOS_THERMAL
>>  	  the TMU, reports temperature and handles cooling action if defined.
>>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>>  	  data from the supported SoCs.
>> +
>> +config EXYNOS_ACPM_THERMAL
>> +	tristate "Exynos ACPM thermal management unit driver"
>> +	depends on THERMAL_OF
>> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
>> +	help
>> +	  Support for the Thermal Management Unit (TMU) on Google GS101 SoC.
>> +
>> +	  The TMU on GS101 is managed through a hybrid architecture. This driver
>> +	  handles direct register access for thermal interrupt status monitoring
>> +	  and communicates with the Alive Clock and Power Manager (ACPM)
>> +	  firmware via the ACPM IPC protocol for functional sensor control and
>> +	  configuration.
>> +
>> +	  Select this if you want to monitor device temperature and enable
>> +	  thermal mitigation on GS101 based devices.
> 
> I don't understand this. What this driver actually supports/implements?
> Dealing with TMU over ACPM firmware is not exclusive to Google GS101 SoC,

right

> some other Exynos-based systems has this as well. However, it names
> the config option EXYNOS_ACPM_THERMAL but a lot of other things say that
> it is only for GS101, isn't it?

right, because I'm currently adding support just for GS101. I wanted to be
accurate and thought that when/if other SoCs will be supported by this
driver, we can generalize the description.

> Does it implement the generic layer dealing with TMU via ACPM (hence the name)
> and adds specific things to support gs101?

Right. I expect the sensor mask may differ from other Samsung Exynos SoCs.
I remembered I compared the register set with e850, minor differences there.

> 
> Should it be something like this (feel free to correct):
> Support for the Thermal Management Unit (TMU) exported via ACPM.
> 
> This driver handles direct register access for thermal interrupt
> status monitoring and communicates with the Alive Clock and Power
> Manager (ACPM) firmware via the ACPM IPC protocol for functional
> sensor control and configuration.
> 
> Select this if you want to monitor device temperature and enable
> thermal mitigation on Exynos-based devices that implement dealing
> with TMU via ACPM, for instance, GS101-based devices.
> 

I can generalize the description in v2.

Thanks,
ta


