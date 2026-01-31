Return-Path: <linux-pm+bounces-41821-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNkwFUGofWlDTAIAu9opvQ
	(envelope-from <linux-pm+bounces-41821-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 07:59:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD3C106C
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72FA3011A54
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894EF329392;
	Sat, 31 Jan 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVIWM4tE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NuqGSclw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC7315D31
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842749; cv=none; b=XSRUcMOYUNe1igcyLlaYEipFe6uwSuBzmujaKdaoqoi1AEY9T/acoD7IrlP+9rtZ+Z1jS6pHYYH9fm0kMRA8X3ydZe0s29C/B98xzSPzH1bDdgmbQH/lvS5l0J/Fk77m6r6p3w6FWzIZsnxk3UKs9VWOK5Ma4U2JT/BcgQNU7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842749; c=relaxed/simple;
	bh=/0+T+cFkdki/dh01i28H9jbcBtphAMy5PzjX7GklI6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc2p2OjyueckC8eB8Wf6YLngoqvJS86ANBDtesEw15Q+rtdVg/PjIlAHifsJau47oKsC2aG5q6HW/YxKOyblqu52Wzs5T6wJTt8gmqZ4m2VwgQZga8DQVZ819Yz6cHwgOlM5/wGaFXxGnRDR7ZZA8w/xbI+DQyMaluFYpKHh8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VVIWM4tE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NuqGSclw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4UEpX447403
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 06:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QP+gMghqHEAGfNEaofiyayNE
	TjTnaMIGARKkwi6pRcU=; b=VVIWM4tEIys5/eEU4ZhiHvTYxD4hHdaW+6PtZJXh
	LBNR6quW2YcZUkz/cL/Bu8b0qX+sELNn87aTG3QS7oXO4u7RyMXDp3ht/mSIAIfV
	QrZ398/MBL1jaUTA53cKr2fW9UOVwuD2peSFX46biK2iaX1uAdoP43fVlWhkZ2UE
	auxWJBAu6kesmH3swkSqW0WXVrVDMAlNnb5vZJDoM56Io6X+jOtsRgrX/5hD7ddD
	xCWJt4muiyEgayDE5RGSA0fwi/Y0OIXZS/jqZ5qtNJU8LrUjf4xPlnRBRS04WB65
	mjdbcIBZEUAQmr+p+oh3+xwJGHE5UBT5UrH4DW1o8h708g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrrajs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 06:59:06 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f5337e9fc9so2837592137.2
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 22:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769842746; x=1770447546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QP+gMghqHEAGfNEaofiyayNETjTnaMIGARKkwi6pRcU=;
        b=NuqGSclw3uzbdVMEN9cjPcutiYnBOPIwiHij7AQm0J9KNA8dN6lec3/AZG0foUCGNn
         FNyU4/0jJF+H7E7texG1Q60NqM/K+XpjmJ4oYJROBTYUNKpaQ6MDZd1IfDXMFiMenmpS
         VjSbPBhRJiL31e/uFT2+vAu4SYbHXol8SMu6555WAPN+M6jSkkdpFwUuPmMNSbyavg1M
         OtWZZx9lEi3xKTEroeizlFBIEM5otO8PZQH9anq7R3LOABN37EsN8S0rkxXFTcS5RJxF
         p7KETytrGEAc+QOchtjK+Ns3PyTnu8rc/OPDPHWlyw5073F7XpipBhiVUsIFwAOLEmyR
         YUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769842746; x=1770447546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP+gMghqHEAGfNEaofiyayNETjTnaMIGARKkwi6pRcU=;
        b=RmnP6ZBY9Ue+/fZwSGOwGt2rIBMR+eS7hCO/K1hYFveulEctkr9SPPOAQmvGz1LlYT
         Pa4IcMbgBminyonBBonK9DfZj9WMolx1yWUB4BJp3vdQg4aOXR/tgKs2Z7HMAdUKwP4b
         XithVUoT1b85gkcM1BVmgZkqJwV7zLheT7/5vNtRK/S0ZNkyUqkRBlMI6HhmQdChQH1T
         g2GZJ9Lhrph+tm0L//jYTd+hJbNT7WQriU/LLG95NhXzWDMbma2uL9MSGMS54jgmm4C2
         GYTgie4Btiys4ZHsMsQjZlrSkLUb/RoDjK3s2COE1dMIiJJNBZbPPj33PeARRI14UB+m
         KpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo4E3EaqYulz1D32W7fFF4egP5UNJO1kF4nXfY/IRu6d48QY44ekVkgoklKdJ7zkW38cVeJFd5Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xhLhED6R2ksNVArBIy0U+ExDYNU4qn5TuH7AVtAf83A3HtcZ
	nGggd9DBZOD9g++M427XKH1z6AcDIiv+PmYO1rxCHbAC8OpMukESAVLGaB/RzK9oMDZnHeFRFn/
	KnHOOhesmt4HBJOiwFObjISus96bcQolVGDWBQqFyYHinDWhCbUo2QIsL84HK0Q8qSwlXGA==
X-Gm-Gg: AZuq6aIYLi9cvCU0eytDJVW87Q15IgKxaqATsMM0XtlD/Q3bo4g0geBsotQN/sed0aZ
	aRcs2LQCf7kipWYFofuQuQgxjcbXLKXRHuTiCyMoSseOqlaoCQXw9sKnZqQrrOnvfePFcpuM3jG
	HPoQ1sIEDeX3M0PVQOvcsOgbx8uRKABXKsruOFTRQFY16AdeTag4E2qzz4/JA8IabbV7YwHWkRK
	13uC+4/Xe6z09G8+MpfqBygXiIP3vk1RPs9JOHMZA1hQZXYZEO0rQ77z6+wQZnMajUcf+z9TW0A
	UMF1Uh6/ZzSpk7xt6gOZPGGvB6iO7PQriLINNkh5gJYQpyd7fsndG/tMkeoJHGbMs4GsEy6ZyHc
	B8KJUEs+UAAF99YAxG1W6iqpavdACdRVJGONl5uKFYPfwXWsDFKIkegH35ntjpLlk8Xma0mVK15
	Vhaker/T5vWcp/TDr8A8uWBa8=
X-Received: by 2002:a05:6102:3913:b0:5f1:b9bd:ab9f with SMTP id ada2fe7eead31-5f8e260255dmr1680070137.21.1769842745895;
        Fri, 30 Jan 2026 22:59:05 -0800 (PST)
X-Received: by 2002:a05:6102:3913:b0:5f1:b9bd:ab9f with SMTP id ada2fe7eead31-5f8e260255dmr1680058137.21.1769842745462;
        Fri, 30 Jan 2026 22:59:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074c0143sm2132669e87.101.2026.01.30.22.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 22:59:04 -0800 (PST)
Date: Sat, 31 Jan 2026 08:59:03 +0200
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
Message-ID: <md3ohsrso7hldhhlqwsky4rc7yf4uvpugyctvpge3emfc5xgsl@flei5hr3fxw5>
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
X-Proofpoint-ORIG-GUID: DQKCkDguJDJmITjj1MsVsWjTpGt-AOtX
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697da83a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=OmOFX718bP5z8D8vryoA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDA1NiBTYWx0ZWRfX7Hxz/ZdndtpR
 pU+VrTAlLQNRhTDcxYj/JNlr7leeolxcSpa7HBpxl0iu+Hs7U0OxaJspVbQ3b0kUPDUsJvORvWC
 bD3DbmvmZ2OPcUum1EdDNPguRHZxsHO1BjcTPO05lQobftlosdVzUs3J0pSDdF9QxSxUiDcaLwA
 gtVryJgAlU2OVxTO1njt+OEtVCuAkU87qKFK03G80BAKFtov8AhqiqaRZ/TWHGLwNqCXyEgtnQU
 iPCMjjXzaXiYEeQzZ3NeAJeqePO5Hl7XblVKXsqBaxzwlQSlIFpujhLyeD15PPLn9zePlv2p24M
 2qZOOGcY7NAS0oslXIAaxVGmEtv4/L42o2RSh1fTyG72PJeevZ4Em8CoH237QxfximNOnPDqifr
 G5gJWiYjpg2nhYQVUQDBEEPC4OdutjifxJLyhhaaFsWxLggEXT7O9OAhPrUapPCkTZ0PknGHYUC
 PBVVr288qF7d67UPArA==
X-Proofpoint-GUID: DQKCkDguJDJmITjj1MsVsWjTpGt-AOtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310056
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41821-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: B4BD3C106C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:54:45PM +0000, Mark Brown wrote:
> The lmh driver triggers a WARN_ON() due to requesting an interrupt with
> IRQF_ONESHOT without a threaded handler:
> 
> [   17.414825] WARNING: kernel/irq/manage.c:1502 at __setup_irq+0xd0/0x7a0, CPU#7: (udev-worker)/154
> 
> ...
> 
>  2361 18:49:55.941384  <4>[   17.415074]  __setup_irq+0xd0/0x7a0 (P)
>  2362 18:49:55.981820  <4>[   17.415085]  request_threaded_irq+0xec/0x1a4
>  2363 18:49:55.982122  <4>[   17.415095]  devm_request_threaded_irq+0x80/0x134
>  2364 18:49:55.982365  <4>[   17.415103]  lmh_probe+0x31c/0x4c8 [lmh]
>  2365 18:49:55.982594  <4>[   17.415118]  platform_probe+0x5c/0x98
> 
> This warning is there because IRQF_ONESHOT is only meaningful when there is
> a threaded interrupt handler and this driver does not register one. Just
> remove IRQF_ONESHOT, it wasn't doing anything.

I think it might be not that easy. The IRQ is level-triggered, with the
IRQ source (if I'm not mistaken) cointinuing to be high level while CPU
is overheated. By removing this IRQF_ONESHOT we might get an IRQ storm.

At least it needs to be validated on SDM845 and SM8150 before merging.
I will try doing that once I have time.

> 
> Reported-by: Aishwarya TCV <Aiswarya.TCV@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/thermal/qcom/lmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

-- 
With best wishes
Dmitry

