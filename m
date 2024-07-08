Return-Path: <linux-pm+bounces-10772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228192A3FE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A74B22217
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6D13C3F6;
	Mon,  8 Jul 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4+J9ZaO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30D770F3;
	Mon,  8 Jul 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446435; cv=none; b=dALAEssrgr5l8ZyL/IF6AVunTxAVtne1YMgPqLFnO929yaVULWk9T2c6o4Y5JhejLHkHOYy/wn0zW4QlZDtQ9S+KikC/P/67YAEyALf6grBGCbiQq9nPcnBaeTMboQ2inVxBjFdKVmMa1NYy2b1uv9riLzE66TZvVp2XMN0ATJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446435; c=relaxed/simple;
	bh=2vomq8mEESeFfhHmhQ5eoZsQ2DEc5hIHJUkmN3qwLnk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JZDGCsf0s0tsQW9V7SLkIgy1RSjMlVO47w7azzyzdg6N93XIZudcSNGD9tMoz0o5WV4bpvcPFJOSi2Xv8RiLO3Yw/j66H246+HUc4gzddrJjyNWF3hEOmuGikdL2kgr/WIeMweDWtkJODvFR9KeKkJPaMhwY68Kp56duoTOwnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4+J9ZaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F10C116B1;
	Mon,  8 Jul 2024 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446435;
	bh=2vomq8mEESeFfhHmhQ5eoZsQ2DEc5hIHJUkmN3qwLnk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U4+J9ZaO/WP8O9id+1gpZf41+qJtJ56JjqlQnnetfmgZDX/p2Em4SdLADSZVpPvsY
	 yS8b1uvRqw5fvEeCWqd5acaYwMZ+r4Ny51XKZVYXdYJ8GRaJR/PnKMN+hCAWpn1XK0
	 tcoTG+akL0rGlgz9YTzEun1YKj8dZfT4TP8lhM+nTshNRQBQ7adqOKom/SVyp83lFO
	 IrbNk41MFFgQ3C10uLFXioOZ1hH5j/phbVMoNQZeZTZOru2a6OUwFIZgIkXtK6MxZs
	 F5E72UiQ6UfWD066+LPn76RavHu0coAoqv0FxPL7CZ2Y7c2IdBVi1KfIzaKNULk1IT
	 CZX6WsUHtwoxw==
Date: Mon, 08 Jul 2024 07:47:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Andy Gross <agross@kernel.org>, Nishanth Menon <nm@ti.com>, 
 linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
In-Reply-To: <20240708-topic-cpr3h-v15-4-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
 <20240708-topic-cpr3h-v15-4-5bc8b8936489@linaro.org>
Message-Id: <172044643349.2927781.3846230770478390037.robh@kernel.org>
Subject: Re: [PATCH v15 04/10] dt-bindings: soc: qcom: cpr3: Add bindings
 for CPR3+ driver


On Mon, 08 Jul 2024 14:22:35 +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the Qualcomm CPR3+ hardware.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Make binding check pass, some other changes]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
>  1 file changed, 286 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-1:qcom,opp-cloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-1:qcom,opp-oloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-2:qcom,opp-cloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-2:qcom,opp-oloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-3:qcom,opp-cloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-3:qcom,opp-oloop-vadj:0: [0] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240708-topic-cpr3h-v15-4-5bc8b8936489@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


