Return-Path: <linux-pm+bounces-21654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A7A2E616
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4DC3A16B6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C91BD4E4;
	Mon, 10 Feb 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx287jsE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978D1BD00C;
	Mon, 10 Feb 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175130; cv=none; b=S66b4QUMuqVVZ+/2kR5/mjV0sUJ60HtTSQtpBscDr67G65cEFFWMrJ93H+z9OvEoaeSKfSa1nDW6S6lL2G5o8/iOjRd5kfvNAdqCFLvwXPYs3sVhm8LZ1IgEoQM+HbQ009Y6hO1ycGIEkWBdORCvi2zHBO5f/OyJrxVz9JgIqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175130; c=relaxed/simple;
	bh=s/wEQHp9D4HLcuK43KrByU9JTfmtEf3h3muu17wBL+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oX2MkmyWCXWtBQc1ird/4SJouVgVkOwp/BpZhIU86BIUjZv1HcirBLc8bxGGOEju+KTWHlYuvMO34BQBxEuA0Hu40mWWIZG9eANmOiliyFXT2SOvq7zXwU7gLR6ul8HunD54ZZVRFTg+m4XZ6T0OX86XiYh+Qpkd+P2BEvShTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx287jsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DA8C4CED1;
	Mon, 10 Feb 2025 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739175129;
	bh=s/wEQHp9D4HLcuK43KrByU9JTfmtEf3h3muu17wBL+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fx287jsEyQasQIyD4qa+rI97L+iVffHU9GlRG9zDZciMWXk2FiKEweFtBbFb7RrUe
	 O5o4Zz9RPrKVFIRmtbkk3QXvTy9HkhKX8x20IfQRfw0xBoCuGg/BVSSRMa0aGzhk0m
	 DGc1paLZ4xUh4N1ZSQayQ6wxWIHN+dW0RFgub6xPLl9V2rnxCuyUTHGoZnO1ShW4mE
	 SqMHjT3oFwULCgZAHnQyOEv3aArnEqhaxv5C4C7ZS5pBmTuSoO/2P6cAJonjMh/OgD
	 hpTMto5BG3SKKCIj/prGxIcSiH8COi8hohTcTWvVwBqBS7ihFMuQa1xB8gZLpsulI3
	 NVqzN6Xn+B0Xg==
Message-ID: <3e69dc53-cf05-479b-9707-eabc2eae9291@kernel.org>
Date: Mon, 10 Feb 2025 09:12:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patchset status - 'Add support for Maxim Integrated MAX77705
 PMIC'
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <CABTCjFBx-QpCKFWs5MPCgLAjJWT6ygrvS_A0nJk2BBxmWAxF+Q@mail.gmail.com>
 <e67c0375-1024-483b-aabf-6a11339ab9af@linaro.org>
 <CABTCjFBvYkEG0WYhCt6tP_cO8Ct82t0=UhwBefZEJrUiFc7vAw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CABTCjFBvYkEG0WYhCt6tP_cO8Ct82t0=UhwBefZEJrUiFc7vAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/02/2025 08:11, Dzmitry Sankouski wrote:
> вс, 9 февр. 2025 г. в 22:38, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
>>
>> On 09/02/2025 15:13, Dzmitry Sankouski wrote:
>>> For the patchset I sent 2 weeks ago, [patchwork][1] shows status
>>> 'Handled Elsewhere, archived'. Is anything blocking it?
>>>
>>> [1]: https://patchwork.kernel.org/project/linux-pm/list/?series=927848&archive=both&state=*
>>
>> That's PM patchwork, not necessarily power supply. But anyway, what does
>> the cover letter say? Who do you expect to merge it? Above link does not
>> provide cover letter, unfortunately.
>>
> 
> I didn't found anything related to power supply in the list of mail lists at
> https://subspace.kernel.org/vger.kernel.org.html.
> 
> However I found my series in linux-input with New status.
> 
> Here is my cover letter:
> https://lore.kernel.org/all/20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com/


Nothing in cover letter gives any expectations or directions of merging,
so maybe that was a factor here?


> 
> I guess I would expect a person from the MAINTAINERS list to merge it?  In that
> case it would be Chanwoo Choi <cw00.choi@samsung.com> and
> Krzysztof Kozlowski <krzk@kernel.org> from
> MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS entry.

Haha, nice! :) There is no such subsystem. This cannot be taken by these
maintainers because there is nowhere they could put it and no one would
take it from them even if they did find the place.


Best regards,
Krzysztof

