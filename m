Return-Path: <linux-pm+bounces-16427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC39AF995
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB12834BA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD66190666;
	Fri, 25 Oct 2024 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fHV/sDRL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB518A6DF;
	Fri, 25 Oct 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836548; cv=none; b=cCGPXiiA4M1VX5mTnCW68UTLBHJd8uYA+9zALA/DxNi8wwblNCrjd+fnjO92Fl6lTsUfDiLAeY0xERgf6aorxR+AImnN2CucYgeQ2TU13xz9jTWIZLDxiMG+RDylUns5EmKisId7UyOeItuc13E54mkBkalfQBD2GjMEtJ4DP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836548; c=relaxed/simple;
	bh=iUuKyIIYb71VLRMYH4ci9GGeuu3H5IdGKlJRBSQs7mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YjB5JciND9pUCkUgOex89PIwGyBUGQBKH6q3Viv6Rs52karXwfOJjRjTG8ojNFRINzOhCjm7ONYstj0A942UR5tL+nexWBwFVe+SEXqbuK5fUnBgNZURTqEZNP1v7qBVNxGjniyyMIogihEwEmbYv3V00q71ppszHAFCi0AZgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fHV/sDRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OKlGF8009177;
	Fri, 25 Oct 2024 06:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w7Mf84VbPhqNkSnSUbM5bCqotbzjmoItpAKa5NiZcf0=; b=fHV/sDRLW3af4Zut
	tbBFaW6L8NLBXbW1NwnMkICQsdBtA/DSqW1rh9rZ/AEACMJsJ1DyFe2D0MFZweae
	IBuC0DtO8Mnvk0Ua9dKyXqetqQtYOyFOssUsPcXP9GyHA3ZO1Sq0BVy7FLF72gmj
	LPJk0wGBBlSyNvkXt6ya7XvX8qDjDQuWuXkuv29WTPsEPsccyunjAi9DMv2r2yHm
	PgJy4hgCa9JTSwWuz6fKrLJWMaUrxr/bhWbcpBKrooIy1MzCBx/HBs/rZKLn77r/
	0rTdWsE1HUDqoUJOxF6tAIZBwDVg0n1hlrfwdge0FYbbuUgvJizXilvZTZkfEqNI
	vvPGtA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em43fwr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:08:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P68hgk031990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:08:43 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Oct
 2024 23:08:39 -0700
Message-ID: <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
Date: Fri, 25 Oct 2024 11:38:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8oGG8ulbuxduqeZUFnOlmGAnLt7x2Dqf
X-Proofpoint-ORIG-GUID: 8oGG8ulbuxduqeZUFnOlmGAnLt7x2Dqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250045



On 10/23/24 21:56, Johan Hovold wrote:
> On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
>> On 10/10/24 20:32, Johan Hovold wrote:
>>> On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
>>>> The series addresses the kernel warnings reported by Johan at [1] and are
>>>> are required to X1E cpufreq device tree changes [2] to land.
>>>>
>>>> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
>>>> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
>>>>
>>>> The following warnings remain unadressed:
>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
>>>
>>> Are there any plans for how to address these?
> 
>> Sorry missed replying to this. The error implies that duplicate
>> opps are reported by the SCP firmware and appear once during probe.
> 
> I only see it at boot, but it shows up four times here with the CRD:

https://lore.kernel.org/lkml/d54f6851-d479-a136-f747-4c0180904a5e@quicinc.com/

As explained ^^, we see duplicates for max sustainable performance twice
for each domain.

> 
> [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> 
>> This particular error can be fixed only by a firmware update and you
>> should be able to test it out soon on the CRD first.
> 
> Can you explain why this can only be fixed by a firmware update? Why
> can't we suppress these warnings as well, like we did for the other
> warnings related to the duplicate entries?
> 
> IIUC the firmware is not really broken, but rather describes a feature
> that Linux does not (yet) support, right?

We keep saying it's a buggy firmware because the SCP firmware reports
identical perf and power levels for the additional two opps and the
kernel has no way of treating it otherwise and we shouldn't suppress
them. Out of the two duplicate opps reported one is a artifact from how
Qualcomm usually show a transition to boost frequencies. The second opp
which you say is a feature should be treated as a boost opp i.e. one
core can run at max at a lower power when other cores are at idle but
we can start marking them as such once they start advertising their
correct power requirements. So I maintain that this is the best we
can do and need a firmware update for us to address anything more.

-Sibi


> 
> Johan

