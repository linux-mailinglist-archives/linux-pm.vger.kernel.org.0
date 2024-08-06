Return-Path: <linux-pm+bounces-11947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499794935D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B93E284867
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DA20FAB9;
	Tue,  6 Aug 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUhPsIkh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF120127D;
	Tue,  6 Aug 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955161; cv=none; b=KJFob3o/fGLcgPcUdN58cNr294f/eIIMPE3DikYWslwREI47EpGE7ra4yqnZTKO2en07GEcDJrQSkrdmEpKsMJNjpbiy7iZsIZb85ARBIcSPcML4AGS0HOyD8syJEEu6seoSArX+ozRKoDOl+HAKMCDY/WcKDeWl4s0qgyMV1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955161; c=relaxed/simple;
	bh=pE2N6HsMOGnyAzF7xGym3HNq0O2ALAdbZQeQ+Vokikw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AKFOHE5QetsOrPe79XicZ7JyB32IFEqQ9fsZq0KJ2JyOrFfGvF5tttYzljIxRtmT4GvlGlUtY670rfpTGNKULdQcGDQF0QQt6RqXE9b6Qb+ItgrMquePrMRFqSc7JP0jypXBXk5sh7m5AkgUtrUsa8tk7z5H6oqj8e+UaaJaVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hUhPsIkh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476C7WNV028241;
	Tue, 6 Aug 2024 14:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3BY/TviauIPnOoSSemqm7eQDC30fq//qXABIEK3JbJU=; b=hUhPsIkhvpz1mSMx
	8iF+CaHZrUhsz54+4L77LUZN6BfNFN4S1mYWyXU7pWgbrqB9J2b5cbfsowghkQY6
	eYbf77VapG1JljYFQ+I6dYnIRQV/xZGeGPQfOw8YTCI7Mi3phxTwvQrExzYRZYW0
	K13u5gaqeHwlNGE+U8ANArzBupaqjy9wftfKGxPpgBp63l7un6eDrkEgyzVklnR5
	uv4vu1TcpbeXZzEdvwlS9vhEJi3IK52RyRJ1TA9g+8pHIu5KFnT6FPZDyDVTVsri
	5UKPtgqHeIqKVIiiHPc+Kwbq6UrA1NLh3ycEk0XZKFWoo/Inc/MiLqoeJFb0xXKu
	3Do4mg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdae7krd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 14:39:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 476Ed1si005742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Aug 2024 14:39:01 GMT
Received: from [10.214.66.226] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 Aug 2024
 07:38:54 -0700
Message-ID: <9c789339-e57c-672d-c032-e31ceae8510f@quicinc.com>
Date: Tue, 6 Aug 2024 20:08:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>, Trilok Soni <quic_tsoni@quicinc.com>
CC: Elliot Berman <quic_eberman@quicinc.com>,
        Sebastian Reichel
	<sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZnmTtmZB8epgbUTN@bogus>
 <20240702155630416-0700.eberman@hu-eberman-lv.qualcomm.com>
 <1bdc4d4c-9cf1-a8bd-80de-7463cecd2c78@quicinc.com>
 <fadca811-fabd-92b0-0482-c317344de2d7@quicinc.com> <Zo0csvj7-3N2aVl2@bogus>
From: Shivendra Pratap <quic_spratap@quicinc.com>
In-Reply-To: <Zo0csvj7-3N2aVl2@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dxUhBj-0zQYRWnDs4xDIf1cxS_yEJ178
X-Proofpoint-GUID: dxUhBj-0zQYRWnDs4xDIf1cxS_yEJ178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060102

Tested-by: Shivendra Pratap <quic_spratap@quicinc.com> # on QCS6490-RB3GEN2, QCM6490-IDP

Can we take it up now?

On 7/9/2024 4:49 PM, Sudeep Holla wrote:
> On Mon, Jul 08, 2024 at 08:50:58PM -0700, Trilok Soni wrote:
>> On 7/2/2024 4:42 PM, Trilok Soni wrote:
>>> On 7/2/2024 4:06 PM, Elliot Berman wrote:
>>>> Hi Sudeep,
>>>>
>>>> On Mon, Jun 24, 2024 at 04:41:42PM +0100, Sudeep Holla wrote:
>>>>> Sorry, I completely missed to see that you had already answered those
>>>>> in your commit message. As mentioned earlier I haven't looked at the
>>>>> reboot mode framework completely yet, so I can't comment on it yet.
>>>>>
>>>>> I don't want to be blocker though if others are happy with this.
>>>>
>>>> I think folks are satisfied with the other parts of the series and now
>>>> looking for your conclusion on the PSCI driver part.
>>>
>>> I will be nice to get these patches picked up before 4th July holiday in US :).
>>
> 
> July 3rd was already late to target v6.11 😉, the merge window may open next
> Sunday. Ideally we prefer to have code reviewed and merged before previous
> -rc6 so that it spends couple of weeks in -next before the merge. If I were
> to merge, I freeze my branch by -rc5 and send PR to Arnd after that so that
> Arnd gets some time with the integration of all other PRs.
> 
>> Sorry to bug you again Sudeep - but I need confirmation that these patches looks good to you
>> and you will pick them up. Thanks.
> 
> FYI I am not the maintainer of PSCI. I have given my feedback but I haven't
> been able to explore reset/reboot core support in much detail to provide
> any further useful suggestions to move the code out of PSCI like I would
> ideally like to. But that said I don't want to block this series just for
> that reason.
> 
> --
> Regards,
> Sudeep

