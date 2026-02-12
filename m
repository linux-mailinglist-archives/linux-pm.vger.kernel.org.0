Return-Path: <linux-pm+bounces-42573-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OByiCboAjmnR+QAAu9opvQ
	(envelope-from <linux-pm+bounces-42573-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:32:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A734B12F791
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E447130498E2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429735CB8F;
	Thu, 12 Feb 2026 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAythN75";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XaPrlk3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E363446C7
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913920; cv=none; b=kyBYZsHrwaGYgFKjEaT5wKha3OItis0tBfRTo7MHUiaKhBNDqGdSEQnvjsDifRyP5j6gE/LmXwkcVAwpgdnBqd1AGmiQ5XFvfmhnDi1xRU5am7ZBANaPp2l0vr+5WbjjT+gNHhfch5D/8M6Vx9VinrAEEJFWiTNeEiACTGSeBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913920; c=relaxed/simple;
	bh=lqp1vYIvVtjEJmhwPsIBSliYmjO2mIm2/HQ2+ixpneo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hch9bjkD85Imh6ZklLvAFxfMce1bxLw+XotlrZmgfyUfyuq8yMz0xclxLQERGa4guxdO3BhFB+DLh6M+6axdHe8w1PUNQ6f0xStM+KuJhKGjF0mC85W46zc4qgP0OOLEq1lN7oHgjliag0Hqr8GAiWLyg680QhbtMitxA3EZ8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAythN75; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XaPrlk3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRhNt421513
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kbe2C/3H5RcHyrBurmPrlUVdtgJk9ApFxvYyiLaMQas=; b=oAythN75n8jcDW5h
	2siQ5LGMMJNE9GCAV80jS1l2Xtq3WN7GA+XpBxO0anQ6Vnr+8gYKPiChs6VIvxvY
	hidNvaEXXDo7Tr4pLw2D/+oq5U0AL4N8o2EwDaaguqUU2cs6n3S8OSrPULXnqV9+
	hAFMaHKlLkZG09Z0t7aoXUjNBU3su9YAlLxKro1Y5GFIRf+emKSZknHkNrn8I12s
	QDbm0zD/bgwz974fDPRBMou+5WzF0C/D3u/5odVc8mdVmTQjmLoXz0EdR1hevJr/
	oAZoT2A289E00YneMtQ8X8Y6wJ39v5xLkd49aGlT3cqURyTGgeE76tGAuP6b1A6a
	6mmWFA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy496fs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:31:57 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5674a0e6953so6331e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 08:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770913917; x=1771518717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kbe2C/3H5RcHyrBurmPrlUVdtgJk9ApFxvYyiLaMQas=;
        b=XaPrlk3jj8raNka/uM9x1u+vCdc4FLo5Mh8y5BvfcQOOiix5oh4EsfpleuK5LhYyK3
         sMZ40gK83X734MBBSGCC5iqr+4PLvTe9k4R4N1AfJ5MHpNIMBx6AufEV/qiSpNeAHLJN
         5HODdtcSGeDS8yIqArLlyEoR03xp7YivLsDvMbRgKBfVSTa6OLl6IvKX1Sa2JjtP1caY
         iaOXauWz1XX3r1SUf+qCSWdixIcwlKaT1CxEqtudCXq6ktasEyHlwlmpnRYhgXjS0oWA
         H+/zSGfOTEeUH34UuSiNAbFswekV7l8MfVMOEz9wg4jMcZma/Tlen4mkTd1FCt5Jagm+
         HmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770913917; x=1771518717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kbe2C/3H5RcHyrBurmPrlUVdtgJk9ApFxvYyiLaMQas=;
        b=KXevv7+IV7v06ZfoJvW7TFECcyVjlxezr+XhNrxwgM/039Y93OPrfbaAdZaNx7fUor
         6vBqq23W/tqm/3YNs0e8OvlTN4qLFPwKVlAEYrYsj5/9rhIg9ljw4wx0x/493juwmyl2
         6bf1omBCy/YU1IMFAujXIHjrfHGMHgDTAvNh9PW5LubHtqGom154U0F6tpTuMOyHjnNT
         DnL36XNurin89dxGVN06p0/lGF3ucc3bFCeKiNth4YbOZIxEyiUmGFZoAL0ukonciC3C
         6OUFioXKuYH9SGgqh0n33GFE5zTjFPQ7ehVMFqMcNoPRSIHbql/pD1SPSeGk45zIBfi7
         +peQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rqvm1GB1weYzVdChXwRSdSg4BBI9mDLHMhdy2k0E9uYRNtzr6GRNdWoJpdZzTVVuDQJ+2rGhcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJl6GeyaU2T974FaB35txZoKF2ZLoNKA/11vRdgD5UnUsZ47oI
	udtb2mVoEJVpUAAqea5UxAXnX/dm+zVr+eywqmpYlnUy6wQh6yj7DbWubcRGim/LMGHgw+ADIYf
	Ee4/rNfT7M/ngHGZRkAyOpiax7IzSsFtLQjCo52DR+rRUr1fEYaoJ9gJNWxWg4Q==
X-Gm-Gg: AZuq6aLA3YsmkFIMFq+oSRE5CXXzP/7t1fg/SbNV/9gR/+WEQ0D0tiArZ2S7nmzH5HC
	0xfi8qsyzAPMkpZvSLUGM+REdnlYfJR5PwLSwKz/Gko88WIrVMsM1sTtZLdJY6nzDdKpHzygWrI
	cZjX1OaWoWziVQkHHerR461b48uvsJovA0lKQD589MAVJIZxYbMmPjky5YCSTBA3cBYYTutzP9g
	tSx/R1Twd3vtRV8qx1pJuMwh31XglPLaaE1ncMbysE6v5Glbw8ui0ZrMuKwmIHiFqwtjKhwyQpn
	qUVdKO80ccTnj32MQjyDO4EM4/wgXbThZ8IH8yS5ozBeW0FQ6KYdQix39RRDAcSxB96xxp8nlFA
	NaSvEeVMYlIOd3/xYW7UAfDMQYqSlf+2uoJH8uvJAQDkIoo2OOduBJ04odzqv0o2HVm4pMiDmyI
	fhynM=
X-Received: by 2002:a05:6122:12bc:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-56759bad998mr431793e0c.0.1770913917071;
        Thu, 12 Feb 2026 08:31:57 -0800 (PST)
X-Received: by 2002:a05:6122:12bc:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-56759bad998mr431775e0c.0.1770913916604;
        Thu, 12 Feb 2026 08:31:56 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e9e98ecsm173956166b.30.2026.02.12.08.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:31:56 -0800 (PST)
Message-ID: <45e8cd4b-0b5d-4c5f-8c6a-7be7660f14b1@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 17:31:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260212161949.120898-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260212161949.120898-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h_JlvpnVERd6eQS8tdy65bECXbei6s6g
X-Proofpoint-GUID: h_JlvpnVERd6eQS8tdy65bECXbei6s6g
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698e007d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CnfyucVePACUQgo_Z2AA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyNSBTYWx0ZWRfX37i9edvokGRu
 9WiUncqQwsmQMQWIBUt9q8YxXVvhOnTnMyCokCXH1p7nme2M/V4O1ld6rr6smX/1RAzIr9B6dVa
 t/ZexYGH18WrqhMrkXn2y3Tr2OBaDQuZh4ofDLJD6Sd0gROw8xzscYHabJH7YA89jI7x8HN9yoI
 OFO3dDeZIuq126etmquXeB1Sc9qpg5YkiuhZzTlviO04AngOzE4DUsojFITSnnRsF3pO7SOa+Xb
 VTrbW4hV+BJTOtvFTmM1NAfHvB+Fa+bX+anAq8RGtoWDn2iKmSoyZ061/RTuwuUpvcOhgwv8KGs
 HGd/yG4NyLfC1mzTfYmJjULZgn0XOa4XfOSqJMY2ghf7RWJKQmzf4JkGd3/7tKiw9AEzVi/vq+w
 T335FqlRU+wq6QVS1xYLxIu1Q+wtlu09IEC7+8FwhVK0A1Lkhz/viEOhr+/xtvNIvrFqlz77n6d
 Z4i1PKNDFUJxgsB/yGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42573-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A734B12F791
X-Rspamd-Action: no action

On 2/12/26 5:19 PM, Krzysztof Kozlowski wrote:
> Document the compatible for Qualcomm Eliza SoC TSENS module, fully
> compatible with TSENS v2 generation (e.g. SM8650).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Eliza SoC is being upstreamed and the compatible will be used in DTSI
> posted later/soon.
> 
> Some existing work:
> https://lore.kernel.org/r/20260119095907.172080-4-krzysztof.kozlowski@oss.qualcomm.com/
> https://lore.kernel.org/linux-arm-msm/?q=eliza
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

