Return-Path: <linux-pm+bounces-28440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CFAD4BDB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C146C189BC3C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 06:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92722A7E7;
	Wed, 11 Jun 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMnm/M/o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685122836C;
	Wed, 11 Jun 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623844; cv=none; b=BIxf/pNVtUH9getPrNTGG2unT3O4JPPEEF9454W2qadh5xannEjoSFMmiJkSYRYs+2MWa09m34F9GXzVvqsnSjO1VYUYfUl7QfgtRMPuQHXO/F5KpKnGHy9Rh8ZMsGur8gR/Mw4p69O+6iqKvHAO1qSRUxTql3fW7ssqWrUybY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623844; c=relaxed/simple;
	bh=U7VDunRvN8u8DkVZV6Ke1Eo1fqlAPBr5nu0BkTBzL6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2N3IBCbBR4RRsP1kQ+PhQWJzV1SDiIUArDRXNhVBk+BHC3VVJIZJFPw4ynLH4ZKlDh2Mfd9XK/ZyQ5LSGMbl0ev6DCcIcLl8GwQMbxwEGs6hP9fsyh17ZxThNpzLxzECfUL6yzmvbNQBnDWNDZZxBaiI++nOyF7RdN+0Z7okJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMnm/M/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48236C4CEEE;
	Wed, 11 Jun 2025 06:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749623843;
	bh=U7VDunRvN8u8DkVZV6Ke1Eo1fqlAPBr5nu0BkTBzL6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMnm/M/ofWvG+gj1RXzMIXoKZooRqMD1QiOM9V05tTiLItocHaLEd91kfr5CuT75p
	 UGIX5Ay64buKfThuLveRzlTFEemtYM3LDDRawZlwyYHl7wEBjpeaY6d9kcQRwvxQ5a
	 jRSnxyVITOIzfmMI5Zl+8+GS0KxrCflCzAPzWUI915UuFvw8n+cKmIk29ncQrc/DP3
	 ceyc6zqgYSsdXAAg50h6XJTfYXM4g8sw1+uJQCMTy+XMAwSMt0prenNtyiAfHmeJd1
	 U0hvsTK/Znl81YAizAxFKa+UN5V4EZskJIuAVzSmiftyrWlTnANE/Zi1jPvvWOxepF
	 N0eQiRRX+5KVQ==
Message-ID: <ad367080-5863-4131-b395-b39e2d357fb9@kernel.org>
Date: Wed, 11 Jun 2025 08:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: Use str_enable_disable-like helpers
To: shao.mingyin@zte.com.cn
Cc: ulf.hansson@linaro.org, changhuang.liang@starfivetech.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, heiko@sntech.de,
 alim.akhtar@samsung.com, walker.chen@starfivetech.com,
 sebastian.reichel@collabora.com, detlev.casanova@collabora.com,
 finley.xiao@rock-chips.com, shawn.lin@rock-chips.com, pgwipeout@gmail.com,
 qiu.yutan@zte.com.cn, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, yang.yang29@zte.com.cn,
 xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, ye.xingchen@zte.com.cn
References: <202506111010521118VJaiO_pb0rD7b3daxqox@zte.com.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <202506111010521118VJaiO_pb0rD7b3daxqox@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2025 04:10, shao.mingyin@zte.com.cn wrote:
>>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>>
>>> Replace ternary (condition ? "enable" : "disable") syntax and ternary
>>> (condition ? "on" : "off") syntax with helpers from
>>> string_choices.h because:
>>> 1. Simple function call with one argument is easier to read.  Ternary
>>>    operator has three arguments and with wrapping might lead to quite
>>>    long code.
>>> 2. Is slightly shorter thus also easier to read.
>>> 3. It brings uniformity in the text - same string.
>>> 4. Allows deduping by the linker, which results in a smaller binary
>>>    file.
>>
>> So you just taken everything from the same my patch - even entire commit
>> subject and commit description - and sent it as yours?
>>
>> https://lore.kernel.org/all/20250114203547.1013010-1-krzysztof.kozlowski@linaro.org/
>>
>> oh my, if doing EXACTLY the same keep original authorship - the From and
>> Sob fields.
>>
>> Best regards,
>> Krzysztof
> Dear Krzysztof,
> Thank you for your suggestions. I have carefully read your advice and
> made adjustments to the patches accordingly. I used your patch as a
> reference standard, not just taking everything from the same your patch.
> 
> Based on your suggestion, I have consolidated the series of patches for

I did not suggest to take everything from my patch, add one missing
change and use as yours.



Best regards,
Krzysztof

