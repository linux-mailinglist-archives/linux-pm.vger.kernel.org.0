Return-Path: <linux-pm+bounces-40098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C336DCEBF1C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C08863008559
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20A315D3B;
	Wed, 31 Dec 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1+lzf8R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1UZN//W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCE311C2E
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183646; cv=none; b=uAw30n/2V63WKrN8LXdnJFTq+NHtfUWv6vUCAs49wfdLoQTK9oxxr2jbqEJn/xrrSL5Ewp5WJ176nc3tw5k6A5V9pURex4OnbawDTnYlwti09xqTppGgbHsUSrCgjXDbqNRCrURKCPBVfgKrVP3htkqJ8eNUMjoqOWqlwqP12I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183646; c=relaxed/simple;
	bh=MQmo3DqHrNqw852pxcHHZYIycvRtZz0hHyNxKMK+caw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfYv/fW55X78RPr1bX4AX+SVhZGugDra5rS5JMtwSFb0LUeeti7I0fdopkaGqjNyK7ngNsEkN9X5jXu1xXCoVTiv5sTUt40FW48oD59kHEBvaff9hYRBWcQ09lFcyYrO3+vhkTf3tymowiaUeO1duTec+/yEo2G/HOX34zHGcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P1+lzf8R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1UZN//W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BULpo7E2916171
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=; b=P1+lzf8ReZpj3byR
	hyecp0nAeX6fcWHGEXiK1bpbcfhdPjFhZStXSR4KGbAdbWUODhI/0jaG+ZKIIxK/
	9+c08q4AfIMdwTg6tGJlDuFgZsE2ujnVSQUJGJURAAKwTIOOqASq51eN2aAOrK5W
	xfgBrL+JmzhySsPyzFNKvpQJA1xubTL77TKekny0CwPlYJW8Dt09uW5DZGnejmPR
	tpqXB5VnPjZXHqlM8P9tTqe05TtSaAJpy4adj1ytUGjQc3knloZChTxwhnAlzjzk
	Iko0kEPxEW5NH52gSgbOM54c22sg5czZtO2l/t8aF4oAz1M76ML9dtenRsZhaBR5
	qUpqOA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky3e1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:20:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88880bc706cso17230166d6.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183644; x=1767788444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=;
        b=h1UZN//WDEnKjJQ0tKE8UQc9TAatJ67vr3AfcipS6UjhZ4bkctv51G0GyK733eoeP2
         8R/V9CUULxviCjiihBqqG02Upy7tei+qU3qBgkMTp6da+lfU2T5bnzPtlsBEtAymtJbd
         l8Shwi5i3pNeprWXdeEadmmLw8UJ2mMIchg4kQkRd8+lZkvEtz/iYPR3wSvj0aAgjaeM
         FHUpj8u/CFoFKm3hXtZ0HMcEuNk19k9aiKMyopFbF1BnbCGre2AjceEGleSAhn8eyZPa
         4R51k/pH8hYmyTXuAFxHgRIbmOb1EAgSr3bPxMc8SPuiAB4kr7AuRZnMZ8R/Q1nC1ZQQ
         WvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183644; x=1767788444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=;
        b=u4wzrmMZ9r8I+I3nDT/RP1iy4xXIAuq7gyuZ/6ucR66QoMQ9VKN/GEPNFi3vgmcT5v
         AqL3M3POfh6ZUtO0974Ml5bkeYsVjIfdi4ChiA8C7Tg0vyj8ZGUEhFFZilkYliXH9w5J
         gNN8mj55Hu6t5maIww304I8TQNdxLYOk5jZ5x3vP4y6o0moTR73p+vI9Af8KOyxlu1oW
         1PFK9rWCJ1bHl6RcFqAwaDWmJkenz9XJl4rNhYyXGeAbA5L+WF/U5Ujex8PTK/vPCmkQ
         iACv8UiqGXnC0Y7sxxgbqz6Ux6DORxE/eDrDnEkopNGmywMcE4tMlESCLNqoGMxh1zj9
         Ze8g==
X-Forwarded-Encrypted: i=1; AJvYcCVu3HtsLC72mvC9eXJ00m7sKmGFVscwXX5IUAAkHLVCm9eRe9u9dJT5ARZfWJ20pWAUwEfzHeMxxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGrQoUbPxQWP3AaAOxzDoRD3hMTNn3ad7vVEPw70+4O2Lkpxc
	C5ELjXepU6lHk47/QB0hZTUN/geYdkvylR7p/SGG7EyKbh8mKsG+4zmvF2COWskVDaMIBRM3WCt
	iNyuNj2u4sp7J/5f9gEH39jnlWROImiWIpEvXfqvGGg0vGQcq/oEPsBidnsZKuQ==
X-Gm-Gg: AY/fxX7IO0ieQOpQBwDiz/ntL4jh8Cmnpua5DdlFqIo7BwiykLF/biCT26EdTG7W0A7
	d+CJRrJ/5yxP1/rVDf5tSyN6ILGxCxK3aenwhXRUew6nnnt19JiIvo9n7GgYSyl7RTcETYmaYOz
	2+KBilszGxh0iVjgIB0NVFJiZiX7+lJUaymTIgiIcybZRRTHkjPouFJirvphr7xrw4T8QnDbFIh
	tDWd8v5558PPRmB+NQdFnyiEjy/A5VRaFiYJNT50fSB4JxnAWiXCcZ9NicIjBiKa2U3R63ZaEqZ
	jRPZpDMVN94P5zuGWQaNchfvxCaLYRlE8m4ywcNQNgxux47gJJ/yWpsKRaer11zQUeL6j1+nx8K
	/1NF8R8bFcFc38nsj2tE7bdN3RuC9SE5B1TfzLbIXNgLOTm0kDqYpw78TTR3PxW0RQw==
X-Received: by 2002:a05:6214:528b:b0:88a:522e:f1aa with SMTP id 6a1803df08f44-88d876fef2cmr429758556d6.4.1767183643736;
        Wed, 31 Dec 2025 04:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNxYZD2jUzi4kfyb+ZH7BBn1xDuW5BG9mO7Ob5u6zKgvjm1mqF447/ECV5NVNX2+vlurqoxg==
X-Received: by 2002:a05:6214:528b:b0:88a:522e:f1aa with SMTP id 6a1803df08f44-88d876fef2cmr429758246d6.4.1767183643248;
        Wed, 31 Dec 2025 04:20:43 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5ea6sm10827713e87.5.2025.12.31.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:20:42 -0800 (PST)
Message-ID: <4fa4a6f3-cc38-452a-a724-d2dc19219516@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX2F8K4EFDrMKK
 ZZQaAMoN5FsrMH5cqXHodsvV9IeDTcKFrMPY2v5e1VEEI0kcrwMmWa2huOoRljRAfyfX1QOwwZa
 dqy46FPqXUbkIKBoxwehK1IaKXa6QnB8Lca/kVdue85oZC/oLzbxfZJkSnROIWL222EFfN1hLAz
 7Prkp2iVa8cOCnUPWHrgaISshxWMqmDmUtoDFlnMwONoFgnHVyKkAoRqC7Yj1wNBe2H2SyGZKg7
 PzkqaZu2/+j8isrQJKb70amQwYjz+uuoexac6xm73MyTL8vbcrjeEI36nuqOMsNWwk5wCK805cV
 f0DbvMzWRrC53spinr6D/arXDN15DF8xYN3LlZRSjv+ExFzT5ATH8W2OIPMYMNwg+d8+jLyjdbm
 rBuL9el0+jVWML+OfrXP7DUp6s0IeRLI6fjUDvFC5K4TpzzYh4YFO74smBvI90+Ng8/HcOe4DZb
 NLbEOgkGWoz/jfPxzTg==
X-Proofpoint-ORIG-GUID: ACy6tfijStqVv7mclwGJhKgdx1ZKGMog
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=6955151c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ACy6tfijStqVv7mclwGJhKgdx1ZKGMog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio3";
> +		function = "normal";
> +
> +		input-enable;
> +		bias-pull-down;
> +	};

likewike to the previous patch

+ please confirm ch1 supply

Konrad



