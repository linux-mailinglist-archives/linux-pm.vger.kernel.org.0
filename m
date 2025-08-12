Return-Path: <linux-pm+bounces-32211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92DB21BCF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 05:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5EC4609C8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 03:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B12DA779;
	Tue, 12 Aug 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfEjVlTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C52D3A63
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970596; cv=none; b=Nhjf9gOzrEQloMPVCEc05epFjPNfaystveJpmxNjcNY1VOOQIq0o8vCImRUzov5aFzGWMYC/kCNisX5RdQhTt1DcUz9QFhDQOyeHD5I3Q2OSKUC667Hn88bTJgmyJMBGTOTM0xhpFRC1wjk6GyQwnggNWy7v4wKKTwCvDRj/LXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970596; c=relaxed/simple;
	bh=87OsKUWhd93bhH0mOSNgVS47foXOTSCk7LBABDEo+cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEH+BKw+n6HpQGso2dWUTfmF68/S3ua4lLCQ1cpruCIauQgLbgsx8cU+1mNJ/XO+CL4BfnMqjcOffrcQiCDMK8YKJVYyco47W6ud5KPDrNFYHhrEtXXxOsUPzUAmI0gzrMJgqy1CGVpmB3/RsvSOJwC8kWs8hTRPdjnC7BelFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfEjVlTj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BH0LgI018313
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 03:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5TV846db6f3LjcIYa6Gb2G9q0zV9dsFXUpYfVhL1rCU=; b=mfEjVlTjeyFm0qHS
	zFnOX5AD3U5UGq89NvX7+yyyR38LA2xb0dTSWn/ysP4ngFic0Vm8c+Lh5tHZzAo8
	VoEHkp22Ayv1c5+t7D7v6RoUGG+TTIvJgehpN1JToIC2FOErWsNkJ7S0WKViXnnU
	eXUl2UJqqEmSOKfNiJcyJOP3gdsV4wAbptMvxk2ei60AJ9b4A0MrIrIQ89kEVhax
	92F/LjJP9eSnH55wPr52b75DAzLpNclov+8Q3JSYhD4p65Qx7+2z95HrjSfNABRd
	kLLQ2DpJ9STUu65cbphDurT0z90ULGec0IDyWf2MqaHyjTB+KOL5F4NRcpRian87
	qlJuug==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g6mds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 03:49:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b46e380a400so2481397a12.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 20:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754970593; x=1755575393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TV846db6f3LjcIYa6Gb2G9q0zV9dsFXUpYfVhL1rCU=;
        b=nzu+WQ+MG5VpkBHUfAwxbfbmSbdd5YSc8KCkTyYS9chKhqkgL4zams3BqNICQ8lpcw
         Bw6R3i1tnRYUcyxic2W1mK2KlG5dFKNpVoLZRZ+wa4mD/LE8T6kbMsnR8PbTqOeWyUiv
         mL3cuzQGIgmj5OpC7qkbOu6RwkydkNeSPr3emLocbKLFmrMNoIGR9TptrifU+wSqSE0G
         6+MGJyuunzh6reuVnA7dgWhuATk20BdS4YSDwrdI9hrJJIH0Q1yC4PEtuqc79KMu03II
         yOl39/PmidE4LHfPQVfpIN47kW4A2HEhzttdZaC68LjnyN/CdVchd0t4Emtc85aLpq/i
         SHCA==
X-Forwarded-Encrypted: i=1; AJvYcCUwRRppo0btzTGudScQg7c7BmCqKbl1jzXV3x+edRasYacB+evdvTczPS/1herxL+Z/Jg17oOp1KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCK71fRfew1FiqN3nB5/dkWxWXZyCEIYalut3KopFabRa9gEJ3
	jBcMWt+Z+kVsWfXBUhDqetPWshtSyj92ueYrWVWCr3i5BIrlv3X0dsWAnpEQkRc6B6aJLCOOMll
	fHTo325g/V+sAMZsjLShBFx0OMW6w65n0HKZxtjN4tl688csaJxSh4iNXn+eq+w==
X-Gm-Gg: ASbGncvtdNNu3I7TCiLU3OYYx3LMYjAgJCAs7eXONaGgGn/Oyl64BRd+Dy5IYvOXz7G
	iOtl7gdt/5msHnO1N/zGRnOAuQKSxT0h4K5hcvhrA0GucdwYcXZ/h4gGNCHQvxrwrErqu4MvNzg
	rGQ3Mjf2qp+cxJIHN3rRM9mWoZZVe39D2K5wqdIPuCI0pPxCLQ7JyVuplTJ1Pqadgpc3x+55GAL
	wVKINDqFnm4tjkPSkdK9Rrb9Zn9b4XylJzNdFibmmgzEvWGn0t0BoJwDi+GzV9t+2SGrrdiFc08
	gmkzzyH/BVR6nGaatNlmdXLpyaBx4sX7a/3hblP3aRJoJSFLZhnl25y4GixR+H1pyEYZbp1HFQ=
	=
X-Received: by 2002:a05:6a20:3945:b0:238:351a:6437 with SMTP id adf61e73a8af0-2409a9b57f1mr3209079637.43.1754970593602;
        Mon, 11 Aug 2025 20:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP375zTdK8Lz8GD2GdflxZl60YmZFoMKeDDEAaMpk+lohW3i3wGJFGZRlHt70eEG4IIaUe0w==
X-Received: by 2002:a05:6a20:3945:b0:238:351a:6437 with SMTP id adf61e73a8af0-2409a9b57f1mr3209046637.43.1754970593156;
        Mon, 11 Aug 2025 20:49:53 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce56sm28275963b3a.82.2025.08.11.20.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 20:49:52 -0700 (PDT)
Message-ID: <f21f6fd0-9d58-4eee-9676-e6e9543cf7f6@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 09:19:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add wake GPIO
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, sherry.sun@nxp.com, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
 <20250801-wake_irq_support-v4-1-6b6639013a1a@oss.qualcomm.com>
 <u4zedngig2jsraq27h2gc5ksp5swgypl2k3sy44znrhndtljpp@r4jb3wibkf3q>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <u4zedngig2jsraq27h2gc5ksp5swgypl2k3sy44znrhndtljpp@r4jb3wibkf3q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689ab9e2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Ztk8bZVGPGJlfjIOV0sA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX7XFraVuvXFMQ
 4foIAI8JkAeK1j5Z2n4IkgFBhRB2ou7pCjd3e8ciGj0EpClng8R2eCW2Tr/3nthNskv7j8z+rMf
 mBxyUg13PXhdHfdCkYnOjkI7VZSe9mMxu1ywRhCLyVmuLaYioiOtEvqrhQ4v+uST1ZDXyoUAILz
 TbGdzIbz6z8rc0Ikg2HiqWMVv38T0qODdjXoJUjtwsujvZfvSKnj0Q3ByI3s57hsgTVHUyXdEek
 s0/tj1Js4ZPHvsRtrozD0XRgvXuwGPvLLay8FNMW/57azxbZzYo/B2s3Y9KZtQT4au9RG60So2j
 GktHNP3rKwdMNyhR/Jh0OMp3rwsXTRmhX53+D3sy08cU1q+MrTihrRZo7EiHFFJhC897F3bvjKn
 I9RXc3Fa
X-Proofpoint-GUID: K2_oVIysdoTxzNZGJjSohrDIBLMjnVS1
X-Proofpoint-ORIG-GUID: K2_oVIysdoTxzNZGJjSohrDIBLMjnVS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031



On 8/11/2025 10:06 PM, Bjorn Andersson wrote:
> On Fri, Aug 01, 2025 at 04:29:42PM +0530, Krishna Chaitanya Chundru wrote:
>> Add WAKE# gpio which is needed to bring PCIe device state
>> from D3cold to D0.
>>
> 
> What tree did you base this on? None of these boards has pcieport1
> defined in the upstream kernel.
> 
Sorry I forgot to add dependencies to dependencies to one more series.
I will add the dependencies in the next series.

- Krishna Chaitanya.
> Regards,
> Bjorn
> 
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 1 +
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 10c152ac03c874df5f1dc386d9079d3db1c55362..a4d85772f86955ad061433b138581fa9d81110a4 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -810,6 +810,7 @@ &mdss_edp_phy {
>>   
>>   &pcieport1 {
>>   	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>>   };
>>   
>>   &pcie1 {
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index 60b3cf50ea1d61dd5e8b573b5f1c6faa1c291eee..5e73060771329cade097bf1a71056a456a7937d7 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> @@ -477,6 +477,7 @@ &pcie1 {
>>   
>>   &pcieport1 {
>>   	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>>   };
>>   
>>   &pm8350c_pwm {
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 0b0212b670797a364d7f0e7a458fc73245fff8db..240513774612fb2bfcdb951e5a5a77c49f49eb82 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -418,6 +418,7 @@ &lpass_va_macro {
>>   
>>   &pcieport1 {
>>   	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>>   };
>>   
>>   &pcie1 {
>>
>> -- 
>> 2.34.1
>>

