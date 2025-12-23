Return-Path: <linux-pm+bounces-39875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1908CDA08C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59015303AEAD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC53346787;
	Tue, 23 Dec 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDAV9JPx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D7345CA1;
	Tue, 23 Dec 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509627; cv=none; b=UE7STfh/E2N+X+JPCoj84PbzTb67qVSNYO5jcjpdm8QXGZxXTHqqpktMf6beYIupJPvIx9JtU6d0yEMHucDHygJTwDOFDkBmWttrUuGBRh8XcbLXbX/mkYA0g8wh8Yakmc5TjG/NtlKNQOTymE41x8xCcKDjdy+IOYWqDG/Y1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509627; c=relaxed/simple;
	bh=UsMS2D/EQN4cBC2AFuKh/q8drUhzFGyUOadRdWtbevs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q7IWEoVUIhvbB1f8pOVrh/5ATQbdW4cR7Ng6QXtPo6dP4NceVoW0RDtO+vM9Q5I5BX3oXfr+Y0UnfUwh24ReazUodOnSEpwFz2aP2ufjQEvvfu+LhWeB6qZJv82vk1dh+AYdY/KbCemQTOIjZwjmPUoMxO3mBU0+l3yqIiBzc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDAV9JPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47157C113D0;
	Tue, 23 Dec 2025 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766509627;
	bh=UsMS2D/EQN4cBC2AFuKh/q8drUhzFGyUOadRdWtbevs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hDAV9JPxO/hGp++tDAh7t0fG0MV8Hizf/uEs3/CkmqtFYO8jYyHpdkBiGxe16fQ5C
	 n6L54d7GPSz4qQtcp/MdZWXiG3m1Pe8E4chV0gTv1oVbRXZwNPazmjzYTGuQHgiW21
	 G2wEXOvlN72Ryop6M0tB2gJHP5LYFRP6hc/hoWN3hEGCIP8cJFheZq58Ok/ItE14zb
	 6N5sK78hxHQZ2p4IqGJtXgu5Wp37MGTwtAVl0zRDWVRWwm5x/VUKlN4Xzdr3gNuYBG
	 h3937Uxk+fpWbOfhyuQ0ayVpUqxDbzUtAtvvfATqJZ53u75CG4KE8BRyh3uH8wNq82
	 RSpKtelJ+xNrQ==
From: Mark Brown <broonie@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Brian Norris <briannorris@chromium.org>
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Subject: Re: (subset) [PATCH v1 00/23] PM: runtime: Convert
 pm_runtime_put() to a void function
Message-Id: <176650962605.445350.1854283294954913462.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 17:07:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 22 Dec 2025 20:48:11 +0100, Rafael J. Wysocki wrote:
> This is something I have had on my todo list for some time, but it is
> kind of tricky because the return value of pm_runtime_put() is used in
> some places all over the tree.
> 
> Nevertheless, I think that it is worth doing because the majority of
> users of the pm_runtime_put() return value are at least somewhat
> questionable (in fact, IMV the only legitimate use of it is in the
> USB core where it is included in a debug message).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[22/23] ASoC: rockchip: Discard pm_runtime_put() return value
        commit: f92d27a6ee158c43e276712af23c79997780471a

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


