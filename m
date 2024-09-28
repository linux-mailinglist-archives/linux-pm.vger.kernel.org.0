Return-Path: <linux-pm+bounces-14892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B1989039
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F773B21468
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222444375;
	Sat, 28 Sep 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l+SeJtNx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649222089;
	Sat, 28 Sep 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539712; cv=none; b=sYNf0KIE8EWxPmiWVJ3A81fpBQxX2y7BE4ZCxn2i/lLsCcfPgISSfbL547sSwhHcpo4tY2xuXNnCVjufvJkxU0gN6bHcJ5PG/tngRlNjinv7aM5y+XK3+0LxqLXEFDATDs+xqgvpvt7T2u8u2qkkNTRcW98hiH0ZnXEv0YwwZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539712; c=relaxed/simple;
	bh=fIMubsjAsUXbV/YGdV1q7TthGWEkg23AlPN/MkC1lnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BQHp8/JopLvBgFuhyshPAO64QZtJk4EL7nQRTYaJMjFqUlnjsT2POcK84fmKGGLxmNb+u+yLLGzuJPYI7aLzbiQHoIDC/53MOBa02OU4WDAr6Q6YyA0DlM+Qjdb3FRqR+xivuQnBE5rSuS8/MJ5DwhSiYUduMQiywxuSASBuYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l+SeJtNx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48SG0gl6017977;
	Sat, 28 Sep 2024 16:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1zgACunI07I9LNrrkDzVrZ7t0SaIRd/sniZLEKl4ay4=; b=l+SeJtNxcd/zArDk
	jeYn7Ys8OaJ21QqsqKD8TqlRjOa5TmudMNolgFPQWq470L8/CBBMfOoNSc5EaHkk
	SoR1IIc7gGdxNdnLZiF6umkqPAc+ZITfIN0Pgs877chalPaxaSxqUKo2juKTeoKR
	N0rekNVPXgLrLmoUoyWCIjRV65B7k+IHVsxdXTgXNEgtiwpBt82NHEu8Q1jeEsb2
	ZjP0OH1i6IR18qBBOqYOAV2o5091AErqKBW9faOYatufXpS4fC30PVmKMneX9EHo
	YN8aqmnBnwkYsA79odvONLCvupUQmSvt1ZbDDlsJD+stbfvRxkzWopNN4bvwA0Oe
	m13ihw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xaym8u6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 16:08:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48SG8EUT005984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 16:08:14 GMT
Received: from [10.253.39.0] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 28 Sep
 2024 09:08:09 -0700
Message-ID: <1ab63479-15d1-4116-ac70-9bc42b85a972@quicinc.com>
Date: Sun, 29 Sep 2024 00:08:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] PM: sleep: wakeirq: Fix a serious logical error in
 dev_pm_disarm_wake_irq()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan+linaro@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>, Zijun Hu <zijun_hu@icloud.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <d-gole@ti.com>, <qingliang.li@mediatek.com>
References: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>
 <2024092842-diabetic-suction-861a@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024092842-diabetic-suction-861a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xIX_KWAeKX7IacHfrQj0yP_fBpyXxkH5
X-Proofpoint-GUID: xIX_KWAeKX7IacHfrQj0yP_fBpyXxkH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409280123

On 9/28/2024 6:50 PM, Greg Kroah-Hartman wrote:
> On Sat, Sep 28, 2024 at 02:26:27AM -0700, Zijun Hu wrote:
>> IT is a serious logical error for dev_pm_disarm_wake_irq() not to disable
>> the wake irq enabled by dev_pm_arm_wake_irq(), fixed by simply correcting
>> the wrong if condition.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> What commit id does this fix?
> 

it is below commit ever mentioned.

tony@atomide.com  2018-02-09
Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")

>> ---
>> List relevant commits as following:
>>

there are one more related commit shown below:

qingliang.li@mediatek.com  2024-03-01
Fixes: e7a7681c8596 ("PM: sleep: wakeirq: fix wake irq warning in system
suspend")

>> johan+linaro@kernel.org  2023-07-13
>> Commit: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
>>
>> tony@atomide.com  2018-02-09
>> Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
>>
>> The former commit fixes the later.
> 
> I do not understand this series of commits, what exactly are you trying
> to show here?
>

there are total 3 history commits mentioned, and the 1st fixes the 2nd
which in turn fixes the 3rd, and all these commits involves "unbalanced
wake IRQ enablement"

is the issue "unbalanced wake IRQ enablement" relevant to this weird
logic which looks wrong ?

> confused,
> 
> greg k-h


