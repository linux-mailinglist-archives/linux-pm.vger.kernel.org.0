Return-Path: <linux-pm+bounces-39870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A4CD988E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2497530336B6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD42D781E;
	Tue, 23 Dec 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzFDpvu/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B572DCBFD;
	Tue, 23 Dec 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498367; cv=none; b=cUKmvEFnc7FWYzpCX4Vq7L14XJ5JFeO8n3h5UlGemYd6dH4Tn1+2EscMkxNRB8tPXKr8GT2gHSKJHhp+fcjoLRd6LktIuDVKg78CWgB+eoFh0RLcEPqS6KsVKbbZ63llt/OArCLZUgWB/Pe/+PhRVXRXMH1+lnBViFz/1sJ6IiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498367; c=relaxed/simple;
	bh=mYYd/HLHxWzeS+H2xjYTm8cCLe5i5//hqlqiAeBTqAM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cPz9U5/qNC5UxP+54ukL2bzgk/fQ89P96kdEfMtoF6wtw289w5K4VRvdbYkPbH8jQlh1uMZGdGRcjTb3TNBWW13k26bK0ManZo2GJxgMxoGZMiXjBI0eD8l0+ND3Olz4c0YUfEpyW5bCInSFBLO+2SCb3jg6B87J83qSKZHPiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzFDpvu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41667C113D0;
	Tue, 23 Dec 2025 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766498364;
	bh=mYYd/HLHxWzeS+H2xjYTm8cCLe5i5//hqlqiAeBTqAM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WzFDpvu/KnSufCT8qHLIxfyESGBpITVunUafcyeZBlDkmC8F/AdIBogJYsXp3Bj39
	 GY5lDLO177lg8eBsgc0mtPzE2qqLPUonw9tkUeXhfzkOrb0YAo+U7sVAkSuJNKaKiT
	 Th3ciLs+k8yvyZ6p1KqQw3YQk/9nThXUZ+XegA++YKMflXp25+kdYIXFq7opxbribB
	 yQJJ4iUu56fVyZ+ItIT4g707vEQJQGDCqm7igWQSVe05KqFtcGAV0yp/OxUUASoaDQ
	 j3Vs9Rn1mT6iI2OboyNC399MDXaWBzyCB4fU8Ig9DF29n2W2NXAz3cPQPupKBQanOf
	 VGTUBPgS0q7GA==
Date: Tue, 23 Dec 2025 07:59:23 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, amitk@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, 
 daniel.lezcano@linaro.org, mani@kernel.org, casey.connolly@linaro.org, 
 rafael@kernel.org, konradybcio@kernel.org, andersson@kernel.org, 
 lukasz.luba@arm.com, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
Message-Id: <176649836333.2975956.6455328748183813008.robh@kernel.org>
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings


On Tue, 23 Dec 2025 18:02:22 +0530, Gaurav Kohli wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.
> 
> Add maintainer name also and update this binding for cdsp substem.
> 
> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>  .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.example.dtb: /example-0/remoteproc-cdsp1/cooling: failed to match any schema with compatible: ['qcom,qmi-cooling-cdsp1']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


