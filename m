Return-Path: <linux-pm+bounces-13506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A596AFBF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50688B217B4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 04:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F280C0C;
	Wed,  4 Sep 2024 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ml8eLJsy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9143ABD;
	Wed,  4 Sep 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423723; cv=none; b=ZmWj3WFZPfkXCncI9Dj1bw1PDb3UEG8SDNyDXtiEKvONk4XAZrEMWZWbaVTwaq049tXdc2nXxSlkKqug/Qrse0H42RtoguzUeO+OWXR15gtKOPPdRpD56EVroGWpPl7KBa5kKLdzrenh6SnLRXfeJUSPapTXLgH5lihmxlUPQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423723; c=relaxed/simple;
	bh=Qu1XPVpPvKdJChKZ0hFB2LCzirvnV2J97z/asZP6aS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MXePRoRupXiobobawAGE66oyYgGCPq4vU9x0oZdwzV9pabyvQ6WFosPvSWgG/XH4U2d7jueUPmrv23hzF2BzEh/+U6IdZSThHeEN4G66xKfH9Dfci0lAfMhPdZq5o8uNX9VLNK50vwKo3/7aW0jMGzcQ3EDZrdqdRGpHwtHOM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ml8eLJsy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JUOIV009469;
	Wed, 4 Sep 2024 04:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HW3mQvPMmVqChJdC3nwsM+UdMjhqyfrsXmn6QSnP3Xo=; b=ml8eLJsysVdtrn7s
	/gKt8MsgOJc4G29b+6OE8Zo3BjnEHk2SBKvYgpbemQDeWYhjhYWmqELvp8+zJXOZ
	oFvdOxt/7SZ3epCmmPzzev/RljDVyPG7tpsk+0Ddak9NGOlaoSanVDZhe0ZdSNWi
	NEnMFN1DG1JW8DMls8hNGbswVXsi5qOxj9V1Z87lMpSK6TubTj29f6N+0sEkra1/
	9T+z4I5noQPoR4g/CKmktYptfaPP3x9TVYa0xnEs1XdIZ0nET1oltpkeY06xlmwi
	8lmIDaaouGIDh3WIfSrp4Gi5GOwzpGoenyDGMvSlNLUEkhHVp1bIq4i0ePgQ5nup
	U6NF9A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhjphn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 04:21:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4844LqV3031664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 04:21:52 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 21:21:46 -0700
Message-ID: <469176a3-24ea-4ed1-84ca-71704cf70e88@quicinc.com>
Date: Wed, 4 Sep 2024 09:51:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add QCS8300 interconnect provider
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov
	<danila@jiaxyga.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Vladimir
 Lypak" <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andrew Halaney
	<ahalaney@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <quic_okukatla@quicinc.com>
References: <20240827151622.305-1-quic_rlaggysh@quicinc.com>
 <20240827151622.305-3-quic_rlaggysh@quicinc.com>
 <498fc1c9-9ade-4443-b64c-0d8fc9b7931b@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <498fc1c9-9ade-4443-b64c-0d8fc9b7931b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9c_jujkUo4GdL5nPT5h3IBzBjows-E_k
X-Proofpoint-GUID: 9c_jujkUo4GdL5nPT5h3IBzBjows-E_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040030


On 8/27/2024 8:58 PM, Krzysztof Kozlowski wrote:
> On 27/08/2024 17:16, Raviteja Laggyshetty wrote:
>> Add driver for the Qualcomm interconnect buses found in QCS8300
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> +
>> +static struct qcom_icc_node *nspa_noc_nodes[] = {
>> +	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
>> +	[MASTER_CDSP_PROC] = &qxm_nsp,
>> +	[SLAVE_HCP_A] = &qns_hcp,
>> +	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
>> +	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
>> +};
>> +
>> +static struct qcom_icc_desc qcs8300_nspa_noc = {
> Sorry, but no. Start from scratch from MAINLINE driver so you won't
> repeat all the issues we fixed last years. Everything was fixed but then
> you send one more driver with exact same issues. EXACT.
>
> This applies to all QCS8300 submissions... actually this applies to all
> contributions to Linux kernel. Don't send your downstream code.

Thanks for the review!

Sure, will adhere to the existing upstream code in the next patch revision.

I will constify all the array of pointers to structs as done in the existing upstream code.

I will refer the existing upstream code for any other missed fixes. Let me know, if there is any other miss.

> Best regards,
> Krzysztof

Thanks,

Raviteja.


