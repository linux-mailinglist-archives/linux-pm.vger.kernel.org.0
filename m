Return-Path: <linux-pm+bounces-15945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251339A3BAF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA0428157D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6BD201108;
	Fri, 18 Oct 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n6U8NUEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01502010EC;
	Fri, 18 Oct 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247788; cv=none; b=CSMGjbXX1TMhrgeWix1R+WyD1VHBCsU6lND+AyCYWJvJM8B1w3rEAjw//sVqhT7AiOuu4nSCp6SxFtFHo0SXpSPyTeNQ5QsrKyvSZgCq0e94Awjocc1hRo4tCp0PbS7B1xCJCWqMIoz/VnkRddOmpb5iTNRlxHsr0PtJx/fsago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247788; c=relaxed/simple;
	bh=zpaf4oJ/9WocXriS7wtNGD1VFviEdWLhjfYzbGHb59w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIfueSfd/pWOi5hEgLl0WG/oQpT9S/F0KCah8wASiKrTuzclZvl1AIUzUHVcYo1YmQgWJ+8cXwhCp4OwKAy3l65CmB6SZcIRtKp2/4FTq55KDaVC6nW33nfV/3YjGy3VafRsSagaXll4LEXCZlirKzsezj4rjGxUcxGU3Gvz1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n6U8NUEs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9FDL0025003;
	Fri, 18 Oct 2024 10:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aO4qcXMHeJ9YzQUS8yus9DWqiYoGjT
	dGSEwB2gwrr40=; b=n6U8NUEsSA8dnOZc486WRFWsUt0YLVeGeuHDH9k5TlTwa4
	Hy5u834hMrDeada2h41WBkNtVEYkd3Cj0nKEM2tMyoAGX31zsZvUVL4jVEQ5sH6K
	FjuiI4rZovis9tq162kefAnLCGm+0pg1ph0RzbZ+iyERCiLoy/kxPsjMSVJ5kbpQ
	g0a/fzojFgD+T4X9taHlo90E/OcV0QshoV0PvHxjfW+OMm5UCNU6GsRAh34quOz+
	QQ08J6SnoMlZpAyRuUEPzUwoV9mikqHOYIKO7V3xO273JlF1gfE26KPwKqSISmtH
	o3WlifHmLa+MBLFGc3kyJ8O0rN1nsQBm1oY3XGYw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd8fmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:36:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9Us1l005906;
	Fri, 18 Oct 2024 10:36:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651bjdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:36:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IAaFGm20906492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 10:36:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B89EF20040;
	Fri, 18 Oct 2024 10:36:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E57720043;
	Fri, 18 Oct 2024 10:36:14 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 10:36:13 +0000 (GMT)
Date: Fri, 18 Oct 2024 16:06:11 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH 1/1] cpuidle/menu: avoid prioritizing physical state over
 polling state
Message-ID: <mq5nkqfyivbo2cbpcgr2pwz4iil2dcejbyxiynxvg34bgf4h5h@ixuoyqzn4qjc>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <20240809073120.250974-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809073120.250974-2-aboorvad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CFxHRrhfTYIp-DNhOdFQNoSyMc1kr1QA
X-Proofpoint-GUID: CFxHRrhfTYIp-DNhOdFQNoSyMc1kr1QA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=880
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180067

On Fri, Aug 09, 2024 at 01:01:20PM GMT, Aboorva Devarajan wrote:
> Update the cpuidle menu governor to avoid prioritizing physical states
> over polling states when predicted idle duration is lesser than the
> physical states target residency duration for performance gains.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  drivers/cpuidle/governors/menu.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index f3c9d49f0f2a..cf99ca103f9b 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -354,17 +354,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			idx = i; /* first enabled state */
>  
>  		if (s->target_residency_ns > predicted_ns) {
> -			/*
> -			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger soon enough.
> -			 */
> -			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->exit_latency_ns <= latency_req &&
> -			    s->target_residency_ns <= data->next_timer_ns) {
> -				predicted_ns = s->target_residency_ns;
> -				idx = i;
> -				break;
> -			}
>  			if (predicted_ns < TICK_NSEC)
>  				break;
>  
> -- 
> 2.39.3
> 

I tried to identify the number of times we enter the snooze and CEDE states
on a pseries machine with and without this patch applied while running
the daytrader database benchmark[1]. The results show that the number of
times we enter CEDE goes down considerably:

// Current upstream 6.11

| STATE | NO. OF TIMES ENTERED 	| TOTAL TIME SPENT IN STATE (US) | AVG TIME SPENT IN STATE (US)	|
|Snooze | 6,389		        | 221,592			 | 34.68			|
| CEDE	| 160,368		| 13,288,855			 | 82.86			|


// Current upstream 6.11 - with above patch applied

| STATE | NO. OF TIMES ENTERED 	| TOTAL TIME SPENT IN STATE (US) | AVG TIME SPENT IN STATE (US)	|
|Snooze | 140,267	        | 6,400,073			 | 45.63			|
| CEDE	| 50,884		| 6,553,641			 | 128.80			|

Above data was gathered with the help of power:cpu_idle tracepoint, and
was recorded for 45 secs while the daytrader benchmark was running.

[1] : https://github.com/WASdev/sample.daytrader7

Thanks,
Gautam

