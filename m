Return-Path: <linux-pm+bounces-13507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884796AFC3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AF8B2310D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 04:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212A80C13;
	Wed,  4 Sep 2024 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gLGC1CAC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4043152;
	Wed,  4 Sep 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423829; cv=none; b=eLtx9RhVvHsN/PEtwGN8TQ1wEMAovgO7zlemEPS9D6CQpO5IDvo6PWZy5BGprmr4Mf7QtJ+iG/rCj4T8e8qDSkSLkGeHjocqwwf6LUDyiMfyQmGz+h496R0lcku8CPQY8qJYnzt4+QS+eCOE4v42fj0dpPLCeBTbFomuzo1IPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423829; c=relaxed/simple;
	bh=QMi6ilXI/bMW7raOG2X00t6hnRUkX1YeyruxgMUexRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SacOp+OrWeWfhLkwSAaKr/ocayq+ZmSPXcGgupAjwhoVVrccifAc1sH+iUjjUwNViPhEStO9qwwWbBJ9C/Tn7q74MHKrEymtZuTTPHSuRWD2inbCeamyFZyGp2MWq6BC+KqZ9nBxwuizdLNU208bjqHvtaAugpEnsTbFnd5oBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gLGC1CAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483J0x9T009621;
	Wed, 4 Sep 2024 04:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QMi6ilXI/bMW7raOG2X00t6hnRUkX1YeyruxgMUexRI=; b=gLGC1CACLUH5BHeX
	lLg/lBKdmdckR/WIentL9L+3bJb/zhexinV8qIf1VDVGkqCafuRgLvr7hd9w2hec
	qb7G+4aALk7akvRxtivNhlhrp5+RXs+VEtPwdztvk7qi0haBPMMiv8tbuwBP//GG
	oCNV4hPNViRC0tN7cyqsGyrAxMm7a/BKFqpnUn5bToCdPrzf/IjzJ8WFHSeFgSLZ
	pUBLFWBoS6hwGK3PMV6iy5/pP5DYVS70GgCZMFCK32mTIcYtaO7vvBHlCxP/g3ck
	RrBuVtorUFyR6grQp/vs3m7pBMGSsqZlSZeuxni3etjpGGDx2gPM4gkmTwFZiF0S
	ufqDog==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhjpmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 04:23:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4844NcEw029174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 04:23:38 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 21:23:26 -0700
Message-ID: <1924fdb7-4c09-4996-accb-cae6628e83c7@quicinc.com>
Date: Wed, 4 Sep 2024 09:53:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add QCS8300 interconnect provider
 driver
To: Konrad Dybcio <konradybcio@gmail.com>, Georgi Djakov <djakov@kernel.org>,
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
 <159df608-e52c-4317-a1f2-d0f94ebfc25a@gmail.com>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <159df608-e52c-4317-a1f2-d0f94ebfc25a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iYW4WaNr5DIcS6dWW0L_1chKhaGrJMY-
X-Proofpoint-GUID: iYW4WaNr5DIcS6dWW0L_1chKhaGrJMY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040030


On 8/30/2024 1:19 AM, Konrad Dybcio wrote:
> On 27.08.2024 5:16 PM, Raviteja Laggyshetty wrote:
>> Add driver for the Qualcomm interconnect buses found in QCS8300
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
> [...]
>
>> +static struct qcom_icc_bcm *dc_noc_bcms[] = {
>> +};
> Please drop such empty nodes

Thanks Konrad!

Sure,I will remove all the empty nodes in next patch revision.

>
> Konrad

