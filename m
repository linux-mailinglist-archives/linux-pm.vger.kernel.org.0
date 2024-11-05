Return-Path: <linux-pm+bounces-17037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD69BD767
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC5FB22A87
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A5215F43;
	Tue,  5 Nov 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ukAkUHHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D7212176
	for <linux-pm@vger.kernel.org>; Tue,  5 Nov 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840707; cv=none; b=PRsvrLLXvVRfUFJvzZpZ01dNuzoNGGfbO1/V3fbUzUsIxvvXN2tl6YasYs1HAz2gMOa6LMndwmhk8cDUTxoNd1EBaQ4Zbdo6aEOphgT289qg42Qy50euPZ6zJ2Mae+ToEDv1w9EGBpwgiyu9z7LjWDPQsagGjxRhICfBbjE3lU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840707; c=relaxed/simple;
	bh=UQfvUdFrVo5aH/QZvzjkC7O7gnD46k63TuIZT1hVGXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxCFRmN45fCn/zMk6Pvxtd1NTZA7OquCTmxg9XBVhjgYsyD7x2U41qNSMZ5KwkHddjuIC31djN/csH/8nAXHZhS0FyusAXZsCUFAVENOVk76szGQ9bx7PGoWRHH/b9TwFRoRYsjxRFJ6lFVZoerYMtvLXJQXgPu+OvxpTwDpG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ukAkUHHv; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7990B2C0272;
	Wed,  6 Nov 2024 10:04:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730840696;
	bh=UQfvUdFrVo5aH/QZvzjkC7O7gnD46k63TuIZT1hVGXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ukAkUHHvH2COem8vesejOJN31915RwqRmJ+2G/1z6Vp7fuueXY2LdGxL1j505kALD
	 Q2uDQHDs4tvGAp0opBriY0S7WhDQy0ocIxnGmZXzE/aKgcAofX6lDBGzUg+knTXT8Y
	 ObAt6jrR7rcEVBRCgcbN74bKuG4MW5tm9XMCkSiXrcCGz0dDeUueJhKGSiB9HI4gCf
	 bVXlUVyosSX/o8g9OBAZtYt3ybMisRYPM6DUeX+mGUkCKWojtViKYv2T1jzGl5J3nS
	 I6X918EHmdXoCusL4ZN2qts4pJTTJscc2xtVvUdXLIS4+GxPt5CIv05Lunhv936WIg
	 rYuf+6Yi8EC/g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672a88780000>; Wed, 06 Nov 2024 10:04:56 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 5693413ECC4;
	Wed,  6 Nov 2024 10:04:56 +1300 (NZDT)
Message-ID: <cc0d1958-ae0d-4181-a8e7-98d852b6a1b8@alliedtelesis.co.nz>
Date: Wed, 6 Nov 2024 10:04:56 +1300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 3/7] dt-bindings: i2c: Add Realtek RTL I2C Controller
To: Andi Shyti <andi.shyti@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 sre@kernel.org, tsbogend@alpha.franken.de, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org
References: <20241031200350.274945-1-chris.packham@alliedtelesis.co.nz>
 <20241031200350.274945-4-chris.packham@alliedtelesis.co.nz>
 <sb3wucuqqyzuaebynxce7btsc2sn2j4i7tpx2ukxtx3bbf6frb@ta6oj35z3w3m>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <sb3wucuqqyzuaebynxce7btsc2sn2j4i7tpx2ukxtx3bbf6frb@ta6oj35z3w3m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672a8878 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=KKAkSRfTAAAA:8 a=YErObtgtbTEl6_bwWHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 6/11/24 09:59, Andi Shyti wrote:
> Hi Chris,
>
> On Fri, Nov 01, 2024 at 09:03:46AM +1300, Chris Packham wrote:
>> Add dt-schema for the I2C controller on the RTL9300 Ethernet switch
>> with integrated SoC.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Agree with Krzysztof's comment in Patch 1. Please don't send
> merged patches.

Yes understood.=C2=A0 I'll avoid doing so if there is another round (I=20
haven't heard from the mips maintainer yet so there might be feedback on=20
those 2 patches).

> Now this 3/7 patch is also merged to i2c/i2c-host.

Thanks, much appreciated.


