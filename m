Return-Path: <linux-pm+bounces-35327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C2B9D666
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 06:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59797A84DF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35702E7F11;
	Thu, 25 Sep 2025 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB+30opw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248E34BA52;
	Thu, 25 Sep 2025 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758775160; cv=none; b=Bh4jAMbQLJDa8jSrKIlQ8N6+9ZXL3iUHsHeEHhK0Qc2moTv1AvfTGgykUkEIltXu8ELmNNSMjrzQph26zSF0RLojz736QQvFtx5nPIziYfJ1gCu9u7YvvCNba8t9DW9mTen4CkUCSXWdWZLfvyIKps5Uzq6Cp9QtcC44bjjpz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758775160; c=relaxed/simple;
	bh=LVKNFbNjJAdEFH7SfjuMMBFH6Rh39a92F5OS01+GCNQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Zpz2XZePhoJOtdfQH6tQt1dF9M7OSeri3ufsx5464Yf8BCplCsFCwmaAkt9SGTBkOexKHb5kYSgjelJsyTnDBdXJJsZ9tSw43LesdGo7du0O4Xh2RBoGft3vcObahL/d+A2rgtoC6Neff9x3yID5F3B1ORT+8QPBXsNjEVi8a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB+30opw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A70C4CEF0;
	Thu, 25 Sep 2025 04:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758775160;
	bh=LVKNFbNjJAdEFH7SfjuMMBFH6Rh39a92F5OS01+GCNQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HB+30opwvg+DRolsxHT3hmGHEBZeQZNzh6L2dtOr7EQNsPXlQkCzr3LefOhzBBOM+
	 UfF1dMwJOq7TPrCGMlShT50Bnuo3ShctXv3kkvnM0nNYKy7YKIlnIbiyKveBpatGnY
	 SotELwPpG0+OXB1zGqnPsNUcop4gTW+G3DpyZ6w1+PmvHh9vc9chHJrDVSMv3Maz4G
	 H7DPvao3hGaeEEDVHlbCz76Y5iDn6D9vBj63Gm5MLxCfic+XuSRVpAEUAYpCdBrnlV
	 N6sMpG0LHwiIRIDi7Harh3wBNJHTUn2sC5n+sRpSBYlNd+JmR+jH1O7Z9pR20PUaD6
	 yyIYiDpPRC7UQ==
Date: Wed, 24 Sep 2025 23:39:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
 tingwei.zhang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com, 
 Georgi Djakov <djakov@kernel.org>, trilok.soni@oss.qualcomm.com, 
 yijie.yang@oss.qualcomm.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
Message-Id: <175877514978.3628981.3210021527664885748.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC


On Wed, 24 Sep 2025 16:02:44 -0700, Jingyi Wang wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 126 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
>  2 files changed, 275 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,kaanapali-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


