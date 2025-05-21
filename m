Return-Path: <linux-pm+bounces-27458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2094ABF616
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50344A601A
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F52798ED;
	Wed, 21 May 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFeEbAn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79D26FA5B
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834185; cv=none; b=nsORFosVPDUBAV80WISptKI2MGY585D5OOdqb6xHJfBerKXaSF+jpgKKBI3+z7R26WGZw9c9PIJbe8Z7cqHxbdtOIuGMFGX4gBsbSsrOVlMWW4IQdYshvqRM9ltUDAylSbL0fH0OTFrGk73/cT0J/WIcCEddbPO0ESNbKm13vdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834185; c=relaxed/simple;
	bh=tlg1lzkYJfIIie1O0gwsHYFTGSnrPtTa21pJSRBZrYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhaS0QJmsPbkaWeyrMKGtx5PUCR1L5QVrymLfyGx9zLKo6ozrvR5dyDQ1yCQ28xOu02cSzrpfhghn1XZS+dzv84mbi1bb+CvBTsZeMo06uBG0KfUBuZTCYMugksXDkUT+fEW7piP/bq6CYzyZm4P7Mw3rCEqUglUtE0jUnOg14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFeEbAn8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XI7c031677
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yB5N65tJppWHuCi8FRw9iMEM
	njhFwmKIAmj2+p8j+Zo=; b=nFeEbAn8AOTdA9soMZv7HzFxDrFHjlARlZbffBOj
	uZ2m0dGbTnMvqD+QonYto89cxPFemG6cRnqPy9GhEMfFbDGTATO+JpJLzJOWk+0d
	NyUb13ItY9BUnIqGBk3JEnnNdFy/SKHNMm852TnthTnKm3PIs9zvl0BkHUi9pLhn
	4+4w7GbYECy2VC1v8ajOymBtmEwJodX2YxYnK60V948naiVBq24SZaPyC9ku4Ahp
	YfoR/5lvFNox68bObaKOk23f5p2ZmGDSYtnZjvGymQZgyRNwN2lvEX4UTzbUjO1E
	bS4nLSyd1kKXFh3iIW+jGtKVCR8MebZwnUalB1tyA2UA4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c21k3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 13:29:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4768f9fea35so165374181cf.2
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 06:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747834181; x=1748438981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB5N65tJppWHuCi8FRw9iMEMnjhFwmKIAmj2+p8j+Zo=;
        b=CrmbwYtGJlL05VsRwOIem2xNVohZi3hrG9nFo2aQ2xg3vAf8S0bCZXQdpHIjxtHhkA
         pvw/ikXuMLR1ZBDfCZSrpKmDhzHitTxQ7n/hxQrD9bMYmA0Gchs6KvOpj8CyNjI54wy4
         Z1pVIWcRlFm2CUnEv/ZWUWi9i7wfsWTs0Z4gxEm2UCr2NSA/U/IlMaP1wvf+2IRmahP+
         jloUqlzMqlqVifgT16ci5sqvQEPbbnY4bmk48uZiC2nRahiOP7o8dmvNm/qjnKNXj1BA
         ZSgHlEmuHObG9VFiKK4CfHVkeKpmjqBsBdMcAhJ1Jk4yR+awAbHpmRtbUXUYeGNP9T0/
         N0eg==
X-Forwarded-Encrypted: i=1; AJvYcCUGv39iU465v16XhLcJavTaO1d1T5PuNDPyp760cHHJBOiomrzaGR+bKR7Lnwx2+NDxEC6iLK6J3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IZSW5jW49dpbe+6OpK3W+3RmwW9qY5LFsLtA39l/EqRKKlc7
	KwXbaYgMiNo5SVNtNTxbji2jdL/JdHCLA0uvupqLMkdcRwWg/gWDXlhu2vMoTkHHa2I8kuxPP0N
	YwuoJfOhcZGEaWqZ5CrglB8nE9AAXXXbAGx18zqdcyXH3SX3VEjb97tv47BWTP1IPpv6BUA==
X-Gm-Gg: ASbGnctlDKPiG2nw/YtihFZ1r0rmext14KBk/cKsXQ+6kMQqkR3JjS3vpu9krb4vM/s
	9WDqM2kA43fVls9OLZTM/r6epnnPmQY6uAV51PqiJW/bug+MsEvbASMTK7U8lEL4z2CQILuucVl
	rOg2FY+Qf0l/gMNqdVr8/DxGAdnzt6+xhgaTRW+o79CpB0FYn6BVqfKbTsiQTvRofCRRepJCn0Y
	TKAKbVI8cK6zWEEHA1zBNQ8JWz4OwLjZIGbr3Rh15UnZLmjKiAzgV4u6OJzcHca1dmBIMUyGcud
	Jb+SBuq6P19S/JiS8qTqjsxJ8IkSs8DfvWR7tElwLa1U5az+EB9xOfQrUc0EA21S9NTM+AqVAdY
	=
X-Received: by 2002:ac8:5ccd:0:b0:476:739a:5cf3 with SMTP id d75a77b69052e-494b074d0c6mr367953041cf.1.1747834181410;
        Wed, 21 May 2025 06:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLno4oDfMSD+g+A5XtQec5aytsPNBkXfe9N89uXd43okFNSnebocYqbtoiXPeNdVJfVlhxww==
X-Received: by 2002:a05:6214:21a5:b0:6e4:3eb1:2bdb with SMTP id 6a1803df08f44-6f8b2d3a73emr302130866d6.43.1747834170228;
        Wed, 21 May 2025 06:29:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703ca85sm2874298e87.217.2025.05.21.06.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:29:29 -0700 (PDT)
Date: Wed, 21 May 2025 16:29:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taeyoung Kwon <xoduddk12345@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeyoung Kwon <Taeyoung.Kwon@telit.com>
Subject: Re: [PATCH v2] power: reset: qcom-pon: Rename variables to use
 generic naming
Message-ID: <uvqqq2f2mhpuqvtq2yrxw7nkw6e34yf2bv6ulkglutgq5wa4dd@fi5h3m7yibz7>
References: <20250521131116.2664-1-Taeyoung.Kwon@telit.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521131116.2664-1-Taeyoung.Kwon@telit.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzMSBTYWx0ZWRfX7KHFQdAJo7LH
 6TmWVrdfPmc6MNAvL3byxO78VzQ158gJ1a+esQZ64v5yjDkXjD5v8QjCo+xUMtgIAUwlykNTroX
 Y37rFdnF7Je+fuOnlfqYigrf3f1yGSLo8OYyuNBR1tKACWdusuhZasdro+VjL8zzeHyHkIVMHsJ
 Y5so30A18Pg5ZyucgxgNXscd8U+zG2SNdroeLgycNOb+abc1Kg5/RqECh6dbNnosrVylHb9bZWx
 Nl7Dqphd7rb35bkyLrrdfkC/OXF4f8UyxdOi1oLJPFS2HiP1NYuPd2QJz2l4DD1IO+sh7KN4+AL
 XtFYuGWVcxt4ypzoGHhK7YQUXVgz6xCED+d0g2E0940v6vXfrutY7ULPyI1KfSom4639fyCHur1
 W1o+mpCDEcofrjsATB4Yw6+YxQUQX4gYvYUjQdlVdC81EYF/Mcy80QCY3pnhAlBfE+t8mH3m
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682dd547 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8xVn4GeRAAAA:8 a=EUspDBNiAAAA:8 a=38eAcjmzj4vKwzUmQakA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=By6hKCY_mHIbKsINY6vW:22
X-Proofpoint-ORIG-GUID: nu_tHfJ94w6mQ0e-eaVuXji5C70M2vZl
X-Proofpoint-GUID: nu_tHfJ94w6mQ0e-eaVuXji5C70M2vZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=698 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210131

On Wed, May 21, 2025 at 01:09:52PM +0000, Taeyoung Kwon wrote:
> From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
> 
> The qcom-pon driver was originally implemented for the PM8916 PMIC, and
> as a result, several internal variable names still refer to 'pm8916'.
> However, the driver has since been extended to support other PMICs as
> well.
> 
> This patch renames those variables to use more generic and consistent
> names, improving clarity and reducing confusion for non-PM8916 devices.
> 
> Signed-off-by: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

