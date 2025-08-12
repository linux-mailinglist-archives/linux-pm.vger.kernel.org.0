Return-Path: <linux-pm+bounces-32218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D5FB223B2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014653A6C68
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BD2D5432;
	Tue, 12 Aug 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mg6n//dN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8420264628
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992319; cv=none; b=Z5AbqID1hdysYYiBNl82ceaA59vZVLi5JrnfVhz2gzWeti4xyc6Vc+UGU/nY7kpwLSKB9+Ybnq9AezJ1o+IWFPJdPuxrYCthp5oAe+pCRLgza/ZUNaGl94dRT2o/MiYQ9HIJhKPUpaI71lvrKVVFlopJNbWFbdnd3zSiTOPbADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992319; c=relaxed/simple;
	bh=jd+E5iukvLUB/eB2TM0K/oVyyoLawcNM8WFyG7kRj8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMIvqh1rbBjUE8IP0jGV4TJ0g7Kc0K8fQ9LrkIz0LY6WW1JZutwc9I3yDPFcgBAK9RusFTE7tKneuuSsb9S7X8aM0CuQHKIKTCZOqCknK7DZYNjGKeaJIrqz54gFupiAzwG0yYmgfj+EJXSEZcE63/FSlcldLnwlbT3tDhukSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mg6n//dN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6oW0j005641
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 09:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/lSBKcNhfzLdUg9Kuw93+xqCsYQfCxwmTkPBOpkw/Mg=; b=Mg6n//dNinmh5sTO
	HqQaBWZlPKZaoxThd1ahlMB4z/w1l4XsUiJEJBlXgT9evSEifZi6+1EyDzoX9DvR
	IfPf9pkO9kgEb1LxH6e2SGYDmBEDhttHnFw+ADJPkaxuVtYu6Fyb1WloGxhBT1Y9
	LxAYr9On01J1+b3qOQv76esSlTbq9GnBANpFREBsYbwNYislGBzocVTHyBH0vi/K
	3ifCp5flG5u95S+wNNrzzFq8BfW2bwM6wYTj2BGtrPhrYSEBvq0iIAZqyA7D/hQd
	QfiqylN+WfsQQJOGg3/G9aTwU1pDlLgf9XMMwB0BJgwaCA7N3rUgB+uSj6KeyspL
	wX0i6Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6kg17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 09:51:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06ad8dadeso13513051cf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 02:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992316; x=1755597116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lSBKcNhfzLdUg9Kuw93+xqCsYQfCxwmTkPBOpkw/Mg=;
        b=w+Clen5jNkqu+28YPpX/NOGmfg+SXEgv8QLyTCRo3ukmWgn2YeI/VlM+rUkQs3+I93
         RPVFWQHVw/2vGB9Nvcb1bTRNrJk9KmKNjUv7FB/v81mOCTLQbyR0wCTz9njDFp61ip9g
         N3LcUKXaa9h0CwWiclRTOzYdgPEshkijdSPE98HcNKzXG1LSKXFqYyzrO718bTPIfmxX
         TkkdJFDe4OrZomQQlKoFz1o+SIUTAg6mp15pOyaX+gZNKBMGSe9DFyxbyd0DbQzmduqa
         jGWZnoSS5Xbhg8/zOjSxamkV7YiBZkePV7bcsTSDHnCOmVo+AIZsKbYBAu+S23AMvaSA
         mWng==
X-Forwarded-Encrypted: i=1; AJvYcCVk6zTHBG3QmN/1Q2Q1Tv5MhUISsDcC/3zNS4IassWr969Qw1VEMMwsBQPtV1AVoM4HmG/cJg5MDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vH+3ayxWK7OAtCS/xn8QaN/P7sJu9HAK33g1juX702N8ilL6
	gEkEvy3f4HusYlix0XJHso6Ea5H9riRStEPr0g3jBl89yBgovGNY+M34vHWRPTuwSpSQjttB/0w
	iwvIJzke2a2ComzudblIsKnLmmS5qKKgasJTT51M/GIEwbkg+1bG7u18OVXelZg==
X-Gm-Gg: ASbGnctHj1GnFRu2eKJ3+oMlb1DSbcikgGJ89qUtEbK20KCUAkoYxCfG+UJWo3iDDjK
	C7o4oCLJAvg0GTsjTkK6ccYQXhZpaOghDH7QmT7WKkJQ0os1CfweYEh0J8rU17q4GdFCj+iEC+x
	AkwwKNBINPpMI6F7HQvwOQl7LKmYeoDuWDcYDjLcjIS7drhq7Ajv3jVhuercg0EINfdNfVtyN0n
	yAmI/1I6az1Zr2cCUhqtBdh6mPPG4k3EMLEkZDHB2AqsWWyje5xdo7n6MZxUe4aPXvexSSCHj67
	g3ACOy+a+6CvsbDQK3W9X3ZmWfDjGJ138t8FuuX38a8ZPQiCg6vknqh35J0/GA78mFLQT+/ukYS
	Y7o1aEbTtX77FCPHJ3Q==
X-Received: by 2002:ac8:590a:0:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0f49eec04mr3747551cf.0.1754992315568;
        Tue, 12 Aug 2025 02:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMkGZ42DZIE9vi6e/XnKS20D9Bo9TKQfpGrdhAifj0KEa4CZRyyn2UFU/k80p2/ZCuRsbrfQ==
X-Received: by 2002:ac8:590a:0:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0f49eec04mr3747451cf.0.1754992315103;
        Tue, 12 Aug 2025 02:51:55 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm2219676666b.24.2025.08.12.02.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:51:54 -0700 (PDT)
Message-ID: <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX2NJ9ayfTrqhZ
 v/0xP9u97RoI1xLHlJwNOmuKdl2osaP71tSMrrRX2PyZWKmLxoolK0nZAlfpBDnkLsEW7gxidWJ
 dJ9K+5HIrDM1oKHztXLLW+ysNtm8BoRj0OUARSk+a7HjzwdlrxhHTNlaEkWr80NannzqtAtRsWT
 m0gpUT6mDWFYMK9l/JME7/eItqMELuDk8XrIeXEkpNuJcQP90PiR5293EGlY+mlzrnfaZYWY7dZ
 YjFR53d2kchjZ3Ny59vEFtd7kClYCyLd1oegj+X/M/+aB+3IgCK8g8o3JJpxaWFVZKtvgklcYTf
 cn5Lo2VpHn+9du4fnPqDtWzxvBo7/WSA01Z5I3MmOiTKN3VEyax1KGg+0XMtOx80/HGS3yJNXQV
 EA5EXIKl
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b0ebd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: BBaC0IYEf1ZwSF6ekfo6P2-L9Ua-gaHW
X-Proofpoint-ORIG-GUID: BBaC0IYEf1ZwSF6ekfo6P2-L9Ua-gaHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/8/25 4:03 PM, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

[...]

> +		system_noc: interconnect@01680000 {

stray leading zero

I also see there's a camera noc.. are these controlled internally
by Titan nowadays?

Konrad

