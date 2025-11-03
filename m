Return-Path: <linux-pm+bounces-37283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB98C29FD6
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 04:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5051888386
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D731684B0;
	Mon,  3 Nov 2025 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="NmvW7J/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDA1A294
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141605; cv=none; b=LgL/B93D4Ik0Tq13+CcG4lRd6K+JFjUSbXQn2jQi48Cfdkf52d7YNG92EWZUMtlsHjeFS1BEhNyMLKvATCKIpE6lpG0BCsgQXF+SCT7gbig0KRDtmHVf206j90UWE+YV8NB7GD7DWkZIKUPRLcfAqWI/Du4GxwJAm8z1PIWbpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141605; c=relaxed/simple;
	bh=yUx/o+iM8bZDA46a4ngR/r4JqpMprbDWFyaV1v974xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kgwWdRKc+5R1faaw1znHoXKngIQzOU9b4ugj+tFg/IDoIczKZsSKGBj202P0qYJfiUcl+sVdybMW0LDEgXH+ubu5USL0B5xNp8llGfGTh6wHPEEsAttvb2WtKPMkXhwJxDFEdJuHSTH2cQlELlPizniTGaTcHT/5d2eSEQnrGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=NmvW7J/0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <8f003bfb-8279-4c65-a271-c1e4a029043d@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762141591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr0ikCBUo2Fu54QL3NUrxLxEo1BIiZlIC6veZgMQ1n4=;
	b=NmvW7J/0D68DT9PC8Wgy4wcDNbi3KsOvcGChZbs5V5yuDJaPzp+cBQIOOI8ctcIIIWCKSF
	VUh8PvSyltBt/EQ/GE2zz3N7nIp+LVCvWqI7f72RuOZzs6Mw0YEySufoVEXvj1KArUtHa+
	/Mhm0aJ8XQ03Rpdm8plVdLqMx00QKTfp8m9grhXmc5f6v6tYqrtHTDk8GzmSZxGRf6FBw3
	2IpZ+zXgA2MfKZScWG50uB3xk2KbsGH3sQrjmuZ+7jzYhX1A93RT2xTtWHdEjDujRHKdXN
	C00FGIRc0/TOt3D2FXTSnhlHBtDCjLIqDIjrjv2gjgayn/ObA4YHMt7HP0Wiaw==
Date: Mon, 3 Nov 2025 00:46:13 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control
 threshold handling
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Fenglin Wu
 <fenglin.wu@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/2/25 9:48 PM, Sebastian Reichel wrote:

> On Sun, 12 Oct 2025 20:32:17 -0300, Val Packett wrote:
>> Currently, upowerd is unable to turn off the battery preservation mode[1]
>> on Qualcomm laptops, because it does that by setting the start threshold to
>> zero and the driver returns an error:
>>
>> pmic_glink.power-supply.0: charge control start threshold exceed range: [50 - 95]
>>
>> Kernel documentation says the end threshold must be clamped[2] but does
>> not say anything about the start threshold.
>>
>> [...]
> Applied, thanks!
>
> [1/2] power: supply: qcom_battmgr: clamp charge control thresholds
>        commit: 8809980fdc8a86070667032fa4005ee83f1c62f3
> [2/2] power: supply: qcom_battmgr: support disabling charge control
>        commit: 446fcf494691da4e685923e5fad02b163955fc0e


Woahh.. please revert the second one.

I'm sorry, I thought this was discussed here but apparently it was only 
on IRC and I must've assumed that the patches weren't going anywhere 
because of the lack of R-b..

The disable bit was acting rather strange after all, we'd need more work 
to figure out if that's even possible. Let's leave it at the clamp only.

~val


