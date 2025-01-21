Return-Path: <linux-pm+bounces-20737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6247A17686
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 05:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B434218876C1
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0667183CBB;
	Tue, 21 Jan 2025 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnuzQM3D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6D45979;
	Tue, 21 Jan 2025 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434086; cv=none; b=Dd5KnIqipR7AEvAmq+s5BwK04ZnHVG50CUruF+7Rv/S0fIfwD/Day/yvcIYBPTrfBUjD8uv0Zbz/DR2OLfMKJnQ+EKKfzE6b6IgNVpRrwgu+qpNLYafbmfDF+Pf4vj1eEgeWAu43YSaqzz46LPaj/RIx5vo7XtxLtyF9oDlskOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434086; c=relaxed/simple;
	bh=ic2Vj9clbccTWpFYpYbpq3VVbXcpDTrMDm0/0NZg7Ug=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pGxKZCt1ZExrF/u5lxmAim3yNsplAock/YrvN8CKPdpYUyctN3w2rmodltrjVkI4rW8fFu05ElFSGdj3Tptr2EIApn4CR+Y0yY86dZXxMdwbYpB0UzTeTrOKXv1c6WBf8Hq1EObmMi/q9Ft4E0lXX2d34mSBeo2j0CIwg3rTo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnuzQM3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0496C4CEDF;
	Tue, 21 Jan 2025 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737434086;
	bh=ic2Vj9clbccTWpFYpYbpq3VVbXcpDTrMDm0/0NZg7Ug=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RnuzQM3DXktPnklWQtlLdFDBZugcN+9yBDvezfwfwmkdmn8a9fLfmQpzGNvbpG2FG
	 oAlnEMrh5/uweTxegEfC9uTTRmPP1D9Dn4rJjtqYGiKIZl4P9akOkzd2gbfi2HoWgz
	 cwbmjXgG5Kc+pHgBLkXjHoyXl/TDwO52raTS89fNZnFbPCi1tjXuWtUhRqILIGQUI0
	 mrfXK/dN6yibPywWcMXxEiQcGuBXcWcj7eJFChr7yZAuJ75+giOfTI822HouQs3gDY
	 C7C5C6eeYic/Vv2hK5tBetF17tGaPY40p6WYcB39yymWfXwcW+1pFi3BmQaUbk2vIq
	 iujUnx7lk6aug==
Date: Mon, 20 Jan 2025 22:34:44 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 linux-pm@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Liang Chen <cl@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, 
 linux-scsi@vger.kernel.org, YiFeng Zhao <zyf@rock-chips.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
 <1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com>
Message-Id: <173743408485.1359379.11212838152081459014.robh@kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: ufs: Document Rockchip UFS host
 controller


On Tue, 21 Jan 2025 11:00:21 +0800, Shawn Lin wrote:
> Document Rockchip UFS host controller for RK3576 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v6: None
> Changes in v5:
> - fix indentation to 4 spaces suggested by Krzysztof
> - use ufshc for devicetree example suggested by Mani
> 
> Changes in v4:
> - properly describe reset-gpios
> 
> Changes in v3:
> - rename the file to rockchip,rk3576-ufshc.yaml
> - add description for reset-gpios
> - use rockchip,rk3576-ufshc as compatible
> 
> Changes in v2:
> - rename the file
> - add reset-gpios
> 
>  .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml:91:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml:91:1: found character '\t' that cannot start any token
make[2]: *** Deleting file 'Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.example.dts'
Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml:91:1: found character '\t' that cannot start any token
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


