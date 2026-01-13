Return-Path: <linux-pm+bounces-40749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E553CD19F45
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1532B300698C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770239340E;
	Tue, 13 Jan 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYi9WhYw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD29313E05;
	Tue, 13 Jan 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318727; cv=none; b=OUR8FPeqCPFkI5UuoyLwffICSM6ewZx9SY84cX9TJ+0auNya6gnTN0ZFNSl/Cg6UKGZ1OsyVaI4PmtESRVE9TXZ8YHPr0dtp1zJ1r1oVAeMIOz+e9o9cfJf9DbtPhQDJKkHA6y5n505fu8sd10kslLWGWQKl1IxTpE7NTswMM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318727; c=relaxed/simple;
	bh=ljT5os089R8jUo9auIHE9TI3ncsDNdnWjL/OJch4leA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=icwSPvmaUIB3mGu2iWz99GDUWxUSnTnfBY5PGIQUE867x+lLyz+Z5AgxyAYpfkL0dKtAZw5BBD5NWSRbGEzLWoBQhOp78SleSEmHPE0qpf3H/8vqBWtzlm8S144vtXVK8yWXMlBwWskxiLr4jEw4FOa2xg/RKx8n+4klO59Hufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYi9WhYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC28C116C6;
	Tue, 13 Jan 2026 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318727;
	bh=ljT5os089R8jUo9auIHE9TI3ncsDNdnWjL/OJch4leA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lYi9WhYwgD1Orn9n6DwmOzaGYJX/YkrW8INCxFw2FUtssTuV52T9mNyNFgbdZO1rM
	 m1HDAiuhHpQ3+VaKnZNSzdqadV5nizrxEZmxwMlPsxCERJHprQjR/GF63nchWAgjKG
	 9vA1Oq3zzVBlL2iyBvIlwLv0nGwx2/NEa7u5fshSVEmEX935+uoYgh/ip8ptqawmIo
	 FInWYr/y+tMpjzOuwK2pcgGAXpq/ykIn/I9qv9At+8LNQna1D/DfkwkhYo8KlEO/OM
	 mfB5c+OO9ShzZ66z54hNwnpWJcPdCqNBttcamyWEWKb5OGHCkelO2rR/QEXkrmaeXi
	 tL2N+KJqy5AgQ==
From: Mark Brown <broonie@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 sen.chu@mediatek.com, sean.wang@mediatek.com, macpaul.lin@mediatek.com, 
 lee@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH 0/6] Fix dtbs_check warnings for MediaTek
 Helio X10 platform
Message-Id: <176831872457.153367.14622745892314897122.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 15:38:44 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 13 Jan 2026 11:59:54 +0100, AngeloGioacchino Del Regno wrote:
> This series fixes various dtbs_check warnings happening on the MediaTek
> Helio X10 platform devicetrees.
> 
> Depending on correctness, either the bindings or the devicetree was
> changed as a dtbs_check warning fix.
> 
> AngeloGioacchino Del Regno (6):
>   dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
>   dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator
>     compat
>   dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
>   arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
>   arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
>   arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/6] dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
      commit: de9f1b1583aecb246b659effb03f2456604fab64

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


