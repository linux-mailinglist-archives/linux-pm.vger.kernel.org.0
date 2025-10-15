Return-Path: <linux-pm+bounces-36205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9463BDF832
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65A86353560
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2DC171C9;
	Wed, 15 Oct 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="imsDHgQS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179C24C68B;
	Wed, 15 Oct 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544076; cv=none; b=JaRce2+wrQTAbrG9m2iSeFsNMtd+JPGsg+W4czmgVKjqRWXGKCsh3NE5YTuKaFW0bX0DD90BVO+dT052V7GLJ5+8g48kL40+nrT8OULiIm2GETYUlf2j5YKhHsnBwY/P7tSsPyjjWxzrzsOY599rrH4pDZjomRDUjQx7wUVjNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544076; c=relaxed/simple;
	bh=UQTEZ911XZeuhbCj9gZ50FkUCFvSn91ubLY7CJkjBXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igii8T1fuZkfaFp08QTFhwSLva+oPuiGNxN4FIdb3lvglnppdp3aHc6+nu89YZQdw35YB7xE9fKfF2QDeo1duYU0WsRAdpV8I8vgUH86ZfrIMC8aUsJRwzQ14D46HGrh1Tb2VyCrXnR08dI2ypHn8JLm4vrDHn/TULqwXngC4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=imsDHgQS; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cmwmk5F6hz9spd;
	Wed, 15 Oct 2025 18:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760544070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfKSpKIVO7I0L86wsZ0n3KPK8N8SS9osaEqLydoksXU=;
	b=imsDHgQSczBQlzJcxSqn+whUjXlWMC98vq4E96KYO2SGuA77QLxYdI/ktl1Ig6kV/cc08a
	h2rk/EcCUZJRH11bdiGJuMKm5AJfQGec6CIUMfGkEkkngJgAz5Zgq4W2g2147qfS2gZuk7
	0mOPnwFcJGjxkZq2NkxADDi2BUF1DMxdaw6VhOFnCydvDkN9if0pTcSpt/0uE1qym20xwv
	bE6DVwvmoaKBP0vw3nT/ioV3R/pMdSpcn7cP2jAm45qI0q+zBCPtk+qpkrEw4xh1fyUqOh
	VDtuWn8RWJ1IWs7e7YO2WplQBQHbF8+TErg9kHAw/48eDZxAgKDZD4Ng0+iIDQ==
Message-ID: <3c82d398-3486-47f1-bef7-e6edd8c18ab1@mailbox.org>
Date: Wed, 15 Oct 2025 18:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in
 driver comment
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>
 <20251015155821.GF439570@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251015155821.GF439570@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 031ddadacde9c6965e4
X-MBO-RS-META: 8fpeb67khun4w8qayuad86hkeafdbys8

On 10/15/25 5:58 PM, Niklas Söderlund wrote:

Hello Niklas,

> On 2025-10-15 16:09:51 +0200, Marek Vasut wrote:
>> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
>> Update the driver comment. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lukasz Luba <lukasz.luba@arm.com>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>   drivers/thermal/renesas/rcar_gen3_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
>> index 3223de238d014..a143b087a8ea7 100644
>> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
>> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - *  R-Car Gen3 THS thermal sensor driver
>> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
> 
> Super nit: I would write "Gen3, Gen4 and RZ/..."
I just addressed that in V2 and sent it, can you please add the RB there 
too if that's OK ?

Thank you

