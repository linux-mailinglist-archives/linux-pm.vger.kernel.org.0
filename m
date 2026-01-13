Return-Path: <linux-pm+bounces-40707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48783D17A5A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C29633002BB2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF036D4E0;
	Tue, 13 Jan 2026 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3zlSVrG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMsqlV3f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9C341079
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296816; cv=none; b=Uzalt2xa+WYG1hIOw5DuaZTnyCNmowSj1CcC5JOjgQ4W+YiPbd6uy39YxIDCfv7bllSVnIAlOq09DfPyH0GKF87AdA6xM2ZtT8zgp9o4DdUnTYR/goj3Zemf9FwWvou6GttoOYaLrLCSLXOCRsypNVAtds0ozR1lri0Dk/uzlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296816; c=relaxed/simple;
	bh=H8rfWCz+nXlb+YRhv9ajoJCIpOgmMFGeDLzv4IonWdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm9Y6FH+s/5iivcT05Ftx5A/2loPfOBTHXAYMeFaUeAiktyepUGZU7KfDbv8G1rngK0jGe0H7JesFyOiF/+yvkI5BRwrN76nWFbGN+xaoi9wPA8UB1xuSM1BD8O5F8ELy0PO8+qcRBqI1t6pOx43xIxvA6OgUW7ZKfr2nTiW5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3zlSVrG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMsqlV3f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7xpDJ3299718
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7F6fqsyOtjM5uYbaPFIgQgGuXH/dsJ28oj9X44dO5jU=; b=j3zlSVrGbRUk2srz
	Y+Bki3mJ+ZJPIBCZbguoSOhQP6tRoE06CAAH02ft5gDXZxn4kN+J9Pk+HCsVX/uj
	c+8XYVTIBJQVZdRzYa9X+mXq7CmEuOWyKXzP+3uF4R0gORP3GdA27bK4xdoajqHh
	pbTLfk0ViY1moB/mIfpblNrbnvP6PVTQeV3FVrWFKjh+KBwslTee2y8jE+5tLip3
	hne7v93Zu01AxAaWChKS+KH3Q6P7tgBCmVA3daw5Jp9IccrwQzjfOaKa4BVfH6nv
	iEQrlNDNjXiIv9qAJPcn6NaNbwRnUypmUk7+UkuV/5oFRCNrWnyoLkyFl8OXgHNk
	m4r9yw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jma7c0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:33:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81eef665b49so6505467b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768296813; x=1768901613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7F6fqsyOtjM5uYbaPFIgQgGuXH/dsJ28oj9X44dO5jU=;
        b=OMsqlV3f1w7ObmE/grlXuEHT53vGDGwMPjUjnILZQ2xXXYo9wCPtzrYBL0HueBOyXl
         Ck9XaOf8AxSt49Pwan4GhQ14U5uajeBljSTtCNPIezXkk+8aQhe/TT/a1ePSR/dKwYCC
         b+HgY0qAEIFyVFkrX5aML1MDJ3Dwx9yvLGv70XUIldBUbX4WlhZnl9HMN8SeNecm/8j+
         eychaSrLM+6mGA+LhlvB8ZV5fwnMPD846bXWudisrwfwUsVb7HoyCEWlBx0cGVsnqcqO
         lotOVgwul4N/E5fq6jso7bnDrT14w+APaDGNzeneOYK6dViWfIgab9cJDT7U4mPuQQR6
         0OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296813; x=1768901613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7F6fqsyOtjM5uYbaPFIgQgGuXH/dsJ28oj9X44dO5jU=;
        b=HvKY7LTuwkBxrRg942NmJV5ed3AwsFgw2CxixKUcxIbfLm7trbybGl9YPVXfzhQmCr
         hoMl+lB05QTWZ9ivxzcu++oCboaAzM873nzLag/UMnr4XgobEui2wXfnf2YW9JPyMmr+
         D1lmtlHDmoraidjkClGVP6gf8gWeqQVtQzib3nYcMKK0SPfJ9L7ukqLenZh8S88LxEeW
         dXQonNZ18IH6Q9SCXYEdO3B3ITacHQeUckZn96hUkcViIBS7MVfB/IciI3axyraXxGfx
         y8ZFV1my4zJqIldaakF8o1/QPNMZVe6eqsLYSXEa1zN4BAF6WdJFIhC2P0MdgPp4v97+
         goOA==
X-Forwarded-Encrypted: i=1; AJvYcCWxyCFS4ohSZM6PdpHSkSZVdxVKehnGFcujdvTGW7mZWeVFwRu/lH4kI76UV8nLaPpps+FQWe+O/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSnrpcGtJLZntfpuM4IYUeO3Pbd5DHzVWwGM+Z/O8QuQ5fUmx
	Vcmf68IYeqvkCv9Km0X3qTT5pDOQdFsNrPnjtJrYF4M+i/Zz6k0zyixjzTL2CvFl1+5vc1Q2qvN
	YwKufnXChbKilDRr31Hrmine5FLOnQm50MOrV2Fm6+3YTnUsaSx4U0F8Hl4iQIQ==
X-Gm-Gg: AY/fxX4De9G+UEtgJ/ixZQh1twAJFyPcdyrjbT8+V8sW0wOhjP26INmS8ahkKVXLNBB
	U26M00X0wJR8TjBgyoYgPWIOP9X5yFQWCq7pcF3c0mGVE7KUatVe4da6e3XY06Z03GeHhxjgPb4
	cHF6SXeiqaMc5yflR6CE/n1dUccEuFJ+X1yNyzG//ceR0BQJBjRuyoT1WuPQVfKcl2PBKIZ+rHx
	NxTr1AXKJM01m8Y3prfRTkQqJLyu9xW168tgJk6UJGppaUk7hmUvUCGaJMkDLUTpAEkAQQIuwSR
	JPmqRcECON1He6o5kVMUQUW8PC+mAMaYD9H2NRrufcDSgHRf3FmKQ4I+PDXIDZt3NIBzSL6HrKB
	F5Uh7rgDhlgEl9LKlHZ3/HyUH8oHF2KtdQ+xnr6M=
X-Received: by 2002:a05:6a00:21c5:b0:7ff:da9b:bd82 with SMTP id d2e1a72fcca58-81b7f6ec1acmr19324370b3a.40.1768296812845;
        Tue, 13 Jan 2026 01:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFecIeFYBPLxo8KEKTggo8B28U1qCpzEzXqTxElS98E5p8rJyvLXahJvNMpn/S72AOPKREPWA==
X-Received: by 2002:a05:6a00:21c5:b0:7ff:da9b:bd82 with SMTP id d2e1a72fcca58-81b7f6ec1acmr19324337b3a.40.1768296812346;
        Tue, 13 Jan 2026 01:33:32 -0800 (PST)
Received: from [10.218.27.120] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm19893360b3a.16.2026.01.13.01.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 01:33:31 -0800 (PST)
Message-ID: <6ae95761-6428-4a01-8c60-54df5e54b71f@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 15:03:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Add RemoteProc cooling support
To: Casey Connolly <casey.connolly@linaro.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <2a39719e-e73b-4558-95fa-d54f94c43220@linaro.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <2a39719e-e73b-4558-95fa-d54f94c43220@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 38y5TiHqMlMWMGrTZCx0hJTzTDpbvGTB
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=6966116d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=0dxYOwnRambvcRU-GJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 38y5TiHqMlMWMGrTZCx0hJTzTDpbvGTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MCBTYWx0ZWRfX1tu6+7AmuYh2
 Goad6TnRFUaJk9Z/23E9oQW9yC7Hc5GyUhu6T+oZmDodUQENMi52SJnOhw6+kx2Zl+T/lU6eHxv
 4LpoR5ZjnyJkh7gxbj1HWYCDS91Dk8yNBl19R8sgfmNROGID1dAo++WEGKlvW5q6+uGN4Z2lmwx
 u2yn49G/YliPmnxgmQpMbwnVBX0eSkekWp2Tp8+pzQmKgZbdrI6VitQHrJQua1Wi/DfDIz/Xd4C
 ygj/jlKOdcpld9652iCVzRlsccRP0m3SbnPUXgmJ0P+RZZOVmySW0HgujBHBvffnwW87oBenXqK
 YaDN6CREr+tmYAev2GVB3t69ohEVaoNpEMpI85DkKce1phLDRzxM6+9l6IZx8HHAg7f9Uh+As4T
 iF4waRIiLT+zE6+3JR78gHpYAdtzPflAJDmht+G25wu/8yUzUQ6I0HmVagCkItofPD1jC3v9zBc
 HDp80aVLzdQpK5SDJQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130080


On 1/10/2026 9:43 PM, Casey Connolly wrote:
>
>
> On 12/23/25 13:32, Gaurav Kohli wrote:
>> This series introduces a generic remote proc cooling framework to 
>> control
>> thermal sensors located on remote subsystem like modem, dsp etc.
>> Communications with these subsystems occurs through various channels, 
>> for example,
>> QMI interface for Qualcomm.
>>   The Framework provides an abstraction layer between thermal 
>> subsytem and vendor
>> specific remote subsystem. Vendor drivers are expected to implement 
>> callback
>> and registration mechanisms with cooling framework to control cooling
>> devices.
>>
>> This patchset also revives earlier discussions of QMI based TMD cooling
>> devices discussion posted on below series by Casey:
>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/ 
>>
>>
>> That series introduced Qualcomm QMI-based TMD cooling devices which used
>> to mitigate thermal conditions across multiple remote subsystems. These
>> devices operate based on junction temperature sensors (TSENS) associated
>> with thermal zones for each subsystem and registering with remoteproc
>> cooling framework for cooling registration.
>>
>> This patch series has a compilation/runtime dependency on another 
>> series [1].
>>
>> [1] 
>> https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/
>>
>> Casey Connolly (2):
>>    remoteproc: qcom: probe all child devices
>>    thermal: qcom: add qmi-cooling driver
>
> I'm glad this series is getting revived. It would be good if you could 
> explain what changes you made to my patches somewhere.
>
> I also remember one of my patches adding the DT parts for SDM845, 
> would you be willing to pick that up for the next revision? I'd be 
> happy to provide my Tested-by.
>
> Kind regards,
>
Hi Casey,

With this remoeproc cooling abstraction layer, we have integrated your 
patches for subsystem cooling. As lot of comments came for qmi-cooling 
driver, so need to send v2 with cleanup.

Will do clean up and send series again. Yes for other targets like 
sdm845 we will add once this is concluded.


>>
>> Gaurav Kohli (6):
>>    thermal: Add Remote Proc cooling driver
>>    dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>>    arm64: dts: qcom: Enable cdsp qmi tmd devices for lemans
>>    arm64: dts: qcom: Enable cdsp qmi tmd devices for talos
>>    arm64: dts: qcom: Enable cdsp qmi tmd devices for kodiak
>>    arm64: dts: qcom: Enable cdsp qmi tmd devices for monaco
>>
>>   .../bindings/remoteproc/qcom,pas-common.yaml  |   6 +
>>   .../bindings/thermal/qcom,qmi-cooling.yaml    |  99 ++++
>>   MAINTAINERS                                   |   8 +
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi          |  36 ++
>>   arch/arm64/boot/dts/qcom/lemans.dtsi          | 138 ++++-
>>   arch/arm64/boot/dts/qcom/monaco.dtsi          |  92 ++++
>>   arch/arm64/boot/dts/qcom/talos.dtsi           |  23 +
>>   drivers/remoteproc/qcom_q6v5.c                |   4 +
>>   drivers/remoteproc/qcom_q6v5_mss.c            |   8 -
>>   drivers/soc/qcom/Kconfig                      |  13 +
>>   drivers/soc/qcom/Makefile                     |   1 +
>>   drivers/soc/qcom/qmi-cooling.c                | 498 ++++++++++++++++++
>>   drivers/soc/qcom/qmi-cooling.h                | 428 +++++++++++++++
>>   drivers/thermal/Kconfig                       |  11 +
>>   drivers/thermal/Makefile                      |   2 +
>>   drivers/thermal/qcom/qmi-cooling.h            | 428 +++++++++++++++
>>   drivers/thermal/remoteproc_cooling.c          | 154 ++++++
>>   include/linux/remoteproc_cooling.h            |  52 ++
>>   18 files changed, 1981 insertions(+), 20 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>   create mode 100644 drivers/soc/qcom/qmi-cooling.c
>>   create mode 100644 drivers/soc/qcom/qmi-cooling.h
>>   create mode 100644 drivers/thermal/qcom/qmi-cooling.h
>>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>>   create mode 100644 include/linux/remoteproc_cooling.h
>>
>

