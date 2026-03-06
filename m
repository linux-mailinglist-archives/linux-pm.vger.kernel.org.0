Return-Path: <linux-pm+bounces-43856-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMSROLMTq2lzZwEAu9opvQ
	(envelope-from <linux-pm+bounces-43856-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:49:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A0226700
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39DB300C02B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106B3EB80D;
	Fri,  6 Mar 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYp/qJk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZ7qseKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DF3ACF0C
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819376; cv=none; b=BG5rdQnSfxWpVmUWyVQtRfVFltJBfDPMQcaFwCp6Rh8FRBZk7NtoARvkkCEkYetZ2DXWRwbKeX1CAk3jN2eNs6ft7YKlcZr7h+FaSR27yfGIsU5m4Tz6CQY6XAOnwZoamCxAiJDh4qRp3DlAE/fEu1vq3CaMGtTi9hCTzOlvkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819376; c=relaxed/simple;
	bh=StylOHeG4dKwtNO9a8/Wkfg+2eT+mXV3C4MSFPvNgd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEvGU0vedw9APnkr3QUUzI0GgCHJb64CqX40YDE9DeQpj1Tc5atGjJq+UXP7x+f4FVUKrhC1njkCnJ6gU+1r1Msrh8s6tHgBHd0CThTRsHHE+u+V6yeBvdgjBJAVE/RTMlWmPpxK07CxXGC1qLMq21IuFz0h3/A3GleboW/1O98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYp/qJk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PZ7qseKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H2PHd742655
	for <linux-pm@vger.kernel.org>; Fri, 6 Mar 2026 17:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M7FsIvsL0LpSvN0/enWDcs5+VQLiU32R2Q3/L52hdmM=; b=eYp/qJk7w729bT++
	uPCybevD3QWI12anZfouOBmgDHoGm/IXoAh+OE4HkFS2eV93mRdZruxQkHlsf1+3
	mxjPZHZ7pa14fW9c5qRQT7cKLmwdQUkvz2DSSx9LtZ8FDP/OSHk/oRgNalz7Kewo
	mJQi4WAGuRvVHt/komoZZ8Ivo29dZkjaN8bJ8M2KdqzXFkvroqzFumIfxhDO3DJr
	jlFX8Y40uLCZdfx/AdBJNTMA61YubfmQoqcsh6w3u5/AK0wW0/MneARu3w5FDh8N
	GOQZjnfyTXlng0qTOT37bHhZf6+pBKAFmBwsKgcsTcZvX6yrcPCgLPsBgrhMLJs7
	2/SBOQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqpxdttm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 17:49:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3a2eb984so6500024885a.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772819373; x=1773424173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7FsIvsL0LpSvN0/enWDcs5+VQLiU32R2Q3/L52hdmM=;
        b=PZ7qseKii2QH/juk0KNKhzhCnfsZ6qJXFNSx/wjOXO67JUOCkAEFGWKgWhIQ+QIHbm
         hV7//TqR/7kdYCV4xO7eREf4Hq1WMhf8Otpv4JrwxQgh9fS74rQL1ycsQKDEEyK7NMYp
         NEGLpvI2nlc453UCa5QjpigCgM5o+EucMevDTQJ69k+lrNJzvr8oigMMpB3DmpUZUFJL
         5YapCFgtIdBSKPVXdhx0mPN2K23cFSRgpYpmuYV98zVMEvIx26xVsq68TuwK2lYOmGv6
         AEY2AMkcKI8gfa0Bv83PiB4+KuDIK9QezH2Jz9LLDSijjOUs9wX6UpVgszDP8h15sP/B
         NiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819373; x=1773424173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7FsIvsL0LpSvN0/enWDcs5+VQLiU32R2Q3/L52hdmM=;
        b=VDmrOCcot4G2eBwlVWn0cBD11kOk4YH2b3IvATK85LhKL0AHosgfLmUXAI3jqbNF8x
         L31LBUi9zdpVbcwxX0GnWCeLdv7ECG06RMljxGA6tWxXqZryUKlUEY2viS2RqycOyNg3
         zAdcYxs/YRfmtdoqg1OAJu095VCpELNbYHyuQ6wWNMu4fwH4KNKolPG30DPLGiWQl1YG
         CZeehGk/n8cnFpV9Hvp0tIuJhB/hwOqbCRqn6ol89AxwPN684TFaK3OeVj/yqxi7ig1x
         QYUF1vmcubN+CWn5QCyo/UTKrK5TMNtUbdwrZENUyYqQ3NKJR2z1WmmKhinvSUKxKeLs
         3cqQ==
X-Gm-Message-State: AOJu0Yy1thV/Kal3ziPyJ15Nd+m5LIXq+ZjxwuUBj0JRGCYM22ez44p4
	+dKLBmxMYEMrHVU5nx5D6IxGhmrofVPUdWRPdhSK3afHQ6+leuxv7h38rVD6CfLp2XXPWF9v+tU
	PqzUK3NDmI6NfaQnExAE+6csnlFRJynO3v+bJWFAz9orum+P5AMuQ/F1GWjj1Aw==
X-Gm-Gg: ATEYQzw0u2X35Qyr5/11CyNAhUrc+6RlJOoGkfMDIUexYGbBmYI0zs/FHshEN+VeTlu
	RWc4zxm8uucZM6/xX3pvFjIbQJtRxusVhKp8GW702ZFXVzc73EuaQSCY8FRSB8vpDPEtK93a6UT
	KVj1QEL6P9Ds2p6qypx+OyQbRGBRszANd3bcE2ae5ymgwW6FsyTF7/dfX/bDMgEkdJkbzYW1CnC
	ve1tNxig+grH9HaKlPu9J5BWKU1hj58cPQCRBcGgHaOwiMo8UHI5sjSCNTuWplBSrGCrEGGkAO3
	JyMhZCN8tFa9LO/v8GPiZit/D8kWkynr0pqdaD5FGDhJ/Bv39rSFfepL85xbP9hl0Q4EeFJaJ26
	UYeSaF2B9W8l5NxHOu6GxsLOmqMEdjD6JF0OiKWxuFJPHGJafjR3z6RnOzm6JP6uBsY8jmQ==
X-Received: by 2002:a05:620a:7017:b0:8c6:af59:5e28 with SMTP id af79cd13be357-8cd6d411a4fmr397983085a.22.1772819373297;
        Fri, 06 Mar 2026 09:49:33 -0800 (PST)
X-Received: by 2002:a05:620a:7017:b0:8c6:af59:5e28 with SMTP id af79cd13be357-8cd6d411a4fmr397979185a.22.1772819372861;
        Fri, 06 Mar 2026 09:49:32 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1265:158c:17d1:c76e? ([2a05:6e02:1041:c10:1265:158c:17d1:c76e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm55370445e9.9.2026.03.06.09.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 09:49:31 -0800 (PST)
Message-ID: <a32c708f-b1f8-4928-9612-9b0d0e6c8d99@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 18:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/drivers/imx91: Add hwmon support
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260306133017.3189979-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260306133017.3189979-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uAXg3HBzW8SE43sSXfQ4Kwti5HR-AE9z
X-Authority-Analysis: v=2.4 cv=E83AZKdl c=1 sm=1 tr=0 ts=69ab13ae cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=8f9FM25-AAAA:8
 a=65OyoGoUx_vi4H7YfAoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2OCBTYWx0ZWRfXz1UF1hvoZjGx
 q1nxJ5AF+3HcybOc0OqQMj3u59xyrIYNvUT0FxL7Knn/UTqwbST+KKLlFFyb7E9xftXERPGyTIe
 ww1j7K0aevhomtx1EGxcfgYh75+iHnCA0U1/I7UIworJ+2eUs/2rWAepNWQ5aL1HQWPIc863uOr
 gtVH4JhMTA+Z+EPzQ8oLBvq/5LhdbP6Fnl+uWGNPd0QpTeyLVPNCoydiIJd9ZareqCQ3811JyhD
 7KN2JNZVDjZ/7Z42sVJbEON8ExvR7R6oArUX8daJIw5l32hn0pHmIPIRIE6cYLt32JY8YwoFmjI
 98WO+NU/xXyfphi+ScmBrIp5aFq3GZfaWcIfoS+IB92RySTOxKCM0LnbqppcZ/JowSG4AFkC480
 Ipqsd7kmXZZsZnr3vOfOq5hwZzQy7wP11tT7XB3qidMKHY3G3kMdAKbwpjl8zPXbNn1aqxITPGv
 NKkyER5aQCkmHIVT49A==
X-Proofpoint-GUID: uAXg3HBzW8SE43sSXfQ4Kwti5HR-AE9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060168
X-Rspamd-Queue-Id: 880A0226700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43856-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ew.tq-group.com,kernel.org,intel.com,arm.com,nxp.com,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tq-group.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/26 14:30, Alexander Stein wrote:
> Expose thermal readings as a HWMON device, so that it could be
> accessed using lm-sensors.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied, thanks

