Return-Path: <linux-pm+bounces-13840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21619702CA
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB061C21CA8
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310115DBC1;
	Sat,  7 Sep 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="n8Hp9Z5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484328FC;
	Sat,  7 Sep 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720412; cv=none; b=RhlitEeaJ+1FBHXMD4dSozA+6PolRAtK0S1bdCMHhnJNEEmgR6uLTuYKD8mG541W6+S5uvj6cNq3ayBj8aEHyohjYJphCR7NkjyIgKKugpfT5SxqtHXmG52YHZLaYKr9h0cWSvC9Uf/i+uG6fwe9PFD4plT82QhcNwDEeppDn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720412; c=relaxed/simple;
	bh=NHJ0+sU2adxTEFbuq/grgcIZX4veA7f7/RBQCE56QVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFBu5aKcFG3nAt01tvYdLbXJJpCVJ4zZ7yyYmYOTsplwq4ptMFoa8MlrY7l0igbUyZjbZ/hLlkRnzW77NNz1haEcosyHmOJ0qm/CTzhRJvzCdOeNrOqecTlEVh99+Ja92OVA3MTb027HEWc9mkBoFeeq5zzfLjeJesqoTYAJoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=n8Hp9Z5I; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 0FEC078A04;
	Sat,  7 Sep 2024 22:46:45 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 0FEC078A04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725720405;
	bh=vEtoINhe3YqLp5wK8FdsELDTQbLLzWqrW7RhTNgkRsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8Hp9Z5I/WAxnS8iFA49TGS8ykMLsm9KqxVy18PU2SezXNKHTVWXySMyCtaJ53mg1
	 1YCUaNGuArthbZ8+SgcaTpf9kuLqLvaNUctnJP4ysI84mZraFdWDO3FuvOCP9fkoH9
	 xto2kSiaBr1njBrrCmT4EzHp6O1DKqANgjewI5JY=
Message-ID: <9051dba0-0483-43dc-9e5d-d19500c019b9@classfun.cn>
Date: Sat, 7 Sep 2024 22:46:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
To: Markus Elfring <Markus.Elfring@web.de>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Junhao Xie <bigfoot@classfun.cn>
References: <20240906093630.2428329-2-bigfoot@classfun.cn>
 <d79dbfae-d50b-45e5-b430-be8106bbb03c@web.de>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <d79dbfae-d50b-45e5-b430-be8106bbb03c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/7 16:10, Markus Elfring wrote:
> …
>> +++ b/drivers/mfd/photonicat-pmu.c
>> @@ -0,0 +1,501 @@
> …
>> +int pcat_pmu_execute(struct pcat_request *request)
>> +{
> …
> 
> Under which circumstances would you become interested to apply statements
> like the following?
> 
> 
>> +	mutex_lock(&pmu->reply_lock);
>> +	if (request->frame_id == 0)
>> +		request->frame_id = atomic_inc_return(&pmu->frame);
>> +	pmu->reply = request;
>> +	mutex_unlock(&pmu->reply_lock);
> …
> 
> A) guard(mutex)(&pmu->reply_lock);
>    https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/mutex.h#L196
> 
> 
> 
>> +		spin_lock_irqsave(&pmu->bus_lock, flags);
>> +		ret = pcat_pmu_raw_write(pmu, request->frame_id, req->cmd,
>> +					 true, req->data, req->size);
>> +		spin_unlock_irqrestore(&pmu->bus_lock, flags);
> …
> 
> B) guard(spinlock_irqsave)(&pmu->bus_lock);
>    https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/spinlock.h#L572
> 
> 
> Regards,
> Markus

Thanks for your suggestions, I will try these statements.

Best regards,
Junhao

