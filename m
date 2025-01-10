Return-Path: <linux-pm+bounces-20226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34101A0923D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C9188E3F7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69420E317;
	Fri, 10 Jan 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDJxtVPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD420D4ED;
	Fri, 10 Jan 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516342; cv=none; b=U1YrHcQrxkh1vOiY5sVwQBm7PVdxn6MNSWzAaqcuWMH28PCphqzz7XbRMfjOsGopljvqqFfRPqIb7cJ+oQfuh7qVWUUvtFj/hgj/ofpG+5RfZP6NFv479VjhtWuArBEOeATFj8jnkV2bFFbf/4Q2aJGMDGe07MVoXVgxaEukWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516342; c=relaxed/simple;
	bh=6706hwt5VHDv/HYNCdAtvE3p3uI0dV7mNWaIgSNjhww=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FPOJ0QUqKS2sdD3Jxg6V4VDFu6erFCFvhv2oMEpII3MwGoGe6w8bqhO7MZL0u47Q7WbkrQmNissOXuENFTnIDbkwC+EhvYJyxgEDyG2BPa7cxTR8L3YoZungZJQww0MkY4jweyn451Rl7M/OrD5LAYISKxflQLGol1QCx4j5it0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDJxtVPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A41C4CED6;
	Fri, 10 Jan 2025 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516342;
	bh=6706hwt5VHDv/HYNCdAtvE3p3uI0dV7mNWaIgSNjhww=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HDJxtVPUD3p1SPdmApTnfH1ZoE4n7ZFxynwqFV038FIhmH+KTYwzMG0DrffGF/nes
	 kHPqBwAElyCI5eK2Ezs/K/2wx9Fm/iwgfWvrIY1/oBQutRKEN6/5whRMsBp3y+gCvj
	 zsk+fd0zgLouIxMHWUtxp7Fvrsu5xZEEqA02aR3WXlWLsxqWJGuyQC/zI5p7cqJ3Yr
	 IdvP7rbi4pJzlYTPlII5k1cSTkk6THrWwSveggw5lwWG65vHhOGbTYdOpY4mPzjIzZ
	 S/HtoWdh6WDCC2mmpvDMmDXH7DENiQdWf8f0jNCEyIKckZyeYqAHdxqPq6FsuvWZ93
	 CdTSfMYioM6Gw==
Date: Fri, 10 Jan 2025 07:39:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 Vinod Koul <vkoul@kernel.org>, linux-sunxi@lists.linux.dev, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-gpio@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Chen-Yu Tsai <wens@csie.org>, 
 linux-pm@vger.kernel.org, Samuel Holland <samuel@sholland.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-clk@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>
To: Andras Szemzo <szemzo.andras@gmail.com>
In-Reply-To: <20250110123923.270626-11-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-11-szemzo.andras@gmail.com>
Message-Id: <173651634086.2650897.13417575426746113059.robh@kernel.org>
Subject: Re: [PATCH 10/12] dt-bindings: phy: allwinner: add v853 usb phy


On Fri, 10 Jan 2025 13:39:21 +0100, Andras Szemzo wrote:
> Document Allwinner v853 USB phy.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  .../phy/allwinner,sun8i-v853-usb-phy.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml:19:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml: ignoring, error parsing file
make[2]: *** Deleting file 'Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.example.dts'
Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml:19:1: found character '\t' that cannot start any token
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml:19:1: found character '\t' that cannot start any token
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250110123923.270626-11-szemzo.andras@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


