Return-Path: <linux-pm+bounces-41461-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHBbLMFBd2mMdQEAu9opvQ
	(envelope-from <linux-pm+bounces-41461-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:28:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33086E64
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9346301E7CF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280733033C;
	Mon, 26 Jan 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GziFswQK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdhZOZR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834933031F
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423174; cv=none; b=NJfXR1fySOB3+ulxsH9XDRqAxvSy4zF9uJbbYT698PQJIm2OPVy/eGhukdDMf/khwrvZ0QsGsjOSybKhnqP3n9Bocu0+cYfBNwP63j0vbttxG0jAcYHqO2yFn9Ty6qGhdWG9kIDMHzrqeHoDy7ehIrGjujS+FpErTxtCzrGM0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423174; c=relaxed/simple;
	bh=iz5fNb5uoCRdvN8WosdjyXPv5O8Ib8vT+HAmtgtXzqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sww0BCaT9y64P+zHXopq886BQElUuhq7b0H9+ejPSO8usuJ5QcILXtqASyzqMgt2UkOhavehK9PL+vJ2YJakrYyB15QoAqHp9LDxnUelvcfGUH1EP6XhQHR4oe4lCZ26/PC4FJtTcZocc3MAoI+E014HNsqyxwNNahyzC3Rclpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GziFswQK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdhZOZR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9brEK191832
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UdgHA7Ue7zFitGhLg5Jp7suCmwVIY5RWPd1y69PBBSQ=; b=GziFswQKIm54Xj0R
	fUeNbTRI8re5CUPMjZHsvzWFVP61yXKOo8f04Kw4X6rFVk2DGXuCCNXJ0ORfNX2j
	nI0Jc4QEvSBk36kptPs4SdN0tKI4kRQLGtFzz9n4gqzKsVfU/BHpVA5ao8Y2h7JY
	AtPOV2Y/nigdJkVRlNRfCtqwTTVq7Nb1JWzZngkNqTLnKQy7Pv7owPrJngiXzjGz
	zC3UcWq4NLkyMfWhO30F1ZUcZyAG7y2JeuKbmaioJibiZ3Jw9vri6uOICxxodSns
	3NUm4qinP1FudUwvKILi0i+LXAmrk6slj/hYJgHIYeZxX5G8V7xtjoOUHm+jLrfW
	hGujNQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6xv68w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:26:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88882c9b4d0so12120296d6.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769423171; x=1770027971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdgHA7Ue7zFitGhLg5Jp7suCmwVIY5RWPd1y69PBBSQ=;
        b=YdhZOZR3GbDWl982Z7C2cZ0pmG+ZsBcnLK+396WDL77x07Gkp22Jk4Yu+2wDPBTCx6
         fgWLBSB6KQT4AObOHeHHrYRcJP/x4fSXa+XaErB2K93hYwNnlbSevO0LbC5wdDPCbpQh
         SIoHMB9MyU/Pqr2fi2UUYV+rAV+A188TRH3F+/yigyqn/0hMeclyYCEspO0LZM4QgIq4
         8RTd4YNO0IcWq4rABwHu9xcaqgy1kW6eYfMugn65X7+WyYhmQUBbdfF16SQirJvkc1Ay
         1AdhtKlLP4p75WIz1FwxtOF2JknxgVya4u5vbmuv7HghpBhqty3hMnzGyIzbduQ/vJy5
         cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423171; x=1770027971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdgHA7Ue7zFitGhLg5Jp7suCmwVIY5RWPd1y69PBBSQ=;
        b=OYafS6QljzmOmsHQONLuSNB9SwfnNQwb6f/SRr4uqhAZqf7H+F1xB4yxuMU8X2wD0I
         cLQvhIDJ3hmO3ezBBPLPOsBSJHKkUq9A6ojtZsoOPr+08qBCuElsb+hvS6bS2OfDrlF8
         UJklETZ4jm2FetAcEvMObnx771b7qJ8+kYiGUqqqpBhr9UqlRIhVnAj2OANniaZg1nRe
         lTVBVwfvvodelc6EzXTkrGKvP6QjKC4+K8LoLptXhAHqmopE6RNTG5hfFRao8XbN6xh+
         Qlzu10G+Ea65Mjb0vCv4RGzB/bhUfRh/9osCELzY940yASYpJifsyWTD4n8DfrUDzVc0
         xkvw==
X-Forwarded-Encrypted: i=1; AJvYcCXn+jZM/22Z11DnDmK+ZdVxw2tk8nuvjaPEvsnh4wUu7DpOHZhb4UNCVfvB3uyTvRKyDNR3V+B6Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUpEn0zRs1pPRDtdjLgwPkoH5JVKKaUT5oXoRNJbnsfXZeY7qk
	kfekD7e073dgPi0byZa2ASRM8g82kOUsHCoibH6i0KlCGY9sswgajHfiOW6vNvyzRXjYTozcEd8
	yOdntRoiP15P+aY52d0EfUyMz0RROHIIztMrP8nS4aniZ4pR5UwA7CmTXPr2Iig==
X-Gm-Gg: AZuq6aK4hp0wKlpay4hZVkGTE5WlBvXpiA9j0H9EDEcWlorr+bvE7ZcqTyVSEsaxQFm
	gazZwHBYdzgZXIufPErEQIqvW+MOlci4ktRVvTkgFNgUcQpbFq5T2xwWWIC9A9rix6ZC8eALXzl
	cZjoB4QgcWSpOR5Wu5IktunZebIz/lv7mzs2H/FmdQDnYPavV663t1JIOspt//R5lCRr/haCkHt
	WTfJQ9IZ3HOq0WzDW3t0PhPJpmOL9uH5rMqml4DFt70vtlQXXFkfHoVYI0Zikk0g5pjoW/3AF3w
	Yb0hqA1nMhviMw6Eb+OUgn/qqj85w+pxE89Y6NmQokJy7oiEoroln79csSa1/QvzP+AFu2GR6dw
	OdZ/mMEkHt7E1QeQt0BQQnz3+tWQ5/EAZmm0tq8MDR//Wt9GBadV/w7r0dmf0O0KTFi4=
X-Received: by 2002:a05:620a:4482:b0:8c5:340b:415f with SMTP id af79cd13be357-8c6f9599b0dmr297632585a.4.1769423171177;
        Mon, 26 Jan 2026 02:26:11 -0800 (PST)
X-Received: by 2002:a05:620a:4482:b0:8c5:340b:415f with SMTP id af79cd13be357-8c6f9599b0dmr297631085a.4.1769423170753;
        Mon, 26 Jan 2026 02:26:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3dbbd1sm622138266b.2.2026.01.26.02.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:26:10 -0800 (PST)
Message-ID: <8015c8d1-6eee-44e0-9a50-df23126bf7f1@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 11:26:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add Eliza interconnect provider
 driver
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Georgi Djakov
 <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com>
 <20260123-eliza-interconnect-v1-2-010ff0d100c9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260123-eliza-interconnect-v1-2-010ff0d100c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: suxgUU_tQArvdXCxIBp9bPhDnu16yd68
X-Proofpoint-ORIG-GUID: suxgUU_tQArvdXCxIBp9bPhDnu16yd68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA4OCBTYWx0ZWRfX6pRbdUnF6hbT
 SV3GEMD5+gpKDvEPayxgvB3YThr4e5Yvekmhxk0nE+jpESXuiHTmv+xHDPv/LPnOtzZ4vFjpSSH
 tyT8k4Gg0ufqpCnQtyVOU6ebCr8RdwruHlqsDMcu+KUKOwtC5mVDKxqMw01DWG0Yn2TLF/hLBA1
 xBc71HteZ7dtGci8UwNvHa6K6HfGpEtmaYDgil0RlQl0cLmGmU4A7VocX38se4nyNPfAO4nGiGT
 CI3QqhCA23uP9qeSnahTIShnDKWmti8KIFQyoxLVYjp9sbeHlWbH52fkl9N6sRl7OGlz88SECvG
 pZk+uNsQAsafzhjF2WGaZGY2qUGWtAb7v36zOkdgyNbE8e8BA0f8vn3U/mys/mdl/lSmkBTDEw5
 POpfIZWMqY4CRdXxJb+E2f8lwKRhRfZgYj9oWv9FyWs1sf/lW51ctPX2wPhs9aV2eF0AaBCeBuq
 GnN5U2I4RFiIYqkUJiQ==
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=69774143 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ggfmzync1vDxQEGkaewA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41461-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A33086E64
X-Rspamd-Action: no action

On 1/23/26 1:43 PM, Abel Vesa wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in Eliza
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

[...]

>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/eliza.c  | 1586 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1597 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index bb1cb8a640c1..53398e972458 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -8,6 +8,15 @@ config INTERCONNECT_QCOM
>  config INTERCONNECT_QCOM_BCM_VOTER
>  	tristate
>  
> +config INTERCONNECT_QCOM_ELIZA
> +       tristate "Qualcomm ELIZA interconnect driver"

Please don't scream

> +       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +       select INTERCONNECT_QCOM_RPMH
> +       select INTERCONNECT_QCOM_BCM_VOTER
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on eliza-based

Whispering afterwards is odd too

[...]

> +++ b/drivers/interconnect/qcom/eliza.c
> @@ -0,0 +1,1586 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */

Stray empty comment line above

[...]

> +MODULE_DESCRIPTION(" Qualcomm ELIZA NoC driver");

Please don't scream

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


