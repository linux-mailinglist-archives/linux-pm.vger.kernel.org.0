Return-Path: <linux-pm+bounces-41754-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAcxJCFZfGkYMAIAu9opvQ
	(envelope-from <linux-pm+bounces-41754-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:09:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0280B7C9B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88AA43006034
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1387306B3E;
	Fri, 30 Jan 2026 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObBNJUCP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTSudk6k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DF32AABF
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756943; cv=none; b=Uec7pT/Oqo1sfe4NraErRsZFAegRB+iqgxyARWXG+DSU+bLRD59jaewumxWHtvSj3TI74WYEB5OVK9r5xWp/E0ycwYR7QCk1Irvv0MDdRFZw0oYe412BbTLPORQq9FCrnn7pAdlOaY6mAJWw/t2Pmmcy7JjelzyupMmhNCLZwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756943; c=relaxed/simple;
	bh=vFbTaRxWPwQB59kC9o4nLdn1Q/su2WIu577U4EPRrVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDv70IjZuVHs2Nlwj6g79+WNlT4ZOkEmKjHKYE95rb2W79Ox1gL+Mf0qgtT9zVmvkUESEPhC3WHQYtjRUFsyl9Wg1qe9DvzNTClZLL6Njhz44q45kDwejjjIXhPuWJYHHJywwrlfcMlj28hNYQdBpTU89ON432vgZfb50DYaDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObBNJUCP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTSudk6k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U52YlL555304
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XvE0CnUn5SK3lUAGivif9EppbEE8UDztCGOLiFM0BRE=; b=ObBNJUCPFZnXThlV
	qRUp1hEq9a6onElu63q3JtkIp+ZDOuCfjRiaTtFBxuf0ry7hdmMS/pocDv2qrma1
	3IcR7tTu55oFlUsCX08vx+gYDQqwFO+KkhMav7twhkecByMP5nT9qionrTLy0EJ4
	TkY+thEmoXvOsIY2nvNPVvSB95QUzYSiC6lvwDXbLMtT3A9crD6plg93vtkDk/GP
	pPfqRk9BU8BlG69vjBZHw32gl0MPvPYMD5I2kUYB3xZEEMG5mzF68Pr+MeTBkHm1
	yg6GNktqC7zNG9oz4sJVvYEEQ+heaS6+RXQdFMWLXwshyB+8ssMPZmjb7ptRnLgP
	7L6XCw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59gba2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:09:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c634b862fcfso1175239a12.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 23:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769756940; x=1770361740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvE0CnUn5SK3lUAGivif9EppbEE8UDztCGOLiFM0BRE=;
        b=BTSudk6kAxjKStiPIi13Pcj/bdtvjHsILSk7BxLiAHONPNlSXco7ID5+VOkr1EsuLd
         DYni0EHeeqXWg0Xs8QnnTwR0/6/wXqCOmaSKF9Yd2w6pxr3/sN3LdJaYi2bVnz2ztVF4
         bDtDlT8uzX+8cz+wqGOx+42XNC2TI78Gc46NCyQB49RC+TujcZawRWZ/yUJY4va2lGsR
         7HvtfNSNASO0rwc5GgoNukr0DD1k+INQsTBbqZnbanuwxYww8B+auyUDDXnDSyor2Pun
         QgATuUUqtIKHwnSeHDb5CmgdT0hw/vY8RhYzWkx3FdwXT+D9Zw/vhe8BMK4VwfxSlzeM
         5tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769756940; x=1770361740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvE0CnUn5SK3lUAGivif9EppbEE8UDztCGOLiFM0BRE=;
        b=cc+mwkY04h2aRMg8WO2/ue3bUXIJu0zWlb7RAYcJ5CJ6C/x4iiVHwkmbDVDbAYHLj/
         6P+e2XSFO2TijxfYKlrbUSBJhdsAVIO4x8tBt3Gi4eaf/TsUPqR+4bXI7HgZWGrBzIpn
         67is3JF5ZecrEjsAynkCKiYucthwmpWBjZpxquZPgFGTZEql2NplFs0i05TX5ipttLiX
         1Skf6AyCF0NEV+NTJqu0Wb6sAaGdP43SKZEcWNFzhQGXWJ2u//+j9J3N547igeJ5VHGx
         U9nBaZFzhCqHBSFqE6tJGJmv4cC9rxe+0RC1pDl+31Q+zwpj/Oj4/ANUrrOKALt4XPzB
         QICg==
X-Forwarded-Encrypted: i=1; AJvYcCWVL2EXS6hMRfl4hDNGuSnwuNm6YwjOOYt9xNA89SacJFWLXw10epLjbECR7bpIh+YQ3hOnLGwvcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV46wBm3cVKEPhHO2NM8mQlOQwWpvlru/QffWVsn7r9LkFLYoJ
	tixe4oXMStTjgIWpx0Ge0PWDF+AXuqxHbIzUuqMO+f69D1YEqwLUMwuSFJH26GZZj3dMVTZCatN
	vpUU6yceU2LSXxxg+UWmspmmou28Ocj1q9mWwqkwz1iQbDH/z95B5RF3Vm+jnew==
X-Gm-Gg: AZuq6aKJ+Wpi3s0K0oj2a/Rzkjn8YigzCLCg9jwSPmiXY05/cfTQzGkBtBHe/zEneGU
	MarWVaeAEvNyIhDNEKrPXS7DegHhAwiZjA/Uem/Hbyu2S0D4eJr4g45mGZxxND3uRy6WGVHxBO1
	efAA0Qap87lclF34jN+Q0HrDbq7xaRyfF1YEzSOjE4arQhQDVRZSHXrYxM+wcxMRWxiLKzi941d
	jDWjt/TexPo9F1EE63btMl1SkTxqlfLypriT4taALc4V/yeyZWBCLouiBuc4nmynAdY7jcSqcqC
	ubqfjLjl3ZdhCBdQtOG+U6APGAJU102qzkwEphwE6fUb64tDlWlGzmzci/CZzK6aa8Jl6vLKcPv
	sFDOPXxrGb+lT5/EXrxRVDkN5+UHpe7nFCoVU23x3
X-Received: by 2002:a05:6a21:600e:b0:38d:fa22:8ef1 with SMTP id adf61e73a8af0-392dfffc712mr1756478637.3.1769756939584;
        Thu, 29 Jan 2026 23:08:59 -0800 (PST)
X-Received: by 2002:a05:6a21:600e:b0:38d:fa22:8ef1 with SMTP id adf61e73a8af0-392dfffc712mr1756436637.3.1769756939020;
        Thu, 29 Jan 2026 23:08:59 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276ef9fcsm6500158a12.1.2026.01.29.23.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 23:08:58 -0800 (PST)
Message-ID: <09298c37-4cbf-4486-b720-5e96cc08a1ab@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:38:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <k3q5hsdsxhtf2yxibyqzzldhgrbv366n3rd6wdcoju7gcksiu3@uplmllaihm7h>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <k3q5hsdsxhtf2yxibyqzzldhgrbv366n3rd6wdcoju7gcksiu3@uplmllaihm7h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K5WknJ78lLg-5z8WajDmfOfDxArKYnMn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1NCBTYWx0ZWRfX8FNGqtlFeabR
 HMpvbGU5RR+qXzF2GbGt+X0RxEeMetr7KT++iND2Fi7ChlKG22sxxb5WaUgHu9Z4R/KAfWZ4Uce
 t8bRHP6vjkQwXf8tjnT7XdmAxNi3xyH3LM76mSQFeuS2Gr0ALpWKCss2gFbxpTIjp6Hmr5SWvG0
 5HEVO4cgekvT3Mp2JERdDkRpLlBH9gDUiggKYuXXEkPJXn0OkcBIv8ABti14vakAxWZmerrJS3Q
 nfnqxW3/1FVmOnZyTNDtEFZI76cnDU5VoxDSXhZXl8KKZWYCqUU3PL4gnSCmxqJREzq4QpXjK3K
 Ba/aUY+97OHe1PVZhN5mYKxuyi4X73pc/RPYb7otom0berBhxaYEwMAhUEnduEeeYTIERfabKZr
 As3R7bk8KZ2qITguiWHrnJA6GRS6XCIGfvoIJ/OfDhMa9G0vQHRWXDHaOysa++cRZgrZo7ARh10
 BCub4lDnUblvmqTJjUQ==
X-Proofpoint-GUID: K5WknJ78lLg-5z8WajDmfOfDxArKYnMn
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697c590c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=se3G6Dq_jQueYJs0mkQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41754-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F0280B7C9B
X-Rspamd-Action: no action


On 1/29/2026 6:15 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
>> The cooling subnode of a remoteproc represents a client of the Thermal
>> Mitigation Device QMI service running on it. Each subnode of the cooling
>> node represents a single control exposed by the service.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>   .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
>>   2 files changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> index 68c17bf18987..6a736161d5ae 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -80,6 +80,12 @@ properties:
>>         and devices related to the ADSP.
>>       unevaluatedProperties: false
>>   
>> +  cooling:
>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>> +    description:
>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>> +    unevaluatedProperties: false
>> +
>>   required:
>>     - clocks
>>     - clock-names
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>> new file mode 100644
>> index 000000000000..0dd3bd84c176
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
>> +
>> +maintainers:
>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> +
>> +description:
>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>> +  across multiple remote subsystems. These devices operate based on junction
>> +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qmi-cooling-cdsp
>> +      - qcom,qmi-cooling-cdsp1
> If I read your schema as you've it written, then ADSP, SLPI and modem
> also can have _CDSP_ cooling device. Seems like an overkill.
>
> Please take care to describe cooling devices for all DSPs at once and
> describe them properly.
>

Thanks for review.

All the target supported in this series are limited to CDSP, so i will 
update the binding to describe

only the CDSP.



