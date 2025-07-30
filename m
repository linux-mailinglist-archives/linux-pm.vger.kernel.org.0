Return-Path: <linux-pm+bounces-31641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3BB168CD
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 00:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CB1164856
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7D22A7E2;
	Wed, 30 Jul 2025 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um/oz7Nt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1319C556;
	Wed, 30 Jul 2025 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913072; cv=none; b=rQFArWPTy8V1B7rbvH6AcIPLBklszucr5zO3EcQdnyvnfAngAeAOyGOLL8fHJbYly+Xkl/e5xtqj1b/hjXx77buwuCslRILiX7gSrlfRDu0xJGxSthZaAY5H/Jq606RIEquvn6z2KWjKOFlgbrC2K0N6hrpwbYI7qOOGFP+vyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913072; c=relaxed/simple;
	bh=A+4NJg299rLznYuK0jos7NwHrFZTgz1u9++QAte4U2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udKJGVhmq1++LGPiQDlvrDWK8cmh8oqpU16bUTR96P33HlJ4N0AEhnYu9XY7M5Ce93PR1o6z0P6z5sYi1O8+eK+Vq1eXeOjlts+9+oUY83iktFmRLlid55ojKTkXtt/kB0EwKfSwNGRF7PoOXcZr32R95bYfqoJ9amw451CUbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um/oz7Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38562C4CEE3;
	Wed, 30 Jul 2025 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753913072;
	bh=A+4NJg299rLznYuK0jos7NwHrFZTgz1u9++QAte4U2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um/oz7NtCuk6lE3D6JV6Z31caeSe5vWaMzjxkfhS8di5iQOy1Soy0mfY0IFT8O+PE
	 1LyorHWOZni50Hjcmi1FHC5aZ67YMLYbiejR9Q8BKWNtoV6vJzgYT/JFFEZEijhNxM
	 DqVdmtEAq6GfnW4sjuUR+wKJWhPqU1UHd9MjTrWkFdJy1OYElroMu4LoixzRKLAZqM
	 4U0IZ4GCNR8OzNAtkV3925kR/fCss8h5civSAM0GvsUw3hyN3ixai7+T7v2CaCD259
	 tTjnhkXhEsUr+UZ85+HsaAaOX1xl3oQGHrgb+4pPLQRh1ThznnEJUAYJ/TGXf4UU0y
	 VD8S3BEc+UGUQ==
Date: Wed, 30 Jul 2025 17:04:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-clk@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
	Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Marek <jonathan@marek.ca>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC 03/24] dt-bindings: clock: qcom,gpucc: Merge in
 sm8450-gpucc.yaml
Message-ID: <175391307121.1783040.16926981800136194621.robh@kernel.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-3-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-3-09c2480fe3e6@oss.qualcomm.com>


On Mon, 28 Jul 2025 18:16:03 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The only difference is the requirement of clock-names, and only for
> legacy reasons.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.yaml      | 42 +++++++++++-
>  .../bindings/clock/qcom,sm8450-gpucc.yaml          | 75 ----------------------
>  2 files changed, 39 insertions(+), 78 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


