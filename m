Return-Path: <linux-pm+bounces-8694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10928FE247
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC371F21D9C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6014E2FF;
	Thu,  6 Jun 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GLEjZbbp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD36D1B9;
	Thu,  6 Jun 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665034; cv=none; b=nWKgzcxvFB+gRqW2jzBqxqF6R+OKyS4LIWQCf2tUQpoNRUhT9ItezIIjyZzQ8kHjoocrGWEmkoRDboYvf7v9v4C898pGu+y4vwuSMa6lwYszganN+RGS4Nr1a900quviHYlXx9rqXLsit9jWgduzhpw/Dh5ReTe+rySM8RmpRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665034; c=relaxed/simple;
	bh=EtGIx90prizG+AnE+pFraDLV268gRS80lT4+w+aqaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3p26rtqxSIdhOCxgcJzuk+pzXGxjWCMiKmdX2HNY1Yl9p11+IoKAbmTzA4YS3tZgPdVkorqRvtXcBxZToy1AMsurdAfBkHd+FfFwi6MYtjONrPmro6vdSeepWSbc9N5A8tnuVWimnIZPqmhj9Y+u8uQbcwhDVmF5uzL5kRuAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GLEjZbbp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455KIBiS004162;
	Thu, 6 Jun 2024 09:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zsBeWenux3zM5BvoDcuWn2gC94RPHDwvuvLCikPbdsY=; b=GLEjZbbpMY6av01w
	XDxtPr5aOkXg59+kr0F4JyYqZ/PGu9tgH5e+u3GvMz7QKkDTiNKaK3B5U1MjHBm/
	boStCUGknYtFuWDYvQthlIjwcjZQf993vum9Rforj2hL2ohDMovtHaCSrCem1XAP
	xmSsVHIKe76uKIKadBkWYKinD0cI7zQhBu3yTKckd/aBQlKlWkp4RLaBDOQ+c8Ht
	NKATM3bhsBePxpD4nQpT7C6jOJ55K9kAOUs3qsxBtXsVpAgvOpUwGKTHMT0/U08d
	Juxkvvg3BTfqtbMW1L+9QiJtR7I4nYBsmsNAhsPOteMpqA09Eiv7lfFUjHaGg+yk
	yabyLQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjxxas99h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 09:10:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4569ACcj031595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 09:10:12 GMT
Received: from [10.214.67.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 02:10:08 -0700
Message-ID: <b9ee77da-bd51-4d32-8f35-d38fe8b77f44@quicinc.com>
Date: Thu, 6 Jun 2024 14:39:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add BWMONs
To: Sibi Sankar <quic_sibis@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-4-quic_sibis@quicinc.com>
Content-Language: en-US
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <20240604011157.2358019-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GntE29tcrGe8qrZnNCwTRtwg1-kSzRFh
X-Proofpoint-GUID: GntE29tcrGe8qrZnNCwTRtwg1-kSzRFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=900 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060067



On 6/4/2024 6:41 AM, Sibi Sankar wrote:
> Add the CPU and LLCC BWMONs on X1E80100 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 169 +++++++++++++++++++++++++
>   1 file changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 1929c34ae70a..d86c4d3be126 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5329,6 +5329,175 @@ cpu_scp_lpri1: scp-sram-section@200 {
>   			};
>   		};
>   
> +		pmu@24091000 {
> +			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
> +			reg = <0 0x24091000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
> +
> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +			llcc_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {

Nitpick,In one table, we start from ‘opp-0,’ while in the other table, 
it begins with ‘opp-1,it is better to make it consistent across table.

> +					opp-peak-kBps = <800000>;
> +				};
> +
> +				opp-1 {
> +					opp-peak-kBps = <2188000>;
> +				};
> +
> +				opp-2 {
> +					opp-peak-kBps = <3072000>;
> +				};
> +
> +				opp-3 {
> +					opp-peak-kBps = <6220800>;
> +				};
> +
> +				opp-4 {
> +					opp-peak-kBps = <6835200>;
> +				};
> +
> +				opp-5 {
> +					opp-peak-kBps = <8371200>;
> +				};
> +
> +				opp-6 {
> +					opp-peak-kBps = <10944000>;
> +				};
> +
> +				opp-7 {
> +					opp-peak-kBps = <12748800>;
> +				};
> +
> +				opp-8 {
> +					opp-peak-kBps = <14745600>;
> +				};
> +
> +				opp-9 {
> +					opp-peak-kBps = <16896000>;
> +				};
> +			};
> +		};
> +
> +		pmu@240b3400 {
> +			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
> +			reg = <0 0x240b3400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +			operating-points-v2 = <&cpu0_bwmon_opp_table>;
> +
> +			cpu0_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-1 {
> +					opp-peak-kBps = <4800000>;
> +				};
> +
> +				opp-2 {
> +					opp-peak-kBps = <7464000>;
> +				};
> +
> +				opp-3 {
> +					opp-peak-kBps = <9600000>;
> +				};
> +
> +				opp-4 {
> +					opp-peak-kBps = <12896000>;
> +				};
> +
> +				opp-5 {
> +					opp-peak-kBps = <14928000>;
> +				};
> +
> +				opp-6 {
> +					opp-peak-kBps = <17064000>;
> +				};
> +			};
> +		};
> +
> +		pmu@240b5400 {
> +			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
> +			reg = <0 0x240b5400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +			operating-points-v2 = <&cpu8_bwmon_opp_table>;
> +
> +			cpu8_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-1 {
> +					opp-peak-kBps = <4800000>;
> +				};
> +
> +				opp-2 {
> +					opp-peak-kBps = <7464000>;
> +				};
> +
> +				opp-3 {
> +					opp-peak-kBps = <9600000>;
> +				};
> +
> +				opp-4 {
> +					opp-peak-kBps = <12896000>;
> +				};
> +
> +				opp-5 {
> +					opp-peak-kBps = <14928000>;
> +				};
> +
> +				opp-6 {
> +					opp-peak-kBps = <17064000>;
> +				};
> +			};
> +		};
> +
> +		pmu@240b6400 {
> +			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
> +			reg = <0 0x240b6400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +			operating-points-v2 = <&cpu4_bwmon_opp_table>;
> +
> +			cpu4_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-1 {
> +					opp-peak-kBps = <4800000>;
> +				};
> +
> +				opp-2 {
> +					opp-peak-kBps = <7464000>;
> +				};
> +
> +				opp-3 {
> +					opp-peak-kBps = <9600000>;
> +				};
> +
> +				opp-4 {
> +					opp-peak-kBps = <12896000>;
> +				};
> +
> +				opp-5 {
> +					opp-peak-kBps = <14928000>;
> +				};
> +
> +				opp-6 {
> +					opp-peak-kBps = <17064000>;
> +				};
> +			};
> +		};
> +
>   		system-cache-controller@25000000 {
>   			compatible = "qcom,x1e80100-llcc";
>   			reg = <0 0x25000000 0 0x200000>,


Thanks,
Shivnandan

