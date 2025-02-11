Return-Path: <linux-pm+bounces-21842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE47A30FD6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130A41883A11
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7950E2505B3;
	Tue, 11 Feb 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8rw2wrr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBF1F0E32
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287892; cv=none; b=U1nfRmY9Ct7xZONbaZ0qvSpulhj9jL1swppb9dh9UjMxmE207qR57g0PIJsoh36KzdwRWB5AnzaKIAlWE0B2P3YponRdlQS7ryczSH1/6BGbfCpZW7l2FaEz9JxO30f2ZiZ+mAcDwSi3VQ3xwBEZIHsHKNN41pE3HIVReQjBYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287892; c=relaxed/simple;
	bh=Bg6Nt+8C5j+0uyXnIEaKjL/2chmotYRWBmv2M/smtRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR9hbHNTjE3uBQXBdUJXdoX7jx/wB1+DkH7a9krMmGgQuAlrhUZDKYr4/uuhToeICZYHG8+Vb4vMRmSZerpkM6FusTfnxLv5NxdXGnY6LZqvecUVyJbrQJO8VLYR00iL2IXNylS+BDYL6wepg4CSjd97OzL1ZLHXmYKURD9mcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8rw2wrr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B9t2U6024306
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 15:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e5OySbyHguqdotrWL0HqWl8v1uqJmDtsgQTUaTpXBA4=; b=Z8rw2wrr0KDm8cSJ
	ORCU/NYvMIkBYjf5RynZfJaS0XWWbhWC80QIPlRTooZeu9p2V+foeMyt1kPKcojq
	EdB+qoLgglyaE0RKi0mRRf1ECPbW3BmXv+rzq3gMZRWiKYrufIYzjJUaWzNTshB7
	oAt+jQAG9ra3IPNdpr1+dL8Vui6oNMxkA+B7MfyoIO08/bRI1ChYtWbi5WSq4HdY
	UrqFTVl3TGoQCsb8985zmCyhPaVSR90lbFTFZddNGobB95T+3yuWnwCeDNEc6O0y
	j3YWcJ8FdZkt0PpglcQx3X4MAeeJ3YOsfiVtmrSpPolw5kMX+JYFWQGgg39vDMfe
	ZMMFKA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r4b5s08m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 15:31:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-471ad2e69d6so349071cf.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 07:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287889; x=1739892689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5OySbyHguqdotrWL0HqWl8v1uqJmDtsgQTUaTpXBA4=;
        b=Iy8sCqai6mtieGQE/vi8+cPQs/4Npv9/Ay7kiTXeA+CzXpn3adaMGV4bihbOaX4v0a
         mBrSo6eh1sdCbGS1eQe6EQrFM+u4Pg/TuJjDEmU0XoorrXahXjBFsXtuelJwKop22XNM
         vy+4KKFnRN7YQCGUHTxpDDH1bLMZjVKyxuPfFCAICjTXPnyDbnSrQlUrkxLX9Kzxe8JT
         I7r+azVrGATNjtZarIfGcuNRnGkuPw3EID5HJBn2d+HDTF10qGLWmQUJ8a1T9xotBPRt
         7pd+tVHy1oEKO0HvspFBR1nhOP6Q4TXJ3/KOQjsmrs07gcg9QbSs+gk6UmEbNu8wQRHP
         Olcg==
X-Forwarded-Encrypted: i=1; AJvYcCVOfi9WXwAG1GrYH0VDavvAj7HvbnJl63R3LJK2xS6gWAL+P3CL2chD4wDPUA14mHyV60+EQc5feg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu96O9BPQxptd/pVPyw5xgQNaQN+PNSjLLNUxaXYMoebE9d4lG
	VZ6IaHB42o/zbVr7d0PmofDr/sipqyU90wHVMsbmR1Pyg+/oREJ04Nq2VsifP2/nYv49PAq/LK2
	omO/3wZ9CPN0WAKlL/rEP25v5XPe5zxLcM8hDtsKLVeuz7fo3H/8zbnUqWw==
X-Gm-Gg: ASbGncth66EdoOBhq4ND5OTbFSgfj+NTYSfY5xkZ8GIdRTAB/1um92yoQr52fWktvVq
	7ThwFFPbRZRZVDbmAmTp1UdjrXZ71tt0oiwjggQk2Cp5V2cgGUD5uyJrGoXqX2IZIgfU8G7aj+y
	QDZuby8y69gRJI1Ip6HhdweOO1FN1pSaLbg850FQzSRSV41oQ+U0nfnjZT6H/jrxoURu+61sikZ
	ZsXUaFQC0ooFQfYSlMiWvZHKdFaqwBYVol3bPTbHUK9ztMvIbrxBwg5RHxnJcyjA/X9ExrH//wR
	GJyr9fRmcA4IVOrtmY7/FDQVO0PbfivwC5mlYpUUn6jo4BZG/ILCJCPkvwY=
X-Received: by 2002:ac8:5913:0:b0:46e:12fc:500f with SMTP id d75a77b69052e-471a38eb6a1mr15565851cf.0.1739287888712;
        Tue, 11 Feb 2025 07:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7FgJZnYB4h/Q3ta0guw1kWk+ay0aXvWhv0/ehdh20wsL+3hNZVueDiuf0CB+w+LhrMUtPNA==
X-Received: by 2002:ac8:5913:0:b0:46e:12fc:500f with SMTP id d75a77b69052e-471a38eb6a1mr15565691cf.0.1739287888319;
        Tue, 11 Feb 2025 07:31:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d72ae04fsm209952066b.46.2025.02.11.07.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 07:31:27 -0800 (PST)
Message-ID: <93a1bdf9-52a3-4dc2-a2cc-28f34b7ee0b5@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 16:31:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 7/7] arm64: dts: qcom: sa8775p: Add CPU OPP tables to
 scale DDR/L3
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-8-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250205182743.915-8-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gmPZoVzQr0mpyFKldjemjT5zrO51j2zI
X-Proofpoint-GUID: gmPZoVzQr0mpyFKldjemjT5zrO51j2zI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=994 lowpriorityscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104

On 5.02.2025 7:27 PM, Raviteja Laggyshetty wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Add OPP tables required to scale DDR and L3 per freq-domain
> on SA8775P platform.
> 
> If a single OPP table is used for both CPU domains, then
> _allocate_opp_table() won't be invoked for CPU4 but instead
> CPU4 will be added as device under the CPU0 OPP table. Due
> to this, dev_pm_opp_of_find_icc_paths() won't be invoked for
> CPU4 device and hence CPU4 won't be able to independently scale
> it's interconnects. Both CPU0 and CPU4 devices will scale the
> same ICC path which can lead to one device overwriting the BW
> vote placed by other device. Hence CPU0 and CPU4 require separate
> OPP tables to allow independent scaling of DDR and L3 frequencies
> for each CPU domain, with the final DDR and L3 frequencies being
> an aggregate of both.
> 
> Co-developed-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---

[...]

> +	cpu0_opp_table: opp-table-cpu0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp_1267mhz: opp-1267200000 {

Drop the labels, they're not needed anywhere

> +			opp-hz = /bits/ 64 <1267200000>;
> +			opp-peak-kBps = <6220800 29491200>;

(921600 * 32) etc. to reflect the clock rate, please

Konrad

