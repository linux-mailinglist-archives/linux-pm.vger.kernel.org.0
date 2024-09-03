Return-Path: <linux-pm+bounces-13397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E896999B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D831B22EAB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0D1A3ABA;
	Tue,  3 Sep 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K/tyJwrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680819F41D;
	Tue,  3 Sep 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357437; cv=none; b=G6GwThVWCxXFaFa0XzQz0YevrsJGThPOigmaMQ1vyHNZvBCTWH8s8bhzp3mn+8XckC+RGAfX7ta0wZBg7B08Yr5jNonQvRidSI9xanKRGXsEAQoXj1JlneG6uy++nHPmrIBXQYNV4oUhbkQdFlPbwz4TYxXQuH9haYQ2xXhTf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357437; c=relaxed/simple;
	bh=cqubLfVw5UF9H8tDMBrJ76paRmwHooWjgakm0+GPp+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ic17SDXQV1Pfl81OrkkbLIuL4zfTOBcRgNofkBZOOH7Z7jBVXmUWUDsKb6a4ZGbUBPlleTKsIUmpeXjM3Ma5NSxipvIidfxm60h/KniOAYlEbZWY4kOA4Sy1egqsvQto+VoceSCVTl2iKYIgbn1kDTFEWux2PIAK4kAnsK5GFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K/tyJwrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482Kc3pX010165;
	Tue, 3 Sep 2024 09:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UtMY7o5mMRRxzHSIdYCWRT7xTQgNbrg7biRIrNK54Qs=; b=K/tyJwrpxvHfsLkX
	3TqhsThlyKw6QKR6jbyjHBLOusq6f0KmI3DIMdRkKKY4SAuHcd3MBKKCRlfqcacU
	QY5YdUXf9EZIM1Kh/anL4PbIkSHH2Gc65SWzZgsznMZwW58NY/cM7ERyIco5/y0A
	HV1cQSm7L5lt8Bpc7vVfl8KrKRR9ZTQn/B6lZSJ1e2Cx9TbHRneT+jPENHCud2Jq
	pWEAtCqXmqRbXLOHFOQ/2ISgDJKb9s0dwLYzzXHxmUElDJoxpwCxNkf42GY7Ou9D
	vHBKm2uL3i46gWYdvU72qCyBQ4rdGQ6svHvvvyHunHYwKggLkv+Hln+ZvsTaw9n5
	KF22vQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41buj6xwx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 09:57:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4839v9qv023866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 09:57:09 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 02:57:05 -0700
Message-ID: <a9425927-c9d8-4988-8bdb-2def8d9668ca@quicinc.com>
Date: Tue, 3 Sep 2024 15:27:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: probe defer incase of
 missing QoS clock dependency
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>, <quic_mdtipton@quicinc.com>,
        <quic_okukatla@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>
References: <20240827172524.89-1-quic_rlaggysh@quicinc.com>
 <xny4v2twbt5sjjtc5yoffpnymryfd6da6pirlmiii5txyz7rl5@xy7wdrzi5auc>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <xny4v2twbt5sjjtc5yoffpnymryfd6da6pirlmiii5txyz7rl5@xy7wdrzi5auc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L4yRlhVVoIAB9FGOgQgChBMjTWJ4RazC
X-Proofpoint-GUID: L4yRlhVVoIAB9FGOgQgChBMjTWJ4RazC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409030080


On 8/29/2024 3:09 PM, Dmitry Baryshkov wrote:
> On Tue, Aug 27, 2024 at 05:25:24PM GMT, Raviteja Laggyshetty wrote:
>> Return -EPROBE_DEFER from interconnect provider incase probe defer is
>> received from devm_clk_bulk_get_all(). This would help in reattempting
>> the inteconnect driver probe, once the required QoS clocks are
>> available.
>> Rename qos_clks_required flag to qos_requires_clocks in qcom_icc_desc
>> structure. This flag indicates that interconnect provider requires
>> clocks for programming QoS.
> Two separate commits, please.

Thanks for the review, I will address the comment in next patch revision.  I will post a new patch for renaming "qos_clks_required" flag.

>
>> Suggested-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/icc-rpmh.c | 10 +++++++---
>>  drivers/interconnect/qcom/icc-rpmh.h |  2 +-
>>  drivers/interconnect/qcom/sc7280.c   |  4 ++--
>>  3 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index f49a8e0cb03c..5417abf59e28 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -311,9 +311,13 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>  		}
>>  
>>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
>> -		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
>> -			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
>> -			goto skip_qos_config;
>> +		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
>> +			if (qp->num_clks != -EPROBE_DEFER) {
> if (qp->num_clks == -EPROBE_DEFER)
>     return dev_err_probe(....)
Will address this comment in next patch revision.
> if (qp->num_clks < 0 || ....)
>     ....
>
>> +				dev_info(dev, "Skipping QoS, failed to get clk: %d\n",
>> +						qp->num_clks);
>> +				goto skip_qos_config;
>> +			}
>> +			return qp->num_clks;
>

