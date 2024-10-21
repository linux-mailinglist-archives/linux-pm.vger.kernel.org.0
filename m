Return-Path: <linux-pm+bounces-16115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EA9A7130
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7001C229D2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6B1EF93C;
	Mon, 21 Oct 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p23295ak"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6095199239;
	Mon, 21 Oct 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532438; cv=none; b=UvCZemTUlaNwqmoixwYDSCPbFV6lifKwrGClutK9iPRyfKxmpL0ZHar26XUhlpVTZ/f0XpPdH06nHdTdBDTI55Q22u7k15uwp4F275+ixJS+olU8v0f+whyf/goOnw/0zAZd3dSbn6/VcLt0k8In2Q/UtEYbCG3qhs+kffNXnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532438; c=relaxed/simple;
	bh=cU4S2vgY8V4H/hAbxrRrdltdTUrfj1DXIv+Wv1wqwVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qqdyYQpLwzkplTotjw2GFBSHag71xez3+cPNV3STLZz0XY6dHBBAMop9/YWsXsQzZM8fjT0qBLHrjWOCoLvC0Wvu0C+B9thsCi8lRa0QvZZd68A2ZyPuh5jOWTju21tmRAILnhzGxhfVWcXt3oWqN0qE39J8eosxmOYlY2Oltu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p23295ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A02C4CEC3;
	Mon, 21 Oct 2024 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729532438;
	bh=cU4S2vgY8V4H/hAbxrRrdltdTUrfj1DXIv+Wv1wqwVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p23295akyNfV5lLGJWo0hopyJjJRmx4FuYtM1MhRlgevKN/nhPcw8mPs7eWAnCZWG
	 1CCanpoL3l7p0BuCtUulGmFDU3QiohS1rRx672W7JYWoFSFLwevI6i2JfE6P1NvAcO
	 RzYSqSLD2Ue9kzXskUgSYYT62rZfjmkpBXxbUO59CGswd4ljOEVT37Bn5p+N8aD/0s
	 EYZnMon7a3hMv3H9hNUDI/WR2ZmSfgQ7x1tj14IhzyxDGnL0aHFzOtUas9ZwkXsZae
	 IBuiT+eazY9ejjZOGmNp2vWyIZsS9U4q3hmuj8CfMw0yaZcwo0X1qTqa/id3TLXTFP
	 Jni3ErmYVoenQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
Subject: Re: (subset) [PATCH v6 0/6] arm64: dts: qcom: enable Bluetooth and
 WLAN on sc8280xp and sm8450 boards
Message-Id: <172953243459.72126.14502831968644809309.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 18:40:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 18 Oct 2024 14:49:10 +0200, Bartosz Golaszewski wrote:
> This series previously only concerned sc8280xp but while enabling
> WLAN/BT on sm8450 I noticed some more changes will be required so I
> folded the latter into this series and updated the sc8280xp CRD and X13
> patches.
> 
> ==
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] regulator: dt-bindings: qcom,qca6390-pmu: add more properties for wcn6855
      commit: 15767191c26d74f7cc2d03fa2ede0d6d0051218e

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


