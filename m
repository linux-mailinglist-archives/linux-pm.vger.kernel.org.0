Return-Path: <linux-pm+bounces-41385-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOlGKELHc2lZygAAu9opvQ
	(envelope-from <linux-pm+bounces-41385-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 20:08:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8357A050
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 20:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7F530097F8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF78257821;
	Fri, 23 Jan 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NfOUlXjS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyQAbD3D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E95225409
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195208; cv=none; b=cb5tg/NGVH0UAiUaTarbDATLL+pZEBfr1uEKCc0ZpT6zQq3mYCE8y832X6+v+ex9NeTZ96rI8RPaZ9i2bBWrFm5rXiFc0Oa1l7zPyH+rSk/SJ8AQ2zcHtm+FnFKA+Cmswc4bQuMzkpLHmU4XtfMQPvklGvJMEpM+r7alRDd7wQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195208; c=relaxed/simple;
	bh=cXeKyQn1zrB0s/g/Zlf2fCZzGKuPI1EYK4pmTBNpp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekwRnR2ZefXl88sq+LDkCZD6eKcXwQfpJfIsLzmCN/oGSTtdHB2sRyj59G2xFDQCfh/Loef/zlZ9icyWBDrFOtOaWewNbNTojdBkxwgc7/Gb4oqupuniU/oAvLReHFLC7AgoIcxHaUBeUJNQDAVArqfdoQ6bh2d+Y9bd0BFTuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NfOUlXjS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QyQAbD3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NBpKXg3656282
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 19:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qKhvdckabX5eF5ZjxFIcU92u
	hukFwsWBMCWJkQDEYrU=; b=NfOUlXjS1b02dU7qA4Vd6KoPlmWdROeLrKf/AoBX
	anCE3dDq/U275V9JxV1ZPImmYe1Afub1vklQv3gjsEvuMR6XQ/2wrm25fholb/YA
	1cWRb815a9Ejj79yXkppaqYvALouRuHplp1MMw2INZqGecdvLYCvNTxIvuMZhgex
	MV27y6NOatoS8CfvYcmhA21DYkqcr+ainL6sHzNLEN8P9qeXa7HMT2bdz1WDOnqm
	t8tJCb9YM1cqoQwwdcWV2VrU6YmvlNIBXf6/9LqexUtxoLUYDH1txQ1jBR4y+Yf4
	zEid6jc/B4NLpcU9DH1hn1cAqqKPvZK78xWdXs/QUDa6Pw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv2hwaqpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 19:06:46 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-93f65d0a94eso2549844241.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769195206; x=1769800006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKhvdckabX5eF5ZjxFIcU92uhukFwsWBMCWJkQDEYrU=;
        b=QyQAbD3D0EXb05wutDINEKwDkCyuBlIlKqe7k83zN6q1WaQVbpCCnsiIHsx6e88Wpa
         +eja8yXrTaAnCm7Sg3Jajuc3VQ0fzEPA6oRgkxDoo5SICZA92g0ALKOQ3JycwrLTBpN5
         PlSf2HQ8jxl420fOaAaNSk+72K1f1in+tsFbHVlq6VgQTU4tMQseLSoZmRf1th2eeY6E
         zw9aA/t1tt2pPRczoDBTARlhNAEJP1kolPS9uyvJawFxLyb2aT6UdvCqZGazZ+j10uNf
         9Pu32yAOvTz9ZWHVdKvmpWonaDDVo5css1KqpZOiMamhvhPCKT7VM4GF13t36wdyTvtZ
         wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195206; x=1769800006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKhvdckabX5eF5ZjxFIcU92uhukFwsWBMCWJkQDEYrU=;
        b=uxLJ56tQ4CsPDZZmpqAmh4hBtStPIx/zaD+voi/MDhH2WAazLyk0rO5pm1ievyvrOi
         NLHR0+lTZYe/PXDrJAe8E2IslA6+qQOMiIEVaFLlyjTdZYdpfYIXxcO2HwuPlEDV1UJd
         f2wM9pOu4742zDSHtYeYZD5Sg8bzBaXEwhchAOmsHCIxYCSjWiPwhKRfiU55ZYuWlK26
         5JDWxRaOFxlky+qxHy15iccc33Z1VLSD2XPNvhdrFqNJ05ldP+7HrLdexkhxgtKhxIx8
         uXzadnN3bEuKkjKortzKSuqnD6YzzutuGoJFSBsoAlangvtfnJBjskQRP6LEeodVJkiY
         H6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAA6/Y903fN+fDMDeO+05RG9kKzTNUHGANRFGahWj5zVFKMyB/sddvLMPHcrktxbc4fKQL4Y0hgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqjqdwa3klIJE04myKgwnwHwagArMwc+xefFLFPvNUx1jWXyxo
	dq0GF4PjtYb03lldeVa32dXRdR5gAC8H4PTZlewwijU8DySGkCNwnZreB8yUcXBBF/gnq0DgM33
	v4uUL1GEAsnvrhIEUXPFUiqleBi+C159fTxgPGPjGbm7nvmNBTgCrqpX6zFuF+A==
X-Gm-Gg: AZuq6aLqeHaiWnnfFrYnEY8Q15CyFWPaatXTXawSt/Yxmb7Q3luPdL9u77d3xWGKm1M
	x5VERVHvYmdfEDYVZaMYV22zD2IuO/v3obAWyl0bx+K9nE2a6ZX6hM1gL2aQVR9556cyvaSRqXF
	MFuuZOD+BXO9tclChlg4FxzYoh/nNMOWJsqVee72BdJ76RR/rvioqJTEtJIze5bRGcMD2r+1pKM
	2rLiyHpMYphstV933H5E3BTZiLLF1M+kQjjJ0zrvYdg61imeWJXsoNZJ+FqfcyjyuJy1U6do70z
	6RO4Vahu+olsRw3P4ri41sISU9pN5RraaR0POdmvVFD4KAJS8ZFVEf5HHFMEHyXjeJlNbz+SGab
	ObjAI8AxzSbuifiW0DpTBMRilF2qvqD0Mr0pBuFWYsE6rDV9VzIWjfSDnOVDxJNtI+jQDeVpXiY
	ZqVyIfVxrDq1Dug+MWD+riwKc=
X-Received: by 2002:a05:6102:950:b0:5f5:3d46:e5fb with SMTP id ada2fe7eead31-5f5584d5694mr572033137.5.1769195205750;
        Fri, 23 Jan 2026 11:06:45 -0800 (PST)
X-Received: by 2002:a05:6102:950:b0:5f5:3d46:e5fb with SMTP id ada2fe7eead31-5f5584d5694mr572025137.5.1769195205315;
        Fri, 23 Jan 2026 11:06:45 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48f0259sm836004e87.45.2026.01.23.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:06:44 -0800 (PST)
Date: Fri, 23 Jan 2026 21:06:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add Eliza interconnect provider
 driver
Message-ID: <mj2yai65bpxgky7svixb4hgtbekrmbym7fzc4rw6t77bot52iu@h3lxsrfy5zaw>
References: <20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com>
 <20260123-eliza-interconnect-v1-2-010ff0d100c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-eliza-interconnect-v1-2-010ff0d100c9@oss.qualcomm.com>
X-Proofpoint-GUID: 5lvzXauUZrlTjcXNlhhUQFnCgFmZVIQc
X-Proofpoint-ORIG-GUID: 5lvzXauUZrlTjcXNlhhUQFnCgFmZVIQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0NiBTYWx0ZWRfX2mQSB4cttwie
 41JxFIz9xNzXITxYx+G82C4Eqm+rChAsIy5DgouO2d41Nq6e5XEITyS3CHATXf1Sho1whu8n4MG
 P0u5Rs4a9wk6lJ2b9SatKoj5qFwkmEfcQY7bZEhWuy1K+Xw8a6V0C44Im3sCw3OUMkZtxIkI8ln
 ev/OapSS5gy4b2jpowb8k8uLjYiTSSrVAn4LYT/Zqx5G1lWkIwpPmuU41RM95/uonJhNzAUk04q
 E4EKS38xnE51rRxbbSJwUupsYhdNtQ+fNa3JOdBm1/X9ibFheG/jev0msqi1C44ZKMpz8JYkNNz
 y/naccjo2D8x9qXeDFXdsTnvnSLSWbaBdXne9FoY2t5zkZsRn0u0wCu+zpqs3Q3Ee9APOv2W8jG
 R6X4/IDquPATJ/+QY0u0YGxGO8ZWcKTkMHy98JIiYdriG9HeOlFgDZ7gp1IlY65n0dQ+5KMHTto
 aUC6+plJbiR9ucmqMqA==
X-Authority-Analysis: v=2.4 cv=A4Rh/qWG c=1 sm=1 tr=0 ts=6973c6c6 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=IdhJIH7UHSwZyGBE1u8A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[qualcomm.com:server fail,sea.lore.kernel.org:server fail,oss.qualcomm.com:server fail];
	TAGGED_FROM(0.00)[bounces-41385-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE8357A050
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:43:21PM +0200, Abel Vesa wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in Eliza
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/eliza.c  | 1586 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1597 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

