Return-Path: <linux-pm+bounces-5752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A66893A43
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639CB1F22329
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324491CA94;
	Mon,  1 Apr 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdmUIziM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189A1119F;
	Mon,  1 Apr 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968144; cv=none; b=IhxMOyCaFX2bUpHgWgC3ux2DReeCrEuuYGBCApDSaS8+JlXamOsZd+OmmacPXG+4Hf59z+fZ42zpJNuB5Cc8DAXJr+DDZOaxON55NkYwGORp7iG9bMtnZQ7CZjEbqwy1QlveTyNpR1KzXZDaxeAs3QFWmZSxw4v/QNBG9kvhW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968144; c=relaxed/simple;
	bh=Y1wrYk8kzjYE0FUlhJXvgWv83DnHZYFF/hLrOojfzis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9XhtQsguLIijFXR0SQ8bqtcWjA4T1+p1jXhY/qlhV2uTSgDDPVPOv4e6DakogUx0UYM0NaHCYEsUs48rVRxIp5fA3ai/0HIF45NMS8KOzzW0bN3WrQ/Nqbb2/+7BcJ8uo1xC+DMxjLBGUlc+gFg8pgnsmSgMZhPHWBs6ccS/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdmUIziM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD7C433C7;
	Mon,  1 Apr 2024 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711968143;
	bh=Y1wrYk8kzjYE0FUlhJXvgWv83DnHZYFF/hLrOojfzis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdmUIziMzYxcTcoARh/gq5U2BzJnYDeDbvWLgoh8U6fLdNBF7mfmcyKBXOycu78Sn
	 JWICU0LmnCGdv+fuTsvSnR6kNtMLk584+/4z7Hozbjde0qEeaVxoDQN3pAf8yty34E
	 APf38WcUO4K2Yh5cxhTJLfyPq7JpidclPtpic0jpwRc3OgGuhLK+fJjPODvSYw1Cbs
	 zHVXk87QyFBTW+g+aDpmNDzp9vBINroJeWQRJhImFPYNHKx49djKGpbRmjSE7hQwFW
	 Zl7ZHIyFbA010m/pd2MwFOS3Ikhi/XyQ2P22MYtSFHHftDarToWTNkLGs9n7yMkpqR
	 z1TwgkyfX5ZWg==
Date: Mon, 1 Apr 2024 18:42:19 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, chrome-platform@lists.linux.dev,
	pmalani@chromium.org, linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] platform/chrome: cros_kbd_led_backlight: shrink
 the driver name
Message-ID: <ZgqPiy73nGukvdAA@google.com>
References: <20240401030052.2887845-1-tzungbi@kernel.org>
 <20240401030052.2887845-6-tzungbi@kernel.org>
 <ffac342d-5b3e-49fb-ad0b-858cd36f3164@kernel.org>
 <026eed23-d75b-4ad9-a359-03a3870fbdae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026eed23-d75b-4ad9-a359-03a3870fbdae@kernel.org>

On Mon, Apr 01, 2024 at 12:19:16PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2024 12:02, Krzysztof Kozlowski wrote:
> > On 01/04/2024 05:00, Tzung-Bi Shih wrote:
> >> Prepare to provide platform_device_id table.  Shrink the driver name for
> >> fitting to [1].
> > 
> > Instead of linking to external resources, please describe the problem
> > and the bug you are fixing here.
> > 
> >>
> >> [1]: https://elixir.bootlin.com/linux/v6.8/source/include/linux/mod_devicetable.h#L608
> >>
> >> Reviewed-by: Benson Leung <bleung@chromium.org>
> >> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > 
> > Missing fixes tag and Cc-stable.
> 
> Ah, now I read your answer to v1 discussion. So this was not a bug in
> the first place? Hm, then probably my comment was not really correct and
> we should not split it.

Correct, this wasn't a bug in the first place.  Only if moving the string into
struct platform_device_id, the compiler emits errors about the oversize.

I'm fine with both versions.  But let's go back to adopt v1 (no split) if no
strong objections.

Thanks a lot for your review again.

