Return-Path: <linux-pm+bounces-42620-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHx/HORqj2l5QwEAu9opvQ
	(envelope-from <linux-pm+bounces-42620-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 19:18:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECD138E2A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A5E3302DF60
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D626D4C3;
	Fri, 13 Feb 2026 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSPhqAaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pxy0petO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872AC27466A
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006682; cv=none; b=nY2TP52arJPiuKXBybm1bQU7LUNIOYs2VksyQp8z9ZRrl8asjuN3kAY10blIj0+wPZ4lg3stGMo+eq/ychgWcDQeEXjbKNrTqe29MjTV1UGXkPVjFmazPHy2GK0WzEUjPKYH7XBCnrzZHSEWnfoOW8GlITwDVFcWIWtNxdnGTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006682; c=relaxed/simple;
	bh=Do4BGO1LGcHGvCJPpurgH3E9R2Ist8VqiaUHKtL5y8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnELmjcR9FtW9isMsm37lBH+XkkoFbCAVV2FaEVgoBHndiyqxjsvD/nWEHiFAPQjYj1K0O79xIjl5TaNlT/1Kbf66uMBkjdVDoj39TAdzl0OTbtGM5b3WJnazrR8OIphE8Lz9UkXX/aPGi026baQtCQTcyyzi+hBXNWeS/bF2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mSPhqAaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pxy0petO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DFP8GF3424508
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 18:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3SdWpZs6y9lD7M+9Gt2ougNs
	RDsaLktIwBXMbAcdzug=; b=mSPhqAaVolMHDdpabzyqkpZ99wtSLj4yZW8Weiy9
	p+jpaQKF1nFlmL0TSFIQ07UP0kA8Z6gFm4p02edS29gUfyxYHqYBEhD9MMzQon7f
	RpbECtNFDStBlNwgLWLKN2DZ8vMoF8zqvmqWfeAjSGFumvoa+5OFVOr7/iPQ12IO
	MuqtgYey/sV4Fas2bovWr3nvNJKGk/OwC+FOfnFKDuT7OD0Wwvzp4/GwO+/EBnpY
	r2YWaJfLZ9ko9XrJj/GP/vFGxU8KKAPMOP7XvqocBvwccmsBvemUAa9IaYPlNloK
	UhnYfVMgWouL0+OvNLhXDI5v4LfU8NPrsQQ7MwXQXs/3mA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9yvrt89e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 18:18:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4b8e9112so30429585a.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771006680; x=1771611480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SdWpZs6y9lD7M+9Gt2ougNsRDsaLktIwBXMbAcdzug=;
        b=Pxy0petObSpM6rLiHmx4UMW2ZOnLKPxrfYLkbcV7vK38YJFR5FjkLRFCSbbdqKsJ3K
         Wx9mSk3S4kSSyVB2j85NqbYEpwpkFnbv7TrN7+zf4B7RCZEf+0+wam+A/igbEeVT2JzI
         iaRGQWX6x87zOGiQ/jVOoc5oBClnjJnkS9OSVcVi6GoW+8sUo+2lciTAUm98IVxQ6EG7
         3oaTcU/NfrufTxqDg3rGfZ2fxb5R+EwEc5TvGiqNeUvgfopgV6jySw35ktiGoZcijRJ2
         cIKGc07jbWo6XeBq4NNl5rQ4GCrm3fgn2ygiQ5kDeM67SWHUU9plyWGQwsMd7r91vxZR
         fYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006680; x=1771611480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SdWpZs6y9lD7M+9Gt2ougNsRDsaLktIwBXMbAcdzug=;
        b=P77DH1Y4djVHuEpWHEmamvWSDsGKQuIE8evqRnA3dQy7bjHEPdvyRDsgJzieGF2zeP
         v15vE+IXyniKz11cqaKZfQG4mixWu4BrBqL/1CVrXVnKghns0ARf2ineqFhQdLR8fLLw
         hXr7BMKN4JVc5glClR9L74F8ImK21yT0FhJ29RuVy9UjKAEoy7ccxcnYUeglm1ju/Ttj
         jMHJ14fJKoOdLv0VHIWWkzloUHVTTCfA9Aws90sA1GrVhoDvfEErbRihcuPWN7F/gqAU
         XqFGz5ATIcp6kyjTN0Uzu766jBTT9EiTTgBDcbAqX/jfW68wxmusfPl/pq1ZqCgoc5fG
         YJxw==
X-Forwarded-Encrypted: i=1; AJvYcCVXk5RYNeLR+si10iH5xgh2O2yX3Ed2GmXEDZ5/CQsL0aEpl0LlwzpI7bhnCMLNkVKPk3gUa6A2zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMf/ABPdkjWkrNdP382Bk5ZmsUp5HK1jTM5u/wfClI+B/xqjW
	eZNd8n/XdNSG7caSMP47PLN2l0QP3HmAl/GOACEBmP7Hl/wr4FZPuGOKEiMgN39DZamWUioDpMK
	lfBJ00wW0zgN4Tyk4WPm4NJlrhajO8c2XH5Vf/Vy3oKQwiDgdlJrRgTX5nYS1yQ==
X-Gm-Gg: AZuq6aLGZ/tkZOS0+vu8yKLovkr1Ub8AshurpTm5gj7/RUcVvYzD5rbzipUG45zNItX
	Rgb0Yeq3Isg8ksKg/amKaXjyZOocCWUZJVJG/fbRnD288gdJDe9NmYqnjoTfcYmhHMdYQ3GY0Et
	2yHAFi5g1SzZgA90cjx6sKNAo5G21eoynOKlVAjfFq7vEpLclOwdLBGmQsFmQg6JswAoMY6ZxBI
	1/vJklmY1fW3wZ9sUHR1c2f3xNhapob/Xmz0f6Gk7J0+YGGpvdIKdxIHOUwKaPYHrSqz6LePKSd
	8SRqOkbB7gcy9Tm1NGQZdB/pUohWiebl65qTxN1BE3tCLIr9Q2q0XbRa0zChh7RAM0DY9TL1yLe
	gKNKw6ek4SumiaGYH9PGEUZd7VS5YKpxTtNKW8gixbiqfwa4Hnz+2Qqe28EvueLNAAIN7Vq+Tee
	O+VefWrkR0eNGp8FbqTQ8iZNAikZlwSEJY8bs=
X-Received: by 2002:a05:620a:4406:b0:8c5:30d3:d6d0 with SMTP id af79cd13be357-8cb424601d5mr320830885a.48.1771006679872;
        Fri, 13 Feb 2026 10:17:59 -0800 (PST)
X-Received: by 2002:a05:620a:4406:b0:8c5:30d3:d6d0 with SMTP id af79cd13be357-8cb424601d5mr320826885a.48.1771006679384;
        Fri, 13 Feb 2026 10:17:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f5fsm1710581e87.56.2026.02.13.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:17:57 -0800 (PST)
Date: Fri, 13 Feb 2026 20:17:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-GUID: Mf82Ac47MPBOqeL8Ulsx_0J2rmrWoDnX
X-Proofpoint-ORIG-GUID: Mf82Ac47MPBOqeL8Ulsx_0J2rmrWoDnX
X-Authority-Analysis: v=2.4 cv=LNZrgZW9 c=1 sm=1 tr=0 ts=698f6ad8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Z7Cru6KvyN3eZcMTe0gA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0MSBTYWx0ZWRfXxZBw6vRyiHYW
 3QvaH8FXvlpalgRhUnF1sN+pum98FqAgYFEgAddXxWoGW28rghXpgwRMXb+dmkK944yeSa1mlMI
 28pDLtyKy8Jy9tjq2fVkSwQGYY8FsKMwXS+b0YIYwR1ptKRX9v8TEDgYFATWnvd8RpxX3xK09Q3
 ts2D6R8g/wkNXno4yCujm38Xrpdx/a/+scHcwdq9RnSefh90EQmDCuyzk8xuikxVte/e0mQmWG/
 7U8Lg0h+DmFvKtoNoFYilauNbG+TiO8OK+99lVVVrj5M6fUL+289aJx+xgucES29zQ6IO+GmVBF
 3tvvxBEnY9CuWgDDTx8owML6qTOgAQd2RCGDFs5JIWFVf7EFne8MxIiStZw0JyoAzUA26OFG3sD
 Aqv12cvRr6cJly7TOgrI5Y+vJTefZ2+hxus3Kcvy31CTiBvkubUnxR+QcluMoeDj8jneMEtlELL
 UoGlyRI/mCgz1vdbHjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42620-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sonymobile.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:url,qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18ECD138E2A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> > On 09/02/2026 14:23, Rakesh Kota wrote:
> > > Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> > > The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> > > documented as a fallback to "qcom,pmk8350-pon".
> > 
> > Drop everything after ,. Do not explain WHAT you did. We see it.
> > 
> > > 
> > > While PMM8654AU supports additional registers compared to the baseline,

I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
an actual name for the chip?

> > 
> > full stop.
> > 
> > > there is currently no active use case for these features. This specific
> > > compatible string reserves the identifier for future hardware-specific
> > > handling if required.
> >
> > All the rest is irrelevant or even wrong. We do not reserve identifiers.
> > If you want to reserve something, then I need to reject the patch.
> >

-- 
With best wishes
Dmitry

