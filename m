Return-Path: <linux-pm+bounces-19839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBEA9FE472
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248E13A2411
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3F1A3AB8;
	Mon, 30 Dec 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b5UQ252R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BD1A23A9;
	Mon, 30 Dec 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549833; cv=none; b=ODMhz8Oj/SS3LOwDoNxwcz1aWlvHbrojmCVquoHWo97LgjFYO2BQdboFcz4wEhLuoAcYjZfdiXVI9kiuEdzcpiRBox3lUZxWx++c9KMEq/RJZ51/XwvAMpPFGTSGpH55PLmgmiO24a9IKQ0jZ6uh0ZNV6R95FqRT2lJ6mdXziH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549833; c=relaxed/simple;
	bh=LvuelUv/PKJnM81qkpumebOSSAWMNddGqZWVrM6Nvbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X5pIu7I7UTRapfCoRrQXonjcYbxjhZwqvPjUEeBS8v6JOFAxuBMqgS/+ZQxRv7u24xjD6pfElav9B1HYtMK3WPST3zktFdIGOj81N5/CjTHutDSoYOkpE2avF8pn6WpuKdP9RbiVqhmD0bMpzB0g3o1Td63I8XPDn1+GyRNFRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b5UQ252R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU2kV89027261;
	Mon, 30 Dec 2024 09:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pOJNikt3Gho9pfSzSncZfTq62v3DSgp6Hu1UcM+O+1g=; b=b5UQ252RtH6jnP/S
	c2Li3XgYOaDt4WS6OJy6EA7UpoOC9EWWIQmwr2sfwkar0k6cddfEyhjK98c/B8W4
	khgH0MOOPlkjQwwwxMT2kkSUT/OFEANK3fbdz8RIRyh7XYpoO0MKUSZtZItTQjhH
	D+A5/gpykUxgUkGt5bSlIWa713yUTXSudAHgDbqTT52o/R8WVbUfQvnr++3VphA2
	mHjF0feL1+IeCYRlzsrbJUztjmBwKbdZ8Siw4x5AEbl1uyqAmOcPKNXB7jdjb3Um
	CXZRLjdWsVeFEA4hRgwIMM1I+KlxLGmCf0wTd5aTSWyCdyqwpG40q3RQzLzsCd4D
	nQNAYw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43uk120ng6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 09:10:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BU9AKKl000353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 09:10:20 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 01:10:16 -0800
Message-ID: <8568e9d3-7209-42b8-91a2-cda8b98a5790@quicinc.com>
Date: Mon, 30 Dec 2024 17:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
To: Krzysztof Kozlowski <krzk@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
CC: <andersson@kernel.org>, <bryan.odonoghue@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <gregkh@linuxfoundation.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <konradybcio@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <nikita@trvn.ru>,
        <platform-driver-x86@vger.kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
References: <ff53d7f7-0103-4e52-ac0a-c05bf4521cd1@kernel.org>
 <20241229101244.59779-1-mitltlatltl@gmail.com>
 <7fc6c727-d3c1-4c6d-a990-8caeb95c43c5@quicinc.com>
 <5ce5c90b-3fb1-41eb-b5aa-e4e06c8cf7e8@kernel.org>
From: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <5ce5c90b-3fb1-41eb-b5aa-e4e06c8cf7e8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6cHNrEQ3sbqy59kutadFkvt4lCjBHAUa
X-Proofpoint-GUID: 6cHNrEQ3sbqy59kutadFkvt4lCjBHAUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=651
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300078

On 12/30/2024 3:35 PM, Krzysztof Kozlowski wrote:
> On 30/12/2024 08:28, Aiqun(Maria) Yu wrote:
>>>>
>> [...]
>>>>
>>>
>>> Check the motherboard, https://postimg.cc/V5r4KCgx (Credit to Tianyu Gao <gty0622@gmail.com>)
>>
>> The link is not accessible from my end. Could you please help follow the
> 
> Link is accessible. Maybe you are using corporate network with some
> firewalls/content filtering?

It's highly likely that my corporate network has blocked this.

-- 
Thx and BRs,
Aiqun(Maria) Yu

