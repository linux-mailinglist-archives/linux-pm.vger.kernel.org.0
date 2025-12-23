Return-Path: <linux-pm+bounces-39896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A96ACDA5F0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A117B3027E1B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351134B425;
	Tue, 23 Dec 2025 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZnfzgia";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXhRSOXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472B3093D3
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518254; cv=none; b=cGxAHAk3rZBn3FOI6m3TYUoqBpjz9NMoI/2T8ROhtpLA6cg6OClX36SOCbaUWRedyy6V8TIUXCeu+d+laKIGwd/Psir+YtCJCCPhBo66KM00CB4mI/A3Ufv/uhVn/FCJWlWaQn5VpHfHV20iMO8yOa1W8SaT1lPjcMb+CHREiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518254; c=relaxed/simple;
	bh=lpfwCWAZ7+wTD7QrVV1mgvT+unO5FNjQODfCh6BMuaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7JKtwI6gMjoirxkoQY3Yo4Vh1xXGR5x6NqlV1U5f9J5CbOeSylhKxP9uUk+yKzWY45We5IOVInvhHROuhwJJluZmozj21MG1F1XWQbfdi6G49L7yT5yRFBkrIjKTgVjGx5olgybjxi8G4ynoUEV4Y2HT2gU+Ekxei42o8Qpo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZnfzgia; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YXhRSOXH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNEN9tX913513
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h6lriivzVPKYtHRQjomqIXlX
	ye2O+WWWhsb5/tws/RA=; b=pZnfzgiacWhx07YYjGaYRHsLrPekIHwb+fGIJsvD
	a3cgBxbOoVOx2+pUjn6PmBkHCY8JC73Cq41qiHM06JPlFMb0OHM2rvSdhQSDQhpd
	34RqYHuruRNb/Di+2YMQx9KvpDFuEG9MvXvwCUcanEBMz/czp7ckFdzLUvTUKFNc
	e3NWlnwgwPM+zt9GxaRdtYGtNZFWeJhHSEmvXpwJkOVCS2g3jLHo0jJmRSNo72RT
	QUGgVwKG+lxXq/xsIt3GVcT68v8PUrJb1ufpbXmnibLL3+le84YhKjY6SFvZ4X1y
	QA2HgvwNZ7uS3tq31cnupS+G3ENm0+xF2wX4qtJhKhjn8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7vt2gx7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:30:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a3822c06bso142733566d6.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766518250; x=1767123050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6lriivzVPKYtHRQjomqIXlXye2O+WWWhsb5/tws/RA=;
        b=YXhRSOXHYD2EGz1Rgf3JZtBymzV/sH5hHVEJk6/QQhpNcKqgpxyliWPSCCt08dEkid
         /mfYRPdalyKND2S8URMhtZpfBVf5Gv3SpSAcphSwczPX7X2PZquAW6vID+kCIYDycxBv
         KcNxJsaKn0fVevJB+3vdeDxUftPhDL23ivUVW8O0BhZZXE6wmvzDogz0v1to4UEyd4IE
         +vQEdQn/P/2KPDneC44sFm6xxkdLZGmP3h46OO/o5+zqnHd4HCxILcNDXlSYq66UdIbZ
         tqTds5/sSJL5awT90Yrwy+aVue9njoiqZz9S1PWUqSF7UOQlTpJcqGLPq8+mLefGHcWr
         FmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766518250; x=1767123050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6lriivzVPKYtHRQjomqIXlXye2O+WWWhsb5/tws/RA=;
        b=ngj6Hxk2myqWF7Yv91uDEAAUlAObwpnl0E0/W5CL6EDAtCwwqG+fG3LKKogLPTxKQx
         /5RE4PDUhaRlvBB73u36Ogf0oCNeYdPZ2fRS0F4Bfom5I6VRThfUeBYYEBWkphQYaK0D
         RrCHnNg4k6v2T5WowXhVAB3oaEQJU5IxGDGXmlklQtsJGY51W/tTVyUrzyd4BHiFDIf5
         BvYhNHi3NXFvjtVdfIYVqRO8RwgC6LzY969jvQJBviVui2/fGWL+zWdl/HXcAwOod5km
         bMI8s1ppoMy3iUcqVMmJAA1wOTt/5zXh2WB5GyC+ekb7SiJF73wcB3aUJtWk9TjMiGbE
         i6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/EVYDuo/Hiluy+4N9w+pVNmKv54Gpj5AhEgxvpfPR6ms51HYt9HSgsu1i7c5L8C7xln3gECFXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcCBV+pVA0NT3EuqgGrk2WQzQyCAk727V50O3ZKpo2VyMyeZV
	x31rTXR5Y1h9PeKR6HcdANlMNf2k9uR+4UByFu65tFDLpss2OlSFduW4lP7AfqlIGVdXErHJ6F8
	FFduUKZgXbUS0F4dYGexZW95m1Gt+EB5kXNwI3qJLdZvK0zf6ut1sqlraXdYzYQ==
X-Gm-Gg: AY/fxX5T7zRHM8MJGcHe1u3J3ov9UzQV7em054w492GbiyQqJYhoMX6qgwBbnWIUB77
	bexBBSFoGDpgaLvTWEUO3nTfigWxMoeP4IseCmHUmq6Nd2BrJkFh4JrfYnrr4Mil72lWRYm8HTJ
	M2yre/kS1T9RoqaG0Qfi25vRtwEAGz1BNQakzhM5Z8Od4H0DlJdZGamp6YhAUP0xdk2K/pu0W3n
	Nlz6U0IPZB0KWDQ/dFcS4HkuZR/PyQNV838dyycwM0gL8PTW9cD4PMarYCkLX7IrzQldaIdb9FC
	PkeuNMrU4t0n+Gs5DBfnQiFuX/ai6vohGvM9Vss//7SJPoo7piHlP57hCR7754/Fj0P75MafIgr
	hLCp732Otla/C09BkE0jFDyoIQvjSp4ZKwiQKo3EBMSuAAePgsmfo4tl0GxdpK6VWNvGQlHhVhK
	XxWXH9BS3lllBYCZtoxQwq49M=
X-Received: by 2002:a05:622a:588e:b0:4ec:f6ae:d5d9 with SMTP id d75a77b69052e-4f4abd9768bmr224557431cf.39.1766518250410;
        Tue, 23 Dec 2025 11:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiQFhmg+1LgcdFhv8vPUyL27Emq3BsdV/vBymwMw0Fb3q3aNJMLIasImN8RglxRiPoWEF65Q==
X-Received: by 2002:a05:622a:588e:b0:4ec:f6ae:d5d9 with SMTP id d75a77b69052e-4f4abd9768bmr224556911cf.39.1766518249895;
        Tue, 23 Dec 2025 11:30:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1862846asm4272768e87.102.2025.12.23.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:30:49 -0800 (PST)
Date: Tue, 23 Dec 2025 21:30:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <fu7rhvpo7t2fjx4l7nvzd2cec7loyjeqyvwgochghyyax4nqof@6bat54r3qgov>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE2MyBTYWx0ZWRfX0hq6J+K06+kD
 DLgsoo58yVdEjPOqNKiFa1oqZKmjPxttMaKrZv+f8CXrZ0LY2wlLaG+D+M7gCq+RhO4AWjhxQ6v
 OZmPNnALpFZyVBSeHmysSkdm6eyojkn3tPbUAmLDawOY/HXh3c203oo6X8QXXnzDO/pNJU27P0s
 ycOlxV1y6pAwlvYsVrsbQm4zW8PatEYR5Ysh+fDaSwpcTaqxReng/bsEHnEshxCXMUyAbNXBReo
 SDNNAT4ejWYC3SAjeYByIzrYTqWSnI8ATvhRo/boaHyAnRcQFGTkCTdG6TD0keVqz5Pz6Ro5oyP
 yCyiZ3AagsPOzg5S0PRd7WwtmzdmQUphb/JHTV7qESbODTPEJ4jFsRaz/Ug2Hd0q/dyQ6xFmtvx
 1rUht0x6TWpk4RPbBsAwsg8RXzFd9kXJMvFYTjhf8Tg7I/UxyTCivZ8onc0zI+FM10l14KQWfyA
 MwXGlZucTzkWt15Ezug==
X-Proofpoint-GUID: fwRDzNzWxrD0TPx0ifu233inqfLvHW8R
X-Proofpoint-ORIG-GUID: fwRDzNzWxrD0TPx0ifu233inqfLvHW8R
X-Authority-Analysis: v=2.4 cv=brtBxUai c=1 sm=1 tr=0 ts=694aedeb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CyQ3y-Klav5xImQqluMA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230163

On Tue, Dec 23, 2025 at 06:02:22PM +0530, Gaurav Kohli wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.
> 
> Add maintainer name also and update this binding for cdsp substem.
> 
> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>  .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 63a82e7a8bf8..bbc82253f76b 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -77,6 +77,12 @@ properties:
>        and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  cooling:
> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
> +    description:
> +      Cooling subnode which represents the cooling devices exposed by the Modem.
> +    unevaluatedProperties: false
> +
>  required:
>    - clocks
>    - clock-names
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> new file mode 100644
> index 000000000000..90b46712d241
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 (c), Linaro Limited
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>

This wasn't updated.

> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> +
> +description:
> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
> +  across multiple remote subsystems. These devices operate based on junction temperature
> +  sensors (TSENS) associated with thermal zones for each subsystem.
> +
> +  Each subnode corresponds to a control interface for a single instance of the TMD
> +  service running on a remote subsystem.
> +
> +definitions:
> +  tmd:
> +    type: object
> +    description: |
> +      A single Thermal Mitigation Device exposed by a remote subsystem.
> +    properties:
> +      label:
> +        maxItems: 1
> +      "#cooling-cells":
> +        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
> +      phandle: true
> +
> +    required:
> +      - label
> +      - "#cooling-cells"
> +
> +    additionalProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qmi-cooling-modem
> +      - qcom,qmi-cooling-cdsp
> +
> +  vdd:
> +    $ref: "#/definitions/tmd"
> +    description:
> +      Modem processor temperature TMD
> +    properties:
> +      label:
> +        const: modem

Why it being called vdd?

Why do you define modem-specific node here, while the CDSP-specific is
defined under the if block?

> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,qmi-cooling-cdsp
> +    then:
> +      properties:
> +        cdsp_sw:
> +          $ref: "#/definitions/tmd"
> +          description:
> +            CDSP software TMD
> +          properties:
> +            label:
> +              const: cdsp_sw

Why do we need a label in addition to the node name?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    remoteproc-cdsp {
> +        cooling {
> +            compatible = "qcom,qmi-cooling-cdsp";
> +
> +            cdsp_sw0: cdsp_sw {

Is it allowed for device node names to have underscores?

> +              label = "cdsp_sw";
> +              #cooling-cells = <2>;
> +            };
> +        };
> +    };
> +
> +    remoteproc-cdsp1 {
> +        cooling {
> +            compatible = "qcom,qmi-cooling-cdsp1";
> +
> +            cdsp_sw1: cdsp_sw {
> +              label = "cdsp_sw";
> +              #cooling-cells = <2>;
> +            };
> +        };
> +    };

What's the point of having the second CDSP block? Could you demonstrate
modem instead?

> +...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

