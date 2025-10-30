Return-Path: <linux-pm+bounces-37132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF975C21C88
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C95F1A2394A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0023546E6;
	Thu, 30 Oct 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0RGGMyf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81130103F;
	Thu, 30 Oct 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849178; cv=none; b=D9LDchvwY1KRfxQGfkUTeCsm9FHUXRsSuftHhpISMzwoTlbsEcRJBwtF0ftLDsjlJrNmpsNFLEA9QsgRxHxHhGuAMg6583e4fhQPLjxtc1qipWflbojQTD2E4rL2tGMm/aQP7WGrd3f4aoRttex+cRQMobLLj2eveuMlqtbELZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849178; c=relaxed/simple;
	bh=a4JXIrKMSTUa1Rent56WCFZrGKYeMoJ3jHvTugvCZXw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VeHJy1TPjv7UKJ0T1/8X2hhKJN8qmnjeFqAhJZhY3e9w2ue/NFBvJab45s9pTTjmz3Z/Mh9j97gA+9IMprNvaD+5GkRiE+yCWQ8CNfxlIBhq6VpefVPATFTrVqk6XqEOCP5jMALxm6G7/6Ut2487QrKiCTs2frCbhMDkpEbgj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0RGGMyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75436C4CEF1;
	Thu, 30 Oct 2025 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761849177;
	bh=a4JXIrKMSTUa1Rent56WCFZrGKYeMoJ3jHvTugvCZXw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=q0RGGMyfkIVOLXM0ILmKLsODTidtN5vo0qLOML6iTQgKSyJ9atAbJWzr/JGmrU2u0
	 Dn5uTKWa+fS/5LVOEFiH8m/u2tYYY+WPjMEfMBfXqMJY6ig1Q5mm65kZ5g0pgJsT/0
	 TzPhZTjZzZ6tP1oPvwppY5FIkLMr+VrCvm4ZxGF4vummn7pMBYpHBSEpibUd+401gJ
	 LL5hasGm3s6BwUSYttnMwoQwBmkf22AS2clizewr4Nql1UeJCoX6RkvLzfooMILYu4
	 CURPxDf3YdzSSSJUIEl+9f1HVVSBzR1RGdLMkZSbZ0+togFal9trcwZCRRZQhQje3q
	 3OB/oNXbvAXiQ==
Date: Thu, 30 Oct 2025 13:32:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
 linux-arm-msm@vger.kernel.org
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com>
References: <20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com>
 <20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com>
Message-Id: <176184917597.249475.6554623309176412725.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC


On Thu, 30 Oct 2025 17:09:02 +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 125 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
>  2 files changed, 274 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.example.dts:31.20-21 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1547: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


