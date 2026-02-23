Return-Path: <linux-pm+bounces-42983-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM4qKHqrm2mu4QMAu9opvQ
	(envelope-from <linux-pm+bounces-42983-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 02:20:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 057971714B0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 02:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1358301D6AC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B429BD9A;
	Mon, 23 Feb 2026 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLVTKgqA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aKZygpFi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C71DE3AD
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809422; cv=none; b=Vh7BJIAMl7ZaUzCdkZVihxJSk4In7ZpJPiFyZyAYGfdopoUKW/ggG5HGCxHHlEqnebbel/zOdXMDJKXYZlcOoHy8cA9I1Au62G3y7Qf+QCAS6ZhyRm3afSm4OvD8BM6uoKeNfjI9AwatZlR+PykPpP/hK0fRknCF38iiTLnb5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809422; c=relaxed/simple;
	bh=0Im4acq/Nf2dLlkLQObXe5jJJdgmzcFL4ciKudLiqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izrjx9ZzLl4FwIGlfqkJr76n65CnS5s4tylZ8LuInCppNYDJ++cxu/O280k9JuioGwHfkbk9SLiUnLuivpffJZd0fdW57yeC3jpPNYjVD3SM5o5yCwt/Lt3BYP0oZcRypPrtRV7o2Af7TbjBEXmQuViQKC21M6ap4vugDrFv+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLVTKgqA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aKZygpFi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MGeAql2320254
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 01:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=diSKSPgAJBG2NEAYSdP1/lWL
	SKl7GsVB4rIN8R1Vsrc=; b=VLVTKgqA+w9aZiS6iP3ZjrxLNFiMnkXEqJccuWQ+
	GFRHPvP6MXT858eSqik1bDyWZaVPAhGOw91Y2x3eeRwQu39gRStSdDCuga4fkU1j
	p+M5OeQjgEKzihQzgJLvBHY33f37oKjHmOaZqVRglJyJdg/SuMDLOoQlL5c+5gI0
	1wkUccLDETtopE+SKIf5GqaBBVkuHT/9MU3H+kF5PA3WJUaf1YdzOsEc0O9DGkKN
	iVMn/BmUF0TH2ER/kcG2jVHyImXqaxKBxDTTLF1sW2GhdtdyF9gHBKkocfmz0Vx4
	6UeUUuhJ3RsNG5YXd8ELqqMui7N4MApd0O5UR6Qve6IulQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vj30jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 01:16:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4a241582so3608424085a.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771809419; x=1772414219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=diSKSPgAJBG2NEAYSdP1/lWLSKl7GsVB4rIN8R1Vsrc=;
        b=aKZygpFikvQ9OhH6314KDhVfBwB2dq9MtZxMUVaEiVj4qLkgdCcpolpS4ym9GADTi0
         g/rkTL0VHZwhbN5l5Pc4WmHO8msEa/K7NCUqQdBReacsyoV6c5idBrKj3AvalSKLED0+
         8wjoFt7+AazT4erLwzMCXJwxKDyICS1HGQkl8vBqUFehhxfZPgISMJsLwiVANPFlD5Ss
         YPU+arISl5HsOQrRyRYdWJHOCoGPWXmApacfp/iO6QQdtY4JtnP1cgroN4zlkx0QPJBb
         +ozCG2bf3mV+NXvOT28caACLO4A70mj1QmY7dws+4HRcjdN4QcZ2yQJNqjIfg9+FqR01
         dA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771809419; x=1772414219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diSKSPgAJBG2NEAYSdP1/lWLSKl7GsVB4rIN8R1Vsrc=;
        b=wLusRaMW5wryQgHvCFKsigR70pskw4TzIm2nxTHTaQX2afOxcoAWcz9Zj89of+d0pp
         jHKgV9vE0wh/yWBlu1UoIOI8saCMD/LmyVfdwTNQxR3lxaOego959avwg7u4+6MaG8B2
         35tbY71SrAEqDSL94rrTleC9nup8+DdIZYDiP2RGsjbHN2QSm+hfQCbe6pbONMpe9+ux
         6iPER1RH+Aa+nMu+ogZ13LlBJXOxPXHiEHepsJrWVVmG5imQIYUh6tao7jDfwY674KsL
         g2xTLt31Udq/mOh4WwAdvv3T1TX1mczmwZGvljCDblKcEq2z5AGIPC+axaaXdBmpy1fY
         R5kg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1MynHmXDrB3PJLVuOgWlJ5plLjxNS4WNkGuOLd8bFrBA4jO2O4/8WfcgAfwdYpjDaAJn4DwUjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7P/OPfP3gB3oKIuvx+9BhpvSeNd7opl9W00TdSZZ644WuQOIT
	CWolES8qn1iFpkPT0hXSfhjCBszEg30zNkJILdNyLgRBDqBjud8g2aQa5GjT+aIXhkScG7cjuxJ
	kIqoZ18aVLC6MTb/8I9ldunbwUQQdykiJeOv3A+yBxhRCXf5ar76amur/f1F4FA==
X-Gm-Gg: AZuq6aLO44hEUpdMCmrJgSdvOIvNrqFDd7JKp0pQURa4WCWvCyS3Syr3AUGynaKtQGv
	WqxzaMRSARJy9oEALSE6/vUq5dwht2Oe6S0fD0d+OsQnpem8/6RhktylLJvk/fIR1n0XToFaFAQ
	phhfxph4wFL9Qzx+l6aEK3NgNBHep47Zixa/9Uwjq9ztuLoTZ4btyPydX0731x9Fx0hDfo6tVTm
	flnL5HYIu2L8O+G1sYYK58sa+Ea0Y1yu1V6LvTZIsEna/lHUrIMFvy5OjrKsJoUVWX/O9gqOn4Y
	ucbvZNgSX63y7LwPtrHzod0RgFIXKiAQQ510i+AYyVZGbMBJMmgMFwqywLgCjp6PiMyKgxagTS9
	yPo3Bv8qx4XrVQeW7md4t0Le9yRlQeIUMqb3NuF69VwZgZBgs58v/Dx33btGi48lkwnmYzviXQW
	cK7/fxzLkNXB7FyZRyF7z2zmoZ2682+Of9WSY=
X-Received: by 2002:a05:620a:44ca:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cb8ca63e8emr924601785a.42.1771809418848;
        Sun, 22 Feb 2026 17:16:58 -0800 (PST)
X-Received: by 2002:a05:620a:44ca:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cb8ca63e8emr924599285a.42.1771809418378;
        Sun, 22 Feb 2026 17:16:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a860d8sm11389151fa.32.2026.02.22.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 17:16:57 -0800 (PST)
Date: Mon, 23 Feb 2026 03:16:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: webgeek1234@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8550: add cpu OPP table with
 DDR, LLCC & L3 bandwidths
Message-ID: <ukixjackfe3g6oz6gb7m5oae3i6wz6czycsxfjjphzgdirvvwf@w3ogubzwusxk>
References: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
 <20260219-sm8550-ddr-bw-scaling-v3-2-75c19152e921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-sm8550-ddr-bw-scaling-v3-2-75c19152e921@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDAwOSBTYWx0ZWRfX7yTMG+QM9RLT
 loiIVjB6UQm47siZjgngAs+w/cZs+dxPKH4K0Ivi7rI3Jpshlb5gAzA1kX+EOYmVDSpzlX96fqh
 yfZNwZdKX3yNLNSs15C1uUVnE9a9uqoefeC9RiFI0fOWKAw4n53z/gpcaE3TV7KmBmyOkZnyexD
 wLbXPYd0dxGlzkmICDTPDdm4YDjDkkYSTEgHu1ad2XcqC7HWVqBIGenz/6ePk0X7yOvfgbwZVwd
 09vRQhpG8sQD34c2PVzAES7/R+e2rHN2/pVL9gJuC+EDegiwr6HEto5e9/P7/gETKj5KwPRQ/1a
 ur8vUlC+aV+eYnSKlezmD+8A3AfiYThXALZ4aezCbZoqk/xKxqyvvYseLMjCEYpjP3I0F2nPpDI
 peNY7H/GPHXr+fTGYnegAIiXbC4uU61SU940zzeeDcbcYJlinoXO8gt64MZAyz4H6FgycxD261O
 vBzTMnOK58wXEbpvwuA==
X-Authority-Analysis: v=2.4 cv=T5KBjvKQ c=1 sm=1 tr=0 ts=699baa8b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ze5Wrr8Eh6wvvEUSacsA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: k67BCPopmZl4iEjz0wBqoqduBdJ0rwiZ
X-Proofpoint-ORIG-GUID: k67BCPopmZl4iEjz0wBqoqduBdJ0rwiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42983-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 057971714B0
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:07:40PM -0600, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add the OPP tables for each CPU clusters (cpu0-1-2, cpu3-4-5-6 & cpu7)
> to permit scaling the Last Level Cache Controller (LLCC), DDR and L3 cache
> frequency by aggregating bandwidth requests of all CPU core with referenc
> to the current OPP they are configured in by the LMH/EPSS hardware.
> 
> The effect is a proper caches & DDR frequency scaling when CPU cores
> changes frequency.
> 
> The OPP tables were built using the downstream memlat ddr, llcc & l3
> tables for each cluster types with the actual EPSS cpufreq LUT tables
> from running a QCS8550 device.
> 
> Also add the OSC L3 Cache controller node.
> 
> Also add the interconnect entry for each cpu, with 3 different paths:
> - CPU to Last Level Cache Controller (LLCC)
> - Last Level Cache Controller (LLCC) to DDR
> - L3 Cache from CPU to DDR interface
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 367 +++++++++++++++++++++++++++++++++++
>  1 file changed, 367 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

