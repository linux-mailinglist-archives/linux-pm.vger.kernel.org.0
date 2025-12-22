Return-Path: <linux-pm+bounces-39782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD0CD6AC7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56011302F82E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6A3314DB;
	Mon, 22 Dec 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k6u4ZwTF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWfUQewl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E132E720
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421373; cv=none; b=WlEu98K+p3El52QMbTaqXvKBocf9kVBDx2yZch8RaLujTKRb7sUG1pNxRVCBk1yVYJ7Dra/k+9QX/LCVcWrmfFKnjc+CcJ08nEu5OxvYcZwTLWRGalluvx2tLMp9qQd8gDv05L2gWTJ/Z6MbRwCM3jSZAyrf39p5ie1OAodO0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421373; c=relaxed/simple;
	bh=xsGdQ2XAEufFnmzMMLv3hLxABOefWcNCb772Vo6VRAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IprBGjkCcs+mxHhOD2EEmJpsSLFHU+oYrGm9rDkMQRVPay4z2sGM5tef2rfkC3xmPPYiVQbm+CdK1SRDXiilKQikbKxduXUBNX3+UmkDSIFMPH9o2IkF7ddiW2gHOGRDw8QF7ZdqevSVWHQpab+frvyvtA2FNRRucFzy/OT5JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k6u4ZwTF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWfUQewl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMECVUs1530063
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wXvx82XWqFm6ITv1sw8wOZgISiDMz2WX+oxaxHkhTJg=; b=k6u4ZwTFheCvfG4L
	eTXZtWDCPRdgf/LiHWR/fRzgmX45mMv6oX/1uuvg2n19D45eMkmntlt0BHj+IVmh
	vccwe9DPdXJVBPefbxRod0bKaHnG2nXa1wp2qoJcySd4C5JX4UN+rG0F4xbhkt9/
	gtmmeRD6v5BtKNyjp+eEdBwssisVkQLD9jP4fCYoNMBdu69Syrde4D/JSUmj7pG4
	t1M/xtMgizzS06Earw41zHFb7i9yrOFJlLvgAYO9ai2GHfRVsop5sLTe7UsxuFPo
	SbMljhmSOIEwPOc8QWJeE7J15DUjJx+VDHvz8iCzQdUZvM5QdI0k9xht3NZOawz9
	6yOGBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y0swq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:36:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso4070581a91.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766421370; x=1767026170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXvx82XWqFm6ITv1sw8wOZgISiDMz2WX+oxaxHkhTJg=;
        b=LWfUQewlVgXJJTrTi6/viLdjy7PtFNkEAMBfHCsGtbxBgFUbOaQ4ycZjQIxiRbtmKc
         MAOMNKPrfpZHGPjJx7PwlwUuePV5r4nbk23j6nTh1G3vGTrBUar7ecexqJ0yvneUEfq0
         +zwnq8GKxLcjP6X3UZOGm0ZSPazLsdlELn84nMRGhYpzY+htAGGDjFQe1RrQ8PVZj4dd
         thcTpDuzOIOvhSwMizqa89EvEfZ64Ov/IRnSawMr5R6J78z2I3ybSTmb4fnbJIxt5y5A
         CyeFCDanRedqiJKb9XDfVK2N8GIUtS6nDFE58rSbO334DZlFvD4Gtg+rwCbwkFpz+v8o
         4IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766421370; x=1767026170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXvx82XWqFm6ITv1sw8wOZgISiDMz2WX+oxaxHkhTJg=;
        b=JMv7GwjqBlnnyt7asGj+/ASFIXr6KgR6LJCdd7/UB+g954ez7v0LIbLDWR+0Rl8Na/
         QPG4bZV+Ci/VOJoBXvucukUlefOI1qJ/QwpcCMBG7s0nLDJjcf+TDaRwtYshSSkx+kqv
         rsdEUGE3rUOARBg1J/vDj5MiYdpxvWkxBLekbXE5nSFd4zQXTWYk8qayKfOoOhCM8KyH
         4HDsrwrJvNFRWDrdUbGvSUSr/Ks0mn8w3oxZ4SXjuw94pN1LbAMIU3USDnUJxJ+Q1Imv
         srP13Q/FjichEwH318AxdxE3NolLqUK4sgxXmdtCKrhg02qEXC/7X1Ewq34LyeCS0O8L
         IOEg==
X-Forwarded-Encrypted: i=1; AJvYcCXtkYyGp67oBEPxpzC3s1BeUxgtVYg5TZi4OvqOq/ea5ipXoD7IgxU0UC8otHAefMs55o1bVR9Bhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDhCW4ZVqQKDWwv3jdx+3i4Y7xzNBf8RixdGTPa8pGlsto71q
	fNOXNR1U+Ck1c337eTwL9wCb/KgH0MVZNOOvhEdiR+gu0gZe3LzRhhL6hbW+dpudZqvNp/cXW4/
	UwCylj1bsOH4Xh6b0iMVXIQ320QJfY0YljIh15mE9o9rsrWM+f5FxHoeomwUEiw==
X-Gm-Gg: AY/fxX5eMYQX57or7YLmqcvsvyNPurP+KQWaE1GQnLkVFj3mQjhzYMXR0w7vaBosCGF
	BF5U24z5c9ZtWsTaEvtrKtsjptWa+QAIXB8RRBNAq8w0YCnOG17Smwyobu8xapwxV8C9o7riHZT
	3J7AuAAUamt6ZhlPrRRGO0jyTPaQ7mVkAFMNmKrK+yrykQCk7q3gd4jcSEkbA/pdlEoeT3miZAa
	ONKnMLT+zNL2u0KeXdh2pii1dD555beJUHkOv9grpYXh75WZqt8BosdvisRjo/REXq4oae8y4gy
	L5pB6sIRNXEwKSE5m8PaDl6UbEusJ9buzAbeZevOyRl+csJlwkC6xT81tx8HByePta9rPxi87CM
	Z3+SB9z4naWGLV4PMm3lLjx1lHOMkox9rB+hD
X-Received: by 2002:a17:90b:4c4a:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34e71d6901cmr13686846a91.2.1766421369908;
        Mon, 22 Dec 2025 08:36:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLpoCnuvbYB6BpdXP+5xmL2PI0Y+WCaNF/uzlKrlfel2GF8nuYzETmHXde3YZjosxkcvRINw==
X-Received: by 2002:a17:90b:4c4a:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34e71d6901cmr13686820a91.2.1766421369341;
        Mon, 22 Dec 2025 08:36:09 -0800 (PST)
Received: from [192.168.1.5] ([27.57.93.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9219f180sm10513551a91.2.2025.12.22.08.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 08:36:08 -0800 (PST)
Message-ID: <2c864c13-9fdc-4925-84c4-7b80bec581fb@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 22:06:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix
 incorrectly added reg and clocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=6949737a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=luqpl2TCSyK2LuNNAmtdDg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IFhBrfRlIRHtlFGW3SwA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: FgYP2mTpZB5kdVHhAorXW8woKtTMRci-
X-Proofpoint-GUID: FgYP2mTpZB5kdVHhAorXW8woKtTMRci-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE1MiBTYWx0ZWRfX26qoqIcbOZlD
 iPYPABVuype41ICmBK4LPDrsOF1ZnQIIdEPDG3Kj6faJs19ALc+WOFgQcHWmpYjerNjeVnfEJ4K
 82+G2sgpqETjGhw7i5u9btDe5LyZdcsMvF3p/aVWUbbvZYCMWOLPY6tiSTZlGYNEpD+Z3XGsN7d
 4KUEI3qiJqQ0+IFwFm5MEPZH17/C9jeSkUbdrOnML6OafkC2okuxQ4/zOA9xAdP1lmz5+dRKA73
 /ic8vod3sof86z/9ISQlKeTzPx2agos4YTEfO1odHSknxTnFGxLgtj1fzOr9qlSJImVsCyhg8OQ
 WtquYZGBp0pyBjdpbRMdlHGRDIqmtKtZwRLqKVM0fzRM7TRpr3FEdGvQivnEe9vrsavlhAu8LSq
 8zdeNy/P69CSGO/U86K+BhqlTZMhUy9GhhWewN1oY0i7DkOs3dX4o1vrO7py4HbsLz8jiq+1dqy
 tVie/MLCNe5FGxQgXNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220152



On 11/29/2025 3:16 PM, Krzysztof Kozlowski wrote:
> Commit 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks
> properties to enable QoS on sa8775p") claims that all interconnects have
> clocks and MMIO address space, but that is just not true.  Only few
> have.  Bindings should restrict properties and should not allow
> specifying non-existing hardware description, so fix missing constraints
> for 'reg' and 'clocks'.
> 
> Fixes: 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> index 71428d2cce18..3dbe83e2de3d 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> @@ -74,6 +74,37 @@ allOf:
>              - description: aggre UFS CARD AXI clock
>              - description: RPMH CC IPA clock
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-config-noc
> +              - qcom,sa8775p-dc-noc
> +              - qcom,sa8775p-gem-noc
> +              - qcom,sa8775p-gpdsp-anoc
> +              - qcom,sa8775p-lpass-ag-noc
> +              - qcom,sa8775p-mmss-noc
> +              - qcom,sa8775p-nspa-noc
> +              - qcom,sa8775p-nspb-noc
> +              - qcom,sa8775p-pcie-anoc
> +              - qcom,sa8775p-system-noc
> +    then:
> +      properties:
> +        clocks: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-clk-virt
> +              - qcom,sa8775p-mc-virt
> +    then:
> +      properties:
> +        reg: false
> +        clocks: false
> +
>  unevaluatedProperties: false
>  
>  examples:

Hi Krzysztof,
Thanks for fixing this, looks good to me.
Though I did not face any issue with dt_binding_check, agreed, the
earlier change was too permissive. Disallowing reg/clocks for the NOCs
without MMIO/clocks and the virtual providers is the right approach.

As you noted, the previous schema effectively allowed describing
non-existent resources, and this change ensures such issues are caught
early by dt_binding_check.

Thanks,
Odelu



