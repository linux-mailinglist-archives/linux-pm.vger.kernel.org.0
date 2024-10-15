Return-Path: <linux-pm+bounces-15638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEF99DDB4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 07:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04D51F21EA1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C6176FB4;
	Tue, 15 Oct 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3cH8pKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4B17623F;
	Tue, 15 Oct 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971558; cv=none; b=m7nZjmP3QJU2iiZWBHkr5t/WBmS88RTHmh50WXViXyq3830FuSpIjTMKBGMcFUDPUIugf3AMFbv6UnAP5CIJ1Y/D26z53peOBDAHG/pbhSGzIOhh49uBYCBk3zyHX+AaPl+dNCCx0zcfSa07EiNSCQLriSI7wp7ypZPyu0zPdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971558; c=relaxed/simple;
	bh=gjwGiR+lw8swhi0FBcZZp7bPpunXeeBui+cUFrOI3EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJEavKpQQIrGxiB7HOSVOAMhxpa9YJ9brEpKF2uf3wgzGcV/8jUdFSZT5z3pLu60L5aErhotp670O7QDQgxOXGY2dbNK0Xi+ZWeDscrOOqz9NsMMsguFsPnEC0DcBNk0iQ2atFlOKLp8KpBJbLXDIs8omONNC/T80dz0uauLUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3cH8pKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5050C4CEC7;
	Tue, 15 Oct 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728971557;
	bh=gjwGiR+lw8swhi0FBcZZp7bPpunXeeBui+cUFrOI3EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3cH8pKRcQm+R7SqtNvAwMWjn5Hja1PiemGxo5EFTe88ND22q0ULdIBCFVwvJh1+r
	 eYUxLZ9zD8nIRIx0bN7dfLTj6JHDCiLvuyrkC1P/JDTpvqF9Ud7lT2GP1E5X2teQuX
	 zgsVuXL0VlMWmckhsYn2G8AUWWC4tIjqGFBebWx2LxQb1gUIPU4oPMyiERrQazD9IA
	 Qno6aUjATKNr9gS3TnV4RSqPmhLUaPQ36kt/dKq4klLNlm0r9Y+4h0dLqpkR6/vOHP
	 V1HkZsN1Nf0KSjERkBY+2vKPBrrVeUqvrTF9PaQoAnkITjQJyrH67W5O+K2JR9vYgR
	 oV8oTtV67DNkg==
Date: Tue, 15 Oct 2024 07:52:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID: <cycdlsi3tb6nqgbzzmypmblpcxxqmn3slqcbf5mq2okw3lqrdr@ghvswymvnslp>
References: <20241014073813.23984-1-heylenay@4d2.org>
 <20241014073813.23984-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014073813.23984-2-heylenay@4d2.org>

On Mon, Oct 14, 2024 at 07:38:11AM +0000, Haylen Chu wrote:
> Add devicetree binding documentation for thermal sensors integrated in
> Sophgo CV1800 SoCs.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  .../thermal/sophgo,cv1800-thermal.yaml        | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> new file mode 100644
> index 000000000000..14abeb7a272a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 on-SoC Thermal Sensor
> +
> +maintainers:
> +  - Haylen Chu <heylenay@4d2.org>
> +
> +description: Sophgo CV1800 on-SoC thermal sensor
> +
> +$ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-thermal

Not much improved, judging by other patches there is no "CV1800" SoC,
but that's a family name.  Otherwise please point us to bindings or DTS
using this SoC.

Best regards,
Krzysztof


