Return-Path: <linux-pm+bounces-20137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA9A06FAD
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 09:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0174018888A7
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540221481B;
	Thu,  9 Jan 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgMMWCEh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397310A3E;
	Thu,  9 Jan 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409983; cv=none; b=YSkXpRNmK4QOGg6YodrBbc/zZATZigvi/oKHb0W9HQ6odboPJPaWzSgICq6pVvqaf8QuZP44WivrLtLALCo/kEODzOMqoH+eOyHYzK/wYEJWt6gwggdD0bxR9gnx8ocHLkt4Z1POlv0M82SYkvFxYy15XeIREfoWdj5aqCWPklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409983; c=relaxed/simple;
	bh=qBbfHEZ+8VkJLNdIID51HsKf3XuVcwLbfONladZVSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBdpoXMIzIUKhfn4DbNhAuAYyDrAprpySGsxMD0X+45IrkrsJYl9yCNRzM/BXzOoSS3DfV8UB4Gc+Tq6tJrcgBsvsIL639HX3ahtFjIBsBs2kn8dstX38UpjVNC58ig+zAG7tVh8AeD/AHkEGQdBrJMla564BrdvQ03pqkjgjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgMMWCEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647B8C4CEDF;
	Thu,  9 Jan 2025 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736409983;
	bh=qBbfHEZ+8VkJLNdIID51HsKf3XuVcwLbfONladZVSUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgMMWCEhgqpNMX/qhjYAeRmSm/nEpjyi3jemX8LF8QGzlD4TYuKJcqXLIFzEYeSys
	 nZPQs+hlvqI6FyW5ABCW6v8X+F+nJwtRwMTuoXkYJQ2hZ11WR+VkaMAfuPWz1fcbln
	 w1ao17MeZ4sJ2fqfZkWmlw8Y2OgKayAngY2KmRfShsVLJzgB6//nIZM9XiQnK9gsz/
	 RMyLLm8DY55upYh3rysEVEUV3E10uPPiHO37FZZGylwyrQ1vnQOXZfSApMW7ioDAfr
	 jUIuNT5g3o613iycsvA0cs1aNILv5dYCjNRI/R/GfB8n32dvdgLoGbU3Y0wjcjiCpv
	 EhbUhVHyreMRA==
Date: Thu, 9 Jan 2025 09:06:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Maya Matuszczyk <maccraft123mc@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Message-ID: <67mvekrysu2ms5dsvjyh37wbl5dmcnk2r3xnow2e5xeeqahhrr@ar5zsq3wzip3>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>

On Thu, Jan 09, 2025 at 02:10:01AM +0530, Akhil P Oommen wrote:
> Add a new schema which extends opp-v2 to support a new vendor specific
> property required for Adreno GPUs found in Qualcomm's SoCs. The new
> property called "qcom,opp-acd-level" carries a u32 value recommended
> for each opp needs to be shared to GMU during runtime.
> 
> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> new file mode 100644
> index 000000000000..de1f7c6c4f0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Adreno compatible OPP supply
> +
> +description:
> +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
> +  ACD related information tailored for the specific chipset. This binding
> +  provides the information needed to describe such a hardware value.
> +
> +maintainers:
> +  - Rob Clark <robdclark@gmail.com>
> +

You need select: here. See bot's warnings and other schemas, like
primecell, how they do it.

Best regards,
Krzysztof


