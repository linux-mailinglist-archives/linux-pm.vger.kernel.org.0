Return-Path: <linux-pm+bounces-27274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B214ABAE3F
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 08:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D18A178510
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 06:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760611FF1C8;
	Sun, 18 May 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nwJUnOjE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CC1FDE19;
	Sun, 18 May 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550600; cv=none; b=kmGTRcoTEb/EN/5xwyRBjn8/ayI+7rs/THpJA3u+649qdj/TuqeTlbl7eMT0BJWO91bXnk4UFn34Da8ncnWgVj3xOL6fHLH5kSGXTE7Jhc+OecWdB3GgE+LBpBI7Q3aT+Og36r64kYPfSteMiAZhIYRJYMhzp9iWBHQ2f8t2aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550600; c=relaxed/simple;
	bh=bufgsglsQWfHFRRrPMqp10TFT7hoem4p8WMMzUJd0x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JIs4TYHAMifEkjaZOKO7lpCnNQy7qAK0HOxnhOGtTg2bH5kiO7g5gfJ9WotirOEqpTX3WQrVs50RFZIJXdZhNL3XcqgkIlSbFW0d/+AuPc6m/20pOoCs+Xb3leQMFLeLoyVwBMmiAHMUM+w9dbgPf81PZYhJ/RVO6opHA5qH76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nwJUnOjE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I4r8jB008297;
	Sun, 18 May 2025 06:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mByDZ2sm1A7KALnW7yMHszVrSwpRXq+3y+nT3kbPp+4=; b=nwJUnOjELH6FbNeV
	IOLI0IuWZDSdkphACUmG9jcUQ4nFigbeL6C0K9UQrFSBkqQfFcY97dGO48WkpMDk
	7k+7SCC/+kcLd9eg+Zj/ps7bx+wq8Qd5NGcv49N/GdtX06piXdxdPtnUDu6Ysm2V
	T6Z3MtBLE/dGSjMu7IcDXaTtEDw3AD7c9v04yQWZpojVKY+rJEoEaD7bDH66KIiB
	tDNeYLxIcwNp9tHgChN/BbCSsEiB1t1PHURIKbTL4IzWa9bxzXC8q+6NxRgStAWd
	T4TJtRQRvnksx8g1zQdQ4TANNzwO+PJYaYl++XQ5ZuZb7sRL60oRRL08MZsLALEA
	v6AhSw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjp31mb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 06:43:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54I6hEfx020527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 06:43:14 GMT
Received: from [10.216.52.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 17 May
 2025 23:43:11 -0700
Message-ID: <e3d44759-e004-4bfc-b21f-7a8cf47ab7c5@quicinc.com>
Date: Sun, 18 May 2025 12:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM-runtime: fix denying of auto suspend in
 pm_suspend_timer_fn
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <len.brown@intel.com>, <pavel@kernel.org>, <gregkh@linuxfoundation.org>,
        <dakr@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Patrick Daly <quic_pdaly@quicinc.com>
References: <20250515064125.1211561-1-quic_charante@quicinc.com>
 <CAJZ5v0hanp631h_VGijY5Joj=tQn=sENnzu5AZDuqWsMiOi+mw@mail.gmail.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAJZ5v0hanp631h_VGijY5Joj=tQn=sENnzu5AZDuqWsMiOi+mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B8u50PtM c=1 sm=1 tr=0 ts=68298183 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=NyfPPY6N7I_wdrWjTR8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H6BB-9ITNKTFjtsdZicF3LBSGnwJqKd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDA2MCBTYWx0ZWRfX1Amb4nw9F2oS
 2od8/4epLwESBJHlLg6VdYdd9hsdgEaoZT1EEz4T8s/qE8pXO1geBhor52itZTzU+d21OgN8cX7
 jXE+fLTQzxs88mSiiDt4mQcMly19fUsDP2/uwD6yt/cbzbvOnrjwtMUw6tG9oq45HCCDmtu3L/C
 0cMHSHAcJzRpwYNZmBXgVWH+pS0pmXnvo6/GpVeTDOhUPTR+GEspCbBa/8kYZBicskpFbYJmwhL
 y2C4uMNoX4fBIeoCaFwa+sGHGvabLAbte3qLjAc7CVXbuFyDLvUrDnDoFCM/hDu+DZAP6cucZQu
 UW0S231TZfBsWRnFIYqJ3Y3xt7Rq9wYlg8RFCm6aeAYHsmK6ZJyykuna2FFd1b6KLHwdUNCzC6K
 tv7C3glOXVg0zlSXIgD0V5YskmFwzSizsiD0llCzyfh8lMTsd383YnsXjuw2TRLl0N1MlHHt
X-Proofpoint-GUID: H6BB-9ITNKTFjtsdZicF3LBSGnwJqKd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=997 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180060

Hi Rafael,

On 5/17/2025 1:36 AM, Rafael J. Wysocki wrote:
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 205a4f8828b0..c55a7c70bc1a 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -1011,7 +1011,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>>          * If 'expires' is after the current time, we've been called
>>          * too early.
>>          */
>> -       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
>> +       if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
>>                 dev->power.timer_expires = 0;
>>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
>>                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
>> --
> Applied as 6.16 material, thanks!
Can you help me with why 'expires < ktime_get_mono_fast_ns())' is there?
We know that a timer callback is never going to get called before its
expiry. May be removal of this check altogether is the proper fix?

Thanks,
Charan


