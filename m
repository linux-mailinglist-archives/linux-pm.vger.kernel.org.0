Return-Path: <linux-pm+bounces-40083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7775CEB788
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 08:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12F43028196
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030C2C21C1;
	Wed, 31 Dec 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WfeKaQ7n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOGrv8lK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF725DB1A
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167252; cv=none; b=uggD47boygN6I8pK8aImSQ5/iLPpvht0s+QbLDZmaUyFLfwoM11wOkyoNPU+elYDMiD3VOHWOtgSwhIHdIhjK7BxmOMUqhNEIMgYkhKsAqF12dJO2na4FIx/yzbvXRiNgrr7B8OqTbFGs5Bp7QM3ShkuEe3iTrc3KU6BMi6djKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167252; c=relaxed/simple;
	bh=+xhSSy6F53MP4C3wgAGMcZME0+5+CHURVg1O2xHRHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA9LiNEnYYeno0YLzmX5yEpG6g3B3gZ8QFeZK043InVaB0bXchND7zlyqW2hlwyUQ4jGrbMvUjT88v/xJvFx56O23knvdtvTTj6r/CHQMfeJglQ7csSeNqlBAkb3X/ugLkDC7NTEtqGjLj3fxiUQWCrdhT+h4g6MIXPogvBDX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WfeKaQ7n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OOGrv8lK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV5uZpo3539553
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CNxJJO9Po/q5iHBXITeafdgQcErvOrIqSg1mjP5CSU=; b=WfeKaQ7n1GCG3sTq
	UOiqWQ3Cl+ki8Wg1Vk5aipt7rBy/xtbr7r5+DiXEYFjkSLph/M/XkNN3mhoaTJSg
	kpSZ3s7K9Bpwdv4h+wgAW2We2Y2LREU+A50R39J4xRffeVwNcJXhsxjOhNpjlqkA
	r1K2JV+LK3aTLjqgxPjzPRRrdw08ciigVqpCJWmi/1XowwoSrVs2wbR4IqiBmual
	nQaRW/Uh7LOSpivWHmUYtXwJtuWlj12DEbjnu1d5a34mUbWFardHOuZy3m7aZlhG
	np7DEKbGB67VonWXk89KCzG7S/Svw8utbaybXx2Kjl3aXn+0pDvScHl8c4+OGJZk
	QSYrCA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc88yk2qj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:47:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991976so252064276d6.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767167247; x=1767772047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CNxJJO9Po/q5iHBXITeafdgQcErvOrIqSg1mjP5CSU=;
        b=OOGrv8lKF738+W2Fe8C5p8XXygHJMiQ0/+EtY79uQ7/DdqhlMQD4cqjRziGkDr/lRc
         qbTqxbwob+3ILrkoNaOQh87ppyMiVq2FGYnK3BB/WYU4Vb4pw5+N4zG/H2+ihYICUT71
         pF3d23nQ2NVtxP4bkPh7sqXwIbtzGAdY3KKASnR5rLZ9qKO98VD9msiRmDkZrY3LonKs
         l77M3SSebOrWDh2fZDixDLvEKl4R6HsKtF3Uo2ActI06u8pdcAW9DLMR4cGVra0jNtZU
         48ooQ3T9MZ4lno58HaGeU4ZzyS0z/7DhaSNkGqbizMez+e56gj2holLL9HVCW03aVjcX
         3A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767167247; x=1767772047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CNxJJO9Po/q5iHBXITeafdgQcErvOrIqSg1mjP5CSU=;
        b=hQzrxisrWiy76XVLBtvHgpCg7iNCz1UOlcif1p4blpl0dWJ7yxxdd5ZDNiewHj42nx
         ddJQtyjGM9Bjj+al+39LzCf2q1PFa50tFaHaGbW0O0ZjFZ3naDZyioK/kPbWnl3ehGsM
         KocfBdhnqcftgTAmw9VJY4DmPTlXwBKEMQGdJ6u9a4UdNvOTqOOXVnIye2+gBvtaZ0Q9
         WwKuSkL9QT4XZgxavU0yZ890zlZYxgPu/LEcqvug3bs75YGJwGNfPLmNFrcD0XQAajoP
         YdCsX1MpJDTXXZiVC+ub6Rny7rxoIa7RQ5lKLlqv+HM5kXAOSSqHePMGqHY/Vrf++Xp9
         djSg==
X-Forwarded-Encrypted: i=1; AJvYcCVSd1YqiNLSds67ell2YO0PK9rqXzXZSe0s4e1p1vh/2s9j3QX+W68U8qtzqhLJfsjOUPhboHgODg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi961oGXrlGnCxhWOxzouKuhTQehbA1UdYYOgUiQYVToGY+Tcb
	fnFMbKVVIcFA6HpZ9CxtSn0CTWAeLVgxlz/wrxgBx0NSi5eE/Ufu7qpA2XFkos8+7ASH8oHetXe
	w9G3wS91RgH6eV9WTWrq6Bzr8WpDGPsPvUpdd2qaRUdOlY1LsSklsPvnNfZlmXA==
X-Gm-Gg: AY/fxX7jt9Y+vHPhih5r4HBV+J6rnQDDlCkzBnDQ2Mlutf+nJan/KIqWBgIGqm329vG
	US6ejkKDwxFciyYcB42Da4F8Mdo6x845EeB3Mzr2Q0gXGHZ23dpFoDG9spH7X5iLkh+rOgVMonI
	9lz4naey5ld+eXZDhAiKpEcvO/LfFKWqwrQLyOb7LKKNkYOfFAAbzpqD5gbaAnUClASNevn0SSh
	Q0RrSHi064l9iWcEQuP/KDxcMOcatYfv/mbmuiq9CMh6rZgpCiOaD+UR97Uvj/VJulOW51Fu8HE
	kVhS+w0UggFg7NbwgJmK650ICCDn25ZbDlY9zBMiwzHGvUwCzzBJ3QoehvOU7soQUbuNs6wqBSO
	6ruSmNVpUD4iAg2RVFLp7kUbDfDTfH3C0c0+jL+M4OQMddcHazLDM9IW1+c0PVZ3hbe4uIUg+Mp
	2XwBo0uZ188H6KPi6NNPA0iso=
X-Received: by 2002:a05:622a:11cb:b0:4eb:a192:de99 with SMTP id d75a77b69052e-4f4abdc6a37mr481032041cf.76.1767167247557;
        Tue, 30 Dec 2025 23:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtjk09vQYsUUCZ/BI0mKFiAa5rvEnZw88dHUZAkBfnTmtqk5GgZbBYwAtd+MZfyQs2Eq1JSA==
X-Received: by 2002:a05:622a:11cb:b0:4eb:a192:de99 with SMTP id d75a77b69052e-4f4abdc6a37mr481031751cf.76.1767167247015;
        Tue, 30 Dec 2025 23:47:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b2958aa32sm6643755e87.19.2025.12.30.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 23:47:26 -0800 (PST)
Date: Wed, 31 Dec 2025 09:47:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <qbbn4dpp52nojvi3fge5kotnxcetuhsqhtvm6rl7rjbo46e2ly@cp24xlhdk54h>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <f6bd1bda-6aab-4d4e-9981-f55cce03f70d@kernel.org>
 <3fc177ca-0260-471d-b7a4-bd479f5e5855@oss.qualcomm.com>
 <60653b06-38c4-4276-a6e5-4a5900ba19d4@kernel.org>
 <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=POcCOPqC c=1 sm=1 tr=0 ts=6954d510 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FPyIfFlKxg4_FzLVRAoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zqKcRGwpuYPMzb81krjjkq45n2Z4uCCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA2NiBTYWx0ZWRfX8eHF7pt6ALgc
 Oe1/Sk82ip+0kOF7voi7yt55aIZ8sXxfVv4+bweoy3auxWeQKbJajeFFOkTKMIW939Bg4JJyt68
 8RCFGrFcXMWKHL30DrPYtAisin6erfXb9WvOS0x6eaB7qbCYMidN3k3GqoFUxZe0DWwlc031cDu
 K0YMjEO2ouwxAd19FaniS+2/fLsNujdlSibrlsflnJkUgvhuDPJ9tNtwygfbaP5EEVlnSl7ipkl
 NwKAxdOet1czwG4c/hlGx184n7JskKMGFgCqzV6urfMus2P3i7kro1RPsQsxgzHHkjH9zM01N0y
 5Pv95R8WSI8XxtRh7E7NBbmMzr4tZmakPtwSxrXs16tzR8A3laBWG818TU6NbB241+Qm8U5lZ8w
 IMCYWfkJ/9ifuqdT9NpXmxLqXjVELpxT4PFegoyK53MnYvejAmBqFhRby8b14kQS/XtSEWl/Ow/
 dmkwd5ercJqEpgHx7bQ==
X-Proofpoint-GUID: zqKcRGwpuYPMzb81krjjkq45n2Z4uCCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310066

On Wed, Dec 31, 2025 at 12:12:04PM +0530, Gaurav Kohli wrote:
> 
> On 12/24/2025 3:54 PM, Krzysztof Kozlowski wrote:
> > On 24/12/2025 11:08, Gaurav Kohli wrote:
> > > On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
> > > > On 23/12/2025 13:32, Gaurav Kohli wrote:
> > > > > The cooling subnode of a remoteproc represents a client of the Thermal
> > > > > Mitigation Device QMI service running on it. Each subnode of the cooling
> > > > > node represents a single control exposed by the service.
> > > > > 
> > > > > Add maintainer name also and update this binding for cdsp substem.
> > > > > 
> > > > > Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
> > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > > > > ---
> > > > >    .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
> > > > >    .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
> > > > >    2 files changed, 105 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > index 63a82e7a8bf8..bbc82253f76b 100644
> > > > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > @@ -77,6 +77,12 @@ properties:
> > > > >          and devices related to the ADSP.
> > > > >        unevaluatedProperties: false
> > > > > +  cooling:
> > > > > +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
> > > > > +    description:
> > > > > +      Cooling subnode which represents the cooling devices exposed by the Modem.
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > >    required:
> > > > >      - clocks
> > > > >      - clock-names
> > > > > diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..90b46712d241
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > > > @@ -0,0 +1,99 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +# Copyright 2023 (c), Linaro Limited
> > > > > +
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Caleb Connolly <caleb.connolly@linaro.org>
> > > > > +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > +
> > > > > +description:
> > > > > +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
> > > > > +  across multiple remote subsystems. These devices operate based on junction temperature
> > > > > +  sensors (TSENS) associated with thermal zones for each subsystem.
> > > > > +
> > > > > +  Each subnode corresponds to a control interface for a single instance of the TMD
> > > > > +  service running on a remote subsystem.
> > > > > +
> > > > > +definitions:
> > > > defs, look at other code
> > > > 
> > > > 
> > > > > +  tmd:
> > > > > +    type: object
> > > > > +    description: |
> > > > > +      A single Thermal Mitigation Device exposed by a remote subsystem.
> > > > Missing proper formatting. Please do not send us code written by LLM.
> > > 
> > > This patch is based on older series
> > > 
> > > https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes to remove unusable code.
> > How? This is v1, not v2. How did you address other comments? Where did
> > you provide proper changelog? Why this is not correctly versioned/
> > 
> > > let me fix the formatting. This is not generated code.
> > I do not believe, because this:
> > 
> > 
> > > > > +      phandle: true
> 
> 
> As i have mentioned in earlier reply, we are including below series:
> 
> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/,)
> as this is client for remote proc cooling.
> I was seeing this error while using older yam files.
> 
> ('cdsp_sw' was unexpected)
> 
> from schema qcom,qmi-cooling.yaml
> 
> So to avoid that, i have added phandle to avoid this error. will fix this in
> proper way
> by including another yaml file which will define the cdsp_sw,
> 
> Below is the dt node:
> cooling {
> +                compatible = "qcom,qmi-cooling-cdsp";
> +                    cdsp_sw: cdsp_sw {

You can't have a node called cdsp_sw. Underscores are not allowed in
node names.

> +                        label = "cdsp_sw";
> +                        #cooling-cells = <2>;
> +                    };
> +            };
> 
> 
> > Does not exist. You cannot come with something like that, there is no
> > such code.
> > 
> > Only LLM when parsing DTB could invent something like this. Otherwise
> > explain me please the process leading to coming to such change.
> > 
> > Best regards,
> > Krzysztof

-- 
With best wishes
Dmitry

