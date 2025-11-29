Return-Path: <linux-pm+bounces-38916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF2C93CE0
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7A904E1668
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978530DECB;
	Sat, 29 Nov 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTUbSqAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7026773C;
	Sat, 29 Nov 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764415338; cv=none; b=DXZWBn38uwiMuUAvtjHXizLzY+Wr3XeEzIK3eiL/G2+LZ8IuTqdIpb2olmY0duwZzWDkavUv5r5lt0PpzrEupLa/wrX2Ne6pSPr0qUSrIGmQX1B4k4NIU1R9WOa4bu/QTjdPakVbrxkojc9KN/30GrBQS6zvm2/nxgGNKMRc5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764415338; c=relaxed/simple;
	bh=drZonjj3tZQbTN0j6Qissqp2OCAtaSw664diWAkFUsA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mUN4osO68XQevKX/C8Pe0ENSwPFs0hLD5m4tf4sTFo1l3oaaJ5R5QmhhKGifk0Df7Hib8tHX50t3YpLNWFgsTUtC+a9l/NzF67r/y8IBT028gz9XV9cHvlgEKrn68cMB3+Ei71zx7/TKCvHpAXA7PU/YvkSDhbX2sePjFb4PrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTUbSqAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DBC4CEF7;
	Sat, 29 Nov 2025 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764415337;
	bh=drZonjj3tZQbTN0j6Qissqp2OCAtaSw664diWAkFUsA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZTUbSqAw6RN0urqmyXot2SkfJ/O8De1X8dXAjj8XVo82RfUcWPPsub3SrnOPjvrTf
	 4/ttLrX+LCYMqIPMTBIUQn9Otj8/x12U5UAWoW0gwSa19nSDTE1O10jEVa27zYzVv6
	 FG6bhWO0zNLfmoS29gc7D1KigzbOgTHVhJxjSLMeisu5cQJkOa0g7LQi1MtRMMHBhL
	 5IozucqTyWqihSff6j0wLE2zVoqkcmkfROMP/IlAUqfvOe4jSMtmXdvVUVEBlnBkmd
	 HPnUmN3KHs9yJU8+DbbQGYMyd0SVKkuZ99OKAiYJ/YO//O1IMc4v11zPdF2cP+8cSI
	 IalFUT8d0Szag==
Date: Sat, 29 Nov 2025 05:22:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Georgi Djakov <djakov@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
Message-Id: <176441533579.3692893.7120523585287384087.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix
 incorrectly added reg and clocks


On Sat, 29 Nov 2025 10:46:13 +0100, Krzysztof Kozlowski wrote:
> Commit 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks
> properties to enable QoS on sa8775p") claims that all interconnects have
> clocks and MMIO address space, but that is just not true.  Only few
> have.  Bindings should restrict properties and should not allow
> specifying non-existing hardware description, so fix missing constraints
> for 'reg' and 'clocks'.
> 
> Fixes: 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


