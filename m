Return-Path: <linux-pm+bounces-29168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426FAE207F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFC33BD451
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A862E7F13;
	Fri, 20 Jun 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXIuSAl6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623A1E376E
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438879; cv=none; b=cTEXsyJFC+0xyS0llj18rjrJiPjMdzUfNSh0yfsnrDbbPKkfj2JnKyVvsTb1Qb1fItf463arWnNTWYheqtmhMZ8M0MPcfiyWeH0ZqQblxngDisPdg4l2kiGvTvORVZGuCKLYn6ROX/4UR21k6aHwsteCuQhJtzjZ2jUW0o1PpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438879; c=relaxed/simple;
	bh=XAukmnt5QjBdMQI+xuahj+iBwVBMbadMcYelH+EV8+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfwvpnFr57XoR6SWoGDwkNjE/cEhauq5y7JP4rBlXl35yAb1K4ur5z7Gv0/RShdBYun1RV+vSV5ZEuQ3oXDnl5n6HYJZDhrd9oLfKGJLfltA2hBhcmzNqUBOxfIyOsyGxa7d4K/Rba+EsC9GVIvoRQ4sCFZV28NMiXICnBtfkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXIuSAl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDf3ga018581
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fpu0l6974H5V385jR1/L6yeOq9JUIfEhJX1r1r81aaM=; b=LXIuSAl6/qDRZB8x
	Rou07E5KSwJ2siNkOf3nRzeATHpXzlQBkuSyYIHUDMWKbO/ceb1UGe8aeHw1tRuV
	+ALWNpKymXnEnJc8yCtBdXL71yc4l/lHODXnx99U3EOQAd/yeavU40JDasmldLF1
	bM3fUiy0kAAIffnJB+O1IZn4sWUH3LQ1XxgIdenwpQ9ryYTqloVOQPrBr8MNlpfY
	X11lR/oJ87wYWKTBtLQIs5+QdYm8dYMDDSKWxDJQMk7VSYu1TdVoOC3rv0YG6Ih5
	7NR0cEOC7gKJL+/PCCh+FSb07j0Fcdsv9kOuohxSs25CEBa75BaBeWCJSDo4lTYM
	K97zFQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47d0pchyfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:01:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d094e04aa4so58755185a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438876; x=1751043676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpu0l6974H5V385jR1/L6yeOq9JUIfEhJX1r1r81aaM=;
        b=YTTt0/KMHYg1v6zFSEMYiHvZaif8OCvOX4iwqls3NdyPIqRq8ST6+YcTqNxuDkw4if
         bABisLyDZkckD1dRhuyE8mRtJx3tADbq3efl2u87YGOaInsk45NQ4DpFyTqvSWAAhImy
         Q2EkVOWlHXAYMnEY24+z9h/SusP409s86GgjzdQWWAjPg3T8rWeSbnr2EIptncjPXMds
         lbKpJmrmS6uyxn9sMPDHZabu6mo3UjXni6oDs6DyidJ7iv3U0T02qaB14ULivexoa/So
         OnZRD30XqX1gmf3xd2sgFftn/98x3qdjYygAsv5KxuozAJTntMhWSObBmessbmVdtxFm
         T2OA==
X-Forwarded-Encrypted: i=1; AJvYcCWsiZIp1IUkj1HwNY5V8d/kn/H3hg5tGAq0vyZ08+1LMt5So0gkqkdzDV3QzvmKL4+qep7FSKn+Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMllt7wmocJ9aOpdqmjSbEutOUGXSFnw2fWVhuFgA68WOOOI2
	a1iDhtN6Og8Vp7a+YdME+v+jmiCvIzqY/Oo3iirXOLSKNMlLYLVSntTj9LQXe144e++/DdYlOmZ
	ByccKNckGPjWZCyCoSRjWCGQUJwJokgdj+3xLAyVtMlxR+s1eiNuA62Xd2S2Oqw==
X-Gm-Gg: ASbGncu4Gia2TOwoD6SwIOO09yGGYlYj/Hdd0+K43nWGhKoyG+SxO/EppeLUDp6ccO1
	fNa3hzqTW/xl+SqG+2aOPVs4SZRC1uW8KVuWeybc0Tb+cMPVkl2K5tceZTUmbr/r5kEPFE3bcxG
	dAYSAHDisF3ciohzh2h5wbg36d+K6dJtdtaWxAC34/iFKyzeVCHw7Jk9nTn2D8noWJmPsrSUttB
	aZdunO7+EMAjiywgqln5gvuzoJlLdiZLA3gUrj69bAQSxV7+gvmKKvxUGwEunRgxohU1OG8hYUj
	+y1vzbQ7jVlkALEiEQCCH4NICU5zkyOjbqHfzsObsSbVq81oN/+CQBATlnZFYlFlR+3M0nnsRbt
	hPwM=
X-Received: by 2002:a05:620a:1707:b0:7d3:c69d:ed69 with SMTP id af79cd13be357-7d3f98ec727mr193721285a.6.1750438875890;
        Fri, 20 Jun 2025 10:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG16STpHVdEHhYbxIqd3DOFgM6T+wJ9+inbvmdt4Ws0DP1ihUKEnE1P7W/LjHT61a5uRN3b1w==
X-Received: by 2002:a05:620a:1707:b0:7d3:c69d:ed69 with SMTP id af79cd13be357-7d3f98ec727mr193718585a.6.1750438875323;
        Fri, 20 Jun 2025 10:01:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a185797bbsm1647747a12.35.2025.06.20.10.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:00:46 -0700 (PDT)
Message-ID: <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 19:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
To: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PCYXqRaJFib_c266KDzcBPdASYGIX8h-
X-Authority-Analysis: v=2.4 cv=YKyfyQGx c=1 sm=1 tr=0 ts=685593dd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=tPfAkDRKdS00ijgZXEcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PCYXqRaJFib_c266KDzcBPdASYGIX8h-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyMCBTYWx0ZWRfX0wVVIvJ52mDs
 44EOT3sfhLMykSTmc31gFLZYn89XjqNDBmtvOR04rQqV6HK4sblALTACEsOaI+piws9uM2NtkZN
 J65R/p7+a4kAdPze2WZ5FscA4JHlDEGlrK//Fr//EZiLUSt31xADq0dTP6mu3sLiOMMV20vgSoX
 1lpBSqSaTuZdyWGl8u7Uf45yZkUmCUSbtd27xDuX2uSzVBLunp22wq4bfnYpNVZEFHtMUjNf+AH
 MigMBlUkCC0MoReM1cIkbRuRkeHkiri7K9Vtfa/qiP7/TmWIZ7D4BuK3zo42YC0qaBFhqMZhdXp
 TUCH+yZTN157sTsfgkcWn7b6YXSa9TYfRT2JEbzBW2Fo7MWYWMI28sPdkHC4bawc7J3L2Fo4ALQ
 qwSTMXfcZSpwr3CRG7UZs+0Cmssb2PrL7W/1R0vNtQb1JKYNUKP+WOhiesDiI5XEC3aqXg9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200120

On 6/19/25 4:55 PM, Casey Connolly wrote:
> We don't know what the bootloader programmed here, but we want to have a
> consistent value. Program the automatic input current limit detection to
> re-run every 3 seconds. This seems to be necessary at least for smb5.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return dev_err_probe(chip->dev, rc,
>  				     "Couldn't write fast charge current cfg");
>  
> +	rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
> +			       AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);

FWIW a random downstream clone I have sets 0x01 which is claimed to
mean "every 12s" instead

Konrad

