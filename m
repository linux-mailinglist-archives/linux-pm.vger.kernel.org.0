Return-Path: <linux-pm+bounces-40833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 059ADD1DB0E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76D38300B026
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3137F730;
	Wed, 14 Jan 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQ8P5KQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcaFIMfZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE35322B69
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384047; cv=none; b=QyLRbr9b8EJCBQxkM5aazwO1NqUDgngvaXolzjQ5iB5ec47cAc9fgypz0EzJIgipTLwtZEfIdFatM5+JGumqeONROY4H4ZJ090X+fTX+V+T4/EWhHFHGsSMXes7U/FAfjag8qY9me3AuDHVoknxQxVUUnAA7+/sRj5b6M3fPaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384047; c=relaxed/simple;
	bh=1H71ql9A0jfornXBpw2ODC7HdqJ5XqT2KE8qRlC4Aiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXiuRhUvR5lUPWeG6jW3J63lb+p9x71PyzqDh9cKOTW+xCItwqu1wvVKy5Z3kkK4II9+YQZCb2SxF1UF4hkRFFhEOzrdTlESg/XI+t23iu2MR8pteK7mc8T2OdjpwmWe4ennm0dBbfFQS6M8Y3L24RdoBahugvJLRri5KrqW5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQ8P5KQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PcaFIMfZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jAGT2587358
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 09:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	99BKTGBFsYNDyPjzQ1FB6HexYu4nx2zw91fFccvYOwQ=; b=VQ8P5KQeWsq5fNOC
	TRWqDvbdtCbpsAzfxnMut/vPb/l+nSLKR6WOTToy0IFDo98LFWyUNwcPo8kzW6wS
	LL0BQEZ1akEvSAtagp92liu7K4xlxbU1XyETsQ5iMBif1+R3mvFanJE72JudTKLc
	Pm8edtiVHZoeuNihBf7fS+BUuku+yd3z5YhBciiI79qk8/EXXjAgSmzD/yXBSccC
	3+5z7EJYsVK/7aQg3qJ3dzljXHdCliUBs4nC2x0UO1wBapTtFu9w34Ou2SCimCjC
	t4y0vgVigADWtqcakC9o7RP+pJgpKV7XjYJwdzHI68vi+Oy5fQUU9LkfSrGExli8
	LmL8Nw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnymssy0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 09:47:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50148ce6d12so1744521cf.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768384044; x=1768988844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99BKTGBFsYNDyPjzQ1FB6HexYu4nx2zw91fFccvYOwQ=;
        b=PcaFIMfZDw2ECLFgdzjjETCsIG0B5vITHxyn1t4pGZPESU/cfJyYdT6EHF4RYxuxh8
         wNoFhDlRR4kJ7KYjnGKhlnEeuO5ZjIvsZv5L/Z0TgXp0UW/twOHtqCwI8ZzYUC4I1Rc4
         LrC4WlUucnRAWCEeDhxXMJuxPGyXv1MRFGuUM953ZRi/GbT6CpUGkXCafNYhLH27xHyQ
         M6XCWvN5dxczqx3rdtYx9s5TL+1ls4tl1C+xsM1S8B+ETBDeLWKHmQEySiffp6FAuuYc
         Jb9dMPXEWlH/ZOilzOq9P9vZ2xhcMMPjRTHzTeMFtwnNV2+/G6xbrGMDh4piBshblr36
         0SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384044; x=1768988844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99BKTGBFsYNDyPjzQ1FB6HexYu4nx2zw91fFccvYOwQ=;
        b=ts7vBxydcCKDjaQdDZohgpuwaRBOA1EieDkzoLD8kx0jeQMVYiYweH653eMeBE7GR/
         ic+Rxc1Q9I64KLoCvV3mSFe2BcLqHxH59FEPIjkzIs4qBJChfUz1IiNsL8+5E3e8wHw+
         GfBkou9KB7YUI2Smj/9/od561n5oqW/7Fzpliydw5p5kldSghl337L266+hfcs2PbtVG
         dRVtvdoXzzt2DRovByYRJbrtFhyRV2kPbOEsiikwP43KJI4QDsTw0pzCs0/x/hlSms8P
         zyLpVNr0KgCmm/EzJqsz/zHdLXlv12Y18a7iXTAD4W5PdorYnRIQMR8hiCiVzDpdLzND
         2HUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmZfLt/iSVMYVuPmCGTYaANcjKby0xpEOKioQZ8KGBXzZmM51N7qu5BeSTEiKVwnSBFK+FfS2J9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxO9hPaHMyDlzXH+HF7QSqgvaH7bt1eD4vJI1Yc6XgcCkWC3t
	mw+kcj7jk9VM3HNi1cLNrLZoqb7s61MTh7DwQjpCBBzK2mmI0GWtyECuepyeGzXI1y7uNNOmeYt
	TEm5DOGlhnFWSJQsHZ5oxlgtZCysaSCKZaS8OixSTJXHEADi+4+jGraconr781A==
X-Gm-Gg: AY/fxX5FQQubBm7seaErjFoFANeGN5geug9PCmAXg6fbqnampwhm5Y4kDudKYdMkfXk
	1ewfaOZ8nNGKj18Z86KZi3CPWcKoVPqyR09pEC+FyMpS2qa3lv8rv9axH8Cj1BXPRo3EoNpucnP
	mRJPB+rEbGYbzkiJKeNw1uU1ZWuPANdgByl0KS4vfnAoMO5VLyueu0MSY35l20qhzoOrqZALyYL
	JwSHxHF9ycmfQwWCYyNP5+70Q4SkvqQv50LToaEKvwnXlqulLBLrQ3aMeVVp2yQL/dOycWmBUug
	KZbH0sr03xuuYUM5XSJF/92A9MK+AkMeMsFt3GZmRXkBUHNKJUPG2oe0BMdsJ548bCT45fxP29r
	S4EcAosbxSHNl2t5GA3UAEjwGNjRIOaohH98sue2mObBU0AtBlZ9o7B3hDr3rbamKVAY=
X-Received: by 2002:ac8:5a95:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-501484c9737mr17815481cf.8.1768384044502;
        Wed, 14 Jan 2026 01:47:24 -0800 (PST)
X-Received: by 2002:ac8:5a95:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-501484c9737mr17815141cf.8.1768384044059;
        Wed, 14 Jan 2026 01:47:24 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6648fsm22238117a12.28.2026.01.14.01.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 01:47:23 -0800 (PST)
Message-ID: <ae46b504-58d3-4042-be05-f31e9e01091b@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 10:47:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
        sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
        melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
        ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
        luca.weiss@fairphone.com, mitltlatltl@gmail.com,
        krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
        kernel@collabora.com
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
 <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
 <aWdk-RP-59cJeCBo@smile.fi.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aWdk-RP-59cJeCBo@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA3OSBTYWx0ZWRfX3s1vjTb4DQ/U
 CjlsO/TUyPNkukhNsi66JXKdJkpshwmutTCZB3vjFIiF2pTtF6tyTQIoKukkXW8bql/I1FWyg2Y
 XCJRLaDX7CVeOF0Ch/pPKhTuF2aWa4Z1JYR2FhJGhMeBrgX3OV3/T3Bw5cGaUFaMeGKp3/soTRD
 BSVF0ezAzZMCsrCXoHdipbPvHKpfRZx78Al4QNhL72Uv3l3Ip+NNoGWwPWI6m/RcpMuyH4AdvYm
 UH7fxTY7O1N/bnDN6ZOvZMqBK+0l96JbxtQcrMnlcWGc/gIMSJW7tW6NtglkVYXeDllmvbcsftU
 rUpfpJMFT7CApZSzNndISrHmPe4WGObszhj7Sx7GQYO6y6lRNxmeVT4N2umKeGxIhC16q8t4DX4
 Gq7fJljH8801Kozfd3UXllgfVLTgATdSydkqq1GdT3XD3iAjz94q3g+3lUqdLl/Zx2M9OOgUFfx
 rkwyqDaO/xzfOz443YA==
X-Proofpoint-GUID: OvDA3P7EmWRPYwPif_HB5Ftat15XaQEI
X-Proofpoint-ORIG-GUID: OvDA3P7EmWRPYwPif_HB5Ftat15XaQEI
X-Authority-Analysis: v=2.4 cv=RuDI7SmK c=1 sm=1 tr=0 ts=6967662d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JqKDa6lEAYI_ZU06WeAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140079

On 1/14/26 10:42 AM, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 10:09:45AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/01/26 10:07, Andy Shevchenko ha scritto:
>>> On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
>>>> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
>>>>> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
>>>>>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
> 
> ...
> 
>>>>>>>> +	struct regmap_config sdam_regmap_config = {
>>>>>>>> +		.reg_bits = 16,
>>>>>>>> +		.val_bits = 8,
>>>>>>>
>>>>>>>> +		.max_register = 0x100,
>>>>>>>
>>>>>>> Are you sure? This might be a bad naming, but here max == the last accessible.
>>>>>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
>>>>>>> 257 registers, but sounds very weird).
>>>>>>
>>>>>> Yes, I'm sure.
>>>>>
>>>>> So, what is resided on address 0x100 ?
>>>>
>>>> I don't remember, this is research from around 5 months ago, when I've sent
>>>> the v1 of this.
>>>>
>>>> If you really want though, I can incorrectly set max_register to 0xff.
>>>
>>> Why incorrectly? Can you dig into the datasheet and check, please? We don't
>>> know what is the 0x100 address means.
>>
>> I don't have any datasheets for Qualcomm IPs.
> 
> Hmm... Can we have somebody from QC to check on this?
> Perhaps Dmitry?

0xe6 is the last usable register today

But I wouldn't mind either 0xff or 0x100 because I don't want
anyone to pull their hair out if a regmap access is dropped some day..

Konrad

