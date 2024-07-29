Return-Path: <linux-pm+bounces-11585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48E93FDC1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B581282D44
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0317107D;
	Mon, 29 Jul 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe5oeRdj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A257CB5;
	Mon, 29 Jul 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279173; cv=none; b=Li7I/4AcN9JUjWBEKkY0bDJd/XZkn8cG2ymP04nbuVFHc89eMqvxCMNutyb71JSPJRg69b1W1HdB5/clGyISL5ezXsSTn+YjWP8H733SQoXQcpcQtH0Jhcwkhh0dRMEo1SK3hUHiiQXSh6EUIatP0PvTFnuyvb0ZQc0PpHFa9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279173; c=relaxed/simple;
	bh=yt/TEqkUG7PE55ZFi3CWgk1De/758QNjYZB7+sdWAF8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=soABoaLkRzhVnoVvwf2eEzLvVTFwahUucGbf0UbpazRmKIoUpWa/nAKCx/oGkisBatE8MrIDi8bDAIFxV679fhCcxyGzfcytXizIWaxKcD3B7IGy7vVfeSpdk5Rg9z+cIIpJiYJ2ZkLoRr0qhXn7a34jTsfcSrMoHPNq5vxaEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe5oeRdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48B7C32786;
	Mon, 29 Jul 2024 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722279172;
	bh=yt/TEqkUG7PE55ZFi3CWgk1De/758QNjYZB7+sdWAF8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fe5oeRdjCPJrzt8taKEaRFv5iTxsmq835QgyWaogwQnJzLezor+5acCS6DwJlaqa7
	 oFzvObtInXfwJAg4k9Zp96ccDMJfbRK6lUcWwWtx/fkueElPKyssu4eT6QITGFwy8g
	 4rXIu0+Ql2MPfVV63K0M5N8mgR47nkBdsdirvuKaIebO43VaNIo9+RgDN9dxSojLWN
	 eXoQOwoQDWsHYOD6kkLTYD8vQxwBk1Nw1kSnyi2GY5xoIt3DlLClKkFFEKdBROx/Hn
	 z1qdNFHbeNTaIfFembiNqffMcJDC3Z3+s7uNICG+M3K5BfYUfByk6MuCcG/8PqYE8P
	 ULC2bUIvIWtTQ==
Date: Mon, 29 Jul 2024 12:52:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, jagan@edgeble.ai, 
 jonas@kwiboo.se, heiko@sntech.de, Chris Morgan <macromorgan@hotmail.com>, 
 krzk+dt@kernel.org, andyshrk@163.com, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 t.schramm@manjaro.org
In-Reply-To: <20240726194948.109326-1-macroalpha82@gmail.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
Message-Id: <172227904756.1346368.2529190213661296274.robh@kernel.org>
Subject: Re: [PATCH 0/5] Add GameForce Ace


On Fri, 26 Jul 2024 14:49:43 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the GameForce Ace. The GameForce Ace is an RK3588s
> based gaming device with a 1080p display, touchscreen, hall effect
> joysticks and triggers, 128GB of eMMC, 8GB or 12GB of RAM, WiFi 5,
> and support for a 2242 NVME.
> 
> Chris Morgan (5):
>   dt-bindings: power: supply: add dual-cell for cw2015
>   power: supply: cw2015: Add support for dual-cell configurations
>   arm64: dts: rockchip: Pull up sdio pins on RK3588
>   dt-bindings: arm: rockchip: Add GameForce Ace
>   arm64: dts: rockchip: Add GameForce Ace
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |    5 +
>  .../bindings/power/supply/cw2015_battery.yaml |    6 +
>  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>  .../dts/rockchip/rk3588-base-pinctrl.dtsi     |   10 +-
>  .../dts/rockchip/rk3588s-gameforce-ace.dts    | 1315 +++++++++++++++++
>  drivers/power/supply/cw2015_battery.c         |    7 +
>  6 files changed, 1339 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
> 
> --
> 2.34.1
> 
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-gameforce-ace.dtb' for 20240726194948.109326-1-macroalpha82@gmail.com:

arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dtb: typec-portc@22: 'vbus-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#






