Return-Path: <linux-pm+bounces-31592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568BB15B74
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B3D5A2975
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A74275AE9;
	Wed, 30 Jul 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cTPbrNKu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABF26FDA9;
	Wed, 30 Jul 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867372; cv=none; b=WE83kWI3gsWljc0ycNULDnIqnKaoNRp8XKv9FAPoBWcwTREsilHwcM6LtyLUDAW7D/x3f/taSVLPg5t+IoMbCG02fTzoa5LZJ5EivdQ7hJYVZE0FAXHf+OZKNdWqc+S/sK4B1vlVm5QeIOu4rJhBlKksnnWe2VW4Aa7nA5b7p6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867372; c=relaxed/simple;
	bh=mzwHw+265Ro4LQQ1Rr7vd9ninEBSp7M3yuLpyZqTcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oOcew9xSEZ0JCjFwgN+nIZiqumPJrmykb+fhRKeh8k1VnL/eMZS0rzs0kdbeVZtQGdpNiBhWu5lE4b38grvUTc8CuCDvq1Hds5NWi1mrzj7AMMaVEn71iHZEK14DOORhpnF0cPxevhGfvT3AZA0zH/J4pm7cO6/Z28vDWPjlRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cTPbrNKu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U7iLCr016213;
	Wed, 30 Jul 2025 09:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	laY4sjzaZLR8SgMhPEYTnLhfZi9R4r0rn2mnqOqjZLM=; b=cTPbrNKu0M13t2oS
	QCREkDNHZ4N2AYTFH8ZG+j0khvtS4NVf3iEhEcXry4ERJ69FLL9N5ICiffYWqHcl
	2H+mZxd97AGNhuzfw3op3jmWOIkyEPzPV2FKWDrO7ju9qgaVq8sVdCKPwatfRh8I
	QBBiGIs1XVLGQ4JT25TfvK5MazH/2jzwSPqXNxEsinv3CzHjd7SUtWc1vvX5UGBI
	7wOs6wQgfUtL958TKJCUzLP4PutjsQCvHM4Cs3zWkapYj5/NY3wZT+S3vMmmhRkS
	wzJ1NsChTa4ITaxkanOneNtd8clzO4k4+o6YHPdm7gtGm7mQK9PPfSEdK+wHQpIn
	/uOdEg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 486v6y3jrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 09:22:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56U9Mkmh005189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 09:22:46 GMT
Received: from [10.151.37.100] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Jul
 2025 02:22:41 -0700
Message-ID: <2c165ddd-f6b6-45b6-a319-8944fab324f2@quicinc.com>
Date: Wed, 30 Jul 2025 14:52:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_mdalam@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-2-quic_varada@quicinc.com>
 <1705cfd6-95fe-4668-ae3b-f8fc7321d32a@kernel.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <1705cfd6-95fe-4668-ae3b-f8fc7321d32a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2NSBTYWx0ZWRfX0ugXjftaA4Yl
 oroN+K7j4TzT6tRyfDJT+TJLmOjFu9NC7YP1E7pKGzQEF43eR+B7EFf9+FctEYewdeCJQTZci81
 OXoFePgSrrOqq/A1yeW/cNRyGNXiXH1toyMDPu2xmSBUgd+b7zT65O5IR529/D+3rJA9PeayYDn
 F493PR2DGT4G3VW5+j8f1bTdefsIZMtv6Dfttq7L0/Q7bfVsOfXLuKpneOXDtpRVFfCQ9qB+Ko6
 /WYjZiMt1DKunF0NVxh3agfVGgYlREbU7qoSCjEKUpe/fub8Nj/zrQ8nAs8TnkHHAHPuyaWI51k
 nhItJga/ka47Wg5n6P8+Z+F+xvZ4rpf5Wigqe5amq5NhxowgvqWywo2B80zsmTqjbmBnsi8PK9K
 zTHOt7ENMKe6U0ndwWVyj+A6wALscBXgobRU7jwt8UIuvmlLyqPFZaVWshXTroToZJin3IC4
X-Proofpoint-GUID: mKGqk8IfXU6HMPAi6WSQj-zZubvVai_w
X-Proofpoint-ORIG-GUID: mKGqk8IfXU6HMPAi6WSQj-zZubvVai_w
X-Authority-Analysis: v=2.4 cv=QYlmvtbv c=1 sm=1 tr=0 ts=6889e467 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=WXmMl29sQjXzjk-Zzf0A:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 suspectscore=0 mlxlogscore=805
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300065



On 7/30/2025 2:32 PM, Krzysztof Kozlowski wrote:
> On 30/07/2025 10:13, Varadarajan Narayanan wrote:
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm APSS IPQ5424 Clock Controller
>> +
>> +maintainers:
>> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> +  - Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> My v2 comments seems still valid. Your explanation suggests they moved
> on, so it is confusing to see them here.
> 
> Sricharan and Md Sadre, can you provide Acks for this?
> 
Ack. Please feel free to remove my name.

Regards,
  Sricharan


