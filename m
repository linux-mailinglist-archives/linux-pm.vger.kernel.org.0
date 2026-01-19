Return-Path: <linux-pm+bounces-41080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F7D3A4BC
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 11:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78E33008C9A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D62D0602;
	Mon, 19 Jan 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pc7OpXMg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JC32BVbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9922C21FF
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818037; cv=none; b=a1ve9Qb0OoNhXzH4HbbCgMYwlcS4YSs9xeZRLP4odklGlZwarwSDE4a1PllttsQAcYEqE9Myc57sRp0yuni4WjRiAL+5wmqGW3bQm5FJ0Mfk3IOMvELz2FggNMYFkVKEy3bO7NErUR4PwUwvGi8JJjJXtp5F8hfS1KYkNS4TITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818037; c=relaxed/simple;
	bh=jDRr6kmHAys4oUmsNHtyBLQBUWiM63bBvhzgLklUZ3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMCC1E+8kCPGaMv4WoEbXvFFUfnyIlNYhojKGkxRu3UhEIItN1RHfEH6jonC0BNS4hYDeHDhjqD9TjOcgNsMM6NAiVSEA7bAitw2QRdauV/vz5Uwzc3O1Bk82/KMpIlwuRMz9VBDltrGkGYQPiz4xugcGoAuRzjF62veoZ9t7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pc7OpXMg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JC32BVbH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J91DDh1150112
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0E3blSa0Xy96fLcU3N+wYkSyzyfL00o3BG9stgU+hDw=; b=Pc7OpXMg9hd0phAT
	9HcuNYyvZi2XEfvxR+88VhV8eiy+C0iKYk1oeAgY8RsFf5Xj3FsGOSNEWh58QhK+
	5mwRsIvmH8W6fxXyoCYWr03Az3K51RKiTdcb7N65dCAXd0V4JL39myoTOYjgVm5d
	25umukQHJu1Ua+KRX2kHvcEXkoWme6RLRfM1k1lWqNOw0ImJ2iyxtevyJgs4uTRg
	qfHDKTmqdx9Goyrljp01xJWylLccOoelsdS0meyQKdXY9eREa+2gMErlfqMO0izs
	z9s2OEHSmC2EiFWZJT4w5IU3zDZH4zaepsXVsDxYLLi8nXvYvaoplfYLoqqEV+JN
	QvoNcQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br04e5250-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:20:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c69fd0a87bso270198685a.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 02:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768818034; x=1769422834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0E3blSa0Xy96fLcU3N+wYkSyzyfL00o3BG9stgU+hDw=;
        b=JC32BVbHwGujuFX2gCMUIPG6U5FtlrtSH2ghI1mUqmXViXB17nknPuPWqCWZLqJ8V1
         MIqEEeU+Tz8shZCQaoLS59GEd9krLa9svx4THyzPWDtWuYoPBlTHSVXD2Rc9jJqOvdYh
         srvAl1qNzFUxvo29kXH+HyYSl6bsq/84h8iWIK26nSW7fqPqR5ZLKd8pqxgdGZ8Cl3GA
         NJyTi59jMk75tuI5pwpFkAzq7kLWAxMlHW1Fcd/90nepBtYB0KS96AE3hYOrIi57MvY4
         Zx2oT8IIFT/qp4+XtvIGFqgx7gGET2CUJMvfJ4rFqihsDcZ1uqVdiuYfUrQQ+Ww19SOF
         AM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818034; x=1769422834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0E3blSa0Xy96fLcU3N+wYkSyzyfL00o3BG9stgU+hDw=;
        b=R8qFTAjbx6chf7Dp/TzmC0W6RfLhFw2D+eGPBhOAwWr6t2rOZnyOXJpXDV0blBThfz
         EiVWtuuzRE5WljnduSpatNo7NSZxoHZp87NcnQWdguZsj19mBW4vjf7EilRHfiStBBMe
         OMSVIs2550a9SjJNmu7G/A1SJIODpTQZ8O2I7+QpOCEZOp2FwFY/2GdMQtckI0EziRS/
         s3fw3WOprIxI3nG4DlaI+cLoBfBWHuNrHW4R1gXQ/P4izLXT2k9ZB0mfN8ppns4NA8Lr
         xrUxoaP0y+TKiEr5Lra+fmYPv/HtaJyfwTZiIhNHhj1vPItpGRIkcz7tN5SIzHq0IpqH
         d4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYaHM9JwJ0Bj2J+XgNQZUmh7cMg1d2HHB+18SGcQxAQnFAh6oLNonNrAFuSBU4tCseuu9lI2pSiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8jc1Eh76Nc81qbeUsv6pRQargYRhF/uQng6KXhoC9g9RrSZs
	ZajKv5x9gGHD0PTvBmOJhW5yap3IhpkF6YVerm8fB6+M9flvGPrCHGowMpcwN6MQ4pNPU9o9mA+
	HbO/FKyQwYYNKbyyOlr8xzDm1AxgSWKcZx6V+EWsgZP7eVTmDrqPp8wxIEo52vQ==
X-Gm-Gg: AY/fxX74kyHzDtYPQjDxFDy9SF0stlNop3Hgq3IUU7Qcc3GuhfTzpAIB0vAoUajouQC
	uvx5U5B7QlVhALJBuJw7/DTHNfMTyjduDFShM+Fs/Yt/K0ts7+C5yIqL+Ov318PaC/02+nM/COL
	VGVjWUYgC8UYN+CO37m7qJU4WvRHoNe63K9RVDRvVkxVSxtW64iYBmBUP0t1rN8pfStMgpN7pXU
	39rjRgY+O6rN9b39Q2H66G3jal2+7TVsSDOqTW/gQi5GAz+gRaDEOfQ9gusxSShseAxn4YJ/fLQ
	tyHCp0TnmhuMHP72/yohkPZQwCfzvXrqzR1k+E+f66xnmCDC1kyZ+koRVrTKEFwdvSL5SSznpIW
	w6Ro6rHGvwT65zsPpaN1lHjOIRf2Gfw==
X-Received: by 2002:a05:622a:508:b0:502:9ed4:eea3 with SMTP id d75a77b69052e-502a1676d4fmr126140931cf.9.1768818033717;
        Mon, 19 Jan 2026 02:20:33 -0800 (PST)
X-Received: by 2002:a05:622a:508:b0:502:9ed4:eea3 with SMTP id d75a77b69052e-502a1676d4fmr126140791cf.9.1768818033291;
        Mon, 19 Jan 2026 02:20:33 -0800 (PST)
Received: from [192.168.119.254] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce433sm9961316a12.3.2026.01.19.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 02:20:32 -0800 (PST)
Message-ID: <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 11:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260117-efficient-fractal-sloth-aaf7c2@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=696e0572 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WxS9-qz5E8wbYe8Hv_wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4NSBTYWx0ZWRfX/mdSGHciBm6x
 QIvMih9l9ivJbVWT+9ry1fcfiCe2jv73CgDFx9q6HLB70d13qIep750vEuJYTWsz460HR51qW1m
 XdXiK5d1uZodsKPtqRiWgbhgdFmv0N2neYchlVi2F+RAdexvT3zQxcgur71dNA+qvu2YgdbwD8k
 ugu55+N/JkKXASB2EL8Y+ZlwqlOSzBnweFkTEgt9CzxzLe/ohEMWyxT+cpar28bj6e4XH3Nqdve
 GiAYhewh1fz37N0zAG1fBbJbFy64Jl50pxa/gJ6zOxoQBgJKKI0/TzF+B3/Jy5wGE1f5bLWTmAD
 nVszSjlrm7gGG6GSZq6jX2MjnVZZtqsmQupE2ETXmuY6W8RFjKMGOxroHQWxv6CSGJxzq56tgF5
 xmD0cyoL2NJLSOi1vxjdpbg5SjexJCKaCGeY2YHQY8McYCGjLpDTuE3CQ9QjWNpRzoBXiFG5Nlp
 Tk8gyaU0BDDc5aC04gQ==
X-Proofpoint-GUID: g8seZb_hWfaOqhe6n6pXwwWq4hnWZNaQ
X-Proofpoint-ORIG-GUID: g8seZb_hWfaOqhe6n6pXwwWq4hnWZNaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190085

On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
>> Document an interconnect path for camcc that's required to enable
>> the CAMSS_TOP_GDSC power domain.
> 
> I find it confusing. Enabling GDSC power domains is done via power
> domains, not via interconnects. Do not represent power domains as
> interconnects, it's something completely different.

The name of the power domains is CAMSS_TOP_GDSC (seems you misread)

For the power domain to successfully turn on, the MNoC needs to be
turned on (empirical evidence). The way to do it is to request a
nonzero vote on this interconnect path

(presumably because the GDSC or its invisible providers require
something connected over that bus to carry out their enable sequences).

Taniya should be able to explain in more detail

Konrad

