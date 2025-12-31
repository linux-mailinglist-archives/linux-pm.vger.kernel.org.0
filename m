Return-Path: <linux-pm+bounces-40102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B206ACEC3B2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F097B30011B7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886EA28313D;
	Wed, 31 Dec 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx+zSRLF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO3oUJUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A192820A9
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198065; cv=none; b=KDNfP/jhfuZrkpYCxuY4x5JLP4usNv3Ihr7U5GpnzyPiQ8em4gPNMYMa+xUVpK4Ydfofc2/PWEVbIRvjGz5dwGDfwsk4LzwCSoYSOtDfYYV2c/aiOWHD/edxOQHAn13XJ8JoGalS5/tkPY+ggmR+O5kG+5NW+s23wmUN9paVd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198065; c=relaxed/simple;
	bh=kbM7z9JEF3+IVedIrrNRCqTbuPN31Pl90mNSYZKtAHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2S7woAXJGtgqsKnDuvLv2Y279JiVNhjLNiPUQD1yuu1PNK9tjIH0ytessKVm3o7B9ZWAb7nI0qkTNvlXwIw1/Hjc5AJNWCtEgcJaIBLAY9BMxamCGU6UqRqS+/JL+U71cuyj4adZYN/X+BNYamCGqu9/khmmR+BuhXJ4bD3NYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx+zSRLF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GO3oUJUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV4oWK81429521
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=; b=fx+zSRLFZvxLc/Wk
	sxuk/y9OxkDf3w8pJdycnr3xa8KYdDRiWRYflDNTDWXm5l/t6L0d9y9lyO002xO9
	yiH5JZ3hOlYUgIjNoITvvtIjb60nSMk9lOLMc6LPaY+J23qof6JKBOX97B/PimSW
	aPRFSdKQZN1iCN7D6XAZV4C0+eV336hYi+/281EwtHp9hzl8TqlBpM8TMqVjYkNa
	bXY3nM23ZF6aSAZ76LLBdX14FiTcNzkB9AMsUFgEvZkvUGXpaeLJH7MNPe7So2ci
	3mkPQi2Pwo7rl8ipc6JY4olMcGtwnW7P5Pv3kCw2CBjTjMfLLNYaphE4sJkYTi5i
	SSepGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcw5e1576-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:21:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1aba09639so32489241cf.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767198062; x=1767802862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=;
        b=GO3oUJUnMc+ZCOywlbxCgpvyEJ+N7fRQbFYAESQPmYqX1OIlT2TeIEjX06vTD6CB6o
         tIQZPKkuX3sU+NorjePnbbSCg0U9N7HvN2aQt1YBOH7WvOSbRGEMGFB4lDz5bVb7VVnY
         PS5/CUBQfIxwuQ32OHWTzQP8ZqrvalBE2f5UYQUlTF7HL3wfROK4pNHG20wq8WBlPrO+
         i7NbLHtSI3ZXcNF/es9GcSSkPuB49Z3+1eNl6VsKmt5y1if+NkvxZ4Z0+Mj2IqbkPY2X
         aGHre7fewYSNYdKi5Qcy90fiTpjKDD6kaxq3f6Sv4a2HDoElNrrxoUYf9mWkRdad1/Q5
         WGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198062; x=1767802862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=;
        b=Mpu4AhwXYmwLyHi/lmuGZwLEuiyt3x1adLUQ/hx7KsKdYQKBoICooJdLXXsBix6YRo
         EdFjrINAV1dXnGOZh7Ro7n9wjfHnQ8OPfZDWE2NOz6mlDoN59ODGIO8VB5q3dyrYdBNJ
         Izp3+pULDTQZABdIt1kp524Di2kVIc6X7++IHZsMcAXGUhf0IeLC2cdTgW0vH6IIsVe3
         rkdHmHJLj7/ngDwJlZORY2b7Ve7IXayey7PHk/80a/HY2spOu7GVaCXXpQ24KfPE7d91
         /sUE3FSKrBoyhh/CEAYfdGcnDwvGLPDuHCVuE8hF17lD04ebruFc2UdcW+qtcZRh5wNR
         fQww==
X-Forwarded-Encrypted: i=1; AJvYcCXlseIEGZXz4MY/Xg2SAPSXl177ykciNcnVCgNbuIPckcW9YwTuoM7a5OUKhwdu6/f5BKxqT1NuvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaQBnfscOdICSNWInYy7FoPyjjmSApQq/rdp4W8VaJuUZbB6s
	oRhpWoawEqWnS+NsFKWvMJFnDDR44MbaE+Whrlf/i8b3DMsLrOEyIewo8i4oqZV4z6ilZoOUpmU
	viUPi8DpZPiO7hDZozw1i7Wfafa3sTfMeZvw7n7m5XMlBAJrVB6sbBlMoDORH7A==
X-Gm-Gg: AY/fxX4euKvy10Z8dc81f3EPMoBjf28C0A+JH3zuSs23rw7sMFg5DLsi3lME6ToxcHf
	BuLMzPL/pIfjL6wcrr8hX2c0IldasJnjqbHzpDtuVG95lTQreYjJGglKljw+I1K8lftzBzXLwKs
	Vl07CM+CnSQQgKKtKtCB5JRZmhpcjZtkih3yeo5I25Ukgw4RRKlqmqSt3hxgZ61qhPgxNstihTA
	JF98x+u2eSk5b1WYHTt0z8J2Unk7TVBSjKrd88RveX+GniyLTikzhlCTwQJ+dqjxKeqVgVxdgDj
	V3uB/K9Vl7xS5hV8ECSrUmqmOaSo4qiaRmqOvX9gqFrdkvGughcFVXzYaYFgK9poABety9sq7Ax
	joaqq/Bkt88/1zoNG6JuuzEAub7rigPMAgxV34FWhnN5721L5b8+caBo3HjAz1hF+kQ==
X-Received: by 2002:a05:622a:87:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f4abdfd1ecmr387023961cf.11.1767198062245;
        Wed, 31 Dec 2025 08:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMs7MfskDvZ0rub/w1y0ccNjJcVrFegP0hECmfEFgKIU6B08slw1DpmpECfkYr53xsN6+lWw==
X-Received: by 2002:a05:622a:87:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f4abdfd1ecmr387023611cf.11.1767198061751;
        Wed, 31 Dec 2025 08:21:01 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80464e01d9sm3907587966b.42.2025.12.31.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:21:01 -0800 (PST)
Message-ID: <00b59998-33e2-450f-bdef-db370c5d6e59@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 17:20:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
 <ab7d6780-4328-4c77-9133-402dd1c4fcaa@oss.qualcomm.com>
 <brzdqbu3uiy3gd5a2uyzcgx24wvuhjrrs3fs5b4qbnj5jvmra3@rfbiy5kgwlbn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <brzdqbu3uiy3gd5a2uyzcgx24wvuhjrrs3fs5b4qbnj5jvmra3@rfbiy5kgwlbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MyBTYWx0ZWRfXxvnCeqCo7hWM
 rM6tQR7NO3JF2Jfc5JUodIoDsBn64+THIDd/B0OmV2ulQhjOaMcGMEyjmbgM/tS4r7iLN6daDmb
 ptY8ZDtAz1gMtJ5HPMzZsLqVj5uymAqyDG6v58JzAC0oXSYzmWNuJ3AtNJ4ffynCCk2uyNtlDaw
 cZgOJ6Rn+U62fZ4YpDUTz/Sa+ErahmBQQ5tqMUHFjCmsADvLEj5Yis3s5GOd2ESGKnO0KWuH/QU
 2MjgcavnGw9xttjHM+1LLqmbOidzRi5D4G65LX13aV8eF/bQwoWFfT+o3wTlYQ2yDg3PAd4vEPB
 08pYAsIe63nhUBytEqiVI3h+62Ds9cVuHDh7YxB90FnhIdG5h1/lIhL6C429Iu0W5bj8rfTZ//Z
 Hi9exzZ4fh3h6nowvzmOXlyciUj63KMPpWrf2uQkXH3ZhK4ZVoVZFOlYZ+rpXOXZ8lc+cNV8754
 FcUTGMci5NvOmQQwMmQ==
X-Proofpoint-GUID: Fd1gcPcvMoNpHseGWVgfzCKQcidwYES2
X-Proofpoint-ORIG-GUID: Fd1gcPcvMoNpHseGWVgfzCKQcidwYES2
X-Authority-Analysis: v=2.4 cv=Mdxhep/f c=1 sm=1 tr=0 ts=69554d6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Q4P5HGrx6TCjuT4AK04A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310143

On 12/31/25 5:19 PM, Dmitry Baryshkov wrote:
> On Wed, Dec 31, 2025 at 01:09:49PM +0100, Konrad Dybcio wrote:
>> On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
>>> Specify power supply for the second chain / antenna output of the
>>> onboard WiFi chip.
>>>
>>> Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>
>> I don't have schematics nearby, but jfyi downstream doesn't do that
> 
> I checked in the schematics, it is L23A.
> 
>>
>>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> index ad283a79bcdb..5118b776a9bb 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> @@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
>>>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>  		};
>>>  
>>> +		vreg_l23a_3p3: ldo23 {
>>> +			regulator-min-microvolt = <3300000>;
>>> +			regulator-max-microvolt = <3312000>;
>>
>> Do we benefit from the 0.012V spread?
>>
>> (i.e. is there anything else on this rail?)
> 
> I must admt jere, I just copied defition of the ch0 regulator. I think,
> they should be the same.

Alright

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

