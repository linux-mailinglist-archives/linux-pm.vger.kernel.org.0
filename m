Return-Path: <linux-pm+bounces-31081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD731B0AC3E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 00:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F057B3A8E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 22:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8B2248AC;
	Fri, 18 Jul 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzEXe7ov"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB722422E
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878721; cv=none; b=T9lhIe82BzyxYKtXOVmiCKzhf8pgYs0JRlW/EQIDBG6KBj9Uz0CtL7Y6Vv4CzHjHbjVOx7AgKCaXGWfqrPLr6lCQIdfGRWyMxnQsxMkkjXCE6ipNzwNzZ6mNeFq8y7+OxKkiRktiF2DgFOEc/x5FkOO2H6pFJAyhYGuIWkBR3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878721; c=relaxed/simple;
	bh=NNwCzXoPYMOTPaXJKHL13c21dOfYSIJZIh7sHCpA1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFoa1sMX4Y1ezjG3FWVpuhpMXIm3q3ST1F0ZzyLfNES/UVz3AqChgzn+vodANrQKNhNu5Fx3lFw5oQOqtCBQuxGykFRwLlT5lJMuymfuMDvmESwkMJ30GW1PQkiqeOPC1OayKGtsB48NQmUUfvzZBvQI/tz44MirDnOT5oGkOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzEXe7ov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHUKHE008498
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B8+eKAj/ZD/UM8+YkkMpBzxn
	aUkFdQMdJ+OYNUtinIM=; b=bzEXe7ovXUKg38w86JRFjXP5NLmLXCb4PC6cMEJn
	I6UPqQ88m3n7p1/A1hLs2ukBkq7/sLq4Jd10UX81Gj47IbLJVf7juVZcsMp8D3TG
	F5phU0XdYjBGMT+d/EPYYfLkbb1Cu2Ou7gcAQLwuG+FjQZ5wBHI8+6hm+Wv6EAe7
	+9WM9qT3sBEgwfj7cRmaE0E+FKabrR9ltp52DCuPl+JAYTCrHHpIHkSMecXbKFT+
	Xrz6gxpPjreK1Zx1zwm9pBurtZvoQlyoJdP5A6zEGGQpL1GeNzVqgYHqPAbtLYcD
	M5xYUDpxDx2iQmPf1rjO3yUAu+7xwD/PWc59MUaMS2RxuQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbd535-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:45:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e237c2f4ddso344554585a.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 15:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878702; x=1753483502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8+eKAj/ZD/UM8+YkkMpBzxnaUkFdQMdJ+OYNUtinIM=;
        b=X/GcNNRPhv6Hivah0+BLZS3XPiyRtmZ//WJ7s6qqJPoqMMtB+AqS1MHbWo/fYkKDI8
         kc6ZZqFHQ+D0ztFc7srC56EGIMRYPxxhTeVg6yaw0titFegKmqd7vRNnxJ3IK98376aG
         XVzHwF1tlX370a8YQ55y9wr+dP1G/OFr/uTExkLAaeUOzEeiS7UW5xN9WfvZPtCqt4ej
         gBIWdj0MHzaaIAQDjLyLnIlyXC6DCKXFq8jXzEF8Cb+hI5KtC7FJ2nmYfs9ydlCO/vR4
         xGnT9bHkqErYgZsDSiT7ZH9eMTncog5fO8W8cWzP+beTkFAfEdPtCZF1efJA1TJ3kfV+
         dQUA==
X-Forwarded-Encrypted: i=1; AJvYcCWp4t11aNalixSk4VwLrQagRUANHas3VD/5Y6l579f65pq9a1r9M1Tcyko/pulmFkHO8OztyPRHsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkePCYrJdvzV60uvoiHMogmpZIItUcS/lHrqeLgSFTiN5Wd2zN
	Oq7CxEf6uJ7x4oM/+mNZn2iInTJRseZ0VTztAaZi1VITu2hOvKS3irom4e5iQPoA906cqhoa77A
	aIOYs7XNOzXJu7DxZcgjX3X4DUkgHStz4g6nnVx1QOEAokMHSa+8YHy8cuyWeqA==
X-Gm-Gg: ASbGncuhViIHlmypnpNFitz5YlsVn7UOqRFugiBNavTEUPFeeukJBugke6fwx+DGj7P
	3Ggq9AOhmH9hgvQU9Pv0gbQm9xnjptg/AvVT9KmcILXu03sGgd5ZXKxLkryc5/3osP/oexZKsP5
	ECcLnjIjSL6uaAl8UQe/IqgPhRQMLuI9KTGq9aqAvdW5+87DQUDIGgpF0ngo7KfiqAzMUVBt/Rf
	6B+NQuyiqOftAp17D9yHlt60HVdhQpPuQPbFnn28rUpzqEsiX2i4M1PY3/nCuD3Vm0sVcshCo2W
	f3cLv4BuM6KLUTn4lIPH1t/rasYpFc0ZS6k0Foo7PppkoRo2UmU0zIj401zs6wkqXGKIvFyQeqc
	R0BeV3T0xhfNa5MqJoMXWOiTxppKkpHsK1V3lQeiccMyGY97PkquV
X-Received: by 2002:a05:620a:1127:b0:7e3:487b:2a74 with SMTP id af79cd13be357-7e34d9d1edemr985985185a.42.1752878701867;
        Fri, 18 Jul 2025 15:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWAAK0ht/7a4kdVpCySbSDtfrai4FYse/ThX0w2qF3gXv3M878f+tua5mo1f2EiYqVCiVm/w==
X-Received: by 2002:a05:620a:1127:b0:7e3:487b:2a74 with SMTP id af79cd13be357-7e34d9d1edemr985982485a.42.1752878701438;
        Fri, 18 Jul 2025 15:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a911b775sm3371171fa.45.2025.07.18.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:45:00 -0700 (PDT)
Date: Sat, 19 Jul 2025 01:44:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
Message-ID: <wi65rrkxd7f6n6nxse3p2bszv3lcko2qtflpbffngupqslcd3s@jvwec7rriqgo>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
 <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
 <efvyk4ojddr3emsdavex4uqrl476sj5hz3ihd6kditdxd373jm@wu2av4fvqc4h>
 <a2b837f8-eb34-4283-8d7c-17031a7a682b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b837f8-eb34-4283-8d7c-17031a7a682b@oss.qualcomm.com>
X-Proofpoint-GUID: C6Lr5kwgXC9jMl6P_IXffYqHi9zOMOh6
X-Proofpoint-ORIG-GUID: C6Lr5kwgXC9jMl6P_IXffYqHi9zOMOh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE4NyBTYWx0ZWRfX8QLxCAWDSbHF
 KJvxJR4dDNCVtZ/DAT3zlO/JswGJnH0ac8vuaKzRw6OKl3S7MSqNekzZaeXJcE++tGGeLZs2gDA
 lL2Uyx0iu5bTy/DoRscfdqGn0uijQqGN3nTjeqaLyhhx9GI4tKqS3ZsYuU4WIUXW+81k/4rcn4c
 rX82cpKFw9uXaj5ZCh1mPQ05+/kc7CS23uoBnneBwyW4212/TBk7SMUpKQjHGavypaKaEh3whHv
 Po7IG0FZ10gYXsMdCcJ/zDOC0Pe4pZeSpRe28T+iWKi5QjKUtV3oglRV94TdPO75jnFFqnauorE
 BoTb8DWG4iPGUrzc4b7v0BjLBrRJRKzEJFIHp0UTxk4xxnif6hHbtlgUwwaBeRCxuN6DeIi89SW
 1qdFfQ0xC1wcpkW4DBGSKJ9aNXYWTcNJy1r1it0eVcB2hcZiBnwjOM8xvHfRJYT850RD7wS0
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687ace7e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=votViI9Epv9A33Tv9KUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=618
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180187

On Sat, Jul 19, 2025 at 12:17:47AM +0200, Konrad Dybcio wrote:
> On 7/18/25 7:26 PM, Dmitry Baryshkov wrote:
> > On Fri, Jul 18, 2025 at 04:38:02PM +0300, Georgi Djakov wrote:
> >> Hi Dmitry,
> >>
> >> On 7/4/25 7:35 PM, Dmitry Baryshkov wrote:
> >>> Having the .num_nodes as a separate struct field can provoke errors as
> >>> it is easy to omit it or to put an incorrect value into that field. Turn
> >>> .nodes into a NULL-terminated array, removing a need for a separate
> >>> .num_nodes field.
> >>
> >> I am not entirely convinced that an error in the termination is more
> >> unlikely than an error in the num_nodes. Aren't we trading one kind of
> >> error for another? Also if we omit the num_nodes i expect that just the
> >> QoS of a specific path will fail, but if we miss the NULL - worse things
> >> might happen.
> > 
> > Exactly, that's the point. It is easy to miss num_nodes, while omitting
> > NULL will crash the driver. So the error will be noted during
> > development.
> 
> I really don't wanna step on your development, but again, I don't think

No worries :-)

> this is a good solution.. maybe WARN_ON(!desc->num_nodes) would be better?
> Some static checks?

Another option would be to follow RPM path: move links into external
array and use ARRAY_SIZE. It's still error prone, but it is easier to
spot.

But really... For the array of pointers NULL trailer is the most logical
way of specifying the end of it.

> 
> Konrad

-- 
With best wishes
Dmitry

