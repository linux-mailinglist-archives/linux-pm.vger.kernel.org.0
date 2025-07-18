Return-Path: <linux-pm+bounces-31055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C6B09F3C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3773A36E9
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7995298255;
	Fri, 18 Jul 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="juwgGFnd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F61FBCA1;
	Fri, 18 Jul 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830491; cv=none; b=NHTSlljd7KfHStU0KrCiIgplREKzgxUjU93sFmdNe4QsPb/7X/VgMvz/YAo+K9mdglf7/Nb4PXd/+sz4VK+uCFq+asDIJIitZJUpxJGO1OatvKavaWsbwP71yrVuYtChiE1+OEkMEQQhcltrTp7ZDgLkmYmozl06hJT7jHCQcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830491; c=relaxed/simple;
	bh=nuXXOvXbKTzt7K8s1oIDUpFZAn9CE38lj6C9oBaYe9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A+SHKbMIA7HX8L38JL6YiK/vmwRrvWWsjx6q1eWMpDq5uJUyW7X3HFh8EDUMOHxyapqRmV2A3c/Uqet6qeW9eMSOVgDt1yhsotiFGcoMDlNdvFl55QhjiDouPgg79jif+T44rWt0KevmSI7DmSsuC26dueIkEPwZFayR2co4sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=juwgGFnd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8e3tl025212;
	Fri, 18 Jul 2025 09:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HzPBi0s9nzPlSsm3pTGmzeeOwU3mkdAfKiTL3w4+NQY=; b=juwgGFndcmki8xOU
	XMtxc7IEJbS7mg/VDlpRDTGTcfLSWqwCtCbKcrLO+hQNz5qOfxkR/v3P6Vd0A9cM
	a42w5pSP+LvOV9wFkjEEFe2GxJxR2UOfqq3zRjbK4AQ4Fr4GFvuTpBMFP5k7Un4d
	2V7ozeJqSwQtKl2WwXmSGHNv/vRM9Hqq1Exz8llle2+FbzDYBqA2j5XoduDaBgoc
	Y471pUWk8QhzZDSD5VVmKxOViL/FjBIaVKEThGwBu5xkY5hR66hRZ77fOu6MmIFi
	GFWulMqLJBRlo4nW7Nk6rpygNe2IxVMo0BdpD/R2orAppgdpFTHYmmQfJDPiZd69
	IhdlWA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqf3y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:21:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I9LIu5011467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:21:18 GMT
Received: from [10.253.76.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 18 Jul
 2025 02:21:11 -0700
Message-ID: <14bcf0df-c5e2-45aa-92aa-cd39efca02a6@quicinc.com>
Date: Fri, 18 Jul 2025 17:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] clk: qcom: ipq5424: Enable NSS NoC clocks to use
 icc-clk
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-2-f149dc461212@quicinc.com>
 <ad726c8c-0eb0-4498-a430-f906ea61c80f@oss.qualcomm.com>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <ad726c8c-0eb0-4498-a430-f906ea61c80f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a120f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=TJLCjfOjLzGPONWhXh8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 18u6dTxShwVeyvrhRI3uPcdjCAEG6d1B
X-Proofpoint-GUID: 18u6dTxShwVeyvrhRI3uPcdjCAEG6d1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3MyBTYWx0ZWRfX8Ge64Xx0bmEz
 zFf32vV+pMfPIZgBW6rYjQyQqiFc3VxpII1zyUi+s1hYTxGSEe3hM0k69gQpIjUe4GgfoQle4mu
 rwiTMdqFSTLewifChnohha+vnO7iaHqz2ecbpsBPuUv3MrZlr4FSZmNARIFrulbWItgh8IVFluD
 aXVxJu5zLlD6okxujjdNDEBOE5XDOlEo+oZ1i6wnJjYELLPjS4UL0VeIQl61bi8JijmK4u4ufU0
 kxW1l/1CXmE56c5ikcTx6CB/Tqz5coUuOkOd6KOY8KV3wjiUF1H3W6sC61k3wD2l5azHHGVtao+
 ZkMuZeGDv7KA+PI/BIAcC1NuOM/UtFEm9cYt3JLsmEXhjE4osoxJ3Gj6J8H36lSyaRbOA4cFhja
 uzbFl95EwOH1brwQVy81dibMVVgjk+GfkjTXGMxTCu5YXw2RmRFqqcyFytxdGob/ZUQG6RED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180073



On 7/18/2025 4:40 AM, Konrad Dybcio wrote:
> On 7/10/25 2:28 PM, Luo Jie wrote:
>> Add NSS NoC clocks using the icc-clk framework to create interconnect
>> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Are there any other similar clocks that we should expect to pop up
> in the future? We should most definitely have a single commit that
> takes care of everything that'll be used going forward.
> 
> grep "\[.*NOC.*CLK\]" drivers/clk/qcom/gcc-ipq5424.c | wc -l
> 
> returns a number of them that aren't described as icc clocks, most
> notably the GCC_CNOC_USB_CLK is consumed as a regular clock.

Thank you for the suggestion. I will update the patch to enable the
necessary additional NOC clocks and register them as ICC clocks, all
within a single commit.

> 
>>
>> Also update to use the expected icc_first_node_id for registering the
>> icc clocks.
> 
> This is a separate fix

OK, I’ll split this out into a separate patch/fix in the next version.

> 
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq5424.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
>> index 3d42f3d85c7a..3a01cb277cac 100644
>> --- a/drivers/clk/qcom/gcc-ipq5424.c
>> +++ b/drivers/clk/qcom/gcc-ipq5424.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> Please follow the latest recommendations for the copyright notices

OK, I will update in the next version, thanks for pointing out.

> 
> Konrad
> 
>>    */
>>   
>>   #include <linux/clk-provider.h>
>> @@ -3250,6 +3250,9 @@ static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
>>   	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
>>   	{ MASTER_CNOC_PCIE3, SLAVE_CNOC_PCIE3, GCC_CNOC_PCIE3_2LANE_S_CLK },
>>   	{ MASTER_CNOC_USB, SLAVE_CNOC_USB, GCC_CNOC_USB_CLK },
>> +	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
>> +	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
>> +	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
>>   };
>>   
>>   static const struct of_device_id gcc_ipq5424_match_table[] = {
>> @@ -3284,6 +3287,7 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
>>   	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
>>   	.icc_hws = icc_ipq5424_hws,
>>   	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
>> +	.icc_first_node_id = IPQ_APPS_ID,
>>   };
>>   
>>   static int gcc_ipq5424_probe(struct platform_device *pdev)
>>


