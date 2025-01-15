Return-Path: <linux-pm+bounces-20471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12784A11CF8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 10:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13E6168EBF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7711EEA3B;
	Wed, 15 Jan 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YwUsiqL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478D246A10;
	Wed, 15 Jan 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932157; cv=none; b=SDciiV0AaMUkHFlI4zHdGLnCyjCuYsTpUBG9A3gcnyjOE/e5NA/FP2h1mS8zFLNoEn2guPyQ6CccSGPNzIbt+jC2HcqaL3Pjn1deTFCRpi2f2gyIhXnOS46468h8dxgQpf504W6jz2CYuAZOmKTTB+rBDBBXSRoIc92lvOs4+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932157; c=relaxed/simple;
	bh=jzVF8QKbSKlwNeLM5JaEErE+5Hfuig0I3TmeMB+qegc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cZ4mnvrKBjHrjKpzwJfN7Q4jAuzZHHgZ2LfpmfJokjsL3EAbFrm9/ZQ64+h9E1oHzdaSqfa6yyVrJhF+4waSbuBjP1NNfAw8vooNvxnw12Dhc6ZVSpXJq3RBWVX/OFSNuvnIdTl7AsC7ENOqYSHFXLMtCCKLNgwYjz01nJiGNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YwUsiqL+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4F1A8A0A27;
	Wed, 15 Jan 2025 10:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ssZI86T0A6XNN8hCXgMu
	MZMsnzteKeFLGvw1TpMOAQU=; b=YwUsiqL+mnfGUW9j8eGYD/GWnYrYU4Lh23/R
	Gk2lpKqoAoqRGyrHg00ogMYZOT6rBU2nNA0yllC476j3q3fUoYLJVNemN00UpP4s
	RNSd3MN5utnVTVpVHhRiW7g18Rxvg6cg5Mbi0igsJ8aqMJi2LKMdPOWddsY+ja2X
	HdVuwqmRkFUNTRYG+1vhShK2qKRzlVSPpPbLn1PZT3aeK6GviuuaHTod48xGpBct
	xITp7DWK5gH6WgPA0466Hq4INt9RjJ3g9jWgF2DO4HcsvCXLUtYqm6VEJSF6skO4
	QKwbsuC4d9czkpAnsIVGSJP89jgtxCsPE33/NZJaQbojtYFP5lBO/LYuskWxvMgF
	L+IEVCzwQZ8fR5S7OdoyPZNYIudOpxHv82EgdF5wm/maN/qVoKiD6Jtr/4cSHgyp
	A0d/IluO1KZddaESPZPCepvmVGSG8fa7b68lneLzG4o93UIraCbzM6rDLsfYHMtg
	lpWj8ZVDnG6zZDLoLifMkms32GIpx/DhARP/Z8rZ3YYdqa0ClqgGgmZVhYHHRiLK
	Xglikd9s9lg4opobT3B+ruWbtNC7nBY7dr1DfKu4PDOZqXWX80G3xcgPLCmXTtq1
	pl4P9NrgOy1MtsywyJ4vVaQqbvy1t76OTxyKF32tbGpRU0vliKNBQ5DbgD/jZTwO
	3/JuGtg=
Message-ID: <81cbb273-a4b4-424c-9d25-f53ebc8ea82a@prolan.hu>
Date: Wed, 15 Jan 2025 10:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] ARM: dts: sun8i: add DTSI file for V853
To: Krzysztof Kozlowski <krzk@kernel.org>, Andras Szemzo
	<szemzo.andras@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Chen-Yu
 Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-13-szemzo.andras@gmail.com>
 <ff57cf8d-626e-4d35-a18f-1a89b4d9fa3e@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <ff57cf8d-626e-4d35-a18f-1a89b4d9fa3e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852647063

Hi,

On 2025. 01. 10. 14:58, Krzysztof Kozlowski wrote:
> On 10/01/2025 13:39, Andras Szemzo wrote:
>> +// Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
>> +
>> +#include <dt-bindings/clock/sun6i-rtc.h>
>> +#include <dt-bindings/clock/sun8i-v853-r-ccu.h>
>> +#include <dt-bindings/reset/sun8i-v853-r-ccu.h>
>> +#include <dt-bindings/clock/sun8i-v853-ccu.h>
>> +#include <dt-bindings/reset/sun8i-v853-ccu.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/allwinner,sun8i-v853-ppu.h>
>> +
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	osc24M: osc24M-clk {
> 
> Only lowercase node names.

I don't agree. It is customary to write oscillator names with casing in 
line with the SI prefixes of their frequency, i.e. lowercase k, 
uppercase M/G/etc. (even though a millihertz oscillator rarely makes 
sense, it is best to stay consistent).

Bence


