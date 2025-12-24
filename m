Return-Path: <linux-pm+bounces-39903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E74CDBA8C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 09:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07147300C16A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72A32A3C9;
	Wed, 24 Dec 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEIHoxST";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aziGHPHK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2B2DF128
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564458; cv=none; b=m0RY6ttqVRDu0XCd0LKe7hN6ieAu7gXy82qawIOdEFterlE6JuO5vGV7xA8u7jnb/xacfI1kGPmARrCyaUwrMh1DLjSziDjKRYhJqE9MfS1BsaztTj/B6is+c7xGaO5JqCu1jRD13Kd0yvY0vMLjKRTB9rQcGUOAXCWzw76fy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564458; c=relaxed/simple;
	bh=GSU5yGNtEOFMKebMqYnsrC3weQDSAQFw3sFP+vYsDkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVAgupD6aKq9xyM656A3UU6W5y2yG0PFkG5c0jJm03hcmyMir0RqJSvpEA4kPMZ1u57TVfYRMK1jWPdu+c4dcpvFrvIfRHCpiN2aJwtqHuQ6scdfiKXkF6IjvxLy4f1orLB7KxOfcm2Nkt3CGn/H6tGoK3QxMvnSKZyn0SejXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEIHoxST; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aziGHPHK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO6iGJX678327
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbcdHEnt0rdVycBwlDK178QvcbxGSwRY7tSrUvZuOok=; b=KEIHoxSTIwsf88V7
	5kyvHNIPj4V9AWAb38nnRpF/jFdgsQthz7d4qSaV3+59OQVOZiEAkyqggJsMwzE0
	ZIy9Al4vOCeBFuzfhGEestBZqVQPPee19eri3h8cdptrkzUXFiezhAUYESlBvyQu
	UVwFeuP6mZSOPAGyO7+heu3BVVFLnWmSxKEsE3tCv440nMtYYd02T+l2tMOFPJzF
	NJ7JqoEpxoUdjZC/oCM0cuUJtrSQANjDdRn/SbfR4xjVj6aBwKbyiqCi3yNJ1wby
	UtfzMBqqlu4Ewhmmq30hJXD2ikH3L3d1fPCmQUs+/2dM95U+q8k7bhBGSAtZDark
	6A0dDQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7yvq210p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:20:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c904a1168so12311490a91.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 00:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766564456; x=1767169256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbcdHEnt0rdVycBwlDK178QvcbxGSwRY7tSrUvZuOok=;
        b=aziGHPHKTc52YSmcJXmaM2J/mMdMW9iVirt3SW556HHvvSoQF+Xfv8CCYbIMiKxl+I
         05fS7CnU1d9RbJEXYywyr7gv1aeGVSd+v63qsn5uMcE3xI+0WUxSDIJjx8poKTTV9aRK
         7TUj5n02qhqD3pTht986Pl5gVrRA5Mosc17bsOBX7hjgMHh7389Sm3G3J3ZQ5ttTmWHL
         9bab5gFUASSYQfhqve4PKS0y/iteAnbwdfOfb18XHA0XXjKQBLJyD7m7aZzQwbltQlDi
         jZJCczlg+DtgwLF/48UIh7CwLYluLwHwQwKFJtOsFsWhpaM4d6npxjVV3TvUYe0Tva8i
         rbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766564456; x=1767169256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbcdHEnt0rdVycBwlDK178QvcbxGSwRY7tSrUvZuOok=;
        b=AKbJG92WsPc7VKu/eeGIuFHeYJ7PFyx5FmCbmc2B8yu0MBUO7UIqh7RflPw8npaa1r
         6QmG8Sca9bBn5bqu/NYv5HC2iNnwJEVgWBwhmWPiRF2jZanU9st23TbdXjSZ+Qd1ERl4
         s+l4dyTTg1zH8Dlvo5dPiNoY310J13SQYy0k6Z/NimwcbFadIifbYxxjJigOrRsY1SFf
         Xj/5p8xRvuGJLZwz3HHl4S9IbW5pJGv0Wpa2GzMa2tOKgkqNcHxpJL5jfsgi7IEyJ48Z
         ZvDjd+PB5O7mubB50bhYEJZ/vD4gcV1/0DZaff50loxxgP5iVC1qZoTkqdTaqonv23q8
         Q/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXvMbw60xqiw1l/F55PR/ehyM+pwPoWJcA5de+6vjoeRVLM0PCUdw1KXzr5yJiGvrzkTc8WGqyfDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5i69VoKymN4Zd2T6vIkkZQsvL01AQx4Hr389w+fmBoFSfEw3
	fduzm6bREH2M11YewyUhzxbNzw/mVlR7Unv82Vc5YaTTLBS87u29n6ix7O+75gVJQgfblY4bJzZ
	AQPFtIB/Y+0icwdJmAaXn1ZoOPlq2aMo0y9jo3DLvyeBhJxsttm6GWY2IBBFmHg==
X-Gm-Gg: AY/fxX4jDnpZceMYqJh5uQDT5rDknHTw/Ny2YKoI9tUQOPUjxy86sWUNdS9WdG2BveI
	k2qQLnzhocNtrEcXkNCOToi8/Oo2egdirpqUdr72ok7Tbkd3uNAYMD3NmWHJVXycU67LENFA5qU
	yZNEiEtZ8XOMcCzCsqKCalp37slczIdjmEyk1BuIdWP5+IabI78WDMwUFyPmcnooVtt36Swqos5
	cOjghUkiW5uqt6F4eilWELEpWVktRlhgkQy2RHlqy4WTkg7u9/PDOa+nCu/tUpiRunTGg16VRRx
	PUQ6Bb7BKVlEsVxbNN9Y6nfSqIfSyHszSkN8CshUG0TjW5G9lZA/pje7WtgCJl+ZOfVfTHcC43T
	Xe5gNS3L++VWLDntam7qzQD2LfZqmVbeBFHGolK3QgQ==
X-Received: by 2002:a17:90b:2749:b0:349:2154:eede with SMTP id 98e67ed59e1d1-34e9214e677mr14067922a91.14.1766564455524;
        Wed, 24 Dec 2025 00:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpNJi8TUG80yxK6/I8Wztg6e2acb+GkGygU+f56Eoxmw1V3ergpeX3o4nU5Gn7hQVrf5V46A==
X-Received: by 2002:a17:90b:2749:b0:349:2154:eede with SMTP id 98e67ed59e1d1-34e9214e677mr14067900a91.14.1766564455027;
        Wed, 24 Dec 2025 00:20:55 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7bcsm17906048a91.13.2025.12.24.00.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 00:20:54 -0800 (PST)
Message-ID: <c46a42ff-36df-43ed-b9c6-a6778ac7a791@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 13:50:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, amitk@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        daniel.lezcano@linaro.org, mani@kernel.org, casey.connolly@linaro.org,
        rafael@kernel.org, konradybcio@kernel.org, andersson@kernel.org,
        lukasz.luba@arm.com, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <176649836333.2975956.6455328748183813008.robh@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <176649836333.2975956.6455328748183813008.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tl3RFrMQsv1lSThsy59_UiaClA4s89d_
X-Authority-Analysis: v=2.4 cv=abZsXBot c=1 sm=1 tr=0 ts=694ba268 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=QcnDgq45NsFIHwn4wVcA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tl3RFrMQsv1lSThsy59_UiaClA4s89d_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA3MSBTYWx0ZWRfX/xRNAShbLXSS
 4tplr6P55VKwDpZNrS1+K/BQYG4/uyIm/CrLl3m13OnuD+h6Pmp5c/YgKXOkEBbB8Cz1VwpHwSm
 NbcHOHchxYPb9S+79KrslKEoVKXX4cumavOErIPhwk+wKerovpxX9J17MW8mZb8r2GeOnDr5imy
 PtU2p+3rXmtLEkfPnoffZVio56lvl19e+tp3WHwXsEUcW6CTF1MazpkXbUXWw7ECXwjglbmyW6j
 htr2+rX3zDCL8khwfA3A+qKmt+YcHIAZ8JjP4EVUIsrh3I3XR8o8OMAgUXZjMHQbtFDr//hFHZ5
 cEjqTLmyehSvpi1sDEbEk0iPeAsSsgC/CttH3kEtz/uZnN/ST/SHOeEtFWjw/fSidn8CWzwNB+5
 +qYfgiIX1D2lfTG8GpreXKG1rfha9DR65Pw3P8/VfkAwdnrIcD5B17XzAxYBM8pSNJuwzkV2ZHN
 3+UBnpS7WmA1ysxCHVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240071


On 12/23/2025 7:29 PM, Rob Herring (Arm) wrote:
> On Tue, 23 Dec 2025 18:02:22 +0530, Gaurav Kohli wrote:
>> The cooling subnode of a remoteproc represents a client of the Thermal
>> Mitigation Device QMI service running on it. Each subnode of the cooling
>> node represents a single control exposed by the service.
>>
>> Add maintainer name also and update this binding for cdsp substem.
>>
>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>   .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>>   2 files changed, 105 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.example.dtb: /example-0/remoteproc-cdsp1/cooling: failed to match any schema with compatible: ['qcom,qmi-cooling-cdsp1']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.


thanks for review, missed to add one cdsp1 patch in this series, will 
update in next post.



