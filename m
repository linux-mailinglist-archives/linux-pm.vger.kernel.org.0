Return-Path: <linux-pm+bounces-36938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A62C12B56
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77DF44E384D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781B23DEB6;
	Tue, 28 Oct 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVIb7nRP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915D1DF247
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620536; cv=none; b=PH9ctBbWpn0tAigKKGEHvZsJlOnmZmfCcyP3W+Anh4nvPLtMCQuNpVUTmY6Fh/cnKV5VlYbqJP7AMIfeZsE3q/RKhoch7nrSbmjLGa14GiboUOaMCN9yi8736LfflzFyqeJ8HsPhghR5QGbZPUGZYcifQLD9ldEgLquB13eehYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620536; c=relaxed/simple;
	bh=J97EGj37o1LYAf64oQGIuCna3MTQqEBoZLlajyaxXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZtfixEi7k2cuNlEvo5nQd4H4ktxh4dxBwBHr1+eniwcxwUYWk5Xsy20mwMxCno2//bObN7PBjDzRd/iySh74zQlYu+lx2FDgr8XHPIu8o9yzMRk9dy8TcLdF9xxIAsK1+daMNWBrFW8Tx5Ct23ljGFI3OZrOwBcvmhbbafbdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVIb7nRP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RFQbon2232270
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 03:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mZT/6+ObGcxpNvzNL3larcNaKCkvBwUwpJYv6W7bOhk=; b=CVIb7nRPeXQ1xUQF
	GSBi0Ve6BZlknIEfrbX2UGzMgJqeCLiOz9nrOyxmMs9+cWdHXsSK5gu5JEcuSaj0
	qj5ZWOTEzszKdFELKzf+W3AeBs7XgIbzl+w1H60i5H1ngjN0JptREGRuG32Ygtku
	B4ClVxo8D1h2gSBvTj0OUkbcXEcT6gBqNDESFgXowrFOGh64jX7Aij6ylxuztoxy
	T2JeMRilZCOS7QKUsIO+9xlN6dSwiRAzyjHIgM1nP/lYlAUYOrczGBQOaCnCwe7Q
	vtBEqd7b2wEGQlmcT8eAJhg7ZxMeHl75dZ06gS+hji7PPN3WOwttsWb2I7ZE9kls
	7Oewzg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wnb44k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 03:02:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21394eeso1707761a91.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 20:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761620533; x=1762225333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZT/6+ObGcxpNvzNL3larcNaKCkvBwUwpJYv6W7bOhk=;
        b=B1xv8TrJGre4MXSSqfjhlBEp0ZjMmUEU/Oqx6OEVgBFwFDa8Dmtytx3ab/zBuni3St
         pgmHPrBN9vYOFNK0+1quB199UWLJ3lSiWQARAbkYsvRhcR8pLPlvz3cctJEhaGnCtixV
         lsQQHmMxNM+2QtdWjvuVI2xx7Dqw4pbMbCzNxbnlHbLY1IA55956GTRrJktuHPwK0F9a
         U1K2DUNMIyuJ1eCeEqCopQ4WtQpQXzJExKFksMmgoIe+sjEtcT28T+BL8zoKTPu4i93s
         1XDg7g4V09ag/Wav8j8utRXQF8zx90wccACiUlBHnqRUNMl7B60/1yFnR7hAzSSCPa8l
         umNA==
X-Forwarded-Encrypted: i=1; AJvYcCUeORM/u+xDnNMFrEse///eC/2HHqIOD5/vqlEvbKzLI7+wKQt8AoXsNo0G3VPmNrxKXQ6I2l+mLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4VfwuRoY0+rwIW7he8yAtKIqnNrBGmWYhxdh/tmWXvG+/IKw
	6M+B6M8zchO7ArFUBPJP5tzUGQgMf3he7FLqTnvaj9fd00njLcuD1fDqSnBaXodHRm0QtKrD1oE
	FG9VW6/khL4/d1dE2tqafD0EzYSPdsSm0BI/G4i8VS7/EVWhGJwQC89Z8ExKDMQ==
X-Gm-Gg: ASbGncuNDjiRb23GPbH4F/FegsHt/Puac5GdpTS8inUSPVPRq0jN7pLrx6b4DoNQoXy
	f9ZhAWkh81tuzNCA1Vvx0wvUpj2oO6H4KnuWa71/NK1MZ4C5zXaV41+luhMsUlA/80/Z/je4IKj
	EjTFPgS3lkQDVvZSYtLkZP5ZKWnAqHJ+E1D0Gr6g8l0aHuBUIHvr6UVtRsMG2lHCjWuo8aD6pPi
	iJUTXF2b76tl8ULKm5RgBO3SqUzujvjViz/8QUaLlOnNXALCiW1Bbfo85EaXyCUgaQd8tE4IF+r
	hfeMLVzTDwQM89K6quYCt/KsctUcI04Qtx/ItURultC8NjrIP7Oi2MPQTkXRGsIYVkAsIBZaSvW
	BL4eDm2gQMSGwleiZ8+6YqieIIt/BNCLch9zXq1NbbtK7RmoFlclBiA==
X-Received: by 2002:a17:903:2c7:b0:27e:eb9b:b80f with SMTP id d9443c01a7336-294cb37880bmr12041785ad.2.1761620533201;
        Mon, 27 Oct 2025 20:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjH2jcjwExR9ZejktFCScAZsb46EVXd09cixcaCyHqdEG80lz4FVfKGqiyH60DFpO/NfhY8g==
X-Received: by 2002:a17:903:2c7:b0:27e:eb9b:b80f with SMTP id d9443c01a7336-294cb37880bmr12041495ad.2.1761620532610;
        Mon, 27 Oct 2025 20:02:12 -0700 (PDT)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f5csm96570895ad.104.2025.10.27.20.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:02:11 -0700 (PDT)
Message-ID: <07c5c404-e2a7-418e-af5f-dc7c4df9f2f6@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 11:02:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
 <20251023-knp-interconnect-v1-1-df13182aceac@oss.qualcomm.com>
 <57bc950a-a62b-4218-99a0-86c570bba6db@kernel.org>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <57bc950a-a62b-4218-99a0-86c570bba6db@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=69003236 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aNDXB-n8nvUMI_014rgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 93NVt1cuwyAAnIc-F5xkXmYVcOIk1sZm
X-Proofpoint-ORIG-GUID: 93NVt1cuwyAAnIc-F5xkXmYVcOIk1sZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAyNiBTYWx0ZWRfXzsFBrx8Gd86G
 gyw6S5UOG1RD/22b4Ax9oPbm4h2IANzgk0d9y5h4PKBI5cDLXd94g2lp28GBBnpPzwG5XPxUDbS
 ee2bQ2q8EMybQdsmJ/2YleER6wT55B9bxnnmq8fHhfp16ckdo1s5EVOwF8yPxsaDQ9HNqw63ZZO
 +2CGB7mru3Ia2E5Kh+wzy7KL82qR5yM92hqUwD+72X/pjPOSzxc0iQ9yD2tz44TOh4rpZ7opXj+
 LQ6+p/jZibXzw7lfew8Nvw/g93ZMxdZd36QvREi8gIbev8SIMxwSXUI2Oqv3wVTfhih0P8hajsN
 nWuQKTrNjV9nrwW0WMFtwuKTAP7T6i1wuC35GzbUN8EtRDOuSlF4Ua4EKnZS5AwIRCBR8WmRtmR
 bYABbNY3ik/FDFCbBPoDnfkNfYjAoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280026

On 10/23/2025 2:23 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 06:39, Raviteja Laggyshetty wrote:
>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> 
> This cannot be tested, so there is little point in doing real review. We
> already provided guidance - and it is documented in your internal
> guideline document - what to do in such case. Please follow internal
> docs to decouple.


To be more specific:
Please drop header "<dt-bindings/clock/qcom,kaanapali-gcc.h>" and use
ephemeral clocks in the devices example like
<&gcc_aggre_ufs_phy_axi_clk> <&gcc_aggre_usb3_prim_axi_clk>
<&rpmhcc_ipa_clk>.


> 
> Best regards,
> Krzysztof

-- 
Thx and BRs,
Aiqun(Maria) Yu

