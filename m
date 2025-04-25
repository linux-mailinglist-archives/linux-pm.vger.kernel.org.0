Return-Path: <linux-pm+bounces-26189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A2A9C67E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB7A7A583D
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FE23E235;
	Fri, 25 Apr 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ahko+Z7f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551301FA272;
	Fri, 25 Apr 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578897; cv=none; b=a3eRO35g48ZdHfxDEYvv7WqBBKI5ePlpH01zAEIL10C2mojXvU8esYGWTVWOXItlIkGgmZARgwTvAuE5rsQvtdtF7KaiLPKryPPeGM4lbqnqL41GLDpGBoIXZ0OWbGV/yFjide57KTa+CAIhYnbpk3CJiLUbPlNI1EfgUG6K5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578897; c=relaxed/simple;
	bh=RGHwiLFDEmsVz1diB/515yQaHzjj5w8Exur+yC06dFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pxrnvUivCVybc27TI10HweS3wEvYldHuHPq3sfKUFD0pzMCD1T2KnQ3CF6CEhQuV3wlcKISeuzizJCRahAdPjJ+H7nX73BjU5fKd3jdy9c5HO4GMru0rAh6FH0QkMIqWbMBXJ1HnGySToBE9QQQuonz/LvXg9TFSJxW8uavXnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ahko+Z7f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TB34007411;
	Fri, 25 Apr 2025 11:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K38bVVgxXwdgs486b2Bk50D3WKbdjVT3p30AxM7Jjo0=; b=Ahko+Z7fkcqgX+x6
	sxOCOrD/S6OibkPbyXKrrW9mhjgkgyI4LJR5lCdzsdw+zNhOY5IzKmbUZLSsxTVv
	7+wqWivHaWjl7jbTL1e922bvMOappcdnvXDT3XWyW99CRvO2w+vFPqpOWMqMPm3s
	gLRnZOQk2c48HD4UdyTjR5XYXdEnkJN7Xq8QDechq2dcdy0wZon/BR3nuUel5wzd
	VBy9Ozr9iFRNhDSY07PgeyuwXgg6ho9zWUb2hXZCDttO7JlF1RlQMuDVqe4xjezl
	g1VeIO0eKSH6OnkR37E4/TW5nuypxfdqiTitpaDZ9yLTeiw8zNM0Hq8ghIzqUnn+
	5jBhWQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0rn51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:01:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PB1TdB001538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:01:29 GMT
Received: from [10.216.10.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 04:01:22 -0700
Message-ID: <5d3033e7-0798-4246-a6ea-74ead8485053@quicinc.com>
Date: Fri, 25 Apr 2025 16:31:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: serial: describe SA8255p
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <psodagud@quicinc.com>,
        <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-3-quic_ptalari@quicinc.com>
 <20250425-graceful-psychedelic-leopard-0da7fe@kuoka>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250425-graceful-psychedelic-leopard-0da7fe@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fn8UqsQi3YZR_F308rkpyTo5a0umiDHj
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=680b6b8a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=DaVkk8uXpmKKpUZFdwsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Fn8UqsQi3YZR_F308rkpyTo5a0umiDHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfX1H/CV3QBI6o6 6nF7xBoyKc+3+1tV4z1swwYFBENLkPWMPXb+FqguQhqZId3sstEpkNqmlHlMQBFQyUeD7UgSVhx to6Mco5wMjCHwHzvxQZz+pcF7RKA8IPVwElHL2bC990Qj8d2yoTpW73znbWqEGE/W/VSxDq9+By
 BWnyPrN9XLlRNDzH0jbfmCkmQ9URkThXux3OLsApwkBd0WBRktgOry3eKCHFMBI2S6meFv62wyj RgOLMmrlG0pP/Ws3oBqQO3j2mzpWj3PL/4RTUx7WikvJzBtEUSphjXhtdGaCgZ4igKEpfzkh3Kk POytX41Vo7VAwk+Xz2riqDw2FqD7m2JAx1Fo8oQqk8fSuFr3ZQWxWW3ruYXxyuV+tcXbiJIRdmF
 McHqnGR6lLDMTLf9J8pbzrcgKKEiXUI6ali6Rh8DmlViglS1v3OYX2bhONpiQiXFMA5Yyclc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250080

Hi

On 4/25/2025 3:42 PM, Krzysztof Kozlowski wrote:
> On Fri, Apr 18, 2025 at 08:42:28PM GMT, Praveen Talari wrote:
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: UART core irq
>> +      - description: Wakeup irq (RX GPIO)
>> +
>> +  interrupt-names:
>> +    description:
>> +      The UART interrupt and optionally the RX in-band wakeup interrupt.
> Drop description. It is not even accurate because you do not allow
> wakeup to be optional.
Will update in next version.
>
>> +    items:
>> +      - const: uart
>> +      - const: wakeup
>> +
>> +  power-domains:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: power
>> +      - const: perf
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +  - reg
> Keep the same order as in properties. You already got comment about
> placement of 'reg'.
I agree, will update in next version
>
> Best regards,
> Krzysztof
>

