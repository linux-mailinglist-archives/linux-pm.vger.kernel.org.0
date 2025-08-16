Return-Path: <linux-pm+bounces-32466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B267AB28DE6
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A07B61B08
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F72E36E4;
	Sat, 16 Aug 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYeRqcfk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1E23ABA8
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348241; cv=none; b=Wbp8hjbdt/N2jQpDzqcs6qwO5dKpqM6pORgAXWnk81BPkNNBpd2k6V1ACT/ma3ZeZc22SfC1aoNBhrhNev/iG4tdk6x3uE4CKF1QaV6fz3Lk36U9xbxeq6HOuTMEYvZNPfvuxHmHR+J+4AJWBQE+Bz67akDpeP2PQk5H0Va7wDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348241; c=relaxed/simple;
	bh=dMBk5+wcbhXjwJZlDOPyYGIfvFpwhONmfJy657BaEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abc4bzsb6yr+tdJaxhvrDNPAqXRzZm4ronipB8ZrUZLZqkyDaWVp0Xdjbv8AeU7LHkLwEWcjEaBZD5VN5qo1kfffczfEvo2ZW3XSqS/gQzp1Pc/nMUx2Rxi5Ydaad6Px4q3m9MShgtmT5s8bl6ihN0iURSEdSomiBttEOmOJrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYeRqcfk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G9plof003406
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hD41N+iuU7Kbn6z9yv3DbEMr
	3/duRX5zPm7iHVruBQ8=; b=OYeRqcfkhTQxjIh7vJjse2vtU1r+cS7Xhy91Fmga
	0MJIdGJVdi7UG2s6f3G52TBGFYDyabckVva3S6pUcAyjhO1U173fmbncQvGk+b8c
	irxKYAvxEPnUsKzUG/2WvA5plPaxBr2FfFODI5byTp8R1Hmh6sO2fFZ1LTkM9qZX
	kLOotCbt2WjA9k0qDhooSxPNyCRslyBiej2XKu5VcdYPjJwS9Fhrrc2GRwdebQP3
	JIW9tJx6v4v1NBqrqZ1fop2dR5MxGjbTWCmsSokpDT6fXMDCKm3aTQp0QC6NaAUn
	SrfNcE5/7+UoyyPO5lukJQ9ctqCI5wzr23TwExkXKSh+BQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfpf0uj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88dd0193so62158476d6.0
        for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 05:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348238; x=1755953038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD41N+iuU7Kbn6z9yv3DbEMr3/duRX5zPm7iHVruBQ8=;
        b=LzyYEBLvj2+++X/yiix+swg82IEAlagQL38pZ2FAf7iDLl5J6hXWUw/yhHwYvc7qIN
         oGoNa8NqIkLr3OxxTj5i1p1TFR/bU8gLGyluQIM4GbfkECWwM1uXK/qAofzzRRj241rz
         EPd/CgXcV38xzt7x2tqwlnlWFQdvw44GDbQh+YZPT8fIaZLOXBdnh/aIUVBLpNiE7bnR
         Ez8uSeKOG+kRa3it6lhuBq0ZiJXQVahXA/GUvgWf/rUVRnCRBCVqmyMq6oq/fr8lezPy
         p2lSp48pWPKLj399tZhGHbE9DORpCXI0RKbqRjRLYeE0jBs9tmZWAxlmlmnR2NVq77Mb
         Tv2A==
X-Forwarded-Encrypted: i=1; AJvYcCVlYOa4+oDTKdTTVpw/KzEWNWCqx/2Q7wYyZQHR7PGNVaCTU3woO3pz8UVambFyb6bLEK9Zj0eAdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkF2mvEiyQZ+Alynv9ZAkUClEZk60AohSWGXm0yoACSxAaMkr
	WEOvjlXgvtTrWtWjCgvE0IeDwfgk6MOMxMk/zIdBmLz7NHrlTvzcB7YArx13OoibcYRFjQRWgkP
	nxUk5SMADI2mwosvaQgWqhvonTnp7nCgd2Umhuw6s0WZyOWh7ap78KvTjrtCBAQ==
X-Gm-Gg: ASbGncsKR93W6Sd4EyKARGsqjm9Qume5ca/4nrQlR1Wx7LjMg1+KKA7YNJhRtDpDoYk
	h37at2aj0ywoUXrWk3vfcPfvp3NVwXxPB3tK0HpuZTyOv3O3jRX7PKITkYnKKaukzNYGHawHv2E
	+bEc2/GN8K+nooD/z1gE3XwBG5H21DmwJuaTUgDS6aCrSi6MEQ8lg7ECtgHtbv+UbD/9Qt7qRpR
	e1n/515YGJfmZybg+xwVG51at+m1roInE02T+n8tfL1MbqT5dY+feTf2zhKdNe9XvSTSptTyR3O
	G0V0GwraeqRIkDXfcHTPSX8WMzKbuoQkch5g0PRLmlRMJC04g/xinSI921Nsf+mdi1RTifbU6ul
	668qYM95SqAss+PMzUq4BzOfQwsE36TF8L+gN1roo1cc473wtoSTN
X-Received: by 2002:a05:6214:d63:b0:709:8665:f839 with SMTP id 6a1803df08f44-70ba7c4cce8mr65606906d6.43.1755348237670;
        Sat, 16 Aug 2025 05:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0UyWsTrhGdjI+ezRe/+lqzfPKZobQcd0dOkMb96fMEc7XS15fnKL25K3jpBjKc/VZ0RLorw==
X-Received: by 2002:a05:6214:d63:b0:709:8665:f839 with SMTP id 6a1803df08f44-70ba7c4cce8mr65606556d6.43.1755348237202;
        Sat, 16 Aug 2025 05:43:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a604194sm9918731fa.50.2025.08.16.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:43:55 -0700 (PDT)
Date: Sat, 16 Aug 2025 15:43:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: icc-rpmh: increase MAX_PORTS
 to support four QoS ports
Message-ID: <24c6v6ko6iynfpqrpdqawcbgmxcuv4vngtmsm36cjektxnzhvk@5qo26h3zpnva>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-2-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-glymur-icc-v2-2-596cca6b6015@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: VpjsfDrTa0fXACubkT9nA1rShx-cuyc4
X-Proofpoint-GUID: VpjsfDrTa0fXACubkT9nA1rShx-cuyc4
X-Authority-Analysis: v=2.4 cv=X9tSKHTe c=1 sm=1 tr=0 ts=68a07d0f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=x1hKQwPmBbkKbiGcM9gA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwNSBTYWx0ZWRfX0DdG6ApdAPCD
 DnLHdTmhi+Mj44daGBsGbsKcA/GJFNopZM1EBIocWdSUn1GChKMFsz9RUG8N86CX2BH91pxV+S2
 0VkvFtOpYyp6XvvPX7aFhbibS1JUJ9UwIhP/0eydpeqnsKafiwaVcRC3IPN24OCjl/DoSXn97jP
 5Uc7stOWKHzkdaNXc6ZHrJHh+S8zyIyrmUoMnPUVpvGMvGw3RQqBVvRSgi+JUiz8Ducwk7hY94E
 CvwzYT4beXZCxs6AfT1B3zaWBQna6qYnbonUnvRx3XsriUgExfZxAxe+/o5OXpgf9QnFqHeD2jW
 xxwP3RLgspfwd5Dm2zyEAegLWfexhq4z2ROmnA1uChmuoWB8eN0wNZCGLG7mvBZI3LG8Ev0MkGw
 SB9LYBzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160005

On Thu, Aug 14, 2025 at 02:54:20PM +0000, Raviteja Laggyshetty wrote:
> Update the MAX_PORTS value to 4 to program four QoS ports
> available on the Glymur SoC's interconnect master node.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

