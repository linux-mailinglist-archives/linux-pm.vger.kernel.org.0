Return-Path: <linux-pm+bounces-8998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCD904D2F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55850283EB6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0716C69A;
	Wed, 12 Jun 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LsK0cqFD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC716B74B;
	Wed, 12 Jun 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178870; cv=none; b=He+Bi0yOmKZtDjKrkLWF/u/1VMFd51URQi2JUEWQsfDPNn2o/euelAVQGlRbPauozF9OOKFIID8zi+fgn72/MvsAV5Uiy7+fL9PnfnrMfRiz1zqjjvpOvlfR8In0hojy2xWFlHgyuuVBWZWjKwaf0zwrhvOaVRIWdNMn5QMBPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178870; c=relaxed/simple;
	bh=aM676pmsaOxULc+LMP3oYXBwRDawjVtxLhJNCT6DRkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6TMHVL2hzC/QxMAIPm6YlL7k9L8bYa3RZbEuuoG6NAvfGf4l81eFj9WfJiAXUNrwAS8a8U5enPEtU2NtEHibyqoVPF7NusHoReR2W1NW0CH6LNu0OQ9e3jXJiLTUIoVxf0Vrrec92IXeKA8La+5kKMw5Q4cuSd202THOVFXqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LsK0cqFD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C21RpI008531;
	Wed, 12 Jun 2024 07:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EsTbt4PEP9sWJr87DdEtwdWk
	hcvYYOYQezIMyW/eHiA=; b=LsK0cqFDerjWmlwK6HDls+kpzZIsMZ52a+EE4GiG
	zqYPdsnULOzte9DAqBFiCaHy6iH74ie+ImyyVJq/u9SVwcaSAeKO7BbXi4HddGkL
	lAQTdFMz4+iL+A4rfWNzeRwNQqwrZTOm30EhDNLauy6wXdKM1Rd6Td6Pe/BFfPWw
	dbtfZOIciW1GpLd1IJKgcWUhbpAGcSs4tG1DVbcnygRlOHxvxhGhSnkRqc/jZMHo
	NQhHMlvyy+H0Hld57HAOQkyxfuuPDdbO75KthBNcWo9GcyaUwin6sYsTgjbiroRn
	OHZOFQjl+6LP3mqcirQsg7icoTfN6vRoECj2VLC2NgbKXw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype913jbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 07:54:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C7s68t008333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 07:54:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 00:53:58 -0700
Date: Wed, 12 Jun 2024 13:23:54 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Niklas Cassel
	<nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jeffrey Hugo
	<quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v14 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
Message-ID: <ZmlUElvlOPBdfn61@hu-varada-blr.qualcomm.com>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Lo55Ft6wj64UAY2TTCisH-VnaWG_kxD
X-Proofpoint-ORIG-GUID: 9Lo55Ft6wj64UAY2TTCisH-VnaWG_kxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120055

Konrad,

> Changes in v14:
> - Rebase
> - Drop cpufreq probing block (merged)
> - Pick up tags
> - Drop quotes from CPR3 bindings $id:
> - Drop useless description: under compatible:
> - Link to v13: https://lore.kernel.org/r/20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org

This patch series is needed for IPQ9574 CPR support. Do you plan
to post a new version or can I try to address the comments and
post a new version?

Thanks
Varada

> Changes in v13:
> - blacklist -> blocklist in cpufreq commit message
> - rebase atop drivers/genpd introduction
> - remove quotes in cpr bindings
> - describe reg entries in cpr bindings
> - define the # of power-domains in cpr bindings
> - pick up tags
> - Link to v12: https://lore.kernel.org/r/20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org
>
> Changes in v12:
> - Add the !independent! patch to block cpufreq-dt from probing on 8998 (it tries
>   to when we attach OPP tables to the CPU nodes)
> - Include all promised changes to the CPR3 driver from v11 (I managed to
>   send the wrong version of that patch last time around..)
> - Partially rewrite debugfs code (to make it work and be cleaner)
> - use FIELD_PREP/GET throughout the driver (managed to squash a bug when
>   exploring that)
> - Fix and finish the removal of cpr_get_ro_factor() by introducing
>   cpr_thread_desc.ro_scaling_factor_common
> - Replace underscores in node names with '-'
> - Fix some formatstring issues that clang apparently doesn't care about
> - Link to v11: https://lore.kernel.org/r/20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org
>
> Changes in v11:
>
> CPR COMMON:
> - split the commonizing patch, make it actually do what it says on the
>   tin..
> - fix some overflow bugs
>
> CPR3:
> - fix some overflow bugs
> - don't assume "lack of qcom,opp-?loop-vadj" means val=0"
>
> CPR BINDINGS:
> - drop quotes in items
> - drop clock-names (there's just a single one)
> - rewrite the description a bit
> - fix up the example
> - drop bogus minItems
> - "acc-syscon" -> "qcom,acc"
>
> DTS:
> - fix qfprom children so that the bits=<> doesn't overflow reg[size]
> - drop unrelated changes
> - place one reg entry per line
>
> Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org
>
> Changes in v10:
> - Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
> - Use b4 (it may be the first time you're receiving this if git send-email
>   omitted you before..)
> - +Cc Robert Marko (expressed interest in previous revisions)
> - Add "Document CPR3 open/closed loop volt adjustment"
> CPR:
> - %hhu -> %u (checkpatch)
> CPR BINDINGS:
> - Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
>   but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
>   follow soon..)
> - Drop Rob's R-b (as things changed *again*, please take one more look to make
>   sure you're okay with this file, Rob..)
>
> Link to v9:
> https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/
>
> Changes in v9:
> - Restore forgotten MAINTAINERS patch (oops)
> CPR:
> - Include the missing header (big oops!)
> - Fix kconfig dependencies
> CPR bindings:
> - Fix cpu reg in example (why didn't dt_binding_check scream at that)
> - Add newlines between nodes in example
> - Change opp table node names to opp-table-cpu[04]
> - Change opp table labels to cpu[04]_opp_table
> - Change CPRh opp subnode names to opp-N from oppN
> - Remove some stray newlines
> - Bring back nvmem-cell-names and add the 8998's set
> - Allow power-domains for VDDCX_AO voting
> - Remove Rob's r-b, there's been quite a bit of changes..
> CPR DT:
> - Send the correct revision of the patch this time around..
> OPP bindings:
> - Add Rob's ack
>
> Link to v8:
> https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/
>
> Changes in v8:
> - Overtake this series from AGdR
> - Apply all review comments from v7 except Vladimir's request to
>   not create the include/ header; it will be strictly necessary for
>   OSM-aware cpufreq_hw programming, which this series was more or
>   less created just for..
> - Drop QCS404 dtsi change, account for not breaking backwards compat
>   in [3/5]
> - Add type phandle type reference to acc-syscon in [1/5]
> - Update AGdR's email addresses for maintainer entries
> - Add [2/5] to make dt_binding_check happy
> - Separate the CPRh DT addition from cpufreq_hw addition, sort and
>   properly indent new nodes
> - Drop CPR yaml conversion, that happened in meantime
> - Reorder the patches to make a bit more sense
> - Tested again on MSM8998 Xperia XZ Premium (Maple)
> - I take no responsibility for AGdR's cheeky jokes, only the code!
>
> Link to v7:
> https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/
>
> Changes in v7:
> - Rebased on linux-next as of 210901
> - Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
>   following what was done in commit c77634b9d916
>
> Changes in v6:
> - Fixes from Bjorn's review
> - After a conversation with Viresh, it turned out I was abusing the
>   OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
>   so now the driver is using the genpd created virtual device and
>   passing drvdata instead to stop the abuse
> - Since the CPR commonization was ignored for more than 6 months,
>   it is now included in the CPRv3/4/h series, as there is no point
>   in commonizing without having this driver
> - Rebased on v5.13
>
> Changes in v5:
> - Fixed getting OPP table when not yet installed by the caller
>   of power domain attachment
>
> Changes in v4:
> - Huge patch series has been split for better reviewability,
>   as suggested by Bjorn
>
> Changes in v3:
> - Fixed YAML doc issues
> - Removed unused variables and redundant if branch
>
> Changes in v2:
> - Implemented dynamic Memory Accelerator corners support, needed
>   by MSM8998
> - Added MSM8998 Silver/Gold parameters
>
> This commit introduces a new driver, based on the one for cpr v1,
> to enable support for the newer Qualcomm Core Power Reduction
> hardware, known downstream as CPR3, CPR4 and CPRh, and support
> for MSM8998 and SDM630 CPU power reduction.
>
> In these new versions of the hardware, support for various new
> features was introduced, including voltage reduction for the GPU,
> security hardening and a new way of controlling CPU DVFS,
> consisting in internal communication between microcontrollers,
> specifically the CPR-Hardened and the Operating State Manager.
>
> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
> from the mid-range to the high end ones including, but not limited
> to, MSM8953/8996/8998, SDM630/636/660/845.
>
> As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
> this is limited to the CPU context; despite GPU CPR support being not
> implemented in this series, it is planned for the future, and some
> SDM845 need the CPR (in the context of GPU CPR) to be configured from
> this driver.
>
> It is also planned to add the CPR data for MSM8996, since this driver
> does support the CPRv4 found on that SoC, but I currently have no time
> to properly test that on a real device, so I prefer getting this big
> implementation merged before adding more things on top.
>
> As for MSM8953, we (read: nobody from SoMainline) have no device with
> this chip: since we are unable to test the cpr data and the entire
> driver on that one, we currently have no plans to do this addition
> in the future. This is left to other nice developers: I'm sure that
> somebody will come up with that, sooner or later
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> AngeloGioacchino Del Regno (7):
>       MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
>       dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
>       soc: qcom: cpr: Move common functions to new file
>       soc: qcom: cpr-common: Add support for flat fuse adjustment
>       soc: qcom: cpr-common: Add threads support
>       soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
>       arm64: dts: qcom: msm8998: Configure CPRh
>
> Konrad Dybcio (2):
>       dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
>       soc: qcom: cpr: Use u64 for frequency
>
>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  286 ++
>  MAINTAINERS                                        |    6 +
>  arch/arm64/boot/dts/qcom/msm8998.dtsi              |  757 ++++++
>  drivers/genpd/qcom/Makefile                        |    2 +
>  drivers/genpd/qcom/cpr-common.c                    |  362 +++
>  drivers/genpd/qcom/cpr-common.h                    |  109 +
>  drivers/genpd/qcom/cpr.c                           |  394 +--
>  drivers/genpd/qcom/cpr3.c                          | 2855 ++++++++++++++++++++
>  drivers/soc/qcom/Kconfig                           |   22 +
>  include/soc/qcom/cpr.h                             |   17 +
>  11 files changed, 4456 insertions(+), 368 deletions(-)
> ---
> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
> change-id: 20230217-topic-cpr3h-de232bfb47ec
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>

