Return-Path: <linux-pm+bounces-24337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF2A6AB06
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A494628E1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35E2147ED;
	Thu, 20 Mar 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIKIi3lh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4288111AD;
	Thu, 20 Mar 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488186; cv=none; b=enBTwZYpJxo22d8xQ1xRdvG2RWlXZvHlyKC253hfJhI6prMGRKE2I5TgbxP5mEcWFHjYqvqzW7TyDfq11euEm9i0OFA7/aaeJDWWty6a1mB1Pme7v6tK4Ilqvpg2nIvrX36LN4fHNbhcbnDMRJbwM+Ni7T+TaQCKsKv/0DAwP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488186; c=relaxed/simple;
	bh=7V0u0HkvjVD+x4Ssr98QbMmTx6KapobH/hb8F7yRjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGcv/TEqkMLXnx/ZD4UFPLX+RolYCbVjj7YqfduWFIY6s/sUcDDhgAZBuW1Fzd7xNz8TpMrBM0r7r8WIhq+Y3EylqTFw57aMBsm29HbuFbg3D0H9aKjkPUYrqHsSWlz52+bhHBtTU1fPhJ/vKuzyN6wH61aBic5pCKAZfjh6/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIKIi3lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6480C4CEDD;
	Thu, 20 Mar 2025 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742488186;
	bh=7V0u0HkvjVD+x4Ssr98QbMmTx6KapobH/hb8F7yRjLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIKIi3lhHLh7Rpu3EfVyWlUif0gNuwBIoXH1W8YH/iJZtxq2V72hN9bzfmUNgQkvz
	 lfQQphM5NoPfCPtj2LAuDWIKHHotcITbnqCcI/bPhvnxZVEbCK07X4CIKBFlsl9Dls
	 HmIrOYsNbhBN+i/n6Wt4kV5mfPy/FLLe83W0yvMlrQ6hcjb5tqb3V3ds6rASTsT5gr
	 04gA1KJL+4eeOILZIRkQ2ZbseJyjakpEItiJrGmKhf8Isfq1PeFWCUaMkdAWOB+Suk
	 P1m+Wc4LFM4UdLOye76XqauFpKCGRWXC4CPtwDdOMYeGnOg1biHEYE4uUqSctId4RD
	 0cUrMZqcXFOEA==
Date: Thu, 20 Mar 2025 16:29:39 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, Input, LEDs and Power
 due for the v6.15 merge window
Message-ID: <20250320162939.GA1750245@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250221160322.GE824852@google.com>
 <CAL_Jsq+f23KniKZuTHkOq5a7WL=pBy6PwuQwXmbPXMjq3Qax4A@mail.gmail.com>
 <20250320155510.GU3890718@google.com>
 <2e6948e3-76f4-4257-b421-db9afb192bbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e6948e3-76f4-4257-b421-db9afb192bbf@kernel.org>

On Thu, 20 Mar 2025, Krzysztof Kozlowski wrote:

> On 20/03/2025 16:55, Lee Jones wrote:
> > On Mon, 17 Mar 2025, Rob Herring wrote:
> > 
> >> On Fri, Feb 21, 2025 at 10:03 AM Lee Jones <lee@kernel.org> wrote:
> >>>
> >>> Enjoy!
> >>>
> >>> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> >>>
> >>>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-input-leds-power-v6.15
> >>>
> >>> for you to fetch changes up to aebb5fc9a0d87916133b911e1ef2cc04a7996335:
> >>>
> >>>   leds: max77705: Add LEDs support (2025-02-20 16:38:37 +0000)
> >>>
> >>> ----------------------------------------------------------------
> >>> Immutable branch between MFD, Input, LEDs and Power due for the v6.15 merge window
> >>>
> >>> ----------------------------------------------------------------
> >>> Dzmitry Sankouski (7):
> >>>       dt-bindings: power: supply: add maxim,max77705 charger
> >>>       dt-bindings: mfd: Add maxim,max77705
> >>>       power: supply: max77705: Add charger driver for Maxim 77705
> >>>       mfd: simple-mfd-i2c: Add MAX77705 support
> >>>       mfd: Add new driver for MAX77705 PMIC
> >>>       Input: max77693 - add max77705 haptic support
> >>>       leds: max77705: Add LEDs support
> >>
> >> None of this seems to be in linux-next, but now we have users in .dts files.
> > 
> > None of what is in -next?  All of these patches are applied and pushed.
> 
> 
> Next from 17th March has them. Next from 14th Match did not have them,
> even though you sent this pull request on 21st Feb.
> 
> So report was correct - you did not update for-next that time.

Ah, gotcha.  Yes, that's entirely possible.

The point of the PR is that anyone can pull and apply it.

In the worse case, all would have come good during the merge-window.

-- 
Lee Jones [李琼斯]

