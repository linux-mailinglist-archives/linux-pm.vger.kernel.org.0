Return-Path: <linux-pm+bounces-29628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10987AEAC53
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 03:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A931BC76FA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD915689A;
	Fri, 27 Jun 2025 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGiJoNa1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09037288A2
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750987735; cv=none; b=DZ4/dcd3GzLNxir0ryv7VmpVQUrBibW4M7ojh8eUKeyJaL7RkI9NXDtpY4YnfFV1vdf52IbigB1r2X+wmu6OFLAoSH5FVbaeexkBpKbUhCwzrB/QKO91fzLWh807OIvoskdUNopxshfIO+HpmcuptAKGcyLRPqWmxdaBjnVrpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750987735; c=relaxed/simple;
	bh=mLhzT0gbEINjxMyIEBcYQYBQbYT3gPLBbXmxqgDjbXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R80tDTCYD8LqcaKuuwlWexJ81YxHujEbpK4ML6gz48MeiHb9W8fw9ecWu+1AtteWfmmKUtIWydd5paBxo7fdUGlKk3c2yVI0kiLhSqcioyhJ065ULzekm+Phk2zeTpIClOFi8MCk9LMEJDSlMNtFly7mfhTGT87XOKTZXaMD5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGiJoNa1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QIR9WU014014
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 01:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7BHttPaz4TxUNQzBLNE+418p
	FfXOu6+pWP6NmmNpoHo=; b=DGiJoNa1uPazrx+2KERUtSEAXuqt4lVnru3pvqJJ
	J2DFGQVD+8mf+Fl2GVyLhAKu35qYZb8sSEmA1WTSMo0Jt+paxrecMa9BzYPO2Wnm
	KYffpuY2cfCquGg9F5QyTYfsJwHHOucH5FURTX31/PKx8gYxn0BRN6Gp7mT7A/lr
	BLtWaRVfMJNeeERQNRTo3utljaZdI1nnWrGe/cs9btcI01h9BslyF+08y0hFXGKe
	THEzYiPVEtomHF/js31JRvJ927aFAn4gc/NwzgfNid+YfsElOPJc2pjMSfsq0avP
	G1UtWR4nTF2oGSSpQ2sGFu9qddblmKuJfXZMEBVXsbUFtQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm23nmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 01:28:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d099c1779dso216146385a.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 18:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750987730; x=1751592530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BHttPaz4TxUNQzBLNE+418pFfXOu6+pWP6NmmNpoHo=;
        b=ApScDQ7rETmqSu+gvkPJsMvZQ0xaE7bqVfocEn4YUJ8TD4owetr7e87SyrWgN+RkZo
         uHrOO590OfR2OvH+HiVl129Rtv9i4s9O8auPgQ2JlBke0WWlVrrr0+Yz5UCGSJ8hwbeU
         pGAENMmZFyapRuEoNnWRQuoFRKNFEU+d5iyeprw/FcO8MWOKUg6dsP3CJiocwJuwy2f/
         bEByB7muyGZGK2ZAV/tUNSczsRY+CJy4wgTqWDodQASUlUewEm37JqlD/dzRbd4scz33
         E8uqVXQ4AhMT+tVIOJcqaFn4daEC5RrmRpLlggZ6scsY1JawmnZzN36lAICWmrQ5NU23
         xoPA==
X-Forwarded-Encrypted: i=1; AJvYcCWpdEuplt7FJUQP3j+28KJqTlRdo8j0M3II8jJyQkMmvq9FA0ZhM6l7h3KzX4E+IbAPy2buSnurVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhgCxMMk/1u/1CCGJdWNkGy0BobNkLUYUHWuBzYFJ+2TzcVos
	nmWOQrzse1kMK7DIsoc82sBC0MXkmrVYYO/bdaWRV3TMJKmDUcTMhDUVkJBUznoOaYr+WmMhO07
	96JpirqAMq1DjIZQIAkRbJi7jvVkuoCyrOAIdM7+/70a0I8CvqxiN45roSk7bxOBUOIG3f2WQ
X-Gm-Gg: ASbGncvQCx0q5SlVFnURdSBo0pip4/mxkLq4UC1S8lXjhabg4rABkuhXz0U63AnhOxu
	M2qeVTfsA+rN+MBYztY/Cgzivat91RjSmURQDLk1vjiGu51r6TjJWKAljaPtVtRjdB0Qwls1rB3
	SalXiJWXrL/s1+EvzPzBacO/k8esLaaaG9+rgtAHz0j40OmA0Iu28PQfz8lHZpy1QPDUK8496Pz
	1eRxUEwzQRmiXMTmolKVVK/RKE3MbSEaNxPVU5lFXBVz1VHSRwl3WikIXWxTY6hOn7ecn2Nhoix
	M7Q/dkf2kB6Ry84R4HJU1rVbEkfIjD7e8XHZnBVCtU6Xzj7sfvo4VEkt42C7B0KK8JvQlPfF3OM
	RtPYcI7rfSClZi/c4F8YmrGk7x3ThmQEUdE4=
X-Received: by 2002:a05:620a:198a:b0:7d3:ed4d:f1ba with SMTP id af79cd13be357-7d4439b298dmr282411685a.49.1750987730545;
        Thu, 26 Jun 2025 18:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4mM93pJrmTOiGI3AS8mbJSAOrrA8+GDhMNzP/TNmnR49p+KAgomnY2oA+PJOFrHgpx9euiA==
X-Received: by 2002:a05:620a:198a:b0:7d3:ed4d:f1ba with SMTP id af79cd13be357-7d4439b298dmr282408685a.49.1750987730124;
        Thu, 26 Jun 2025 18:28:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2ee85e9sm3688701fa.82.2025.06.26.18.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 18:28:49 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:28:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider
 driver
Message-ID: <2we5y3aimhhizbsr6rvhpvtfkzl35lvpqr5vlhpxzsdcjudlqb@iotpzxpksveq>
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685df3d3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=lAZXaacekHF5OtbiRAEA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: DuLSGxOPlTEXAXHnDJT14nHMxi8D-YBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAxMCBTYWx0ZWRfX2zk6TjhPDxns
 yoU5IvalRQDqnRYp0QUStugXn5wwFvBYj9pq27AZIIzI2NMpN3M9biK/wRoDtanMNLswR4Omnb5
 HDTjQ/IUj0M+W8RXvQv4cGnBZVZlyWs1mGUKDgTo9gQRfbUeJe9pAVn5qXykOvjVM+1xpUHoDnG
 F5RY+XTZLJy8gyFXmCL9JxfrIzOMQO4zfX6wU7/l5t0OTCLxA+jZ0rHjWc4SH2mC8Nk8F8M+IRk
 mwvlZfnOZjWw1eAl+EjKPqdReSLpYpwlyuned+N/c8Mc+wiypiaT8LWSueTX53Uut/nvbJwAk/X
 q2eH+CqwE+XIBbsl7xstQNMR4ZilCAKcBn+Cm8R4623WyiRDLqyvJr7RaOaOfPEYbXVabMx/8MC
 9Fzd0vIV0i3CI77xw21zS1VCv65kKYsHpbkKa7ZuNnoYeUr58t1uEEx7mUYhsq2IyfD7TGPe
X-Proofpoint-ORIG-GUID: DuLSGxOPlTEXAXHnDJT14nHMxi8D-YBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270010

On Wed, Jun 25, 2025 at 11:13:48AM +0200, Luca Weiss wrote:
> Add driver for the Qualcomm interconnect buses found in SM7635 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm7635.c | 1554 ++++++++++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm7635.h |  130 +++
>  4 files changed, 1695 insertions(+)

Could you please use dynamic IDs? SA8775p driver has been converted
already and I've sent series converting the rest of the RPMh drivers to
dynamic ID allocation.

> 

-- 
With best wishes
Dmitry

