Return-Path: <linux-pm+bounces-37354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1747C30D2A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 12:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821BF3BB15E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591692E9EA0;
	Tue,  4 Nov 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cz1MQd6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kw094zR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5F2BDC09
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257058; cv=none; b=E1NxRzjeQeUtWtVAF9W64iWKTiXWd6gdgfFUOItw/A7yLfE+/WJ+ZGUQ64crnlHr90HHuhIMSUVQhJ51QNJhBkwKMFN0ZDR9MNHQRMrAONn4ExCG7j2RhUZFoHcITMoxTjd6B80/97E9jWOpgiQYBKF0rioVdTM3cVnMZf12Dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257058; c=relaxed/simple;
	bh=/nzuMN6rWNFeJuD4D+9FBdXsSI4QeI1SRzTUjDUF77Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgq1mmHISysw5oLWceCjAdnE52KDenzheUV/VTzl2hyBFNdfxxI7FiuR+gMdU4tXl25cqEnc0+eJlRMVHGXEbNHQXw4ebFVr2E3T/eErv9VcUVmq87iq6lpkLs89OH2qjhKUuytDhBT21pTb52zjHpRcOUAHO50tgjfvAoKv4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cz1MQd6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kw094zR4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48fgN01488854
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 11:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UkH/lxuwVl9i3D3NL9r9RZlqzC2Y5L8ONrv306XdJO4=; b=Cz1MQd6pYeFJ8mrL
	G3XA5Q4CHeQCdZbEIphNORGiAyNQzcnzm6qcCiNJl8E8AUqR+a4GxyHlxlyKyxfX
	coyIRXdLF5kqFdiPV/5VBHsvwmYXXdEY30mwcACf/UT4Asxzg/dQrGmJUNm4UUGZ
	gXC0NQqd1O8j/Se+8s7/DTF30HY4YmmG4bBy1bIOyaypITaRqn3wsmNsvaTjaucq
	qQpjuF1X4JPOF6G3waHiZyh5imWqfn3+Iyjchp1uIWth5MkAxs9A8oWSk51TKDPs
	eF6IJpnvFZXAxJ6wR3kavLQ6DQhwRLnMUlLxTOGtu5J2TiPBeJ0FDdcjZF/ZsUex
	Q5yeJA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jgvq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 11:50:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e965f2bbfso221312285a.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762257055; x=1762861855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkH/lxuwVl9i3D3NL9r9RZlqzC2Y5L8ONrv306XdJO4=;
        b=Kw094zR4ULc7Nfzd4rzdzkbQDuLLqKEYfWyU3pNgVEBhLpFZcuRSoc2MuIvBC7ZFC2
         XOxqzdG9iIFKDn9LSYHZKIkC07tcn7CiRD6iOUsyh9uyURVLGW+PuuhcKmqdbA7yvlsb
         bPDP82LaCK1JtfbKFG8lEmKC+ua16OuGXH9M+QUy+PGZrnpnHO1mLrQQ26HUdGMCyd9b
         o4/3g2pR5J1iadOgU/w4MXMXnFXP+UA7B5uwApCgv/WtzuARMO5M+ajnGdbMjs2evmL1
         hmDWYf7vMUhS3x1/v5TqLYFFN4Q7NrCTr31Dur2tcHH/qj/xkw9rDEU/dT0dY+vAgr2i
         1j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257055; x=1762861855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkH/lxuwVl9i3D3NL9r9RZlqzC2Y5L8ONrv306XdJO4=;
        b=I2qC+3zPYGDWmxF746+/wc2/Y0QyAGGfrixWbkLKw6sUCKFs+u3MiMmOnrRjE/gDcM
         1xtPLbeHL8PSJ4xZ8N8UUXrhEj+EsVnue5LIuk8n456S72hWZOAIKwOAaWQvPBi8WsE4
         uA4KghoHvDVFEkigkGXfnhKQaB9rf3kct8yyfZiKATgnc/RqMF70s/GDw+GYVQGMhEVj
         CN/UHhu4kVqB9YkC0alpcqtU5W65NaoP0esZuVhZHqHvvRkVb76f37RWuFL3hdot47M6
         ++TbZlLWFrxVtR4/kADcsPLMQj+x0nE4b5R2p2k9QQoi8JtGN8HqemmBm6jIneOWGEkr
         ymVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5rUmIyQyM0IiFE2EQKzI92LEE0X7DZxMS/N0AernUwcsqov15pQjhN74WOJt4dO2Atjn7Tq426A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeW+u+VPGTPFM4cbfbaL4rNXHLSwR1EEVR5tR/jaFHQ+o+I1l
	u6jzeDF4Na/UAzmoxggJF+mXVxOU6D4djuE3Ztxbv6hQtQecdpmqdjWsMKGcZ08ZgC7sfgbxUge
	/KAhDfOmm8Cw6w1EvF8itAA0FMsSSi9KeqyaV/50hQMQk0BjkTDnFBUGkk/IuSw==
X-Gm-Gg: ASbGncuZej3gpCAoNSFHMh/rusD3yDTpoVa2c4XtXtzkxyLMC/I5OZV5kQHTg1v17H8
	0gvn9Y4he+AYopI4q1tx2+el+GNQBG6FPtMV0JojFFUjMAYrIkUnEKQ1vrIZWSyXUeQ5C5ixMRG
	C52iZfJhNl9p7QzEqazOXckD/+eh69GW9pGiYT+NLqNvk1GrWsxsrYjuYrqjK8guyRaKQuCGKA+
	GoYIp98rxWB+NsDjkctvXzfuRWh5Fg7gha9mKDkINfZgJ0ER6JOtlk8mBYEPJzdReMa5OSto3BB
	vp1bxLmRgb8NJBt/ciBYRdaZ1wutYmRKuR9hOG3R59sRhq6ynHWG84MSBXUknD3PHE5x/z9x2Ed
	POVdiAZv+z5Jj0SholJ3y+xZ2/z07SafmBNwuhepbyUFPW9SOfnAbe7h0
X-Received: by 2002:a05:620a:1714:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ab987f9141mr1429710785a.1.1762257055059;
        Tue, 04 Nov 2025 03:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfk14ebc6h6zBWnJMrfOt7xUZr2p7iCHt90EAYEBiFxDeVcP4Q/S+ENPlE4waz4rA36IDENA==
X-Received: by 2002:a05:620a:1714:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ab987f9141mr1429709085a.1.1762257054529;
        Tue, 04 Nov 2025 03:50:54 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2597sm192129366b.45.2025.11.04.03.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:50:54 -0800 (PST)
Message-ID: <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 12:50:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5NyBTYWx0ZWRfXy583G7cnotrf
 JOYdhqT8RuzZ3MFt/12ABegugqlMaOVhEPOHfaYG8EfDjl5R1Mbwa8ndxz8FUzIRz0bBXh0yIlw
 43G8+1KUuX2NPnzev2vGVMMCmzb/iZgoAhqOm+Jy+yLtV14gIAR0XINN6di1L18qzTUDpXoSsGF
 FGNJgmNtgT+y/JAzX0bbjwqkHn6QBI98TPuPBrmYzfKqMeMEGYn7TNBaJlQyJvXenysRIf1Plfa
 zass5FjJqGiVipuXvA/UU5rT827CEYxcG3po7Z+cgZqtncaXhb2a74slcoSzu2IIxlHs5HJcGJr
 k7g2ueDBwcVD62OZI5xsDsCdysphvIc187SdRFXo3RhyQACG1y5GSDFy/JivTJD/rVnxUG0pmJu
 3RLjm4UnBb649FywFjI6DVZclqRr1g==
X-Proofpoint-ORIG-GUID: wydM0pMq79iCLWUWFQ2cvMg4K0go-lWE
X-Proofpoint-GUID: wydM0pMq79iCLWUWFQ2cvMg4K0go-lWE
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=6909e8a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bj_OeWTxAPJtTrmVhqgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040097

On 11/3/25 7:20 PM, Loic Poulain wrote:
> This mechanism can be used when firmware lacks proper warm-reset handling,
> for example, when the PSCI SYSTEM_RESET2 function is not implemented.
> It enables the warm reset functionality via the PMIC.
> 
> This fallback is only enabled if qcom,warm-reset property is present.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582..684e9fe9987d 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -19,12 +19,20 @@
>  
>  #define NO_REASON_SHIFT			0
>  
> +#define PON_SW_RESET_S2_CTL				0x62
> +#define		PON_SW_RESET_S2_CTL_WARM_RST	0x01
> +#define PON_SW_RESET_S2_CTL2				0x63
> +#define		PON_SW_RESET_S2_CTL2_RST_EN	BIT(7)
> +#define PON_SW_RESET_GO					0x64
> +#define		PON_SW_RESET_GO_MAGIC		0xa5

Going back to msm8974 where the SPMI arbiter first showed up, these
values are all seemingly valid, so I think we can drop the dt property.
The restart reasons are set in stone too, and you can find more of them
in the register description.

That said, we're circumventing PS_HOLD this way - is that intended?

And do we need to take any special care where there's more than one
PMIC onboard to make sure that the SoC gets properly reset?

Konrad

