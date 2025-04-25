Return-Path: <linux-pm+bounces-26225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7CA9CB8B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079AA3B2DF4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E525A2BA;
	Fri, 25 Apr 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LcpjD4Tb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61754242D99;
	Fri, 25 Apr 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590749; cv=none; b=aTIHVSUfgJsExc7G0lnlBJXg17yTnx5adYhYp7pZzD1h/ytVzcutojYsdtIXcqsNHBDwfcvxh6DJ/s2L8mm7nk0W3cJ0YFfmWe6yDcoa2zb+Q5qnYrYqJrk7GYKzZXQBUIa0d3K87NwhVEKXYlRFE2ITVpHXThno8jakcC9CRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590749; c=relaxed/simple;
	bh=AexMVO8fjC67c5unH1YsKkDaQ25ekn/4Lx4ExdJWDKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bI1GDvvxusQZG+8xJfg3+uIEUzC4RuPEcXQ+KROn4f6NnW0kD3JhrusozF9qtgPQOJNbTyR6/6//keOSb23mBuFBKcDfAyz46KpJVq6heEwlMRAP0Irzhd7qY67yDXXnzS+QFkzdqiht3FJU5H8OvN3T8Fxg5Gh+jpGZH7jrcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LcpjD4Tb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TH3s012251;
	Fri, 25 Apr 2025 14:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yjDv821Wi3ckO1AszK+lyZiFVArgHwipVwVKRxNCQM=; b=LcpjD4Tbuc75xQ4H
	ond5vkgMBqF6PScSa3cO2+Vv7x15uRj7UCQ5K+8dTMd5pMY//+0uTbuXMPqegR6G
	2HMib9fIGFrHbnoqfqDAqbBzucmVEvviTRufCnG+9Ax3YoqjqRE3S+KnLt04QYYp
	CzlDDgIGstDxeAM0dfmfqVI+tlFmKJB1Wus+ocTLYlc5uJjfmG9W9TRJyBW/thRS
	M2iBwjLprdT5bGGyStsW9FCoosMwuN8QB8blGMJTLo72cSKSA4+OlxEvrk05HROY
	cpd47CaGBg+EDD4YCaMaQ/UfwTxyc42HQ2xydkWzkxeqX0S2EHHPZidCoUWZvTUU
	NUSsrQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1962r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:19:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PEJ09t013635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:19:00 GMT
Received: from [10.216.10.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 07:18:53 -0700
Message-ID: <3ffe00fd-1fbe-41c6-b82d-030bcf6d76d8@quicinc.com>
Date: Fri, 25 Apr 2025 19:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Enable QUPs and Serial on SA8255p Qualcomm
 platforms
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <6662b275-6b8e-40be-b62f-c17ae8e63dfa@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <6662b275-6b8e-40be-b62f-c17ae8e63dfa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yWItsxx6KJ97y4tpKlsNdZwd4vDXscRq
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680b99d5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=oNOacO-TtzJHBqNP3j4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yWItsxx6KJ97y4tpKlsNdZwd4vDXscRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwMSBTYWx0ZWRfX9iW1noMtBIcn 5r+Xkeo1BMGjJVomKnjfobQ1unPzUcWKyK4KS4TWbQpfwC9rTz0kh7C6mGCx6dSZGa6GyjuFq7C Tv6LQuWji4diV4onMhmzNFnsruR6Hp6hTBwSQ7OT1/EAHlDsO5SzyIE2jXk5I+xhodxEXrKQwKO
 vS8EgWijMjOVWB0C/xbfPmuRtddMu9mT86ur3v6/xBBllX1A2NILPmE1lLnwH/GbETnZx3X1pFC ClxYfewKWTdfBQssF8E33TGpZWOfEC6kRQzA1GhVAZIUMu4idIaVyXm35NDNqlO2mJmZMcdS3H6 y/H9c3yZRA/l6XWWM4KsowKKxBZvHNY8y8k5FyNxcMB9xslWiPspzI8N+K0XK2/Rq4WsXtcG3PQ
 gi8g/hpl7vA6f55EAKPF5sVuA1ECUw+GrpRg722fwYpNJLyvbUqF6VGVhqKBFmz8XZytZvJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250101

Hi

On 4/23/2025 6:31 PM, Konrad Dybcio wrote:
> On 4/18/25 5:12 PM, Praveen Talari wrote:
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM. The device
>> drivers request resources operations over SCMI using power and
>> performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power states(on/off).
>>
>> The SCMI performance protocol manages UART baud rates, with each baud
>> rate represented by a performance level. Drivers use the
>> dev_pm_opp_set_level() API to request the desired baud rate by
>> specifying the performance level.
>>
>> The QUP drivers are SCMI clients, with clocks, interconnects, pinctrl
>> and power-domains abstracted by a SCMI server.
> So I recently started working on abstracting away power controls from
> the SE protocol drivers into a single place, among other improvements
>
> A snapshot of this work is available here
>
> https://github.com/quic-kdybcio/linux/commits/topic/single_node_genise/
>
> (not yet 100% ready..)
>
> I think it'd make sense to get it done first, so that we can condense
> most of your changes in the common driver, where we'd swap out the clock
> handling for perf level setting instead
Thank you for the update and for sharing the snapshot of your work. The 
improvements you're working on sound promising, especially the 
abstraction of power controls into a single place.
While we appreciate the direction you're taking, our patch has already 
been pushed upstream with V2.
To maintain our momentum, we would prefer to continue with our current 
cleanups rather than waiting for your post if it's planned for a few 
weeks from now.

It would be greatly appreciated if you could take this patch and build 
your ongoing work on top of it, as it would be somewhat similar to 
optimize it from SE's protocol driver to the common geni driver for 
power management.

That being said, could you please provide an estimated completion date 
for your work?


Thanks,

Praveen

>
> Konrad

