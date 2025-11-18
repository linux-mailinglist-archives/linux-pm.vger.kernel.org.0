Return-Path: <linux-pm+bounces-38183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21BC6A73A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6366B35918C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E336828F;
	Tue, 18 Nov 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIl6Xlvp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hhnh7/8s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5D364EA5
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481145; cv=none; b=DQRxKLQ+9q1Jo3s1A/Vwa9MKsm40Rq4nzdm0/5MSOEaXW2d+IdgS2qbWR6FzXrL/c2S7wY3Qw6cOgt8ZChSPRAkomD+SK+LlG5wbox5Aqb9UJzdNYRjBGTDzQ3YokzH7AN7uvCsWs9zEle8wR2+RYPk0nI3PzXDwOJd+a/1/lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481145; c=relaxed/simple;
	bh=jhgoynWmXQ8FJxBSbELVEzmFu/j5b89WjfcSj45l5ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVpgiifZVy/taUYQnXXfk0MVgo74JAWyr10qF9dlJ/ubdljbvCexjl1iKVtBUHK+ETLRzZWhcV7ppBbH2QvUyYm3xP1s2DHP1PAjc2JM1fYEnowDIsYh7vwPaY156/PEBiW411JWv0X4Ud8sAY6wOcemQiHwMyP61Sz+l3CPixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIl6Xlvp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hhnh7/8s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8DqtR2193978
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+S9cwiuDUdnvDTifJJIrHZ0IIJPViyg6GXb2Zlu8Qgc=; b=PIl6XlvpX8k7CiWX
	ufDitI/zorj6h2bJyzGctXcE0sdE9rik0AB6P5O5kHJGSV+XX5nHaCOXJMynyVFA
	ct0cWbwXT1zeH0ouaC9CLESsuv5tyAPf3B7hapEpUr0wXzdwmQCbhETbw/iART21
	WrteSZOFoSycw5M93+GSbpXfj3BUp6Mpq4cpx7Sof1we3tDyOntf8ztvLCy+3SIb
	50LCt2+EAWXE8CmBTki1B3Qj7W37qQTfLHjuqqh2Xq7YS3TuDBWiLwsPXbMx7otK
	q+Q5lf5JF6xfRW7oINBJlF+ZPUyDIb0z+7ubVAPpP+6EnXlsBjHonOmn/B4b3IbF
	22idlQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agn3y99m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:52:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297dfae179bso139990065ad.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763481143; x=1764085943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S9cwiuDUdnvDTifJJIrHZ0IIJPViyg6GXb2Zlu8Qgc=;
        b=Hhnh7/8sNnOd0q1iAf/fZvxxyN9hSzXh6DlNMzGcm1Nhl+FIxxznH5NCBYJG0xpik2
         LpOcBxqs+9zH1pRalJ5mPPla/sX+XlyhC5wmrKm64xJeiyccwCOHag6scnPkznl6FeGu
         zqt8UdT1SJ2v3yOy29Vpk1mEFALZ9d32nYWdiFliQG2EhvR0/yQ9USaXK3XEVbKbtmXz
         9t6FPBaNZWLomftAqaK2JvPmHIH0ZbHaduJgwy9vjbzHdWV/8c4FJSxXhJZ44955K/aJ
         lm8Kfy9D3+v5UJ256zv3moZ7DckXO1rNR7mG+2AnnfYcr6wRKU8baMAQQt7gmPdCBIIa
         3Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481143; x=1764085943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S9cwiuDUdnvDTifJJIrHZ0IIJPViyg6GXb2Zlu8Qgc=;
        b=orz0grsb1ku0Qxos5n7KesgEdvH4+t0cjtgP3PuQ4QfW6HDVJp1F5qToX475gHKMzH
         OZjh76+zlAgKkx1IPySP4pUyudxp2kScXZ1rdiXUOguyCC1vB6LAHwz0M8tOrubgXKcv
         PLtsIheOANg99PBSKeDhLFfCP/ZJGKJbS//AlktGPRrTwJ/YbLTleihYTq7NbOmWev9a
         NaNWKNzXrrukkLUYBqDrK5i0QX7jQRbCEMtfsHyonLHekE8Wb6nJYYhqnIWg9s+tv7vc
         29/OgW40IbeOwYO2471Xn4UCFzHjhFmxITlgjqWyzzG5548J7V4g6TQHkLPsa6PUNi+a
         RqvA==
X-Forwarded-Encrypted: i=1; AJvYcCWoY6pnspBGYrgLYjyB+05hhXWUEPZ5050CWfAnXuRW6oPzEreJuNy8KxriXVLsXRDhLEOrRV4qOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QqAoLssHVV8Fbi4xdzrITt8i7CIkN/LpjExx+pxM/uKkviqA
	3D89XYsNmIPKwHFgV66NapsXnWY2ldSju7B0nzhcgtUpHqxPAYaTGH1M9FyPdC0c05UTODT7CZ0
	IqkskS7Fn/J4f4sMxB3KclQvUanrTE6pJA+3T+jwJtP+bUZgov5rRX7lPzBfuQoMKamSkng==
X-Gm-Gg: ASbGncu/S3fbM54V+NWu5m241z3RxzW2FX3T2sdYtYEni5p84XmYkMrnboBC3+55zEe
	hed0dN6q+lJlHuKWYX7Rt3R9TspjZkSr4mMOGRg8UYNG/WGOjaq8UwHzaH3wBfRNq6V6eHqLpC8
	0SaAWDxPY7tomCZ4izoy7iWKXIMMzsmRPMGiPTBODUJXZacU2kEuG70JisYpuzrMJhYa3b28XFP
	HQTyZPTe0bh46XFi5NoM1bUVVr0vthSPsqL8TPz1stYC5u/XhE5GlxXxFWf6DKm6ldCMoNb0+2Q
	U+jeAoDm7FM/65tGwsdXll5VuOR8L7ftc5pZuXGMmjs3s66Zdzjxe8Ls6rvDqGBGSBN+DdSzzhy
	6qN0sp5c8GZUiN5V6sCyqNfZf+nofQa9tNw==
X-Received: by 2002:a17:903:3203:b0:299:e215:f60d with SMTP id d9443c01a7336-299e215f8b0mr106502275ad.30.1763481142610;
        Tue, 18 Nov 2025 07:52:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHseDNXc7m7GA6025pahIuRuNrB4a5ZnzV3Byi0LKvV1p1mIn8Z+DlT2DDFMPM68tlY+b1YA==
X-Received: by 2002:a17:903:3203:b0:299:e215:f60d with SMTP id d9443c01a7336-299e215f8b0mr106501865ad.30.1763481142057;
        Tue, 18 Nov 2025 07:52:22 -0800 (PST)
Received: from [192.168.29.63] ([49.43.224.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245007sm180008915ad.31.2025.11.18.07.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 07:52:21 -0800 (PST)
Message-ID: <621fbd17-99c6-4669-9d7f-4c1c42270dcd@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 21:22:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, vireshk@kernel.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
 <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
 <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>
 <kaxxdh2xt4hghwn23qzle5wx2ltdzq7eyp7rtyvbsgffjvowv6@hgphk72idpbz>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <kaxxdh2xt4hghwn23qzle5wx2ltdzq7eyp7rtyvbsgffjvowv6@hgphk72idpbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEyOCBTYWx0ZWRfX5sQM1OtwPTUc
 35dqwNrkHx/46nN3AAyH4fO3a48ShcMzzKXIVGPmZwVzHQ5i8g3S97CnbXbDSAGasJReWgnU7ra
 vk1fsTBN8oLPTbV0nlKTGdgO4j6PqDgsz4wm9dlmSw5MWNRMLxH0bWthoPIS570zOw/jPrk+HTk
 1FxDTIkZ6nAAPcyx2Eie/rZ+oE4GZ3N0znluAX/qreNf3CS6WoeIZkAAZ6PO86S/CIf5W+ybiIl
 i+yrUg7ZT/9keJHWr51drrts5CIiA8g9yCELPtVVSS8APKrWnzpDvMG0t0vaR1wtSCoIWMYZpeR
 bsfmnNjFs+jtLckUfWstbZPardRxw3WiDoDnOMAwhU4y1S2ic/XmqmtNXww6K4layAZ8+kThqqE
 99M2RzSHMFK7hLaqn3UTCKhCliz02A==
X-Proofpoint-GUID: _-Wk-_pVNjzFaStnzZk37AC2Rywc_GmL
X-Proofpoint-ORIG-GUID: _-Wk-_pVNjzFaStnzZk37AC2Rywc_GmL
X-Authority-Analysis: v=2.4 cv=FtIIPmrq c=1 sm=1 tr=0 ts=691c9637 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=3MraTTL+RAxS6hpN32Mmlg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5bj78bA5aqO2U0s1xTIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180128



On 11/11/2025 2:03 PM, Viresh Kumar wrote:
> On 10-11-25, 17:37, Krishna Chaitanya Chundru wrote:
>> Something like this.
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 33574ad706b9..833057f55328 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -2050,21 +2050,21 @@ pcie0_opp_table: opp-table {
>>                                  /* GEN 1 x1 */
>>                                  opp-2500000 {
>>                                          opp-hz = /bits/ 64 <2500000>;
>> -                                       required-opps =
>> <&rpmhpd_opp_low_svs>;
>> +                                       required-opps =
>> <&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
>>                                          opp-peak-kBps = <250000 1>;
>>                                  };
>>
>>                                  /* GEN 2 x1 */
>>                                  opp-5000000 {
>>                                          opp-hz = /bits/ 64 <5000000>;
>> -                                       required-opps =
>> <&rpmhpd_opp_low_svs>;
>> +                                       required-opps =
>> <&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
>>                                          opp-peak-kBps = <500000 1>;
>>                                  };
>>
>>                                  /* GEN 3 x1 */
>>                                  opp-8000000 {
>>                                          opp-hz = /bits/ 64 <8000000>;
>> -                                       required-opps = <&rpmhpd_opp_nom>;
>> +                                       required-opps = <&rpmhpd_opp_nom>,
>> <&pcie0_opp_rchng_clk_100_mhz>;
>>                                          opp-peak-kBps = <984500 1>;
>>                                  };
>>                          };
>> @@ -2106,7 +2106,30 @@ pcie0_phy: phy@1c06000 {
>>                          assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
>>                          assigned-clock-rates = <100000000>;
>>
>> +                       operating-points-v2 = <&pcie0_phy_opp_table>;
>> +
>>                          status = "disabled";
>> +
>> +                       pcie0_phy_opp_table: opp-table {
>> +                               compatible = "operating-points-v2";
>> +
>> +                               pcie0_opp_rchng_clk_20_mhz: opp1 {
>> +                                       opp-hz = /bits/ 64 <0>,
>> +                                                /bits/ 64 <0>,
>> +                                                /bits/ 64 <0>,
>> +                                                /bits/ 64 <20000000>,
>> +                                                /bits/ 64 <0>;
>> +                               };
>> +
>> +                               pcie0_opp_rchng_clk_100_mhz: opp2 {
>> +                                       opp-hz = /bits/ 64 <0>,
>> +                                                /bits/ 64 <0>,
>> +                                                /bits/ 64 <0>,
>> +                                                /bits/ 64 <100000000>,
>> +                                                /bits/ 64 <0>;
>> +                               };
>> +                       };
>> +
>                   };
>> At least for our use case, wee don't want to set it in the phy driver, we
>> want the controller
>> driver only to drive this.
> Since you already have the phy node added as a clk in the controller node, can't
> you add another opp-hz entry there and make this work ?
Hi Viresh,

Are you suggesting to retrieve the required clock from the phy node and 
vote from the controller
driver? If that is case it will not generic as some targets have 
different name for refgen clock in
phy node. And this will be like a hack to do it from controller driver.

If this is not the one you suggested can you give me some more details 
on to change the frequency.

- Krishna Chaitanya.
>


