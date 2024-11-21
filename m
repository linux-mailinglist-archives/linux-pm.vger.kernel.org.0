Return-Path: <linux-pm+bounces-17884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AE9D521B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F271E1F22BB2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631A1A2C0B;
	Thu, 21 Nov 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a7mDN+tp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0218A6B0;
	Thu, 21 Nov 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211383; cv=none; b=L+ZNiQmc7Yy6/QrZ0T2zOtOPo3qCqbjfPw0FxRG7t21L6GNr5gy9H1rJFiBWoZ51yReHcVUL4gTS93BHkhPszIGtoV9lUiGpf/wT+vY4HJVzYDPFJix+94lYzMBc32BxJh7N3UryzxD+Y7RsKVcD1XHtGjrJDsZgasIj22IkgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211383; c=relaxed/simple;
	bh=eYa0tafet6GRAMGRDmil5OxMlGok6oRDpRA8q5GaqSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AckmZWY7YG7QgtZ0VDt+/NQAfM3aKtgvc1hyiXgfW/ZOiRCg2O8Ny+hmo51Lfh8t23q8ABod6rnt1CyovWcpZO+C5aPp8nWkq2dFQGAz+Z5yu/YWCMfIuV7XPPgGdwdhsXIdMbNBdp/0VVdSDcJhQ6x8RJUu7S547iInA/KK6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a7mDN+tp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALAb2IR004466;
	Thu, 21 Nov 2024 17:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wm4fBSwIUToKWln2SasrDquBwxxQuyoC/VFXaV8gUBg=; b=a7mDN+tp1Pse+NEx
	JvtS0YY5fpvjTmp89EeOEHjoT+lgxxxl4bxFiewiglc7TK3rwt1gRYH9kCTrMjZa
	Bcjkq0bmkhcAO00oxo3UieUVyKk3v7X47KL/qIJc+F0zj4UKg+BwFZYkZpaN1O+/
	uyQco/4YtmsApCYzVaW9w2JiGGnDZ23PJqjQrNBWW7BXnn/lKbKmTbrMjW4lGNxH
	ITDSyj2alAwj5RsbYpdPtFnTW2vRU+ZeHoWHqqctfCSxXjCZrDqHKScJ/a5+nGsf
	yaIcseFC/LI5SdDCLy5XykEdlPne/bIPWns+9V0HoxHoNl6kh94/TVNPr549tX7T
	8ln6Ng==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ea74gdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:49:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALHncXk002470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:49:38 GMT
Received: from [10.216.2.20] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 09:49:33 -0800
Message-ID: <41977702-51da-42d3-ad18-0d77ba9c8b5b@quicinc.com>
Date: Thu, 21 Nov 2024 23:19:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/4] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-3-quic_rlaggysh@quicinc.com>
 <2b72c05e-eeb3-4c27-99b0-66bec8adba7c@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <2b72c05e-eeb3-4c27-99b0-66bec8adba7c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e1GqR4-eLESl8WGpAnRvkwwI50QgbygL
X-Proofpoint-ORIG-GUID: e1GqR4-eLESl8WGpAnRvkwwI50QgbygL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210135



On 11/21/2024 5:24 PM, Krzysztof Kozlowski wrote:
> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
>> SoCs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 9f315a51a7c1..dd7207eb3616 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>>  #include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>  #include <dt-bindings/firmware/qcom,scm.h>
>> @@ -4282,6 +4283,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
>>  			};
>>  		};
>>  
>> +		epss_l3_cl0: interconnect@18590000 {
> 
> 
> Drop unused label.
> 
This will be used by DCVS driver for getting the interconnect path.

> BTW, DTS is never before the driver. It suggests dependency. If you have
> dependency, it's a NAK.
> 

There is no dependency, I will rearrange the patches in next revision.

> Best regards,
> Krzysztof


