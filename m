Return-Path: <linux-pm+bounces-29184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D0AE2846
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855013B1508
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E718C011;
	Sat, 21 Jun 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFZQ7X08"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAF1F0E39
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498545; cv=none; b=Qq8Bm2R4ykErJ7QDJWr7Uwepdva7X/lHcmDAeW7TnmEHRIyyJzbRe3Zf0JxPF4YbCZBvgoFFSOYfQRpxDvzAcQ3eKyPo64p6zj0KX7yk+OSL5X611VJ6jb57yBf9UGnXLf7lBipyOxcV+RkB6ctxZmOL+2NJU8W1VROklthOUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498545; c=relaxed/simple;
	bh=qMez/6e9iR0UjmQAW2ieUww2UFBew2FQJHL9FRtnHzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXvWP/+wgK4ophQMlfxnrKkD0NmoMy//4fBgx5Mn8T/IvOWcs+juC4379mobLJ2PCIi5lcs/x6+3RmRULSER/BinIqgFEDleQPB7fdaexqK7SIU0vfPqvlzxrbY0gX8U7eT1YVMyiz1SoPIOe7VdRjjbVL9Xga0pMsMHPrA7LeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BFZQ7X08; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L5gGFg021135
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NwPF+41HTQ/VpkvHzZlY0OYp5Xr0moDhEfA9/UXqwyo=; b=BFZQ7X085MEX/2LQ
	ci6JVm4UPS+RZ0g80A816DkSIZ6czqmepuUqBbodCU80q/lIdrE7e+nQHy3pjlq9
	Bsp2KMBL1k+3fzBlbfCx4B5sLZtBA+7jvIvNbJezFep+F8/m47rRm3r9wc0D0r+a
	ysd9YuFO6iGXIj9SF5virgUj0wxVxy2egCO7hi/HEEzKVXiZtWwAOrf8MWLkFMbg
	UUkU01e1Qk3UKlasBgYBaqsf5OzifyV6DM9wkHE4rjeePAsBNyzr1ga4U+6TizYw
	NfYo9giAoE8boYUf3ZaO9fpP4wCZ7GY0yN96CaZbRj4+z6yZznnFdD1MKPc5xHwv
	OnPDqg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dkraggfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:35:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3ea727700so35627585a.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 02:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750498542; x=1751103342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwPF+41HTQ/VpkvHzZlY0OYp5Xr0moDhEfA9/UXqwyo=;
        b=LE+rCY0ebXtJxI1BvGeymh+oSSebip+MnYLIse1sDn3pygLec7Bd6uL970UurTKejC
         i7JsIXNHyHP/uk9aLFLopnntsSwGN31dbs/OVtI8t31ZWRWd1nDrRuxFi1hiEDYbxqcX
         BWZdXUdAZWx0S7SRV1dPWH9nHaK4rmmHSsk4nznlvGZCXYcbjvCjtYFweGvOha8s4Ioq
         9+lfZTFIM35UUXByzWRmb/abrTqrtOtnyzuhFdlE4gWZveK3I6M8lFrBhoozQWSoOfSH
         rbjT+YPnUFQO/kkuQRcPfBsfxuJDrUS0vE0DJyCNJYqWwAw1lnMZsQEnaRJJ0VtHaH4T
         IFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3dcPcy9lplISQwgqpY1oEVzp+Y5CYHl0wgaygts9zRpX0wLri/e+8OrEudErnzFmeZ+PWx6JaKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgazsJad8uPfd9x3HfKw/NEqMG5mIJgcdZerI6k6FAfYy4oMsF
	8BpsJWWJ8avJQRmYZHN2aJC+stq1TFBC7tJPb3dhXYt36LquElzo+SeiM0osybaQpqbxNRinPwM
	8l1BWIlDhy4fUdgZR30hoqtqoohajkGpDG9Sd1SkHf1gSbh7Z7sJSDs9KSxZCHA==
X-Gm-Gg: ASbGncuUmdjjU0eZXgPg/bwbxuXc7sc3DJOg/RGPTW1StRIadbXWAz3Dirg7IY36qSI
	LqCId8/VJFe3yn+5b8ifxKNb2ZHRj3piPTv2Lo1K06LJLLQYMy6VwryeLwMqWbswg0mefRpWDwC
	HZw3psDIwT/us4fH74Q2mGCt4TyNlWN0SrNkp5Ti4u5ZlzM6FrjEmeIi45x1VzduX7c46MyDOSB
	ub3f1Wj2m12TTNU7IVDK+8+f2gpOrgSblMO6kji7F+ktQ+vZGTLvG2dBHnPNlKVwv2uhXTIMKJN
	MHvSfx1WQKBR0d+cerKjSqLGRnxeBwm8RvWLBcGN1Z6pW9cuN6C+FPOrbHErxkDu9lZ2JNSQ1Zk
	QJIw=
X-Received: by 2002:a05:620a:1aaa:b0:7c3:e399:328f with SMTP id af79cd13be357-7d3f991e796mr267151585a.11.1750498542021;
        Sat, 21 Jun 2025 02:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg2nByYBPFIwY3g4IMg6xmOect607XngDyi/VlYZ801y6UNBlPPKA1JzXmjP9Pfk2EZTJmBg==
X-Received: by 2002:a05:620a:1aaa:b0:7c3:e399:328f with SMTP id af79cd13be357-7d3f991e796mr267150485a.11.1750498541579;
        Sat, 21 Jun 2025 02:35:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18504ef4sm2880152a12.15.2025.06.21.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 02:35:41 -0700 (PDT)
Message-ID: <e171a7fb-ff96-42a4-9a29-37640e99177b@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 11:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] thermal: qcom-spmi-temp-alarm: Add temp alarm data
 struct based on HW subtype
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
 <20250620001918.4090853-3-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250620001918.4090853-3-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zFGB2mOFgTsScRjbYzqGSOZsnOVpZ54E
X-Authority-Analysis: v=2.4 cv=YKWfyQGx c=1 sm=1 tr=0 ts=68567cee cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ClHdKqAKKX4Pgx4N8LcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zFGB2mOFgTsScRjbYzqGSOZsnOVpZ54E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA1NSBTYWx0ZWRfX8Yk7m9SIWswu
 8jMluJs0pu3zzv2G2RlBW4EwJpNwajhwIy3vaDvWScT+An5q3Iv/csUCWGsihs/jA+DA5HRmBWl
 8Qlex1QSsapXKa76wYO1HCWM4Vxy2agKNVo8foCGKda96Qbqi3STScwYySKSj/4n/COfYZujPPS
 tKKN5vgBytKoQpWnzO3FBqIa7LXxBcnaBEBRayR0QgTFVCioq4lywjSapfRH+RrqWmnryZrQf5f
 KDdmuPcWRngoE+PRAbToj8L+DJ7A9cym5V3uaVnF4M/R0oeuTddqFcmIgep8mlP/jwT5jwQj9m8
 jfnp7oMd9ENC4HA2+nhT0uKFv9ikOJfxIUC4oSlnPUFE/ttEUHJgR14RH36/JwGGxRt1vAGw7pH
 WBmQnSeBPbSUeInYDq7WlD7Y49yYYuUJPYQLDtgUD60Ak8WD2NBqlRuZ8kc0NvEs651hLnic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506210055

On 6/20/25 2:19 AM, Anjelique Melendez wrote:
> Currently multiple if/else statements are used in functions to decipher
> between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
> refactor the driver so that SPMI temp alarm chips will have reference to a
> spmi_temp_alarm_data struct which defines data and function callbacks
> based on the HW subtype.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +static int qpnp_tm_gen1_get_temp_stage(struct qpnp_tm_chip *chip)
>  {
>  	int ret;
>  	u8 reg = 0;

this initialization is not necessary, as you override the
value right below (there's more cases of this)

[...]

> @@ -221,10 +235,10 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
>  static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  					     int temp)
>  {
> -	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
> -	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
> +	long stage2_threshold_min = (*chip->data->temp_map)[THRESH_MIN][1];
> +	long stage2_threshold_max = (*chip->data->temp_map)[THRESH_MAX][1];

maybe we could go with an `enum overtemp_stage` to get rid of
such magic indexations - not necessarily in this patch, but in
general

lgtm otherwise

Konrad

