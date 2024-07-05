Return-Path: <linux-pm+bounces-10644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D04928108
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 05:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A89B1C23CC4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461F425761;
	Fri,  5 Jul 2024 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aVvjLct+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B32F52;
	Fri,  5 Jul 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720151210; cv=none; b=Lg8QrFWSrAysm2dvbA+22dWv3q6HFX48GFImDwyOpgpbV9Je44Jabs9tevtq0ZaeFbz/72P17CMySnk5SonCwgNt9lN1ETbliMTLjjssWlJ/3YN49jbtON6b4UBbINnd2CZJzn/dCOOP0996QMj5ZjbyV7ZEG0nvw/2OZN16udA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720151210; c=relaxed/simple;
	bh=T2O08jGp+Et8lf/CHV6lITgsATP4JeT/bbtW6zMq7Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=atvdOpe2vUm4DdjwYcNQ7zjgeuqUXp06iwUHliq7OdZBSywIr7Ap69+7A6zeAJcMiZ6RjJ8aOnn5t6Dmubco4BGtcjw5huW/4SMd1TAviMvz/50ZEpSGIx6TrCq4P4XcHKeMbZdhYX4tYDMMwEB7wwTSj2ggdPvcbBgtCLds5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aVvjLct+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4650gRHb019873;
	Fri, 5 Jul 2024 03:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5fIlGKLbmHYDo0tO1/ZM35cd+CYT9rRts//EQ2h1qw=; b=aVvjLct+I8/KUsC4
	CZncgxHL8/Cd0lg/2WyAwKbH4XuHty198cTV9C9JeKVrAmauYMNdYdmJoSNSYZ9o
	UeEabu4aZqneickg5ZRkBgQR8ZYtG4KbCpKnuJCRkzcnSUwHodzgj0vSNwKKxT0B
	jGQj5pIq8+wBtWMu+RkeeBhdeW91pyEJ5MR0xelv9TxrwVSWJE2AqnDb3c877duA
	mS9uW1hj1gg55thSrlnW4WaHoP9QsKWrxrQ3LJcJltuOm3VnAtgToy8GDbYa3m5g
	E9aGyDjJAKMR2rmZeA8Ef84ERnQqkhCqnfUPT4heDkDwC1WtSAQgT82TGMiigJVO
	Ua+0qQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4050cycxnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 03:46:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4653kaMG019567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 03:46:36 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 20:46:32 -0700
Message-ID: <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
Date: Fri, 5 Jul 2024 09:16:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <ulf.hansson@linaro.org>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <johan@kernel.org>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZoZ6Pk7NSUNDB74i@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ARZJ0NLPV21P96IVhRlNQqO5XxVO7jnb
X-Proofpoint-ORIG-GUID: ARZJ0NLPV21P96IVhRlNQqO5XxVO7jnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_21,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=621 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407050026



On 7/4/24 16:02, Sudeep Holla wrote:
> On Wed, Jul 03, 2024 at 04:37:41PM +0530, Sibi Sankar wrote:
>> The domain attributes returned by the perf protocol can end up
>> reporting identical names across domains, resulting in debugfs
>> node creation failure. Fix this duplication by appending the
>> domain-id to the domain name.

Hey Sudeep,

Thanks for taking time to review the patch :)

>>
>> Logs:
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>>
> 
> If there are 2 perf domains for a device or group of devices, there must
> be something unique about each of these domains. Why can't the firmware
> specify the uniqueness or the difference via the name?
> 
> The example above seems firmware is being just lazy to update it. Also
> for the user/developer/debugger, the unique name might be more useful
> than just this number.
> 
> So please use the name(we must now have extended name if 16bytes are less)
> to provide unique names. Please stop working around such silly firmware
> bugs like this, it just makes using debugfs for anything useful harder.

This is just meant to address firmware that are already out in the wild.
That being said I don't necessarily agree with the patch either since
it's penalizing firmware that actually uses a proper name by appending
something inherently less useful to it. Since, the using of an unique
domain name isn't required by the spec, the need for it goes under the 
radar for vendors. Mandating it might be the right thing to do since
the kernel seems inherently expect that.

-Sibi

> 
> --
> Regards,
> Sudeep

