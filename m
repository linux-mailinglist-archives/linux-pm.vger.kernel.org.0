Return-Path: <linux-pm+bounces-25174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BBA84D15
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2478A78F8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A028F957;
	Thu, 10 Apr 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJPX7vmi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A228F942
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313500; cv=none; b=BIPHKgzLUwNi+weu0Rx9wrJg1Zw8BzirrlDI9+V0djhHZwXX1cZnOieSU7Wu6I1k3TpgmpXoRjQU4RdQXnxohWybxU3XWoR4N1qgLTRNlK0L6dofWSDt2+5+nI27QkrfPnsMrEMLmMuzQwNr8IhEAYHp0nmk7ZbBVkpCyWLOoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313500; c=relaxed/simple;
	bh=nvk3AfBlAGN872ZRTShvqoou5aanO8EBPXmNKMB9Veo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUrCe3Dkxsji8iMwFYnzAty1LTFVAOJqKxgdaO2XcqzxdhoZsbazyAaogtbttuoPcSRZAvD/moJakdSyuRDh9DMQJ35pHNKYQAP2bQec6odf1ILnYHt7/H4fU6OFucgCk2CaEFuW8ZN3+RNrDjzYNsDnjUI5jd8OOzc6JaOgM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJPX7vmi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGA7G2000635
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 19:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ds9TtaCY5KQ6iV/Yaj6mG8zs
	RfUBvQFElU18gYT4+UY=; b=gJPX7vmiC/oS5ak4DBfWZE9ixd9+ysY8osoaEgj7
	61edvL7XVE34WQiPGOVw+HlwLzPZqN6Ovu/+GgcvyuIN5Fou8pCocDn5TO2+FidD
	Wz7LXd8COtugpdgTP6aan5mqKNwcaw6Eaf0GjmzDVgUxfoe+yUUEubsrKbMfhYqk
	clzFgiIVJUr3IQAmlTsx1vUQb+nmnE3+Z1hwaqRorXlUl16NxUFATWerVOK25eip
	ptaCjZPDZISJHQ3BhWQxySQSOkRyV0ikTUYkHsCESJy+dyEnlfFiSozQDZaSREcy
	dRWjFRFSY60uxcOGQ30oHZ8nfQ0U31bSL2qbKsBirUC5Dg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd303mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 19:31:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2a31f75so351109785a.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 12:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744313496; x=1744918296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds9TtaCY5KQ6iV/Yaj6mG8zsRfUBvQFElU18gYT4+UY=;
        b=NwYGRgV2zGrKTl445uJbe5E5wSFrbjrPXVRrqTHh6vvxs2Mf/Qdzb7UTad7aHNpD5i
         KGYvC8+QjlI0sJJwSwh27WuUMLc5qhz5kR+RgGlksbMu3RbFHM/LqvevwIpQjp1mkmsc
         uKnS51fV+otinUBS4W1sFuNepw/i01B/vCXwCbCXUJppRsDv15xVubV8zBHXUTyRUDY6
         UoDZ51Yhv3VT/MV0vnwsh4AJKLjE6eZff4xcrOop75cytqPHnEaa9eUO9/bciK8+sHK5
         ygA8v7B6gm3fPjw0sm8HrPx4KvZuSCU5puH/St+XvZulxlEuMq9iJLr/u9MYx2sQDxoB
         9f2A==
X-Forwarded-Encrypted: i=1; AJvYcCVO8qAlTWZgsOpTKUMj0R3SRn1XSRR15YLLVhTbCFTjRPXZhkyHLvIrxuubTIVPP0WqNpiVQOS0oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyReZvi1GuPNrP0QMSOjwwNf0GYScAo+aPk5mO7vKRpFTFFY37i
	sSi/DykLXhRYB1680D4fsyoDORvienq+zMiC1TYvgYb5VBixJwvqXRI0xuUlVEu5FrlDeDAf8V7
	i+Xk+sZTbV/3L3N9lTrsZpveQdPheHBxaQs4MGmFCQlwjE9sKIA4zCgFPQQ==
X-Gm-Gg: ASbGnctfiQykgurCBp9UIxW2nmT9gWAV7h9n+Cpeoz8b/NPd6OobCA/rHrX0Q+jH3re
	c5QKkCls6JCGTVMdVIyZosgGMR4OWsHV41pTjegSXx5q3zyr0oTGex9KzjSkwk1BEB55JH7uGfr
	3XzNwcdNxa4sHEJJ1RvxlqBLUaY87Tt+u1hisvKMN12iQuwhlFBrdVQRr8mib/fCHltIiYEexe2
	tnsD4acrpqmQCtrd1GcXBxHJVcDfCEuE0Z6G8cUsZQLJcG59zh3zJXJMrq0sx2vFCbB8gzV6ogc
	MnGR4Jw3deKSO1VjGRKLvlgMZpwGYcH3ZLoaqs62G8zuOw3Jn2zBzqpLUUdP6sLhiHyc465mtXU
	=
X-Received: by 2002:a05:620a:439c:b0:7c5:5e69:4450 with SMTP id af79cd13be357-7c7af0d6384mr32377285a.17.1744313496253;
        Thu, 10 Apr 2025 12:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqctDDvkKrw5rP7GZctwMAOW52noXSrb/QQM/7LagYwEhTOr3WvKjQ5q57zE/X4Pbf9fAxcQ==
X-Received: by 2002:a05:620a:439c:b0:7c5:5e69:4450 with SMTP id af79cd13be357-7c7af0d6384mr32373885a.17.1744313495965;
        Thu, 10 Apr 2025 12:31:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d123d84sm228105e87.23.2025.04.10.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:31:35 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:31:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anthony Ruhier <aruhier@mailbox.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
Message-ID: <zns3xlyeajvxxpubzzsls5tnr7tnp4ws2dwfx4s7klzn4nslte@gpgdfjzm2s7p>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <dj256lrkc4s5ylqkqdrak6a6p3v62ckkd3orsg7ykz2w6ugllg@rbfkojacklvx>
 <0d1aaba8-7736-497e-8424-84489c637914@oss.qualcomm.com>
 <dmzoooujjb4zojjlgovjt6lccxilnnc3yr4j24vj4hwpzf5ouf@e6qkdlekcsnm>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dmzoooujjb4zojjlgovjt6lccxilnnc3yr4j24vj4hwpzf5ouf@e6qkdlekcsnm>
X-Proofpoint-ORIG-GUID: Ho_dXxfyDXnEVCzMYuEMtMEkFpzSh49v
X-Proofpoint-GUID: Ho_dXxfyDXnEVCzMYuEMtMEkFpzSh49v
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f81c99 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=ZR51km1V383oZAxlFiMA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100141

On Thu, Apr 10, 2025 at 05:51:38PM +0200, Anthony Ruhier wrote:
> Hi,
> 
> Sorry I should have gave an update on this: I don't think the lockups are
> related to this patch series, the same problem happens without applying these
> patches. It seems to increase by a lot the chances that a GPU lockup happens at
> start, however, so I could use that to debug the real problem.
> 
> > What firmware files are you using? ZAP surely comes from the Windows
> > package, but what about GMU and SQE? Linux-firmware?
> >
> > Specifically, please provide the GMU version which is printed to dmesg
> > on first GPU open
> 
> I'm using the firmwares imported from Windows, the Yoga Slim 7x is not in
> linux-firmware. I understood that the firmware files used by the Slim 7x are
> quite old, maybe it could be the problem.

Recently firmware for Yoga Slim 7x was merged to linux-firmware. Could
you please check if this helps or not?

> 
> The GMU version:
> 
> > [drm] Loaded GMU firmware v4.3.17
> 
> Thanks
> 
> --
> Anthony Ruhier

-- 
With best wishes
Dmitry

