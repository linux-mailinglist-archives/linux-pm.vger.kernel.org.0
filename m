Return-Path: <linux-pm+bounces-15250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6880992584
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D283A1C222B1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7218C037;
	Mon,  7 Oct 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9gJOplw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1B17DE15;
	Mon,  7 Oct 2024 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284954; cv=none; b=U4h3PZ1xgEyv5/e+Lp6NxtlYghv/b3cCKjThT1A+KgbrJyZQsXFohKgr2WQl3/sxszHOEMxdS+4v5VroORJz/CfL2h9sUOW9khlGI6SBIp8cZ8/MSxqeyAh6dPuHlTH/RgRQub7XSo/2TuszwLjegLCTEjM6y1hAPJkvcaPgQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284954; c=relaxed/simple;
	bh=HaYluipwIXVvdOFAJ9zPfQ+R9ZmE1ePxVV5rbpyspfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jkUGw1sqGTvVF70XDuATq/YepnVnuOW8q3HbLrpIBVtGxicTdOIsqU9x3WEvf9k72G7zUQMM11ZTMBfTEz56nRtu9tUuXPaRHSbzuzjyx2wInLbIViutu4gblqu69XH0JflREkbc2KnFbBE9J5boDYZblR5bnuBZUYOAGFVniqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9gJOplw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974TXLZ005308;
	Mon, 7 Oct 2024 07:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7OiBlFCcy+EsRXW8qMeYAkYGqWC12eyHX2jjrnsKEvk=; b=k9gJOplwfo2xbQDp
	ch32EP1Ytroil0LNAerBlCuQvEKaHge45GuBVxRk/tLQPPvlyYCAeYKkXwbz/1j0
	c4vBuLn/Nh31krpOjb0BuTZtVEXm6UJe+LxvwrYgEiKr7N+OMinirn76hYdkf4O/
	4+XtoPUNfqP1FsolhpQnG+vrYUiFNP8nirlMwXdGr1nDTAr9UGUPbnBMOGt+bB5S
	NbG0Flssu/Nf0bgkrrxtlg8ipUEagpU/rdivUbyJr0sd/Q1AiR47osuQCjXho0Ft
	NEpvE/1c4as75bIMHTXG6O+TzqC7koWBhj3aptPGmKIR4gwyf1rZoRbKKTRWDECJ
	4bY7Jw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xqnu8yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 07:08:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49778uPS004008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 07:08:56 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 00:08:52 -0700
Message-ID: <25015664-22a7-2d4b-7ba7-ef9611fb3045@quicinc.com>
Date: Mon, 7 Oct 2024 12:38:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
To: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <cristian.marussi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <johan@kernel.org>, Peng Fan <peng.fan@nxp.com>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus> <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus>
 <CAPDyKFrESupeNS4BO8TPHPGpXFLsNqLPrUEw3xzr8oh8FsLHeA@mail.gmail.com>
 <Zryxrdodn2Y2xsej@bogus>
 <CAPDyKFqmV7yvMdLjGhDHJN4CFiUun3FXprEk7uGFV_qmn9vA8Q@mail.gmail.com>
 <Zr4GsOndEEMI-6ap@bogus>
Content-Language: en-US
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <Zr4GsOndEEMI-6ap@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6rlIe34IG3MUdHAYsCgaAX2GUJsA_PUm
X-Proofpoint-GUID: 6rlIe34IG3MUdHAYsCgaAX2GUJsA_PUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070049



On 8/15/24 19:16, Sudeep Holla wrote:
> On Thu, Aug 15, 2024 at 12:46:15PM +0200, Ulf Hansson wrote:
>> On Wed, 14 Aug 2024 at 15:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Wed, Aug 14, 2024 at 02:38:24PM +0200, Ulf Hansson wrote:
>>>>
>>>> Sudeep, while I understand your point and I agree with it, it's really
>>>> a simple fix that $subject patch is proposing. As the unique name
>>>> isn't mandated by the SCMI spec, it looks to me that we should make a
>>>> fix for it on the Linux side.
>>>>
>>>
>>> Yes, I did come to the conclusion that this is inevitable but hadn't
>>> thought much on the exact solution. This email and you merging the original
>>> patch made me think a bit quickly now 😉
>>
>> Alright, great!
>>
>>>
>>>> I have therefore decided to queue up $subject patch for fixes. Please
>>>> let me know if you have any other proposals/objections moving forward.
>>>
>>> The original patch may not work well with the use case Peng presented.
>>> As the name and id may also match in their case, I was wondering if we
>>> need to add some prefix like perf- or something to avoid the potential
>>> clash across power and perf genpds ? I may be missing something still as
>>> it is hard to visualise all possible case that can happen with variety
>>> of platform and their firmware.
>>>
>>> In short, happy to have some fix for the issue in some form whichever
>>> works for wider set of platforms.
>>
>> Okay, so I have dropped the $subject patch from my fixes branch for
>> now, to allow us and Sibi to come up with an improved approach.
>>
>> That said, it looks to me that the proper fix needs to involve
>> pm_genpd_init() in some way, as this problem with unique device naming
>> isn't really limited to SCMI. Normally we use an "ida" to get a unique
>> index that we tag on to the device's name, but maybe there is a better
>> strategy here!?
> 
> Yes using "ida" for unique index might work here as well AFAIU. It can be
> one of the possible solution for sure.

Just re-spun it with ida, I've also shared how the output looks
with those additional device ids added to the device name. Have
a look at it when you get time.

-Sibi

> 

