Return-Path: <linux-pm+bounces-4228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A217685F5F0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B5928422F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2D2B9BB;
	Thu, 22 Feb 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOeIXNrn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60E3F9EA
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598665; cv=none; b=p6l4YUzUHV+a1ChGUX61smmElJ6aUWY7k74lwTpVoJXYYPKpbGseRC5jhd7pBEwMOIsghL3qXXhWy7i7Jwqb6Jm/GnfruL1Jtz/mMPw6XqSumXuGdA2EXi7M1Cna+QRLswRqzM/CKJtPckfqR5ek/muZms2CZv1Yy//JKA9wEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598665; c=relaxed/simple;
	bh=I8GfOfCTLZmih12aYKjE14cKV4MXTg54Oq7SR/j3eZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBjYgeHaB7SnpFNCygxdsNOF5l2SpldxfU9wE/KWmlCHTNoIdD95q9Omens0OF/zImIaqhAgKT1vX2ufrcPc6xvYEleRcWNAcq4znnb3y03GJT9WR8cHxJ6a1TkkgAC1k56t0vaRnyYiGUt+L/wd9LQ92Z87QxhCbhhLKC1eggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BOeIXNrn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so21201701fa.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598662; x=1709203462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiMRQBwGLj/KPIT0lE6FKUXqjnkUTGxkru+2azcnTvM=;
        b=BOeIXNrntHg88q0ztMhKZTwdp11aOLgzRPMmQ/xvzL1DiLUoyLpkJ/zYREPOF+TbJU
         jeYHjUwv7Bxb7YmN/k6Jow5ziite1pz5l3Zf2NWIUR18QaDWFSjMoexbo9xedEPzc4pi
         LMcCCLpYM2q6Wp3G0aID7yHmPQJp0EvsstAmkmvwlkuTQkFV0fM2Q/4BIhxbQeZRY3JV
         N1isLzmP+oo0W+OfUZO6CPxnu+S6Lwo314bEyQTpFU8iskpXcYfyD1kjsj+D25dy20J2
         zv7xHf4IUBj6+MkMF1hUizBe34FQDoivg/r/wbZAMEOdHSR+7RQttIUwCCIJ/pJEyfkZ
         RUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598662; x=1709203462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiMRQBwGLj/KPIT0lE6FKUXqjnkUTGxkru+2azcnTvM=;
        b=XZXTxMuJE9AuopllDasewwTuRZAFpxGaOL1qTezYEGYvWv9ekmCJDtUvrJX0iYRG1o
         OlAuw6AI9gDMUEQjMjGxsGauoEo7bedrxYIpzj8cYbScLUfV+iH/NkcFdV2jRclRLxzi
         emnn6j+uoorTx5vbcVd11MbcTE4qWM0a22aqrCIs5NAfVNbxeUbB6zcUWJdUe7EICQ57
         kWDkYsutL4KxZOJQnFQgjCAPul56LrlKhzz1DjDv66zXgq97/2oH0FbD8KA2RemHvfUM
         M0xWj0l8G6wM516butDfyuhqHQXCJ9A4oFsBb08btIMNQ+jkZxjZzjvHgKo4yKzYS2vn
         ZNxw==
X-Forwarded-Encrypted: i=1; AJvYcCXxFP9kY+pn4wG577/PEa8W646fhkMxH3LRNLSsv+y2ItVZGDKBXW366BWsHBr/wRRf+N4wgwLaRngQGj8bP8z7VAQz2zME/LA=
X-Gm-Message-State: AOJu0YxCdKhaS9ciM0dbHC2UWXlttyvxwEV58oV0mZmo4lqOvMtyTPOz
	Ej95aBtX3trycUActSQTikAdNAYbc21aEKNmfyCgeEfvM6vuuoSmbhvKw22EMMw=
X-Google-Smtp-Source: AGHT+IFI+YXV+IbPRZDUS5Mhza+q8qDL4tfABrK7RQ5BrnppYXtMdT6C1vmAYblahRewhKdggLFw7Q==
X-Received: by 2002:a2e:870f:0:b0:2d2:4218:6275 with SMTP id m15-20020a2e870f000000b002d242186275mr6301038lji.49.1708598661733;
        Thu, 22 Feb 2024 02:44:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p6-20020adfe606000000b0033cdbe335bcsm20032407wrm.71.2024.02.22.02.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:44:21 -0800 (PST)
Message-ID: <d6ecb1c6-f9a7-4303-96a0-129c42eff75a@linaro.org>
Date: Thu, 22 Feb 2024 11:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2262393.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code requires thermal zone creators to pass pointers to
> writable ops structures to thermal_zone_device_register_with_trips()
> which needs to modify the target struct thermal_zone_device_ops object
> if the "critical" operation in it is NULL.
> 
> Moreover, the callers of thermal_zone_device_register_with_trips() are
> required to hold on to the struct thermal_zone_device_ops object passed
> to it until the given thermal zone is unregistered.
> 
> Both of these requirements are quite inconvenient, so modify struct
> thermal_zone_device to contain struct thermal_zone_device_ops as field and
> make thermal_zone_device_register_with_trips() copy the contents of the
> struct thermal_zone_device_ops passed to it via a pointer (which can be
> const now) to that field.
> 
> Also adjust the code using thermal zone ops accordingly and modify
> thermal_of_zone_register() to use a local ops variable during
> thermal zone registration so ops do not need to be freed in
> thermal_of_zone_unregister() any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


