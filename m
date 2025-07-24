Return-Path: <linux-pm+bounces-31376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F3B10A5F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17973BFFC9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C32D29BF;
	Thu, 24 Jul 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OT7nSb+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB12D29AB
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360621; cv=none; b=DsmR3lDerR2dUOVfENaJTaHU3F8fas3rOYNdE7Rwy1B+S22DorpAeGQJ0gWKv6X4JrLZoiml0Steq281CYaK7e6G5CByNE0zRrWf0TvTAkdEklLox24QSKmZoKnUjYd8PlMBuWHJV8mfggg9Z6aOx6bNFtj+RHhgrv/dAPo4jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360621; c=relaxed/simple;
	bh=LcSIW0NY6oVfU7XhBiAcCwSmXdrPSxDV38BCQfAwyXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbNaRauYj3ig0M/45FMOAzmehB9WZmofIM8MJ4Tt26OjZRkTrPEiVIYWkFnG+O+t6aGqIPH8P6SPCeBf5iP5k5UtqaR7kw7c4NBaiTNExPNosGodz7kJoCD4ttQdAnwREe0uFI5/qn1LiJ6gm8+QC2bQhvMcRD+L5HfqJ/SOWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OT7nSb+t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9slc0007119
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 12:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSR4gbUU/2tBPcpsP9lRCwcwfrmXksikVD3aXPQ1sts=; b=OT7nSb+tMmsWHalP
	bvt32Eq5DE67wqxcWNQ7RmlVdqStcAEJFIjE2DJFh+TcX4H4wuzmlNY8+wFQMBHu
	fHjjjd63XJZ9fnZtWr/Yb4tOKntSmW2GmhE2Xrmklb6qU25PTFD9RqJfMw7B4Lvy
	GORgShFwNatTr4X70ZqzDU/YpFjkRrBMYxfitQzC/Efda7iKJYgCkBZeWk/MzVyS
	dpwB4WatGXFuqgXc/srS110j5GcI4rjehJG8KyVFJvDRACxL8dGkbf5YCWn/Qo9j
	J6W9buqT+4WaYjBTTXEaLeq4HS6zIixg6DrYqJzVqSTk/fHNTFFmzeA6ewEG/QGK
	CY/Icg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 12:36:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e344f333beso19108285a.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 05:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360618; x=1753965418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSR4gbUU/2tBPcpsP9lRCwcwfrmXksikVD3aXPQ1sts=;
        b=AesRDdhhDOOF/tEQ0osfYrgLgEJsVq0NcMpQS1vmw52DsEnJmgXKlsN+WARoZu8GeL
         Ro8/2hXozqdRLaf6sxt7r4tjh6cEVo65UfDAL0+/CJ96cedlzeNNifgAHvxsenBaNN9t
         CMpPoQnBj2+YApxe+iOccm9aDUz398SnFAz9SyB2NPmZB+W7VzPBFaaiUnrjXwRbKjhO
         SNvFLH8SL5J09yjwL5ThZuVcIWy6PqA5EgiIb6QlngxTD2F37KRfB0oEHKASXWCTzdIY
         II5AgulJfDVxrTIecRBDch1YTCtlFWM6oDcGXSZk54T2ryxmkvWeR44tLwWOb9rvZop6
         9Hng==
X-Forwarded-Encrypted: i=1; AJvYcCVABlClAG3gmS2MtD+ztvYR3nm3q9Unz/RDDUx1IUzswRIZcX8XC5YkxZQ6YbwCj4NdHtxgFD7vig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XPnlye7kDLXDwhLH6JerqBvKGjZuboFczODzaXU200hoQkGX
	+9MxZ1JJnidnbM1ATwsScF4ic9SNwpDj5qHTyx1chqM4px/j9fazZ8SYKKehbmZx7BQOfTuul4/
	XLj13QWRiXJaJlHKaPLNHjfLfmJSPQoOeqv2uu9Lh2zfbsbKTimIs1Yj228gSLQ==
X-Gm-Gg: ASbGncsZK+RRP39jhRfcZileXLERqakhUxfNToqhUCBA/Z0CdfWi+GOD5b0bO5DgaQn
	5WgJsBk/kp/QsLri1/4xYCGUxWZYFZZ69Gwi+cN6SvVDPE4CIH9pJi15NqzM+XP9BBBaOaIi3DR
	wM36hFFznqTei0dhz4C82U+i0FqGoasePedDMstPwHocghi/MC+mvxgnMO6Ju37MHR2vlMx4NNQ
	xhNxWo3JDQIV11mF76NokEOe9IfWoaQEARnwFfWZKv9DdseWy9tIcCvw0SQx1Y14lUu8IPsq3D1
	GzoUdA/Cxjzg3HmsPrRqBBZz4UqwDJKhaiqxUfjS25/57Afj6n8kUuLJ6TBrJkzkj7Do+YOM/ie
	rJ4doRGL7VAOISr4/KA==
X-Received: by 2002:a05:620a:d88:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e62a0e4ff5mr305361785a.5.1753360618056;
        Thu, 24 Jul 2025 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtobSdcxMw45bMRgVyfiSZ4iD7n9YDnCcddnf4qk7/DbB2ZWWg10WQWjbeX0X1bWYDwrezTw==
X-Received: by 2002:a05:620a:d88:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e62a0e4ff5mr305359385a.5.1753360617552;
        Thu, 24 Jul 2025 05:36:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c496eefsm108992066b.25.2025.07.24.05.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:36:53 -0700 (PDT)
Message-ID: <9884efc6-c6c5-49f1-b582-55bba8397521@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NSBTYWx0ZWRfX03mVCy4vqXc6
 8MEw6g16qy4DpLsX/wN9GjXB+73yU41KlGnLvU64a32ZGkdoSSiMxvr1XTPyLHneKYtnzpvePHz
 38FfeRUQB6LRRz9X+GIJ2R9BihjkcL/ntOoCIPTg4RBLBBnDJrp7//GlwrI+umfHl4El9SDoUtK
 jCNDWpnfRU18L2fYZrv/oFug93hFz6oSUciFRHmP3k+zF2oOdBLLFMs0GS/iRCqQ9qIzS373VUi
 FEmPq+vuIuKA62y36mWB/h6A5zz6Vae2hdPNKjni7DJOWpw9ICzU6BfNUbEC5P7DjdqfzSAvkhH
 HoreHZUdyJXFtBIfRGQJojemeaxLnymG3kCc+PQ00RuR1ygnh4qTq9Fr/e0kkYi79wMgIUYQWra
 fO+7vXHUr6fLFpJgD8aLRXSoOebvdgVUCkoMyO+4EEn1Ho8GpffWqh1zSyI9of665oktTFG6
X-Proofpoint-ORIG-GUID: xHhbTrMSRrnNtkIlfMwJ4rC4D7b3zbks
X-Proofpoint-GUID: xHhbTrMSRrnNtkIlfMwJ4rC4D7b3zbks
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688228ea cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1ihfflFO6Zl3b22XxKoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=986 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240095

On 7/23/25 12:22 PM, Miguel Ojeda wrote:
> On Tue, Jul 22, 2025 at 11:14 PM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> icc_path is in essence very similar to `struct clk`, so the newly
>> propsed bindings are understandably based on the corresponding
>> common_clk module.
>> This is the interconnect consumer part, with the corresponding ICC
>> provider changes coming in some near future.
>>
>> I attached a sample driver making use of these, to ease any testing
>> or CI work (as the title says, please don't merge it though).
> 
> Thanks!
> 
> The usual two main questions for new abstractions are whether the
> maintainers of the C side want to see this happen (and how will it be
> maintained etc.) and what users of the abstractions are expected
> upstream.

I haven't talked to Georgi about this. I can volunteer for
code-janitoring, but as you can tell I'll still need your oversight

Regarding the users, I don't have any specific promises on a consumer
of these abstractions in a short term, although the ICC API is rather
common (especially across the major arm-based SoCs), so it shouldn't be
long before someone needs it.

Konrad

> 
> For the first part, some subsystems prefer to maintain it themselves,
> others prefer to have someone else lead a separate sub-entry in
> `MAINTAINERS` (e.g. "... [RUST]"), possibly with its own branch too.
> 
> Cheers,
> Miguel

