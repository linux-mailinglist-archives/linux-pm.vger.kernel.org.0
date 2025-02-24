Return-Path: <linux-pm+bounces-22763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2964A414DD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC693B2C3D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 05:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B91AAE28;
	Mon, 24 Feb 2025 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F5vSibWv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AB3C14;
	Mon, 24 Feb 2025 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375811; cv=none; b=MwiEQyYyKOXTWI9VKBTftwHQTzEx8iAx4MGNVNODXPvmOtVHY2z/LKkUIWN6NVV4UYNawI1mAqD1L5wPOyy5jEgl1EbnJI/DRqCjjl4GuRUDxZIVOffDHTzkLUPTpJLcuGu6K+D7bAkk+1I/qzwqY206CZZwp7QjqOue0lEMmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375811; c=relaxed/simple;
	bh=/5VmSNMxuhIRU7BOwyDf0GDQkFJRzmkBhylNdNI8dCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JNf1L16H0s/XaMLhBmQ9yXjHZtn3k941N497+fUfO6OUES5oahsSjcQ92k3seCZmZ7AVqW5/9hQVoFe3J3ZITJ14Qc9ZYpyOfLvQf/gMgX1YHHIv72grfE0RG7QrRmuFbafeVEkYQc797xajCIwBI/jvSw7jMS2EFYjOTw8RTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F5vSibWv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O1QVc7031671;
	Mon, 24 Feb 2025 05:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I43oxc6ZzZV6qiw2F/wFk5NNcwqhDLdZjbyHD2Z3k9Y=; b=F5vSibWvD2DYE6/J
	j8Zy2m66OBLO5Ph3VCIdoxmrO5j5WKxx7/qSOAawh9zywK8omTNVVSMF4iJ8QIZL
	ohXM0v4XPWtzDcfeNQzfT6B+vbOGwrmMZDXJOr+pW4WaQ0c3u95EwVXzD7GAmpJw
	FxMjCVJrhkvI/b5tlHCQxdYqHCUBuBbR/VOwUT6s89sqB2NZz4vbeJdYC480kBdo
	+z7ZA4rCS9n1E3heJQ9e+PPgl+ySbyxtW6C+yZJA+Itp9RF8PCBJphvJcHQYM5Uy
	ocRE9DDOOBxzuN2Yli/b5xaUaNeJ2Ft70O4VMmT85dCu06VlOtepXhUdgVqdBPls
	Egt1Fw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7v9bg21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 05:43:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51O5hHDq001641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 05:43:17 GMT
Received: from [10.216.6.72] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Feb
 2025 21:43:12 -0800
Message-ID: <63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com>
Date: Mon, 24 Feb 2025 11:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018
 tsens
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        George Moussalem
	<george.moussalem@outlook.com>
CC: <amitk@kernel.org>, <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <robh@kernel.org>, <thara.gopinath@gmail.com>
References: <hmhagxzvumlmzvnbw533ebzilbvknexarsnxjfwi4djq3eabkc@efferfxbxkt3>
 <DS7PR19MB88835F4120912ED00626709B9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
 <5quz7ulnxvhsafmjxw2ktwfrkqjcnzeao2msfwdhltoz6im3c2@dh2dbczl2qkn>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <5quz7ulnxvhsafmjxw2ktwfrkqjcnzeao2msfwdhltoz6im3c2@dh2dbczl2qkn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rS9HgfqeR7Dzg-34d4gDwUuGI9ved0nc
X-Proofpoint-ORIG-GUID: rS9HgfqeR7Dzg-34d4gDwUuGI9ved0nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=937 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240039



On 2/21/2025 8:21 PM, Dmitry Baryshkov wrote:
> On Fri, Feb 21, 2025 at 06:41:44PM +0400, George Moussalem wrote:
>> I've just checked the downstream dts and driver, it contains 5 sensors,
>> but only 4 are used. So I propose we leave the number of sensors to 5 and
>> adjust the commit message. Thoughts?
> 
> SGTM
> 
Agree, thanks George for re-posting this. Infact, chip is still active,
but there are few other priority ones that took over. So should be
good to get this merged.

Regards,
  Sricharan

