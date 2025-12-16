Return-Path: <linux-pm+bounces-39633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BDCC3890
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 15:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7ECD30D196D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8465C3587A5;
	Tue, 16 Dec 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3WaOQ1z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6x1Jx9V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157EA357A5A
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887265; cv=none; b=Hopq5vJnHTa7CJ3WOKSCRKF6TIKHshhhOBJDj5NCBkP8gwypLokvVoOg/g/o2SoBggmrbxmhjYRaNX71zlmJaIFNjt3nrSA/Hyc40NrmK5KOMrugayy++EQ49BEXXfmyb8jg0ApVttIALxLCZejL2qR/QbqXaPKTYtqg2L9w9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887265; c=relaxed/simple;
	bh=yJKFLN7YW6OmeRE6BOlO9IK3te1IOjZ71MvoO4qgMgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YI0mLBWxVKCwmF4xxs4zYvpz3S7/rpjWMznL/BDpCZGneNHAxoAbmOJCU3ZqGAAjlNrE8HtwJleOBCMTKxO8jXEX1czrB+xscnx6gZWDMRR6rxa0Ae7FKjDf/+7UMrP+NKsTpRB3n+Bqh62OkKz+nQTpSdcOlcRNwMmv91ncQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3WaOQ1z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6x1Jx9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGC3soY2810651
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	16/wIy2pdlULZ8ONM9EfUI4Zmyro5D9Bgds/oD362R4=; b=o3WaOQ1zfc4R4Qvl
	BP7m9vK3HQjtpkTJmBgNH6MLkJbkbZzBUoFAS3MXHgKrNwT3EjH6sb6djnHHH7hB
	qwuQTY3vaabpr5DA9uMrZFxHtIqnjbe5uyn2PMRQEVl1DGi2Z6Ml8lNUGHVglUHx
	d/84O/bNCwtN3C20lDERjXQiy8OMawQ/BwFZ5fnkEXaGhZZDsDWAjN790z655ela
	8Y55H4ysuj+YxmBIShQLL3VIstoykGPgKUNQZCs3o8FqLGcxvSgEd3q3PUWaO75w
	EEPIAMJFfV24cNKVu+vrXDoIf1h7u5+Q5Ty0V7wVvrWHil1Dp7j2d39gmVJ86NAs
	+2prjg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gas9pv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:14:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2fd6ec16aso73088785a.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765887262; x=1766492062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16/wIy2pdlULZ8ONM9EfUI4Zmyro5D9Bgds/oD362R4=;
        b=U6x1Jx9VbSV7md+jl7GGG7S0WF7vJMBKUtLqLXzOp2GZ5XpbOXyWLlyTbDGGGk2HWG
         ojokEImAp09diUbdGDLZvz7Miy0qxWZRgBgwYWsZKKFEHyw5NqsOIWKucKgykt5x0KSE
         BZIIxTxCqFXhrNn/j8eWJDY9skrhnB0WjmvEDdlUnPluONuIPdPodO78sqvKFRcctmgP
         1/OIzTQz/7+6nDoS/ahngp7iw9jjGMI4kfr2Ise/tnmJKAbSeO2Dd2w+5bVEgupOnAC/
         TsSlFwz8XJLYB8JDExyyKdwBI9KPbpQZwmmW6geoWa2zrpoNjGXHuxZiLWiBX8XfgIti
         fjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765887262; x=1766492062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16/wIy2pdlULZ8ONM9EfUI4Zmyro5D9Bgds/oD362R4=;
        b=aYt7XIkWjEIuquizicl/MNPCAzc6q8hJUWYLpiOy816JIXWR9yCCUn6bTxkVx7nfUb
         bzPbuqRBUlDaNofvlJCD3WF98DTqBur5vtbI/8W+KTb/JYNaKhHXi8MGaEnt38h1bVsw
         YagOTeReZjYtZAk2wqEaVpnJKov60jBkZNV5tI6JSBYuYk/GbYShcIABwEcd1VJLpMg8
         9l78cFMmdxsV/1+Qc6hkWa/DYmRnDLpWQHNAcfYdPTRgt0Psf8p+Udd8URaQppJC0QXG
         dN8n1qutLwMDmj23opMkHxwK7NHme7aw1Gmyt7WIP7mCE/L0crPms0oACrHytQsm4Qft
         C4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUQvcOOrIKvK8UxsCl9oSxNeRjcl0mMWz/xKHjJ6EP0M3D4bRG3n1nRdMPHNrFnFpZzif6/7SesSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUG4qt8t+cmR6fgPleNlM/Lazji2fBHcM9xLdXW2nZF7Z94Tdg
	aa6S4V4bvhanVyGaFtulNDkbAA5CNe3BqUtqvX8C3d54nbWGEtaTa1VCPctkjI/JxLXJpJqbKWk
	KTJ3L+5BZBj4lPsP35FXMPgdp8NwKojWUBBi4L8eHh/xaqHZZI3ymgjgS13/ORw==
X-Gm-Gg: AY/fxX7wYH2hIaokTWHUenZ3oRfhpIhO5oiQRJTss1XCamYMGovZDbvXG5LbrmnXUWV
	6ZD7sPrWfE7B2dmIE+Uc5ZTmUPS7MJp7yEAWgR8vVDLxezQMyfCXtCMt/bBXCjwdC+as3kSteBq
	L6AYiOVwyba/23WGzSIdLO4fHbgzcU4g/ztqfpMiAOnS4W2c7vjyL19q5OOZXJ0EfaO5EWSdS7n
	chmMGhr9pVzM1fkExhSEYkHk7ySEFoXzdxIej9mm41DFquYFvZ9xBVQJsdf0Ft5MsUyZ4cu3JAv
	V2gi9/id0L1rt6X6MBCasjv3TKqIzfukm/yCodb5VilrwHxK5+uXLy2XPLcckjahhWB3mUXkNfn
	ig8K5C8YbvH6iAhjyzDnC3Do9KJiIeUud0PD6GCutUhYK4PNO/FyAv49rRdzg+8wsAA==
X-Received: by 2002:ac8:7f49:0:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f1d06724b0mr152370231cf.8.1765887262266;
        Tue, 16 Dec 2025 04:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC2vmxl0OpZsjtN0+6EBlqKqjmbjan6XEWRnP+Dkk2hDl2mEvaNtMJ5HTZ0L2t6SWpujDP7g==
X-Received: by 2002:ac8:7f49:0:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f1d06724b0mr152370041cf.8.1765887261921;
        Tue, 16 Dec 2025 04:14:21 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64981fa5514sm16025465a12.0.2025.12.16.04.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:14:21 -0800 (PST)
Message-ID: <f1dc4911-fb20-4289-942f-ac6d133e9591@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: power: qcom-rpmpd: drop compatibility
 defines
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
 <20251211-rework-rpmhpd-rpmpd-v2-3-a5ec4028129f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-3-a5ec4028129f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=69414d1f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lR2tOKNDw1Un2gOXHDgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: onXkxHRhvGSJyjis2-uCN1PZLF7ySi5v
X-Proofpoint-ORIG-GUID: onXkxHRhvGSJyjis2-uCN1PZLF7ySi5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMyBTYWx0ZWRfX9+xOYi9I/jT5
 t564fFlx9tohCqxIbliO3DHb5JQiwXF3CfBjX5cO1I1vPN6Wr/fA44ZFG39Ipt6VnvLHT+oJiUJ
 0yLHUVYJlm3XXSZW6QwOuOKFjc/k0A3DxX+yr8kGcipWbWxhBJTX54VJnHiFx10LDPmvvv7qjpk
 Q5o6UmiF6lFUl0jEBZyIwOHeggaOLP2tP0g/AZH5429R2y6Wec1QuySrlbsdYAb5jc+25RCEQc+
 JMgV9paZUfGLkRjMOuxLyhNdMeLbpRHP4fzg7ONN5iP/W/aQ79mnUGrqX5N3ubV8OXgN5IrXyVY
 DNuPRduAcvzMNSz4mMJe5RdS61KoxscpZVgdfPWZ5Q22QyXypEhRIg4aSNHYgWSPpHmKB9uo1be
 swWN/cVb91J0MkcOoHNs+NLSq0io+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160103

On 12/11/25 2:52 AM, Dmitry Baryshkov wrote:
> Now as all relevant platforms were converted to RPMPD_ defines, drop
> compatibility defines from the qcom-rpmpd bindings.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

