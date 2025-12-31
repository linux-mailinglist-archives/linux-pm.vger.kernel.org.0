Return-Path: <linux-pm+bounces-40095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B6CEBEE3
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA11300EE44
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05C30FC2C;
	Wed, 31 Dec 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YStJLcQ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqeetFvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF472634
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183475; cv=none; b=Y2H6Z5eb68R7ocbEIh7Y/FPttcKyK3qK5yFOWEX3ghmaUQOd8GlCmQeU2cDDA4Fy/q481Uj4MSe2LxFa3jk2x2MX6CNRL9j6OpmPF7eBSFEYRy7jQHM87ra9u1FZFpbJKvhhC7OOuyCItCqCEW+HhBgSYEW6M0qbRzvZn/tmggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183475; c=relaxed/simple;
	bh=gcWjQ0ei8NJ5xBZ0hZlXZvs27R2RGWslCP9YD3TTtLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/knQO+TYDjKjD4cfgQZvKWSDq34mcxQMWWdP8uTH4vHV5DaPd2SJ99DM3kmL3MzSt8fJz0hCedhIuVWebKl9S4zs+KgKz88f3uG90i8G0Tr7VUOSmTqHlGy7XZRdiYuGSJCD0ad5Z1HqZbfLj9S+lAQX8ArdHXvP1R3HiC2oK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YStJLcQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqeetFvo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVBpnNv734201
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=; b=YStJLcQ/1gj1QPk6
	WGuc2zuuj9YusxG62FdQwA7h0YomzJC5GzziFKj+hKRHqULsP+Cw5zcTarpWCnFz
	uRnUn/5lykugUEgRu5XmtjAksJR3U2c+z53bM5DR7d1zWAjx2PLSJp+ERoSKFk9C
	mNFvcxyXdmKNaKuxlpl0ui4VrF8IxGvRGxIu01R1Y4/UXmnL2UTGncDDRAkcNpQU
	cRqjlMk9n/qmplXKUrRptyC9CM80vtB92iB7N/CVmey1F1Lg3nhvr9bsdeOaRgQI
	2PY+g1zVKxP2t/2nVpb05a5Wa0Z3x7VWztkqmz4ZCaAKgcV0FHdSiyFGL/pH3lAy
	mZVfSQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0sgv9t2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:17:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee07f794fcso42586331cf.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183472; x=1767788272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=dqeetFvoKH4HrRlWz45xfpVyz95h8QBhoCFjhirTtobQ3rki4o6z5WTQvFzsgS8Hlc
         ZB7JwPh1nz0GVYWvSRinbQWcvWlMczehNqRDrPpC7refHPnkQExQkTwu8SOiEFsR6MER
         lPtG/k16XnJ0cgG8X+6Sqt5IOmMymbDU2rCwkJSilqswuJewYJ8W0QT4V9x9sniPBRVH
         PinZLxa2Opwf1pnIe55ynpgD2/IqIHPVpbAU49YgIGcqkrg3dM2cDAJqf2Vmxi65lZwN
         I/3sC/fTqRc9HedaURC8ylQbDln5tY4zd6w/APmQo3eMtTC2os9mkw5qZjeJjN+15lFI
         lB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183472; x=1767788272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=wmt4WXW4fm17VeVvVhqzCr85rjt7LDlHiTmvGWonmiulW6vIT684hHFBPvcBYUm7s2
         cx4lBCUHAC8W8+LLVAViGNcmcgCCHExmcyH20yOAScB4Og0pGiovnDT/3MJ3Qe3ZRCRa
         kAdnL6R9t8uCCdyVErd3alCUa3DD1+CEP4W/VSO6NWU81gD8Hy5XK/mnaBUkLwErbpns
         bwgSnfuuacczmVC98O8oQLT2mXRMtaBPGSo+c7PsMOv2aC5hj8bcL+fkP5HDEizI8xdw
         8Cq9cEMmgPAFRA1YQALv00KgAQKayfck88j6DetLXrVFm/e6ZulnS1XunoqsPr63hpwg
         i19g==
X-Forwarded-Encrypted: i=1; AJvYcCXFolGczGiKKzutzCa8MmCAfsK4oOzzC627v7tMPZ0hktAwC7eTqBqaKIHRBlJT649WxohqK0ZFdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyW0tszidTprY3evEQ+/LKNQcsM8MIeQi1zcVq7ME8smgwkcq
	HclFFlRCi04cK6CI+/24BZakdD4UTvHBWeBW4JU/llTWYisQjTmCxBsn6hYhGlftAQy0vgOcAQp
	crxglATDM2M4JRRnsjGXVNtPq9KgvnJ3J7MjpnuBVz7+8v/3JpRX0gug+dH/N9Q==
X-Gm-Gg: AY/fxX7up1qKPOi6MiULjdmzrkJzP6V75iKdcGc4pU48p0cNTEUhEMIY2gdlVB9K61n
	LAsXrMWfdwDRbYsGAh0U7qpBQoBCtqbOffK4vitYfop15cxobXI2UaI1eEzHbmm4fBRNKkzQ94O
	57ETL2dhm9Fb6/o7CgPitNCPsvmlrDt6PjLxQb6lEs/BsCodAMyoI5xKxYH2tGwFCpXOxkirJ99
	dWyaQTw9B+gpADRBBcAua4FLGhKaoHYtD0jSZiEY9o/4ezLPNbpGvZxEhpjOqyf9eLLLO60/MBR
	82iZKOGbD1mkrDee1B2Gtdal0B0StJZlQ7SjXbiGt8SgOh4REh2tVR+DnjoHzqCco9WfsI5Fs+Z
	DkG9g+e0Xf167p5aKAMG1bJvdjR4v1afJX3CU6oY2MJPlcrCLu/pzDWOcm7AZ04g/9Q==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251491cf.9.1767183472207;
        Wed, 31 Dec 2025 04:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH957KOviLl3ff9m92xdS8YGRjjD8sUTjMZEhIjpCXfBub9SZDcdgZ+jloiUSvjwXkZhRj+kA==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251091cf.9.1767183471721;
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f4ef1fsm4017817466b.64.2025.12.31.04.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Message-ID: <604f92a7-580c-4bef-9d13-707f6b1c7105@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
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
 <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX9usJdpDtMXJg
 vEw5KWs9U15DTjEqkqzSXAn/JBR6JcBxJs6NMms/PfPXxOpp3/l02sxCrJYDqKLpqloGGUJo2l/
 zycYLgx9F9f7n11nhLKf24t67AOShhlIqnyETx4e4uBdrTp0kOUyodggTvmLD+HQn9Ht4ZblKsa
 kNPJFyzNIvKJCVBVYZ+G9RcV2GBJE78AO+0Nx3VUkOJ+QzJTlr192wqs4KVRlorBmARSA3jSxS/
 mtJVNqljmt77cY7GqWXbIvUmWP0W/n+nzKJ8F1luHGIO5uPX8EGng/4sLQM/hE8vjiCV89fBxBv
 N9G+mLDdLTI2u60elKvdhFVWd7xYenaUHmw7hpcrgS20NlfmNnZD5F9BPYmom9f3z27qc8QphXe
 /wGvnfJLoGCiMPo60jfl2XeT7L/ootZ0od/JiVp2ovMS6zU8nUcDKTTajdK6klQWjkc3P12pOl+
 ial2UgA47tfAEauDnoQ==
X-Proofpoint-GUID: SUpJ2J9HKn1na7tGjTqPrD0K-4iXh4fJ
X-Proofpoint-ORIG-GUID: SUpJ2J9HKn1na7tGjTqPrD0K-4iXh4fJ
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=69551470 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

