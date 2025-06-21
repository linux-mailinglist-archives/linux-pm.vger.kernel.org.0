Return-Path: <linux-pm+bounces-29183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA593AE2832
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAE3BEDEE
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2D1EE7A1;
	Sat, 21 Jun 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQbKvmyD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1516F8E5
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497238; cv=none; b=XyzuqxpNJfCog/97WgHp9kdVDfHfAcLeli9gCskP6KOEa4Hc5og1jJMpZ/LVk2B07H5MfilmcDXrOWENSt3RZIkJx0RhexuUT+cDWjRacJGOVd2owLJfLSr4KS9Vz+ZjbAoytyeYLvzsccqQtfHL25iWpk/zYM8WVeX3dPXvWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497238; c=relaxed/simple;
	bh=aNZPfi5MEjGvLVYSe6rsKjxWfVWTq3w5CLVh+Ha6H2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSLNlBirXTULDzL9MYk5geRp1nE1XkbmAaYnYGQxIIpfefwK4ptVZBXm2RNxH3ZFOIflvHl2oQYPwOSj6V3yA4ftd3IZOYVrs/l7qLjEbll9oz0hMv2rhCcDNX6t2YJ2HhcIIbbDs6S9fRLqhCTpF911SSmik3dO/dYI6vmZJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQbKvmyD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L4FRl8016646
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CdrgCuFyZGhrHzoOCbhVdJmers1s2mC3v5Ga2/l7EzQ=; b=SQbKvmyDx+aE++sV
	597nL58TAVp2oDiYX2t+tZdsqDGYK5MhIdE0i2goMfP4gVwE+uBkbGgCwclzD8Ia
	Gj2O5gmDaon4/qVdb2nLNb3DPDg4iVR23pkdeBdrCpImshyQd8u+0NBDrIEqEBBY
	l7UY0TbWEMqL/9N9h969wqes70RcwvlIB2M91XLiSos1EHPXLYs42X/Ocy9DCH2O
	uo/zlVQt/KbppTQd1mvN595B6lf1reqbfADckK/L+aQYoF2dTbYoEAwKgpa/y1s8
	tXoSZJ5bUT0xF13cfc3eTrlxb/dOJAMQW6nwZmfNuOpBYEzYCIVmFUwjZzoesk+j
	ppGm1g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dj3q0m4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:13:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0976a24ceso79386485a.2
        for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 02:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750497228; x=1751102028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdrgCuFyZGhrHzoOCbhVdJmers1s2mC3v5Ga2/l7EzQ=;
        b=eBVERGemcMxOKHhDnevJmLj6vVWZR5gR8SgptqJub30iCghvm58WNMYYx/50/9qm9x
         ZICilVBeVzgDGT1zQq8YQ2gpmBfh8TKRDiVjS477V4pdADOI3dv8+eIU8laxCgVRZsrX
         H8kVPGv2jsREQUVnwtOIO94OLkqfNKGfbY0j+H7uA6fCiVaOB7Il81hP9tPTnqH/KHzn
         Ve2BTVA1EiHvr4VFqvEcZEBnK/NyMPGi6vOee54e+httEr/DQLWPXGEHNt1Y01ng9lJp
         n+zPKBUJzS/YKuVBnXrJ1PcaL6aqYOMwFO1cbmE7CiJOGA9E6d4W0x/RubJKXbnzUWX3
         OciQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0GbKXmgYKsjaFRwhbuWFAfH3g/ox8bRdvHTTG0a8kz/agKSwDvRIXs/VXAQjyqQYzJGVx+qXT5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C055TqMQcNQXZ7OjZK4GqjjOKkgSjcESNCantRAfAAUTD3cl
	lC2CG/DJiPRNjVzxXwWcZXGnRCJWaAcbzRpDGu/4wfeVjfGYGrMuCCeGc7F4xdojrKiRmlEtSI4
	Ibvug+tgTOcze04+yQxGmFViBaMHDsR0G4dqo1oSulvXyxTO2cCUjJqNUzUfnHA==
X-Gm-Gg: ASbGnctcLjzouosV4WMDRa6SF2UDPKfUJ5ewmcVllcfpLP1Bgwcz0kH9mH5yjqW7hLD
	q8CJghkcQ7bSC7tO3jxn0rbxgGEbdsUsWKFK2kaHYibkSWUyWgYvxDLwV6KLsSw1RtlnhLGEtYR
	hYsYL/2MKHEbdaIkiWdI8gOhtGlXIyi6Xto6b6vWnzoGHLsn5OxhjIpQtEpZryrao4BEfIM0ep9
	5NaVsKFiKmSSmT0Xb/G/PToDwVLyMmU4tiCCqd/FYF/08TndDOe8NFaZ1et4ZegZpDfvL7cGUml
	uhL4+7+wvGiDyF+uiPjgeBSZqIoL+V2wbovywR4jTLUDEGN0ZhoTsVMNN1FNxYQ4S7RpjvvKtGF
	O8lM=
X-Received: by 2002:a05:620a:2b4d:b0:7d0:996f:9c41 with SMTP id af79cd13be357-7d3f98c09e7mr345902185a.1.1750497228279;
        Sat, 21 Jun 2025 02:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyIiz3szvGbH2qSS693ex8SUlj+1QG0R07ppmiIPkiWKJZke6knT/gDKybEOK5kP/nw/KbKg==
X-Received: by 2002:a05:620a:2b4d:b0:7d0:996f:9c41 with SMTP id af79cd13be357-7d3f98c09e7mr345901685a.1.1750497227887;
        Sat, 21 Jun 2025 02:13:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1851450bsm2799894a12.12.2025.06.21.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 02:13:46 -0700 (PDT)
Message-ID: <29748d63-0166-425e-98b9-5cf52db583f9@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 11:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2
 shutdown when required
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
 <20250620001918.4090853-2-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250620001918.4090853-2-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BPWzrEQG c=1 sm=1 tr=0 ts=685677cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=buOH-We6NtgwU1KSyRcA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: E4c0bxDAiBU01SpZ9EJapa-rib0MBYao
X-Proofpoint-GUID: E4c0bxDAiBU01SpZ9EJapa-rib0MBYao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA1MiBTYWx0ZWRfX4eZU+AXotkf4
 bJET0PQADebZMufQ/wC1d/Y+Xn+DyaYqT8FfO8ZmAWbGissynN0sX3f2STaY/B8dDR9eEcfy0Yn
 QmtW1McIiDj1t/5o0KJb/3C9g2yYKMZgLeK7nODT9dU/B11b+NlVWlyxzK0vicKlmrMCK/OLNUf
 y09D9tD1YhYMmYTsbjCByQ7XhY1tQnuv7Sjfvausc3LRSxYh9qY2CPWXIry2LgzHkeIay+ASGg2
 54MotFi2SVCIubTeSerbN5CxtBTuPv+o77s46ibXuMpn0nKJXsN3Vwc5FfL8r1PHCvNYCXuQSlY
 MAv5aG/R5mF/DlIBqeNDTH320Vlx1f9zmsD2ShkrIcxo2ZXfQKhZM0rhJuSJL/shYc0/gDHI5Fk
 77wRSicFgwWr239QNBlqlrPOLaYwylNnQE4hUCDQWbruOkoRhm0vxX8PvKe6oJvAEsIKWCom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506210052

On 6/20/25 2:19 AM, Anjelique Melendez wrote:
> From: David Collins <david.collins@oss.qualcomm.com>
> 
> Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> stage 2 automatic PMIC partial shutdown to be enabled in order to
> avoid repeated faults in the event of reaching over-temperature
> stage 3. Modify the stage 2 shutdown control logic to ensure that
> stage 2 shutdown is enabled on all affected PMICs. Read the
> digital major and minor revision registers to identify these
> PMICs.

Can stage 3 can be thought of as "hotter than s2, need to take
even more concrete action"?

> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---

[...]

> +#define QPNP_TM_REG_DIG_MINOR		0x00
>  #define QPNP_TM_REG_DIG_MAJOR		0x01
>  #define QPNP_TM_REG_TYPE		0x04
>  #define QPNP_TM_REG_SUBTYPE		0x05
> @@ -78,6 +80,7 @@ struct qpnp_tm_chip {
>  	/* protects .thresh, .stage and chip registers */
>  	struct mutex			lock;
>  	bool				initialized;
> +	bool				require_s2_shutdown;

Let's turn 's2' into 'stage2', it's not obvious

[...]

> @@ -402,6 +405,12 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "could not read dig_major\n");
>  
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read dig_minor\n");
> +		return ret;
"return dev_err_probe()" is preferred

Konrad

