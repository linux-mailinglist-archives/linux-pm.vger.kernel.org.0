Return-Path: <linux-pm+bounces-34708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A17B5903B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599101654E8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFA2641CA;
	Tue, 16 Sep 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VbQXZaum"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561928467B;
	Tue, 16 Sep 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010709; cv=none; b=I5n/HwnZYYgsRAspZVOB7l7WI1YyQN5xyeKGDvaYuT0Zsi4ICOF50vs638z+MMJdsiXmerJ+4g0sqtrvKzbvdMsN6mDviQQD5a21IUqlEt0MWdzkVJgDRMvUpIpjdx5sGzn26zo4UQ7ZOzJN87sr5g3mhtwhNVHqZxaWWu0NpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010709; c=relaxed/simple;
	bh=TmqQY6BbZjKaQA1hi6SW+pBZMY/quwU3/0S8doXUFiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCNyYtxE9n+AYssmQHv0WIjdLKa62SRaPa9NsJ3hGJHrK6I+994YxyjBXePLPnHV4vdmXmuY84JpL+T5b+GU3bGz7wERsPenmVW0VL8JDijgG+YIM/Od8TmWi/x3Qf2BafsXpH9u+jjgzMSAcgxUgj6M3edyhsrv834RphonXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VbQXZaum; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cQvt75Jvsz9tgv;
	Tue, 16 Sep 2025 10:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758010703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqXqKCY0qebI5fxiZNfbPweUXhgaa6GZB+v8rBjD+RQ=;
	b=VbQXZaumHCFgUdGJO7CopdN9wPUNt1ZtzdgRjKXiZCjh677REUkO+9tS3iT9gppvtgM+zQ
	zCIcRzhkgrE23Wl405TGELiLqu0wfVCZyd0+GkrDRTkFc1RY7CskMCkZ7AbdsS+5FtT9nh
	gV28jILyL2urq8ptHF22SNJv0+LIheCSotFEyuVZ7gZL2QuT2hkHVJOaPAqzqDHnodmdLr
	TSP4tLyzu/zJgTE+M94eRYksUByQoPds42cIP2WxcA7Lk/DdNg3RHrlyKUTxL6yB098mlN
	A/zFzCnrVOaVRZEhS7hnA1QZKDUrAQ6iDTdzLmrZFuHpngjlq4s3A4TVnLKy6w==
Message-ID: <89957015-5b28-4fb1-8218-5dbdac2b009f@mailbox.org>
Date: Tue, 16 Sep 2025 10:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in
 Kconfig entry
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20250905193322.148115-1-marek.vasut+renesas@mailbox.org>
 <20250905195904.GA2033628@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250905195904.GA2033628@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8f5999ab8efe036ee83
X-MBO-RS-META: 7dzdwda8t4qn4y3dd38ksepxumxmn7qc

On 9/5/25 9:59 PM, Niklas Söderlund wrote:

Hello Daniel,

> Hi Marek,
> 
> Thanks for your patch.
> 
> On 2025-09-05 21:32:56 +0200, Marek Vasut wrote:
>> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
>> Update the Kconfig entry.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
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
>>   drivers/thermal/renesas/Kconfig | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
>> index dcf5fc5ae08e4..f4af8c7f28b05 100644
>> --- a/drivers/thermal/renesas/Kconfig
>> +++ b/drivers/thermal/renesas/Kconfig
>> @@ -10,13 +10,13 @@ config RCAR_THERMAL
>>   	  thermal framework.
>>   
>>   config RCAR_GEN3_THERMAL
>> -	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
>> +	tristate "Renesas R-Car Gen3/Gen4 and RZ/G2 thermal driver"
>>   	depends on ARCH_RENESAS || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	depends on OF
>>   	help
>> -	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
>> -	  the Linux thermal framework.
>> +	  Enable this to plug the R-Car Gen3/Gen4 or RZ/G2 thermal sensor
>> +	  driver into the Linux thermal framework.
>>   
>>   config RZG2L_THERMAL
>>   	tristate "Renesas RZ/G2L thermal driver"
>> -- 
>> 2.50.1
If this is OK with you, could you please pick up this trivial fix and 
push to kernel.org, so the other trivial fix for rcar_gen3 would be 
included in next ?

Thank you

