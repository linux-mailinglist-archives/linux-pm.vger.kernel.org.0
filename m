Return-Path: <linux-pm+bounces-37332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F50C2EF1A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7151881E26
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205D23E229;
	Tue,  4 Nov 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPZEagKp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKUO0lc5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95955469D
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222761; cv=none; b=ouNjAV6dA+KWk2c2OeTeQIh9E5/FrZIst0CPuYmgvNJMjdybndnkv8khQgUfv9mOh9sHMpoeSFbBG2vpkXRawTA9ewSppHrLAQFupEhtWRmzKpuQfpHBmWVFSkSy5JlgNZh6bNiDUyUAGhV3PDgpvEAjJr6DUgtrowVcWpXaBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222761; c=relaxed/simple;
	bh=KyvDk7KBdsvEJPh/jWWyguSsjyrw/3gCRgDyquZ54I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOyh2qz9mJZl6Go3tLHWP3ckSf4bwGN2NF0PqwlAXDxh0HNl4bgJEKRJ+fmC2pqCNwtIdO1QbihD5Y9n9PGxCNI1oKfp9iAMHqIcApT4n6OrNgQqXf8ooJTF7rXbcUkcGp+uLsc7etiEMnfzt99YtvJqn5Ain6qb/rakcIhNv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPZEagKp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DKUO0lc5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H6iak3693686
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 02:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VT+uJMyweB9zpA2zQcP02IUX
	/l5CbJ76U06mX6DtMmA=; b=MPZEagKpUp/d7rDAt57KB2eVri5hhzX1kdUmxCvk
	wkH1918n6wX6IJ8QrnEPNG+wja+jwrSStenYy0/y83jK/L3eR8R9UUwGkKdDbn6Z
	2pmM73eFS4Gcn8EH+4BtZXKmmqIloaFfJ5riOEoGbBHoDmu5wbRuQZc8AI3DdChA
	26U0kR6Rv9Tg5dyjsx1h3ovdNyfzbJYs5DpZ2etzMoJRdpRLhp6PTWD5WREK9wKP
	qhowIOsXr/ndNZfmsxHpzFEGWy1Hdnk92CsTA4FG3U3hXTIdnPYgvnU60DcVCT+T
	VxWOn0uRZ2nmwN64qBZgVWW5flnBqmjMrDXHSn3uOGrmBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70gm9a3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 02:19:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8916e8d4aso160835371cf.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762222758; x=1762827558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT+uJMyweB9zpA2zQcP02IUX/l5CbJ76U06mX6DtMmA=;
        b=DKUO0lc5lENhS/A1908BCv44rl0qgd2/L83+AWIuSkN4PRM9APmpzBk5w76LiYJCOt
         K8WGFJ+ORoBB1Kp5CWcoyyuWBIoke8313/yS2gGr49nmh9Z9ny4zx/e6RU5p0T7aGnha
         cTZQnCxxdEolZTyFpDJ7WFXHgnkWtTeUcqBmNrvagFmIRysO4VcF8Nv0sBlxoZEut8XY
         eJCV98zysMn5ZahcUTbmYeu3Eo6RMQEOI+YyxQhf9wUh3EXXhpnHMH1G24zmrhXbe8Eu
         JcGm4601P9Mg3mIYlt23oAVMBEBrtOA9xBccVL/ap5svj5fXqiyuC7oygi2PCBNDqCnN
         KAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762222758; x=1762827558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT+uJMyweB9zpA2zQcP02IUX/l5CbJ76U06mX6DtMmA=;
        b=lFKkuAFAquNhNzRTK0wSmqx0e6WGm/EgE9S203rxkAuK11eT7YoT8RmEzhqqLhOcxz
         ZUHTp5k/YP/BluO4V7i5bMAQeH+JIxM3XFYlE87wcVdFOFN0xOyz/9mDWaiy9/cJkxI5
         PFHhqLw26TQ4oKe4ytJmoxG79WB/3JzB8og/ZX5KtZsCnlpAQXfwNclka0TDtExOn8Vn
         Pyjl/q+TyrneYjiCq5rW/UZ5EnDhgMpxOj07NXxEl3Zx8WhycPw10lCx7YX6B4r3/KgH
         4wwC10uD7shrb9S0O9MXq+Jeli2n9CbM0NB7e29JLkUO6AAIuAJfgdsKACk+c4dhjPNV
         v7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsaf0eXZv+zn2NgksaI5MRCge+cYsCxm9AWol/VGMH7Mh5eaLbYuCN/nqbrnSbp5bov9yeyTazaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCox9xmab7rk3fTaqjFjPT7w99r8ENtgTe58aj0KunhBl87oGV
	DmYMh9cNdmvQAG5oXRpgBFARhohjmwUjsdnqWy1DPe+tW8pER+QBq02k6y7877NOGiy/ONiZBQ5
	ASLeH95cDATCXA77EbBjs5khxH1JX+56//sgRXU1LrV6+XmMPaJE/OQMsogxWhA==
X-Gm-Gg: ASbGncuh4sUlN3RbzhTyhlTVnAbcDtMfoThYGEo4LX7tHkfwm0gRItzchv6s1K7f70X
	H0yvmIcspJnpQZXHxDJd4pq5izHfcrB7yLw41WUBu/jOsfHCkYgyQWJiEhptdsT9J5wBtFjL+ti
	p6+Fza1jXVMndRlmfuqG7mlPq2HQmZBb2lkLYY+bcs9nt2Q15+9Yz33CDNQHJ1jiykPq6rUKSZb
	KSPdh/E1qSQDjrNJR6+RJq/xHs5VDpW3ZE2NkyVjPQmjK96NdASfZCKOMuq/u2oXE+9Vbdi3ku6
	Dcms90LTzL7t0XuJeZ+fpubKkAGIu8NClWtt3a8i1pyKFWtiy0rFawk+LwkYfc0v4Y3TWazHYpP
	VzbvtsP1RMBpa22c89ACBVKvo3d3+IpcvNHQH/nT4LARMNcWB4Jgfv6F4Z4jCfE7mwU3zAHV3oW
	EYQBEyW/FU/RnY
X-Received: by 2002:a05:622a:2591:b0:4ec:f4be:6b12 with SMTP id d75a77b69052e-4ed31073e8cmr191051531cf.72.1762222757859;
        Mon, 03 Nov 2025 18:19:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0ryUoF8tqlqAR99jW1Vl1MLNpRRKFPflxwGP3hN75SmMfFz0v4Z+G11/UAlfIAEcBs3/06g==
X-Received: by 2002:a05:622a:2591:b0:4ec:f4be:6b12 with SMTP id d75a77b69052e-4ed31073e8cmr191051331cf.72.1762222757399;
        Mon, 03 Nov 2025 18:19:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59434439851sm347104e87.61.2025.11.03.18.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 18:19:16 -0800 (PST)
Date: Tue, 4 Nov 2025 04:19:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Message-ID: <v5dbwbgic5cogxsf3lkmdwmlkpnqvo2niy3s7qu6ow3btpo7se@2altcz3nhbo2>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
X-Proofpoint-ORIG-GUID: fi0_K9x4mja-VOQNnCU-1Fn_2QvEfSff
X-Proofpoint-GUID: fi0_K9x4mja-VOQNnCU-1Fn_2QvEfSff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAxNyBTYWx0ZWRfX6JrJaX/Dk7D3
 SFcrHzUZrYTqZV0EmhToP74JGlFU36anjvXLKapMNLvF7YF2wtdNVu2Iaof0wsv9OnIggQzjSrp
 YrC6AOKWAVuuZCdAjY8g5NyYGzvYbH0/MzTAz4MSTLUFA94BohuceO997W6L1B4kZ+APiebuXCi
 gSGWhPIDnnclPTZicI99uYR0J/05vsIVoaGmPwiDJ6y6G1ZvScjHQGvlalXyffoFM9MdrZo3fOZ
 hcLQyfP5QpHIGIhDmL2BM5PHopgAEAVT0Ikq5zYsT/mCbhGYJQ0lZxWYwQsNQRj/wpfWAYhVxt2
 GXZSrysjzi3ukZznxKS1trZK5cKSOj8BqrR5uFV+M8w3BWX6HB+u23Ie6nxHQdVi2f858O39ORq
 SZa4EyAI41oALumGzKArm3yIzxeiXA==
X-Authority-Analysis: v=2.4 cv=CeMFJbrl c=1 sm=1 tr=0 ts=690962a6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0l2IAsR_NwdsoEKv6PkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040017

On Mon, Nov 03, 2025 at 08:16:30PM -0600, Bjorn Andersson wrote:
> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> > SCM can be used to support reboot mode such as Emergency Recovery Mode.
> 
> "such as"? Do we have any other useful bits in here?
> 
> > 
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > index b913192219e4..c8bb7dacd900 100644
> > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > @@ -121,6 +121,10 @@ properties:
> >            - description: offset of the download mode control register
> >      description: TCSR hardware block
> >  
> > +patternProperties:
> > +  "^mode-.*$":
> 
> I'd only ever expect mode-edl = <1>. Do we have additional modes that
> warrant the generic nature of this?

fastboot / bootloader?

> 
> Regards,
> Bjorn
> 
> > +    maxItems: 1
> > +
> >  allOf:
> >    # Clocks
> >    - if:
> > -- 
> > 2.34.1
> > 

-- 
With best wishes
Dmitry

