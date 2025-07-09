Return-Path: <linux-pm+bounces-30479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CAAAFE8EE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EA31C46DEF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AD2D9ED8;
	Wed,  9 Jul 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h6sLrCpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BB2D8372
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064173; cv=none; b=MiXKY2h5D2BPNDhxT+c8nbSveQJGG3KZn/C1Igxbqk9rvczl3p3VZK7jLuo4gmMn8OEgVZBr9ntrcpFZw/x03O8UpSA/NyXeb9ApO1NqXK6EqJifpQ4rAzGgEB5m/CCdOkGe46i7jm/Cr/+mS7tHi3yHg51gvamwvav58vbxFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064173; c=relaxed/simple;
	bh=1qoGLFWJSjiD5FNu/QJSNerguNW231RX1fjFWd+H4xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRGoOoljWMAUHSMNpMfz/oYs6/tWqtYcxCTeKWMTFNxHyKs2DFPhQq7Ze2mo/ihjwqT5CYpiCtPjXqxnBwEGiWB1cAsyM2UQWh+vpOdleKBl+TFnnUHDePFT0cnQfmPaM2/KT4U3Mhp+vqAGs9T9vt9xnIXP611+T+naxBhI6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h6sLrCpK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso4231159f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752064167; x=1752668967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RpZyEsZ9siwnxWejSZ2eKpWoZRAgc76kY/VDdxOs5Y=;
        b=h6sLrCpKnBxOM8Uod1nNsuXIohGuf2JkRBbdHfUXbD6sDbo9fv+lY7d1Mp4chHKMLu
         mu3s7Qjdt+i53BQg/MPURHehzVq+JRLn659XhlEnET/OAXANSavHYJuwrGmI87B7U/Ne
         3o2tmTFeuhBwoWnjY7GGfZVphqB2Tk4zBxJUUaHM7jXyQh3UiOb+4X61/XOMNQ6FScNN
         +ZkPbFer/WGgjQgcnQz17hkIDHKO/Nnz7QELMfGvXPiha4hzeaI8zddK6aJ9bZbe7zX3
         oagGwOinB/zaZ/kcKY6Ux2zDWRMdvsnlHkW+gQ/3Z2FgV/elJF/KaHF8joAr0/SLEAWt
         q0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064167; x=1752668967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RpZyEsZ9siwnxWejSZ2eKpWoZRAgc76kY/VDdxOs5Y=;
        b=EdkZGS7EzIrjXUv9KXjAUKYAK5S48xeqWjOUshouRR9DJW7RLHtEkIP7u7ad/2SDT7
         bTXOJGHQmIx1n3gByFu0NPAZaDXQZou3kE1mMDWf5GiwxV+ahOelJEoMnkezrlbwZwY5
         LvUKcC5K0CHVS/ROcT4l73bDCwWctxK+mh05rCMSK4vpMUEAe0y59+EDRDIz6jmnwbx0
         gAdibIvs6A5801X8MwXzEOkLTIotg2YXIn7Lypfc38wRe8TQ/FqqRhBveEnBag8WQmqu
         HLmD/KYb+BACOBrYDMCOfK3UrGLiET6vLF2dkn7525wSorOWxtidzoUYFRIrxQn6yfnz
         AH7A==
X-Forwarded-Encrypted: i=1; AJvYcCWkw+F/YX9HKMuPZqVpx7WbrmBN8RFACUUzXrnvj7qh+cDJ6ooKEfo+Zh0GR41eKmBa2UnBesfmvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3S+KsjWDkZTEEuUugMnLJGNT/vfW8dtOvZF3tUSD3lZRtBaP
	udXROvSoY2cas6rW52aGst35ES47ZOa5rv4GaaSMECUNnu6ALdceUw9pgyzJyFdKa0Q=
X-Gm-Gg: ASbGncvR6l7lPnRWvf3Zax7UdMGauN5yvBVK0a3sdUtxO5gp2GYIrfU3KUbh0FPw+pK
	9CLX04Gr2gkIqv5V8eR9CdeSyuFr0VL6xRvUVq+Bh61Nz9DgmBdFmvVJwNpSYi4WTyTvMOnVKFT
	/Pdmghe8rOAeeGsJjT5gkxsNYRBqlmgQ9nGjulD5Gop6BuOBW0sHsOFRHyI1R3F9RjZzjCTMyfd
	Y2hXbcwoLNf+9eK4yUBdhVY+iO6/3huL+b/Krh+J5SdNlqv2LG3+g3LJid3PU9THitBBm18V29u
	OwQ8PHUwRK0hqHG4JfF+ZKT6OTvfwbpXbLPsZkidGqMQZi/xBU/ZZl4SVtipNUa7ZdWlu9EFyvu
	h511cZw7syJEi03ar1kc=
X-Google-Smtp-Source: AGHT+IF46xeHA/xHWUZt2VaJX9Q27+CBFxgDcAPuZ3tIACT9PG7tMok6gEJhsgPD9ttdMfDT9SW3Yw==
X-Received: by 2002:a5d:6f1a:0:b0:3a6:d7e9:4309 with SMTP id ffacd0b85a97d-3b5e45380f3mr1883135f8f.29.1752064166873;
        Wed, 09 Jul 2025 05:29:26 -0700 (PDT)
Received: from [10.1.5.232] (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm22393915e9.6.2025.07.09.05.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:29:26 -0700 (PDT)
Message-ID: <8107b20a-b0f1-4724-8ab7-994ede3b3268@baylibre.com>
Date: Wed, 9 Jul 2025 14:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: ti: Select PM_GENERIC_DOMAINS
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: vigneshr@ti.com, nm@ti.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vishalm@ti.com
References: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
 <CAPDyKFpdZGa0nT1V7fkOv-RuNPDz_xNJk-+Ex+NzyMF4Lp=peQ@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAPDyKFpdZGa0nT1V7fkOv-RuNPDz_xNJk-+Ex+NzyMF4Lp=peQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/07/2025 à 13:09, Ulf Hansson a écrit :
> On Fri, 4 Jul 2025 at 11:08, Guillaume La Roque <glaroque@baylibre.com> wrote:
>> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
>> it is always enabled when TI_SCI_PM_DOMAINS is selected. This
>> simplifies the configuration process and prevents build errors
>> if PM_GENERIC_DOMAINS is not explicitly enabled.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   drivers/pmdomain/ti/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
>> index 67c608bf7ed0..35a4c73da17a 100644
>> --- a/drivers/pmdomain/ti/Kconfig
>> +++ b/drivers/pmdomain/ti/Kconfig
>> @@ -10,7 +10,7 @@ if SOC_TI
>>   config TI_SCI_PM_DOMAINS
>>          tristate "TI SCI PM Domains Driver"
>>          depends on TI_SCI_PROTOCOL
>> -       depends on PM_GENERIC_DOMAINS
>> +       select PM_GENERIC_DOMAINS
> You need an "if PM" too here. So:
>
> select PM_GENERIC_DOMAINS if PM

ah yes sorry i forgot it.

i'll fix in v2


thanks for review

Guillaume

>
>>          help
>>            Generic power domain implementation for TI device implementing
>>            the TI SCI protocol.
>>
>> ---
>> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
>> change-id: 20250704-depspmdomain-2c584745dca8
>>
>> Best regards,
>> --
>> Guillaume La Roque <glaroque@baylibre.com>
>>
> Kind regards
> Uffe



