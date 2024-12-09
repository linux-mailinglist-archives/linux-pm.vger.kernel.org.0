Return-Path: <linux-pm+bounces-18872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC969EA26E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65A31887527
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590C19E99E;
	Mon,  9 Dec 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="B0hds9hB"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA719E97C;
	Mon,  9 Dec 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785817; cv=none; b=vGebEj1Eo+6nw5n9YK9purQx1OtH4TYR3iYRzbTAGHOlmgbl9xZyMiz2z+9mbP+7UlwNMy58x2VGv+QDH4gTnS5KL+BpcwXCaTVAdRO2QR0VIzAmLDnJpXY5BhwGl2BLzNuTsLMnkJCn+WFSxPKzdtVoDCwmCP7v/EMSTHFuvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785817; c=relaxed/simple;
	bh=urlerA32FeBNEhOin0VW4iTS7QRr2BiUyd3+3ETar70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GgXa0XMIh0hT3qUThBYqQdnpy8tIIMYdURa+y1S5T3B0hpbXgnp8yRXRpWd3xhS1ZbemCD6sZPfXTxtxwLAOefH/q6En+GI7U81gsqiOuJDOFaRUbHWLQ1uMsFPo52trJ/45rmeQQYlKPtaj0gImhoCxzkQeWq1V/R0Y9HqdEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=B0hds9hB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D3067A0361;
	Tue, 10 Dec 2024 00:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=OLhLfksWWgmds5VMRiED
	a4SIvCz7NIL/9DfCWi5eIJw=; b=B0hds9hBsDDkMvjMKQfhPmM84mgLKYI+mV4x
	T+MHY+rzU+ayB4MAgCuRzTwAvP/UYe6/NuKLjs3MaHWjAvA7i77HlfiU/ecvfMuI
	4v/4F4XD3EhZAWQ4ElrW7BktgddsmLm5eGEhARyXBg2ElfUqutUy8rapsyrCjGUR
	8nSO2OQYq2aNK4PY5ExJT/oRpja4QmFJHXROyE74YsLMx560JfJSbl2puZO8QIOx
	BtkxmQWwXg5XVY+n77sroWRa+iiCsYwhq4m1Ofm0B4/p9InifeZq2QkbebooOZ+Y
	QNx+sMCSKlqSb2fZmd1vZbegQNk5EjN5RoPLvuCZgGMT26eBl68WfdQWDkEkmrwl
	b+3scO9xBeTbynk1YlyteRrlSXH6iGKxw/jwytEnLPW2UG5AmGQQ6Yx2mIuYN3Ss
	NZh8Cd5+zwukANmRVb3tC6PLmtNXtFOkWnFgaPqsLCex31Hh7i4U9MK6s2PZjNzR
	1x8H7zcAeQwiJiy6+xlZKRNZ4P5DRLuQ3ylVW23wJRODCSZFzgTvGomam5RXcsTR
	TFUejh+vBageCdaIfEBr7Fwavr1pWTmkhfO3313Q7ePnw+RJk+vtFn0033HXkuMN
	q7I2VqFYo77ezS199m1iiX9bBSiQbyeP48LSbWpEMU9N+JVbHOhpaCJ9VZrgpbJ1
	RY69u+o=
Message-ID: <4e9be877-0cbd-4794-9601-39721ca9b698@prolan.hu>
Date: Tue, 10 Dec 2024 00:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: Fix uninitialized variable in
 ip5xxx_battery_set_property
To: Karol Przybylski <karprzy7@gmail.com>, <samuel@sholland.org>,
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>
References: <20241209212323.71228-1-karprzy7@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241209212323.71228-1-karprzy7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627067

Hi,

On 2024. 12. 09. 22:23, Karol Przybylski wrote:
> The variable vmax in the ip5xxx_battery_set_property function is used uninitialized when passed to switch/case statements.
> 
> This patch initializes vmax to 0 at declaration.
> 
> Issue discovered in coverity, CID 1602239
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>   drivers/power/supply/ip5xxx_power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
> index 4bcf0ea0e..65d3266c3 100644
> --- a/drivers/power/supply/ip5xxx_power.c
> +++ b/drivers/power/supply/ip5xxx_power.c
> @@ -541,7 +541,7 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
>   {
>   	struct ip5xxx *ip5xxx = power_supply_get_drvdata(psy);
>   	unsigned int rval;
> -	int ret, vmax;
> +	int ret, vmax = 0;
>   
>   	ret = ip5xxx_initialize(psy);
>   	if (ret)

This is not the proper way to fix this. See my patch below.
Link: 
https://lore.kernel.org/linux-kernel/20241208131532.1028581-1-csokas.bence@prolan.hu/

Bence


