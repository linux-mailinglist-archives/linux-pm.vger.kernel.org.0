Return-Path: <linux-pm+bounces-27420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F230FABDF64
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098351BA40D8
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E655225F7A1;
	Tue, 20 May 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDUitAJD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44024C061
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755881; cv=none; b=SPmEGi+VY+sF95E20mrVFb7DLkU9UfeoBjS9839iy3Ha/2n2RYfVyAy4nLm5Q1aT4/2lBU5toCYYwQz2ZBlYHWyuqefA2o5D2oy6pjh8CTxkIhTZ8AuafrvykNhsmSM/49vmrq9e0OxG3Qagn0KQhh3lN/u6IQeObvMTbAoNYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755881; c=relaxed/simple;
	bh=vHPtQTp95qgHiVjk0rfgT4rumfQnjKWibWtqb4WPsqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/ICGF1b8x6pP8oF5qNb9qUCk/OvK9EyokpsKOblr71jwpbblrh6114SMf5OR/5lZ5NZdwlFen8IoM2O0iOeKCMCLtTZuo6trHQg+Wzr/T58IqkFfMqG/X+BpyJu40OUkzxTQloR52lHuS9G6fgnCqjcF3gvS7cjFhMbgOHNLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDUitAJD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDrWCZ032102
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 15:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lSAgwbIDWc01IeRoKRHNp/WQ
	jOOH+8S+Tdt/kRAF/+U=; b=dDUitAJDaU/aF0f3WyenDEDOHDcJoqmo3QtouF7W
	ITxRFH3aVq7oy1IEqbHkWEYQu3SvK7wKmgnY6sF/Fh3XwySUHp8pRjbPMMzLulB0
	kF5TPBQcFAniHLe7AId1JPitZWC36jqD6ZOoYBfwc0/HyhZqGOWR0V3+GCnzOM1Q
	ShuTLOA8aGwc54ypNWRcHBH58EGLzB8KkuOqTo8wJM05U7Zb4jAqwP7iV7kcwQVj
	Mkb1xCaD4TsDgDNWn68Z/cts62LZuS/AL11/X6oPaBdXfZxa9CsuvVeRQh+w2TEW
	ltgP58JVAb9eSMevVQaJ89J/PLkTumzNVUIt4X5FsOuwvw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r1atmh2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 15:44:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5c9abdbd3so587286985a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 08:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755877; x=1748360677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSAgwbIDWc01IeRoKRHNp/WQjOOH+8S+Tdt/kRAF/+U=;
        b=LldALzAT4nfY++/sYcWTzDqRl9/9kZzyLl7xJonDVK2ROSKbQRGllycXqeECJc1BlW
         vqtq6UrkzHo68NdhneSrQShYkX17MZ6MYlikd5Hu/Pu8hM6MBjDeurV1ObuIoQMno/b3
         IVDTpVxyJ4Ey3pIsX5JtwwUwRiRRQYUh5O7x/CcBE4p2UdGuxs04FxmRR0YlhBWdoYeQ
         9S+5jkOXmTPWYrAMaHgSt2shfEezwcgWI7GFj0g5knTGEsN13+iMEJ9JhIBJwi+QEg+c
         CbtvJLQKxVUBI2FpO4x41trvcv52fKy/dsPwf/eFBRt6a2Fk79rexePUsYoAq62SPq7V
         57ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkekiVOlGvGIcf1jysup19ENoZesQXbtjCUONeCmFplZqOzQJcXxzkHH9BiyIlZysG69bID/HZTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5n05XrQQ9lJ/QwHFHI0qFxXB6H2PtGudR0xE1f+6s/OnYaAQ
	f6SrQw7lERlhmzHnJlGOjZjaMqb1itoE4vp7WjcD+frWSCms9h4/IIoPl0g7rnrUZ95tva8HunN
	ccqQDKRS5TGAyo7wl9Avk7TV0g72CtP1nPZavZSYoIIU5Kv1tSAJOQHtWaF/rgQ==
X-Gm-Gg: ASbGncvsLPjPi9TZKrB31einz8krjsKgwld99J0vPj8SDaz8ga1axh/niYgTX5n4UT0
	3R/tI77m+FyNb6V4/BYkPcn8yHwlFZGg2ZVhm6eb5vP8Hc7f2Is6owWEJHEw4+QarhQMlcFj2oG
	VJyA8AA1cVQ9XLCx0xAotvLYJsitAU3gIEpqcbfl77IlqHqkuocRQvgQ3XkZKAMccjN0kOpT9Or
	h2rWSfukqX2RbxG8p0uq7x4FpibxOlwd9L+p0d9Tqngw2/SyilSi4pj2YIYVoTk8hd2fn63yqKC
	b0qabyaXk4M6kdXJJPZbxLqk/egWwO1iafwEQ9HJ1dJ3wc4CF8c2EKo/MDacdxzeH4hc0awL9KQ
	=
X-Received: by 2002:a05:6214:528b:b0:6f8:c23c:5278 with SMTP id 6a1803df08f44-6f8c23c8524mr209650706d6.12.1747755877436;
        Tue, 20 May 2025 08:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm9hVZxx6jSsGoAw0nQEashx/KJKae4VdE14/j2OPoOQ0PtJya6PHIlpK4xtUsXtkz6QIb3g==
X-Received: by 2002:a05:6214:528b:b0:6f8:c23c:5278 with SMTP id 6a1803df08f44-6f8c23c8524mr209650276d6.12.1747755876852;
        Tue, 20 May 2025 08:44:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e7017f39sm2401148e87.151.2025.05.20.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:44:34 -0700 (PDT)
Date: Tue, 20 May 2025 18:44:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taeyoung Kwon <xoduddk12345@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeyoung Kwon <Taeyoung.Kwon@telit.com>
Subject: Re: [PATCH] power: reset: qcom-pon: Rename variables to use generic
 naming
Message-ID: <xyhqu7bw3kqlkl5q3q3hexceq2irm4vru6lfspsnpmxkhp6vuc@jpqtvyke5aec>
References: <20250520143612.109567-1-Taeyoung.Kwon@telit.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520143612.109567-1-Taeyoung.Kwon@telit.com>
X-Authority-Analysis: v=2.4 cv=OfqYDgTY c=1 sm=1 tr=0 ts=682ca366 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8xVn4GeRAAAA:8 a=38eAcjmzj4vKwzUmQakA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=IoWCM6iH3mJn3m4BftBB:22 a=By6hKCY_mHIbKsINY6vW:22
X-Proofpoint-ORIG-GUID: _l37KtReRUw9732AkLy991uhfmH81Rus
X-Proofpoint-GUID: _l37KtReRUw9732AkLy991uhfmH81Rus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyOCBTYWx0ZWRfX2VDLv9AqzCx1
 UXY5qPXNdwDoJ4fdHM1MKqtWAQT1dnyw/q6Z8WWrBF1tB576KDuEREDbgix51L9t0duwfHd9DdL
 UVoRjcnuWmvDI8qzw9Fmp19D+spgaO9+LHicOVTThJg2yVBFuQvRDuP5w/7/Z6p7UYO8005dnvd
 nQMkiVlA6sNSSq3j2bImg3eeX92Pbcq7ELXPeGRftLwnuwiRXgF9ylyG/1IM3iK8Eib4HNlmjyc
 GPQylnda4bBx+XzVHtMLu+HSExtOVm45kDooTl6U1GAvgpknHHfPDvwJ3cO+02Cgz6xwHV3mMVj
 md0OIv8z7DbWo+KwTyau4NM38eSY3wEVUnLMnyDMfSQ2JwWOl3fK8advlMygP1Ue4GMy/MpwuTs
 MMuPx2LmMYjedkTJYYo7jsIuzllDLtcD7QLeKPGZzr4sli8Usq7MlEbqNIQ5LAURPtLYEtt/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=942
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200128

On Tue, May 20, 2025 at 02:35:50PM +0000, Taeyoung Kwon wrote:
> As my company email adds a signature automatically,
> I am sending this from my personal Gmail account
> 
> ---
> The qcom-pon driver was originally implemented for the PM8916 PMIC, and
> as a result, several internal variable names still refer to 'pm8916'.
> However, the driver has since been extended to support other PMICs as
> well.
> 
> This patch renames those variables to use more generic and consistent
> names, improving clarity and reducing confusion for non-PM8916 devices.
> 
> Signed-off-by: Taeyoung Kwon <Taeyoung.Kwon@telit.com>

Now your SoB doesn't match your From address. Please move your
explanation under the '---' line and instead add the 'From: Your Name
<company@address>' as the first line.

The patch LGTM.

> ---
>  drivers/power/reset/qcom-pon.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 

-- 
With best wishes
Dmitry

