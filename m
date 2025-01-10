Return-Path: <linux-pm+bounces-20261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24880A09E41
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 23:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DEF188A04A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0F219A9B;
	Fri, 10 Jan 2025 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F47QU7Ac"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEF218AAB;
	Fri, 10 Jan 2025 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549040; cv=none; b=V8tWNcdZKso0c6vwH7W7zQeHbHciCojVLGpkBy/ZeKWU0da/9P7iqLPm2h9pdNMRRm8vBU6XB6nrCa/aDIwv9gRruHXzSFv9q67l600o3E88zMxGGtEKoKbt8gkq+3V9UmvuamrMy20Ak0j1OMOkhPbyhllWyog1GqvwOdOhygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549040; c=relaxed/simple;
	bh=mC+RmYtFpZ8COsrkWfu8xW6P7u4+cXzKJ+jtiA9UHPk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EZmRYk0Ju562BFOFFxCoF7DotsgpXLGHv94XQm4/pIBYsES+sHsS9FN+QM88kT/glqNoAx9kSh1Sxdkp1qVcM89GFtUm13rXCabf8YnIzALF8NWOCcIyP7ihICvG6zydnSRz+fNUkmws+DsVOcFS6IRxI0Mnf9jBJPtYzTBQXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F47QU7Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB4AC4CEE3;
	Fri, 10 Jan 2025 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736549040;
	bh=mC+RmYtFpZ8COsrkWfu8xW6P7u4+cXzKJ+jtiA9UHPk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=F47QU7ActJUFaW+RAGY8aL86j04K+YxyrviRSuUMeWFX3IX4AG8FTecmqyLwdKbB3
	 bDqrfegZ3Lu3hD08e3vdIOhSZHBmBWM9r/sJEpQRWO2Uy/IMxpkKqivNcncP12rOMm
	 JOjpQX8MbUrXpvdoFoFX1xy9/X3jKSPBJrvHWydCQMyhO8d/RPmvmJAzQtcEHGKBbl
	 78XrCQ5xJFAl5FrDGC51BCMsJO6CMhEmGwZwkmLF0h9GjkurIUDXbkM9lRFaII3cRK
	 nlEwFeDVceekVGLsWEuFLCDNCIbexI+4Z6jUkQ1eMf7QzigE51s4WOIiRa5Gys1SC4
	 RDwoYqEA8ooYQ==
Date: Fri, 10 Jan 2025 16:43:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 Sibi Sankar <quic_sibis@quicinc.com>, Georgi Djakov <djakov@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
To: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
References: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
Message-Id: <173654872449.3799052.8538047724799581059.robh@kernel.org>
Subject: Re: [PATCH 0/4] arm64: qcom: sm8650: add DDR, LLCC & L3 CPU
 bandwidth scaling


On Fri, 10 Jan 2025 16:21:17 +0100, Neil Armstrong wrote:
> Add the OSM L3 controller node then add the necessary interconnect
> properties with the appropriate OPP table for each CPU cluster to
> allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
> cluster operating point.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>       dt-bindings: interconnect: OSM L3: Document sm8650 OSM L3 compatible
>       arm64: dts: qcom: sm8650: add OSM L3 node
>       arm64: dts: qcom: sm8650: add cpu interconnect nodes
>       arm64: dts: qcom: add cpu OPP table with DDR, LLCC & L3 bandwidths
> 
>  .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/sm8650.dtsi               | 938 +++++++++++++++++++++
>  2 files changed, 939 insertions(+)
> ---
> base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
> change-id: 20250110-topic-sm8650-ddr-bw-scaling-f1863fb91246
> 
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org:

arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: display-subsystem@ae00000: interconnects: [[213, 3, 7, 8, 1, 7]] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#
arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: display-subsystem@ae00000: interconnects: [[196, 3, 7, 8, 1, 7]] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#
arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: display-subsystem@ae00000: interconnects: [[205, 3, 7, 8, 1, 7]] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#






