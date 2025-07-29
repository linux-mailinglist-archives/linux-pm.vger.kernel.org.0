Return-Path: <linux-pm+bounces-31565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358CB15514
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A844B4E1759
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72227816B;
	Tue, 29 Jul 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3WYrD6V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3C2737E2
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826934; cv=none; b=UR7E5+9XK5476NCejqKvHUtojLYmeJiR44C3vXQE1SOj/zz+spViaSpTo8ofSYUJsNKexIZFTWeMj2OYQpiyBFE+Axuz12WN6cpysrdmApbGtbx+kyG0hNZVA8hcj2vtRvjVA7eMf08x2hj/JAbH82fZ+GUJmxtl68hSPRLabOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826934; c=relaxed/simple;
	bh=/116a9/ohobL2Uok3T+K0EljoWhiGCaTOs4mb6iaYqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW5K6HPzRZ+yqnGBirAsBUOsH1atxfVduTGChUrKkkt71tW+DgvZpjT4Pgk3KWESWZhozBKoyXLyA9ztKiZKV+SumMnBeJZEpCAViWx1M9n8GGPUAEVvxGTKuiWkHT2CPSALKaOe0JFJeFMe9JP5PQKBLeUzSV7CHYkuEQogJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3WYrD6V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TI2dl1027698
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 22:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cE2pbs8FJjLTVtcD0Npu8kn7V5B1NRwJqNGNDeObNU=; b=U3WYrD6Vpc9KtYZx
	RpNBajo0fv4PIQynCH8pC+mKt4kLYIaCPcCBMoUy+BJGSGMVjONqFqgx4Bd7aDWd
	//xhYdaYSBZDZU0yH1Pqw01tUFcX8rTFcaltofq0YBziLQWNunjTBYySnvEzsxJZ
	XLuwgBUBgac+ro5cOc257ALZ0H/BgL1s/WUFD7vNz2hSgG6B/WcP4vhko3GkLL0G
	Xkw13bsiSvy6iejGthqNvpPtf+vfeX4KN27wmECkC3guB7CUlkULi22cthpQFwvD
	1QfFvqffBHLfa48KB3zXkX8WNg2N9dP0dRR/1xW+NtpWvdd8emFIrvHuebbILbXp
	rNYa/A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860enxy2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 22:08:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-237f8d64263so3277465ad.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 15:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826931; x=1754431731;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cE2pbs8FJjLTVtcD0Npu8kn7V5B1NRwJqNGNDeObNU=;
        b=TwB+VUZ+mmVMoAAHekYYv3KKqEiMVI40HcMjJbU+yxyCcwB9FbYDKZEZYn3v4ZoTzj
         4gcuh+km+krFocdWLQJy9hsi9+0C/O+ewEOEJ01a3gu0MFKzl8RRgZeenZmK7t4dOAhj
         zGn7LlSZOSEsGYe35K7TEJv6gibL0Q2Xvjroozu4N4lZooSl5l1V6HusO+r+Iwjr1xAO
         A/nICg/G4UUYFqgZThusJBZTBVbXHctNkkfwBF/DTLwXVDDg++W5k0eYAI4LfnT3NJQa
         QbGK79OYPh2h8mpPoqMD0+7EhHPSP3y2Gbw8EyCgjuK4GNK8oStuM+HVlsYeIh9R/j7t
         H6MA==
X-Forwarded-Encrypted: i=1; AJvYcCX9cv29dmQ/fRtWNyVSnA/xehOFxTIaeratu4UFEQD1AZ6nAD6PcVN2UlSYC9UsioNWPe3rVr1Mjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycfaFkdOJUA1Eb3eCh4rNihKMHZAC2/nuQ8WWjYl5QCzy9MYDM
	YKX8TmtJNRQfm+nLEo5tIpTXg30RRXNQzyChyerrdBssQzozsClrReN/Vy74K5xYQbMOX8ziJKP
	hpSVymQE1xByBDAKhBSxpwsHxJciwaRNZYAvOBeB0BLkX9xuIJu/4filApOLZow==
X-Gm-Gg: ASbGncvxje3/g05Ygrj8KkjiHm+BxMklibHApFGEBRQvxu0NfK1hwhQNTCOv+ZTVp/S
	4nMLxxF1N9F4h+XBmxdEEe5UHFdd9WAKjV2fcizXWBSlNt8N6WrL4Gtt0eqwMjk86CQensIVtqc
	CGqXxlTb+GDFAoTBAHRliii2R7DTzmnTFfwi8UknKXICi/3IrLDKrLUpknWyBTnyJjSfvyazqfP
	VqXHA5EUDzhVrxr+gaHNdG0P4RIkcS3s2a7bT/+O7tjMkPupn9zKNgr0CWEKwd254frA4IcIHFA
	FDn0S3uK+5NuCnxs5gEKxbhc5MQYFMESxF1GgHyLCcfpbWzn1Ydff03tDV3dP60S
X-Received: by 2002:a17:902:eccc:b0:240:968f:4d64 with SMTP id d9443c01a7336-24096a47522mr13256585ad.11.1753826930863;
        Tue, 29 Jul 2025 15:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvETWK9P4/D0CelAU3J3wu30rrD9X2asRN8OMQAvwraBYzRraej0TCmImrwEUqpGOhQed93w==
X-Received: by 2002:a17:902:eccc:b0:240:968f:4d64 with SMTP id d9443c01a7336-24096a47522mr13255985ad.11.1753826930270;
        Tue, 29 Jul 2025 15:08:50 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.231.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403e020de1sm46439195ad.15.2025.07.29.15.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:08:49 -0700 (PDT)
Message-ID: <6c0689e8-38b4-4d3b-b475-0ceb16046875@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 03:38:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold
 <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss
 <luca.weiss@fairphone.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
 <aIevIuMDA5R8igmi@linaro.org>
 <50868cd8-68a9-4bad-99f3-8cf542886fb6@oss.qualcomm.com>
 <aIhrav7GKpsbVpto@linaro.org>
 <6b903628-9abf-4b9e-971e-e9338308d693@oss.qualcomm.com>
 <0a1337d7-ee3e-47de-a401-b25586e813e4@oss.qualcomm.com>
 <aIjsTgA7O7UqS-Oz@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aIjsTgA7O7UqS-Oz@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ANW0l_PeVt0hHbqjXEETVvE9EsxSJS8R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE2OSBTYWx0ZWRfXwuA009xLPdq0
 2TPHOJA8nl4aeQ4NmAaoNFCZr7Jbtcs25R8jy8OuxuEg2EsufBPrwtfHJeuKsa0UWGSgtOITpjQ
 6S/9ULv3B0oK971SL/6wPyDYoEQFOt5yDMEjJ3zRNJK137+Cf6R2xoBKeaO9YBO2dQy7d7HbbrR
 ZWIunwTSx+bA7hx8/R4U85rmpThN8gyBFtDiFrD+/POcB60K9/npzDeoG/KixvAUm7C2XJJ5dn0
 uehgzuuXsrx+wySJPbuEjzv3oOxQZe3xYU0oUJHjbfRObsX9KXbgbcvKlwbJKgHBQYEEcONUvzz
 p5xKjToGMolA4fXZOoW43fI+URa0Rn8MXNSZYAt1xlFlvdDOH/45LonVkkjBEDA5BvZU3yqO/rp
 dxMEDl7oZH1Gd9fvzN5XXhPDYnrLJH0tDfvlbTRKFtwsKDVyPdy/Yse/fNO7SGsGMbGIEH0R
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=68894674 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9XpMM9ZEX5jLuhR58p3+Fw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dnjAduxQqvqvlADX3NIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ANW0l_PeVt0hHbqjXEETVvE9EsxSJS8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290169

On 7/29/2025 9:14 PM, Stephan Gerhold wrote:
> On Tue, Jul 29, 2025 at 03:28:55PM +0200, Konrad Dybcio wrote:
>> On 7/29/25 10:23 AM, Konrad Dybcio wrote:
>>> On 7/29/25 8:34 AM, Stephan Gerhold wrote:
>>>> On Mon, Jul 28, 2025 at 11:31:10PM +0200, Konrad Dybcio wrote:
>>>>> On 7/28/25 7:10 PM, Stephan Gerhold wrote:
>>>>>> On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>
>>>>>>> A number of power rails must be powered on in order for GPU_CC to
>>>>>>> function. Ensure that's conveyed to the OS.
>>>>>>>
>>>>>>> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>>>>> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>>>>> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>>>>>>>  			clocks = <&bi_tcxo_div2>,
>>>>>>>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>>>>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
>>>>>>> +
>>>>>>> +			power-domains = <&rpmhpd RPMHPD_CX>,
>>>>>>> +					<&rpmhpd RPMHPD_MX>,
>>>>>>> +					<&rpmhpd RPMHPD_GFX>,
>>>>>>> +					<&rpmhpd RPMHPD_GMXC>;
>>>>>>> +
>>>>>>>  			#clock-cells = <1>;
>>>>>>>  			#reset-cells = <1>;
>>>>>>>  			#power-domain-cells = <1>;
>>>>>>>
>>>>>>
>>>>>> To repeat your own message from a couple of months back [1]:
>>>>>>
>>>>>>> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>>>>>>>
>>>>>>> Parts of the clock controller are backed by one of the MX rails,
>>>>>>> with some logic depending on CX/GFX, but handling of the latter is
>>>>>>> fully deferred to the GMU firmware.
>>>>>>>
>>>>>>> Konrad
>>>>>>
>>>>>> Please describe somewhere in the cover letter or the individual patches
>>>>>> how this relates to the responsibilities of the GMU. I searched for
>>>>>> "GMU" in the patch series and couldn't find any note about this.
>>>>>>
>>>>>> Also: How much is a plain "power on" votes (without a corresponding
>>>>>> "required-opps") really worth nowadays? An arbitrary low voltage level
>>>>>> on those rails won't be sufficient to make the GPU_CC actually
>>>>>> "function". Do you need "required-opps" here? In the videocc/camcc case
>>>>>> we have those.
>>>>>
>>>>> Right, I failed to capture this.
>>>>>
>>>>> The GFX rail should be powered on before unclamping the GX_GDSC (as
>>>>> per the programming guide). The clock controller HPG however doesn't
>>>>> seem to have a concept of RPMh, so it says something that amounts to
>>>>> "tell the PMIC to supply power on this rail". In Linux, since Commit
>>>>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the
>>>>> domain") we don't really need a defined level for this (perhaps it's
>>>>> more ""portable"" across potential fuse-bins if we don't hardcode the
>>>>> lowest level anyway?).
>>>>
>>>> Thanks, I forgot that we have this commit.
>>>>
>>>>>
>>>>> However after that happens, the level scaling is done by the GMU
>>>>> firmware. This holds for allOf CX/MX/GFX. I'm not super sure if
>>>>> both MX and (G)MXC need to both be captured together - downstream
>>>>> seems to describe MXC as a child of MX (in socname-regulators.dtsi),
>>>>> but I'm not really sure this is true in hardware.
>>>>>
>>>>> The GPU driver currently first enables the GX_GDSC and only then
>>>>> does it kickstart the GMU firmware. Downstream seems to do that as
>>>>> well. So on a second thought, since we've not seen any errors so
>>>>> far, it calls into question what role the GFX rail plays in the
>>>>> GX_GDSC's powering up..
>>>>>
>>>>
>>>> It might play a role, but we wouldn't know since AFAICT we don't support
>>>> enabling the GX_GDSC. Look at the beautiful gdsc_gx_do_nothing_enable()
>>>> function, it basically just defers the entire task to the GMU. The GDSC
>>>> just exists in Linux so we can turn it *off* during GMU crashes. :D
>>>
>>> OHHHHH snap! I, on the other hand, forgot we have *that* commit..
>>>
>>>> I think we should identify precisely which votes we are missing, instead
>>>> of making blanket votes for all the power rails somehow related to the
>>>> GPU. In this case this means: Which rails do we need to vote for to make
>>>> the GMU turn on? If there are no votes necessary after the GMU is on,
>>>> it's better to have none IMO.
>>>
>>> The GMU pokes at RPMh directly (see a6xx_hfi.c), so we indeed just
>>> need to make sure that it can turn on.. Which in short means the
>>> *C*X_GDSC must be able to power up, which doesn't have any special
>>> requirements. The only question that's left is basically whether
>>> MX_C must be on. I'll try testing that in practice.
>>
>> So this is apparently difficult, at least on SC8280XP, where something
>> seems to be voting on MXC and it only seems to shut down when entering
>> CXPC. I would imagine/hope this is not the case on newer platforms, but
>> I don't have a way to fully confirm this at the moment..
>>
> 
> If in doubt, I would suggest to leave everything as-is for now until
> someone actually runs into an issue caused by this (if this is even
> possible). There are plenty other actual gaps to address. ;)

Konrad,

GMU is allowed to collapse some of the rails in some cases (GX/MXC/GXMXC
etc). So there should not be any other vote for these resources on
behalf of GPU/GMU from the KMD side. You may have to vote some resources
for GPUCC block itself (I know it is in AO domain, but still). I don't
know the specifics. Can you reach out to QC clk team (Taniya/Jagadeesh
etc) for necessary details? We should be careful here. Just boot up
testing is not sufficient when it comes to clk/power.

-Akhil.

> 
> Stephan


