Return-Path: <linux-pm+bounces-24530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3A6A71D73
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FB16AC41
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCF23E32F;
	Wed, 26 Mar 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UARbOku2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9523CEF8
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010900; cv=none; b=jqLxBKxVI+NhNfl/AJFZBuT3VZk+f6FUExACPI/ywoOpfgfLdx5tQ3MBsi9Onifx57EBDNFldesstCe3Mwqpbo8C1dbjv1v+iipTCW9LYHi1FygZHHgPbWKaYi2aPypqwmM0r6n7Gui6RseFHIq89xa7SWRE+1tB+IeLV+FycwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010900; c=relaxed/simple;
	bh=dPZgitgsGwSsjuUHxo7G7lYI6fjnEbCeZqlMQtm+0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qeky8Mq9HRgHA47w3YvKtOO+hNksT93eevC1CTdXLrHVYwWZEU8HBA3MJ7BKV5L9DWCr6WwJ0ZImC8BqKMz172WgwdGg30NcCZn6gOSbxPLsgwJkT6YhpYjrMPqTs0Z98KPnrzeCoS2wcBNU/T295u3DGShO+OU+qhnLxN5xFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UARbOku2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFkekI000678
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0e0BEB4eko8NvNN495XsFKzx
	AAwQjYeFziRudbDnS3g=; b=UARbOku2Gc5sIx+hapZo/JURDT+HpDOE1F0w+3ug
	sobUY5/w6QT7dQ8A3mrAUyd90pF6tMIaZSQ2BxpB0257f82g4YVBbF5GUDP4nLSx
	uedLj0jOFXOPnsB5607PhZF0e4+xVcQgVwiLCZspdjP5Tk/P91mdNT74wT346cHn
	QtUWef1Kq1ft2sqp6w22MzBRqfRv8C+wKSyMFAwvsP9NdwXsmiwHrmewc+omgb3u
	fVrUR1Mb9mbDq0AvxC3NnGFIOUAgBSOJqaQfpOxRuR3mvpg0gWj8BJNtaxpsSQhn
	tKAcCgoun8tDn5VuncXQWcMJVy47SamyzHnhZ9S0aBmh9g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kypsbnn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767261982eso1667701cf.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 10:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010897; x=1743615697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e0BEB4eko8NvNN495XsFKzxAAwQjYeFziRudbDnS3g=;
        b=cDg97z8ksv3c+VX2RzDamEOO1c3d2wYap14UOUJDaDllZtlrXzATs0CnUfgoK6cL4l
         G0gA+zvpjC37EJxcpUfFvp4vMSOiHS/JQpN2l0woxBf11/hyu3my1x+/7I6KEW0w8K+a
         Q8WFs0nl9xYdE0k0AwpS6WRFIeOMBWu5dHUA17ZtL7mheh8ZhAickYljkAwkrlvxYkjx
         QdXHc6QuuPu3ey0CYwn1ixW+kUWSyQqKxDfwY4pYCxXIm6UB73CwhEVsl0S79efgWky8
         MSqzE/mKqbRiP7EcGUbPIyZBxMVWkNeOtmEJZDu0kYZCArWwVAo2arYX2s3AsQqhRwPa
         ALhw==
X-Forwarded-Encrypted: i=1; AJvYcCWnn1peGFctvOuhSqmrSQnRmaGNqiQHOGon8Sn63o9wAnVm+Y9ciE/vRl1QvFtZIl3ZvtF6FzyJEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+ZbGOEpEF7NBBu6xkoJbOJiu/5fkn2gpEROZN1GknA6HIKOQ
	D495w0wL8LH8rUz1KJcZN7EW4T0PGcndOE1e3+KwglP7Y9O8f5a650WWsPo7RFe36LXgsLE7dxt
	XxTwZVvJRzas0Bj1sFpC7uBAiYPPwHEdJHAWB7v42F84Fwjl17aAJxyoJew==
X-Gm-Gg: ASbGncvODZoZGMP0HCe1RpMlmpbNBShlSks4Bf6PHqde23nd+hCOBpcRRJavbVIP6ys
	krhYvyU1HKeaWlM/lS3a0JG5I6t+rbgmDSmkihAxNEUuIsMegvXWTbugWaH2DjgoOGVHh0wra1s
	AiXwT40kBTnILwV1Q5g2xcKajCZCXQQXQhu9qEf+5gqze3dDsTc1tXmibhg2UnA/+O/7uCfsCuY
	rpOTY1IYOML21rjYOe093Zw+6NefWvONVna3Z6IEJLPCSYtEQczEjiFV1xzHyZk3kgsXUaRvEKO
	THitnRbbOUBYV+XJP6S2nfq8q9VI+Mxte4b6TaOXnWLEe2YjBOSjqGPc3iis5B5ckL9nWPAt9/V
	uT0s=
X-Received: by 2002:a05:622a:1e89:b0:476:a03b:96e1 with SMTP id d75a77b69052e-4776e21bfdemr8187701cf.52.1743010896856;
        Wed, 26 Mar 2025 10:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElZlPHzzeXuOhqUTtRJ08UHmrzkaRjY0W7vKQkAdgIF7PW8h3Tr/mClGH5KbRXI9kzx8/sVQ==
X-Received: by 2002:a05:622a:1e89:b0:476:a03b:96e1 with SMTP id d75a77b69052e-4776e21bfdemr8187181cf.52.1743010896364;
        Wed, 26 Mar 2025 10:41:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646872fsm1847854e87.9.2025.03.26.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:41:34 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:41:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc
 node id support
Message-ID: <qmzskuz7h5pqmhemk6kdky7rpoocppemq4stuhl36nqlvqt5pn@uvrxxoakynhu>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-5-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324183203.30127-5-quic_rlaggysh@quicinc.com>
X-Proofpoint-ORIG-GUID: F5_bniVwxaUJmew6M8UTsI3YNbpqNnQr
X-Authority-Analysis: v=2.4 cv=fIA53Yae c=1 sm=1 tr=0 ts=67e43c52 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7MvtbgVdnMJevg9Cfp0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: F5_bniVwxaUJmew6M8UTsI3YNbpqNnQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=798 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260109

On Mon, Mar 24, 2025 at 06:32:00PM +0000, Raviteja Laggyshetty wrote:
> Interconnect framework relies on static IDs for creating,
> linking and maintaning the topology. This dependency on static
> IDs prevents creating two instances of same provider. To overcome
> the dependency on static IDs, dynamic ID support is being added.
> To facilitate dynamic node ID support, the driver now uses
> node pointers for links instead of static node IDs and icc_node
> pointer is added as member in qcom_icc_node structure to track
> the node creation.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 17 ++++++++++++++---
>  drivers/interconnect/qcom/icc-rpmh.h |  5 +++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

