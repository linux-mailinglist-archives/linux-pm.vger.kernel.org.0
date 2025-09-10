Return-Path: <linux-pm+bounces-34372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D0EB518DE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1670D465097
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACC320A23;
	Wed, 10 Sep 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUPJihnQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C4313263
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513226; cv=none; b=jS7aqAMmhUBFSq74MT3Yjn0hp9TyMS3+lEgCXk9jgP8/wlUCMc+Y5HvepcnO20EdcZUSlfryCjmEroQNM9VBIU5LA88Nva1RildEfgikyN2RwKFe3czYKmz0PfKchOUv3ZGTW709rQ9gM4btDPPqjX4NSMxx95BQjDabQbK7p0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513226; c=relaxed/simple;
	bh=BkZx6ICU7s8fX/L0ntxfxCcXLl4LVKiejzAU6fVQr7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUq0NtS/W/tx/G7MvGRrAQ4/7XtThM9tYTfBtUg7t1XwwuTqsdrULHeha38BfyH05oLgqWpzEdKNzhbF1gRVoO+xZv1f96uyHy6xRhOWt9g9bqkvgohbtbselSwoSvZoPzaQ3toFUoXR12zjjy9kqwtWcj9v9MSDWhnkLPG2mnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUPJihnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EBDC4CEEB;
	Wed, 10 Sep 2025 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757513226;
	bh=BkZx6ICU7s8fX/L0ntxfxCcXLl4LVKiejzAU6fVQr7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SUPJihnQtTHYphGhUGd9wmaMcRmV1bPzHUFu/TkGZKWndRkC7AI2TUT9etzAlT6/9
	 5XhwstYwI8BkXdE7TGhXyu2Bl2OCe7OwrpzATQKxv+FmX73fUuk0j9VNlgcxhwe7oI
	 jbNq9CxkVlBtmk95nO5HTq0df6JCX8TQGmr2Gmy6+1Az/NsHS/ep53Z2RUVeLRPJou
	 eMaUsxPKXuwvFQjZxBChxz6PUSoVfQnjFSQ6JkoUuX47nYdhcOgfGhUWrAnuP9I8DN
	 WGn7OelamIgwuW7yyuUd5ZxMD3JPe/zLxE3yRwUNQBFu9D9vCdQBF3kCymrX1ApWXN
	 lQhNz1dQg9Pow==
Message-ID: <5d927b79-a1c2-406a-afb2-431a4b861ed5@kernel.org>
Date: Wed, 10 Sep 2025 16:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] power: supply: Add new Intel Dollar Cove TI
 battery driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
References: <20250831122942.47875-1-hansg@kernel.org>
 <20250831122942.47875-6-hansg@kernel.org>
 <sfsn4int5dcrx6ln6xicps45utch7vnjocyeuroazjepgwpphd@hesz45zgrvdy>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <sfsn4int5dcrx6ln6xicps45utch7vnjocyeuroazjepgwpphd@hesz45zgrvdy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 6-Sep-25 1:59 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Aug 31, 2025 at 02:29:41PM +0200, Hans de Goede wrote:
>> [...]
>> +	/*
>> +	 * Note cannot use devm_iio_channel_get because ACPI systems lack
>> +	 * the device<->channel maps which iio_channel_get will uses when passed
>> +	 * a non NULL device pointer.
>> +	 */
>> +	chip->vbat_channel = devm_iio_channel_get(dev, "VBAT");
>> +	if (IS_ERR(chip->vbat_channel)) {
>> +		dev_dbg(dev, "devm_iio_channel_get() ret %ld\n", PTR_ERR(chip->vbat_channel));
>> +		return dev_err_probe(dev, -EPROBE_DEFER, "Waiting for VBAT IIO channel\n");
>> +	}
>> [...]
> 
> The comment confuses me. What is it supposed to tell me? Is it a
> leftover from early development stages?

Yes this is a copy and paste from a comment in
drivers/power/supply/axp288_fuel_gauge.c where the comment at least
is accurate in that over there the non devm iio_channel_get() is used.

Clearly it is possible to use the devm variant though as shown in
this new driver. I'll submit a patch dropping the bogus comment
right away.

And I'll also make a note to see if we can move axp288_fuel_gauge.c
over to using the devm_ variant too.

> Anyways, I merged the whole
> series as it looks good to me.

Thank you.

> But I think this comment should be
> fixed in a follow-up patch :)

Follow-up patch is on its way.

Regards,

Hans



