Return-Path: <linux-pm+bounces-40954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC45D29061
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA7683004291
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC7324B34;
	Thu, 15 Jan 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGfrPDJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VFMkk6Gq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168C30E831
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516228; cv=none; b=fqOPLa3vld875soXI7b85lnphlS1vkFkp8hnbutWSnJ2TXzpyr0WgO0Xv7h9Ur/90kdPd6SWWzg0TXMOG8DXYf3lCNkAmTX1hU508Ky28zA60CUy/Cklw8amNoH2/9bUoYgKrzZLKWsGBl+o115zRXVpSa+a0OvZOHWR5lv2C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516228; c=relaxed/simple;
	bh=Q1ztBYZHbeuHfSYeh4P+EVbAsMT/PxPj5sxkIr1hX3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFtr1j1lz+lBz0Y9o09bPHS9Dn2m/m1s3Y7pGpTZU+3XWM2VTkaAw1UWNhMwh44fPNCTxZay7yGvdLDn/cUEvGtLtvxv2kE97fblkZGVUhfT6AqEHrbyvydBwNJUsMS7RyZQModtLG6TFGf9tSS7iWdEDJRK/S0mDKy6Yf9ZkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGfrPDJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VFMkk6Gq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMJn3a3560159
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 22:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RLTv/1YWn/ElIxiYzdBl6a2RnzNYFUXfvjrstlyGkzI=; b=ZGfrPDJCgCWwJvNj
	hcP4KgxMFEL81528zd9FqBDLEDfbg8JiPI2gwhtJH+eONFYsck1FyJzBfo2laI00
	NjCEuBG5xIz2gne4zjurmMxzNMFEj+4hn193yEHjxi+E3BJqxcWhV37GYhgLZIgM
	T5YmTWjLzCDIefmbFNr/bS6ms8SO2esYb9BHlbabAoADlRpUwaWOFviFXDEfTm1X
	fl2SXfCNw6Hv7e7YAdLVIHH01FssSve4EtYDjJ37VLNJ8HAw+MeRwC56jFkvnCkM
	efbDRSL8YNBS7UOWpBnHbiglZRAvzWES3P2kx8tbkr4PK0U0G4DASYNHKlMv03u+
	331jAg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpj1pv7p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 22:30:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ae29a21e7eso1591137eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 14:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768516226; x=1769121026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLTv/1YWn/ElIxiYzdBl6a2RnzNYFUXfvjrstlyGkzI=;
        b=VFMkk6Gq0iFZS5VzIIKsz6r5kH+SZxnASpdyGCTo+DOwLWTfgLrGsr+6jzUec0Vkfy
         O06+RmHj6FiOfj8zbVSQ3k+akddhNTg2te7IdoLNc3jCPIQ9FUeGJLz7/wbOpcMaHQEJ
         iPDIE1m0H6MdvvWdlsZfG+e0SQngXUyQDFplVmxifxUNncuxktsGG2VDqiMRr3/j3Hhk
         OAlGzwUHicJVp3yGfmy4uEe2qvru2okqrop3zSM8KrBdJfCaaHLrfNFlvXFBsPjXkyiZ
         +Q640rN2vzupwgKghwR8jOe33QmZ29eapEoZMCHMtwcd6DvQlRdNatt8D6hyu3WPfl21
         yr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516226; x=1769121026;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLTv/1YWn/ElIxiYzdBl6a2RnzNYFUXfvjrstlyGkzI=;
        b=BqbrsPvi1Z1/JSoc8dhpiHQbu4Wowap20BZyT3Kfue4VeBgyck8hLbSZaL3CXrDYgg
         Qtc/SZxLVNGWPXcmvjys4Mzyd8UuYYA/EBYfe+7ii8q1hk4FdEf6H3b/6I/vQYopWXTw
         HnCEmPNCZa8yKweliE2HWgXeNV2LYEiPTMIdGgbbpmfu13aZSFbOOFf/tTbkv7J3Lk3c
         ikWBDo18jeCkPuNVUsi1s2JWrTTkhGUCexwd/ETOymGqK2jbicYC72s0gE+vbsJcFdNB
         bNeRX+nOkxi0aCgShG4NU+SB9hB2ISzS9wnjpN3XU8yfw4sdryxL/d7CETm57aijYNMd
         fKng==
X-Forwarded-Encrypted: i=1; AJvYcCXSgUv/CPh04i/NghFRwND9CnHmWnwCQTPjOAld93/uzwOOSWoMigZB6xgLAk6DIp8qnuuulMML9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIxDGs5ISnxlJilE1OYZqaUZaK7kG9Z8tFmm0lKmRxYartQ+c
	n/hmPJpt47+brn8c4lDGrXFafWb5p7PKOemmr3qItYG0hy3tPPndfCkvXgNpQeUi55AxB6CAPFl
	EwfscbWzeCyf1hUZXchR/+prqPXZm3ot6o1btrE0pFSET9skwznVrGiwT0Smqow==
X-Gm-Gg: AY/fxX5Qo3rlYAYsElyuDJVhVhhLQo4UEMRehk8RLiv6eJfZ5GsYs3HrsCBtoBBW4Qj
	kfGDqXO9Sgb9tHME6z92PILW2Zc8IR2w+ZUaoPf8EGv5vA+oG9nYgn+IC7b6lWxerjg6Z9Y3DNN
	me089PC3zS9hlpoZ8Y1BCY+P2885HtfAhK24kLSXilEwCWf0ALFyxxE3fxo6rcPiAx6U5eeDyrS
	4Be6167xEiarCNhHUaFBjBLLT1EyN1T2KJ+vT6MfyubC5RsNKQAEa9McOAkubMkDpZcdZFhKGY+
	IKQvRwYE0duJsg0No6kOpinWDzbv5A8XK7Sppftz7yRxb0b072hCVGtJUZe0e3UTVAa8TIM0iqK
	HOFWBSa8sRM+VvCBBSAMCQTgZB18I0APlbq40CLCAt9tVeS7ui58y/4oCxlBywNVnhYJK1mJza6
	h+
X-Received: by 2002:a05:7300:640d:b0:2b0:487c:7aba with SMTP id 5a478bee46e88-2b66434e796mr6726485eec.21.1768516225252;
        Thu, 15 Jan 2026 14:30:25 -0800 (PST)
X-Received: by 2002:a05:7300:640d:b0:2b0:487c:7aba with SMTP id 5a478bee46e88-2b66434e796mr6726379eec.21.1768516223209;
        Thu, 15 Jan 2026 14:30:23 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm635436eec.28.2026.01.15.14.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:30:22 -0800 (PST)
Message-ID: <52b2b799-09e6-40a4-bea8-c7e8bf21cf51@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 14:30:21 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE3NyBTYWx0ZWRfXxGWQKbJJWCr8
 6W/OiftNLET+G09v0sxouetjVdW0H89KDQJrYp8k/f2ETKlT10+M6qtTOzLvh62ihhkpJM50PVF
 kyov1OVvTQd0FRjsBw2J0bEpDARoPS3RJ25KD8CNO+EfVdA2A9LsPQllZt7j8kLsYqN6kePwkvM
 nKF5z+HOYNStJUWOBBwpxSeHJ1XFbIMfbaWaFmqUz7MyWiXMcQBm47d0FNemm75B4ZTgtGDTH3q
 pbH/wWolYw4syEBq3yEPtz8TXGokj+4/+18ABptmOKeydwjz/9jKBgzBvBsCgxYgtVgvU5vNpJA
 R5q4C7gnzhP1qYHmO+eKdQtL9KMSlwbHb3z0/tLA8JyBJe1sLzAyf6Bu4nNibrLkS/MbkqdX3Ua
 dBSLY2eoM1F1egUtR40x47gqkEj7oSK85WXFwYgKp4zp/2BSmnWhObh9LgP21YCTbJj8ILpGetI
 nwwGNnY+KMo2kIHZoPA==
X-Authority-Analysis: v=2.4 cv=J+KnLQnS c=1 sm=1 tr=0 ts=69696a82 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=L2C35plnZqJTIQ-6vfsA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: SqN-fUQIiutH7MiT6ZMWrCZUgr0-NlGv
X-Proofpoint-ORIG-GUID: SqN-fUQIiutH7MiT6ZMWrCZUgr0-NlGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601150177

On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath10k/snoc.h |  2 ++

My automation flagged:
* drivers/net/wireless/ath/ath10k/snoc.c has no QTI copyright
* drivers/net/wireless/ath/ath10k/snoc.h has no QTI copyright
* 2 copyright issues

I'll add these manually in my 'pending' branch

/jeff

