Return-Path: <linux-pm+bounces-40093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56213CEBEAF
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A18301C922
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD6320CDF;
	Wed, 31 Dec 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mezau7Nz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBTXveCS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCD3168E9
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183052; cv=none; b=VSwkdOFAE4K1y/K1IFAGVEJtLRGl0oEQnBdLENs3+GvvmGjU7/uTOi2a7RUlLUPeeZbBrLKtx84BbWD/QwsQhtx4go9Y8Ip35d62+zkHfRBYh2cj48Os0/82hh+cIpKrHGK1CdhZtvpMSvOj8aRxGdSOCY+A8omLxyTs4Du0ufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183052; c=relaxed/simple;
	bh=FzhfKAYKhvE4b1t8D4IAourbx7nVeMnR85FO5C0OjB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn/JtXxK2hL6wDGdQegKxDsKXoMQSJ5OhB9yz7TAhEomnanOumlEdxY6zXED7avepg/j+tNig8lAPRgAF23CzAKANzI3ky4gLPTVAbh3iVbi7UEHTITIjuUZR3PJ74ZO6651HE00rpN0Ou/DOo8nBcNojIb/IzFfdgEk10VhHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mezau7Nz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBTXveCS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV4ppit1431464
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=; b=mezau7Nzk3XUhMQV
	4EiIg/pK/tFORCyMGoQ/PLNKi4tMRaTvpOwC0hf/CJOAwOsS5nHynXeO0jPK2Lug
	+ctgHBC8aflVVXSofn8SmFDUW5efcuJmNwmuSPIQsKR9k/E/ztH8qFR4e4ygZUH6
	lnWbWyLOZG1JeLAWomz2chAgobMNfAA2BHSbm+k2aTAOiDm6xF0kpNe76juVtC2n
	ZnDJT1ez9iTgc/E6xnjuf66FbrEslT5jCwInbzye1qu+dCeskUyPWcfpuKBXv7hJ
	ZCVWEpV0v2AIeA5mKI34UHkQlCDc0pUkV0ZfJkBE0t/b1C0s7AN90fguASRIdazO
	Z+V8qA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcw5e0q9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f34b9ab702so28126571cf.3
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183049; x=1767787849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=QBTXveCSkMcebfwv05aNYzqiTq6OFGOS4yST3rcC6ZQF3BFxBZruUmPsOxx1AqHhFn
         avVg2wKVfb77vU6hjXh+e49NKNtlBFPdIhUTfflRgZYZ3nLQeLAlJNc1yEj2eHglAwh4
         5wbMMHmmJ6c8U/iBrq8qt4i42CL6c6ys+JSy0JO9alqx3pNkiQ4IpyyykZmo0L76+mkj
         wBzALwvIF9ZmUqc8CZufPPE94xcFWt5jyFW4o1o/KBTJxWxteIhyYMhqVcmjC7UKBo6a
         7sVPyOv6dCN7oq8M3uh0I4d17mDcMNdw7CB6GB9j1NJaPdHAnY2Gl19xpJ7VLxm1CW7x
         AIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183049; x=1767787849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=hS6EZGFTpQLDC5bU4gKQvvtEr0ll+FES7+aIZB3GZK024SwbfywdH0bJyvYBk2Lh0F
         eQlvE46CMLOBVCJPjY37qPqJtp2CEhSUnbF6USBglkr61XExY9OkXi3Khwf/BLhh1SLE
         N45uJWusiqYJIwqO8jqaeJfidWs6P3+tiqtRNk/0b4tp9E7ozTRONN0pGdbTyqg6IKZz
         gk4bCUYdVFqd+QdVt8XwLMWD8sijOHz2DVJZw7YO5iRfnVWlTWgXesImGudffSGNsUIH
         lY2k1jPT961ewj68HAZUafPRd9wFwZfZBnkRgSnH4uurEK2esZptDTSJYKMV+XBgj2hy
         Dcog==
X-Forwarded-Encrypted: i=1; AJvYcCXVG3mN0/TlAjzIu3SY8mkiy9UONbz8GtTJJPBC23PWTJy8eDQWovJyk4ODMoZM6v14ai3hgANDAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvQ1cwgSOlByxV6/Gyuc+UQZIdjkEe8Fq8QCMnpRw8DBazoF8
	3LY9ds11WnU6vlv0Q5sxHHVjM0YiHC6Ez0eTiFX5+QTY6CNjJa3wQjsFQMd2KeUBfP1hy02XtT8
	Ozu4i87BYZnQQoPdNlJOKmqqDDFwhYBkxQof0lGzzqBIoJYwtZmtiBTGxP5G0XQ==
X-Gm-Gg: AY/fxX7b6JxRl+IiQ8+6SlHA315dxcodEbCAUhA24Za1ownR0fJcfPIUVhl8+t4vcR+
	xqYcNYn3WHbtfIXeVzU/12TS06IzWpEJfHkWlAr2SeGNAfhjBCs0QtbhdyF4wyf128kEznrQ0vb
	GivSZ4ZUHNaLGXm2OXqnSNFDiJq7eB59aFdk5vUKOFYhTUuUibmjVGbdECfJ3RzpcMQrERf4h0W
	wA/mXCGy4tjJMknH7xktLAXOtqaBRrheLQhygjvSbm6o6rID1arrO1+wBlsO7RV58WN5l3EOfYU
	3EayNVjJaScGdAIaeVoGqPEoVYBfIs5VoavPy8DaDKr5lpyZvisuQp5KUNL77lAArNMNaQyNJrV
	ls5+czS+ljEuO5j32oPuEJq7Sb6ZgJYNUqMlYMSmwVMMYu/0q99ZZ+gU8JP8foLxEkg==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412852281cf.1.1767183049245;
        Wed, 31 Dec 2025 04:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6cFEFkyE8VRxM0b+yrpQtlOmvHQM/Qqxgrd4xJLvYLI3HpIrI34F73/M4v3Vqo3svEu2ifw==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412851731cf.1.1767183048729;
        Wed, 31 Dec 2025 04:10:48 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90414649sm38031586a12.0.2025.12.31.04.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:10:47 -0800 (PST)
Message-ID: <d42f24f3-ce9c-4804-bad1-f83c832bdaed@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm8150: add uart13
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
 <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNyBTYWx0ZWRfX4IPHWOEE7x36
 QpnmXXUEDx8FJRpzHl7ePyQu2PVqAidGX6QoBDN3HnvV52SB1HgnUwrxTtCX/JmdfYltUlbPqo7
 lJ9b6YXFeypkhKuQ4vaGB8tt0P4612EaD49KyCMwcZg4m2QZydgEM2Dzp4xIxGAWamaqWBzx8I0
 HJzTzUX1hNSOZPdEFnEQdeLho6Vi8OKJROUHSChhfjU/SVAq6BAOhvl0cRITY0f/cDEROtRXLLr
 GY/0s9Dhx3AUmO1HJHV/APITvB0so3so143Eab8cwyH77WwLxaB7dH9ePS5ydSdnzGcX/pci+S9
 z9edwzMxMacZe38WC2Q5zYZK3IOY9EaTmL/va/4TtBOijh0JmP033jCoXxDpAylhRlN5PUYzNM5
 /tBSjo3aq1/pugpIEjEVGijWoroUmwb1f5b11fifeem5gR1S1BoTpYjATA6Gl8/78ni4BkkOQQY
 ry0zP6NhKtlx0cjHqrg==
X-Proofpoint-GUID: XxSCDv1gR3PS3VMFc-e0KGxuVL-xQ5ix
X-Proofpoint-ORIG-GUID: XxSCDv1gR3PS3VMFc-e0KGxuVL-xQ5ix
X-Authority-Analysis: v=2.4 cv=Mdxhep/f c=1 sm=1 tr=0 ts=695512ca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ROe98goXJRv4GV1sSmoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310107

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> Add UART13, typically used for Bluetooth connection on SM8150.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

