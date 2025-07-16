Return-Path: <linux-pm+bounces-30939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F44B07CDA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA1D1893BD9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715632BE7A3;
	Wed, 16 Jul 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdgzDPo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291229ACFC
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690194; cv=none; b=r+/Kt79TMR4kRBZGGIq52R9mdX8ptuJqdREweIE5Gxl+azRqp5Eqk3Oixk1aVv9skX7bWu4o7bhp7C+TRcOBa7Dpv13XvOWo/wJhHEEcmeerw7l8fcX5rHTbM9MCyEL+VGtb0Dd2b+TdG0GDWypPZYE5TsVuS9UoO4vYK/qjQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690194; c=relaxed/simple;
	bh=DoCggDPXxoCH10+4U1zekwBy6EFTZXslLJab/HUMrvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffcDljx/YGp1sJGFVnCL6PK+EosyIGml9A8rE1lOQJMqULwJ5JLTCczvBehUZ04qSgxRKP2fgX5PfRJt1aVcm9ZddQVtb4buF3pITenPvZD/6JQ3VKn4OZ20pv8iFHxlPXelEqjKuZRjeFbCr695EhOPct0z+mOFgScIGfZo7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdgzDPo+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDXJp021705
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 18:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JK4iMoMMVXxdCtDOd3oRY/UP
	XotWkPq616eJEmzqYJI=; b=jdgzDPo+S5AeuFxHitcGVjiSb91nBxdmv+ZwTS9B
	KJ9Fn97AOnoeL4wtT8aau1LwC9v/yn0gk1cPJk+XNNummwnlWWohJ1QulxHoi3kd
	XPUhZ3oGK4+aDEa5EIqfvtDL8gXlxefqhNPzjud7Z/c3X25P8/MGp/TUYTRYLUJ/
	mgGAZSvsXTk3jK+AEqFUVn/5Mtk4WAf/t8Gggwg7QxDfWevcYPb532lLoWvGaUlR
	q4451Ygz0AdXirlQNhfDABBNAeK8qlLjP6GbiFXGhSdzitFCw/9vE1imZXry5sQb
	AQCBuiyzzapPs7KXTdmlpOft9TkSwzB64gi+1i+Rg/ewSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8cuup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 18:23:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7da0850c9e5so22426585a.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 11:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752690190; x=1753294990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK4iMoMMVXxdCtDOd3oRY/UPXotWkPq616eJEmzqYJI=;
        b=G4Ocf5XpTAzP17vfJiSSs8cc2OLwka5NYW2k9GtzUWnHoge69faabusU9W3Firgyt+
         jH6LkD5D5GebeRc5FscLNDDbxJODhZAJIEahx0hb7IgGFO2L1wDRrjDJZE5sHdXr9+mQ
         q3I3LD3jBv88lgXYqWtKJh24WbmVzrPfggSYbo5OaHkuARW+No5pVfDyb3e/nHI2Z1qZ
         IkKC8NiO4pW5i7+PTFBXSYjH2Q8M7rS3YgTgzkkJd6pWnTjRiI300y8EZCwX3sqnb23/
         M8gJi75BdHR60jkf/Jfif8SAzRLdzXkoWqxvTqSz1koroz+HJ+QX1jO4QrqnsTeV8e73
         dFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdnxsJCddFVIlqhyoDFXpf5REdTrhcHi3UmTRTKV6GMya1lvwEwvh6z9xu0594zgivXAp48uvVuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGnrQZ28qHNDRS3KVAzGi/Uwytj756sYyAMelxufg5ZhMnzdK
	0aYtqWHL2uek+p9DJA/0tO3C9xKQxaBL96VVCvz3U7PRcyak3H9tkHF/Dc81PfCPBecivZUTmiM
	48n2MG+Ai/Zk9MUpfUCgM/opH1nH9eQinW2tDZURUQLFFlZQJNgxQnt4uHDQlFQ==
X-Gm-Gg: ASbGncsUSN/qUrIUiowxcVHReDtBvAAeoitI5dDpiAMIyUSs9m4ozeuretyEUL/01Sc
	fh5cDUE9mVNMuAy/X9db4DZdAdaF2by/V94c7pyO4lk0swLnk49k5vkfMro92reQv+CPHpLmQWW
	1KelMCYPTLIqALz0/xB+bYizuddZGdiDJbhBgbd+1tQznL0to2rwkmrT/YwCjFoEywRBfCZbrFP
	TSDxP2d0XUy13USlZOG9oNwShvu7oGEzX0ABW0kdShnwREn4wXCWK709Y82JbCOvgOPTcR1M2A3
	M4NVrqnW1ih69+syGMthAImPtEM12Hic3lrNS+e2bXo2fHB6tHs3avca6NrUAGXRc+6jzlR7lDc
	HR+8yyNRZYDD3AUmslmAwM2BBCRTrRueU0wpIH/5SFUYM6o/JOmvq
X-Received: by 2002:a05:620a:6282:b0:7d3:a7a7:27ad with SMTP id af79cd13be357-7e342b368f8mr700586385a.37.1752690190343;
        Wed, 16 Jul 2025 11:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4dGOAQzmmOnjOY9QLp8IFiHzk+jathDu/1gUNdhAauGYoBTABP8XBoC53a1ib974mH2810w==
X-Received: by 2002:a05:620a:6282:b0:7d3:a7a7:27ad with SMTP id af79cd13be357-7e342b368f8mr700577385a.37.1752690189707;
        Wed, 16 Jul 2025 11:23:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bd725sm2745529e87.14.2025.07.16.11.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:23:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:23:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
Message-ID: <brk26rybf37png4lqea2ekmtdpvdubhih4rq4gazek5aqjzfs5@nbthyvvnxtna>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
 <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2NSBTYWx0ZWRfXzb44ae+0VAmk
 hJFrKEp9mkzC2PAjwT0ytIuoLF97LsOE+5f0m67bg/RvwB27izOtlPCQrhJgIEHJa77uEt3M6Aq
 5SAuYQkLoH5Pu3cYHBRQoM7cQ2OYhu46/vWfa4FM6ah7qiLa1O1xhdpOx7O17+Jx93byK6NpZWi
 eXp6MkVbVmd4X1O0/1n8IyAmcw3hQbN6kVfx+VeSr2cHzYx+ZRdX1WQza0hoDyVXLnvpcZKB5w/
 kF3y7b5gYk12g4TtHVC6+anKphMp1M6KKWnFA6+k4bHVptWKISF6UyKP5HOZ1cHAQ0U5EL8rcnn
 g63nTbBj/B3iUlhEfr2QWIZkEkwOWnbFLhIXJqioLEq/WrWfzrigs5YjQXbrvfuHT3bs86RvOAO
 QQMCcKTUxj5M3qgc7+BE3WPkmrRJJbLLQ7C72/gpre1UcQX+HDcRwyvz+7ANBbf0s6OZprUV
X-Proofpoint-ORIG-GUID: dIgvZ7aSXpEAV_ceoxZWXAzoOGxVIEfb
X-Proofpoint-GUID: dIgvZ7aSXpEAV_ceoxZWXAzoOGxVIEfb
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6877ee0f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=DTRyGS_NSo7weVScNrYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=906 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160165

On Wed, Jul 16, 2025 at 08:57:58PM +0530, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMh Power Domains support for the Glymur platform.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

