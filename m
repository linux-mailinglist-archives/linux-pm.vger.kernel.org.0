Return-Path: <linux-pm+bounces-42548-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENzLKZqtjWmz5wAAu9opvQ
	(envelope-from <linux-pm+bounces-42548-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:38:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C312C93B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69E87305421B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B62F12A3;
	Thu, 12 Feb 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAwf02t0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hd5sJTIs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE52C08CB
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892685; cv=none; b=RceLkiRfiIQtcR64siBpcVd7jEeMtlUVFVVF1CSoAfFJpEqWb9Lc9SSUxRmKnzw7LiH0pFyPCXAznIvtImveO6FNdaax0SPTo43LBuYfIUN2WckeTpYhWfC8Pq+lsIGQORohBUyQqPSsxiToNvxrz151zZQmUINUrmuxzfow3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892685; c=relaxed/simple;
	bh=dzivrYVlNO2Gn+ga2q/0v5yze+ovu0iMlHs2iGufm0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEOr0SG1VmlpgmOOFV8Y6zLr1OUMWSqU9SOcie211lFhUzyL3rDkF0iTOlFa0npGF1fzS5Zzrgk3kE3nKCaZ9TMy7neAKE959Ha8pRLLBLQ8UIsWJhV6f9EFgSzWgy8BVnbpJ5KU2NfM79Q903q8/u5+DUKwDLiOE5HE5XHA9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bAwf02t0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hd5sJTIs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C3S0mL2545139
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 10:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7E6S3bjat2cxjUHSftIQdUL7rqVbAfh3aOYtI8Y17Ec=; b=bAwf02t0MyG/GtM/
	2g2kanFqZz4clxYE+FH2QDr0kGthcClGfExw8901dlMkSAplHjrIXaTD0JsP4zOK
	t7cDqPR7WhG/ZldIaKKffFt0u6xRQja+/u9AYNabAi9NJFTCOSgyMTNdwYZRWR9d
	hGigQzCH9sC3ZZB++jyhQyaDP8GZX2QANqeFNuqBl3kAVAt3pk20y9BCfPY5uH8k
	AD8/cnim/8IV9CYBkLIJXuOrayhc7dXaUiyBZDwUnugAT9dd6Ivn24U02TAp4CCd
	ONdDp8XbaPPYqQETLc9ZU4sXEaxPXK/257Z22u/0ycuCfHUYP+DOj8OV6Si6fHoC
	dZN2Ug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8wtpjxdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 10:38:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb399597fbso6012685a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770892681; x=1771497481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E6S3bjat2cxjUHSftIQdUL7rqVbAfh3aOYtI8Y17Ec=;
        b=hd5sJTIsxO49OlJSH3YkIaz/sGlcWKGGd2jYJP5uTLUXdBoCqhO5KbBBidrRgTfnxb
         KpqPWGl9bjiO+bJcigt2jpfPj/Uhd33WA3mGsZKTtf/VVh8m7fYH3p3qi06KBg/qfxKN
         U8N8aN+90m9HwrRXabIchB9Pj4Gn5mKPZktyw0PUMs5W224SpbsPj1GvgHxnViZaQtIF
         w2xRusA0+QLuDcn1Ja0yGH9Fugpghb1dwqkoIB1fXW/1hnmED8MPv3oNRqBwy4vC2u6H
         0l6CABRzXChVq0pm/1FdqNO6fN/UYUKpmiWHkEssHUUxN+OVRbBoQ9tOf8H1IJil3z8K
         vEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770892681; x=1771497481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7E6S3bjat2cxjUHSftIQdUL7rqVbAfh3aOYtI8Y17Ec=;
        b=sCP1LTkXYywqTiMvUyVAT/VRMoLzqlRW9na/T7u1/1J9vYVSjOgV8uTkXeYsg4/zqR
         bozvqkxVtZqgUH5WzyQELdMfk+meI+Lw8V267aIZvXep/7v+g+Kjd8o6yKaxgo2lD48F
         yw55b4ga1PKwzD7L4UFL/GYveSDwHGkuO9F2RFnFa09FX5XtyV7geU3yAwAitfjN59Ln
         cmcyHRVJDN7Msv/0GDnPgivAVDXll7J/fAbIRSUWlY3qFOw/szFm/ZYMp0qpyW9RUpX9
         I0ZDAZjx53NfNIOufKIVGtvNL3uqyd/T966lDMQ5JBC3mf8YTptpvDdrlPFUIobtkRxy
         MX1g==
X-Forwarded-Encrypted: i=1; AJvYcCXbXJBgDw7A5p9hSF1aVZqjqgKv68uML2MgbXBjJRZ4UZIie42k1MVYN/CrJ+E+n0QEH6MHhxymnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYrw1j3S8Nlj4WNCS1vM1pmFwvDHlu1UUaogL+f/S3msnwuud
	uOEL/UZyhzVYRwpTy+LL2tUh3yv6Co6XoS7+u6zkFinN/KAV4SNyxinhyOVlL7Umc8H41csp+Xg
	qmlkrdSIenj0hVfFbIjgxJi5yZI6+vXm4T6NipLXJNYaesWggdGdl5bFBz0Gaaw==
X-Gm-Gg: AZuq6aK3sFtsx8ogmbLN0NYQEHHRqM73B/c0w1y0qCBgB+2JKG8ZP7L3f9ZUCgiIxe2
	G6bzmLNEsB8SQFX41Gmqo/mVWX9HN//qSHiNVe9Fgjf3dZLX6KoYgpc4d0NXfUBZtjy2e1lJ63q
	SS1yOB3S1ExwZhdMy5T1io3pj0qN7H2sNI667RjmlENVqPIS36dxhucp0jwzSnFzZGGCYaww1t5
	iJ2bHEPaHXWpTcIizZAPLUvQ2RDJ+GfePZKrbEShHtf5RkotxsSWZaCiciQ+83a/XoKIq8fqmij
	lGK19xBh1HBqZY8uSJgzmtFO6X2VmJfvFKOiHjgfugHht7QXrVDdDhWN43MStE+htPYy8yLeJ6T
	s/n02IdrU8W2VoJSjB0HiLbYbs3ZyIUjzA1xkUDmuGbkTF2qiyp1QGb75UjWruiUTywGT79HvO1
	4jCG0=
X-Received: by 2002:a05:620a:45a2:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cb3311bdc8mr190987185a.7.1770892681170;
        Thu, 12 Feb 2026 02:38:01 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cb3311bdc8mr190985685a.7.1770892680703;
        Thu, 12 Feb 2026 02:38:00 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65a3cf38c5dsm1643228a12.22.2026.02.12.02.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:38:00 -0800 (PST)
Message-ID: <e7d77381-4e03-47d8-8583-3724f50291dd@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 11:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: talos: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
 <20260211091112.3285626-4-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260211091112.3285626-4-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=baxmkePB c=1 sm=1 tr=0 ts=698dad89 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=QD8XKuxi8VSVazGx0XQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: u07Z2Bhz6qgeu-uRcS-R95oe_zGdBK0t
X-Proofpoint-ORIG-GUID: u07Z2Bhz6qgeu-uRcS-R95oe_zGdBK0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA3OSBTYWx0ZWRfX1liR4F5WVTOM
 W4rvvB4Dt50thEID+rk6P6mXtQ1wK5P2mRh9Hgj3ff8KC9Mpebqu7VIkOav2gmoidaEJuf7Fuye
 FU5nkHfBJWs6MdvDrSnLCpdyhfZq5400Af3sSQ+JeyHDh7hw7yDmcFj5HdH+ZJwAtzlvpa3JSdD
 mTw+7PH8jC4oPB2mVUeoASLlQJoIlYiPQwVkSnF2K4yV5RZJvC7be9JaI9pv9tQ9uJLJtOdWGeA
 FEuntr7bT0DZr7yfG4j52XY6AL+4z0Szbad6RkeReqZD72BuvXSEXTzzDSULf689BvYvvkRZqPD
 Mv+WMkZJ9vLllCypxWSmv6m85/f89jdI6oIKfmVc29qJAf186GXHAOYjlbq5Jg6PFWditkR46hF
 i6e+rKOq6Lz8chTDPHAr9aI5Hng6VjYuPRrFH3ePrwV7dLGhQSTdJkrt9Rbo1Fmp7cc0eqvGW4F
 jc/17mnZEqKv7l0/Ziw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42548-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F9C312C93B
X-Rspamd-Action: no action

On 2/11/26 10:11 AM, Odelu Kukatla wrote:
> Add clocks which need to be enabled for configuring QoS on
> talos SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

