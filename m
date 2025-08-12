Return-Path: <linux-pm+bounces-32216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B68B2223D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 11:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61C36E6603
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445A2E717B;
	Tue, 12 Aug 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oe9JsDNZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2E2E611B
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988923; cv=none; b=EdRlH9EdOvKG1L2w2WVNd6ZfQXgrUhHt4fOjR+3/LDr3hinvi0njmHIdUT1QoiUpj4aesnpgqfpMMyWq5JQgBmVUhKW7/uIAS+KWTaurNScBOEgUHYqCLSjvEiBBdM837qPGrZi9uR8XeW+RTfnQPjp3q0zDuTHy84ArumLVlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988923; c=relaxed/simple;
	bh=xSs6dS+KyRDNFjNfeFIgB59xgPp98X9tQpRjtakfgRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO16IG2GuBgBbkdUUkp/x3jlKMVXcl0kNtyygBDwR53kiBYA8kTtyF0tBugIRRA/eg6KRyDASm/mRMyTZ53BMv8WMG87FbkwHNkFg/aO+XEJ4XqX+W0fbX3hnua9+ILgzZoWRY0PzPUo26owg3MDeS1eKO+hGX+4Ln7v8sNXSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oe9JsDNZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4sLYg029604
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 08:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ebzLashfQv7DGHl2pjGLWaRMjZRcLyKDg5E66/KXdh4=; b=oe9JsDNZUHdy5vFJ
	PdStn1nMaBC7PB3A0D5Qvl+Ps/yy8wI+I+E31mAKnZccBAVI2HKidilkjMQ5JA4A
	B8ohSVBrvYXSRFCi8AZ1iRGkEsZyC9Q1cYCMZaULUbnMw+au0/xsgNBd78U02r0D
	r5yyrz3MpMVTYgff8/WmNZlREMmI/eXHYDlvD0zAudyfmawHYUZTcCPlWqP3ZlHK
	KlbT0EDWLpSO2qD8BlfDSda5AcCrVgYMKD3sbf+KhwP2rdQXCiXZM4ss8Op4/RwK
	JDDxfvg8bDZhRmEvQ/LWcvcgJsydvIAyop4RutGezTdlVAGQAEZ+1tSPCEu4zqa8
	t2mjAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqn70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 08:55:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76b6d359927so3347008b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988920; x=1755593720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebzLashfQv7DGHl2pjGLWaRMjZRcLyKDg5E66/KXdh4=;
        b=K/fk77cgGvJPPVEIMuzj/jh+IriTk5cZmmk2xEvpbaTHtmKc+p1/Bm4n/s3Jr+LoKH
         uSbhI0xTGNb66Ms3/g/sIP9bLIieXbKr8vllb+7wy3o0No70T+eZimUPA0R5hgQbWA4M
         uq97OdSMY1Ke7QPDjBEurKNd3jF0hXcX1RwAoE/kr5KOF2FSWDwTGLV8uW4qPjAzvEjn
         Hc7uzArgjNnt2Yo30EcmDvHpO9ieXmAijLQ3nDl+RIUgwbjdawCYtTsDQKVrJXeZ8Zot
         hkIw3GauZJjwj+ZKhel2i9wGCkBNgJhW7+xsWRU+Gr90EXrXOrPr/44bMZnB5g3Bg0ye
         PpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn4G4BtDhjoBsd2v+6t1pIUdRkpz+eBP88bY/rLQtGYV+Mi1JwhI4cBaQ1zUUGg7DjrU2iEXo0Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVcqnqLdZWDL8wJT1lw4y66PK+L43MJOGxNB7RBgfd7OU7UdL
	fCtTKwW489VqoxmHD0MW3jOJRsaEjJxEEN10VkGLWIWJgokHULA00bXzAVHvbLSMuUOMBwGZ4su
	J9B9j7mpXHwcY6eqjPAJM6bschGjrocpRDuSQ4oM7Hi6g3FH8hawvzAIH9UHPtg==
X-Gm-Gg: ASbGncsS/7WUUlqyAM3w5LJdRmV+E4nioS2xCTmFwH3JuWjlPq9f73N9vB02JwXY+4J
	o8/fKnbp5X5btGLSVAO2n2103os8pLShD2Yg6WgpssnR6XgH+g+sEWOSil757+7erBjFzBpiq5x
	xtd9BWekT6HVJe6yCmGG37ENjSsN8bAZCgJijNPR+/dJXT/5i+Wi3GN9/3pV6dbZInNjqYf1sew
	AnUWzXsjWud2MC1ciDm2vGXoJvZUNqe7pxoAFt1obvjwSYF8XTxdWXdv10Hu0eKx9YD1UQIF8bP
	/VC3j2SbLMpq1MWdt25d6NeG0EkDdXlqOhiTBYPD11cYwM7oYBDdgmtIjcDxaVV03nO2
X-Received: by 2002:a05:6a21:9988:b0:23d:781f:1516 with SMTP id adf61e73a8af0-240551604f0mr25082524637.22.1754988919644;
        Tue, 12 Aug 2025 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlnXmlEPEhmClJA7oU3TLCmpGyzifixg3hvVecLC6bS5LjgZJzR0qSooNP83dnLrlUeNXW9A==
X-Received: by 2002:a05:6a21:9988:b0:23d:781f:1516 with SMTP id adf61e73a8af0-240551604f0mr25082483637.22.1754988919136;
        Tue, 12 Aug 2025 01:55:19 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm19854361a12.40.2025.08.12.01.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:55:18 -0700 (PDT)
Message-ID: <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 14:25:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Bjorn Andersson <andersson@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689b0178 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Kl_B17VGIN1bcdT5aTYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: MR-5sVx5elYB3wAQmclGSQgr0w_hK5wV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX7Pqy/4BKhC85
 e94o80IqHdc6FFhrby50BcLvDpRXLLA2Q1K0UAukJSAH1WmGCF6JASIODpFlMq5B6CFXBFB25+O
 HFM/jOy+ODC2aRDDoPoNkMutboTH7iGzGdVgdsdRX7Kp3MEQoNDd8grtIg3DBIgUanh8brHMZR2
 rW2tmDKP6OIEStmmbj95tmhfWJTYpk9NqkJaPEnQ309p/73b7nwRGyBPKcRttwbRL4ZLSqVPII2
 yIdToh8pv4ZKFFeFAMW0Ur/fj3quz5Dz4kvIhES2JzZoEBxw/Gjs3WmRANlqLboev8b77/Qeu6Y
 cJlkkCxtdc7k1MQGZfXtu2CsMg//eB5mXWfF78KcY2op7dpgxqUvym2kj2fBB+MypCoebPHq3j4
 3rmr64j8
X-Proofpoint-GUID: MR-5sVx5elYB3wAQmclGSQgr0w_hK5wV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015



On 8/12/2025 9:15 AM, Bjorn Andersson wrote:
> On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
>> Add support for video, camera, display and gpu clock controller nodes
>> for QCS615 platform.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> 
>   DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> 
> 
> The missing clock-names in clock-controller@100000 predates this series.
> Sorry for merging broken patches in the past, please fix that as well.
> 

Bjorn, would you prefer that I add the clock-names property to the GCC
clock node to resolve the warning, or should I instead remove the
required: clock-names entry from the qcom,qcs615-gcc.yaml schema?

Let me know which approach aligns better with your expectations.

-- 
Thanks,
Taniya Das


