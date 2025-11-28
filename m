Return-Path: <linux-pm+bounces-38894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 948A5C92901
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC00A347CA9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290B2882A7;
	Fri, 28 Nov 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO+IfEn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AC283CA3;
	Fri, 28 Nov 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346768; cv=none; b=hoDb3pan3yEWYxgNCgIeswmISFQAE+3BywmveO4MQvdKr4kIE07PsyGIoL8rAEqaHq1to329XDBbXjCILq24omgaJeHE4sLbXUgD1CwEh3+UnTcRol9RXvxwQEdCdwWiJVcfX93ekCrfk3Fl3DFUz2GxwmI/FQKYblPo/e96t5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346768; c=relaxed/simple;
	bh=68QekvtfCVU8xJ7qaRkA8qixOyPPyNfIdJ+5zWCAlAs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sTQNUHkPc1OqNp2PbYOR27CrPMf47lhcd5731icXQZX9HJlNw46Dmw9AFxiYhqDBtAwahNXPCHF6MSTBpe9zyXzbJzoYTSsItNht7nCw4lPP2iIkGZp/FFLv1p2Vvcr63VTiYk0BhesuE4aeYdRLsZq5rbEaIG7tJGNEUDhby9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO+IfEn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E43AC4CEFB;
	Fri, 28 Nov 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764346767;
	bh=68QekvtfCVU8xJ7qaRkA8qixOyPPyNfIdJ+5zWCAlAs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XO+IfEn84KYofn3IAyhjBokgm1uFAgEF8jIXR/UaAaq3Y1UlxqZPiqD1BaUtvJEES
	 v1HkuHOHs/icuDJiqzsK/+W9zhmtE66spDxWRtSOGCMxmZYoC/uekfSYNwJ8bd3fi1
	 BRETo4ACfNBFYlVB9A4u7iv4sGnQYDw0GEBUd5pfHRUnPbQU0LN6vMax3nB6Hw+7w7
	 TOxEZ/RaOINUHVJJwqq4aeRVnpFPfVI7CY4y4r3lC23Pe+vkLy7vfvV+aH6CozR+Ue
	 /ETPDSvXAz6HjfWygYh5VU9B6OFte2lspmIXKt4D5sLfCaQ0fOP2kyp2Jqs4whco6l
	 jJx0RzQ1aM+gg==
Date: Fri, 28 Nov 2025 10:19:26 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
Message-Id: <176434676426.2173810.9273510900390540492.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on qcs8300


On Fri, 28 Nov 2025 20:31:04 +0530, Odelu Kukatla wrote:
> Add 'clocks' property to enable QoS configuration. This property
> enables the necessary clocks for QoS configuration.
> 
> QoS configuration is essential for ensuring that latency sensitive
> components such as CPUs and multimedia engines receive prioritized
> access to memory and interconnect resources. This helps to manage
> bandwidth and latency across subsystems, improving system responsiveness
> and performance in concurrent workloads.
> 
> Both 'reg' and 'clocks' properties are optional. If either is missing,
> QoS configuration will be skipped. This behavior is controlled by the
> 'qos_requires_clocks' flag in the driver, which ensures that QoS
> configuration is bypassed when required clocks are not defined.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,qcs8300-rpmh.yaml       | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


