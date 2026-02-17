Return-Path: <linux-pm+bounces-42763-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPSxLAyWlGneFgIAu9opvQ
	(envelope-from <linux-pm+bounces-42763-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 17:23:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57014E1C0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20D3230333DE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998AA36EA83;
	Tue, 17 Feb 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0S7QHZ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5rSGT8g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD636E48E
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345416; cv=none; b=kPtU67MiTtcljptL3Vk8gALnbY+4tJNBThOvNBqaRGIgC4ffOZt81NzEhYBMriC9ExNu7iWzxA7x2BSNdwDACbB50fpPEOqXLtuKjRsW7xN+p7U7RFh7IyqN6LmyTxJKd2Pn/krQT/efB56bIRDvbirt6LYpmxiEuzsPkFwHnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345416; c=relaxed/simple;
	bh=MZgfISmNtKRd0DeJegvUbp3K2YqJ4nDQ20AQ+rfElTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNHN3RWPZKJNk+3fKjNzmhlW+P4lqYEJhEtYMcV6Ta/niLeURo2CDLanJ/TsTfR+1AV5RkeWr+ecOkVKSNp4kNAh+MMOx9DaRewdJ34s+n3MsK4vvbqhT+2R7BuSgO82HxYbkkG6SSY5h5ayrmd6lI1FLSgRTNhfDo2jT17xTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0S7QHZ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i5rSGT8g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9MYFR985641
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 16:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WVLp6F42vh8XKq8PDwrm7Fs3
	8/i5i/QAF9Oiq/UTNvA=; b=G0S7QHZ/8Eh8IhBBjMq3+AQu+CqsB5+SIUogcOuI
	VRDHNso4PfF4IfNgt27SPIAgySxHCFkOvvpVZUTX5O+1b1qUpyK3gnpYpcSYvvVG
	w0BWreXfLTm1nRkBHTb/2CX+UpjyUecJ59+xlQNatrYhR2SiLrhBO5FpFZ+i8Xb8
	8rHqr3iiPCA9ynDsH/nuqeQerf6xBNZGdcH+dC1Xf7e9a5zofYH/Sl4fwQJyNXYK
	cpj1hlCAq8g61CwditqlQCQgRf5ktj6snyquECSNxbJGzVYgCImgbWhi0l4ZNOvU
	zn7hEbd7OAli081HUHjiQPNDlfxeowqj2a56lF72nKqAzQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap2y87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 16:23:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3b6b37d8so2682353085a.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771345414; x=1771950214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVLp6F42vh8XKq8PDwrm7Fs38/i5i/QAF9Oiq/UTNvA=;
        b=i5rSGT8gviwAtYba4qh3tEgkANEfityb6WwgMjkcKtgPxIxHka8RZJeE7hhkclob8b
         9beip7/ReUhYUCRBJ9bMG8DfxZ3rmyOzLHArSDPnIEb+jjgY872rua7w+p9JDMfTAsy4
         ZF+3HS5wSuYWx+wz8+0SKxRdtWdZKvjGSM5wMLKZxbZe7wP4yBG40krJnygs4s/k+Cek
         A1PkIFysdD69Uhvy/vm+G2NKWwRCVvq+fEMwWpOaGJIIOyxDr7tAKgMboazyfXj2g89Q
         /KtzaZ60sYU2Mb1uhF62I/1zLpq6h8zNbjkwE59+4RxvYq9M2+3VnVbAWxY90NAL6H1l
         Gz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345414; x=1771950214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVLp6F42vh8XKq8PDwrm7Fs38/i5i/QAF9Oiq/UTNvA=;
        b=GIxCE1+MWJH0jNsoE3O73KW6p7mZA9viXNVyEU211XTXo+azwRCs3ODtD5RGmHYlve
         25L2OsPYYwEfat7rDs8bZQVwlUktaWEZy6pgjLJckrzuNkdiAg2BnOYA4WWO9IUL5lRx
         8v2RlgXkUGEb7ZKLvSlw+btOMByg19nod5Of+Rpy1CrnLbDBWXIQM+tuad2rrBXvIuNP
         jrlEHq4P5rcb7qO7YC1Z8iOoUtXo7mkY577QziMxJiKZxTfHUW3mppOYFKVX8kDhiVST
         G/UVyr0Lh+SMTJiV870ZOBNfUjIAXcwPXoBYLCkZHXarYVCLVFV0MsrRBCFcKpST0nB3
         CNRw==
X-Forwarded-Encrypted: i=1; AJvYcCWAVmyOTVGSAZNysIJHXeVveMQMyeZ0hkoIseGCL0qTkv45laDM47Ic9rGe5ZcFwab+jO87Tuijdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41HoXwt450BMSSkodOjghV+n3V91/L5JT2PXsBt9x3IRAitu/
	pRtHWjNXLCU7bJ/oBo7WH9gLtWmjqOVoSTKavV1EHDUO/suK/Og3sMMraDJfMhR71xVCajZPDxz
	l1nduOG5gqI669n02y/QtQNaPib02BgCroBX0a9Fl2SM3ekyTa7wFip3daoy0lQ==
X-Gm-Gg: AZuq6aKfzjrM6T63B9PYCkc/TmUrLe6+pX4l8WPJNqtGKSwajBfs1kx6UXWW0/eKqT8
	JkIYOiU4dmHTOTVAjcSS+t4SjOw07zjtJkz8bVFQWnigXMjrWRMBNXF+CLiHmYEdr2VyevyrRYc
	ERoLTZI9ZeMwtCc4mni6D+Dh9pZ/8m3OSxEaYO3/Wo0NHcngi/iw543W3XkGFofa8Rx8+/JDGgp
	8IVD/GrldMMh81E+0l4VHfI+j33y0Vz2A1Ul8FmgfniRs7BDMTCD9W/0QiGckfTJwJmZQZq5/u5
	1ZuVjk/tJso5dr814Yfo9Q0bJ9JZLpEZOh68zIgDqXKFjnEXrLU63aYvLzUOgngo8g3Neq+fjW9
	ldBKxdkPDybmPu6S3FFqwJLdM/JAGPKtWXKfYEnLYOVsRtVnR/TM2ww23Rgn3OGnAMpg0w+WhK6
	cW855pDNGywYW93eEAfjcHTKeanvu5KlCf1sw=
X-Received: by 2002:a05:620a:468b:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cb424bafc7mr1605743485a.79.1771345413703;
        Tue, 17 Feb 2026 08:23:33 -0800 (PST)
X-Received: by 2002:a05:620a:468b:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cb424bafc7mr1605740785a.79.1771345413240;
        Tue, 17 Feb 2026 08:23:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f5fsm3969811e87.56.2026.02.17.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:23:32 -0800 (PST)
Date: Tue, 17 Feb 2026 18:23:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] interconnect: qcom: De-acronymize SoC names
Message-ID: <fepfcyqpc7h2nopqbtjfmaejhtb5m2hrfrruzf355n4wc7zwyd@qek476ayuvzx>
References: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260217130035.281752-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217130035.281752-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMyBTYWx0ZWRfX+hhUkV6VJMrp
 1c+A17Q/oDy1qS5gxMWhB6/xOFLo7DZvqgs0aLDFSXoG1gxx0a3vUYBpL7uSqpqqEyYnGcOQQE8
 G+NBig7ocxXkItOs8D8DdMbCZk03j7cXfpQ+7QpWj00tFfgpUpxpUFZ3pgOe/23d7VwfN7NVfsl
 jlLL4JmEeId5Xst1aB3XKdyAU3KnYD5mJpLpanFXq0mMM0O2406jlkK/lQHNdCK8G1m5/vIEurS
 2fnUKSkzgxBxpjwPuxCY02AoTIqOpqZxQ9TgmP3m3OnWrHWhk3Htq01uFMC/ygD55baZAXfhhf5
 2xyykoRJTcqh40zxXTOj2U4uYbVqeOKJfku5vH4Qck3ld/TqECpebh20VGHfTcsK0mKCdwzbGTb
 yWt4Pt3rO0wFB3Lkl87HQJHNNbolynCGGs1I6TlvgDQRZim5YRWp3MBegBgT12ByWljzCt4iHiH
 wwGwLILtBjdCBF6l7Lw==
X-Proofpoint-ORIG-GUID: w16rpFj4qsnBCbY9VFQ7p9m2xic3ucUH
X-Proofpoint-GUID: w16rpFj4qsnBCbY9VFQ7p9m2xic3ucUH
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69949606 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=FlZS5g-ABFJi0eqNzBkA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42763-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2F57014E1C0
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:00:37PM +0100, Krzysztof Kozlowski wrote:
> Glymur and Kaanapali are codenames of Qualcomm SoCs, not acronyms.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  | 4 ++--
>  drivers/interconnect/qcom/glymur.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

