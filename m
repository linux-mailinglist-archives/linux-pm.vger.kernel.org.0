Return-Path: <linux-pm+bounces-17276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A29C2E82
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FC1F218C0
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988B19ABBB;
	Sat,  9 Nov 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/IYTpzA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9422BB09;
	Sat,  9 Nov 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169847; cv=none; b=SxYC/ogeox4HyzFg+rePlBLTmtww7lr1vKtoHwigYQwUAh9xFxHvDNpKMzk8ppR8GT7JJmY0xKf9u9Gdnz0TXQ51sekXb7fxtKoVaBtbfW+jf+QPjDlw18Ps31IirCYjpOP8X1kuJDKU0PpU2GV+Q6gSxS0ashjHg90PoUTk09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169847; c=relaxed/simple;
	bh=4nzEV01HerKl13JwtsONKUbgCEH5uMrLa3opUgMD+sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmordxizhg4ehAW0Mv5Zn9ICqvZ62br26BUTLI9+zlZScZTGHQwMZmnS9lnCEnHxrhnL1VOyXv7fPqByenlpLsVek2vJRl7Hhe0e1yVM4qBdMos7hwUJq4NWjb9derhbhVnukv/ij1y45j45882ie9G8ykFhwIz12V9Wz1tA4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/IYTpzA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20caea61132so28139905ad.2;
        Sat, 09 Nov 2024 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731169845; x=1731774645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HFu6d4lO7rqvd9CtGtNgYr/2KPNT3OuXCo4vOZrFRY=;
        b=W/IYTpzAnK/sPvb52bME+7m/QPh9xrSGB4J4kikOvCTutjLs7/OTgPyi1oXiM+Nz4v
         ldDm6T+Fm2ZB1QJ5L1oQofqaigeJhllEVcU8R+ldtDvQ91xYST7JHrbfx2HB68Co6CSl
         qxqvhTPwfemjQDwZjJT8yozelN789Q+eHlPBed0jbUlGlo1KOUDyBGRuJjAF54BRtQLQ
         4HYqRkerD1fTV+bWh2BKLjdc5+zcyxotjvPxEFlVcqTQie02NRlPEouHYSMRaaSWRDev
         Mu0NM/LHlXKrgSaBSJYhPJRNe2/8M8fv/0vpwhNt3x9kkVidev57svOG66T5LxKG4zVB
         GNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169845; x=1731774645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HFu6d4lO7rqvd9CtGtNgYr/2KPNT3OuXCo4vOZrFRY=;
        b=Xp8jhpsDEVMBxO6tFL6YVKresPgXrTQ7MBTVRvdpuwlM/y4awUUOM/OUyKxQkchYZp
         VOYW0JYJLIjFpJzLem84e+c9d2kKCHojawf9cACaXrYcLecEdzzzvqn3xFoEW7f1R04S
         YhYm4H9NA1O+KkpT14umpQYwKZeHYz45GeqK62UbVrbBjDHbnEeGLJUZ+HyOuiEpxzI3
         roVJZzBm2LM25HND8unB+DPDFYWtazfYSLCwogm06i3SxOljVhWNiEixBvj1KhoE0b5p
         N4fA61nNQM+1lnLcXR1nRAZv33bWXhiU48wJzJVIacBwcNBz1ngW3PVHKPplxvjlhX7F
         dJIw==
X-Forwarded-Encrypted: i=1; AJvYcCUKzNWohtN+/N7BfO/RXetLddzHLPGFUypOgo1N51/VkZVRT7+b8b8Aaos1Bt0drJZF0pVj4DG5yTTdB2k=@vger.kernel.org, AJvYcCUYb78ItN1vhvcGS/CFEbWXzfDNxY+OEGJ6wOvMXqp3UXPVu7TsshA16VLtqAtphqbj43sp9ln/yCdNRQ==@vger.kernel.org, AJvYcCUq5teus+MW11U6Pr63rQNLslWrmtXvbJm56syMgxHDuh15gIAKYxlNpbkq+ynsTWzCe5ZKvN03GGYpmw==@vger.kernel.org, AJvYcCV6WTwy/kMsTl4cR3SY1l+GSTRB14/ArsuWs2ueURzgBXLBwldhQ3Mdbj5gAtvl6qwQUCR6O5HNNRc=@vger.kernel.org, AJvYcCWBgv+eMtn5hSTiMJlBCT+kzthf0UeusLzYGwcaXka3YIqxJqM+oPhLNXPPu0IpM/dwzclFtMCf3KIU/sw=@vger.kernel.org, AJvYcCWPdstUmWRWJgYQKIo21l5cWyHvuoXlhgJ+T5iXz0JwITLY5ii4gF3MUGLmzIsXMFfBcIXb6sNVIhX9cMf/OGss9Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLltKm/zeLk+pBondPtNaQTcN0wcaevBBX+HMoCU1IniDDdY4z
	JOA1VcP5ECYKWRMWUns0Gfn4RGUGp4mIusmzMhTvrgzE4Go4kTjY
X-Google-Smtp-Source: AGHT+IGGs2S0yCDvHRz6lhphL26+ZgfU8grAgZs942pwHOPtldd6rtgtD1s1xn3JASfB0aCkY4pxLg==
X-Received: by 2002:a17:902:ea10:b0:210:fce4:11db with SMTP id d9443c01a7336-21183517ca8mr100546255ad.22.1731169844727;
        Sat, 09 Nov 2024 08:30:44 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a3f4sm47858475ad.234.2024.11.09.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:30:43 -0800 (PST)
Message-ID: <3be2547e-d987-4987-9d75-30bf81cfe6cd@gmail.com>
Date: Sat, 9 Nov 2024 08:30:40 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-tegra@vger.kernel.org
References: <1a44c5fc95616d64157d2f4a55f460476d382554.1730987047.git.ukleinek@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1a44c5fc95616d64157d2f4a55f460476d382554.1730987047.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/7/2024 6:57 AM, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/memory to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> A few white space changes are included to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

For the brcmstb driver:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


