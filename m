Return-Path: <linux-pm+bounces-37339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F0C2F2CF
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 04:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6781A4E3866
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 03:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92052299949;
	Tue,  4 Nov 2025 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XVIgJX9r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eox0Vjed"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827528EA56
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227311; cv=none; b=Z1CR4X7Bt3BszeituE3ANHV0VivHHEZcLuIBwt/EWJqHOxkRRnpxwEIMVbRt4svpIdtQx0IKSg6T2I/lSVHMP29h8TBCCjmVlkp8UxP1i+aJTPI1Qi64xIMmJuERrT6DTQHQtD7xbOqZV/iPKd8Tk5hVkwM7LM27994Z/zmuDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227311; c=relaxed/simple;
	bh=t601eelFuhoshQ6UhK8FXumC5nM+7Pd1jlLamcO04w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPjv07fTlu5POf5h5Kzzuom1h0nT2UbJEfociil85mzhQ35bzZSQs3imiH0IJ/KPmr/08O6AE/B+FAzGVTUwkjzICU1TOHLCI2fNlIesHBtuF3EAdREOppK1DgW+HxFJl/V7VKr6tBsDiDSPg5UQeqIej95ddkXCKcJhFGbsBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XVIgJX9r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eox0Vjed; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42iZ3o3693375
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 03:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8t0XF1cncrMQz+L3qdd7BN2KhVFZQpN3RctAGGxSyNw=; b=XVIgJX9rvYhblKcN
	3zgiElpZZ3TIYZTbMXRXgyJ84sYf5LoF/Yvar579lS0fxJa/TNEzoSLyog0DWrsT
	y51f10Mn1qVkRJY50Qb9zJIzpQ9KVZ7FAYHMJuzQCHj+/ujTOp6N+EqBnS8oGVWb
	sMvdWJTAaN7ejy93LQz8IQ91f02ZBRAj7HXkNCTnO1lVZgEoSnD09nmEv4rHbc7s
	A9jHfoUz6mwpRI14CSUO5IIBV6gNSVvktreBG6XdpEZ8fGsMO7s6UgVq5cQn8EQx
	jWpcDMgXLH3zmsc+c+f/XEH7XzZQPRXtZVbtSEK07XsZZT88J7ch47epmJsWh6ML
	UI2QxQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b2fbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 03:35:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2950b8e12b8so13595215ad.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 19:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762227304; x=1762832104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8t0XF1cncrMQz+L3qdd7BN2KhVFZQpN3RctAGGxSyNw=;
        b=eox0VjedCqvYXPB0FbjX3wOpW9Gl1SRASAkDaAOrTH9vLaTCrwLe24TTKh0/40vaJj
         ujUaRaDyNoS062NUTgyXa6YpIRjqDvSyYjPSaIu7UkwsDYn8bEQJqs0d0Sd5slzF1niO
         A9T39dSxcbhP5m+qB/SWoa4OHCj+Z3EIX9t+mpZaxRZ2ff0yLpI3bPdQaF+Rqde9athP
         lOZPhJ8FJKRtKBn90YOpV9rERBd114oLvtgxCmbL03+Z6Cs5lv1atSBDlfigl1uiw78K
         YRq71QNVTG/4u4X1eTWVtYdAzEcHiFevjWt1Yf6IMEKEDIDZSdcz/37iHtiBFiKjlfzd
         4srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762227304; x=1762832104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8t0XF1cncrMQz+L3qdd7BN2KhVFZQpN3RctAGGxSyNw=;
        b=QiBYXvXwENg4SddG2Xoj2WiCBLLbQYFdPeYeVxRphwV5IrdpGb94JTpGUBinWUTmoI
         PgqnQj1BbmWCJUQkyozu0VD+UsccT/tFnIrnZSg7ppXuRViNeM+K9uZR5gQNTNjKm0CF
         bsz5XcoKqnrGjGRqCx6U6DqWyoQzMVwSdj/etKOcfUZ/xw2fQPGg5lS5bRik7MKfPJq+
         OzdfNIA2o+QKoJmH62BDvl5hW7K76IoemaVMaLddbugOIu9SCqiqXUNbw5F9KyoE7qKH
         XyANDOUB7oSrwop7g1ih0WatfIOnT8Cmq49Qa0fPGFJ/4KPiKF62+PO3KUBKuzZBk8Nt
         KK6w==
X-Forwarded-Encrypted: i=1; AJvYcCUO9ddvOUQRBLyz2Z76p4aWLFcvJuleHLV1Ssjj73OjIvDyeZpYR7a/KBJOJ/+om0p51t7v56BY3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcIYFuqRTgsobpyzMu+4ii2OgdH4SIYqBlfDDmAF4NnkhoKe4
	H7bbpP0KiI5CC3sjKr5c8J3McvtA3EgmCEloPEH1st/cxlEys4mSFU4wH3eMJ95ybM9eGf8PE6z
	CDkBY5FseB2xwuh0ixUNeBiSl6MVNARbfUCpVnqu+qi9Im9KwNsmSOVaU4U24ag==
X-Gm-Gg: ASbGnct0bFrxrozMOSH0a3GORphKaFM3hdYoz3g6A8ynmK0rftTRs/cxaEOwbFa4b9T
	i1vQK6H9hSy8ioUOj8LeNzsz7BS3ta0OBmGWriqiLBLbZ0gJUMtvKg9D3O5A1Y8aMPqcijCfi4x
	EiV0jnvKH/IwDkc6x9LXqKmyZ4XsP1oIPzMxzpjzMnETOGgSV5CB4agUkvPJf/fbCvL5kAs/VvI
	9capt1G15LwPwTlxbHkhPCS4MeSkSAn1ziY0xjc/UBlM9NAK0gIoZ4SfIo6sy78/SVq2KQoVd+M
	4ZssRfl6cHnJwOB5bCWA4Vxvk+nGRZGwV96IKvqHxlC6Bf4QGtFvyRWOBhwY6GzUhHhwNAgdA54
	O08hSX3na4b52IbbjxWn67xFzOS1coYDKTZHEr+GqYL100U0zAOtzC6OYRWPPErg3wg==
X-Received: by 2002:a17:902:e5d2:b0:277:c230:bfca with SMTP id d9443c01a7336-2951a3b6656mr105514155ad.4.1762227303961;
        Mon, 03 Nov 2025 19:35:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPCTZexD+QXqfxpLAdQ9PN7TgGgbumgKenU9BA4EepJgR6Oo0ZpARKrQ1dKow8iyI3o7tD1A==
X-Received: by 2002:a17:902:e5d2:b0:277:c230:bfca with SMTP id d9443c01a7336-2951a3b6656mr105513895ad.4.1762227303459;
        Mon, 03 Nov 2025 19:35:03 -0800 (PST)
Received: from [10.133.33.149] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199c338sm8022115ad.46.2025.11.03.19.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 19:35:02 -0800 (PST)
Message-ID: <bb3fd5f0-9797-48e3-b54e-fb2ac2c3867a@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 11:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Kaanapali
 BWMONs
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Amir Vajid <amir.vajid@oss.qualcomm.com>
References: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAyNyBTYWx0ZWRfX1I7TkBM2XJsR
 6ONydpWLk6Wl4DFnFX52g2tp2FDJ1+B+FAU11ta3MrIbE/Qgok2RCZNbgivDdMiFi0qIdmrLdFs
 WWPXzYmjsfXOeIP0hMONhhxY6/htODMn/X7BCH98L5NjqqxwGRcNaJGbGejXrW/HcenqMdCJU5v
 EcmUrecln5R/qflFUi8QZWiBJ2PO5DemwIdUXN+Kt9wyMr3I2bpvYGx+aIaM15Km6ot0odd2s/N
 15RvEBGdS6qy92SGW2w+ITxf2K4aZtlC0FSwqxCtJmvANJG+vtqbwVdlygdDF1FnTtYqlf7+eF9
 QYOMgLS+vkjYjgEOPuK7JNlS0TVW3l4o93w5v80EriBHX8IdEEJwmdzeldg6WU81vI744Le/Ljz
 JOvbZV1PrZHNXQmX6PqL4t5HRf5jOA==
X-Proofpoint-GUID: 6djpY3ygOMcRkNhy5buj-xHLe0FbGoNz
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=69097469 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=k-oXDJut3rjzcoNMBmMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6djpY3ygOMcRkNhy5buj-xHLe0FbGoNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040027

On 9/25/2025 7:25 AM, Jingyi Wang wrote:
> From: Amir Vajid <amir.vajid@oss.qualcomm.com>
> 
> Document the Kaanapali BWMONs, which have one instance per
> cluster of BWMONv4.
> 
> Signed-off-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 256de140c03d..0d1a268db921 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -25,6 +25,7 @@ properties:
>        - const: qcom,msm8998-bwmon       # BWMON v4
>        - items:
>            - enum:
> +              - qcom,kaanapali-cpu-bwmon

It looks good to me. Glymur didn't have this functionality verified yet.
Remind for review.

>                - qcom,qcm2290-cpu-bwmon
>                - qcom,qcs615-cpu-bwmon
>                - qcom,qcs8300-cpu-bwmon
> 
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-bwmon-d3e2020ca6b0
> 
> Best regards,


-- 
Thx and BRs,
Aiqun(Maria) Yu

