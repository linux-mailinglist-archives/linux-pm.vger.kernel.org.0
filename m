Return-Path: <linux-pm+bounces-25186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22396A84EEB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079734C0141
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947751EBFFD;
	Thu, 10 Apr 2025 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDTaYRtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB651C5D63
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318919; cv=none; b=MZw9ndYV/V9a8mZHC1Y5hajlrJAQ0N2NDurBu86rgbRtCVc6pg8T+y9XlgLTgf2Ecm8bIA3dPvZR/4vUEpG5NyxHzPcuwc3+Ya8lOXjhLbXyMjMmNxogWDNNE4uJVg9XBff5hj/etHX5s5kkrjh66vOJBmUs4F+twItHlQ6JfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318919; c=relaxed/simple;
	bh=Bp6+mDq5oMmXkzUXL1kUpCmqYnpORysSLja5cHQfqko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvgczuk9CwJIW4ybzOXbYiJ0Ja5Agwa3zFBhAnJfFPZA26VHLIGsxHi+Qceur7aMWH9MwMDENSuwY6tdKRVSP+FBCAhbczcnVuI/7t/KsTbYq3vIaURssEfWMMezLqunU8H7/f8Sg4PD2VRsvFRjfDhCylMsbODH4Hbw/qBillM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDTaYRtN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFjntC028856
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EAczs4DgsEXDn10TzeEXpsxj
	GDsTEgsnPDFYAZGDppQ=; b=XDTaYRtNGakvPh5wIcPKRrqc//FrVnluzievkDqr
	4YXunzjTjFI0Uz5TEDtY84vc6dDoJf3KPW7FWsqPIDIUyPCtprp47tH6s7UNpFe+
	jptYSFcsbynAJFc0Nn1hV0A053T/pkNjYrz3pjyWB71w/Ns1SH5VoijBBb/E8rPl
	5MUga9ChweZxPO8z6vUYwZooOyELMZevWOeVgr6BmsYjyOOlNF1VB8UKpu2xfs5V
	y8kpN7c/g9LxcF/nkiPaifFhOPVJnUnw7s+ByvLfWW82414u8bQY83SFy+ijoAvr
	25RxV2V54aS1hPtF2NH+SSylkA+70s2AXvxHfF5crpQr3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twburb9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2265a09dbfcso19444175ad.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 14:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318916; x=1744923716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAczs4DgsEXDn10TzeEXpsxjGDsTEgsnPDFYAZGDppQ=;
        b=l6vSVX4BQHcn1y1AjU3+mP+P27Ep0Y0qnw1VWY3n9uSqYTz9aWqtwJYAKuQQEOWK42
         D+tqh/65LrO24z6k2wICkIItcEnb2a9n0aXjdLPrV37skYtN45z8yTcMCV6YTWyvnGXk
         cs+fQGAImnDJ7lib0eDw5bNQmvqYGQES2oeGUXAIxsV8bpQuzkyxWs0g6D6NOOtiwNes
         dBxRqLbV5kQdjLFXpxycgEyXIjGVXS9mVXz/sbYMRSqsq4BC+cyIjU8ZaM+qn9kmBaw9
         axNmoUrYgGLg6uz0hwQHzb5E8mzlP+rucCy1aQZCL1pZlfg0iDOqg35GeKiJUo7L1Ifd
         ZrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUcaqnrDxaGhe0M9zP+ylFEK4xAhKk9SCLVrHm1hM/qi2JW8pW0alqTWnX1qKoXUfjbDuK1D/XUuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycdegatuBWDF6hJBJ52nQ82bEOGsRFB3GO916QaXNnxTT9TOUK
	FBt/ee7CBagGT6IYbygd3Rr4FzG0cK9UpLnm/x+XuhMaMbJ/eV2Id5mgMsTWPkwMMXgqRwCLyan
	xoXQRdPSRcrS6S8FPl5F4dzwXMiCpw2Obz+EDQPYyMHSvqi7dx9T/l5Qjkg==
X-Gm-Gg: ASbGncs2+PkKRgAY5K93hgpuISQ53AsHmCB+n4EcBKmURTv3i9al5e/w0r25G3Pl00I
	eFLoR9m+GmGWBYrIhKHtTzs7ahIk5Iq+FAosXeZbGmZgWY9Uk3XyvF+8oRxR9wy6+xTUKgApnbs
	CYqH6AnpECBHz+g9h+0ejrGYbG7W6lDj4xDb2aTd0ra9489tnKEqLpSYi2/EzbsN7htK4EgQzTG
	eBX2AzlCUUU9T3VRsKrLt24NPeJibmPLE5jtl17yjNtw9XUDokF7JpUu5je17Em0k8IZYyqIC4N
	6Zc3mPROH2XQpihKk8c6zSLoTHjPvqFTastWwSrRBu/3txAMnSnFM/r/VxMcI7q5g+U+xQK0s1k
	=
X-Received: by 2002:a17:903:228e:b0:229:1cef:4c83 with SMTP id d9443c01a7336-22bea4956e4mr4389725ad.4.1744318916215;
        Thu, 10 Apr 2025 14:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2LTJB2/RY/DdqKTkh2gKJbx/x6EreWNzJjdMoIjeJhs6Ywk/JJ+CEjjTpDEwY4jA5Y4atkQ==
X-Received: by 2002:a17:903:228e:b0:229:1cef:4c83 with SMTP id d9443c01a7336-22bea4956e4mr4389375ad.4.1744318915867;
        Thu, 10 Apr 2025 14:01:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d70dsm5790861fa.22.2025.04.10.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:01:53 -0700 (PDT)
Date: Fri, 11 Apr 2025 00:01:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 3/5 RESEND] thermal: qcom-spmi-temp-alarm: Prepare to
 support additional Temp Alarm subtypes
Message-ID: <vsxqfagv557jiqmpu7dkt5ojiltsc6bqhgaiiccsnamcsn7eec@myowjpia5war>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-GUID: tN3-eI4DMICIDUM1uXF-8yWrxr9TD9Y2
X-Proofpoint-ORIG-GUID: tN3-eI4DMICIDUM1uXF-8yWrxr9TD9Y2
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f831c5 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=igDgIpU7c0FD-4j4V8UA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100153

On Thu, Mar 20, 2025 at 01:24:06PM -0700, Anjelique Melendez wrote:
> In preparation to support newer temp alarm subtypes, add the "ops" and
> "configure_trip_temps" references to spmi_temp_alarm_data. This will
> allow for each Temp Alarm subtype to define its own
> thermal_zone_device_ops and properly configure thermal trip temperature.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 38 ++++++++++++++-------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

