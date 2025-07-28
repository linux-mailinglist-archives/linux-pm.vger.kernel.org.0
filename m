Return-Path: <linux-pm+bounces-31524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0435B143DF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 23:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84CA17502C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320B235055;
	Mon, 28 Jul 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXs2qKgH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1941F1537
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738280; cv=none; b=psmdggaucZpy886tqz3dAL0dlljuKy/3XCkX8wSV9GvRopjxSKaLYkQHdiflb+pnOcIrXFsXI/XVmCm3/O9JDTnOHkMsNYtkco/Kr1oK3DwFozfQbs5uK8k4z6BdvjxuHuAg3xJemJQpVhziYMGm91ujbKtDkn3Mm1LPqRXqRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738280; c=relaxed/simple;
	bh=xOpGSwD+i3k4RvsiTCXNKOCRdZ4nxyhgb6f9qWDfH6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFyMx38a+/hwxmFS0rRIQXlmrRPSZ5wdkxoVpBICajmZyNDDmm/Ioo/2ASpet+rShR06aQmr/j+aZz9wcGQOXsUSxt1E87imdMiMaL0Xyu9UaBX24ls1YAMEjCetRrP+T8FKBXcH2VzAKy8x5iu/UEuf1PuensZoDtPMNCYuJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXs2qKgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLOkIn031280
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 21:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQzEir7iRMo8Nll1ylqLs9Ikgmf6SuRckbH505+LxRU=; b=KXs2qKgHxKrmw8ge
	Q3tHP5EFqL8B3eauTeWPiQLecxuWuigdn5mxjtHAZJ3jhLrNYdt/13EDEIXEzca9
	bkIaopwTnsUpqhYazUPZuqedoPRtgl9CUqxSjsuRb1Ncgu6ztS+SzYg2ZIrDZbmS
	2HuUZE1NdG15tuv8hi+0DUMt7SL3ENWYeoSTZZ9GyKrMITXat9W+9tahQs/mS9hw
	MhFoF+k0gIxv8nHIL1ADiJsdWxWnbuyk0DuMwNKbShlIXBsoxmOC0Sv8fKasqccd
	d72XBXrAZJnCNM6LOBbgnvs/2Ili01uykCK8aCsp/6U8oGxXmXSGAnoArhO3hbTG
	Rev3ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xba2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 21:31:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33e133f42so101564685a.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 14:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738276; x=1754343076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQzEir7iRMo8Nll1ylqLs9Ikgmf6SuRckbH505+LxRU=;
        b=Mx0A/InSX419SToiatU1Wd6m2GwJsIpYcKoWDMf74xRmMK/GAdRcaIZTR7T3X13iXi
         YAa39Hgboz1aclWHFDnCBFMDPibKHn7C3K4iWOn/SilKP/wkyp22IPeqjV2MhtjE39ww
         hduTsjAjkMH2S+HQgT0GCr+OlknsE8J5GOybY74SsaW3T9xBFPYN8XSA/hv2LtY3UHC7
         z1vzp/YL73fEQuNtZOPGe/bFRg4Qu57ymqnM2/G0JLAse2nnYBF6U8IMGWO9qTiViIlc
         F80ARZjRS39MzaME38l3KZKA0o8q25XS3hgMmHuJTF/Hs6c/gLLaLCKIQsVYCskAsZlQ
         mzQg==
X-Forwarded-Encrypted: i=1; AJvYcCUH/SFBjycQk93xhu5yHUSg0hHO3sVybbrTBzkpVqjCXrJWUIzsSNbZDuwOsh6U3mVMJYz2t3upMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+KES87LSZJnzHMbZPoKeiigON8A5aMfpe3/+XXnBoY1abtB4
	Qc/R+uLu5CWTyP6GGsJP6bmk+eybP3ggFO7gTmZCUbyS6mQkaynVb/CHFy6d53TPyHs9cGLJums
	8wFufxCLWaSPuym9Mvap9f1BPCBFwbe00+iTpiwanQvfjwmdFWVFz8djQs3oP3w==
X-Gm-Gg: ASbGncsYjuESpJqmQvLS9jROQRXnyd/DP/kgPXHgPge5oJOTSXoi34UIxqaDfddKnsv
	ceA3dvEE2iQ62SYCeXmL5G/ci7eLWNrjuwlO5K5qY1FkcB3MZrueStoZsZQIY6got809UIaoVBs
	QLoKAqZj5kbikfXk9Jl4RNTpAEtj1Hc/2kRLprMDvQDKEz6xJ+x0HYNqy82RG2Sm/N830WWjtFU
	2v6cuHmERALwzGNpYXgcXBm+9vnjRJ3yPa8AA0icCwUTxrwnJ9aCGMSvH/j0741cVitglqQhRyQ
	o1udMRneO0NWMwzB4XYMfpPN/alBjjAyNtE0n1vRrU2StMFQRF/4tQY+RAaxZr5mcBmfRN6mRdy
	JvLFpMxUhqxxNu5dnfw==
X-Received: by 2002:a05:620a:2586:b0:7e3:3029:44c with SMTP id af79cd13be357-7e63bf6fa83mr809617985a.7.1753738276326;
        Mon, 28 Jul 2025 14:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+4JUeHIe/vdgr99ACJt7Fa75bNvYRVKL98OaFFoBsSdhAU1ioagzUl9HgqrphdrjT4yMMgw==
X-Received: by 2002:a05:620a:2586:b0:7e3:3029:44c with SMTP id af79cd13be357-7e63bf6fa83mr809614785a.7.1753738275560;
        Mon, 28 Jul 2025 14:31:15 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62b14sm472695066b.77.2025.07.28.14.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 14:31:14 -0700 (PDT)
Message-ID: <50868cd8-68a9-4bad-99f3-8cf542886fb6@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 23:31:10 +0200
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
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
        Andy Gross
 <andy.gross@linaro.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
 <aIevIuMDA5R8igmi@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aIevIuMDA5R8igmi@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1NiBTYWx0ZWRfXwUp4HrRTA86a
 q0WOvZFNoXFUt6ycl7Jw7F9462nbwBXWh/msFV/yOq1eLUWQKuCQXMECal66ESuSWw0SFSZrO43
 jdxkxeYx4AUaP+pQMwgdsxxkOqqdibKRn0neGRKxtqZlT3GuPtAU95Jpf4OHUbaczK107cqcWay
 y0CB33Rr9q6SVt28Xd6JDSF79/mu8b5/30QPCG1BGVnL7k63RFuUT46gfpADCq0dNfDJFeWG0RT
 Kra39AC9oOh/D2VLw7wCV5JJpo1+PvgGK+s90Sn3m2FhgOYGNHMcmEKn2hu0okhuVwKFW1E29kQ
 9yHps8J3GQKtA5JaHCQgufx+uE8HnDXSMQxY57Wj8tN8rfFuDGQvXl3i/mOixcpTKxoywOvfxzj
 E0zlbdk99BBqnJL+S1eFhFgpFLa+ds7rqSFpm3Ssh8wJu6XYfzofkQ/TVcp33nMEpoBM2+BL
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6887ec25 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ep2Uw0KgDCB9V8QWne8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: q4fkH5OfgAQpvBloSbiWp1Ip7VSKjDvL
X-Proofpoint-GUID: q4fkH5OfgAQpvBloSbiWp1Ip7VSKjDvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280156

On 7/28/25 7:10 PM, Stephan Gerhold wrote:
> On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> A number of power rails must be powered on in order for GPU_CC to
>> function. Ensure that's conveyed to the OS.
>>
>> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>>  			clocks = <&bi_tcxo_div2>,
>>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
>> +
>> +			power-domains = <&rpmhpd RPMHPD_CX>,
>> +					<&rpmhpd RPMHPD_MX>,
>> +					<&rpmhpd RPMHPD_GFX>,
>> +					<&rpmhpd RPMHPD_GMXC>;
>> +
>>  			#clock-cells = <1>;
>>  			#reset-cells = <1>;
>>  			#power-domain-cells = <1>;
>>
> 
> To repeat your own message from a couple of months back [1]:
> 
>> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>>
>> Parts of the clock controller are backed by one of the MX rails,
>> with some logic depending on CX/GFX, but handling of the latter is
>> fully deferred to the GMU firmware.
>>
>> Konrad
> 
> Please describe somewhere in the cover letter or the individual patches
> how this relates to the responsibilities of the GMU. I searched for
> "GMU" in the patch series and couldn't find any note about this.
> 
> Also: How much is a plain "power on" votes (without a corresponding
> "required-opps") really worth nowadays? An arbitrary low voltage level
> on those rails won't be sufficient to make the GPU_CC actually
> "function". Do you need "required-opps" here? In the videocc/camcc case
> we have those.

Right, I failed to capture this.

The GFX rail should be powered on before unclamping the GX_GDSC (as
per the programming guide). The clock controller HPG however doesn't
seem to have a concept of RPMh, so it says something that amounts to
"tell the PMIC to supply power on this rail". In Linux, since Commit
e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the
domain") we don't really need a defined level for this (perhaps it's
more ""portable"" across potential fuse-bins if we don't hardcode the
lowest level anyway?).

However after that happens, the level scaling is done by the GMU
firmware. This holds for allOf CX/MX/GFX. I'm not super sure if
both MX and (G)MXC need to both be captured together - downstream
seems to describe MXC as a child of MX (in socname-regulators.dtsi),
but I'm not really sure this is true in hardware.

The GPU driver currently first enables the GX_GDSC and only then
does it kickstart the GMU firmware. Downstream seems to do that as
well. So on a second thought, since we've not seen any errors so
far, it calls into question what role the GFX rail plays in the
GX_GDSC's powering up..

Furthermore, this assumes that the OS is aware when the GPU is in
use, meaning VDD_GFX would be on when GPU(_CC) would be resumed, but
with IFPC or hwsched, we have 2 corner cases:

1) GPU is on but the OS doesn't know that
   (which is fine because by the time the GPU is on, the GMU has
   taken over)

2) GPU wants to be off, but the OS holds an RPMh vote

I *think* 2 shouldn't be an issue either, as downstream does
precisely this, and if it turns out to be a problem down the line,
it'd still be something to sort out on the C side.

LMK your thoughts

Konrad

