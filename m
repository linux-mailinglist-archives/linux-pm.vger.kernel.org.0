Return-Path: <linux-pm+bounces-19187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215E9F0CD5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E821889C03
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C021DFDB8;
	Fri, 13 Dec 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/vKQxAi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A61DF746
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094787; cv=none; b=vB2tQzkQ8EzC2CKP9seR0MPpiv1WH9aDd3cnmRjsv5RmJZ0uXoZXfRchzG2w44FWxeScUOvJ/9uB3Mt/YjuSu5rXPFkTEjI0FExsM0vkQdsLnby4Sj+rBsc8sSOhQHNAOz8lNDwZHDz7JnvIlcGaU5rt2QeNwtXW+fe8d+N1jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094787; c=relaxed/simple;
	bh=1sJQDVL72VcKeErh3nbOH9yrJdYI93yt1fBf8g+slXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTzJcv6hHB423y1yUeJXcdfuhxys9u30ME/2VLhvsNmZCWj+ubTctb3KaN98MQyhREazhjqxVxCVhTx45PR09pZFFO2FjCn8k4DcjwOPfcDc/TUJsF40nuvNne09t5k6T0UPDkTb4Bl+UARABtpACeAeb9ypejd/bCbPIdxg3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/vKQxAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9XXVB031415
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 12:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+eV3bBtlbvxhn0lVz/tJ4AtCvy2WoiBPNjuWp3jNDSo=; b=P/vKQxAi6zvAQ8Fh
	c0WHGtOodR+4PioTYf3lBW6WHF9skSvckpWHvRQ2z2uxSfvsWszdsxL/FgievStc
	ld/7ZbYAypt8MjwS1G4FSw4oCVmb/teH/f/jeG5id0joxoIbpxmJNqWOz/3A4ZIU
	Vxnkxbpmfn7mQaAbqrtfHBbQ6n/F/tBdMsIS4ZTuWZwULv2TEEWo6dJw6KdaqTIE
	56T0TyejjObyNtvRrdAtbVcDXwlCf99xm5Mrw+DeZJRfhf8p5UpMcmP9nH9BR28T
	24vaJoQOsCmiDvQkwOhFjDW3DqNdYImCEExf9glxPGvYOg3illSbVqirBqQeKtYm
	NkQ++Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgekw91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 12:59:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467a0d7fb9fso2227651cf.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 04:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094784; x=1734699584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eV3bBtlbvxhn0lVz/tJ4AtCvy2WoiBPNjuWp3jNDSo=;
        b=ncGQR+BRGKW8QwL40/MM5GBoRKuV1TAJ3CFFO4nG8sKhcOXwDy6mm95Yl1sFNVQmYE
         DEEneDyrtteBvvtYtB83iJMFiconVRPXafoOpIIaUr85zRu8w8qSwBJpEh+Fx11+ifIO
         J2Z/9vKQ9EMQqjvAigbRvmaRbpEPF6vrkiHanakRszUkMmKgoGhgoaF6aEhTinrcXifw
         /m/R6bX/+z6PEucJ/E4lsLKg2eYsBpB7feTc48XhhcP88E7x6dHB79IMoe9fRTWcUAjH
         Gb+f5zz863Cth7BCJJUq8WKq6j3osQTqdM1wCOYRfMCdft0KHX9M+NHwxUDFsYMowrLD
         Uyxw==
X-Forwarded-Encrypted: i=1; AJvYcCXexXGTf9vaEndfZw+6edeu+p04Ea3JdCj+bKiMBepy8GhRxUIKrGKDPMdk6YbB+RoYMaCEndif+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx492UoYRB4hAcSnl0ZJxM5K1MUR7WFHgSTzpThia8Cf01u7lWc
	siYgRmuIav8QpNDij5r9uVd81k25BIuITCCSysIcDU/dE6p76z1MYmzjaAnTS0E4XVzsGDlFLk+
	0Ymo5BYmCkh1y5Iuc1sn+tc5DEHdZA3TY9xmZplJMKiZCNPgNJzQ8TV1PEQ==
X-Gm-Gg: ASbGncsU4om4qxoO5olHJ4h/HIU/SmFZ00hwvCavmS0xQOVxAL9yL6hFbs02kV0adlM
	2xwZSpCnKJL7jfpW95tmRtJyzZBDPBid/MWmlmYpkAtAWtzTijanwgfm8M7O3e1wEGgL7QgtNUJ
	PnP0WB8WaDMt23csYbPgd1/T/idaHigLDDfghXVLesWdNqC2Iux1ug/88fy7xmpH8NcK1qZfxCA
	1l9KEZ3P7Z+oRcTtTC8jAHlID1QElR+BTenMPuGfXV0DKJtP9j3GJO35S3eU/FVYBc5Jg4SxrRY
	+NYO+S10vOP2YtGs9LJWNw1LNkuZ+/c4spk3
X-Received: by 2002:ac8:580d:0:b0:467:5715:25c4 with SMTP id d75a77b69052e-467a5718efcmr16859501cf.1.1734094783917;
        Fri, 13 Dec 2024 04:59:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTMVkScLMOAUpwlo69xsAMyYTOhOnL3+dt2mvoUtSmgo2ideD0opMaFY0HbLG/Js8xSim8xA==
X-Received: by 2002:ac8:580d:0:b0:467:5715:25c4 with SMTP id d75a77b69052e-467a5718efcmr16859271cf.1.1734094783581;
        Fri, 13 Dec 2024 04:59:43 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d19498sm822746466b.5.2024.12.13.04.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:59:43 -0800 (PST)
Message-ID: <556ff23c-8b2c-4ea3-99dc-84196e3f0651@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] arm64: dts: qcom: ipq5332: Add tsens node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125050728.3699241-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X61vLsFIRZz03gq8EOybgY63ZwWKpJ7R
X-Proofpoint-ORIG-GUID: X61vLsFIRZz03gq8EOybgY63ZwWKpJ7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=913 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130091

On 25.11.2024 6:07 AM, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsens
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

>  
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5332-tsens";
> +			reg = <0x004a9000 0x1000>,
> +			      <0x004a8000 0x1000>;
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base0>,
> +				      <&tsens_base1>,
> +				      <&tsens_sens11_off>,
> +				      <&tsens_sens12_off>,
> +				      <&tsens_sens13_off>,
> +				      <&tsens_sens14_off>,
> +				      <&tsens_sens15_off>;
> +			nvmem-cell-names = "mode",
> +					   "base0",
> +					   "base1",
> +					   "tsens_sens11_off",
> +					   "tsens_sens12_off",
> +					   "tsens_sens13_off",
> +					   "tsens_sens14_off",
> +					   "tsens_sens15_off";
> +			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";

Please move interrupts properties above nvmem

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

