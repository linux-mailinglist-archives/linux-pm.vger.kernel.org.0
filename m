Return-Path: <linux-pm+bounces-39786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA6CD6DAB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 18:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BDF301F8EF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177F33375A;
	Mon, 22 Dec 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCiVEhEQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQ1Bg4o7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C23321A3
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766425523; cv=none; b=e+qVwp2mXOc0OVFZMpMDhV9OTgD1xlozHohpqOehqNWrYrCOYALbujd2lskGTyTdsM+hLPKa0uQOxepAAy6f0U2yUWgPRaRVLoUZO3155soGrnsXdDnhBl1DdarLxHu4y51Xw2rhdlMQD//8ZLoENQHz70UmBoH1SkNa86D0Pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766425523; c=relaxed/simple;
	bh=mDcYHWWDFCZ8abX9mVhTIcxFXGToPYmyE1T1wNNsIEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2gRcKbuUuI9aOfyPb5dcuq0n1pNdl7K6r1GimYvh+aRt39zKU62g3FIkyQ7+4LBVlGFm5Sc5RAgYpHh4XdRwhCpPFFlKGaZNU5oHTK3OyPBqUPaFvyWn6r86tEPooZEeuX12inDAUhcJqniGWq068lXWJmMB9zSQiscmBop6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XCiVEhEQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQ1Bg4o7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMECWgv1570353
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 17:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNreFgwKVVrMQp9bKV36Cv+4AeGfdYFXYCSfOTeRS/Y=; b=XCiVEhEQBzgMg1Td
	p/ZesAYpTQDZLgHUW+dBDIz6/9OMx2eBGLwTwAO5APTppzX5K++RMNAhyKpM9REX
	N+UINCelzSrq3uQT+tfy7wK/SYT160zat1fIWxh9hLmBS9fDdLhPaUAQHm+FiIQs
	JWKUa5hjFS0jZ4ksXjIB8vpOfCBKlnbmEl0HupChADqHL58JmzENyy9FMWiyS23s
	ufRj5E8m0WzY6LOB7pHsI/9H6Nu/BZWqN8EVPtqQETh2lWFSbm6LVXhqjgg6EQVi
	picuDhsurkVN8fPS88TxlpYBtbXyIdDKRoT+I0WHJRDrc+krAWrHAPDu7VWpeuC9
	2Me4xA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy0paq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 17:45:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7d24bbb9278so8271676b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766425521; x=1767030321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNreFgwKVVrMQp9bKV36Cv+4AeGfdYFXYCSfOTeRS/Y=;
        b=hQ1Bg4o7LliVbiCq6e6zFe8GkRad4CamgR4ZVAN9gPBy35/3FkNs/na4Ydkdlp4EX6
         8Utr3C/R3xnXUGy1WuXalciOq5cY2WlnlqKCNuu8NKVwClyLdU7XSEQCDD8aM+fBySES
         +Qc7dhhBudyN2sB0Dw1dtT+o7vwhBgMtymrdnWI09C7bovPV+UeqvtM9mzj3f+DqCKuU
         lcicagcHROX8XBsJciiFMZCKrE7oZts7tBRlpHNXTYHp5B1e+TPnUkIMg369nWP6HERr
         Dcc3k602NUK+oJxzwagn5zoiaivgJRcjdGFa34MyK5kE8C5ugghs2Ur8uTrMjo/M+vAe
         bq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766425521; x=1767030321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNreFgwKVVrMQp9bKV36Cv+4AeGfdYFXYCSfOTeRS/Y=;
        b=DuPSrONBYxMcWQPRTT3e6MgUDPQTr5JFOkaC3IFIg/i8hGhUuMBa9ZQJ/Y16xICoBY
         PMYEKuGlTqeCwlbZNkSC1YBJLY4etEUcccYCNTYZXnSiHbiz6luWtxZ0xYtBvQnLALBU
         BulH17hE4U28/Vx6Yig5KZJrul2fNAvenXyBE4rgtl9n01mj7Z95IskdjfKlDqqb9D+o
         0EUh550Cuv2phTdwEprbajlOI7uDbyNzjBJWn4CUFyIp80oOc0coNBM7KkPx5mTTBrf1
         ZoN7jTRLGe5VXzNakaxwCGQCmIDcohDnJfT8HmiUYPzCMU6qmOVcEYOjtcuv+WI2eWLr
         T2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdlDsxhBeJeodxXK79GzRSuNmyGXLdMZsHF8+IyAGAAgX1UciSEzc3NpUgUwTcUyY//j0kLV94w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfZHFqJtVP9d3bbIQoZuXd2tE5VaWawlAxZZERzV9qoC53934
	7xDCrVANiPhs1f1ovfUXpWbPaTkzjdG9cmbtSwA98577P3EBrr5csPTlQZQNrL9mLzZrKi8XAsI
	JBiwoqF3WDcu6ORtd7M8xrnLspkldXHE2xktQGz5BwDJdixK3x8fNGco7pYINNA==
X-Gm-Gg: AY/fxX6ngiiRx0NSyZcJunYbLqvfWpGOIYcJTfSKIfISMIOJsDJIYKYYrRIkNg/zAmO
	14NZX4g6mW/XV3LH43uczyCRYVZ0Un6IgvUI/4BqMggNpe3oV7c9eAgsDpVlPLXKLsNNGC1G91X
	LvcsKFB5f3FIidrz/SbVm/l2IMdnUbzQnyWjSFC35kxR0UphBYWGRcFpncPJH4yR9wYjXhTODbT
	j4zHLUnMLETQKXPVxKLX//rApMhE+DC6L0pv7JgNa+oGV9WXfgVIfbiX2EzkNuoHbu/0vItmBYA
	DPUlUm8c7ZlsFOAM2p5VNP6777Hy4ZiJ1tXkSnzZEdP4XvEkv4YHDD/Wh25RsaGgSg2BBlAuwOC
	HU11gFM5szlApYfAbHoRIgoKB8WSQdSFaDq5f
X-Received: by 2002:a05:6a00:3c8e:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-7ffce33f6f9mr10410977b3a.10.1766425520800;
        Mon, 22 Dec 2025 09:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSjEA9ajFMNhJnx1qyt2wsBG0dEQR3s7oZFVNUtpfNlBwxwsb7uE5zp34TNadcX7aJYIR1sg==
X-Received: by 2002:a05:6a00:3c8e:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-7ffce33f6f9mr10410942b3a.10.1766425520287;
        Mon, 22 Dec 2025 09:45:20 -0800 (PST)
Received: from [192.168.1.5] ([27.57.93.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843ee4sm11188529b3a.10.2025.12.22.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 09:45:20 -0800 (PST)
Message-ID: <3193e3e2-2b00-4c7e-a84f-86616c3666d3@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 23:15:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on qcs8300
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
 <4930a0ad-258c-45ea-99a0-753cb3c3ba6b@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <4930a0ad-258c-45ea-99a0-753cb3c3ba6b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE2MiBTYWx0ZWRfX71b1SKDW6Jb9
 GFDU0YX2SIQqMsIexgdCymXTKVeQjl01vLZ+sKYfc6YHfrbjlDDxdZnVbaJzigzxnvyMjDNNIy6
 jfxrVggLNEQ5np26vm0NieH/viUYWQoKZdQHnKnF4MkvYq1wJv4Mas8dWWZBL1L7A4yiHdYKGc6
 9ORO8QaRL8xTrqzvJSgjaXBgE8EFOHudEFFXUTCxXs40FNU9GvM0jNEeqS3uZcP45e/OWShW4wS
 PFFy9sYJwao6Xp4R02IuE2Bj6FSY2IUwOr9LWxPC8E778wK/FHzmA4GkfhgZH2ccK8QDa9r0qKX
 FNegGpkN6dfgOJ3sreSde4qE1QrGLb3udR2haqs3WN1AxkAjZaQR2tcYYbhNhbeHMKc3Ve21PSN
 Np92TbWfIBHdy67Is1zj0H05cc7YvX/6TG+TqX3Ze7P2QMgb9z3NPy/xgdYpIXhImWtKDh1wUM3
 AVuKGvsXSeWuu3oscyg==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=694983b1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=luqpl2TCSyK2LuNNAmtdDg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=izIGmOzjKg6u1_hBuywA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=i6qsmYmKKdoA:10 a=csto0wWSG80A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: XOsO9HvZWggyabH72lhAdHwFvq8Y5AVp
X-Proofpoint-GUID: XOsO9HvZWggyabH72lhAdHwFvq8Y5AVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220162



On 11/29/2025 3:15 PM, Krzysztof Kozlowski wrote:
> On 28/11/2025 16:01, Odelu Kukatla wrote:
>> Add 'clocks' property to enable QoS configuration. This property
>> enables the necessary clocks for QoS configuration.
>>
>> QoS configuration is essential for ensuring that latency sensitive
>> components such as CPUs and multimedia engines receive prioritized
>> access to memory and interconnect resources. This helps to manage
>> bandwidth and latency across subsystems, improving system responsiveness
>> and performance in concurrent workloads.
> 
> 
> Same problems with your previous and other commits:
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> "on qcs8300" is redundant. Prefix defines that, so use proper prefixes.
> You do not add clocks for every interconnect...
> 

Thanks for the review and providing pointers, I’ll address the prefix
issue in v2.

> Best regards,
> Krzysztof


