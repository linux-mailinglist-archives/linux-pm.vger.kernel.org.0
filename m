Return-Path: <linux-pm+bounces-42145-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN7eONGHhGl43QMAu9opvQ
	(envelope-from <linux-pm+bounces-42145-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:06:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939EF2364
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496203046E85
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD53D1CCF;
	Thu,  5 Feb 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bh08hRqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4tDgLdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D83ACEE6
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293005; cv=none; b=HvVNML5E8e8pel5dLnQYeSOpvRwvHoAX+FAjldVPoMNoaJSziEvvHnm+BrsWlvodxBZLpRymHD/Niv/LqjU6G9OYqgM63PBjRQ9IBkbxhV65xc9xO+ju3syS3cZ6V3pRtjZUPwDbGjC7jnWZkw658T73QngvlOTXLlFrvMkIQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293005; c=relaxed/simple;
	bh=z1aNBf8qq/+Iyk1bcLI9E8TQJPP8Rk67gfvRWDCu0us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7QWwgdE/d7K8fgyKtHl+Y1ol++D0Az/Gt2KNl1rF7jRxwcCyzT2jX0jZhagnaVDFQj4OBgNBQW9Xa9j5YQw2DXxTEVlYzxDQPPFK5hQPC6YF287BX4xvNOb/fBYv+VAJnJZGyHOErHPvrA1zTXh2Drh5nqPfIE2ee+wjcQnMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bh08hRqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4tDgLdy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615BlfNg4135881
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 12:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FE5i4ccBmqmPlVnpP0IUjclBz7WYpfCo1VUUmVew2T4=; b=Bh08hRqKJqKqmss4
	82LOEh/8HYobmnfsaFsHqKyZu26q0a/l5dOKrAMDjU1IJtfNYExmUG21dnMTpCuu
	3Z/xV8x+m9XeTcY0T+aAhWmYWOpwHFBuEOnAfJKY3KTxqVguCUULLtYoJFJIOMgd
	pqFcTMP3KdhzEr1RKN0LYy5Fl3qHxfPkJi8db5djFkIbc2mWqH8W16jbI/mLg6ss
	Lp/5tTs/wNGPLGuQ8kAPnYp5WmaJrijDZG0GpUiPxpzeuRyREFhXJeye64/5V5Qd
	vLQujeiLuOwBEvFI/TE857NFRGlzUDhu4vrcqyd/2/TyvTIH5/Yym6xchmVX6S3D
	bUS3Xg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4tn401jx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 12:03:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c533f07450so30345085a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770293004; x=1770897804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FE5i4ccBmqmPlVnpP0IUjclBz7WYpfCo1VUUmVew2T4=;
        b=G4tDgLdy/Myzf8/9WaN2fsJPcWWuQPk0r5AOSv0nroM7inslBgSnfQuN71vdMsnH2S
         Bzhj42rTuk+3indA0fioGizvQxhEykl0M3El6+hCGMsqxCXbbhnxMv2dwj2yom3kuk3i
         C1B7nywYSICFd4KcrqqyZB9nOrxHfsK1++jKZTbB6eFCFxCJ7sMitSr/zOYPvh0r5uV4
         JTcoko7ohFVgfamS2J2c0WCoktUx3zxkM5vFi9VuDJHetSlABA3EK3+IQbn8rX3x3oS/
         7M9bgYKJlfQQiU8kFpL53zAlwjl4BDMJoWT17xpq/xPhyseo3Fd7m24N36nd2WDD88Ez
         dhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293004; x=1770897804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE5i4ccBmqmPlVnpP0IUjclBz7WYpfCo1VUUmVew2T4=;
        b=bIIHcZcyvDieu21pQUXNVatuStCNKH61u4Npw3iYHV9V3ud7bujmPA//LWT3NL1ssi
         0g4E/YH+986x76VU9ve49NmBQJ2ShBWaZnHxljOt0G0wa/3Npqiduu3nbPQakR+S5AbQ
         7hWG8YaKyxK/Th2XS9JT/l6cmZgfy1UPjAj15RNdAqOLa29lWbHpPIARWCCSzg0YpefZ
         3t9osP/N34Gsf1zOQzB/Lzr8LABtq1jcc1WuH8jkcca+ZxbqCxlwyxwL1sIbX9NreP/u
         AldHkpYDT7blwUdGHUpey77KrgM6JkFEqA6pIK2s7Ox6hDhX/8SmdBzYXaXoCK9DR8qu
         s0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXl6522gcPBaSvZlBSy1OCG+O5EskBlI4jpiRT9+MphaE/YLX0OFX7cfo4tSRLSnOZiT8gIp4/5eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSJNteJ2KauuDkyOFlDUcDQteAznZoLPVQ1+F5Fc7T7NQk0BZ
	PITOvOKSObI421a0/ELcN77k8NTHlZS4i0E3zWXHxzVCt6CFlxk9F8UkjpEkHbFJvnOxZlB/osJ
	QofKkEYmTWXvDDIpBwXQQk5hQlDbSXc6mJdSWIrKtLLtSINAnZl5Vlz1fJtj8sg==
X-Gm-Gg: AZuq6aKrJzQl+N8WJH1YuD66h9GdyxbsC7wkwKznRtuSDE99AJ0midpOWHPGo2jU4W8
	k78Nd4zJ2VG435csPmA5Eug0OCukqxgdawtV93f/NqHE63BIoti77JWvh/JHQ8wl7Akj6btDc32
	23nhOYR6FDfuNq5W4VgrPByNW4HUsOEs9arV2T8FlHSIfKSBmgZCNbrHxoBpNgsBKp/uNFbSq9W
	9vuWUkN/kM9YUsk+Xe3cc0DbuncerUewwoJwdo63iwAiMAnx+UkN1om18mfaHBaGy+fuiFhj4oR
	69QWq1e6t5XekeptGryiTf6TgSs+QpcrdHq5gj8X8Kmj0xc32D86UVTTie+UKVdF7z4O+IF7s/U
	ZqI2uUszoZx04MZgsKMV/zNPIUK1upSFI8lVxGu661u5Dkm5AUtEHehRucuUM0Q3JA+Y=
X-Received: by 2002:a05:620a:25cb:b0:8be:6733:92b1 with SMTP id af79cd13be357-8ca2f5ec4d0mr643929285a.0.1770293003972;
        Thu, 05 Feb 2026 04:03:23 -0800 (PST)
X-Received: by 2002:a05:620a:25cb:b0:8be:6733:92b1 with SMTP id af79cd13be357-8ca2f5ec4d0mr643922585a.0.1770293003399;
        Thu, 05 Feb 2026 04:03:23 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a2351e6sm1991383a12.33.2026.02.05.04.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:03:22 -0800 (PST)
Message-ID: <f9620566-0173-4644-8f89-52b7a69c2a35@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 13:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-1-70fa68e57f96@oss.qualcomm.com>
 <20260205-abiding-beautiful-locust-6ee1b5@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260205-abiding-beautiful-locust-6ee1b5@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h99Miyfj50gux7KJoc6UlNxDwzOH7YD-
X-Proofpoint-ORIG-GUID: h99Miyfj50gux7KJoc6UlNxDwzOH7YD-
X-Authority-Analysis: v=2.4 cv=Dfgaa/tW c=1 sm=1 tr=0 ts=6984870c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=eYRqk91NNi6RPXgtGVkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4OCBTYWx0ZWRfX4IRn6LXlchp+
 xDFkaCs7gATBpccg9h37cHk8jQMsDI2aSAEVrK7fvSbzDihCjabMENM0boFJs8OvmbuoywjfDU0
 o0UIpRvi8mxuZkGOAeUyMQvu/0y/wBMl69HevuG0sXI+/wVmtc+K5lwp9sB/iZNSOCDFajpLxDq
 QrNHAIuncjGm93yTg47bA2G49jDjA8nw/dkFnFJKwgStMjtDyWQ/IhGqfpqmJhg/9ej8+ynoeCA
 a8RUlVuFJq00leuHPohs31HFVY82UEcvTubAxmjHshftAC4OBJmaG0RBxiSF2PEkylsRDCKItRx
 1XeOWqvfsSuEyvFqem+H/gTuk+QgnjKFRk3ExNMFEVUlKwvUH4IoTvWuT3g6u7dCVriVzEiP9+5
 gGIG0/LX1+zWkz6vZMDe9Q1tefU5oKwyH3K3wTFKXaP87ZNY41vv6ChJZsZie6nkjMUFepIowOa
 OCPiremfJ9twsKIqMEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42145-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5939EF2364
X-Rspamd-Action: no action

On 2/5/26 12:31 PM, Krzysztof Kozlowski wrote:
> On Wed, Feb 04, 2026 at 02:59:49AM +0200, Dmitry Baryshkov wrote:
>> To configure the video PLLs and enable the video GDSCs on SM8250,
>> platform, the MX rail must be ON along with MMCX. Split the bindings
>> file in order to provide separate file utilizing MMCX and MX power
>> domains.
> 
> ...
> 
>> +
>> +description: |
>> +  Qualcomm video clock control module provides the clocks, resets and power
>> +  domains on Qualcomm SoCs.
>> +
>> +  See also::
> 
> Only one ':', please. It was a mistake to introduce ::
> 
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: bi_tcxo
>> +      - const: bi_tcxo_ao
>> +
>> +  power-domains:
>> +    items:
>> +      - description:
>> +          A phandle and PM domain specifier for the MMCX power domain.
>> +      - description:
>> +          A phandle and PM domain specifier for the MX power domain.
> 
> This is an ABI break, so please say in the commit what was not working
> or why this ABI break is really justified. Currently you just give a
> hint that it is needed for PLL configuration, but honestly - why would
> we care to configure PLL if everything was working correct before?

I fully expect it to kaboom if you turn off the display (which also holds
a high vote on MMCX)

Konrad

