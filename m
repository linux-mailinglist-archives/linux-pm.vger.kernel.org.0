Return-Path: <linux-pm+bounces-23894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14819A5D085
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 21:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A7E173DB9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9C264F99;
	Tue, 11 Mar 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWnpb1wG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9E2641F1;
	Tue, 11 Mar 2025 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723945; cv=none; b=nftGdNQCcIPgLOm9jR9hcND7YgT2qps1WVyF6WiHL30QOxPOGC7xP0YDDonV2Vkrns6zENzQAy8l5veWOhLTgUbb2g5F84ynDBEGMCB6h36qFyf3T/7ZwUCjZ66UKwtqzw3usPUGR4vKO/1WmnDSZ54iyYwFRKR9i5lFfz4F+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723945; c=relaxed/simple;
	bh=aG8lVFvNtP8J6nlAUQoM2tb12NQ0LmUQ/5LfiFA5s94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dto9m4s4ZBzGAhRQXyLJwO8WdeO0BIWAlSD531VeLMgXnqSQVELTETSle41yRxyPDi8Gd7J4DLnX2fizOSmyZQZ+zAPbU4I8rzYvUwwHJv27Q7o9KFdptamOYtHVt99ZS1upIX0HFwmURe6ndYwwNBMz435LzeF4N+0LFtt/iTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWnpb1wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A082C4CEEC;
	Tue, 11 Mar 2025 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723945;
	bh=aG8lVFvNtP8J6nlAUQoM2tb12NQ0LmUQ/5LfiFA5s94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HWnpb1wGyF4g//SlyZAJpWzL1HpXqjbhBCvuxh3senUqbTFEoYXnI08G7f3cVlyG/
	 kxWw+7iFj+bU9iAPzyh3NNmhyq/Uh6u2lUwZt3GzWTfZTWUa3/vxSO03XaWhH2Yw5R
	 CtV13E03i48r/HmzaLxe/ad8WikUpD8VDK3GHlcQ7UUmwHAUjsWgf9jBaVJnJTYbed
	 ydVBErLMkLiv8L+f+w+BFyRhvhkoiyHJ0AIDrXNdcfUgNWiCIG4zQmdYayhikpZ9e3
	 y5SWYSB9XHf7KKih3K4oKfVXvvi+ZKzXapKB/GCOBsM9pcpFOEnZ0Q/foiWEIAHxNH
	 VcCQREybLkm4A==
From: Mark Brown <broonie@kernel.org>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, lgirdwood@gmail.com, alexandre.belloni@bootlin.com, 
 danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, 
 linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de, 
 linux@treblig.org
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250311014959.743322-1-linux@treblig.org>
References: <20250311014959.743322-1-linux@treblig.org>
Subject: Re: (subset) [PATCH v2 0/9] Remove pcf50633
Message-Id: <174172394137.371198.5965546226649774705.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 20:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 11 Mar 2025 01:49:50 +0000, linux@treblig.org wrote:
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[5/9] regulator: pcf50633-regulator: Remove
      commit: 248bc01138b11ff3af38c3b4a39cb8db7aae6eb6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


