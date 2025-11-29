Return-Path: <linux-pm+bounces-38909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4467BC93634
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B969234927D
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9E1C84A2;
	Sat, 29 Nov 2025 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abUeTG8H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBWWed8y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A73D994
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764380212; cv=none; b=SmIge3raAzVVVvIeO1nvoCYI/GYGI34K0bkMCeQ1Rl3bgGJu2s8Z3hR/AzLrN1WY06n7sfdA1fBfJKmA8VantMO29GQ3IOnoKiFRw1CA9kDZe4ZrsAKn51pfi33USYT5BbjBR7rHlcByqnl7WpAFKJylid2CCWwIDKHIgrrbllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764380212; c=relaxed/simple;
	bh=U0yCnpzZCRxKiNCq7FmevgdBBGUY29V3tCizS+IJwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFPk6ccApbxSwEpdVMGBnM5a1lGHh5MSBZ+XLBkv73tdb0roVkIWhfS3moEtr3T4q2iINdpcCj870WANvY9ONicnQJc/onwV5BI9Jg7/wbdoNlOT3iBfHiM5X7UwMHmMYli5PmaYjFGdT2FmsmY0I8FhXvOPY8153UoYtUHJTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abUeTG8H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBWWed8y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ASH6T3U4089678
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufm9gNwR0cbLZ1GXX2qw+EFYjvpWMB5Aesn6FOAhg9Y=; b=abUeTG8H7TdMjz37
	3Z3ph895DD/EPZ/j9oqIjDYjUSjXCtEFoK0tg/wG92woyJwoUNf9jN6JmAna5aGM
	dvfpHfILTIK1DqCunWEMRLteLZi48Vf710LOzn1Uhn3XHKR+raHI481SnhmrD778
	OpHkINc2bN1usctJA6IwIvBK+0mXREkP2YpbZIVTR1I7hgn06CuTnhRum7eeIxP2
	YcqVSpBBjNLgZoJcP07E5V024EVE9l2Z7CHZp0kRGivnE+6QQ3v1Z9qyiTE89Cu/
	kzK9yTCEmHr3Xgpez0BETfBIoa4bu3sn2ZjqFDk7bsHbG8b3uyNh1EDfpURm81DX
	cYIseQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqfuj0r53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:36:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so407286785a.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764380209; x=1764985009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufm9gNwR0cbLZ1GXX2qw+EFYjvpWMB5Aesn6FOAhg9Y=;
        b=IBWWed8yO9ZjWZPE9PAUzyiyBPxl5oAz0IuIQcLFLLWV0jJY/RxpQp9ITYFXYS6/+Z
         mWCzpsY965QtY746o4w0DzaTVPeZNPudAiTKC7EEVbyF7qGRS9PTdFxIoceaHmfwryJH
         uOyzE89NCVVxE8urzqA+OwejQk+pMCeNya6mFu0zg3IdOVuBa30IaruyvTi2509KAf4/
         CQFCIHds5SnrwNY6kskc57O8htlQ+JaRz6VXOb6G8tZ/V8iuBsklteuEYDTCuogE9AcR
         vBDUVgBzP92UdWQfLT7svGxVO94UaOJ3l7EhN6ktG8mngHfHEnfkTOHGrqRkM3KTJ0ed
         ru7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764380209; x=1764985009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufm9gNwR0cbLZ1GXX2qw+EFYjvpWMB5Aesn6FOAhg9Y=;
        b=Jgyk1lJsW75v/qLvwaaeXSyhW9xVUnGcoyvBMlqnNfYSuLnjxt/Q6tneBgM8abNxWX
         cdDtWohF+WfR8c/ilSLz/0Rs2Tq52NgvLdg32VkP9ncaS/bwd7khXrFmF2ZX1/6BGw4C
         nx8LDWwO1lFf1KMoRtTHy7lZ+mKoN+FRIvsJoynSxumyP/gmIHjJ+HQOl+fjSZFKLyOH
         egsUNSkfOTaoPxY8ylac/jOIEBdMQvk0G915gS424NzTS6bqAsKGDyJuhvM8Khs6rruD
         XGQptF+NZgsPLzkdfrv2EQOFfzEEcTYywab5lftffGdWk0RqGLH2RS7+HtCIv9guklTm
         mFWg==
X-Forwarded-Encrypted: i=1; AJvYcCXyASws9skLuQl8QWzcB2XDR4MonVDmv/2ncbrciHhyg3W+NDsicC/gj3s0DqZ/eGGsQ0snbd/tbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRqL6V+UwUkJFl5j9tIE+7VbkPDB8SGR74ekjRZOVjL8X/04T
	yHhwg95e57MlmLlY+neRdOgtB8HkYD166z4WKlktqtW1er3Z75YuvXiMdZQN1dUP4lk108Kdnp5
	HwWrIKrmZRt9YLqSkuiOa68Zv498AzxABxNaiMrMZOCNy+DtTh6DPtyhDJx785g==
X-Gm-Gg: ASbGncvlD3LOcwb2O0bLbdjYI8CL4mvchdEA8mFwSBMpLR5Ev6bCFdR/B5To0/s8bUG
	C0gEbrrmkn8iltbwztbYh2ekDERJqpYAd3jV8WRxXN77jD5cqmHD5vq21Ujz1gdIGA5sIp1EjdP
	BSe2btaLodlu0mfQ6/ChGve8ihxvw78WXI2T8iVOAEfQcDzYcQlFk8JGcYguSiRHD5EL2mkBgU1
	OonUxfBjXqmnNmmljqTN79p8dEoNOJTuzOinLup4c200BfHDXQee5sT+HQV+ypFExAD2z6h1HE4
	6cm54CGTmJtPCBPYDltJTmsvZlXIa6xkQFR6uJWBgwJbYdjtivK6T8BXCczbB+X48KYUH+CbhHg
	kVOtQbA4zaMLcNyWzHppmzUJ1eTzJGi8bUDc9adwwsK5pNlsYjq1dpXdBwlmZpGtGWGgXuMPcmu
	P9dGkL5UUMZ9hLRZdYTTbhd2I=
X-Received: by 2002:a05:620a:2905:b0:8b2:f102:b8ec with SMTP id af79cd13be357-8b33d23b35amr3912681185a.16.1764380208664;
        Fri, 28 Nov 2025 17:36:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX8UWXjjxghID0A8tsRWFi7bqv/pri9KP5RoM5dGN+bsSvpyGRIIwkVgB8OmzgubO60PJPug==
X-Received: by 2002:a05:620a:2905:b0:8b2:f102:b8ec with SMTP id af79cd13be357-8b33d23b35amr3912676885a.16.1764380208138;
        Fri, 28 Nov 2025 17:36:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236b5b61sm13421801fa.11.2025.11.28.17.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 17:36:46 -0800 (PST)
Date: Sat, 29 Nov 2025 03:36:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joel Selvaraj <foss@joelselvaraj.com>
Cc: david@ixit.cz, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] power: supply: Add driver for Qualcomm PMI8998
 fuel gauge
Message-ID: <f4hlaj3pp2vuczwbjkhxmbncdpgjx56l4oqoa3r5v5g2txjpzo@tdhqd2hrmfyl>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-2-dd3791f61478@ixit.cz>
 <jddpwqo4f4irukwc725b3c5dmsitjgupcvupvbe7fom7vx2p6r@ilfmls4fzrn7>
 <af0e5a39-a4e7-4deb-b915-97a1d9bea19c@joelselvaraj.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af0e5a39-a4e7-4deb-b915-97a1d9bea19c@joelselvaraj.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxMCBTYWx0ZWRfX+pXqzi9h85Kv
 ODF5TvJYuRa3Vftl1a28tBZeveTsJyzz3aZjMNAb4NAQeU/Dgf5udLleRfW8TyCQFCMWCzV/38+
 KyYPaas9792nHt3UAxn3tPvyh+N8rKT6m6wEukxW2Oc0I/cqeNdxSWR9D7mbTWmxN1Qrssq0ajL
 eigF2C6jCYUujyBzCeDCWwXtKSJIXIqqrOR0faYboY4JMaB2/hPVcTF3lkCbOsGppahb5BqK+MC
 y7DzarcZMu/grJ1YjBOlMT/Sdy1pmvuaiNBN2TbE0KvVkinxhPD4xWKZ01n3VEJMTA1QyrbJxAc
 CTa39GV/hpgowyJ9KemAoMFaedbs6HkPb4IuUx8eUaJcZjhf/zR9Mx8aGcoaOXvTM9be/ntFN3q
 WJ1gHIALzZ1ExTLSwMURs0lZ3limdw==
X-Authority-Analysis: v=2.4 cv=GupPO01C c=1 sm=1 tr=0 ts=692a4e31 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=OuZLqq7tAAAA:8 a=sfOm8-O8AAAA:8 a=QmoCL596_DriJ9MmrNoA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=MZguhEFr_PtxzKXayD1K:22 a=AKGiAy9iJ-JzxKVHQNES:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: v1enHCejGZNBXrjBPI8hbsW0Ktl1oG8g
X-Proofpoint-ORIG-GUID: v1enHCejGZNBXrjBPI8hbsW0Ktl1oG8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511290010

On Wed, Nov 26, 2025 at 04:35:09PM +0000, Joel Selvaraj wrote:
> Hi David,
> 
> On 11/25/25 5:13 PM, Dmitry Baryshkov wrote:
> > On Mon, Nov 24, 2025 at 10:53:35PM +0100, David Heidelberg via B4 Relay wrote:
> >> From: Joel Selvaraj <foss@joelselvaraj.com>
> >>
> >> Ths driver supports the fuel gauge hardware available on PMICs known as
> >> 3rd generation fuel gauge hardware available on PMI8998.
> >>
> >> Co-developed-by: Casey Connolly <casey@connolly.tech>
> >> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> >> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> >> Co-developed-by: Yassine Oudjana <y.oudjana@protonmail.com>
> >> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> >> Signed-off-by: David Heidelberg <david@ixit.cz>
> > 
> > This can't be applied, there is no author's (Joel Selvaraj) SoB.
> 
> Here is my signed-off-by. You can include them in future revisions.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>

Thanks!

-- 
With best wishes
Dmitry

