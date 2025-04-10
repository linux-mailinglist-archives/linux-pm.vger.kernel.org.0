Return-Path: <linux-pm+bounces-25185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F6BA84EE9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B316C8A23C9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084E290BC0;
	Thu, 10 Apr 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NGXi4zcq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D08200BB2
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318875; cv=none; b=rx7JBmBQOHEnm/MDNicS2cbRP62aJPz72bGrSbLCL5pfSVm4hzsa5G5mO7d7Jcd4NYA060zl6wzlN1WPIUzRmL92F8YBnsQNFJc3VazlsI6UddQkGfPOL6mSI+JU7eREdlrhF9xu8gwZCOKMoWYORcdqLUU/c2CLS8+CuF1ZgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318875; c=relaxed/simple;
	bh=vT8A4fU1UmOiZ9+DWtANvxU8GSZaCb9rftBdA7ojakM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUUR83agTg2cfFN38iJJOBzpPfttYcZLGtABA+OTfEzGIJkJzEczs8+Vr9f8cCqX44bvrjtyhkMGcDytGTHXQccrifxzOumwuNijYw7SDtG0fImepR4rTEul5ROwhEv3pv8OvzROGMUqe3WFMpDivdxfqN3qxZOX3//wkXKEQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NGXi4zcq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGXexl032136
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hTXBltzFE67Ruh1hsFseJc4C
	3laLglIPKoe35RaWrWQ=; b=NGXi4zcqQGWuVOFse1/QIZsmH6gZGc63XtWuDw3H
	XyDZ2X5RWZM1r5EbosyqWvq+bhMNmcACErkJLkXyJgDVtyvPxtLs11qzdG6BeryO
	zq/dkOHEQj51EN8wu5Ku8bK7tsOVJz2MH/PeY+ZkQNl4wTQWQ4D1OZZKS7f6hmhE
	DieyuUWB8Q8g9BIR+/hshQcYL3fLTl0Ay4IeWPz8C0tbLcJNhArjLVdQFgJLb67R
	u8NxIX/p6qw4sfVTLd3xPS3g0HJhm3A99JseUcqlsE4wSoK7D0boitoxmAuYnl/w
	BeQgC/OyVlGZK4ZuxD6/1S5ts8DaENv6tHC7qQoF+yCdkA==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmg7yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:01:11 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d443811ed2so23957245ab.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 14:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318871; x=1744923671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTXBltzFE67Ruh1hsFseJc4C3laLglIPKoe35RaWrWQ=;
        b=lcPLjV/EkJVhdLOJNpvXyPAmVL/w1VhThcj4qdsku35dtZheLOaufhmpf59+fXIzBf
         HNGog6t95JtAv0I3Gb5oxkPgax92YUX576cwI7wDbNOih550jzkXtz70TNFuRM7jJNcu
         qdOyYfubqTM5mS+CMFd/cvWM2F2yTNvlXTZ+Bo6YRwyQauDiDClgMBM0C1G89MRKzqOp
         87Bgm06MON/R4qrRw7ywVq+ctWXDCOaz0tcb+8QxAUcCQdhwb+gKxs9gDx3SR+JeaFrr
         tTagtu8IS9Llu8Jm/P+QLeMIlFoYnEM904FS0lCNIpNepjrXjiwgH485lyEY7Rlax6Hm
         KjPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPFXJ+qnjXFv2FYR/4LJ2WCWmaa/oVdShXwuqJUImF2Ml/yK1J3jnV7a56D6u2ZC1XtQf8CE6Q9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcbSU0eZZztYSHBI64gpkw18XPwiMLVO6wr7fwJ2cHQkUSd0Dt
	DSQJsJooUd0yZIbP8SOK/FXMQFKBARkKUST2up4Sc5cVcs9hgPK3UAWDk07g0egw/4rMLXT8TZp
	w+8hUpNVM3ciQbZ1F0VVcWGOlnNmqH9oTbGPADZu0rVZ09lFTCHd+1PRTQw==
X-Gm-Gg: ASbGncsrDUU0gkAQZ1rQw2g4eb5qTx2ihVaO4yLoOO7roJiKJ1nrgOg4F7wX90eMXl6
	z1gLYLhF34xdmovst9WSs4A79OyOmXxczhwKy0bpBNID4ACV+yc7lKOIhIJ1D3SCAsm8oMmAwuZ
	VPW2D5Yrtj1fDqK4QaQbOaCHkMFyVYJKROfVILV/vv7vo5gXvxxx6m2z+GkFJSdEIzHqzKhVL9z
	XdrwY+p0j/AIz/hSyj0MdMFjLPiy5TeSFr3Rhf8ZVPhiKAF35+SMriQhnqMIMsc4uGTsk2D7c7y
	mg9NYaU0282KjN3zHMUWdzqZ3sUi1AjDbPIW7rT0wLSkvBAd+beS0Utnj21/phzjztQlA7qNUvE
	=
X-Received: by 2002:a05:6e02:1449:b0:3d3:d4f0:271d with SMTP id e9e14a558f8ab-3d7ec21bb5fmr4965275ab.12.1744318870733;
        Thu, 10 Apr 2025 14:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tnBM663rv7qwbG2Lp2yaNzmsf6T/Qev5qfbwF4jphfaqDwalzWmtac96frqAt/9iKu4ewQ==
X-Received: by 2002:a05:6e02:1449:b0:3d3:d4f0:271d with SMTP id e9e14a558f8ab-3d7ec21bb5fmr4964675ab.12.1744318870275;
        Thu, 10 Apr 2025 14:01:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d69fsm5843981fa.17.2025.04.10.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:01:09 -0700 (PDT)
Date: Fri, 11 Apr 2025 00:01:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 1/5 RESEND] thermal: qcom-spmi-temp-alarm: enable
 stage 2 shutdown when required
Message-ID: <m5vw3et7qquuuwkrscs3e7yvjyx7obuc2legrzbsnd7ahz6vdk@elvuty2lrudc>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-2-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320202408.3940777-2-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-GUID: t2Os1LYTs2JhLSbV4V8WgDS3302fU4wj
X-Proofpoint-ORIG-GUID: t2Os1LYTs2JhLSbV4V8WgDS3302fU4wj
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f83197 cx=c_pps a=5fI0PjkolUL5rJELGcJ+0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=meonRkofVk6r_IjrMSUA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=HaQ4K6lYObfyUnnIi04v:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100153

On Thu, Mar 20, 2025 at 01:24:04PM -0700, Anjelique Melendez wrote:
> From: David Collins <david.collins@oss.qualcomm.com>
> 
> Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> stage 2 automatic PMIC partial shutdown to be enabled in order to
> avoid repeated faults in the event of reaching over-temperature
> stage 3.  Modify the stage 2 shutdown control logic to ensure that
> stage 2 shutdown is enabled on all affected PMICs.  Read the
> digital major and minor revision registers to identify these
> PMICs.

It would be nice to mention affected PMICs (at least thsoe supported
upstream).

> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

