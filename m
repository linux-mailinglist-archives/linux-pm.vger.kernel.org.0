Return-Path: <linux-pm+bounces-26574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B8AA752B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF357B7903
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE4256C81;
	Fri,  2 May 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UW+T+1O7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE792561AA;
	Fri,  2 May 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196802; cv=none; b=kf2z8QYJ7wX948OgUP+ytMAYUq0viqnqSl4P25CLi5eagwKOCrTUEgS9ViP6yOkVTut0du28rRhIHXYTh4zYCeKW84lkOBswldWtXqGFZzhhogjpNKnRbV+NNtuFWz+AU7MMkhMkj80TyEUSHgUIIB5lA0t4PzBpsTPe3MmzS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196802; c=relaxed/simple;
	bh=QsPpiaBLB1aFFmt/jJN2Nv++3refqGj4VMkze5Zx/mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GOJveoTDEF088SbeBLyGKl1RSLJbAT1WW1UehinijofxFzIgGEnsgAyYTmdJHR1A2WmlnOJKZSr8KB1/l+9GLb5qz3C0KjIzb/WqcGH8ChqAtO287WwYc4FMi294mYBv1FHiJ4pz75QCtBJ4agFxyHamFCC1Ueo/q4BkNyL0YBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UW+T+1O7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542DXQl8023283;
	Fri, 2 May 2025 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihUAnzGKyPDiDhSe0ZCJJ88GnAc85VGkvMyX1QaWv7o=; b=UW+T+1O78hQ2Z0Wz
	tRR1GvCiB/ZVLs/WH2YCC5R9VhRpLVC00wZfKxjp73xIsHaV/HRW+podzmY/Kw8G
	3ZMJ87riRJIwomHf/EhXaazuOVqDd0dlbRsWYM2EXdJfeDArJvgiyaYHzzxAwTnh
	Nd8SHnD5SZBNpYCTh+gaWY4I3EDCb2sFI9kZVfca91yO1/OwqNglfzR23PBuU92D
	fEwM5a3iVx6tud93/Z/Ok4V7x/FxO2S7kFyAd2LAKpmdB29PlYLXks5xq51zV86j
	3r46hx+jHZaz1mwk42ivn4fxDqwVmO27J/648V8fwf66GrhsNCAHpg63PM7Fg6NY
	9KM5Eg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u80kyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 14:39:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 542Eds6V020371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 14:39:54 GMT
Received: from [10.216.18.87] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 07:39:47 -0700
Message-ID: <cc17c3d2-f882-4729-a676-476705a203bc@quicinc.com>
Date: Fri, 2 May 2025 20:09:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Viresh Kumar <viresh.kumar@linaro.org>
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
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
 <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com>
 <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
 <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
 <CAKohpondRqdfqC3CFSJibL2om8_Bbds8k5Dfu8fcZDksNxQUwg@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <CAKohpondRqdfqC3CFSJibL2om8_Bbds8k5Dfu8fcZDksNxQUwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ldc86ifi c=1 sm=1 tr=0 ts=6814d93b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=B5uisSGkWXMBVcHgxMUA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BLC-XjugQWvpu8IIlQHOHrm1McJkrgrl
X-Proofpoint-ORIG-GUID: BLC-XjugQWvpu8IIlQHOHrm1McJkrgrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExNiBTYWx0ZWRfX7+mQQSkd3Vij kNKshKwPex+efq4MBATgc6zx5ntseOs3rwNAFlnqJSRR3N8wLqihBeNFZa6YP7BwnwP1kyDq+5f oh12CHUkexUllb6CAKrOsXfMp3uW3PQHqyX1ErEiO3IfoyQrPV+zdP6P1GpPuH6bJoH/bnAS2Yi
 1UzUhsGPIbBXN+crOaPFtBvTlIFLKPAQ4weTST0s7q3ZId42J9Tk03tlT4lzF0AIjRhu8dhMbeu QXDgVt/VEQd+F7rMcMf5nokFnr59T9teFCB3UilfCDyfOZxBblp8XhvUfK66oic6b8Lvpw/u23F oXCXgv37OVKa82BsSFY0+H+9CzMfcLEMA0Pasw4kGyL+OoqTUGcIG5ggCzq5YX4WvRqJDLHXtcX
 00iUnMJ7kX980Xe6KrgsiX3jSsnlqqZBhnXbu/wLFW4QAAGIsSNWgvBnwj4oEFfJ8MhUlW/l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxlogscore=950 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020116

Hi

On 5/2/2025 7:41 PM, Viresh Kumar wrote:
> On Fri, 2 May 2025 at 19:32, Praveen Talari <quic_ptalari@quicinc.com> wrote:
>> now i can push V4 right and will not face errors on my series w.r.t this
>> API.
> Not fully sure what you meant, but you can send a V4 of the series,

i mean one of the patch from series is depended on patch-1, that i have 
removed from series now

so will i face any issue like kernel bot

Thanks,

Praveen Talari

> without the first patch. Please mention it as an dependency in the
> cover letter and that it is applied in the OPP tree's linux-next branch.
>
> The one who applies your series needs to apply the series over the commit
> in my branch to avoid breakage (if your series is going in 6.16-rc1).
>
> --
> Viresh

