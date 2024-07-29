Return-Path: <linux-pm+bounces-11552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866093F98C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A271B1C21D13
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75762158DCA;
	Mon, 29 Jul 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFTE+tIv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492613C9A7;
	Mon, 29 Jul 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267251; cv=none; b=b9IF+gLFh2olhKddhd5QAS1GELdNB4pI2/ckqA5jPHCHTo8FyE2MkUTQk0MzFzaPV9ejRn5SA8cLk4DBE/PAYucCqDL5Pb/QIE8hQHsnQ5kgy69OVYy5FyokqBeytuphPXgg3Me1QHFPDumQGxf5GjpQlZf4VMXU+LMjCj0tFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267251; c=relaxed/simple;
	bh=mzYFMovn+k7oVAsF37f/0receWM06j5IkQ9VA/yeUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Bz5ytA7EVxFKE6NO1nwNv/27NkJECuIluD8gn5MRPKI8Tn0Bq9ND99YZlpOqmOcgL0vuu/E+H2O1QcZguqQOaQ65ZcFmHQmaRDhxJf3kDYG24JRBlJbBmeD1q6Amr9Zx8ZGl4Qwc9xYrfM5NXY2ZfBzY07TBcMAkQKvcTwwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFTE+tIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E773C32786;
	Mon, 29 Jul 2024 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267249;
	bh=mzYFMovn+k7oVAsF37f/0receWM06j5IkQ9VA/yeUSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFTE+tIvunFR1D9DNkIqF55hQDwc3o0SIrQXCY63uadpyNrUK9i9Ve8Mo6yEuVuIr
	 7+ZnWNChbJYYU+5kVHH0FiCKcRj76aLrBfD2MCZKJErMj7ktvMfx6KIis+kAELmq2v
	 uewS370vaUQgIHEFCHKKo/5u5weNvwx8ghVBcq9m4tT+9dX5xRl756+lmbYgjNqDjx
	 L68QbFr6R6HKwzxAIDAkDUZqmaS5DPoFD6zk1XYcRKNDwz+eVHS/EyHm5Gs3J6NMxG
	 E1aCpNVUpWSp9z/p0pGVfxpD5lNyaKICJAdkYEdQ/l8f8B88NyANpKVYIoCGXKYYTU
	 I3zn9rriTNlEQ==
Date: Mon, 29 Jul 2024 10:34:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-remoteproc@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: Batch-update Konrad Dybcio's email
Message-ID: <172226724571.728425.2439563101739958891.robh@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
 <20240726-topic-konrad_email-v1-3-f94665da2919@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-topic-konrad_email-v1-3-f94665da2919@kernel.org>


On Fri, 26 Jul 2024 13:18:25 +0200, Konrad Dybcio wrote:
> Use my @kernel.org address everywhere.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml         | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml           | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml            | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml            | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml         | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml            | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml        | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml          | 2 +-
>  Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml     | 2 +-
>  .../devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml      | 2 +-
>  Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml    | 2 +-
>  Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml    | 2 +-
>  Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml  | 2 +-
>  Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml    | 2 +-
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml                 | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml        | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml         | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml         | 2 +-
>  Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml         | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 2 +-
>  24 files changed, 24 insertions(+), 24 deletions(-)
> 

Applied, thanks!


