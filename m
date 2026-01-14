Return-Path: <linux-pm+bounces-40888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F33D215F5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AEE30802B2
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1D378D63;
	Wed, 14 Jan 2026 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8HsnKDp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDB36CDE8;
	Wed, 14 Jan 2026 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426608; cv=none; b=P7qor6mGNhrf3cXGyppSFcHqbKle3g8fWWTNLasWKBeeeIj5U0Ilr359U2931bsy/gkZdGKzkW6tR1bFwM0DjiIZlY0pK5WTG0VXhRtIHyVNpuzxlcpL8E5iZ4ApKHxW/Erd9d02At7hQAZpy7duppvqZXKCHg0nVhZun1fLK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426608; c=relaxed/simple;
	bh=WVO6osBIohiBYtrg3CeMVJao578MY2yze+0eFa3vztY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OMwXZ/iUNLyL/6iLvyCJ8aFCsVif32R4EV8U+Rx3GPuFBuXQwqHSfUjAyjRfi5sQnngjRzIK+lD87sRDoT04buJXji+ZknvPM+HbVF9OSNuP6Wp4e7GWWMYM9RnVzWG3XoMZPsZm3ahwqf7rP2nF2SYH2CuRgMSILmzGRWLEQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8HsnKDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5819AC19424;
	Wed, 14 Jan 2026 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768426607;
	bh=WVO6osBIohiBYtrg3CeMVJao578MY2yze+0eFa3vztY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e8HsnKDpwFN6/zQvtnWiC1TLCk1/a/d23fOLW+6w1LqjLlSkWQEgmfn1JLJLlDE7v
	 cqRykWw1V57S492AZY6rJ+0yck1CplYYN3r1j+a6RwPHNUdemEEsY3N8TzTnLR/Gm6
	 C9BmcagtEs7ODmgDAcv+M/20fiPhlm+7KH55Glpp/ukxJR8s23gJJZBA1VAZYlEO8q
	 F8X68mDaW3JT+aMLmPGFJTV1N6zQx1CgOsQfQOa3FW6Rgl1WPvpxyqDN5NCxKEvhsW
	 4/L/uNl4K3lGyvY9eN2tqMnd+YBc/reDpPBgD0lq6yqt/vlmTCHypFyRkY2MBfqy5F
	 oBBlu1fKJ7uew==
From: Mark Brown <broonie@kernel.org>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
 lgirdwood@gmail.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org, 
 Yu-Chun Lin <eleanor.lin@realtek.com>
In-Reply-To: <20260113092602.3197681-1-visitorckw@gmail.com>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
Subject: Re: (subset) [PATCH v4 0/6] dt-bindings: goldfish: Convert to DT
 schema
Message-Id: <176842660309.229619.6412457616367822654.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 21:36:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 13 Jan 2026 09:25:56 +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish emulator platform bindings from text
> format to DT schema.
> 
> Most of these bindings are currently located in
> Documentation/devicetree/bindings/goldfish/. Move them to the
> appropriate subsystem directories (serial, input, power, sound, misc)
> to align with the kernel directory structure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
      commit: 10303b32519f52a5afd40593a507543143c8ec6a

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


