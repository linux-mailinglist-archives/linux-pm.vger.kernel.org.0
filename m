Return-Path: <linux-pm+bounces-28563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83825AD78A5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588611891D67
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20C29B214;
	Thu, 12 Jun 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfVLnwJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284924887A
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748012; cv=none; b=a7L0UnmLxvy6ELzL1hS2bYxS1Dc0yAEwrtp9pWPN2aW7bUVKnA3Smg1P/uMaGYXaxaouof/9YRWvsh+SbSZbxe0e1lHEIY0Nf+xjUpISZzk6O++6i5Ux4s4q4t/nNPj1qoEnVcbE5Eyw92q6YbMCm0UrYp/9PAX2k0kXyO2vDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748012; c=relaxed/simple;
	bh=TC+OdAXhGoMZG6SvmmASRYnqvkbHKHrlXYVoGxDrKac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWD2rCopD3eAeG52xUX7KJ2T2ug0fslCtKXPy0PFEpAJ6gyar8cG7tFtLlA3i2ebti/v4bgtEyfmtuGr47/ug9dcBsAaZGJuKoC4IIilciuYkzdQGd/zIO5QpUpA9oaS2jIYCG+4yvv9iGciRPUEbYVCZMiqsS5x6abRCWNLNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfVLnwJ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CG2n5t027189
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 17:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0/F9DH13AExJPe3SmFcpjEpcSWprJ1OtQ4zge43iQr0=; b=YfVLnwJ/2cuMQ0xS
	3hRoocw3/7be204I+4jeZ8T88fUBEEBCFCd7wzBRMgMfPsoFc+C77dBvz0hWXldH
	hV9CHTzS23bJI14nggxxgwSHQU8HzIAVWi9VIssfXyszGmvJYRPO9Kcl88AKa5X6
	8mmG7RlmRIppDFy281V6EzPhg1GKqnLJYSQxzoMG+Hnsfz3w8GpvKDgiMWl3xPGc
	Ngbc6m67yTdNzmUsSxM3yHzqQOheRgOsRN5KzogOGbsTB/aQDEoRhRipN7sTijyq
	4+acEeDQs31mf96eNdQILUiP4qJ/2HgRPkmJe9cfogD+OqnRyVfJv6B59SC0isYj
	X0rizQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvh7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 17:06:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d0a9d20c2eso23400085a.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 10:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749748009; x=1750352809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/F9DH13AExJPe3SmFcpjEpcSWprJ1OtQ4zge43iQr0=;
        b=LUYioqnK1GPl0OPBgLyGN2BIXBDrINAHGj5JQ+13Vbfzyzbdpldhgg0bE3hDoWuWWR
         Zzetw2R8QpUaEGYRYSQ/crzDZ+hb3WTNkM9jYpSEQY6g3Adc0dnWDKYzLEnWlpAvRg+V
         RbG/ikIdLQ/QszrAYTyVQsA+N1x2v/7XNQmqY0GHfEri/7LlsnEslcDjCIorzG72Ymcx
         L6E/5oxKJH4u1ikAclCoEt+qXmh5yaaWn8R1/76E6jyTuvQB8vv2v7jsEoZ1dAv6G96C
         1Y3TQ2qNd4WtopT+fSSBz9Ipu+vvHj74gIoyggoKr6489D7UOd9RjJAlszCQdNQWzNlN
         QeoA==
X-Forwarded-Encrypted: i=1; AJvYcCXEERwDjsd5pF2gy9xKobHjL39c3mzH2OfXVUbqlAaRd+xByXYYzY7uSkR3jN/UOHSW9nEvKvN9Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbvk01EpSPg+Q5UanDuDVzGRgK3BZOBu1oU7jcPISGT+hdQGZR
	8OVsF6sUxBB9Rc9iWItxIdwxHSs1v0iS3SSyCqFL8//gymFMQne/KUeV5IvdORVizUCQKhogVT1
	DVIQ944sVhEj1Y7SOPhrcvUo1YN1qjj+7oCYKEIa1HimxLQiPaX57K6AQcC3REQ==
X-Gm-Gg: ASbGncvkATU29F34J7B2QkqwvrDJgT3QYXpHz/uV4PFqcUTu2IJSXl/A9HkGSvKu5jj
	wPzM9g305e83rca4D1velGXdKBq3lp/01V6tMSP5fjwDTTOUlLGVnSSisxd3tLz5TjLs5pESOt3
	a57IJDkt4pJWPUId9T0b5FD6GPLjJGGYFj5rcfgbDZK1x6cn/z1tPWwElsBl1QBHEn72bQJAUKe
	ersEhgO6VZRXZQeVAmExGaUujCs9ezH1RJAH/eio/WYWaqW5NCId8213+tEVPYaoIPhZ0yufo2W
	JM1/nn72/42cVcyFfV/o0dKf9NQS15BgGHjiyR9mEPAUAL1TI4hoCUqig8ketRB8hxNWOPbnaqa
	BGSM=
X-Received: by 2002:a05:620a:6008:b0:7d0:99dc:d027 with SMTP id af79cd13be357-7d3bc44b583mr3223785a.6.1749748009045;
        Thu, 12 Jun 2025 10:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENJW6VHvwcvJhbYXcOXbguZrhWncdGYuUMo8aTu0ygAXzgLYZHTyZcyt0MfTt8BprUf2jNDQ==
X-Received: by 2002:a05:620a:6008:b0:7d0:99dc:d027 with SMTP id af79cd13be357-7d3bc44b583mr3222585a.6.1749748008623;
        Thu, 12 Jun 2025 10:06:48 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadb22acesm163057366b.103.2025.06.12.10.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:06:48 -0700 (PDT)
Message-ID: <c29e80b2-4b15-4823-9821-137a9208f632@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 19:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] arm64: dts: qcom: ipq5018: Add tsens node
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
References: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
 <20250612-ipq5018-tsens-v13-2-a210f3683240@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250612-ipq5018-tsens-v13-2-a210f3683240@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JaUTr5C34jR_FoOkcGayWjqkM0d0zhO3
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=684b092a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=p8e7PeVTpa6WA4hJRsUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JaUTr5C34jR_FoOkcGayWjqkM0d0zhO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEzMCBTYWx0ZWRfX92FauR6O8LjN
 4J3Deubty2hRTupYTtRuxqIGBzG/QDCSkn6vcojc2yFh5uV0Q1TemmA77KR7wL2dlfpZMH6u92D
 thumufT8ImP0apLwJa0HGhMWghhrrK7sh+iUyy+uUWfGBwO5I2/7la2EqMRgBHvaOw+Kz0W0TMA
 92/tZjLNxxjsnRHmR5O7xtpHTGaxOO1wTOUQ9ACu5bd6spVDaAVOgHhfhHY1GHsRVpR8VkAiKro
 luugE8NAhK/RNx35/yWjWWcTOrHq0aPXXZM+cElZan3g5WgnErzdhkNrG51QQZzen1hMG3Txcx1
 +3V4bV0pbV6VgZCNoCEpoMkTZ93+PxmOBlFwpLTVat7lpwuWkW6FLcwtLW1mWv5QOA4XzU7clyu
 gqdu2nJ+Eigbu+o6w+vX6MV0OHrD3jtCePraS9ttP2LGasjOVMsCcWa/cfSzrD/Ulf++DviR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120130

On 6/12/25 8:46 AM, George Moussalem via B4 Relay wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

