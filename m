Return-Path: <linux-pm+bounces-25674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2261A92C8A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FDD1B65396
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103D20A5CA;
	Thu, 17 Apr 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXgG5wCa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF020A5F5
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924250; cv=none; b=mZmbwv2TG8hlwjFEflyIZI3PYWb87NDkRVEyykPmXarviM43LgV55lb/jAc4lmmEBHC1Mb1624dSwlzOg/fhjAPLCm1iRw/1Jeuck08XQnfBGNSHF4XzDf4ia4WqaeCtJ4U8OWZMOZJMnoI7H+M15lqx3XcWKdNmsdP1pvYpGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924250; c=relaxed/simple;
	bh=zayiWsGQgbypU+9CEl1xh662ru7a7m6M637EKU98BmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFA62UZJMU8YSnqGdw6F6PIr6ourFVP59eGlMZIJIvKgAeV8wfPDES2+4vogyDq1DxEp1RDC1FBqZ5JDJjVVI4E8EZaO+D2ircO5V2TjJLg80O5I9MuHQ5kER22dlwbEX9Kj7kqfOWieHZJ4WW7nUmpukaiZB8UbuYdKYLpM15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXgG5wCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClVhv014447
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 21:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W7BgY9XqHUX3hFGnIp/2PCnU9QUDjev+cgR8XFlagS0=; b=jXgG5wCabCGSAiOy
	y5Ofsvz26d37XCFhUVZm4qHe6aDKHsYrFWya6puT0zDqjq/NIg+QnBZ+bAWhVzum
	oKpuqFP114+RO3uU/snSjBF++Pnli03emu9X/G3Qt23AATbP7Jkb0pQEkw6dAJA9
	QakHLlboP/o08WcF75SHPIUKxvdYcw10ErPIKP3p2VYYp3l4Kmjhb2diW6DYLcsr
	+Hsh5dtLYsfEgGlN3NPAe8ED36VbBXBhCUcKLURqmE4DXk85tzv9PxUIyx18tGQ5
	eB0ihiLw4smVlmfQffTJb3zXeaNGdENTbaSYDVakMDqgev1du3GqyPSihspHandq
	AUexxg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1g45p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 21:10:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4775bdbcdc3so3184301cf.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924233; x=1745529033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7BgY9XqHUX3hFGnIp/2PCnU9QUDjev+cgR8XFlagS0=;
        b=wQtGs/j+IG6xNPIpBKDYkMizYfQk0yHMAZLyORLZ8nb+H7d2mvMfh92cOAJ2jO0G1b
         RaSA0LA8ytp2kZfLv6Cip7ljKEQptWlgg8bQI2VDrGdxH1XfuovQlaxzPjBQQTSbqUYt
         t/Gy2eR0eMtOo+06FOSyjoGB4WtTFWILUB9y+d1oA1m9VZ3lJiGFEqHrb1vXBqmEq3uc
         MHqXq6zkst9lBQVcNeWsMa9q5XL/MMwuZG2KwQ0Z2yxCvKg2e1SuMM7RM+JC+E3ZZGOJ
         HwgAnY+37GaMtNRO787IJOM7dGV55JfXekNbRTaHIAohy5N/1+PEVM1MG8FYg5fv/D6D
         3h1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+K2X3MG215leWkJ+EBCeRC6Tg5vckm+7JbwakZ8CRlskG7pSnJBO7sH3TSLRUSnUsqhD6PEn1Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK5fsZNfoAMtM6ACjzMSkHG3AQwXo+wwZbhpOWswyo4lqRe3E
	yoR757Xlwf67WBesj80KR9GWyUsBW4WCqFkKh3K+KIzczcHfjdwtAJHdae1RMUEbTL7Xj34Nagb
	zGnlmMTg0MEzJ30yL//timJNyiVspSnQkOKNMUWNjsb5Fg+C49IHC0Gn7sw==
X-Gm-Gg: ASbGnctiyF+oC4e0iO24ClSwqXNZf3HVEvu1QjU3PIqZcqPclnIFEyZOBw1bOq2KE1f
	WtE+fTNuhcjsckCGMb7yrcFNKMDBdxSSKqZ3iUhFyPRAQLtT3ZkG/K9/DZeXV2qh9V+ojbiBimY
	SsswlVo/l/uTfrgbaqStXuZD1tZo6oi54cej6v/UAoXLHLcSNHWzCdS+obEhmkT2NivXAkhxKDn
	wH8xGr7SRoNYmzJJLn8eoTHDCUjpJ3mCw9hCrlA60xQstMptduqW3wF89x+4J+pe83r/sQr0xhJ
	Dw1243YSAumnJlSvTylG3ADmtS00BhJX4L7h8xsSRAArc69tCafYNOcJOUQoxlGAzg==
X-Received: by 2002:a05:6214:4002:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6f2c455d583mr3156436d6.5.1744924232779;
        Thu, 17 Apr 2025 14:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKtWdxfBKZ2i3dNXJvyLNKutWRDck70NGeLsfxcSiel5Fprx2Taw91T8qGaP9AVoaybDiI2g==
X-Received: by 2002:a05:6214:4002:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6f2c455d583mr3156306d6.5.1744924232396;
        Thu, 17 Apr 2025 14:10:32 -0700 (PDT)
Received: from [192.168.65.58] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec10ed0sm39494266b.36.2025.04.17.14.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 14:10:31 -0700 (PDT)
Message-ID: <5fa5cade-fefd-486d-b1a7-622f3677c74f@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 23:10:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pmdomain: qcom: rpmhpd: Add SM4450 power domains
To: Ajit Pandey <quic_ajipan@quicinc.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
 <20250417-sm4450_rpmhpd-v1-2-361846750d3a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250417-sm4450_rpmhpd-v1-2-361846750d3a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68016e58 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=h62wbvEV51DO9j2QOb4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: erWVMFkwTKu-Ric6usfEcl8VKGfj7uSN
X-Proofpoint-ORIG-GUID: erWVMFkwTKu-Ric6usfEcl8VKGfj7uSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170156

On 4/17/25 7:07 PM, Ajit Pandey wrote:
> Add power domains exposed by RPMh in the Qualcomm SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index dfd0f80154e49d882a59dd23a8e2d755610c896b..078323b85b5648e33dd89e08cf31bdc5ab76d553 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -360,6 +360,21 @@ static const struct rpmhpd_desc sdx75_desc = {
>  	.num_pds = ARRAY_SIZE(sdx75_rpmhpds),
>  };
>  
> +/* SM4450 RPMH powerdomains */
> +static struct rpmhpd *sm4450_rpmhpds[] = {
> +	[RPMHPD_CX] = &cx,
> +	[RPMHPD_CX_AO] = &cx_ao,
> +	[RPMHPD_EBI] = &ebi,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MSS] = &mss,
> +	[RPMHPD_MX] = &mx,
> +};

/me wipes glasses

Is there no VDD_GFX?

Konrad

