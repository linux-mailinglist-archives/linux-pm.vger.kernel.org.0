Return-Path: <linux-pm+bounces-31054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22DB09ECA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543FE1C453D4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56B2957A0;
	Fri, 18 Jul 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D7qaKLvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244A217719;
	Fri, 18 Jul 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829993; cv=none; b=Y3syP4YPpu2thIDXXes2mf7YqOhU96syb5o6wg39OHdJ0MmgW9fNLwNnU86f6fP1GBq/K3H34+y9ssMUS2YPPi1jfATn8aZ4+WrhjebA1NZN9YSgFMNCWENc+HgZwdwT7LrNe7KYtfRMz7bBY3FgcAqsG/NDYHywyR98G/9susY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829993; c=relaxed/simple;
	bh=VS1YJzfRQ7G7yvHqabL4NTyAeH3+uyBIsyGfYeU35ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LiI5I0eS1AQDttw/oY6K8qTmCvK/RwvHT2UNCNmD2hto6+7bBsqxk5wZuxZtrbLx6Qvwq9xVncV+eiWF0gYPk9A17RLI4Y4+pIrYDUzrX3sxbtD0/nLFKSRUjdqGeYMKes6+uzvjRlzbTihO351RNcMoe0bdX/Fq7dp4zNFGnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D7qaKLvR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8HJ6F008498;
	Fri, 18 Jul 2025 09:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	op/Ag1A6md0DsDBJ/E5eHh1AniEZDJjKyNg/fUBJrS8=; b=D7qaKLvRElgKI3Ky
	tZ/njhvZFfAryHKT4I0jpRzrMbUHk7amVrCD2dWqITi6Vlxbpwxh3D5P4RYbYpqs
	8AStEsCyhIj98tX7k+LcsaG1/fFVMUYM7wbdgaGbuNkRz3DROvABc7OWjNVtUkVY
	jmPy6xbhEMDdXLaNWmtZePrBWtpk4iD1vVcXN1Y4jxsuKDlOstTvLQIIOdONAna7
	CmKyf+qs1zDo7/4GQqIVwd5uYO3Lh13810rdQgBU8+3IGG7MlZr8DlSWL5bTxvSo
	9HEsxdG9gsox/66o+JiYjVBVuydZ/z9KHJeqZQdrBlWi/wrkB8PV8y2J8F668k8e
	l/aJzQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbaw9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:13:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I9D10o019181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:13:01 GMT
Received: from [10.253.76.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 18 Jul
 2025 02:12:55 -0700
Message-ID: <f361df26-0314-4011-9c49-3b030bf4d95b@quicinc.com>
Date: Fri, 18 Jul 2025 17:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] clock: qcom: gcc-ipq5424: Add gpll0_out_aux
 clock
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
 <20250710-qcom_ipq5424_nsscc-v3-4-f149dc461212@quicinc.com>
 <193de865-980d-4fd7-9c43-39ae387a5d0b@oss.qualcomm.com>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <193de865-980d-4fd7-9c43-39ae387a5d0b@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oceujg-cA7d6__dsGgV9v4PKOnMNanoS
X-Proofpoint-ORIG-GUID: oceujg-cA7d6__dsGgV9v4PKOnMNanoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3MSBTYWx0ZWRfXwetrrYxaSbdY
 c0mXEjpl+t1ZeTXgV+y5aHbz2hXbHG6P7n7n/8wHFNAPKl6F+Ngf3m6RTscDNncSCr3eBU/SHnS
 e1kXpRvCQmUubm2mnupptVbYQPZ7qW+ihE3G2BfzTnWOKATdIGWYiRPcl87J0yqcbCzMwP8NgBv
 DyD1HbPT+adDvk0GlEDnzNphzilqIL4FbSo5V5NBifg4rpn8M9oqlyu2XzAkd7evSs/93CyRHla
 19vTa3UMYssjR2TKjSCeEXsUa1TJciOEmI1fA2hQr+s1kyRTBfz2Kjonq42ERovW0ptnkGvg+Oh
 ntnl01O0EWavc9CazSBULOTTsBdhTW4doHzelBQdazTIk0KIG/iiVKuZuKp3dg9U6uM31hk6BGI
 tORkGRuqnRthX5ZlCS+PqM+CIOeQxjLxPv/2ZrU5t1XDG4x1E8ke/VvFNDsClXMP/CaY4V6m
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a101e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=1O3MfNHGUYumxtBdEW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=960
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180071



On 7/18/2025 4:41 AM, Konrad Dybcio wrote:
> On 7/10/25 2:28 PM, Luo Jie wrote:
>> The clock gpll0_out_aux acts as the parent clock for some of the NSS
>> (Network Subsystem) clocks.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
> 
> nit: subject: "clock:" -> "clk:" to match the other commits to this
> subsystem
> 
> Konrad

OK, I’ll update the subject to use "clk:" for consistency in the next
version.


