Return-Path: <linux-pm+bounces-31845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C52B19B09
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E85E189615A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574C226863;
	Mon,  4 Aug 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aRz4/Uiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7422E3700;
	Mon,  4 Aug 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285202; cv=none; b=Bb3fTPUf+y8W3ETQUmaTr+m/YRRJT5MtNmckX+KM2FQsuflaH40o5+Stkb5epYb+aAaHl7HCDh4hksYwBlLEL83V33kp79ySXKCp2R+P91HUNDIn15zbRKon/1nW7Z4IRbzAZB+RAW0/LwvIYkYMApLxmyMumBXtJFU/ZqupWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285202; c=relaxed/simple;
	bh=8+SICm9T0nIjgH/zBLSXN/HXO61ycWSipS4HLigNX5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ngP8aYTkj4K9NNAtsmC6rvds9uIv23Jr5W8Ya6sRCry6y8IA6ogdLUcOgWAzIdNpftdDd707Ukyw4oRLFU8gul1vuUmPzLNO2QuZRl97QxLrbKU2wtZvkPVwHOo1jFjCdaLsDF8PNDRsVpmnFgOHLFKeEEY4ZAz05nTUkOhJ/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aRz4/Uiz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MpL5J014583;
	Mon, 4 Aug 2025 05:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFGkS54YVV1zT1y+FDj06DTTUmT2+doAase5afQ5Xks=; b=aRz4/Uizc22Hw+Ox
	VXlc/akGK2IrRk7OSNyVWqEJE6sjVoqFdmUm9HJh6NTMWhGYaEJuFHa/mbAXOblc
	A0eDDMp0/6A3haQZHPVadpbzLBQRdTpnxLPar1vpMVIIUN/HmLXxDzQHg5qtq/Oq
	DRzWCQW0U9tMvEWU+atpP7R7Pv8fJn4hlsxYKs3BumwI7suwk/nkS8inCzaJ2CxO
	o2otFXTk4gvIunjJicKNMIQx3ai0n26EDJ3wJQlAsr5zOJkI/7MsmrqIeyICUai2
	LyBktD6bRHUgS1tlDw15v1oKHp5QM6ztGxpN7tiq1GGy1Ne2vu9rSG5YSE8ogDEI
	02/eKQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc3g3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 05:26:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5745Qbr3020903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 05:26:37 GMT
Received: from [10.218.33.29] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 3 Aug
 2025 22:26:33 -0700
Message-ID: <a9d9f421-1bde-4609-81db-b139952bfd3d@quicinc.com>
Date: Mon, 4 Aug 2025 10:56:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        "Georgi
 Djakov" <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v4oskueLB_Nw6eZ2GoKMkGx_9jOvzuXa
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6890448e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=m_ZRiPf0wcHI9QKGqZsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: v4oskueLB_Nw6eZ2GoKMkGx_9jOvzuXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNSBTYWx0ZWRfX7PezlHO1SWJw
 Zx1a8IQ+x7HOni44pKU1aCxhArWiHloWHYfOjokoPYshoCurJYO+YpnfHbIbiMEhkR02rkhET2f
 u7fXu7V5chp9MwyDhtzAzDMJh1vFsFqAERNlqJRG8+yUM4c7k9cc4d/iPPjnYP/clTI3yrrZNRe
 RPDpPvpHJS3FfNZfc/CsyHUW3ewUFJEZGzP1paVb+gSBVjK5Jl3CKp5QT1p9eR/6v1FqKenoIf8
 AXImSy281MEkZ3T2su8JoAtZm5X1t7Om4Mz/1V1tTrzBcpC/NJLhd3LbY6WNz5ICkTRqXi6olKc
 N0nAmx9UCMFOKiUPLlHnYtdXRK5IVlVkmkjeCNC8DpXhPK4xh2Vbo6l/uSzVMP/wrYhDRXIdYFt
 JmOMh8J+8kvIpxCFBRFLEePqbnP96GBCVTaT5CoOxLhtg55g7bEmog5iERz4Bu5Bl31JZUvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=731 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040025



On 8/4/2025 10:35 AM, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

This patch is functionally depends on cpufreq-w node change [1].

[1] https://lore.kernel.org/all/20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com/

Raviteja, As discussed, please mark the dependency on this change.

Thanks,
Imran

