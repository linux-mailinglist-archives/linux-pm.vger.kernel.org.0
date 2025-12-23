Return-Path: <linux-pm+bounces-39899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3336CDA6BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3291300BECE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2302566E9;
	Tue, 23 Dec 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AI4dN8ha";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cXCFbFHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB129306491
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519533; cv=none; b=JhOfl+8595Vxf6xjdk5TdnnJwtXYTiYPIU9tt+GkR53jdnfsab0N9o/9P34Yytxes6EwkjCQ+E1xyTXlNkecYfRl2leLUvbuaPwpP+dCizc3s0VsRdSn0qz6D30+DFPI5R/hse0rYohU28OmwEXpMYg+h6xH4SQWkBcO70P+h4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519533; c=relaxed/simple;
	bh=aEYc4AJOLNr0Fq/XaGxyJNzOjvRGBGExsVKICWIWc/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbWZ/POuaXEFArI9bX1A4kFrnnF6YJTIFFD83QBNgTkXXMBqt6be0mYvt/FUCnqO/lNaxTnVmluP2lBp/ya0Hxgv1+Y3lFDgrklf3UAL+V2ZROAIeDdYgSojTMuqSTJ0yU5KFkbbl3vcOscKoGANs5aX0CVUXyqpMUFo84SETeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AI4dN8ha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXCFbFHv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNF69Ga4044367
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6KshIsYTLPDmlTDd0Y/Ja6i6
	zDZQ9rQe0PmWZGrSK0Y=; b=AI4dN8haoMhyfMpAqDD5FmsAm66lEibWh1rOWfsB
	42I19bwfviEDxu16idybD1zIjYzEXOq/CRk2Pfmf0EsEET2M1be7UKOYZUjmUqx8
	1Ve/Z0Mr69cYPiUL3If+GM88+sg8UBNQ9TdN7SBUTGMXpaXRN6Oby9a1YzVb50pf
	Zi2xfpvKIQe1iwezNhrYwPGeFIiQXq7UsARpMKSqSgiFzK9VtU5ZXV6qrSwNCi37
	tUpS4p8Sn1g9clK89Re0BQhfuegCm1FZlliFO3dn1uoiVz5kNSiSHr+FyOooTsV6
	l++I8Gn/2rwb1qHrINcnBVotJOacti/om0GrlV7YaOae3A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cuhbx8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:52:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a37ca7ffdso80174256d6.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766519530; x=1767124330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KshIsYTLPDmlTDd0Y/Ja6i6zDZQ9rQe0PmWZGrSK0Y=;
        b=cXCFbFHvBfy4g9ccDuvmdDhz7fkMG+C7tB4sf5y8g4+QeyvYztiDlk9PvRjJ/tqP92
         ax4pXdg3FzziasyWhxPF5dbynsF2l+jalJbFt0TNulkDzlI9ybhazHspDN0M/VDLT5XC
         BByU/OX65lt4H/DRhuZ73yNkYVhPgSMfBCV1IKWl8tGcEcwF/0weDH+Ru5m2tR5Z1n6B
         UOCMQvlqVdOgvjZdwlmQqoN8GCCwucP45855YdcLZP4qj0YDev+Xiq3PcgSJi6bH+/T3
         UiTwlpVG6kDkBhqqcUNmfWE8O5Q3v4AMzbD/CinluCTbchi4BAaPYA5IFSfsljWynugm
         05yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766519530; x=1767124330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KshIsYTLPDmlTDd0Y/Ja6i6zDZQ9rQe0PmWZGrSK0Y=;
        b=tUj9ErD7R1Dj2ItKMRqL9qtjwtt7mKP5+cfWxldItkqAea0THRWhXMmpRMH3Ly6jyX
         B1xzM9eQZqJKy9rU2yh1sQO7XktewWuBzTJnJzbSvHEOdsM20VXKSWK366rpbuTAM/AI
         +LWYzBdeDXWO8E24aElL62CKoPNZnuNixctuHDWPWA07WBHYiQAvtIWNXij6QZ4IUngh
         o8ui5ptuRGAIb5y/KNigTbjEs9Eo/spp0V/QJ+4frdrKw4DGNIiisx7HhIohK2+P2lR/
         qZFKx5Z/3wQpzAx/+7ZIV73JGxL4mlsb937al6BwVgfnVMZ1Cm+T8zeb5iKHK/Swvk6U
         r6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EtWS4Ev+6EdOPUMqTqk785Hr0A5iOBTFPnnp5+S6xaS2IoqR3YQa/1UV/EdH9ZEPyNWdbompbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFkLdbt1hsiBOApUD/jmyj5JrI0UUvGbooMKlvZ6T7lIzuYvS
	tKcFp2HHH8JRnuwoun0n6PQi4x+7emMVW2Meo80CUalyUHa0AUhY7e/u+V8GvbBRHRK2p/QG60x
	9+Nfn7lyLP0sB3dW5ZMAw6K5OcSm79rY91eNDE1t1sPhz7DSTTjnf+05K5bnJFA==
X-Gm-Gg: AY/fxX5DZ3gmCuiLDZa+aSzycGbQToKf6VrIEHgAH60tESTmjakVL9o0nracBI9OVnv
	tZFJhTGEb1RZ60iUSIXTj5Ysb8GC//WCeoaUAilKdskOOpQXR9HyIegBNmqO3XxNUKrdX2yV5wt
	B+pazLt5xAaVcYtWcKwJqz735oEqjEDcMwonPRoIZI6AEFy0eBLcYDIRbJyXVZIS/Y5BLeQJ+UH
	9Gm/QcVUBaVEpqolwfYZF/hH5/ihF/IhUPyllewthG6w5/m4Qfu9EnZqLtxhhK/m82FRqy2Mm5M
	qs0YHvQQ7QSIipfQi//LJszBsDH0FTSkLLxDNENGO6P88mlb+z7XUBTRZ2b00mp38SH5L8gdJtt
	raL4hzslRsK8cei9sl4YLKaIqWKODXmaGGk3ZHBTDI2VMq37ql2fb/I8Oh8hPCrgVq347H4hp7l
	WGr5FKb0sftsGHF7PZg//QupU=
X-Received: by 2002:a05:6214:3d87:b0:888:8187:1547 with SMTP id 6a1803df08f44-88d83d66f47mr253092066d6.48.1766519529991;
        Tue, 23 Dec 2025 11:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElcmzSWfMp3OnnkJW3VSNidVbgATVqt44JHPnSvdEiCCLx4xVtfnZ1g49h4JyAKbDBK2UkeQ==
X-Received: by 2002:a05:6214:3d87:b0:888:8187:1547 with SMTP id 6a1803df08f44-88d83d66f47mr253091866d6.48.1766519529517;
        Tue, 23 Dec 2025 11:52:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b307sm35999471fa.31.2025.12.23.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:52:07 -0800 (PST)
Date: Tue, 23 Dec 2025 21:52:05 +0200
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
Message-ID: <y4ccb5svc3ucrqbqlhsqfau3c3vt5w5eie43w3kk2q2ewksbvd@bzkxunvoerwc>
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
X-Proofpoint-ORIG-GUID: A0tLO5c_f_-YuPIHRBUZOULrHqUa6G-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE2NiBTYWx0ZWRfXyy02Aas1UdrL
 BgZVsvgXiydyKcvRhPrEbmbSBK9AOIgK7tlRtlKhJRFrJJcniP2L0T8l0ZUfCdzFysbmEBoY1au
 O/Fy5MGrNnokc2rAM8TpbemyzpSWfZecMj62Levi1bt2Wyrj7LTCEhYoV9C75idng8XdjnwMyxx
 /P/WvOFzObrPzBp63bIyOpvs7oUaGSU+WqdssLqz1BqX6yH407n04ll9cMtLS9waEeTAwFYoX9A
 kEWhh3vcVabhlDp9SCbBT4yYJAS9qTzDa7+GvimXVAZQDxwMn/QWUJlAeQeTA3tHW6FGQ1xtTyk
 If2e07YRTC9ioQGnWvAHcCkFY9rY3hv6AjjjKbkefIfPgbV0NAH8OOnFUkqtgQxFoMt64bj7PHv
 CwdlHHb1p2d3xjTYgOEdwnnlv3aiZ6uQ6iXp8GPPivvTTaH0GOJ/WoAn205YSJqLmpZG5cpfonV
 W5Zt1yCvXjWlvLl53/g==
X-Proofpoint-GUID: A0tLO5c_f_-YuPIHRBUZOULrHqUa6G-6
X-Authority-Analysis: v=2.4 cv=NZDrFmD4 c=1 sm=1 tr=0 ts=694af2eb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BvWOXjPTdWbiDO9S6QoA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230166

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
> +
> +examples:
> +  - |
> +    remoteproc-cdsp {
> +        cooling {
> +            compatible = "qcom,qmi-cooling-cdsp";
> +
> +            cdsp_sw0: cdsp_sw {

After going through the driver and through the DT. How many cooling
handlers can be present on one DSP? If it's always only one, why do we
need subnodes at all?

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
> +...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

