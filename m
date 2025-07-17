Return-Path: <linux-pm+bounces-31033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C753AB095C1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 22:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E7F17EAC6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0321D3D4;
	Thu, 17 Jul 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7tc7O3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3891FBCB2
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784407; cv=none; b=r6G5/UWyvZFauwPETfJ3CycBhKCuyFum1IHkA4qAKlR0cXGdJ/yyzSOrl+wTQcm1u8Di+L+iGOuh3wSP2PWSj+WVH3+vN/yUx/fek2drCFj6xBINhKn9+WfVrOCIn4ao5WDHbOkG08SLhaBdZKFn2UEuCgqTmxEHfMf4FsbNiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784407; c=relaxed/simple;
	bh=465kQ6yQTPhCxldTUvMEum0rUEyB5JyOVUpOTCjgfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0m5/pPqV+G8KC3coD2JrIdVqjcM31rSeSwH5vjOJgzUClDAKbOKn61W5YMOozKl38aIjL8EKOnW1sT+Je9oYbhxduMJ34mi0ytyc6ai5btFBLzGJq35ijKzuEMyilplB0HfkzKytSIG2dD+GlrK1gG1Lehv0woklPCyPmyWtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7tc7O3p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCeNRY008788
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 20:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8nModRSVGZSsZ5DL7kr1DuhtFiXYpOSlYAQ311KsRLY=; b=X7tc7O3pUqk4qN7j
	RfmUHeG5JwOtJOe0lIIJrPb0H6dHfDakZ9Hdx3/4GAkQ82gUPKRNh+sNOsVSiIeV
	6IilwXAQZnW1kjMR3cm91DonN0vW7efrAlRKtYLmhSIxjYL/nVdAu72YZcZl5pb8
	Pm3WPV246TQECUTJwiOD80QL24MkfpvfqBN30isWBTRUYRn4QGEJLQKqdZz/I3uv
	gN322mKC/d3opYz4g6BTwlSu5E38BELG24Oh80N4LdoCm8JaYcVEi23mRGCBWoxQ
	ncdY2SgZhChbbTk1m9zqP9I6E2cDYPknO7/6FFeaDgHmAi/2wMVeJSbd1k4Zelgv
	jmbKyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb93mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 20:33:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e344f333beso16108785a.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 13:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784404; x=1753389204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nModRSVGZSsZ5DL7kr1DuhtFiXYpOSlYAQ311KsRLY=;
        b=aktSBqJTGEcLmaalz6jLDVzdZ/A+c+hoiqGILCGMCKexu6nnFmOcAfWfAmilRCd9VJ
         OPS1iOHyN3V8FqUHfmSJMfA/CKAH3mEw3ihM72qEfWY6E5RfrArBkfkp5QTY1ghfPGym
         g71bX6eyjrRcHO+ybiIGLF1a5jS+zKeL6XRyhFv+87XYfVOjvI2OUPMiE38y9ae4d3jH
         IJGoT+oxb7nitOpnGbym+AGOvsyUjkhfxVMOjqsQ6esE9hsRFGGv208YpDzwEqBceu/H
         mJPgfRk5LKni6RajHHWoMtbJ/Kf622ub02tWhV+3dFYkmFH9tqhaobbILoQe+E2YTpUP
         8Vlw==
X-Forwarded-Encrypted: i=1; AJvYcCXPsvg+QfM2j9IO6eLA1vdhcltaKpLmTB0S4QMn0PZ12WAF3cs/nn2LoXC6nRNRo1RrmKPEC1g9Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLfamyd3uXrcX/r+JvJX37FZ0JPNJuQkbszLXxHLqs2cxCq3i
	fVb8Q+E4k2ltw3OMXYdF5lk70lgPoNDi7US/KxEkzL7aTJ9OKtcvY3ovhCEjNt3hEHQIGD+YlcU
	S4mxw9Yh2ng9nY3P6q+8qsGmqCEJ5GXzGMBQHXACdA6dv/SlLfkoCURXFjdqtRg==
X-Gm-Gg: ASbGncuT1cYsjQp49MH5dmqgFvlvmT2BXdUrwJd+UvsF4uHVZ/VRfggtu5ZIZ28K9ZZ
	FbU4v2PoqTOa7e/eS710gmZXeSZUsZvosc1JOWeYuLbAAMQ4P2K+LbH3YzwiP0gQPJLOnnAuhkA
	VOO1h3VTkTp1+plLmQA2xpXUY5jJxJMxSStxRBV1MzNDVC/37F386LJ+6Us0IV/xcpssduKRuAa
	6RhQGi9ntG9JS0Y3LzoYrAso4Iau9yWX5V9ttOYiHYjUd2cRY3dIJCCpgF94FyT/XbBtHZSDfjk
	X0JPMp9EJdrymGSqmtb2nuX9tAx+klaReZCsE0KwXYEQDZXI5iJuSZe6q2s/gxwr/xGB86CGe5S
	1iJp2wfZMd1yOnjnXwJMT
X-Received: by 2002:a05:620a:2697:b0:7e0:2b47:bd68 with SMTP id af79cd13be357-7e342ad5730mr507120885a.6.1752784403722;
        Thu, 17 Jul 2025 13:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq7ne2sTqDVyAUeSU+0dYOV0hFl3hEPNgP0CsgwNgE6XNHuWeZQZvq7BCuCRpH3GkUIIYwqQ==
X-Received: by 2002:a05:620a:2697:b0:7e0:2b47:bd68 with SMTP id af79cd13be357-7e342ad5730mr507117485a.6.1752784402906;
        Thu, 17 Jul 2025 13:33:22 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1424518666b.152.2025.07.17.13.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:33:21 -0700 (PDT)
Message-ID: <37932b96-fc4d-4321-8986-8f975b0c1350@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add glymur interconnect provider
 driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, djakov@kernel.org,
        lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        raviteja.laggyshetty@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
 <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ovap0ypZZ6KBvlUmhWEKor11zy6AYcA3
X-Proofpoint-ORIG-GUID: ovap0ypZZ6KBvlUmhWEKor11zy6AYcA3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MSBTYWx0ZWRfX4V/D78bbcWeg
 ij7aVghxCoIk9O47Jl9ef30guvFBsHciEyIU2zjVmmmsdh6U6gRHBrywqcCX64m5j1I9aLsnb3L
 n9H7p0JOSdbvot5Vnj82B8RL/P8gy0x4vlnyls0sWN373lxWhTaHXwLiJhVxZUiiF4WzXYnGjxY
 Ku3q6IePsUAmzn83UP/j51h281sQPjhXiG5qfDjXuI3aPKqRH5d970tbH5+MG3MNHWM+FkaecY5
 Br6JvECkrm6Gb+mfU+NBLpUhLYxjouAhOiGw7j5TC323kQL3Xmo2ICVGxbwr9cKgB+hsxFBIyM3
 JS++3jw974aUbYt7KKDw7D8iNoqKP1EC5Ou6Nk7GsIzT3KLy2MozZ4iyp+IulNz9YUN8vHQ4kkB
 20uA6PCp3OG7kO+uw8+KCjfNOkfOrmQIwa1K95vqVPSohGBSAhPFqBR2N3oj8MsR9CamRsF6
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68795e14 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=2uCcKERadT1UtqjeBP8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170181

On 7/16/25 5:15 PM, Pankaj Patil wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in glymur
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,glymur-aggre1-noc",
> +	  .data = &glymur_aggre1_noc},
> +	{ .compatible = "qcom,glymur-aggre2-noc",

Please unwrap these lines, i.e.:

{ .compatible = "qcom,glymur-aggre2-noc", .data = &glymur_aggre2_noc },

I'd also request you work with the author to provide the ICC QoS settings
for this platform (which would be good to see as part of the introductory
commit).

Konrad

