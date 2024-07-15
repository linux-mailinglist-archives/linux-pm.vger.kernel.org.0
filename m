Return-Path: <linux-pm+bounces-11120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BA931B10
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE72283161
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BED7A13A;
	Mon, 15 Jul 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U+c8yoRC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A415491;
	Mon, 15 Jul 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072135; cv=none; b=rpppwk+tsumDYwTN05tITuPvOTIGZYzJbVVntHPA/d+ObIL1C6suBFKoLeLdJ1Bp3wTiXbNzvdabEDtKpeyvtNmD0i9FXEFVsr0mrU/cq70LLgJhU9WQL9/AvWXwwdnw/ent909bLC5lH2tNSa1Hl7LZ7CiLUs+voByAm21j2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072135; c=relaxed/simple;
	bh=FRn9L6xt/4pBPTKmgkgNlVfwV8prnDiH2WQXjDdDtOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5RB6wYZnr23Nn3cuAMOEGnGTulYo9adDBYKW68EYB5+aMDYmxj/F9EKt7E0RpMoh0vrSCpQd/878jMaOy/ZtsmOkjA9TJcSmoUCt/crtwcgztS6b6rhFH5eBHKVWr4TZvCpFUDjouMaBVLp59+Z/jzM7YpygePFY+2/IZ/8tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U+c8yoRC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8jKZ031938;
	Mon, 15 Jul 2024 19:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMUJ2TW4Kz92vZ1WNbj9fim2oaakNFSraWNVGeLCagg=; b=U+c8yoRCaunVsvgr
	XG+15WKI+r84R5ti6CuwxYjgMxlP7Sm0SE1k2Tm1Mrg9d/O7GvrjlRw4kqEu9vhQ
	6KixL6vuFBRM/EZ1+JHTU+yfNyaVwhEO6MKy+tju10wQdfVY0l32MCoQnlz/Z/KL
	20ovJCG4Ugy7LJbNX0Ynt6qTatm/P7cKSCmk/sw8cl4Ycx7K/0s9drAYggl3UOpV
	Ux3vpxaL2z34mt7SfO/h5g0P5CrXc5m0R1kutWp+xppsA5qpV6xxmFkP8prBHNQv
	kNS61b1lkOMM9b5l5ByeKUmQdwrlnxZLqEts3vS0BxBsXowysOWdvltHBkUgEyYv
	wTm9mw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjbh50b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 19:35:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FJZC02001309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 19:35:12 GMT
Received: from [10.48.247.129] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 12:35:11 -0700
Message-ID: <6c324421-f35a-450a-9a39-05aab3136c8d@quicinc.com>
Date: Mon, 15 Jul 2024 12:35:10 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman
	<mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
References: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
 <20240701083320.c3r4aussa4qojewq@vireshk-i7>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240701083320.c3r4aussa4qojewq@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ctGWlwWjxygEGzUEfixMirX5izh2d6XZ
X-Proofpoint-GUID: ctGWlwWjxygEGzUEfixMirX5izh2d6XZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150152

On 7/1/2024 1:33 AM, Viresh Kumar wrote:
> On 14-06-24, 23:08, Jeff Johnson wrote:
>> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
>> files which have a MODULE_LICENSE().
>>
>> This includes three additional files which, although they did not
>> produce a warning with the powerpc allmodconfig configuration, may
>> cause this warning with specific options enabled in the kernel
>> configuration.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

I still don't see this in linux-next. Is anything else needed from me?

Of the almost 300 patches I've submitted to fix these issues tree-wide, this
is one of the 13 remaining. Hopefully this can make it into the 6.11 merge
window. If not, Greg KH has indicated he'll take this as an -rc instead of
waiting for 6.12.

