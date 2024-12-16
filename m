Return-Path: <linux-pm+bounces-19321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136879F360C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E2A166C5F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791D2066E9;
	Mon, 16 Dec 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrtCSjKh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB631885A5;
	Mon, 16 Dec 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366562; cv=none; b=hegxUClrqpvee8yYKOWi3R0EQXlMJ6crJ1EE6DqQC4RvR4WkBVLSNYSsb12vyh4JCBrSSUN10J7kFP8QIp9zudGLGGiyU8WPdkoN9SHZnVtGAMlR19T4kDIqsrctpzFE3kikOSeC1N/JP0VcvRwrkOv6WBm0vqj+WwDGwIuEC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366562; c=relaxed/simple;
	bh=EH/ufdT5EDnouKnjjdGAMRabPTfJmALbDN0nfMT7ml4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=k3u0pi0hvBI9dbn/R7N8sjY3LpWWTlNVkF8YQmE+c7W07pLFRenkSKrAGqYWn+zvSuaNHatWdvxfTXro+N4aE261MOVp9y4Ai7ZIXU8p0S+tG8zSETMBWPMbTgtPJHAHgvACkJBNZYgRtBzx4/EqyS5bY+LaHp1PXUmPtbmIOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrtCSjKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01627C4CED4;
	Mon, 16 Dec 2024 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366562;
	bh=EH/ufdT5EDnouKnjjdGAMRabPTfJmALbDN0nfMT7ml4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rrtCSjKhQyNdd9mpknLtAP4kBqJbnxw5r+4pSydUFfCnyaaeVrOIZLIwLkZvdxNgY
	 NFTPjBZca0lbeQXdkmx+w5SPcmnXa21FW6x4Px+LP5NcKXwy6EnPBl38Lq1eNYLrIQ
	 YJpg1rGy4b7X2O9sNp1hSsQ62Hxd1yftj/QvktYmyXwNN3V/MzAt9L24haWHuJ6RbY
	 DpDSL8xg6Cg14s+3W9/xD3ClsY2s3FdU33XGcGYbgUPnb+uZ0r8r/5hrrNTD5XIbbb
	 9Kj2ONWn4hfQwtLT0a7+dtM9o/7gnmCfTKZ3a81mzL/V3v4hagmIPqQMfpj3tldNlx
	 K6kPADVCFuR4A==
Date: Mon, 16 Dec 2024 10:29:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, heiko@sntech.de
To: Shimrra Shai <shimrrashai@gmail.com>
In-Reply-To: <20241215032507.4739-1-shimrrashai@gmail.com>
References: <20241215032507.4739-1-shimrrashai@gmail.com>
Message-Id: <173436598341.265396.5585546641509709958.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: rockchip: Add Firefly ITX-3588J
 Board


On Sat, 14 Dec 2024 21:24:52 -0600, Shimrra Shai wrote:
> This is the 3rd draft of the device tree proposal for the Firefly ITX-3588J
> board. The same functionality issues as before are still outstanding;
> however I have cleaned up the style and structure as per the comments by
> Heiko Stübner on version 2. Of particular note is the splitting of the
> device tree source into two files because this platform actually consists
> of two boards: the ITX-3588J baseboard and a single Core-3588J compute
> module stuck in a slot on it.
> 
>  - Shimrra Shai.
> 
> Shimrra Shai (3):
>   arm64: dts: rockchip: add DTs for Firefly ITX-3588J and its Core-3588J
>     SoM
>   dt-bindings: pinctrl: add header for PCA9555 GPIO extender bindings on
>     some Rockchip-based devices
>   dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   7 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3588-firefly-core-3588j.dtsi   | 453 +++++++++++
>  .../dts/rockchip/rk3588-firefly-itx-3588j.dts | 712 ++++++++++++++++++
>  .../dt-bindings/pinctrl/rockchip-pca9555.h    |  31 +
>  5 files changed, 1204 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts
>  create mode 100644 include/dt-bindings/pinctrl/rockchip-pca9555.h
> 
> --
> 2.45.2
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-firefly-itx-3588j.dtb' for 20241215032507.4739-1-shimrrashai@gmail.com:

arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:355.39-358.4: Warning (clocks_property): /display-subsystem: Missing property '#clock-cells' in node /phy@fed60000 or bad phandle (referred from clocks[0])
  also defined at arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts:292.20-295.3
arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dtb: display-subsystem: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-drm.yaml#
arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dtb: pmic@0: Unevaluated properties are not allowed ('rk806_dvs1_pwrdn' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dtb: pcie@fe170000: Unevaluated properties are not allowed ('rockchip,skip-scan-in-resume' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#






