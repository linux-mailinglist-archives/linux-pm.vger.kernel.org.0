Return-Path: <linux-pm+bounces-29665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1626DAEB812
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695E41C45BC3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368452D8797;
	Fri, 27 Jun 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VlHrQhUg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F072D3EEC
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028505; cv=none; b=jCfRcLBVBh6Mopc/BVzFo04wUSCkVe/AKSARQHKaETt2GtMlucS1zMSrp1uR3JVltu78RnEj/TqYwN5eUjffUR4F1J9Gw/YO0AGVglr7WyAsXNe3GdCeAB2FbqoD1u4FXzeEDsq2z5+5RDn44a95xYVAhVoiuhEvQ0sDETi1wOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028505; c=relaxed/simple;
	bh=UuPWtR3N+BbYwvO2xcIwzWKAR1tRGm1+TPbVRsZ1wvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrHy6Osn6PpJavu2ebjSivbiV13pLYHZGYtYOYIPhoaCI0NT6iQn8/BhrSb0Q1YqXMYzf93lyzs5zXoF+5I31fNcSXGAmnxtBtCSyzUAKdkO3lV/zB66mxMSipB1okT4PAU0EqYkknAjZc1TrBuXmyIIQ7pwDkJ4FHKjfM65of0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VlHrQhUg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBVXQ3028766
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 12:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJWdJmJzkwxzneVd84Z5q76Y6Bh4N9QowRdGtG0g2/I=; b=VlHrQhUgCUTe2FEP
	SrS/yvTa7IfH1NPjh2VtHifLnvJBWvAc8XbC6I+RmVoeZ3BWBZ4iKZAWXeEgOeii
	JOrtt3w6h52pIgqSs75j4fKbHRSFgbPNdh6uzA5/k+ep436xbVJrotnLoCuiZ7+f
	lceEvR/ecQvSZWVzI41UA/Mr8wBNS/1uK8RFb2ljXpZ8eg2PnS+gTRmoL/QIDM/X
	1u1ePRNMfVfiMwAlRlhBGp7Q7wHqrNZ0HiziT62sweq18Yw7y42Y3u4DIrr62ApX
	K+NwYQlK5FVmOc5HsDkNUOu4J5Y3BpSzmVlOkjyP5AseuIFaQOlvFdfsySk4OvpB
	8dUPxg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47hkpbhhcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 12:48:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f7413beso5984056d6.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 05:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751028502; x=1751633302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJWdJmJzkwxzneVd84Z5q76Y6Bh4N9QowRdGtG0g2/I=;
        b=OHFPuJDFF9ZpXFIM0ZISC1UjFBlDNcwfGTPHEK0NadegzfMcgZZpHQn4jDQB+IWuqI
         L7T7BlProqlpFcokFWBjgA20a/FLU9OEotWIUxrIDdg8CfRLjFqzsqrIY0NdkCCyJZQY
         IQD1Q8GmTh3oTfkzHApvGpmhS4jwhMbElS4yvfaASxxA9dDtATmsxsSr4PRLmRJwbbA2
         Y9iniuiam/dl/2nLSagfA/E5pLwKYLFHGu5h1VzlBmeBFuynm6O49J4NVgWn9/dDp6Ou
         2l7atJMKhN29Nzyzq+ZUzLPz/M1hgsoEiQNEOXAit6ZX2iy7jhYhtbnwgUczAAXMWWLJ
         vHVw==
X-Forwarded-Encrypted: i=1; AJvYcCVhmgAJZvxLJA1IjSemc11Fd+sFofxdjb6GkOndYlWYHYkfJf3Bn6eULDnqq6RmzpQouZMLWzSTNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyMQYAk051NJN3A0kjuk0/62FWEgoAQyeZGJjiG9iClEj61qK
	np0bKqOxZ4gIK6F4YOX9Wf/9VMmrilq+/jsuvd9B6IXG7gUtiZTgVIfmjqvqzD05OY9pofLMk02
	tWAhDQ4oJ1//KNNu8wisrIYW6OA7OLajYW1o5jKgArNzQi46pLxCsocvyPDhv4w==
X-Gm-Gg: ASbGncvPRCHCsxoXuUP2bYXEg8lqYTWOnwSERGesPseSkeNuPArHL4Iq1/TEuaUfhZb
	QtsKXJZMAfTAJijWlUXyFvgVIXBjtBu4WZBq9XW1z7P9XiGpoLMfMAx+KXC/qgqmLqiLfxE3t2v
	QM8Ckw5OaAXZoPF7rm6w7KMJmsv7fjzjdPPY2qVX/UFPK/G3JXk9N2Fe/4ZNlbeoScV4+JEO/Ea
	KYVBlQeRm4CDOdgQcpHcJHkZVcZJWZtqR9yK3lse7zcgzQ9YvS6NfVQVswKas3pj39zYL14YhgM
	MMDJFC1uEr6vdaCB6GJGwfl6PpWz6otvn5jQQdkghpKEllxB4SmynsyIF+BTenb7Fb1MKxUXzX4
	rZV8=
X-Received: by 2002:a05:620a:4881:b0:7d3:e06b:1d60 with SMTP id af79cd13be357-7d443944ba9mr176785285a.1.1751028501570;
        Fri, 27 Jun 2025 05:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE+7cQBsQwlzqB9LaJqbIhJCazfcoQVZVW4hsNtBTvL1HoOy7IQ4PoeipK7V/yc9W7r4biBA==
X-Received: by 2002:a05:620a:4881:b0:7d3:e06b:1d60 with SMTP id af79cd13be357-7d443944ba9mr176783785a.1.1751028501049;
        Fri, 27 Jun 2025 05:48:21 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae360e6ce54sm64278766b.37.2025.06.27.05.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 05:48:20 -0700 (PDT)
Message-ID: <3f8bcecb-4c5e-48b1-98be-96f3c0c8329e@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 14:48:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider
 driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEwNiBTYWx0ZWRfXzXG5YPj98soG
 9V8V5mVCZOKtPWMzjDLVLbW8QrYW33mG+j0+ElWDYILe6UaORnGu95cSxZ4BdMgAmqo22dVDjVE
 7Zy8VMIeOQFhQ/m1FtMNAxcOYE46DnB+QIee72Um+rUSutUoAfPmVZGxkPXeBor/rqYF9wOoFe4
 2X6Cj57wrlLGFGz5ubNB3nVVoqeBLodROxJKUtWkiGclq10hJcv80yNVxmRDGiziCf6mUgKp9kW
 1rGqjZMO9kK8LOFCG+D0pG/loGXoiq9r4a4C0QhWvq+PAlSWFhWqOk9rPSQ59Yg20S74ClpCcqH
 YBndYnjtT+YOti/BjPi1ujtL6Q6xacQWuAydVsZL0brkaIKcbGA3OcAEaU34gAxjxEPeEidTakp
 AJmbIjVx7sFjKayaDxWn6qmqPUuGTptOirCg22Bo3seTLN+XmMyqJhzcnQcjdSYvpTPuW9Co
X-Proofpoint-GUID: FZJkPs9DikrDPuGMoII6zAV8V3dYWcak
X-Authority-Analysis: v=2.4 cv=AY2xH2XG c=1 sm=1 tr=0 ts=685e9316 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=-wJKSiCeOC9Tbg0mKYcA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: FZJkPs9DikrDPuGMoII6zAV8V3dYWcak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270106

On 6/25/25 11:13 AM, Luca Weiss wrote:
> Add driver for the Qualcomm interconnect buses found in SM7635 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm7635-aggre1-noc",
> +	  .data = &sm7635_aggre1_noc},
> +	{ .compatible = "qcom,sm7635-aggre2-noc",
> +	  .data = &sm7635_aggre2_noc},
> +	{ .compatible = "qcom,sm7635-clk-virt",
> +	  .data = &sm7635_clk_virt},
> +	{ .compatible = "qcom,sm7635-cnoc-cfg",
> +	  .data = &sm7635_cnoc_cfg},
> +	{ .compatible = "qcom,sm7635-cnoc-main",
> +	  .data = &sm7635_cnoc_main},
> +	{ .compatible = "qcom,sm7635-gem-noc",
> +	  .data = &sm7635_gem_noc},
> +	{ .compatible = "qcom,sm7635-lpass-ag-noc",
> +	  .data = &sm7635_lpass_ag_noc},
> +	{ .compatible = "qcom,sm7635-mc-virt",
> +	  .data = &sm7635_mc_virt},
> +	{ .compatible = "qcom,sm7635-mmss-noc",
> +	  .data = &sm7635_mmss_noc},
> +	{ .compatible = "qcom,sm7635-nsp-noc",
> +	  .data = &sm7635_nsp_noc},
> +	{ .compatible = "qcom,sm7635-pcie-anoc",
> +	  .data = &sm7635_pcie_anoc},
> +	{ .compatible = "qcom,sm7635-system-noc",
> +	  .data = &sm7635_system_noc},

One line per entry, please

In addition to what Dmitry asked for, please also look into porting
QoS settings - those will require additional clock references in the ICC
nodes and as such, the bindings will be altered (which we'd prefer to get
right from the getgo).

As far as testing goes, there may not be any apparent perf changes, but
if you get the clocks list wrong, the device will lock up at boot (unless
you're booting with clk_ignore_unused and friends)

Konrad

