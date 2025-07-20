Return-Path: <linux-pm+bounces-31110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D1B0B5C6
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A806C17BCE2
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A920485B;
	Sun, 20 Jul 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxCrWSQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F21D5ACE;
	Sun, 20 Jul 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013473; cv=none; b=L76U80jgc0xVabzlqE5hh9+CXZVVcaRr8V+E1VZOTsBvIYfSNT8w1xWAFdjZlBspq9+87Fipk8eHvH3qwxhaBZ66flZ2RKYVlZTD8RR0LextxKOI/bOGPEQMmIi8sCm3E72mE7yj6s7lD1oA8iB2IY6mb1qKUs3HwpLcj7gctt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013473; c=relaxed/simple;
	bh=MZwQszUH3PF/So1Em/f18h0ala3qC7GcHPl8KVo1lcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7EzvmG3fyNUmOT5BYiK0i+Ese5bkPNstNLW7Qg1oh4arRoaQ+FSIDF3Xi/GE4j2ZUBtwGvZJt6QaUwe/SLoiQox7bK6zIH2KXo8KBGTnw2Z39I8qBF7qPap8g/StJa7LDbgelfTq6zRgQAv5Z9Z/fyPoCSR4lC6/oV6Bt2mVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxCrWSQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6681EC4CEE7;
	Sun, 20 Jul 2025 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753013473;
	bh=MZwQszUH3PF/So1Em/f18h0ala3qC7GcHPl8KVo1lcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gxCrWSQgaMgOKax1iENySyqGpWXXcbFVmHg0P1y2+inKSXXlOfR/C0Fj4tOvxs5+K
	 RJyOPemUa/w3/M1eNLoEGLH4zKyyMn3N6vUFKngwrKciPNkeJE2Q1NqSSNpWL/d6z1
	 aff2lZfVsHsCbSgIiCbXHukPjZq/4atvY2RgicutZIlwEZODM5ehkBlBj8C4VtdQQf
	 4TnDICR8g6DL7xKBICvnXjg2xiC/6W6oPzuIroCkCdKqYNi/y5Bx9MZh3qWqu1lRVD
	 gkAOFSkDn4ma1wCbXKs7i5VNa9zaxnIqfOkf8dO1iD/twi8A/uuZwAyRYigbgmKmUG
	 cFTJ+lje7nGLA==
Message-ID: <1ea2d93d-1d24-412a-96c6-f0285de554e5@kernel.org>
Date: Sun, 20 Jul 2025 14:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] gpio: Add new gpio-macsmc driver for Apple Macs
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>,
 Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Conor Dooley <conor+dt@kernel.org>, Janne Grunau <j@jannau.net>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org>
 <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
 <CACRpkdZdz7eHVjgX-X_UwjJ_qSu5hSPeocuQ9DWSiyjNLU5AmA@mail.gmail.com>
 <CAMRc=McNK3fmbP2UON0EGkjM6gH_1zSHFr_PzZ9JhR7a5swLQw@mail.gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <CAMRc=McNK3fmbP2UON0EGkjM6gH_1zSHFr_PzZ9JhR7a5swLQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.07.25 17:52, Bartosz Golaszewski wrote:
> On Sat, Jul 19, 2025 at 5:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Sat, Jul 19, 2025 at 2:59 PM Sven Peter <sven@kernel.org> wrote:
>>
>>> top posting on purpose: are you fine if Lee takes this commit with the
>>> rest through his mfd tree?
>>
>> Bartosz should answer this since he's dealing with the merge
>> window for GPIO, but generally it's fine, and it's even using
>> .set_rv.
> 
> Yes, for sure. Lee typically provides all interested parties with
> immutable branches after picking up complex drivers like this. I

Ah, perfect! I didn't know that.

> already reviewed it but for the sake of completeness:
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 

Thanks a lot, especially for the fast reply!


Sven


