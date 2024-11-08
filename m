Return-Path: <linux-pm+bounces-17198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF49C1C7D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BE4B23A92
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE521E47C7;
	Fri,  8 Nov 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdAskxrU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9041E0E10;
	Fri,  8 Nov 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067027; cv=none; b=PXYbAmp6SGnmSzAySTLXUt1+eft3+BesE8kuelBv13VL9wJizKFo+y+Vq308iklIyIM6uHEjpJPZFwKxwEr1x2DRGYCuM1DFib5YxOWKIE2uLhDcaA68tgS5Y9xitv4xc7LvtMFr5rgd4F9b2/eDiHkcN+z1wd+1CX1SU87puJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067027; c=relaxed/simple;
	bh=QbmFVfadbo8uXdqtT81Hz2hqVSegNMI1xnbOcKgH/94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neDS3yDzIL/HEoP7Y9IjLCGEJsP0S0fjCgsxmgQSXuHCR6xeQ9mftAoySVAelg3sPIo0m//vNR7BK5GpBKXiWq2c1W0xBM9jQ98JetbdKspcvdpWqDgDGjm9UuGQrSZA0qq/XP71b24TtLQYIslKqZsll3Uvo+JLEw2cAzMGzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdAskxrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1EAC4CECD;
	Fri,  8 Nov 2024 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731067026;
	bh=QbmFVfadbo8uXdqtT81Hz2hqVSegNMI1xnbOcKgH/94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdAskxrUCnQqARtdBdT1Xjji1CjZcDU39CU3w1LtZyMuDCq8L7NJq1eNyy3OsErH6
	 H7idgmY241VJ0qZbnoi/AdkHYqDllUAj8DILDvzKtmuX4T4HS86Hbs9+6gIsa+HKff
	 +RYqGGLLSL8u4MAQnLM+QnJhzC3/VKIwZmlmzne0L7MeSoLEbB2NYaRqumbcLIWr7x
	 gp3D8JQUAwIrCZuHORoMvmLdXzl+qxbw7LEqXvUQiSfWDN49Jb/qT8nmW5ymJK/6Vd
	 ktQavmGa2pkSzJGp4dboY5qnjVVDtCWnOFv5hohswKtzE7NR9KHVbnGdPzHGLa8rWT
	 in6s0lfz+w4Eg==
Date: Fri, 8 Nov 2024 12:57:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, 
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: ufs: Document Rockchip UFS host
 controller
Message-ID: <bpxlah7lewfhbpe6555d6pb6sfj6eziu2ski5iiazu7pwpwc5j@jrhvjyke5rzl>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
 <1731048987-229149-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1731048987-229149-2-git-send-email-shawn.lin@rock-chips.com>

On Fri, Nov 08, 2024 at 02:56:20PM +0800, Shawn Lin wrote:
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
> +    #include <dt-bindings/reset/rockchip,rk3576-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/rockchip,rk3576-power.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ufshc: ufshc@2a2d0000 {
> +              compatible = "rockchip,rk3576-ufshc";

Odd alignment.

Best regards,
Krzysztof


