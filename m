Return-Path: <linux-pm+bounces-37603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98793C3F02A
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4EE4EC375
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8A2D6E60;
	Fri,  7 Nov 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9VKSGL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OlyvRjR1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A82C08A8
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505140; cv=none; b=Mk6lJ3MW6GGeHA2LkSDiTxh5ruYuoZZSTXWH7HSJGF64P0isAQfvcTuTayePOSrvwSET6kul4Xs2W6IYQYLPiID+wbojgQbKYyszXZg6YGfuNTDW49Ug11Ij7V+DLUK3GYB0S0aMKCouBKoBrtuDblpwPqSS+iLl40EUOxZP+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505140; c=relaxed/simple;
	bh=RKIGS9KO0vrK2ZX9kbsgi19599kVH40TuOoD/FFjBG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4S14yDgv035NTy96f6wx32ooUVLV6kPVuoLrYbZ6RMlfap5ZiOcBoE/CZ7Tc/+mYcQEiPFsTy07cFKFrYo/2RCYbz6Em2CkFvshIM2ykRBu36HU0MzP863Fr+3xICeoLJz1NWAuJUazqcW2FK/eBN1VFLXqkdIeJ2AFb8WabcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9VKSGL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OlyvRjR1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A75L3qa528571
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 08:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=; b=j9VKSGL5ldNhCJw0
	IDsem0Fzr4SZuyQvM/h+H2DD1w1AXbGzSR3pIfo38NsMeard3DiozlihvbgOA8mk
	E6iXrhmwPw+FvmJt6QIA33bRR//xSA+t/4krdqjLlTv+Ktsev+bV4kYprelpwNdF
	GRGMArQuSTUJWlqAla3WFLSuaGWvjhBrDvToC7CMXn0vN+J1xQZllcYOCXarce4g
	qBJRGRQBgZLrKak5prqU40NrNsbZbzxGb2YBYOhfRhU9EAFl2akC7pCJS1EFpvvT
	BJycTnz7G1RABrBE0q3f8B1E86f9WqOUQCb0IEp4y1Fp73PNUYDuiP/x9QZmB2cp
	h7FEuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905htahr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 08:45:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8906754b823so20444285a.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762505136; x=1763109936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=;
        b=OlyvRjR1scUYpx0elK70FcvgNMsie2yqvTd3JwwCuBE6dO62ea16VBAw0G77yqywR0
         dCUP77sIHzROUTTuAw+6EMYLSnGwju56++KGde2FpWJBxgTTokydpK/oDODseafWfOSc
         qJUaQQ+6WyvpKr8lttmje/A5nTuOQsfIsXx58yFLST7keYVteYCErxPMXDTihtYbUP+L
         HwSWh1+lulyJHT4qirOJGpgqRoi7VGigqZFzx9CThrsChR8LwdUIaNrsYStJbuu7QYhB
         thwfY50m8ogp5dvzknQUseJdEq/cVLfLkwTWf75rlnM+cLBjoMalZkgIOVOtMqugmQO9
         K7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505136; x=1763109936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=;
        b=mhY70y1XyCi7tGBStHmLLvG0rn86ymP2HL1GtRpDi/YST0gBuxq8MtUxkvQNQ2bnGg
         GGcHTS8QmHEhve+7UlBQidxYEW1xKTKLSyKfrCu/uU0UheD3T6S110kxgtJYlc7O0sTt
         tj2FtCRHGYFAB+eU/JhU8+Zuor6NUxcXtzQpe7NeG3FbvrhKqRkfe+yxh4n9yP7e7ToR
         SbBwmmgokSCBTnTL+PjgZXii/M3gJDaDJrF+Pz3Ra2TATiikQIKiDuSNeBMLpjO8UACi
         R6cgPeNk379Dnq6vBm+aDoDlafxKysDZ9l5xF80B8umiMp71Sx29J/U3BKY7hfOzFZuy
         1ksA==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ9X9sG9xiulgI4vDaOl/xfw9o5z7bxKAtC52zLDxg3JbuYj7kekUK8FYzfVNi8poX+BOv6xWXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Z5goQ3f6WZNXdTcQjabeji4CDPw9EvLbBb3e0OfjkUI/ryye
	ajxMFRRoitz7ldPhcGm4UMTW+JwfbpjcvGksHXCPSoWH04k+GZ3Oswp9yNVn2tqSPA4Dg5uHZpe
	/ha0a/fjT3CnsqUOb2svkSgkLgm69q0ByRDATewgsT/+gkaTvAWZJjm7BnZrlUA==
X-Gm-Gg: ASbGncvuqGDbfAlLXqd+zG2IAeR1EpkZtLPVhHPamukY4/VmgyQZIglvd0ZRr/u8d0T
	UHQH6DGCsq9uBsvHQphNuWXpf0WnZDh4ZNjgZMaIkCp8yoLIfOcDL1Qz12wIECinM7PHvGMx/2k
	pdyfKRp/yRpehr14+Z9NCM7G0DGT3e7mHxVdhCSC/Q/wBFu4GCIUdK6ivq5s0IYTmdZLA1H4hgg
	fg3C0qOLAFl7mU9M+m8sZz6QkXbV6DxnJ3zkd3C7z5cqBUh/mv56OOtpTFY4mode0W6h/xtxKvh
	IxiR/GRwrmTkuoTecvGR8KFgL/aqyDeM5zIZJc/Y3uju0nX/Apomp+XwtPXvZfXDBcJBNxqrkyX
	2X1O+UhzOShBkt3PjHMny6BAGOAOvzBI0mF7hCRJGPr+lM/hYI3426MaV
X-Received: by 2002:a05:620a:29c6:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b245325b1cmr200933985a.9.1762505136057;
        Fri, 07 Nov 2025 00:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvBCF3YyaLzOcN+aoUwXSd+qKgBVW+y3iV9o0DDasJiaqAVotNnEsYQ0f5UYACwqcVlSpGpA==
X-Received: by 2002:a05:620a:29c6:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b245325b1cmr200931685a.9.1762505135491;
        Fri, 07 Nov 2025 00:45:35 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm184419466b.41.2025.11.07.00.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:45:34 -0800 (PST)
Message-ID: <c7065cd8-9819-4af1-a346-4daaa4e306e9@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 09:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] firmware: qcom: scm: Simplify with
 of_machine_device_match()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfXz0VgZ7RtzxTv
 CWhvdhDD/L6/R4jzx8ws4TnaqHwg4yXtD3dNNEZUcNtjJOoXytNjJJq045a0be1HmUt4fyg9St9
 RyrRaHNI+h/zO1c8mFEHjDmZVLaMw2S+r1r9CCqo0pZItQFYvfGMeKkKStuimF5MlbPAL9Kpitd
 b85gq5vAW32FBRXywDqV/VJL4VWkUEV8YtFyL/Q2UZxSEz3yqBc11v2zfmlRY5549QxVkT6ZKPe
 7/YFQQOMH7BNrwe7cSggPEzayGq54v1cNCEQe1GgFU+cI4/Piej02vwoTHM0WJEIcH8Kg3rFRdW
 9SxVLmP8uz/liPCOiIVbAeshg3tNyzG0nyLjQ1hRXP76GHJWaz9IVzjNY6U+gxlroKVVNwUaOE9
 4i9piY/4+2UgLm+lphErdrWUGVLCCQ==
X-Proofpoint-GUID: mXt1lzgNOtNco6twde_Wl0gJHQSvjxEA
X-Authority-Analysis: v=2.4 cv=GMAF0+NK c=1 sm=1 tr=0 ts=690db1b1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=TYptV6U4Xydj_hDeH6gA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mXt1lzgNOtNco6twde_Wl0gJHQSvjxEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070069

On 11/6/25 8:07 PM, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

