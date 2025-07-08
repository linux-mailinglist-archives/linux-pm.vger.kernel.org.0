Return-Path: <linux-pm+bounces-30366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99080AFCB2A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2471887A62
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873802DC34C;
	Tue,  8 Jul 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3kZ1y6+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BD2D9EDB
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979595; cv=none; b=jUmeWwPdJ2bl9YfLlqjTATVhSHIgAHG7YIl+/J6CXlK9FrnQGPLbSsyxMXEZW8CY0j5a3qhe4KecSP+zumTDkTMCfz8aubMSYPYaoa0nN7wg38lIZwlt4k69fp46IafOXcBwZ81nXn+n4sSMpqgJhlG0i7+RYvcm/I4EEiRjuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979595; c=relaxed/simple;
	bh=orTMmSyNbnUzuFP0Q7e5Izz0mU8u5v8F0gBzLpHJ0wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbMRFQNIRK3Yedru4kU5RBbkGk+JV2OLrzREK3cqhZLudTeLumrivIuhQLcrbctstNt79KLxMs/SaN94VWNm8icnEgFg3+fP5ZTPB5Sckdr0D6R0Yffx1x8xuICBbhwPQOsTDorl51ryLwYxtJIArzgstHNQ7FGd4E8pT3HHWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3kZ1y6+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAXYA029148
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 12:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KHC6JKuoqLCmEa3XL9EUZYEa6oZuv2TGka1KS57uh1o=; b=A3kZ1y6+GzGgLxfE
	teDVcTwRy7+O6oKsQ8ysmAmzskILEuqu/7lZgTrsG+BwGdvHUujbZIsTYdSVn+Eu
	Ya2FJsXNi6LrAdUCoqk0QYQrjdxBJXZKmHCLOftBqIT7MjHZQ7B0AIa3xFgMa23C
	98sqwDynDBpdeu/IVvL5Ewo2CrJkbmkWhRwAmwRTwpyB4s8+5sl3NrmglgbzKtyu
	gJJysYsKkBFo7LyIuThfIIRywm/6KTpe3F3olppKDzrYFjxWwuG+bPE3sO5F236E
	CEzlu6agR9wCLmppRxHVVCx+OWQ4IzS0ZWw84s8D1FspS1Qoya3pW+Ud3eo/UPdf
	2t4E3w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2b5pxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 12:59:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a43924a1bcso7690461cf.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 05:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979592; x=1752584392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHC6JKuoqLCmEa3XL9EUZYEa6oZuv2TGka1KS57uh1o=;
        b=pMNRzduRCU18UayRulCi/CKJpv1ufxSSS0xOhZSfe4KQ+gi+xpM+K9RsbCFPvmFlBk
         mj33Qz8lhuUgUdtwONfYiUjZHeTH5OZmeOx7kMUamTrMjNLjV19ACrW3XZntN4TvJDl4
         M4bayh8tkYCv2qsZKz+UjD989du+gJ/YikGc/Ddm3FA00k0PjYAxNsmVStqd+AJAx2Gn
         7K0DRNOntXZ+Mdo2Nf7kJNdPXpTVUENwGX82Y+Y7N92anrv3vmQx7+6SOVNm1K30aRJV
         qsuXmJRZNplkdIYRkBDLlyjbHi+MI6x0NI5XuVKmky30FqjtptekriP7fTDVIrqJTk43
         Ot/g==
X-Forwarded-Encrypted: i=1; AJvYcCWeU3bfus1giy88Trd93NfNEE0fFmnizNCfIck89oCuA6WHQwdE1g3S4pIXerV9HmzW5s6GtWxnHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjXXQX75eWGUinhr0gcRdydET7QJ5sofLrvCujAOAJohtjrR+
	vKyQeEPEuMfzpnU1ZjF8a55A1HwJymZdgvOSAtYP2gArmurJbLy2ojLul9j8CChnA0Y90XSFkwa
	JO3H+6k5TW3nvEICylF4BwKsTdcFalmC+EeUfNealiCUo6efx5X6OBvb6GhcLrg==
X-Gm-Gg: ASbGncv+7wGT7NC1Fi1apeRNrg8roXd1C4p9hP128xP+M1kniI/z8pcm7nb3Cy/RWj1
	pP8nz62SobMsBCBez61uDzjJ3SzL24N4FcO4ttXmjOhnRjXrAOJwtV9vY3JAIu1abbB/ZhnVHpl
	1SojcaeCp/ndxuzTLsQVW34qmv6lA8PwguBOU4kOl/Pp1CJKMqaaYM3BTsx8Rak6Ev4Ln9Ht8Jo
	jyLQrm0EE52wAKqfAIr1q27OkHXDBDK1ZkrHvZLm5JgZRExbod0CsWuSLCpDbarlO0jCDDCJsl0
	UKj6Enbgk5rejoPPIVIhcscXch6n5fKbJ5U0CRHspYorBPRJNb6r9kQUp+xy4D91JDg1gnntJDn
	w+3c=
X-Received: by 2002:a05:622a:58c5:b0:475:1c59:1748 with SMTP id d75a77b69052e-4a9977451a6mr100569121cf.11.1751979591971;
        Tue, 08 Jul 2025 05:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGpMtDCSDvrmPqDsjhCiPEDYaKFNY7K8YHnf9+piru8qyLOVRyTkfkXiQKQuqfvq78x5rumg==
X-Received: by 2002:a05:622a:58c5:b0:475:1c59:1748 with SMTP id d75a77b69052e-4a9977451a6mr100568791cf.11.1751979591382;
        Tue, 08 Jul 2025 05:59:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac547fsm877173366b.89.2025.07.08.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:59:50 -0700 (PDT)
Message-ID: <0c30f2e8-bdec-4694-812f-c792703563fb@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 14:59:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] interconnect: qcom: sc8280xp: specify num_links
 for qnm_a1noc_cfg
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-1-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-1-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOCBTYWx0ZWRfX3zO9kNrMb/Al
 IeCeE1jE3k0TBKHj3yIHvRA0EUQMAmobdBOTcH9OZXsefA/dL47fEIpvR9pah/AmtMKZvZ4YyBz
 dn6zjU3LaDcC8y/SntcDeVOhuxUe7sMoN4luCf6aptttsgkRZyfebiTOfW4Soo20cMkPyisWRZj
 6eKxJEE6hsUI3MqN09yGNXenbFRbeRKY2uwbXqqprjnOS2mdMvehj8Ia7kZtlTx6H9rJnpRo3hx
 62bbfRF/ID2PXfCmfSesPtuwEA35EKPRz331lozyNO3WXM5DRboL7qf0NGaUrJmIDJr7OwdCVvu
 DMkjDAUyq5cIl2ifpmCIGDEjs4ENjB1TXarEfEwUhynL6bdwDlp7l9kZfcfXHls77Nvu2sqOiCl
 abhIyXPpwsb1x2NI7KrIPw4bwnQpxBqxaHe4citnDGL12/irBSsX6AOWN/iEAx1qa0jM54je
X-Proofpoint-ORIG-GUID: qAKKIbU8xAMFzeRbvmKNuMMYM4Mh5ir1
X-Proofpoint-GUID: qAKKIbU8xAMFzeRbvmKNuMMYM4Mh5ir1
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686d1648 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=cF7TeHIyr2-eM01_ESMA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=883 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080108

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> The qnm_a1noc_cfg declaration didn't include .num_links definition, fix
> it.
> 
> Fixes: f29dabda7917 ("interconnect: qcom: Add SC8280XP interconnect provider")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

