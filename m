Return-Path: <linux-pm+bounces-33894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42144B44B12
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A7B7A3481
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D57B1DE8AF;
	Fri,  5 Sep 2025 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxnPFCXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70B1D6187
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034244; cv=none; b=OQ3Sscut8VYWkVgQxmvQ0sfhzFAL3F4HsrGrUHMEdv4D5GpDJlo7WtGjex9YqB4KksZUaUHKL31KJkNMfi+948OBQYXLqIHLz1TuVrHNSF40hcN8eabistAYAL6hbRffWysScXDAVdZwlLzMQ4nA92MTO+wLNLjE6a4AT9TQ6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034244; c=relaxed/simple;
	bh=E60oZCvVY2XQC5MKAz3hSZqG5cJY22Czhkp4QdVVK0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvGCMU/lgMJBDub9edhIbZZoO4N6DbzhjM01/4vVOUdwv/fnpRXh+NLQg9JVIDu2Hb3FF5T9VFaBKv0ecq8t4Bn1kFp19zDPj+GCsuUau9dEXoK4O0t5Puwwf8RQiOJA+lZJjulupdzHQf/I33NbJ1bSyThcDCJlCb3yK9yg23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lxnPFCXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IQqpj012122
	for <linux-pm@vger.kernel.org>; Fri, 5 Sep 2025 01:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9x/ZnBgm4svQLivjO5lFYu5fqyWw8hoi1jnTAaS2pOs=; b=lxnPFCXFMyLZb9AV
	X7ffLjgtvcqL2/6lLBrlZcUNg+kauiZcZo42GKmwsofn19Ry5flHl2HMRIR6P11H
	5r2PYbyEFe+WoS3bL5DpivX/ej1D/yLd4jWblkAuKqHQRxVBU+PN0ZerITKwbPq3
	Jzwg5izzv+6/NUywDnTNx3UI3iEr6VY18T/yFEqTYhRD9e0hu2GCbZ+v/rJDJ9ri
	mXyamNeHb+IPEuC7DKyobtiPNptI/RN2jS1CmPcVr6xPs7Uhn0xuQSwlt3ETZ1OG
	8DcXjD+TW9607Z75ANPR4g6GNs8Whx58d12fG4nnI1eRYXZu0gwSc1V8CUAeLXJ6
	B0yxvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj5r8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 01:04:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24cda4063easo12783045ad.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 18:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757034240; x=1757639040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x/ZnBgm4svQLivjO5lFYu5fqyWw8hoi1jnTAaS2pOs=;
        b=O4g3VzFFgRC+aR05v5FkFUanfworTNTjn3+kavc1SlMZWXpLBFbWdQRDzsl7Khw9DC
         XMUurwyEgx3av1mAnT904z/UrZhFJ8QAhb5U1bXMMa/uA9mgPFPRy6tMXrDH600PpoHM
         QmTdj0k9SZgyXcl385Vjg2zXw9R6JqbLD9ljdCZgCzpXLtmM7UjbjQs5vSbvfMoGU/nr
         sHzj23mInEq+Xeoq0ux2R09YJkamCmjv9EquDLn7X/B4yPvOGVQzoHhsnwvZAk5+XWF7
         dMfKsTtZCK3nwd9q6aR8QZ1ITfNzMrMTsvMrtXZEI84gJeRoNWp8dvucDDGQsLV2wtQy
         tRfA==
X-Forwarded-Encrypted: i=1; AJvYcCWwY6dx+heYDNeyfQcGBPkhS6rZOcyTCnm2NJb0wOc3P4WFUoZTj3l6Xrgc7vJqIizOQ/WSe8S91A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPY2ZfCG8vEFQvVl7q7iS97os7M2BAJ9iWYaitg55zSP+DB7fa
	e2MHwk3N5RTgaT2vZGwNGcfK4KqB5NiFAioYHgQEHtbASBtc4VxU/UV1gsqRadEt6mPCRzjfCMQ
	ZD9Ia1Enwu/Pum8F47tlcbT0bYhskpax80nqbGvL0lnXqKA+pIWmMNXfz/ZseUw==
X-Gm-Gg: ASbGncvVnoLaQPkQV6JGsURDZgLcBF6qZof2omDKUtTMm/dEHN01IfR8PczjeRexWUW
	3X/1QcUg+IMNb62CBjAIOuKOvEWWStZ9vshn9tpn5bSO4rT+e5UjHT14aMnawsKp7yprx+En8cZ
	pg0sSCWkEuLV0pGOkfQiGtbfAyKzYxOp3rE+oB+FwyzAmnG0q+f/N4MDuqVtX3mhPTNJ9bduV+F
	EdrRLU33111Ju3C3Yd3zkXXmv9/8d8cXwwU+2xalKmaekD5SflIVrx++PXL9D1LYGAfV4OpB1N8
	+NfnkDeS4IBilwtMQvOJI4rCwRnpZilEloic3N9Nqh7cuOfBxqZKwtJ9MrdSsStKKIztIpEjAxg
	w+RKes+d1dKTVvrGldt5sgCFLYqwSrbUs
X-Received: by 2002:a17:903:1a0e:b0:248:c96e:f46 with SMTP id d9443c01a7336-24944b81c37mr262422535ad.60.1757034239990;
        Thu, 04 Sep 2025 18:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7PL5Q1tEpk5K+qxnrlMkRx3Zfh4Hi5/r47t4WUi+YB3Zb3IhsOhnnrsNU7IDSjiEHTamUJQ==
X-Received: by 2002:a17:903:1a0e:b0:248:c96e:f46 with SMTP id d9443c01a7336-24944b81c37mr262422075ad.60.1757034239485;
        Thu, 04 Sep 2025 18:03:59 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d925sm58656885ad.36.2025.09.04.18.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 18:03:58 -0700 (PDT)
Message-ID: <af7cf6cc-d558-435e-b406-374ef92914a2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 09:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
To: Maud Spierings <maud_spierings@hotmail.com>,
        devnull+fenglin.wu.oss.qualcomm.com@kernel.org
Cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org,
        david.collins@oss.qualcomm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, kernel@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, me@kuruczgy.com, robh@kernel.org,
        sre@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com
References: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
 <AM7P189MB100958EDD985483DB1F32EC5E301A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <AM7P189MB100958EDD985483DB1F32EC5E301A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX3XMDCXodNK1d
 yvDb8Dt7cPXk9uy9WmQOiFqJ56zhKlJbLOYUE0Op9qVDpO2bc+UKjRDjTyBj1Lpd6oDl522+Fgy
 nRel2TL0loQzNfvoX8jsuDRoVhR57sd6aWBbOuCY+g21OQA0m5PCwhT+HUByR2V/4+y6MFCgx+t
 GuGJCvzGl/WSpYxGSFbDjVPor0CM97klyftQ/P7xabAxaeENBJYHDiykQG7yGSnQdiVX59x65Zy
 3u0dvUpKOsAQfbjZLlwBKc/80Oi4of/eeAUgrEr6NJSdKy6V8ceq8babbcuUj3ayIHlXAdpgpC5
 NrD6y10sbGRQK86uRZuZXh66BOTiu/2cQThSZkrNYHHh/IINHyhqcRbe1q9yRwpsBHEArdAeMxQ
 Ruv7vPXJ
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68ba3701 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=065pQyBIx5i4jwDuaBsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: _07_RG6XUXr0dmSzWHpB7qndhqDgiuZ_
X-Proofpoint-ORIG-GUID: _07_RG6XUXr0dmSzWHpB7qndhqDgiuZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117


On 9/3/2025 4:41 PM, Maud Spierings wrote:
> Hi Fenglin,
>
>> Add nvmem cells for getting charge control thresholds if they have
>> been set previously.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  2 ++
>>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> index 
>> c9f0d505267081af66b0973fe6c1e33832a2c86b..8c3d30dd936ef9b12867971f5f237dd12484072d 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> @@ -82,6 +82,8 @@ pmic-glink {
>>                      <&tlmm 123 GPIO_ACTIVE_HIGH>,
>>                      <&tlmm 125 GPIO_ACTIVE_HIGH>;
>>
>> +        nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, 
>> <&charge_limit_delta>;
>> +        nvmem-cell-names = "charge_limit_en", "charge_limit_end", 
>> "charge_limit_delta";
>>          /* Left-side rear port */
>>          connector@0 {
>>              compatible = "usb-c-connector";
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> index 
>> c02fd4d15c9649c222caaafa5ed2c777a10fb4f5..abf7afe5127d7b8b572513234e00009ce837837d 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> @@ -239,6 +239,26 @@ reboot_reason: reboot-reason@48 {
>>              };
>>          };
>>
>> +        pmk8550_sdam_15: nvram@7e00 {
>> +            compatible = "qcom,spmi-sdam";
>> +            reg = <0x7e00>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges = <0 0x7e00 0x100>;
>> +
>> +            charge_limit_en: charge-limit-en@73 {
>> +                reg = <0x73 0x1>;
>> +            };
>> +
>> +            charge_limit_end: charge-limit-end@75 {
>> +                reg = <0x75 0x1>;
>> +            };
>> +
>> +            charge_limit_delta: charge-limit-delta@75 {
>
> I think this is supposed to be @76 given the reg property below and 
> the other ones above.

Thanks for catching it. I will address it in next patch.


>
>> +                reg = <0x76 0x1>;
>> +            };
>> +        };
>> +
>>          pmk8550_gpios: gpio@8800 {
>>              compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
>>              reg = <0xb800>;
>>
>> -- 
>> 2.34.1
>
> Kind regards,
> Maud

