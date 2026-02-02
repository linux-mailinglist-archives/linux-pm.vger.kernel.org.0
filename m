Return-Path: <linux-pm+bounces-41925-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EQBGz8KgWkCDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41925-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:34:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796CCD11FA
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F23563008097
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6272ECEB9;
	Mon,  2 Feb 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMcz/zUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIxhOo4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECF2C08B0
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064442; cv=none; b=dzsddhlITsdUmaCXNlAr2MKEadR8hVVQxkpwmJiVe880g+tAUDnOD/nEu1PUh/JCpK1zg0pY3tEWx2/N/IpuZVWMvxF1Hx32+Em9oIxd/T9KhUwOTfuBvtFoo2rA8tkx6+Hgj1iTlgT3O7zg6pCdZfXG7q1oculx8DvGYsQUXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064442; c=relaxed/simple;
	bh=AAGgoRaMg8X6w0FiRgwznJrC4vdntNkIqJEV9/0kQ/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj3Z3vIGL3c1qyOOP0rGcmDdSoUA/LnBbo0VooDT6uiDGWnPM6v6U8rMz7ig4DvnMQnXLYwAjTP04O9nBUe941UWtzN6taToZTdQHlILWpG3ix/qGzO1fWeCvbJwL+MMCQdx0vHXL16VAWHdkAuTV/JjZy42vRsWrgqARYtlr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EMcz/zUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WIxhOo4S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CVDR0255028
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 20:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ckMGDlkbd98kpK0JvG0HV1pF
	HxIC7BaO2528jq5jWA4=; b=EMcz/zUWkRPYHmlImw8hbDqaozu/L2J4Wik3iYF4
	mKHLDZqN5bpyfhId9Nt44qswZOU0xUuOkhI6oOCqbOZGgh9iMp+TWvnzqa3qFVhN
	HtnbSbrYMOM1lCWE027scA2SjsAEsv1gaguuZHTCIVV69MPdSoeo+IJbTLiPhOyx
	X45weeigqMF5QB5kZ9ASpYcpcSAhVt6DK+2RGQWu6pTDrJdsPk+hSEzhRMRXh0/9
	1pLZwoyc1sWuEFVSW2ZkaYX8eb5pHOPKfRJsXa0zkXLUFCo6B2PD2qtR179tLu3Y
	XjJ3yTnliq40GS1Uc60YycuyL7POLvCr7ZRfZJKFuZewFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0khgdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 20:34:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb9f029f31so1537031385a.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770064439; x=1770669239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckMGDlkbd98kpK0JvG0HV1pFHxIC7BaO2528jq5jWA4=;
        b=WIxhOo4S0w2K7z5+aFxcfoFUmhtRgvxsdYSjdfPXxTNMYX00HAAHgtVhglMcfQdR2S
         3KtcPdhfH5CfuSBAl3hjlBAgzpOdwjHb5aDfIqp4nWRm5Sf/6H8jTCrSmFucLaZFozSm
         esrfoBeQHghgu7aFRCIQjfMjt1V07RbhV2GPh5aG2vC2ZeRNbpOEVCvHMfdZRVPvYJ9+
         VGJ2GRJpf2MuAzKA5NGLJyAcIV9PkCS9ORqCg8/keDMBJlg2bWLkCVCCS9PjRCXodyGg
         9q89Aq78LKpiQSj11nfmAx/90xxOSlRI1OI8MNEaPAwIZ3WCV0pJ9GWC+28ZG/QwxEtl
         mqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064439; x=1770669239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckMGDlkbd98kpK0JvG0HV1pFHxIC7BaO2528jq5jWA4=;
        b=kUWA4NQe+wakk6BCr1UAJFh9aHNeaBf34IuFR84iIbM939CM20T+JA6/h4PUrVYTA1
         lA+JtfhXych4NdUxhhSOGvIt7aqYv5tGT1iRUXaZisnYAUXaEsIQI+4MYYuJaxfrQgpq
         vqpqBaEllf1sTKqEMgmqdJ07CsPU0ZxVFMykUg/CjHtQAxadY+Um2TA3KOAN9+1XQ6ou
         WnYHtM4d2UzFsuHmLfiPUWYHnrKT64dgdO+dwVYMGzUsrzfk1Y9muaG27a+3glkpYKeG
         b8mDVeXlZ6PkEMPp1xNlhODo4LZ50w6vcb0sGmtyg8p/LZWyl6xH7m/1i5OnFpMQfb41
         WpnA==
X-Forwarded-Encrypted: i=1; AJvYcCUxRErsFOr8IHdyfukArASEYFcWk/q+HeeFTmBSlvh+stLdFx6WDWSofIFapSJ0V0cIYy0ba7OEYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWyprTRFtLyxE2wng8CAS9GOVsMA8SQZjhMtcKhgRcRfBMBxB
	EO0ioFUIWfoedHBLtSx6eyTO6IVmJj8P7glIMtgyxMJ2MdF3PPQzwm2o48Lkg/mIfksidL4QA3m
	lzikrMU5thZ3UTuQBig1KIKENtsnm86YYWGku6ghizsDfDrH13MF4nCOfqrYRysYtF5BWzH290b
	Y=
X-Gm-Gg: AZuq6aJHA+UYrgtscG29XqBf+6RJ/4LfcFIFFbWgDkQf5jbfbI2P5LLHXoWshZ/PE3i
	pBM8aCVDf3+p5WM4eT0vpS5qzYcfQ2+Uu4HwxKJlCDFnuXYwdE80EtB+pk6X8uc8jER7strYpTs
	t8B8i1361Rx4ceE/4ijt042uDnf+8mnynsVFxstbYQn+Fk/Sb/DDRZcnKGn4uG+OrT+yVrtV0la
	lpJSo3Nl3X2fPNrAXQVBUROTKPvq/bJeVsps9+qlcE9wqqXbmAdcbOc9An0vd4kwSVkdk/5Wgpx
	qAVRLd06B7/Wlca+N0ZwczsIqEPfdF7yeXXz6oQd3F5Yc2yCNnYvMgi5VC1nAfY9BewBddKkzL8
	lPoxbzSWEQCLw36od8H607Sz1RVOh2p4vYi34Ev+u+J0BBI9brxwGi6bfodqc2435AnG94bWg49
	H0CFuCluUgdhBfotJbdu6wOXE=
X-Received: by 2002:a05:620a:294f:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8c9eb34facamr1591675485a.74.1770064439027;
        Mon, 02 Feb 2026 12:33:59 -0800 (PST)
X-Received: by 2002:a05:620a:294f:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8c9eb34facamr1591671085a.74.1770064438493;
        Mon, 02 Feb 2026 12:33:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e0a2ddabasm3382564e87.25.2026.02.02.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:33:57 -0800 (PST)
Date: Mon, 2 Feb 2026 22:33:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: qcs615: enable QoS configuration
Message-ID: <2tvwvaoyh7abkx547mmuknuzxh2hmxopodbfukmpmkgbvz4ghl@2svwizaxbca3>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
 <20260202070534.1281652-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202070534.1281652-3-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=69810a38 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Np_ZfMqjrSSXuD8GcM4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE2MSBTYWx0ZWRfX9/iUYInYmnQg
 +iaSp/IbH0X9tMZhvX9kKCm4CB8Ez6u9b5ipSxVIhvzXmqHTvqG9WP60zO4KMEQkHVWsPtziHCc
 iW9Xuf2E8mTd3XGZhe4xr+exgYveoSfl8YYr/WkVvTNWtfFa8rvbDpE08FfUA2Eg0dYy1cf+C0I
 xJTDqqwpCE4F5AWTd3xnX1k3jztNQYxE/48qz3CtL6jodvUbZsaXeOAAX8dUWnKwpPd9fyIlgED
 1X1uhqDwOEGhSRtpSQEhSR1vigGDiU7xNpRtA7gZRmHO0uzPWnE/irEUm/5JRnIZ7X6NxYxUiqk
 IkAFoAnY0tbm63vBNPB4GghVPfUdq+7JOmWALfp7L0qP1hLBO/xmsy38ICSTJA2EY/M5RqrswL9
 GM3FebshWk6eRt6t+0dW6S0QEn592Pp2IDqvFVljVsxlRWZtB5JY1Xixzq23WobYSONJuOILcD8
 g83e0xb2FScvoWkw4uw==
X-Proofpoint-GUID: 4-1J4iRa7Nb_BzS1OOa5l2ihIupM_LkO
X-Proofpoint-ORIG-GUID: 4-1J4iRa7Nb_BzS1OOa5l2ihIupM_LkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41925-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 796CCD11FA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:35:33PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/qcs615.c | 247 +++++++++++++++++++++++++++++
>  1 file changed, 247 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

