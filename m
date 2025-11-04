Return-Path: <linux-pm+bounces-37390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D4C32E67
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 21:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 593DD4E7929
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F72D2499;
	Tue,  4 Nov 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaWDPd3k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E949659;
	Tue,  4 Nov 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288113; cv=none; b=dc45/49o4qC04NugsXAq5+S+ir/oeKIEYia23rF/gpyVsIFb7XCiyYiPxBd5VBp0j6PDNsyVAnSh+UaLqL4r5EB5cRZtEyvu9n49hQ/O3mKZS0zB9ClET0an1QRI7+v0gYFzHll14G0kAZspplqR9DtwDnU3HkhEX13u9WdqGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288113; c=relaxed/simple;
	bh=2NMyhk1TPjR2nI9NtKMxYL366qDB0Hhswxb8XuRvfcQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oVP0cg6OV9I0/QrYyG6Pv54p1TxUI5CectvU0cqNjccGfQgNAsmBbQbXlDe6ex5EGvpd+79eC7zG6qOKixu1TXgaSFFxN/+ymUW1ylRN2kW6uOlJXPUVc+f6KgO5W+1r1h9e1QzqPTLAJMorZnMSDUMmdL6Od1LYCSnW1skiZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaWDPd3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FCCC116B1;
	Tue,  4 Nov 2025 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762288112;
	bh=2NMyhk1TPjR2nI9NtKMxYL366qDB0Hhswxb8XuRvfcQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JaWDPd3kvzZ5Cp6muJv2UmPGzSkhOmZFCnX35nV5nNroOqQxruclZ4Cbg9P/l6G06
	 bkZ8NyXX/cIM76u3UIVMQOhVmazsYa2hp3eD4uZIVIWKBk8w557aNdhWBtPuFvoOy+
	 eO+UZCw7EywzLmvCLOh9Sw+zFjwZ1Bu1sxtvVYLGdC+Q3x9qtO4+w4ahnI5gS2MMen
	 Sy3XdxtqXSfpbR9Uofu8DkxSx8vykLiSZHj2DLNYKsIQKEr5JUCyhWtoNug9wtOKpJ
	 CZy/7vbanEK6UtlaECE152S28aUEaLVmYSpx04npsjEelU9rrzn9RRe0pdXpFWET4p
	 thEY2/pypEYeQ==
Date: Tue, 04 Nov 2025 14:28:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, linux-clk@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
To: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20251104-topic-8280_mxc-v1-3-df545af0ef94@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-3-df545af0ef94@oss.qualcomm.com>
Message-Id: <176228811062.2960164.2575259376675191895.robh@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: clock: qcom: Allow MXC on SC8280XP
 CAMCC


On Tue, 04 Nov 2025 20:31:08 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Move the SC8280XP camera clock controller to the 8450 binding, as their
> actual characteristics happen to be closer to that one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,sa8775p-camcc.yaml       | 13 -------------
>  .../devicetree/bindings/clock/qcom,sm8450-camcc.yaml        |  2 ++
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.example.dtb: clock-controller@ade0000 (qcom,sa8775p-camcc): Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/clock/qcom,sa8775p-camcc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251104-topic-8280_mxc-v1-3-df545af0ef94@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


