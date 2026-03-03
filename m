Return-Path: <linux-pm+bounces-43478-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFl0DpGjpmkJSQAAu9opvQ
	(envelope-from <linux-pm+bounces-43478-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 10:02:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2F1EB74B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAE72302D1A5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2D383C6D;
	Tue,  3 Mar 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5+HF9S7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609E3559E1
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528508; cv=none; b=klNskw07cp672v506e2QMH8cAhRDXnabUoIo97hj7SyOB1DVT5FSB12iLEEbL7O/Gu1CrJ2hYVTiGah1gaAXrAdafzXWgTlE7zhUNDx19tbcIZaRGK5Vwkf0Kv9//eaM5dXDIA+cDFxwnXfZ/ECTucGgdRRK4wjDdDMPqTQEe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528508; c=relaxed/simple;
	bh=wKzv8JjnWV5gBG65VFCZ2zPm9xxHlHBRT8kIM6tUCBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUlOsoeKlZgtwmneB9UEC/XlcKJtMLpUMvZHQ23Z5VkMpR1NMLleZxjEJl6J5efFyIicE3LXV/ycjiDATdhwQh89lUOwCwfFWpcZ9NGNkOs2SaP4I8TYsL6JOKhYZENoYT6FzjS0hGzawbMvr7YfcJNdF66b60FMmsaHYuDgIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5+HF9S7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so32568735e9.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772528505; x=1773133305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xKcWF7NPjeXU/Yo9Rn3BptYJg8YH0is0Fv10MXJEt8=;
        b=w5+HF9S7SpRWMZba5sOz4lNbxVM1DShoNulBVR9GGxFlErxPJAQIB1tNRAoWMdSf9C
         4BQawI3ab20j7asF+paexzPduMb7qjwh9hq1tq23FAwz3VLgUEjHntxUJLgcFMkVXLms
         ZjqZoRqfWx5XWsj7PG5+UmShQlKIhGKOaQpzTzyIsMPk1iLbgnWdm9f3g6OcBdl5ARw4
         hPxMlFP3mbZ/0b3uVahPv3nIW9eJeMuqGARhNAOpjhht2yD2DU0pE2Qzt26m2fGqAnEr
         SRfpD4Pre9Svmd0Mm+o43o+qLWIfHVbPYYM8BeczfOir0/EhL6Rca1XiFSiWQXosLsLu
         pYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528505; x=1773133305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xKcWF7NPjeXU/Yo9Rn3BptYJg8YH0is0Fv10MXJEt8=;
        b=i9GwVEYP5Q6KL6pbm/cdGJYt8bXgcnlC2NpO0TUpUh8VMLXWjF/R7lowOMvu1G5kDY
         ILweIqqu1/EPCNj6RG19R3ygURUAdcgLNKyWhg/M0A4aMVv4iEB1S9G5dP+MyDmCzsVF
         JOHfx4e/USmNX4e35u4fyAFAgjlz8bbErMAm0fuEfeALAv+SetV2FIBRDMgix1U8q9JQ
         QCRnm7qvrWLvvXYA2uR1VpwB/Xq63rhGqQ/M0bDH1rLPAMuLF3U5ZiUSjNHdDfP1d8ki
         PYBrAvXMdZfAAUPvACSi4npecUgSGggG/TulqvHZ2unlv50e6cnzx5unVGE1TOzDtiVi
         LR4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKV24rwzycU18Wb7UyS8cBHT8ODHBSPX0KzYdup7FILmnRbegiqPMeKPLNBeL43poT7nKyV7zMmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34OL1++nXRBHVSj07KwyJTheSkIBGwoeTDyn1DytqjUsLQj79
	/wB+5bMCqum2Vtdzydcznq3bwrYPtEXWW67XFrqEVxoP1507gAJTg8rEyGzKzUnh6/8=
X-Gm-Gg: ATEYQzwcCkZt+ORYVIggI7i1drZXMCRpNjwVlW7X41K/sADZJ2XjCpmJgoZjovHoK09
	5O0hIW3oJVQVG6JM2x0M6kus2Yn+LYp2Om9B462Wm/Njbht+sfWxrDAF5SKdcHjNuSc0oeVeVGD
	Ll9NzscsghfGi/TV3Z5W5cgWQj5X6wsbv2LPczohakkr9Hdb/zlU8xTR9VgIMQFqmHIldVbcDoL
	vyKc7UISMKwzcX1IIbQKC1Yx0XZIUfGhpx3oFn+cSd9Ar5Bwj+qA9jwl6PB0gs/al+YtGkms80N
	7h5LvJaTAHmcAAwbDuVNVnUj1y4J+OKCZtOoohTv0bul1AvzjldbEii4QYJ7UKFFy1R8m8ZD0mD
	Q0hO12Zbl6mMlUGX17OBdbhNqW+hKTG1XK/TjtxWFYnZv2w5n7k1YsfHE7R1pHz51CBAAv55Tf7
	stD5GTd4X/V7dAA66Yc7QcWGIBqeDO0i4=
X-Received: by 2002:a05:600c:6385:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-483c9b53c9cmr291863355e9.0.1772528504551;
        Tue, 03 Mar 2026 01:01:44 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3474dsm312924805e9.1.2026.03.03.01.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 01:01:44 -0800 (PST)
Message-ID: <b8a029f1-1229-418b-895e-b8dc0319b545@linaro.org>
Date: Tue, 3 Mar 2026 11:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <CANgGJDpjsyoCnuXuMMi1L3nWNJsM4aMs6C=NvBcTkWeC3NFadQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANgGJDpjsyoCnuXuMMi1L3nWNJsM4aMs6C=NvBcTkWeC3NFadQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BFF2F1EB74B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43478-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linaro.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,intel.com,arm.com,samsung.com,gmail.com,google.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/2/26 8:30 PM, Alexey Klimov wrote:
> Hi Tudor,

Hi!

> 
> On Sun, 1 Mar 2026 at 02:26, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
> [...]
> 
>> ---
>> Tudor Ambarus (7):
>>       dt-bindings: thermal: Add Google GS101 TMU
>>       firmware: samsung: acpm: Add TMU protocol support
>>       firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper
>>       thermal: samsung: Add support for GS101 TMU
>>       MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
>>       arm64: dts: exynos: gs101: Add thermal management unit
>>       arm64: defconfig: enable Exynos ACPM thermal support
>>
>>  .../bindings/thermal/google,gs101-tmu-top.yaml     |  67 +++
>>  MAINTAINERS                                        |   8 +
>>  arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 209 +++++++
>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
>>  arch/arm64/configs/defconfig                       |   1 +
>>  drivers/firmware/samsung/Makefile                  |   1 +
>>  drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++
>>  drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++
>>  drivers/firmware/samsung/exynos-acpm.c             |  35 ++
>>  drivers/thermal/samsung/Kconfig                    |  16 +
>>  drivers/thermal/samsung/Makefile                   |   2 +
>>  drivers/thermal/samsung/acpm-tmu.c                 | 643 +++++++++++++++++++++
>>  .../linux/firmware/samsung/exynos-acpm-protocol.h  |  30 +
>>  13 files changed, 1275 insertions(+)
>> ---
>> base-commit: e2211f5d980086dd9fbdab3bcd86b715e12cae13
>> change-id: 20260113-acpm-tmu-27e21f0e2c3b
> 
> JFYI, the series doesn't clearly apply on today's linux-next:

okay, thanks. I'll submit a v2, but right now I'm dealing with other
higher priority topics.

> 
> Grabbing thread from
> lore.kernel.org/all/20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 18 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 20 code-review messages
> Checking attestation on all messages, may take a moment...
> 
> Base: using specified base-commit e2211f5d980086dd9fbdab3bcd86b715e12cae13
> Applying: dt-bindings: thermal: Add Google GS101 TMU
> Applying: firmware: samsung: acpm: Add TMU protocol support
> Patch failed at 0002 firmware: samsung: acpm: Add TMU protocol support
> error: patch failed: include/linux/firmware/samsung/exynos-acpm-protocol.h:40
> error: include/linux/firmware/samsung/exynos-acpm-protocol.h: patch
> does not apply
> 
> Was it done against mainline?

Of course, yes. It was on top of what was the latest Samsung SoC tree
at the time of development. Internal kernel trees may change,
depending on the maintainer.

If you want to try the code while I submit a v2, I pushed what I
think it was v2 at:

git@github.com:ambarus/linux-0day.git, branch b4/acpm-tmu


Cheers,
ta

