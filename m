Return-Path: <linux-pm+bounces-28435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88439AD4990
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8384517B0A1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2776218AC7;
	Wed, 11 Jun 2025 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W93cHrYg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406221171F;
	Wed, 11 Jun 2025 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613466; cv=none; b=tcvIrf8QeJpP9uj2A7nOkxH6a5OENn3WLGk/FvopRsh/Kv1Wbbv143gSMLkq9Mcgi8eFqf1MrcgYHEkYW/aC9IJ3T+Zc2AQscnqSg4uhOwYfE+EZlCy42U5ysrZPdoq8fevK2v4fLT3m8hRTgOk1IRGSf7Qhh2LEhD3k//xlUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613466; c=relaxed/simple;
	bh=LxRm4DeSEs//MKBHHs/GlVji1LewyuuLa0J18JhIIkw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=D9nqMZ12pCPrDusWa3io3Uojr7fY97QjnbM3RdmmlAPmKBF0rk/QG3pMC1pBbHU0S+jIyJ0syDBkHpkIv0xa7vRpIg8OTHkl9IrsQImktJ6YfItSVh8r6mJH8KxTmCX4pUNhKXreb7sXiHtPhJzBlt0ryvO9XcliSMAxP+uOf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W93cHrYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4712C4CEEE;
	Wed, 11 Jun 2025 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749613466;
	bh=LxRm4DeSEs//MKBHHs/GlVji1LewyuuLa0J18JhIIkw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=W93cHrYgMjscdCqoOGFK76Xdsq0+4Ic+6c1WIcC0ch7RSKvRNiK6g36QFtyNbXSau
	 OH/boEDl4JKhNmg3RZUHTEBUvG8P2Fj0J5F3MocYYMcu5Tl8E24xJ52Foj9YRPu3wf
	 Vc9Z9vlheU2tD4u/XImruBo9mBOgC3FUSj3DIMWGgaLXMtv3U83hHqkcogVNXbFkVe
	 ihsU+88xgk2uPndu5+AQQQfOzmEpNwUanXHwrWDB4ZNsmKWamfpPRMj/K7tphLxHNX
	 cz8c3S1QWD4eBMlY5GkgrI6ZtA1c2q3FDJpi/qPvOfq5hbiWfZ5I0T08erXH66DHIX
	 D8auzCV/f1bFg==
Date: Tue, 10 Jun 2025 22:44:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
 Amit Kucheria <amitk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
References: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
Message-Id: <174961323702.3426131.5549067137523335657.robh@kernel.org>
Subject: Re: [PATCH v10] arm64: dts: qcom: ipq5018: Add tsens node


On Tue, 10 Jun 2025 17:03:34 +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem nodes and adding 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
> and 1 interrupt. There is no RPM present in the soc to do tsens early
> enable. Adding support for the same here.
> 
> Last patch series sent by Qualcomm dates back to Sep 22, 2023.
> Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
> and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
> confirmed this SoC is still active, I'm continuing the efforts to send
> patches upstream for Linux kernel support.
> https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/
> 
> [v10]
> 	*) Rebased onto updated pull of master to resolve merge conflicts in the
> 	   DTS patch
> 	*) Link to v9: https://lore.kernel.org/all/DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v9]
> 	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
> 	   v2 features as suggsted by Dmitry.
> 	*) Split patch 3 into two, one to update conditional statements as
> 	   mentioned above and the other to implement tsens IP v1 without RPM.
> 	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
> 	   from v7 to v8
> 	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v8]
> 	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
> 	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
> 	   v1 interrupts are set and watchdog isn't enabled.
> 	*) Tested on Linksys MX2000 and SPNMX56
> 	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v7]
> 	*) Updated cover letter
> 	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
> 	   no RPM and removed Dmitry's 'Reviewed-by tag
> 	*) Refactored patch 4 and split support for IPQ5018 from support for
> 	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
> 	*) Depends on patch 1 and 2 from patch series to add support for
> 	   IQP5332 and IPQ5424 applied on Feb 11 2025:
> 	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
> 	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v6]
> 	*) Include (this) cover letter
> 	*) Picked up Dmitry's Reviewed-by tag on patch 5
> 	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v5]
> 	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
> 	   which 4 are described and in use as per downstream driver and dts.
> 	*) Padded addresses of tsens and qfprom nodes with leading zeros.
> 	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v4]
> 	*) Documented ipq5018 in qcom,qfprom bindings
> 	*) Constrained ipq5018-tsens to one interrupt with description
> 	*) Added Rob's Acked-by tag
> 	*) Added Dmitry's Reviewed-by tag
> 	*) Fixed modpost warning: added __init to init_common
> 	*) Sorted tsens nodes by address
> 	*) Sorted thermal-zones nodes by name
> 	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/
> 
> [v3]
> 	*) Added the tsens-ipq5018 as  new binding without rpm
> 	*) Added Dmitry's Reviewed tag
> 	*) Fixed Dmitry's comments for error checks in init_ipq5018
> 	*) Ordered the qfprom device node properties
> 	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/
> 
> [v2]
> 	*) Sorted the compatible and removed example
> 	*) Fixed the name for new tsens_feature
> 	*) Used tsend_calibrate_common instead of legacy
> 	   and addressed comments from Dmitry.
> 	*) Squashed patch 3 & 4
> 	*) Fixed node names, order and added qfprom cells
>             for points seprately
> 	*) Squashed patch 6 & 7
> 	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/
> 
> George Moussalem (2):
>   thermal: qcom: tsens: update conditions to strictly evaluate for IP
>     v2+
>   thermal: qcom: tsens: add support for tsens v1 without RPM
> 
> Sricharan Ramabadhran (4):
>   dt-bindings: nvmem: Add compatible for IPQ5018
>   dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
>   thermal: qcom: tsens: Add support for IPQ5018 tsens
>   arm64: dts: qcom: ipq5018: Add tsens node
> 
>  .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
>  .../bindings/thermal/qcom-tsens.yaml          |   2 +
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
>  drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
>  drivers/thermal/qcom/tsens.c                  |  27 ++-
>  drivers/thermal/qcom/tsens.h                  |   4 +
>  6 files changed, 256 insertions(+), 9 deletions(-)
> 
> --
> 2.48.1
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: base-commit afc582fb6563b8eb5cd73f9eca52e55da827567f not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250610 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com:

arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dtb: thermal-sensor@4a9000 (qcom,ipq5018-tsens): compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,ipq5018-tsens'] is too short
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq8064-tsens', 'qcom,msm8960-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,mdm9607-tsens', 'qcom,msm8226-tsens', 'qcom,msm8909-tsens', 'qcom,msm8916-tsens', 'qcom,msm8939-tsens', 'qcom,msm8974-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,msm8953-tsens', 'qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,qcm2290-tsens', 'qcom,sa8255p-tsens', 'qcom,sa8775p-tsens', 'qcom,sar2130p-tsens', 'qcom,sc7180-tsens', 'qcom,sc7280-tsens', 'qcom,sc8180x-tsens', 'qcom,sc8280xp-tsens', 'qcom,sdm630-tsens', 'qcom,sdm845-tsens', 'qcom,sm6115-tsens', 'qcom,sm6350-tsens', 'qcom,sm6375-tsens', 'qcom,sm8150-tsens', 'qcom,sm8250-tsens', 'qcom,sm8350-tsens', 'qcom,sm8450-tsens', 'qcom,sm8550-tsens', 'qcom,sm8650-tsens', 'qcom,x1e80100-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq5332-tsens', 'qcom,ipq5424-tsens', 'qcom,ipq8074-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq6018-tsens', 'qcom,ipq9574-tsens']
	from schema $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: thermal-sensor@4a9000 (qcom,ipq5018-tsens): compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,ipq5018-tsens'] is too short
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq8064-tsens', 'qcom,msm8960-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,mdm9607-tsens', 'qcom,msm8226-tsens', 'qcom,msm8909-tsens', 'qcom,msm8916-tsens', 'qcom,msm8939-tsens', 'qcom,msm8974-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,msm8953-tsens', 'qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,qcm2290-tsens', 'qcom,sa8255p-tsens', 'qcom,sa8775p-tsens', 'qcom,sar2130p-tsens', 'qcom,sc7180-tsens', 'qcom,sc7280-tsens', 'qcom,sc8180x-tsens', 'qcom,sc8280xp-tsens', 'qcom,sdm630-tsens', 'qcom,sdm845-tsens', 'qcom,sm6115-tsens', 'qcom,sm6350-tsens', 'qcom,sm6375-tsens', 'qcom,sm8150-tsens', 'qcom,sm8250-tsens', 'qcom,sm8350-tsens', 'qcom,sm8450-tsens', 'qcom,sm8550-tsens', 'qcom,sm8650-tsens', 'qcom,x1e80100-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq5332-tsens', 'qcom,ipq5424-tsens', 'qcom,ipq8074-tsens']
	'qcom,ipq5018-tsens' is not one of ['qcom,ipq6018-tsens', 'qcom,ipq9574-tsens']
	from schema $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#






