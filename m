Return-Path: <linux-pm+bounces-35325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB919B9D3A9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 04:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBD77B37FB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 02:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E72E612E;
	Thu, 25 Sep 2025 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HX4F8QJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7281A314B
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768437; cv=none; b=MFQ8s9moRKJOBzYnvUSKTmF5hef6wAZpLBrN+0YrtKotCtAGpiakt2mq57RXl0h6H55Szp74SYtUuhVgpdPCEh6jRahTUrS28lFChMcgJK9fbVFI42CWvgtehzqWQKhzV68xwN+FDS+gCMy438O4hbndaGOxcTZU9FEmydhBCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768437; c=relaxed/simple;
	bh=knL0qShSKz9iITJEJ5pqwFTLrmcOR2lgqU1fn+jaaVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kewwct8/IP/onV1IpI64G+ka8SHx7+x44sU2G2x8ekadkmnJeBgpEDewCNjl3C8WwxcxAoJepJ0CTUTjt+Zj+QPiFlFlnVMJhwXO5HaenrXD1geEAUZECn7QKocXBOzbTgARuX0zR6yXbKicUNUsLNrv3xTgV965ycUydPlURrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HX4F8QJ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0qiva001992
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vmzDde1nY9Gum+QP/kxmg/q8
	dry3hyyGVlLVwLkd+PM=; b=HX4F8QJ3IB7L6d4GE/+g7UqPw04IyNlM7sVMyFyf
	3OmCpJ9X+A/hHFuLuT4w5s0w6HkAT1GYeXSsI2Uo6Kry4P1vYCSFOKzfc/EjsJlW
	GJ/IYnEbYUqzyxKEwfzLXSxZEr2Z/vuAqnHYljJE4+eDHJ99FvLtDiBXHs9HRbxO
	SCcAy8mqGF6ttw0/tCjl2zWgVO8rdVFlskGCaAnd3eb/LBklI3jq+yAl9t2I7sg9
	1quHLjQ/MGW9RcKNeoVuBq+hO6skgvwhYWPs9pX3nj5MEaUkO18AELFdrvJYav9t
	VlW2CXNrzUVisbgqZS4+ve5L7QMeHfms9ykmDnPjmG404w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98pg5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:47:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-79235f57ed2so4270446d6.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 19:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768434; x=1759373234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmzDde1nY9Gum+QP/kxmg/q8dry3hyyGVlLVwLkd+PM=;
        b=WR9ZBkTFqOmykVwm6LPbq8xmmA4vU2kSAKL8TW5+H7gAwXmc3OcWyBb/bhOW4N9FeN
         j34MaQZU8lFlvRThUSyfiu7NS/WKfw2oRebzQQrRkldcjdvWeU3ufsCLCJ8T2bhzK6kS
         gzg7v1mCgP1O0mSkTWM3NGoeAfxIbtb91so1HNxuqQpY/fOG0LXbEI7nBfpuW2PmaBEx
         /pPJC/0KUk5am3mXDRHPCzybWBB6ccxxdwVZcrqyQ4gCV55EdO3tDSevrFyGifpkPHXG
         m8RTAvl5bl3VIcFHC88dXFKTCRaHktNdwHTRjPI/EOyQVO77qyrzp9OO++CbKceLwXiq
         8A1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDWVwVDNkUO46FVCK6Zw5HfURkICLwbVHj53hshxmdbaY72RR3dO+TYL5C5e2m0OupLbE/6I8w+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDjYdBvFrnguhf2M6m53cSG2p3KiV3ngJZdsk16iP/JPSmtph
	Xy4LgBC87i1axP00zZi4+T8t9EliVBoOlufDPX8qEp0aLWj7eeEjVGzA705NpW0pyLtFCCbCVpG
	XF7NNr56Tlth7UjA6STyVr4hp7/HpPKTr9u1Hc9l7t11iaxBOMBujrYTghZd+9A==
X-Gm-Gg: ASbGncuwj5hPuJsY18UoGqZ97sygQGGFywvviE+2a0ZrjKiDyBI3zTqk881fANshePL
	JDbuS0PoPU0kZHPfOk9Ri//z4gGDMpX+dLuseh3WNcIWMqqO4sx9fib0yFcckMeMehgmzIHpsr9
	V327eKPlp3qdFtopy6eQb0qLgBRV6nCMM2fPkusLEb7bm4ivjqj+AhfB+63av2dZ6kDtLOZl7CH
	emfw9LTLTsQpF2iWPb69w/puy0qLQpTWTYVAYkFHP7tOHx/W5urtFoU4hDCvas86D2/Gcb9S9ig
	SGI0MVq0qgWNCfUIXiARyKVizLpT5XHSwjelQjBYqu20gBvSzNw7RrDn5iS5OSv4dz2n2Hd74Ve
	DJu1nDXkriSzEJGSCMNq9fvM6bqaVR8JEAO5xe98iCUqPWKzocGFP
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id d75a77b69052e-4da473535b8mr32183011cf.16.1758768433972;
        Wed, 24 Sep 2025 19:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExb7T/OYccuwzgjimDxaVA2LXm9/FSZaMnNzHFBySx7V4Je77xVRXOd4TLu6HqCTkejd5+IA==
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id d75a77b69052e-4da473535b8mr32182901cf.16.1758768433568;
        Wed, 24 Sep 2025 19:47:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665640bsm259733e87.83.2025.09.24.19.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:47:12 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:47:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
Message-ID: <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
X-Proofpoint-GUID: fUyL9rtFy-YfMDgaxWDXE79d8EGhiP53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX2iIuWWfWHEBQ
 nG63+iPrzQmgO5U1kfLPKocK3pWGT9tZ8HsfdNTq0Ecz6hmG9g/ZEiVRIoEsWSIQzjKp6xmUPDa
 Mm+J0GcAAYm136kW2VEx5P6zikVgsFNU5CUqmk+6Bvv6HaXkIfePL5wMauLrZlGRDLMN1wq/KvL
 oH3mCHwUpWEG4MwrYxZ/OGzmP+Ze1wxTqXnXinO9n3aEtqilwKZhTmstfvZlMO0h4JhBbf2ESUC
 A2j6z9GpN2XPIpbOud9aYm5Q8cs0UjbSdnFEFMvYn+rby+ZY5uProApx3Z7DgM9i9i4JRA7M3bC
 hLsoHmuA8YA+Dgo12EhsyvvKzrvTsngz9EOnRPVJUEMl27jysHAQRpePvjxDHZ1XjpHB10/XHOm
 jpQQn0ZE
X-Proofpoint-ORIG-GUID: fUyL9rtFy-YfMDgaxWDXE79d8EGhiP53
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4ad32 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2uCcKERadT1UtqjeBP8A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Wed, Sep 24, 2025 at 04:02:45PM -0700, Jingyi Wang wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in Kaanapali
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig     |    9 +
>  drivers/interconnect/qcom/Makefile    |    2 +
>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>  3 files changed, 1879 insertions(+)
> 
> +
> +MODULE_DESCRIPTION("Kaanapali NoC driver");

Qualcomm Kaanapali ...

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

