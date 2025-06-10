Return-Path: <linux-pm+bounces-28380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DFAD38E3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F549E6603
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4DF2D29B7;
	Tue, 10 Jun 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCkZ/GeY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD42D1F5D
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560933; cv=none; b=ivkqs6ce+7Q4IifUL3C7XrMc4ZD7TNsBI2JECT5k0Y6B0bBu6COnbzWSdXQkpkuW59ugBXkEkZi6uDz0z5Wa6V0Ixs4Gddcf91MBomrJHZ9cprH+q2aHjoI3TVi4oZNbAy25/Gz+x52MVcLB1ydNfUh1M9+epxtXd91FX70vJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560933; c=relaxed/simple;
	bh=evfZ6g1FYwwlpCeQBDLuX2LOv/1nyUFtLivVJP8bURc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki1BNwdjvq8aJUOMUu1dTaOHqzHC7a3PlS0GvaQ+peB/St8Kh79FBmM2EVORfkYZijk5pDP6FOqCpXvNTNqguErlkiv0Wb+W6lRTefh8xW1UQeXpRGJovYRyYiJhyWBbIujLSF8ROyDH3i0R1kldQcYmzdIlYBdrPph6LYIjyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCkZ/GeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AACZpC030719
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 13:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1erattER2EyDtlcsiT8to8amhSAT62hbSa4lAh3IJM=; b=BCkZ/GeY5eGSI8p6
	K8aH8PRZnsnzqX+zl5WUM4d9MxgjBgI/aA2PoYMfx3zcuDS2BPzVkwbhMLlc7Hbs
	tZhGOAcGhecoujv0poqQo5VYwuxeuaGTFWYrMZGnRTn+eA7ImT3ybu8fqyMzfoVV
	db7nyOfQ+GZqkYNv2M+c+ieRLdyYfqSn5HehXtpAtSedO3VjGw3zjc7Mhe3UI30C
	KhHVo2mW2mxxZ3N6ceBVIHH6qJSGvuvRgh+D+pSTSckONEethNOiyfzMmA+KORvz
	2/Lw+2CdLBnEngpH/BSqd75pkuxg6RLUUEpBGLz917x+Y1C5zR1p4mjmEIExOuhu
	PSgjJg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4766mcj8qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 13:08:44 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2e8ec46835dso662338fac.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560924; x=1750165724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1erattER2EyDtlcsiT8to8amhSAT62hbSa4lAh3IJM=;
        b=LqJ7mxpTbnTkpcEX6O6o/tO/fYfq9+6G0hHZAjFbJflEdDDSoWAnk7HJvfesepvPoi
         SPvDk1FQua1aObrmbNLiCwzPUHUU9mcbUPhnJ0wszDIxLa2WDJwXrdrmI6TGXKUEjlNB
         j+I9Ehrg3bKNutt278x+4JPB5zhf0Z9hsqPbC1RqxKchlj+G5Ep2FPb6oC0clGC/jqxz
         nnabt6JOHTpDbYrap1i6Y2a76w6pfdOtmlKVIj5VWzoprHhSTkRX/1v73VmHO8Juya31
         FaG9wdRJ/l1VgFGnoT65kFREFyVXMik7bnfhwyML+XUu+9SHfmrNiqimZ4YHVKG54Dfe
         4Orw==
X-Forwarded-Encrypted: i=1; AJvYcCWYpDLVesZGAfM5ZwSExYMzwNMsNWQYXXwHhbJ1fUXtwaens1pTx1J/E4PqEgJn6C7cPT7/6UcaHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykkypIy/44GET8CrsstnzDLLKcuqeZzUQ7sBiQkJuww2P9TVEx
	JBPUwbZiDWyqdUqtQgup+xTUBP+zTUAQ/qJhm7Pl+F8uBOovauMMEn9IPskR5TJPMRbDeeo2n6N
	cO1IfBh7ve1Yb8mtLFrWgh7A5MmImSh52H/mw/9TXzsmoljZl2rp+jqQSXpp+kGtYV6EFoA==
X-Gm-Gg: ASbGncszCG/wCf1iznoEc4rI4pgew7HljMHIoG0L24bxkivVdCBRbpesDl7CZWBB3uN
	HBcRItxhr0zrPouL28xey3erx9HdacEyOwGqJBjGqSdEw77sDCL5pFso4won5Mwd5CLt7Q1azIK
	kuZbkWemHNrP8+NqRswduKx1X8wPpqd3nLFgolxaiSxbfaWlVifm6XUo+YZqHlLqF9qOqRrvYgv
	Aw8BVsB1XLwCAU7gEEGkna8eHTG3TTmv5GTb7IJIPqM+VSjtCr3rN1ODJ+BizHPWZXdGpOktLdj
	mCw9YQ8eCmbqGTtAF0WweXb2GSgie3J3NZopuZfxSVtmmQNM1pOKAGHTo+GrG6BjzoaGFo3PcCJ
	0
X-Received: by 2002:a05:6871:d304:b0:2d9:3868:b31d with SMTP id 586e51a60fabf-2ea0aa71b9cmr3548160fac.2.1749560923779;
        Tue, 10 Jun 2025 06:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHumeK8s6YcLMXzmdaaLzgYlUSa+GoLCZFmNnBzQDlQdOXmx6iMWgCspTl9NFPTRxuzi3p5yw==
X-Received: by 2002:a05:620a:408c:b0:7c5:79e8:412a with SMTP id af79cd13be357-7d331c39c85mr858426185a.2.1749560911969;
        Tue, 10 Jun 2025 06:08:31 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754653sm718680666b.20.2025.06.10.06.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:08:31 -0700 (PDT)
Message-ID: <f123294b-b944-4723-bd74-713970468d51@oss.qualcomm.com>
Date: Tue, 10 Jun 2025 15:08:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] arm64: dts: qcom: ipq5018: Add tsens node
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T8KMT+KQ c=1 sm=1 tr=0 ts=68482e5c cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=UqCG9HQmAAAA:8 a=gCHPDHSnq_wzHoAtv_MA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oAjP4QMl-QEPDOYyumUs6VYq8DWoetge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwMSBTYWx0ZWRfXw9nJK+n2IF1h
 xUSHdTp8gkov8GR4lZeE45vd2YJUHuMUyFaMUJ4m4aJs1OJC5M2+BtX4QrtUDn9ZM5m21cNHmPt
 +8HwdPNLCd/LudcUKpfwtNC/91/fpV+aMwkQbfahEntjOZ3nH0TURzWiFQ3H28AwYPjqFxIBfVA
 1/RWleg0Lt/IF5aYSgrQzSfADTF+mGYKS40BHUS5ZDpurYWtx6tnSur/Denl+WwUnldcoDMp+4g
 ENlk8ijrtV7hGYkVNJy3vSeuscUtconTN5PfQCiw5SsGP/QDd5Mpzx/ghSdXMcyhKuQgFiXDLKJ
 cRHod/lefuN1KlkeP6/o9hHn2R9DFQXhzlZ9HZ1glFx46hZ0KXXafhHiVWr7gPk8zVhxUkQZnh2
 wYHgsgl9paZGqlSKwkfd8xAvR2SUvhlsLX0CFFb48g3iN/cM5DSw94i5+4RmKMoeBGICSK2K
X-Proofpoint-GUID: oAjP4QMl-QEPDOYyumUs6VYq8DWoetge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100101

On 6/10/25 3:03 PM, George Moussalem via B4 Relay wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem nodes and adding 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5018-tsens";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */

Please drop these comments

[...]

> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 2>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gephy-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 4>;
> +
> +			trips {
> +				gephy-critical {
> +					temperature = <120000>;

I'm not sure whether there's any firmware/hardware measure to shut
down these beforehand. It's better to have a software trip at 120C
than to not have any at all, but you may want to try and find a
case_therm or so thermistor for your devices..

> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		top-glue-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;

0 is default here, you can drop all such entries

> +			thermal-sensors = <&tsens 3>;
> +
> +			trips {
> +				top_glue-critical {

underscores are not allowed in DTs (see:
Documentation/devicetree/bindings/dts-coding-style.rst)

use a hyphen instead

Konrad

