Return-Path: <linux-pm+bounces-29916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1048AEF7F0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961D9164285
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8372737EA;
	Tue,  1 Jul 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqFrBlPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430D1EA6F
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371848; cv=none; b=o4BGdxlSR1cNiofKvKx54RBr1TR5kAM35i23Z+PwEXIUxq6lu9Yd4oT3vm6XSDg8L+eWsOq6ADXxIAgzfRFGsakI5Pjnqu/gIYCO9efshr+BzRt3jEUEWIBETlR4nDdRCPdqr026wm0M+V57fFjlmAtLUjFS5DWqbUzNRrV8H60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371848; c=relaxed/simple;
	bh=+ZTcoZDBgfv9tgwSo5krlJwewXP9Gn+CvJCEwKMyp+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3gChZVQE2H+n8luXwF2FZbX7fWB3iIqy9AgtkTJfAJb+koLFxjnGI1gI1Y42/j/MOQJx3dxAlxyLP8bmiMvOExygPERjfr5Z7Q5jZ3OXqZwam1MDE81QGYbBfwNzt80UKvKbagzj0WqrKo/AIFJ9sIOOMebKCmsX2T+gvRBF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqFrBlPi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619oKkN002240
	for <linux-pm@vger.kernel.org>; Tue, 1 Jul 2025 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W7b4c8FAEbR26sZIDd9GjlRjW8NmHWg/e6iguo0YBys=; b=pqFrBlPioOJlzMoi
	41hkI6RiQkIUPd+reYNaF+2l4dMszIj9gs2Gt8pJgqPc+zi5y91fr5yPE+9mBe91
	eAXgI3Qu1pfXhhAG4agIrHGP5lgECx1KNf+6ehkvp2unibXmJuy0TlZH+VA+vDk3
	FgyobEtGYdnPfj/lB6GnQ63SVyxkpn7GFZvlTSYsUCHkWk+M2nZOA+5JbaVjjhVc
	A+OZwhYMpIlketjKir7i+ys7L7+g3rjiFckVN7JG5AtOyE9YbFXYL5hCCgptF1QS
	l5X0ApCTpCSjh1SI1DAiEppqP6McnlghdXrP6QCm+InEwFY1yRzbGSLIP4BjV5Rg
	un0uDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcrpj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 12:10:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a5ae436badso8177911cf.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 05:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371845; x=1751976645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7b4c8FAEbR26sZIDd9GjlRjW8NmHWg/e6iguo0YBys=;
        b=hiTYr9f1dacn/dCLWwZi4bTCktbDgsY+syxsRpqcquco3DD50gJqFpkOUI4QJ21elq
         wbSxrrX3FUpeocH7/Z9ldsJwA6F4aBc/n+kDK4aadQoHlxSZr2K1/OYc5HL57ZywD/Em
         lsgg6gzI1WdGS5iTpiEJrl+7VgYLroZbHZKdHIAD0hb5dyqhoeFDeDyT+Gn6RoPfUGbw
         kfyziFRDSXdP3UnJiL1nPpgfKZYZTFkj45QTJ20CoI9aZDIypwpN6QsYbY7te+EA2pFj
         Ww6SsWW32s68bZJXZKH88wlOABts6odNQOSG9beme+w3175LkBSbrIJ6L9Hbh5NeO/+x
         QO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMDzUIS+bAq36ZNc4iX/3eugIxQRGZlgAVM2e2GT8d/qmpGuYbEgjxMqqNdwsIzdzCy70BgAOf6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlgrmh2h8tP3m9vCEGAFHuHSSTLgKNVShtLalga+AFYgdii4Cy
	ec6td8C47ggxalVN+0Uc2lv4xKD5Do3EL0FfD+XULLe9RQKRkBHgRQuokBTFsqFLUPngoA8KjUs
	YhIbl2Lj9RZaBfBapwlypO68Qoevosx12L9ZG6XZnpAuTALpNX5XVtD3Ix1rk5A==
X-Gm-Gg: ASbGnctQfhoCvOkGv47iPjLvlGAjvn/f3E5c1w59kbWqgatupQGlEgvTlMBumx4GgPG
	CRUq2q1Pa/WhK9S6QGPjc1u7EZ0HOG57dwSKF2J9kM0rNdy8+7PUGTS7Gu8Z18asA/apnLBSZUL
	dgntHIJ9IApu0mpbXJ1+y5NufCN5Q8ncpGl1OW7Wc/A/jwNBdC8jHjdwdJ1YnbGNaObwKscV/yh
	vpiBfhUZ43mM0xfCPnkMmEdRy9kx+pNDYC5S+u6O+wonDrBFNkYPFODkArQNaP2hiUP2xhWpn7i
	FQanwJRPRKU/aaGHieV7PXCK5EiilEwm7E4eyptmyl3QBVDaBob86I9E1csZ9u54GS5x29mqfjP
	t5HHLcjaV
X-Received: by 2002:a05:620a:3710:b0:7c0:bc63:7b73 with SMTP id af79cd13be357-7d46774f6eamr146983885a.13.1751371844186;
        Tue, 01 Jul 2025 05:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTxzbx67vZnwclq62QSQMEsaHBiUQUi2s3v5N3dbE7nNpEwja0y/5s43uax9D/Bfc+SnBykA==
X-Received: by 2002:a05:620a:3710:b0:7c0:bc63:7b73 with SMTP id af79cd13be357-7d46774f6eamr146979885a.13.1751371843303;
        Tue, 01 Jul 2025 05:10:43 -0700 (PDT)
Received: from [192.168.1.114] (83.9.29.190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1619sm854280966b.149.2025.07.01.05.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:10:42 -0700 (PDT)
Message-ID: <a873f197-1ad6-4a7a-ba66-5fef10f32c57@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:10:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
 <cd6f018d-5653-47d8-abd2-a13f780eb38f@oss.qualcomm.com>
 <db1d07f4-f87d-403a-9ab3-bf8e5b9465b3@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <db1d07f4-f87d-403a-9ab3-bf8e5b9465b3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4d43WGB9jVbZ5XNn4SpuKxr54m9lcCiZ
X-Proofpoint-ORIG-GUID: 4d43WGB9jVbZ5XNn4SpuKxr54m9lcCiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3NiBTYWx0ZWRfXyEpzOtju2rP8
 jM1WFzDr8QXMWL9fwuFQOKKsjYXUjqV7k8xncCWpN9m3qTZxEwEnQSNHbgSkA1+T4W9RgxGEUob
 KQL7eSs8T4CyLkZO6PrbVlEs/09+hTUsURGzJJBIrrYaGrxEvLAMzw4108EDbL48K3pIciZeExA
 dlxQa/TA16g2dvVgl+42ot7/Eemdh4gTcbdNlr3fPf6qUcDQ2iz+F5+Gl0lpbwaTjq/QJ6cWIJr
 7Ml9niHVY+SLn4VQbCcvDwDMp4JVJ7+4aOjMCS4Wnq77XVBvooTydP8XoXS219E0Xt6fwGXsA1x
 sFi6OSoMwrj8fw6pUz1v7WO6YyGDzxD/ScYdD5sihS25HdSSLaS16W/P9Mc5isY4jvMlSLcFPoi
 0sLAUWLd9CR1JFhyrbJWNsH+D7DC8oCVXPIzF69jeQtwybAIMzRGpGWojuRbohHydl1spc4h
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6863d046 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=fKQzr7EGRj+VoE0XNsDNvQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ovtazKSSlfofSAFZHdsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010076



On 01-Jul-25 14:08, Luo Jie wrote:
> 
> 
> On 6/28/2025 12:27 AM, Konrad Dybcio wrote:
>> On 6/27/25 2:09 PM, Luo Jie wrote:
>>> NSS clock controller provides the clocks and resets to the networking
>>> hardware blocks on the IPQ5424, such as PPE (Packet Process Engine) and
>>> UNIPHY (PCS) blocks.
>>>
>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5424.dtsi | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>>> index 2eea8a078595..eb4aa778269c 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>>> @@ -730,6 +730,36 @@ frame@f42d000 {
>>>               };
>>>           };
>>>   +        clock-controller@39b00000 {
>>> +            compatible = "qcom,ipq5424-nsscc";
>>> +            reg = <0 0x39b00000 0 0x800>;
>>
>> size = 0x100_000
>>
>> with that:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Konrad
> 
> I initially thought that a block size of 0x800 would be sufficient, as
> it covers the maximum address range needed for the clock configurations.
> However, the NSS clock controller block actually occupies an address
> range of 0x80000. I will update this to 0x80000 in the next version.
> Thank you for your feedback.

0x80_000 excludes the wrapper region. Please mark it as the entire
0x100_000 that it occupies, no matter if there's anything in there

Konrad

