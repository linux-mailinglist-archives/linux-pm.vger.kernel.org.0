Return-Path: <linux-pm+bounces-9967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50632917088
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B251C21287
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7FA144306;
	Tue, 25 Jun 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLXfD3xd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D3A41;
	Tue, 25 Jun 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341249; cv=none; b=lKARl7hIJwUv1+vJprnIgtnCmKWsFCIEOYP/gQOmyXgDQEnuiz4j96lYDEw9486qkVhPVCCTmnlXx7OjZNqvJyHpgORJ+6hgOr2Nr7BQGd5j08ygz2TAVU/F3MXNNSzCOyY22oYFwiwqiNHNoGTf86nzmAil7J0ljM6JnKykyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341249; c=relaxed/simple;
	bh=bhr8nFnDL7/6wv7wSLgjf2kIbx/heqwxBGqRTTkrtqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CsGFfkRLWZFGQbPxGIxWomuod1bQbuOWKiZkJ6Fgc714x7dXzv0t4YWSNHbin30bOJK4FdoQblyc/JLrdEgKCjCTtoW09OlH9Fx9XvIQR9Ko7O1cWnsaCJVgX6470puBlfKL/SoQMdON27mPAr73zmXeF/RUUQJt27N1uDxBaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLXfD3xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE5C32789;
	Tue, 25 Jun 2024 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719341249;
	bh=bhr8nFnDL7/6wv7wSLgjf2kIbx/heqwxBGqRTTkrtqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KLXfD3xd6uJZwws+dSetGUwBCfzNfuucKdITXlxBeyaD2HCrIC4ZOGFEfbd4206z8
	 Lzqy8T8vlQY6Cls/b7CS3aajnGLSBgvUWUsou8b1OkmIT6KiyRRmSsnzyRhbkdcLrR
	 5rth+FbTad5uuWBp811dQhihLAT+gA1A11qD1jA/MtzQFyJ2zFtAsr54VAtaWSIRds
	 jvEfBEwfFmBUJhajF+qY+E2RzrrInzbJPHgL9H73p1f0MyJZgTc0a7jvlm42aiUsEu
	 MJx73xiozDPEBVNioSJL8+QsvC6lnInoPM0P61F2rgFHeXQGLKyYJzeWNCmIsxx2C/
	 zb7i2hgzq8X6Q==
From: Mark Brown <broonie@kernel.org>
To: djakov@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, lgirdwood@gmail.com, gustavoars@kernel.org, 
 henryc.chen@mediatek.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com, 
 Kees Cook <kees@kernel.org>
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and
 Regulator knobs
Message-Id: <171934124556.1173981.12014605377517424760.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 19:47:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 10 Jun 2024 10:57:28 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v6:
>  - Fixed build with clang (thanks Nathan!)
>  - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>  - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
> 
> Changes in v5:
>  - Fixed Kconfig dependencies in interconnect
>  - Fixed module build for dvfsrc and interconnect
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/7] dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
      commit: b147ae7ae5141cb10c520d372ecabb2c520210c4
[5/7] regulator: Remove mtk-dvfsrc-regulator.c
      commit: cd102850e32c145661c6a0640dc6c5feba11af72
[6/7] regulator: Add refactored mtk-dvfsrc-regulator driver
      commit: d2ea920a4092b3c0a6a004b93ce198ca37455d90

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


