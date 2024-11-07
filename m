Return-Path: <linux-pm+bounces-17120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C69C094A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F01C2230B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFC2139C4;
	Thu,  7 Nov 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzaGTWfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1E213140
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991047; cv=none; b=Wo1DEJboq9leqgD7+MlQr41AMmrn8JkwyyHEyZfv1EtCsQ0Bf95u3bJ4F2se97T4u5zZYl3CQwYsT5U+LW38aMvKGUnPL+iF6FImGT5wsjbEm5+iHV2oevm3HVPKhVnKF0R0urhYCKBdRl6Mjxm8zJUhjMwIScNPT/0rLxHu9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991047; c=relaxed/simple;
	bh=c/xTRIrJ5nBsiRyw55IV13bqiTCl2MenC3obfPMlG1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4jAFzeuT+TtDd7KZksnkhBWPZddLe8w6fIvcHWhfx9+Ac9wmBW8p21ClE9Lg+AJuW1W/xOf0vuJ9k3tjvhAqBfU0kuT0U/e458Fq1GkQO/rLP26S9wG+rDkpQ3E/eNGQLx/Al8zBi0fo6l4pyZUvknjdK5cL3iy2Dd37AuIYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzaGTWfp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A76YiPF010504
	for <linux-pm@vger.kernel.org>; Thu, 7 Nov 2024 14:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	orOKMQLBCv2h1c195dYm+Nmc2xLy3QnFjG1e5d7Rl/o=; b=jzaGTWfp/NtUodwA
	RsSZofrgtVYoE9CVJy8F23qqbIjw9F7tczczFR+lApvRxRH45Cmo0Ou4ufqTME8H
	8OKHwd5+vAGiZMizIVSXxKIP7ZLHyrlWzH3qPfqGqzdc6W+/54AV9hqcwjW41EiC
	/jYhvl47YZKoMPRUvx4bQ+8ij39K5Pd0Qx7ny/4cu3fOhbdrY0zRZ5IkfyyRxQyq
	tE6GeIwMTg4YkRkguQZWR780z6kfZpY1QrQ3T55wivy68XEXnOD0wR3I6AwwTxwf
	OqgvtaFhHBS0fVPivTMdWWMAMFoL01Gcnq0kMyAi2+BV2Vu287zJg6kaRwmaypOs
	SYzzCQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qn73eqn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 14:50:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-850258af7bdso61036241.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 06:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991044; x=1731595844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orOKMQLBCv2h1c195dYm+Nmc2xLy3QnFjG1e5d7Rl/o=;
        b=Rta+s4APaBiTmck8QGF13FH2KgOWE/jwohRYfnHumdCcxMAYM2q3kyhDWJK/6lG7/O
         aFvDUD/HhTW9+OJv+CDtg0mADKghSWv5xjV6xKh/2Vcoh4NYFzIjGrjNo0yElCtg3sIp
         V9mreV9pOtQbKpsjODKPINUbB0aRyWX6co94Zxu4VbauRqXxh84tz1W5SkDlshK4VcyO
         TX5KRyGH7bG3iaWlXpEqLZyMyxSsCoMyYdBGBBd6AbTQt8tZF7tCeBWueIgs/wiQivfx
         pyyOYGbn862prGl1Lw+Wtc9ohsuK16VWRerGxRa7zv9Y6bFN7MOaY81ndx2DCCalw3fx
         i3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3/c5yP6XV+fTE3FnueTbs5xm0OaSvNHEzqYBL8Nqr/8ZpiO3EAE3wvqC7k/OKK+7H3GG+MfHhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wxeEwlBbzyMYqMJb1BtwYcFGEybcdPLaP59XeS8cVXedTPxB
	KjKS43/r2YDKI8K8OjwgE/O/5WpILbMYRwBRS39RoVP8Ov4DNGYiSgpwLhRvCyeloUCO7uFAZoY
	dKkRqaBW145oYcjuOOOA5Zcp+qj9yWnFD8yh/EeXT7ghPfzBAIlZ08MHwnw==
X-Received: by 2002:a1f:d1c4:0:b0:50d:6f0:5879 with SMTP id 71dfb90a1353d-513fe8bbd35mr120061e0c.1.1730991043634;
        Thu, 07 Nov 2024 06:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHus393ipmlzutzTG3KT0B8ynjWizWAAq7Gzr52l40pNnylVkHVxH+LD0GcjNXGrfSrQrhO9A==
X-Received: by 2002:a1f:d1c4:0:b0:50d:6f0:5879 with SMTP id 71dfb90a1353d-513fe8bbd35mr120026e0c.1.1730991042981;
        Thu, 07 Nov 2024 06:50:42 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18872sm103586466b.11.2024.11.07.06.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 06:50:42 -0800 (PST)
Message-ID: <69000e68-c1ef-4cdd-8fc0-2a04a6d38e02@oss.qualcomm.com>
Date: Thu, 7 Nov 2024 15:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] arm64: dts: qcom: ipq5332: Add tsens node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104124413.2012794-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: isPgxMHvAmPED49wGnMbi-kcXqMHSZ8Y
X-Proofpoint-GUID: isPgxMHvAmPED49wGnMbi-kcXqMHSZ8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070115

On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V6:
> 	- No change
> 
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index d3c3e215a15c..94dca05fdc2a 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -177,6 +177,46 @@ cpu_speed_bin: cpu-speed-bin@1d {
>  				reg = <0x1d 0x2>;
>  				bits = <7 2>;
>  			};
> +
> +			s11: s11@3a5 {

You're adding 's11' etc. to the global label namespace. Please make
the names more specific, like tsens_sens11_off

[...]

> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5332-tsens";
> +			reg = <0x4a9000 0x1000>,
> +			      <0x4a8000 0x1000>;

Please pad the address part to 8 hex digits with leading zeroes.

Konrad

