Return-Path: <linux-pm+bounces-19292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329669F2CF4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F1B167A1F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52832010E8;
	Mon, 16 Dec 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P839JV1c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFD201031;
	Mon, 16 Dec 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341222; cv=none; b=IKB0GV0CXZjwwItbSBKHtIF1j8A4+BMacxzhlIsh9Pnl/hl7ErLakqOpyNiybSWQ7J9+BShWR7vnRNVPQr/5ZPnsyap+XBnaqXSUT90mg8BAEmfnl8asQTJoFbpKsnbcZrJFC/ZjbWMTjW8yh1DUQQCE1N1CMqHIBTaKkHvR7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341222; c=relaxed/simple;
	bh=RiNZbWnZxjqP5avkWIr4+Q2y+t0Cf4R8Bb/gjwRkOhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7XSgvnBMO1E+McCp6PnJbm2QmulOuN3qn9fx3eaGcvSWZv51v7LuFr9Z5nHOUw7E778Mw0unkv7iKudvN+XWRGAxaaXXR8S8HEBnJshySpZRGQFrL9Ruz9aQDzN4TpEfEGkzA8Z2SEM36Yg+qGcIb/4xxtmZ7t2s8heG4JTeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P839JV1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E36CC4CED0;
	Mon, 16 Dec 2024 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341222;
	bh=RiNZbWnZxjqP5avkWIr4+Q2y+t0Cf4R8Bb/gjwRkOhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P839JV1cAUMLZ7jxjjy/0R4WSlaoT6Ejp1FNkM2wZtm3KjWc2lWi134wD3z/a5Hz2
	 GO6tgq308F1Q5m5OyeJcd5RtSQtGb+fBK1IeSln/DnhaTXl9mxxSVSlvcyDAfK3o6Y
	 1QNPp07NJ75j6PJ7VqZOyLZwK0QCjw/atdyMgGHYh4kQnigfSb+NU4PWTgYMh9M3dL
	 yDvQFPbpBqQFVtUyTxFwd94Qtr6hG37v0hyg5Z3tXgFVrxW+WpultvTGcYeMledd8X
	 obepvIzeUShWIcqimGolI8FJgKieAk+KiuVqH7lyebMyY4I3geRN78jix0Kx27Sm/z
	 XDCvqCYUvCuzw==
Date: Mon, 16 Dec 2024 10:26:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org
Subject: Re: [PATCH v3 1/3] arm64: dts: rockchip: add DTs for Firefly
 ITX-3588J and its Core-3588J SoM
Message-ID: <itsbbexem4wlkbk6tczmawkp5z6ngse477iretyarg2ut5jhi3@atg4o3lr3u6u>
References: <20241215032507.4739-1-shimrrashai@gmail.com>
 <20241215032507.4739-2-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241215032507.4739-2-shimrrashai@gmail.com>

On Sat, Dec 14, 2024 at 09:24:53PM -0600, Shimrra Shai wrote:
> Main DTS for the boards and Makefile addition.
> 
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3588-firefly-core-3588j.dtsi   | 453 +++++++++++
>  .../dts/rockchip/rk3588-firefly-itx-3588j.dts | 712 ++++++++++++++++++
>  3 files changed, 1166 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 86cc418a2..3f2eebd1f 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-firefly-itx-3588j.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-friendlyelec-cm3588-nas.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
> new file mode 100644
> index 000000000..e911a6472
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
> @@ -0,0 +1,453 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +#include "rk3588.dtsi"
> +
> +/ {
> +	compatible = "firefly,core-3588j", "rockchip,rk3588";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

Best regards,
Krzysztof


