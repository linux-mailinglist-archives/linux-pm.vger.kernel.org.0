Return-Path: <linux-pm+bounces-28609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EDAD7D51
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 23:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6945F18986FF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000B2D4B58;
	Thu, 12 Jun 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EaxjjFpJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BF22DF9A
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763203; cv=none; b=PKfntVLNYdQdYmg/1lbuY6AnoKY0z9T35V25wzBXpoEZYzbOh0NAOKZaiz1hjPffQsmpy2JrNOsCtmk5yfzeRikVhIg+OxKRPTarSrHwre45qmAG+0/R7bxqCRGhiGh0V1M/+7bqjL83k8Un5a9GesVs0o4fnKVOi9BlknlWxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763203; c=relaxed/simple;
	bh=H3ogvr7A5eaCLCoobtUF9Y+ndFSfv9DKlh2LHMiNqnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vhu//2wElMBRnT40QERQVxYY8zv2kAsbxzuenlSuCh26cxC/wcjhJ/G0NYaJlCIhLfHC8jCViv46EGbLPm5Csfk1ulQyBDcswhR1NWxNpMjqha1YWK2I3GtGiV+rLkPbnEDNpb/ETSazEvSN2Jw7scg1VaUoO4zdGlRYL9MQEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EaxjjFpJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CIM5e8009041
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 21:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Zmr5+JECjNDrTnuNUMITpmDMpNItBuB/kFf5nbp53s=; b=EaxjjFpJ7wS6WdqT
	Al1W1Dj40l1WVibjXSMhFBkQf7/kUWFEy7BYQ5Xh1aoIZxivt/1erMUK4pXf9IzK
	D6GvU6tPk97CzCjDbyjp4RBj9ZR2Q1Hvg6pEjCSoSHTOS3GpK1i0MNQqh6ss9Eg2
	SsavzA5JlzCtAdLE/i56RtkKXQdF9mkMe7qiHQCpIWSERGU97gZWoXfBPDeAs+Jw
	GtAZTZSGbvNuZJ46oglDZhV60SoySDp0yIswVG/qv1FuDvK6FXSbAiIjtNYMBxKL
	RYCYlTJN6LekxjS9R3Ha9R4GwWOjrVcR9JwvsLgw9wJq8Ykq2S9uhRG9dXyOKWIo
	0C2X8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753bws6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 21:20:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso364991a91.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 14:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763199; x=1750367999;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zmr5+JECjNDrTnuNUMITpmDMpNItBuB/kFf5nbp53s=;
        b=GL65IwnclopGChVkM4Q1hDtasABBOZ3GIH4OzLHnkpH2Nc9PrstYFEf9M4IWEhLG10
         /znos5ZXXq46kl5E0m6O31yNcJJXsl7ojn0UOVaaiWSfP5J0Io2OUQzQzS242OM2X3RW
         liO+Yy83ugKOoRCybi646i+b+ce9Z+VfsZwLGFS59Zs2l+50JgoJ736XbOTtM34TqlQv
         gsicW8cn3+2Z5NGuztOL25Wqr64t4ckNxEITWu5tVETWm9fM4Awye9b7a7msldC4nr9v
         q0ZbtmXDS98B3FpNqkr+06hI0DR+LM8P2zaaJE4PxRqaClXeXrn1/mr1m7wZWnPU7koi
         n+SA==
X-Forwarded-Encrypted: i=1; AJvYcCW8EnKOTdV+bD3ygKClxJWyWzKfsIOoosV1V7dmSQROBxOZbAZW5FTD9osY857jeR8W+3z/dAmpGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfX4MSJO+m3zFRVCh0EvoAEUQcRwuaF6B3r2CGVyHagSaO1iI
	m4p+6odIRYYXqbaxPN09B3uww4IDRxeD4kq3cRAyzU8MfIZ9cW0MmfDgP+cyzQUDJ4tJHFUMKpG
	TKTDZd8ji6j8+m/HeDgNiWLMEWX90LdrB9EeyDmLx3wc24jxQzJ9HJgJww4CnLg==
X-Gm-Gg: ASbGnct7iqG+UhKR/rQ+3h26MjXYXLiFlMqlAI3yEzbY2ly6DvZl8Zf42Wh7RqKAyih
	5NWqCS5FJw++ODWZ8z/CEM9sCLnQxgt4Hc2KQMFLVqZKtIFytweuPxOgNZRNuRYB7PGRRiU3UBO
	zTMqbIkxitRZgADZ/zXZUcK7mgMb8xA/Sn6kVx61sVpeI2P6SVnjw82dCnwmaSfUV+yspnuzVA9
	EUKCqa7DpZrLn8voBmUQpvQJpL2EltKUP6hkx01BPdmbdPQrx7qsOFOFQQJ/DvWy61trHawSxHK
	BGAS1uD5xSd4NjDe8a73dTue+ygHtXKpz7wBNIJVGg==
X-Received: by 2002:a17:90b:1843:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-313d9d71383mr1065535a91.14.1749763198846;
        Thu, 12 Jun 2025 14:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcEB2oQFFgVMym1bB2VUhhziP7lQFCJfNjFpbKCnIdWSG44vwJc/VtPEHqnpJDg2SoasT6AQ==
X-Received: by 2002:a17:90b:1843:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-313d9d71383mr1065512a91.14.1749763198422;
        Thu, 12 Jun 2025 14:19:58 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.228.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b5a882sm1990932a91.40.2025.06.12.14.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 14:19:57 -0700 (PDT)
Message-ID: <036e739c-54e4-4252-b6f0-c8eed5557d15@oss.qualcomm.com>
Date: Fri, 13 Jun 2025 02:49:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Support for Adreno X1-45 GPU
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
 <0e6fd97d-9a56-426b-8b98-dc8aa50d02d2@oldschoolsolutions.biz>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0e6fd97d-9a56-426b-8b98-dc8aa50d02d2@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE2NCBTYWx0ZWRfXz6gTz+snIPFR
 ZG8gnHmkP6lTn5yzX+ABI69/2s8FVRlvF1nxvPKr6oxqmtJ4YGcD0ZVqEPuhPTCWv8Ep6ckxNH/
 ejs6iqS1Oha25InkQ0woruYRZowwfMtKhY027g9TQxL+yfZI3er6G8+zkN7DEGiBZCuc2kxn87I
 1tRqdTYvjBVJnmEQQpD8TcjjqSOsSFkhprIhAfUGoQmF0xW9a/gMc87hEbJNIM2LJrIqwBCxFKJ
 RGLQBG8N4yzXfKyDEICnYkhjsfolidcUHH7peg3AkIlgyMod7nB+gE4nElRwEfuCSGKNoCJNHZq
 pUFt/3N9Da+EHXqTxLVn7SVlTXJxjHArL+17A8kPkSOf6+cMqYWOZjlb9b/3TEYcblUBuyZQlTu
 cgUfmieghjhkc7HkB571LMmsmjzdN9WjggqaQQUenYP4gEMuajeS3Yq4ILgqw4vL+PuLYVgi
X-Proofpoint-GUID: jwbcr01WecWHnBmzfh1MfPua_eWQnDm4
X-Proofpoint-ORIG-GUID: jwbcr01WecWHnBmzfh1MfPua_eWQnDm4
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=684b4480 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=8TKXt+tWyFtBY9WE4KDEmA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=uKUkM4gl_lyc4tR08vMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120164

On 6/12/2025 5:32 PM, Jens Glathe wrote:
> On 6/11/25 13:15, Akhil P Oommen wrote:
> 
>> Add support for X1-45 GPU found in X1P41200 chipset (8 cpu core
>> version). X1-45 is a smaller version of X1-85 with lower core count and
>> smaller memories. From UMD perspective, this is similar to "FD735"
>> present in Mesa.
>>
> Hi Akhil,
> 
> when loading the driver (still without firmware files) I'm getting a
> speedbin warning:
> 
> [    3.318341] adreno 3d00000.gpu: [drm:a6xx_gpu_init [msm]] *ERROR*
> missing support for speed-bin: 233. Some OPPs may not be supported by
> hardware
> 
> I've seen that there is a table for speed bins, this one is not there.
> Tested on a Lenovo ThinkBook 16 G7 QOY.

Hi Jens,

Could you please try the below patch?

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 2db748ce7df5..7748f92919b8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1510,7 +1510,8 @@ static const struct adreno_info a7xx_gpus[] = {
                        { 0,   0 },
                        { 294, 1 },
                        { 263, 2 },
-                       { 141, 3 },
+                       { 233, 3 },
+                       { 141, 4 },
                ),
        }
 };

With this, you should see 1107Mhz as the GPU Fmax.

-Akhil.

> 
> with best regards
> 
> Jens
> 


