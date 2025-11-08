Return-Path: <linux-pm+bounces-37672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D627C43286
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0069B188D7A7
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C7265623;
	Sat,  8 Nov 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehE8VltP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXpMLMFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC4231A32
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624064; cv=none; b=VDdt9zfugOosN8RjcZq+P2xvaIdatVDpyQYSRvdHxzWCYKZNMtS9yQ+Vh+U61rupMkg/Zo4Ya7N2cWj739kIkODcKxOz1udkAPT0J56ysuLZ1wdgHeOouBFBnAKKCg7hWtFN1MzL6uN5tqQtskvAXoRDgwrxeGPDCsas8TZyp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624064; c=relaxed/simple;
	bh=HvpMmGW03dxYZC0YZr1+D/jVHMgv5z2Ip3dLnOgqI58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiEkm3g6Db8wjasn6lBiOllAdnwmoFvf/vWszblYdqqqSPNNA1ACbEN0DLn4g/0y0uP7z3T7UbueChENuj9W8xFfEapJ7C9TvsaqLVYoYaflwpvV7wwK1zc8uyOVDnwcAfjd1K3LWBWKm+O9S8HrtRBd/UUenaae+GIHF5OXXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ehE8VltP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXpMLMFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8FgwTq2169529
	for <linux-pm@vger.kernel.org>; Sat, 8 Nov 2025 17:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ap8lj9Sm9uVSu2cLhXJsylRK
	Em7Ck7Un0+RpreSBVWk=; b=ehE8VltPXhudhLonqwFbDy4yuE1PuVRx0IRFivnl
	E5RNygneHI2ThVrziuVdwuP1y6tLymkZfRB67749jZitmFn1Y0VaSYDpkljAiaHs
	Xz/QG8Bl1i7hdhGLJjjd1A15n365VduJmNzIrYa/N8oPGPwiJa8/++2ctl2BCPuZ
	lKUVoc4el2dbrpARRftAyht74KvnHQ1Y/ziXwsIntQTwvINJhU3SyDfblnsx6Jyb
	ZRdHG3E54HyqTXBMBImBEIFo70N6HS0e1teXUmgnGmEdpd4W9hisrDOShIUf5oat
	PT0nG1IJSV05NdWZwj16BM+WIQ3gXUSGry55BpyKyZ6WNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9rxmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 17:47:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88237204cc8so37356156d6.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762624061; x=1763228861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ap8lj9Sm9uVSu2cLhXJsylRKEm7Ck7Un0+RpreSBVWk=;
        b=WXpMLMFtgS1bn9grrnmsr4YxEHL7sNGIowbwZe/HlQNzg+H5Wpc8f8dbdar1vme+xS
         pa6tO8wb1josEo/mLVwUZ2YpN6226qDDUooBake3m8F7yvw0rbkLFM2i14SQsZP9BSOZ
         d3bmYRdIStnPf0L4cd5xel3MdomoKLDgWNKiexc/fjlYAFCcp27RDC12bTcKyyWosgDo
         BYkjqmV5AFHWV7JINJ1DSFK7tVDZ830ySraRaEAyOmrvi9OXEqP6HjvEED3WJeGILvA6
         llW+wf00QviwfO6f9KvLMMOoem/D2UlNztf8vz2qEpbxEJHMm1C1aGOWLsV1kgXM0jC/
         U4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624061; x=1763228861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap8lj9Sm9uVSu2cLhXJsylRKEm7Ck7Un0+RpreSBVWk=;
        b=qBC/ofNq56cNgFPt1Jw1cT+HLmHk9Aheuz4Oy0ZeX8roYlWhIc4/94PyoVeu5ESQyX
         jUT6ZvTJc+zlEgLt3noEFo7kYyIKPKREgWy4St/eow9BBeyKwW7l39XMEENebHOYMIXn
         m32mC5j56kBTW/EtwCWKiwCAaSJ93TJmw3bCows2qXb9M1AgQuIQaavDxlUujRBwo2S2
         LWiwvue642ZZBvd5EGzkxmNLGGIpLzsWTS4/pQr12t2aypNnw6/ZrCnP0t+eSgKWeBCT
         OM6KETYlJj5j+RxNvB8ZLo9SCitvxJW/AMIakV6bK+hT/7+pQNjXD2UnSQyQc+PK/s5w
         cT4g==
X-Forwarded-Encrypted: i=1; AJvYcCUR/5WHKZDtEQLSSu4/k4rFtE728ogoLcFL65vIi9SmKmXPIAla9ftettnNK/6yKbg6ENAJa3V9yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5mgtdNd+uj9FvyO00Zoqo6qeNCUiX46hwKJbywqdaWTJ19cD
	sOJ8i+a1k80fkPk7pr4GDc8f5FQvOqe8Sez8JqH7WWiT+FRcZ/j61XrnIMvlGWEYZgqege695Zk
	0+mqKZwtSW0UTDUXcZcQDXU+gLMOGGnxRhpiXuQ4OAiIy52lVfDEEJWYgcz9zVm94xfE9Ug==
X-Gm-Gg: ASbGncvPm948JZ/uVt8217gsTdQitZwFPBnnq0HGbv7hgU+5dE4e0pBjjpyEeAzFi5C
	apxIdhulLk0FvVMfentFvLtGP8SURztMpJVjRyrM/TeKM8orFYmwXctA9Obko3n3JCp0IcZ+vMI
	UUQawTeEhseJSyhH4ZPJkg4e/E5ym4ZZtYR+Utcn1qcvTKNNHvGbOcT7alGayuk4CPKBS5WYHHY
	Bi2SIvWFJ+ktCP3NU47MMBAnmCQAKrXziHlgIaR0wkCyHBzb4Uex3sTXxSNsdPXYi3unAjB5Hei
	jJ/ZVXh4m/WGdp/MmQA9neTaQdpTiRrKRIY+w2zZVXvZHK3EVWSmjtjupZj3+JNiGvwnOZmnF3l
	oK0cfbIP8NDnaGBLuQT629+16v9ZjsIKgYS/F9zH5FFs3P0JNkEYtKFLhiDQ6kpWsj3TVqoH86f
	a6lVV/0b/Xb6nE
X-Received: by 2002:a05:6214:f2a:b0:880:4f97:d17b with SMTP id 6a1803df08f44-882385c4948mr35733376d6.19.1762624060723;
        Sat, 08 Nov 2025 09:47:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9L3CuPYnBcr11YnGCLvWOHvYxkY0YKpO25F22jI6Vbwp5Lf3pvefb6cGn9JxaUMlq18tqcQ==
X-Received: by 2002:a05:6214:f2a:b0:880:4f97:d17b with SMTP id 6a1803df08f44-882385c4948mr35733216d6.19.1762624060312;
        Sat, 08 Nov 2025 09:47:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd168sm19909131fa.33.2025.11.08.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:47:38 -0800 (PST)
Date: Sat, 8 Nov 2025 19:47:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] interconnect: qcom: sm6350: Remove empty BCM arrays
Message-ID: <h6zyw66l75p5zvaztc3piimbu3iiusvjjxmee3yrlxh5xtievu@lme6idh7ja4q>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-3-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-3-8275e5fc3f61@fairphone.com>
X-Proofpoint-ORIG-GUID: Qnv-aHEO7haJMtj4Tz0OlrDR_n7_A21P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NCBTYWx0ZWRfXzGVCHLDlMCXn
 wHQJjSfJNB/nIWjBxTvBJD0axyQMg61diqZIabNW0XRVqjZUXf8SM0LcdZ5onBJOCwHRzJVw2WE
 1Yn8Apz9rh2aKDNh4D2CEs7pfCI/ZvRkvfmOEQVlnYWD4C2cZMjE+YHAerVTHZIh0oTypyL0nOK
 8vsbkXiKSnn9NvKT3oh/OZEGA1+DKhxcIZrJ7aCQJRJFPbz8MDw0ykQZl/3+rf0EmCX5ckmnz4X
 f6KE187jRXiFG+eCRyfwoFyrDipFmckm3e352m+MOseNp2SaY4Rj3nEVHL1Ng580hu1OLa6SwgU
 tKGeKJH/BIelA0s2siaIbolzhwuNxiYWqKF3IW0MRRoOwOAvukPyjS0kdheij5A+J9kXhkXn8CJ
 oelHpmowsQpYCPLh86nNXuSu+zowKw==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=690f823e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=AgmifABs4vawdm9268kA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Qnv-aHEO7haJMtj4Tz0OlrDR_n7_A21P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080144

On Fri, Nov 07, 2025 at 05:08:49PM +0100, Luca Weiss wrote:
> Clean up the code by removing empty BCM arrays to save some lines.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/qcom/sm6350.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

