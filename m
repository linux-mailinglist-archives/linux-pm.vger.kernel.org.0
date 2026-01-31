Return-Path: <linux-pm+bounces-41834-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYjHPU4fmn7WQIAu9opvQ
	(envelope-from <linux-pm+bounces-41834-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:16:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75AC3260
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182093021591
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAB346A10;
	Sat, 31 Jan 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Om27ghhq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSg0mGmO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC35344D9E
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879790; cv=none; b=pwQIW67h3Lb0R7G6sYvPymRJ1S+dx2h7hLuAHAmVOceZ+5Dpdn6ECj0gHEwllcxaG93tVdVhAry6ngBIIb2rGuSOg2Lowq3j4mnlAgBOGOft0itf/T7uHt+Us5bRP/uQienKHtdcBUpGzcbnXznJLQlU+Q9svIiCiQm63/nzxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879790; c=relaxed/simple;
	bh=Pp2tZNayAeAGhetrVryvZEXWIfHJpVhfK8vW84vm/BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHo/un3bj+lSTBR1RO/usTZc5rjbAVc9yB+BlEyZOVPAMb4PRyNFVFWqTxNTfQs8DnfhKVfYDO1grKSDbvBC5lfgWlU2/DqEwh1zCIpOjC4gGJYS1apxFAdjfyYXIXKhjcE6pJ7BJ7I0KmogkNNhloAUhyAzXMi0Gc6Rmn4Jj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Om27ghhq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fSg0mGmO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4bvma1061873
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pmjaigohOle/8CP1P610mumz
	JkOkjP4G17HW9NWw0JE=; b=Om27ghhqHpM8Mw/Q9Qxt5XR176f0f7PAWGZqAXqi
	SChUHcTm0UIEE3NGvIjPshu3bCOR/DsfBNcBjenhNXlG6lEDmwghc8zjhLG1D3qW
	MeCvbR4LHeKO819ZaH5yooFe9Vl+akmPAAJNKjAWxc78a+SlXGkHIXCa6aNJA2sr
	O2JyQe5aE5gUNcXrfRv+NimniJff+ptzDlPLm1+4xR5jmTNw6w9GpTUq3bQnBxeN
	P7LAhAGxSkqWoOujnGja59OFnIfGL5/KoFgT5QJFmrK1jlkGjYhDsx+0uErmE2KS
	LYhYm5mC55PzBbcGRSDiWy6CGYNId8eExfNoB4e0Zo7fXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avnh5qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:16:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b4058909so818257885a.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 09:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769879787; x=1770484587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmjaigohOle/8CP1P610mumzJkOkjP4G17HW9NWw0JE=;
        b=fSg0mGmOniqC38fwgje5lh1QNfD/GM7F4jyAu2VJsR6lTa3BcyTIDdtCFRh5EQqbkX
         uwBvfw/4MI9bmJvAzAAAUy9y567zJdsmLP/+0dqyzFxBh6haIjMtHPjTledCXBicPBi5
         9wh70nxki0DMlHoRfOTJ5N4VKJYiv4qSVzTPcKNr3/fTTjLv08UwLmg1DY5VI4NKTyyC
         FUlagvsNxsi5MS7t3Rj6nQ6tyAA3pjeM1arTti46utv4LcAOmD89slBgNk9Va90rf62t
         ewz+s1uQyhEbsYSbZwQ5uETlwK3ooE8vyTq1xM85lSl/XuLd6Xm1AMxrexGaXc0muMfh
         czdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879787; x=1770484587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmjaigohOle/8CP1P610mumzJkOkjP4G17HW9NWw0JE=;
        b=A++OXXdOTCEWGIPZPE2Vm/Ue/MGkj11RpwCgdxWANkGm2WYYGTeWWPMackqFtncjnt
         k3FsRYDhyVaqnaG0MgaCRIghTa/NEx7kLS93xiZNxEPbhOEIyEs1fdfePR6ty4W9MDBM
         cIK+EZtd6583VxYokOvHjjFsD36+At9zbtnJo5S5Tgozl58Fw60Gg1RObvNue2st57P1
         uAAHa5vIjxqKQP4CTi46UyQ0MFlHLLXRmgWgEoGJpQ978mAPQltkdqfFe5T1s8Ay5Zk5
         ond1QjwtJl+nTBXlugPtgHIHVPx9xYO0tiHE8ssC30i1puuxdAr8tgJQFVyhYgm3Nd8b
         i69Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz1AdSQh1zAXbsRR5wVLIQx1wVxbdJWiLmq85KvOGeTS9RaJdUUXZ7b484iPshJSzOfGHu+KMnYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfi9qCAOU8oOMu6cIYDfMYTocSHoIvPToEPaYm4cszk+SUI5tl
	iC5zKYMmozhZeZzhyNSyK1Tg3wRhHx1FMJvnZWD7UgVD9UJNo0K6zpY1ysISDEFaBjvHc+dmCHe
	CJgUW1kTqyaRoeF2OdPCYr8H3Ldr7mobTx0j68C+1KZM09yYspREW4DeheXUDv0uc54Ru4A==
X-Gm-Gg: AZuq6aIMAQqiteaFjBKu28uqUYOkh+CNHqzUpFvb5HZCh/yHIHWR7kfnhd8iEc2K5Wn
	OmVjRTdx/VGBYWM7kedhU7D+XDMfdK81fcovgMHaFv1XeE5HNCjxzDfMWwn7Dki2ciDfSAr+RDR
	1aB+VrpCN22qePqBdGsx2rXkpO7hPMD5q5Swk4w6Ovodvz108gAsVOV7IYoiOn7JbQHCtZaQLB1
	Ib7dIAANN3mXYmaM1tFbielIdc9UhMmB1bszyE4v4GHS6gtaZOoWNpcCPIwOzlsi2regY01FF6N
	CMPjp1jMiVVfxSJWj4JRegImLvBl5Ov4PnIP3GCjmBogv5MuO30KGY3+39eNd6aq1x5nJcAQ1cc
	PG4O4ujnIstMpn1hXiLqESn4bSy9qmMlkRsQB+ng36JEpn8rOR+ovOYcb5PLRC65DkhPNIPNT4e
	EQTyukP7KPHRwruDXAxs0aoSY=
X-Received: by 2002:a05:620a:4706:b0:828:aff4:3c03 with SMTP id af79cd13be357-8c9eb30f3e7mr803502985a.61.1769879787255;
        Sat, 31 Jan 2026 09:16:27 -0800 (PST)
X-Received: by 2002:a05:620a:4706:b0:828:aff4:3c03 with SMTP id af79cd13be357-8c9eb30f3e7mr803500285a.61.1769879786778;
        Sat, 31 Jan 2026 09:16:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625f6c13bsm21424401fa.30.2026.01.31.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:16:26 -0800 (PST)
Date: Sat, 31 Jan 2026 19:16:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aishwarya TCV <Aiswarya.TCV@arm.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
Message-ID: <o5i2yrwpjxugzsyec7gkkxaclptshcn2swjwzeb2pxhqngj5y5@4ceaeiddvdyq>
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
 <md3ohsrso7hldhhlqwsky4rc7yf4uvpugyctvpge3emfc5xgsl@flei5hr3fxw5>
 <aX4amIuUFUtv7M2J@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX4amIuUFUtv7M2J@sirena.co.uk>
X-Proofpoint-ORIG-GUID: Xsg9t1Td_CgOdEzaE6OwFTfr6RbVnSPS
X-Authority-Analysis: v=2.4 cv=bPMb4f+Z c=1 sm=1 tr=0 ts=697e38ec cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FXXLhfyr669pEzwslaoA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Xsg9t1Td_CgOdEzaE6OwFTfr6RbVnSPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NSBTYWx0ZWRfX0jAdmosNaa+I
 J3X1efpbndr29JXpMIdctUw2Mw4EE5KP61EvkJQKSTEhEkQo508iuI7Z7uFn3bD/f+svhmfqvwi
 oK6StK+i1AqqlpPnLbmvamexo008V5PtDHtRaYB0jiImYfl1c8g3OBaURGnhHZ+hdOEjB6fp2LF
 B1IH7CiAADfkp38yWkHJVx7obR7g/WO4oB8WZ7foDLWsFZPYPQjdL5xnwyBDCVFyTMmG1bJwVeW
 TSi9BS1k2njTMSCzXkAVkqm4ldP3rJ11iWhK61eePGY3Afd7MPBtKlXOte6ZS+jX2GhAiE1xyfc
 Yj1OrLFGkucFvljUMguaajXCEnYpPLxhi7MvkU8nEWhYuB3UpTdbTzoC8AxGsHAZwSOE8IX2HfM
 eAJ0/t22ko4hnliVw5X9n3+qOhgFiqq2NXwE71FEa/PD5cJrK+XLOKOy/PdU7U4FSsLQvoT1HXD
 /yBbmqo7MXYMkVmMdYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41834-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E75AC3260
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 03:07:04PM +0000, Mark Brown wrote:
> On Sat, Jan 31, 2026 at 08:59:03AM +0200, Dmitry Baryshkov wrote:
> > On Fri, Jan 30, 2026 at 04:54:45PM +0000, Mark Brown wrote:
> 
> > > This warning is there because IRQF_ONESHOT is only meaningful when there is
> > > a threaded interrupt handler and this driver does not register one. Just
> > > remove IRQF_ONESHOT, it wasn't doing anything.
> 
> > I think it might be not that easy. The IRQ is level-triggered, with the
> > IRQ source (if I'm not mistaken) cointinuing to be high level while CPU
> > is overheated. By removing this IRQF_ONESHOT we might get an IRQ storm.
> 
> See the commit log for aef30c8d569c ("genirq: Warn about using
> IRQF_ONESHOT without a threaded handler"), and note that a oneshot
> interrupt will be unmasked if the main handler directly handles it and
> returns IRQ_HANDLED instead of waking the thread with IRQ_WAKE_THREAD.
> The handler in this driver unconditionally returns IRQ_HANDLED.

And looking how it all works, it looks like qcom-cpufreq-hw disables the
IRQ generated by the LMH driver, which in turn disables the LMH IRQ.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> The above sounds like the interrupt needs to be edge triggered?

Well, it is a level IRQ, it signals that thermal mitigation is required.

-- 
With best wishes
Dmitry

