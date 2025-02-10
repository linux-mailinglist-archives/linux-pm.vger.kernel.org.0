Return-Path: <linux-pm+bounces-21627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68917A2E40B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9AD3A6B3A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36F1925BF;
	Mon, 10 Feb 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PnUIHkHy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051F2F2E;
	Mon, 10 Feb 2025 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167953; cv=none; b=BS82TGYv3Owqlpyi3VNTw7tIZ879V4k+Hb6a491NhZ1eGveot8KaZlrFuF/4peY1ItOt2gO8Vt0yCvA9OzQgjeoSfqZ45i9KCo0wcJB3CnKoHfWmRuiGnnBaRKcATPOibAwcCFrPd1dsohl5TfRKY73mh5FXj6Op67Chg2GfiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167953; c=relaxed/simple;
	bh=ihYWExwVukP9KGwkRT8lXliaHzer7giR2gVUCNl6LPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z6Co/CEzkq42XJqUgltfGhr9jXXBw0tJ19tNxe3kUG5s/OTqPgarr7dXVzvYfbLicAtuu2xZfAD+U18AIe32BCgoHOMhHlWkWnLiGRfVJyG8aQIMuqCp6nAqeAC03xxWw3gvBvomSJtVolEvJ+fSwoAcBn8b4qh7sPnwuJZSvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PnUIHkHy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NmkM4011856;
	Mon, 10 Feb 2025 06:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B9zNerNeRN06eKR30n973CXujbZYNKEd1nPUPlK7wfw=; b=PnUIHkHyx39BAH7W
	nAlvAgAsTE1aEoa0pirLgIjMuKzNa4EhmnYkGnTgTnsK+jmjmonwIce2ls1W0J3V
	qInS+66WLFywNGdxcP7Yus/Cc3gIaWRswtaJ0EipcXqXzMhBYjGG0tzZLO3xiFN/
	hhQ5g6L2+BRwxGBjuLrnXU0BBQUJQQyJujmYbQurMoaiJ5wTUnFzYPnv6SI2QJdg
	+0VYrDzPq6CvVxpaYDQJxl7Lz4LmNx+tlkZHvV3wfaP5x5QLfnmhmir1NYbk1X8w
	sqORUpYRjVcEj84zKJ9T2vD61NVAbfw7E1x0I223WuFFR2V1s3ATy8+m56f8KniE
	4woI3g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dyk6js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 06:12:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51A6CPsg004095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 06:12:25 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Feb 2025
 22:12:20 -0800
Message-ID: <747868ee-9f6b-4bff-a88b-a91ff52e3f06@quicinc.com>
Date: Mon, 10 Feb 2025 11:42:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 5/7] interconnect: qcom: sa8775p: Add dynamic icc node
 id support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sibi
 Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-6-quic_rlaggysh@quicinc.com>
 <ujsy5e4u7inz5mzdh5m672zkfcrd6igoypgkak2assfpvlcrve@mmjlabr6rh5a>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <ujsy5e4u7inz5mzdh5m672zkfcrd6igoypgkak2assfpvlcrve@mmjlabr6rh5a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TbPko0J752bfWoB4zchitNYEeYC5_B1G
X-Proofpoint-GUID: TbPko0J752bfWoB4zchitNYEeYC5_B1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=984
 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100050



On 2/6/2025 6:30 AM, Dmitry Baryshkov wrote:
> On Wed, Feb 05, 2025 at 06:27:41PM +0000, Raviteja Laggyshetty wrote:
>> Discard the static IDs from node data and set the default node ID
>> to -1 to indicate the for dynamic ID allocation.
>> Update the topology to use node pointers for links instead of static
>> IDs, and rearrange the node definitions to avoid undefined references.
> 
> I think it might be better to forward-declare all node entries at the
> top and then keep currently defined nodes in place. Otherwise the diff
> is pretty unreadable.
>

Sure, will upload a new patch with forward declarations.
These forward declarations will be present only for SA8775P and for
upcoming SoCs, topology will be adjusted to avoid the forward declarations.
Please review the other patches in this series, so that I can include
the suggestions in the next patch revision.

Thanks,
Raviteja.

>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/sa8775p.c | 2194 ++++++++++++---------------
>>  1 file changed, 962 insertions(+), 1232 deletions(-)
>>
> 


