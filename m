Return-Path: <linux-pm+bounces-18907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A689EB184
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985922887BD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AE1A9B5C;
	Tue, 10 Dec 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myzlr3nP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A51B3938;
	Tue, 10 Dec 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835643; cv=none; b=bDgtvgIfoTcWxK1wjxihTLoZmbwVk+kv67DyDB/3Yyim22vUoMti4EBhzP5u19jqdRAcDecO0SKJp3EjVvtdHSfnfTFTGXpVGsmBREcSu6PD5lDwmNoLKI8bq5rkzvhZPpvymbeYiVEwVG73daBLyplBkUfl+Wy+xSYnV8+IQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835643; c=relaxed/simple;
	bh=7G7GfT4yW3zCpkGqBz2K23Qi2P4CWzTVgsILI8yLq8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sgAeHDvPxsSUZEiJ868zvQllQf3PcpYo+TNnSGV3bn9p3QuoBj/2VhBZwRFkblvJ4WDF9jL5VRtrtMh8HeC8GTnNuXFg4JLJO/8oIPmGa9pbSAWDbk4WUTsK4uzZPbHj48+6yqfcmHxtUP76GUK0cYwmHF2tsQmHlwf/k/AYbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myzlr3nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F094C4CED6;
	Tue, 10 Dec 2024 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835643;
	bh=7G7GfT4yW3zCpkGqBz2K23Qi2P4CWzTVgsILI8yLq8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=myzlr3nPEt0OthL5kbLhQpwnV1PTKaxRgW/URgQv9tsEAswweBdDjRnp/JLpdKFQv
	 NpuCNUSbgDe/ylBd3hJQOZX7mr1OUADsFxFpqpD9nconhWgOF8PM1B62JF/Qj/lL61
	 9KWWTX7sG2RGT1FBZcm0A7x8h7PERX+1KNPQYtSFxlnMdC6kU+Qtzs3KrSu5vx30+K
	 vNPVYdgLeP7lG/9usdwAANSRVOgc9BtBFLdFRgJ0kCa0qJczFsVl11NXeeEFI9scWJ
	 0NqKiGfxmI6Q3DOcxh78TYm2eUAmoFQia9AHIlHpHCk+EMjhAbc+xUa77jgCGapUul
	 YKrUaxWuPfctw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
 quic_anubhavg@quicinc.com, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2
 board
Message-Id: <173383563938.33920.16190333165637044320.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/4 Add description of the PMU of the WCN6750 module.
> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
> - Patch 3/4 use the power sequencer for wcn6750.
> - Patch 4/4 add support for the WCN6750 PMU.
> 
> ----
> Changes from v4:
> * Added reviewed tag by Krzysztof in p1
> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>   handled in wifi FW.
> * Added blank line between the nodes in p2
> * Placed the structures in proper order in p4
> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
      commit: 8099b1f7e37e98f73664b883464d54e2e2d9522f

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


