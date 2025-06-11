Return-Path: <linux-pm+bounces-28492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D43AD59B6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F117039F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920E01C6FF4;
	Wed, 11 Jun 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ku62Iyur"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034561DF994
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654393; cv=none; b=pPMryAJb3ax6lqopKV0RbCdmKUSSGBEi0fXphgfPEmBAqcCsl/AkHpS9MmfLbuPwBYtGiv2EU4o1BNuJ3D/VmjEypX51vgi5N1NoY18Dlhv/Sr1L5g5PowOsPwHb/sOeDmyAAXsKfXgXYgNzQAW1st5IbAn6F0uCqs13Zk7HYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654393; c=relaxed/simple;
	bh=ajchxbU7+AMklteL9pZzSBbNZx9h7w3GcNr0Mwics1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRMMQH4uQakmiTsMaV/cBzPN4Zsu7nImvPARejVdLYMgSmFG81iTb6OqTBUUGKY1WvS2o10bV75WyrBpcGTnl6zxBQyhy6aPc978C//HOazXn0vv0jYFhdzbZe//JXpMVthyuYTjn3xzglp0u84gLHV2kjeKecG9gYBJPyGIHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ku62Iyur; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DGfr026050
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 15:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	77fKbdkYmtPlwXrxnM32o82p7ovrXrSQy4ozw1UOaUo=; b=ku62IyurvRzF4bk4
	miTbSYf251eZWFjTfr6u4uUEDRIOVhUQFH131bvCOhz1uizHvyiGNOTU7ynprf+J
	kB0XZbCw6RrLi5v4IKpF/bZdpbMBVPNr5s2WvBa0q+IGaASUwiiVEWW7IewbJp83
	8EU3/2PTb6mKCS5Ox8dvEnI2EUaxsfGflGZeKcmO5kMR+ZgOIr2VkNEgYQZqYAui
	+C8MfH8+btFfrKcV1sXLxVplJGc1Kokb02gIB70OniLMyh11sezM9VLFpDb4IcEO
	BwZtcJcHRu4aZpXqT5auropA6UsThPHsU7KQsapqdhB7JX+h06NWKIFT+g7nEeHs
	7I1Sxw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2y87ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 15:06:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d0976a24ceso21156585a.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 08:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654390; x=1750259190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77fKbdkYmtPlwXrxnM32o82p7ovrXrSQy4ozw1UOaUo=;
        b=fCad8SFbjhB1QxRlkvWoGpnwVc4o2pkyrHdfMMhzdCZKRInUSj91ORkDNtcbB/JAbQ
         hAGrPa4nb+H1AqtBDmgB8MKG29nrw/fqex/IPedlhBxx8MaLhKuq1fkerIFE2jdt7nws
         P7g7sN65QamMZk01HUB1/O65CzFoQjcedwA2/7I+7p1Pb5B+s/Dr2RCMOc0qsPWrCLzW
         y25NMuIwFzDHaXcVNLs3ULUMEG+xD7hGiWiOGAVxRmMH59PrtHmH6cXi164YJURV/5RS
         KLbgM3YCO923NpilBZr1dPVjkzI0Kh7MzGZWnidAZx/O1UdvWRyF0G8IyEgim7SFTxde
         nq4g==
X-Forwarded-Encrypted: i=1; AJvYcCWfpxzsJ+soRO0CjOrSK7suDts6knSBN1ZGztrEgWFmcDQSpZtlVbvyP5678PdZtnVnrwSlx0YdiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwneWLvTwdJbPkEOU77m6ILRlU3m4dtiHUPjLyERWa9ZIORdMxR
	WS8QwdFsETf/Ekc6fOAi5nNMcwnazTnwH+60JcM2Lj89NvkFjmnFD6MHhvFxH9sG71czkWTZl4v
	ZPITuudV8EHO7xe24G8thzGuZNH0EwxVp7N9MXdP75QEnzBjn9atxPskouQ6mYg==
X-Gm-Gg: ASbGncuI6gPhMsp0I229Joce//AsYp9JM13Hoy48vrkipN9CWKRm4bHOAmCev+yqKRg
	d1AW1VEqtoxWbCej9ZOK3+197NzlgBUARbVoryNRpymtnTWAg30Hvfhhsc5WqR/bGkAwKcW86bT
	pUZAsG/dgDKvkI4TS+p8KH53CRgynEQmoAeaMujX1Kmb/9EfZdjCk8tYiPvUkw/mrFmfM/YTXZh
	xvLe02tRWbXF8S2oSR75pQ1rvqB9epL9RxXaYNjyFNMHQvv24yW4q2LohfOGrAoMGKahuCICzqD
	/NxW0OHHMAA6MNTu1KUjY0VJcbx153iVvhhYluMiOVrNq0hNGKbIPl6XQG8PfbtgIoIGnyhS1Lf
	jfHg=
X-Received: by 2002:a05:620a:2a04:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7d3a87bfb10mr208043985a.2.1749654389702;
        Wed, 11 Jun 2025 08:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFQcyeTIefOmtTUXQ/DK1/6HF+P0px0MJoBSIH1JUCYT215zZQycMHgB/rDMBR3Qjc3+Rx8g==
X-Received: by 2002:a05:620a:2a04:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7d3a87bfb10mr208041085a.2.1749654389233;
        Wed, 11 Jun 2025 08:06:29 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade31cc25b7sm832539666b.66.2025.06.11.08.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:06:27 -0700 (PDT)
Message-ID: <9d966b32-d5ce-4262-b99e-900085648230@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 17:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] arm64: dts: qcom: ipq5018: Add tsens node
To: george.moussalem@outlook.com, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250611-ipq5018-tsens-v12-0-a61374a5517d@outlook.com>
 <20250611-ipq5018-tsens-v12-2-a61374a5517d@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250611-ipq5018-tsens-v12-2-a61374a5517d@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyNiBTYWx0ZWRfX+7xRbNaI81Vc
 bVWw9zl4EklCYJInCb693+gHSVN+uAtdT5+v8qp3jzHkn4V2FJcmrUloOGpGvqybWB1W6Q1ax/5
 xCo0/ERqeDYZdyVu7pjiukGj9IkHAtxj7HrkvYYYRLpzvit731k+zJ+MctGU89S0bF3Iez+AmUd
 jcPvK70tw5I12Z/sMjCTm8Q+BG/6Ic0CzT2pzlRtA6pP4JLE2M229X4y6U8NbwR7APhn9h+ag+F
 gTBPiPIlx8FZI2xF4/+d13EIn89iRG6384Yaluf+IS0DdbqSuAwLD1Ue1TYzi0R+qrCrSAOjZvA
 N1LSoCygzL0OmDBfPFMk+xiqZ309cWhyK97VmFgBdlOsYC0yIU9HAUxShCcD3t7l81wwHxuk0+4
 hvy6GRigggYoR59ZriGRcthYUig9VCHpOPxWlTYLlus7qjV0AYUffFFiEJuWFy6RnvBjHVlz
X-Proofpoint-GUID: xZuzYoCU-wbkRLi9eR3GpWoBUYSHptdk
X-Proofpoint-ORIG-GUID: xZuzYoCU-wbkRLi9eR3GpWoBUYSHptdk
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=68499b77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=UqCG9HQmAAAA:8 a=TIMhQzKtEeIAjNMpRogA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110126

On 6/11/25 11:33 AM, George Moussalem via B4 Relay wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem nodes and adding 4 thermal sensors (zones). The critical trip
> temperature is set to 120'C with an action to reboot.
> 
> In addition, adding a cooling device to the CPU thermal zone which uses
> CPU frequency scaling.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +		cpu-thermal {
> +			polling-delay-passive = <0>;

0 is also the default value for polling-delay-passive


> +			thermal-sensors = <&tsens 2>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +
> +				cpu_alert: cpu-passive {
> +					temperature = <100000>;
> +					hysteresis = <2>;

that's 2 milicelcius, consider x1000

Konrad


