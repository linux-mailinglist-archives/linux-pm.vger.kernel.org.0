Return-Path: <linux-pm+bounces-14055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14364975CB1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25C7B242E5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D4185B52;
	Wed, 11 Sep 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k9c58aIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E41428E4;
	Wed, 11 Sep 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091790; cv=none; b=R67bnnlOQjHRCsd16Eyr2tID53ixaaqFxrhlgNhRo//a7W8Z4iGo/dNbVOvyXHCeM9fUypbkSCMQVhtuTdTEw4RwuPlKPyljhNFtDY+T1/6P0KYkJB3B5wBh/Ybk8trdR8UcGMRAO91HyB2+aOyMkds59IztZNtoxY6lipU1RJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091790; c=relaxed/simple;
	bh=fsJbTM1nUA7ZmJoZZbS9jA70kAf2HF/itnbUmNxF1Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SdvDVnKs99cLF5llFkv5DEKodoJwekkAsHTIw0hypA30uAON3O8cYxPuLBVH2x0YnGP9udr6sBPlXLiICtpraFMom4d4GYp8hdoOimipFJij0wJBPXCECBi50FCkeeAISvXVslS9CtDPAFktUmzsWCKiLLFpiv0mEEKBm6srftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k9c58aIZ; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8CF4910001E;
	Thu, 12 Sep 2024 00:56:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8CF4910001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726091782;
	bh=x1ZuLjno/PPN/Ymr/GiIARkc5oJZWRfhcU1ulFV49j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=k9c58aIZGLL4IlOuz2o9NYucPfT6GI9nf1lCXOkvfmeEnU5wfr2F+Wvd85zKNz8FK
	 e4sTJ0DBdtSfs7rGm+dKaPShDV5kr9gEhofFg5t/04OP8Lofpb7H2kf3TfES6S6bZH
	 isX1DhhkHjJkqCP6dkUj7YvEWzECO5YxxFXGdRvHIVYcbKocOxoQ7FLBpIbWxHwXfV
	 idddSgkd8sCu4Zn1wqJpmEb27gdo6av0yBbndCRsiyIEpUpq9B5UqgVZ8qUNuZSzEh
	 BxSQ+avyCkjB0Ekp7ibbS8N4D5WZVu31w4rC6l7Qst5j8BXcgMuphynf1eBAzxTaEV
	 RhOYOzIAmkmBQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 12 Sep 2024 00:56:22 +0300 (MSK)
Message-ID: <26ab17bb-1b2e-4144-8a34-696a92328f52@salutedevices.com>
Date: Thu, 12 Sep 2024 00:56:21 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] amlogic SoC's power-domains fixes
To: <neil.armstrong@linaro.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <20240710223214.2348418-1-gnstark@salutedevices.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240710223214.2348418-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/11 19:53:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/11 21:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil

Please take a look at this series. It's 2 months already since ack

On 7/11/24 01:32, George Stark wrote:
> Here's some fixes to the bindings and device tree related to Amlogic A1 SoC.
> The SoC provides dedicated power domain for for almost all periphery.
> 
> Changes in v2:
>    dt-bindings: spi: amlogic,a1-spifc: make power-domains required
>      - drop the patch
>    dt-bindings: thermal: amlogic,thermal: add optional power-domains
>      - drop required conditional
>      - rewrite commit message
>    dt-bindings: i2c: amlogic,meson6-i2c: add optional power-domains
>      - add RvB: Neil Armstrong <neil.armstrong@linaro.org>
>      - add RvB: Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>    arm64: dts: meson: a1: bind power domain to temperature sensor
>      - add RvB: Neil Armstrong <neil.armstrong@linaro.org>
>    previous version [1]
> 
> [1] https://lore.kernel.org/lkml/20240708194808.1819185-3-gnstark@salutedevices.com/T/#m398c283b369108c5c557e68b7a1ada9abf3e5cba
> 
> George Stark (3):
>    dt-bindings: i2c: amlogic,meson6-i2c: add optional power-domains
>    dt-bindings: thermal: amlogic,thermal: add optional power-domains
>    arm64: dts: meson: a1: bind power domain to temperature sensor
> 
>   Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml  | 3 +++
>   Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 3 +++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi                      | 1 +
>   3 files changed, 7 insertions(+)
> 
> --
> 2.25.1
> 

-- 
Best regards
George

