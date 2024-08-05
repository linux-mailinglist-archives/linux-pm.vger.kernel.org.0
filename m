Return-Path: <linux-pm+bounces-11905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58E947337
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FEB20D36
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1F3FB83;
	Mon,  5 Aug 2024 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FmPpht1E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66A3EA76;
	Mon,  5 Aug 2024 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822726; cv=none; b=hIIWCgStfodJEqrUQ+jHAAt++Eh3SkVtFzc1fU98b0g2Kf3SGr0VHhuQagDMQk8N5A0yI5CdT0SCw33ySiK228yIqPq4lK1PKKFuxyng64lzdzCvA9AhRdX3EPVYLrazCJUEhXDzqpHFt074Ud3unWgOQR7FWrjN5RnN/XM9QHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822726; c=relaxed/simple;
	bh=lYp+khZivfJ7URiH5f/SRglEaW42kwy/c0jVmmhTyCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OR9vfVBHjDuRDKWXr8Gd2bGTeIDLrNl/eSPLg63aPCUZS9+zZGv3n9NXNho9yl+vhsWubKXiJRY/tgZqHR0CkNrzb/sRf1rdpksFOhVu3gQMMqXvwCWt1NYGLlHwO9SkevgufuTwQsN0fq9wDlPEoLTxw7oobiD/D7LoCuas9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FmPpht1E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4750E3wY014086;
	Mon, 5 Aug 2024 01:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/J9ScKVBO4MCpNAz/Ecfgh99TR0qd4XT1EoEjGm+D0=; b=FmPpht1EgbtTn1eb
	gnz0agywEjrC2hqWu5T9htOqsmruGyNYG/np8NJxlI8mXTRrJeTewnFW6QwTsmxL
	oSva55UuC1laowmPDGyQ2ghRc+w2fMuoVCA1b9mYpfxeJpPy8Ri3y+uBGWwaO04o
	Q5WtFYOadhHY0utaNzUddIMIyCxxqyEmQb8vFdZqzejb5MAm5PaNYroWEFa3//fc
	YVtYG9Tf55iQvSVoPEHui3gZJzfC1wz9iXdhyTp4L9uxsxXVXi+jrGnXhzkz1D2H
	16C92omwQNw8PQM5X5EyDZbYe2lodc20oOaVciry8kJhIgts8r05f5qIYnrTwEhR
	Ul2WMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4y2hs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 01:51:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4751puk9027167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 01:51:56 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 18:51:51 -0700
Message-ID: <114d13c1-0b1c-4e73-b969-d826ef80a307@quicinc.com>
Date: Mon, 5 Aug 2024 09:51:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] interconnect: qcom: Add SM4450 interconnect
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
 <e95c0938-3af3-4ec5-bf23-270ab8823e5e@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <e95c0938-3af3-4ec5-bf23-270ab8823e5e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2Efnt8AdBz_p27JKBeWD19xbB-8FQOIf
X-Proofpoint-GUID: 2Efnt8AdBz_p27JKBeWD19xbB-8FQOIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=797 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050012



On 8/2/2024 3:22 PM, Krzysztof Kozlowski wrote:
> On 01/08/2024 10:54, Tengfei Fan wrote:
>> Add SM4450 interconnect provider driver and enable it.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>> Changes in v3:
>> - add enable CONFIG_INTERCONNECT_QCOM_SM4450 defconfig patch.
>> - remove all _disp related paths in sm4450.c
>> - fix patch check issue
>>
>> Changes in v2:
>> - remove DISP related paths
>> - make compatible and data of of_device_id in one line
>> - add clock patch series dependence
>> - redo dt_binding_check
> 
> ? Running make is not a change.

ACK.

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

