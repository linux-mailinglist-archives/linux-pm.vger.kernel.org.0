Return-Path: <linux-pm+bounces-41691-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH8oIK9Se2nRDwIAu9opvQ
	(envelope-from <linux-pm+bounces-41691-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:29:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076BB00F7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0AA13011052
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AF385EF1;
	Thu, 29 Jan 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A24iaZuc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SOxNp4zN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAD33F8BC
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689770; cv=none; b=OIR62Qx5maiUhjfLSEayADLlYbfZ5aqMnUgJOQ+EHQEU7ZWDTCca2+nFpELWcq/C32+S68olVVBDHd7wtIFsr0X2I9Zy72Oxwe5D6ST7t5DO4aAPN+ClmDEuG2wsP1i/R3Dbh/j5OtSm53IKvrZfWuuD81ZIFGJHfZB/jZyQu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689770; c=relaxed/simple;
	bh=Zw9AndoEa0T9RhFboNwNcxTyO913HoPHAwMfMc7OTrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWYqZIoPIQU7Q+Ml0rtktXMOawiJEScwSnhM0GrpuYYYrr2ZJAujaCGptarysfYTUgiDMAfldigH/TmzV83AaaKzx5MZ+rIEHL+6OKbWVPPoXjKyvwvVVNafy6ePlc1lAHrssBGL1WWyF0+ImCWsyESJTa0KMGleB4DH22XZGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A24iaZuc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SOxNp4zN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T9s77S2060079
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bseSTjOPR1bRtBco40OAygrCPMHHvnjAqNPg5drYHlU=; b=A24iaZucrhPurdJC
	QrqYFeD4lRH9lZKWzRcPch1okboL2nJI+O6ZhecoJiUVu/EIfIEbQ19zrERiZXRP
	6cozdLv2Yqd2p+QGAdaLwiLdliKwnXnU95mxvIq5z5ombBFnWveGzX7Di0Vgnzxz
	OXR5Y/hT8WnozsvNrzETqX72winBvUqJzZzuBwTX4PFeosPtN2B0Z3/3aCRiEkBt
	8Lth59pqdquisSuWAvfNJaOcW+bg7EIcZ0cQfWJRkDevlMpy6aqKpb+v6Ipm3EAI
	Moks6dEnO5dhBYiNZQ37AxQifVIjZJIWqC7MmLnO53haFCcK9JUv3mMyxDlQZKfZ
	Av2Bbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypgrkc9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:29:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52f07fbd0so382370285a.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769689768; x=1770294568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bseSTjOPR1bRtBco40OAygrCPMHHvnjAqNPg5drYHlU=;
        b=SOxNp4zN1FjQD2A9w5JgIBfLzR2ly79T8TepJn0VudH8m4EOCanhKRzSsQD2KXhGeD
         4zOCrIlepei3MZQEZKSZ5oq3KyR3rI4Uatz/XfktTfrVwbnbWtRE8EeFJ8wt6AlsEiLD
         dGB+ypdGUPV8MOs2d6CZD5EuTHQmFKT0kxWUSRi0te0y8QStgN7mQCppLAcSCC6YNn4i
         6uCmrO38catacpPzacqdqxaak5PKc9+baDZRxw76Qcg2Q0f6jCanEj/2ihmUhwKKTl1y
         SniE/R7LZcgJ/8RSXQbI3EVXUwZbi/hFg3p9P9YyPgAvwf2EGyqaeDZqOtzIUxJ3zTyA
         fzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769689768; x=1770294568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bseSTjOPR1bRtBco40OAygrCPMHHvnjAqNPg5drYHlU=;
        b=kSOWn85Xzv25/NzIar85l/ualJLz9QNFosnBWxJa2j1FiocnDe+yUzXq99a2keAgg8
         32TGAyDLMvkx1uZlhGCMgLqQkUcZZIgAWzNYMAUG/fvLrXpieDyea3DeDiD1spwz4nSI
         wkAM/3Ir4WX4rElzjYg3cdZAf+z9cOub3CvPl5qs3qk6zW6+0w1YfQRtzbwPbfzdYAnZ
         JdmnstM/qknDg/mTnfWJiNarW/TAlQtr6jhBAuD7+gyeH6VxA+HeacLOkeBLFVe5IgbK
         1hVcx1BySOkbfYDNDkDLvgB249+5JVf7lBPtj/o8/JXVZbxRlmxwPe2p/3hR9BosMF8z
         HmCw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5CQuJcNwddfBtpxXb9D2ClKJSbAqmVFBFFJR9UwozPES3mV6lPG9ltgp+jPUjjLQKF/X7F7czA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0xqT0oilzKgMTS8UO+VG5Hyz6lEhkRLfu2uBXd9uY+14Tldm
	Wunk5drXR0LTQt+r2y2t/UPRw1Y7xEYxcyYG0WGN9ft4Mce+5RByTvVgxi3CIeXZrk7R3TAjf10
	6dA6my5cosxY6916lC68Jhy+6EZ3N1Gn3sBvCXtxfUOFwTxAe7i4g2s1V1BhBEQ==
X-Gm-Gg: AZuq6aLS/+Cd0gO+Z2hCzr+OqTAJEiE464Trh06V7NNpy7Vlff4FxeUpfaiJZnR+YwV
	vbz1HD9ksfa4TtrbdzFAzrTOEZHDUF91Xd9yAqWp3KVAQ+RTZQY/aCOHsFQoxVt1uWMFqKSGnOL
	i8KTwRWxJ7FyPEsVz9hZY6NUKuDqImQvL1/1nkMiDQDEQLNV/ukjRpxec6pDmI+xWQ0BhO8zefd
	IA06hOOPVzQj+P5MkzJj4NYh2b0peHdjcAXgIMwJoP4df2B5DeJMMSVoVYx3+K1/rbk79Rp9Lef
	NOb0jX7EftelMf3ytCy5Xwpbnn9NDEsvnG6QBVSihz9aq6aeHkmwDxbhtXXZFvqfvjJ71TIPoQw
	nOaeOk9H1AIhkJ+cAHsTSDHWsEHNHvDqR08I9XKLruRqrWOVsd24j3z39Rl+T5yF6lyBs8jGNQC
	DivTtmAtxPkpLrmjNfq70o+W8=
X-Received: by 2002:a05:620a:29d3:b0:8b2:e069:6911 with SMTP id af79cd13be357-8c70b90da5amr1046010285a.59.1769689767692;
        Thu, 29 Jan 2026 04:29:27 -0800 (PST)
X-Received: by 2002:a05:620a:29d3:b0:8b2:e069:6911 with SMTP id af79cd13be357-8c70b90da5amr1046006985a.59.1769689767238;
        Thu, 29 Jan 2026 04:29:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c8225bsm8413041fa.18.2026.01.29.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 04:29:26 -0800 (PST)
Date: Thu, 29 Jan 2026 14:29:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: lemans: Enable CDSP cooling
Message-ID: <stmlthovu36kyhhnn7s7rpn5l53chnvmn3lmyepzpg33o7hpo4@cnoknywqgry2>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
 <o3gdovqbkmclpmrhjtg3lknhqcecwfrp73bpbv6nsspzvkjfm7@qqkrzte3cdy5>
 <3a1b3a2b-d73a-4dae-b866-14abec2ff18d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a1b3a2b-d73a-4dae-b866-14abec2ff18d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=d7T4CBjE c=1 sm=1 tr=0 ts=697b52a8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=073ies5X1yjxOHlRSNAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: jjKnHnEmbIxJVxhrTtqoM71IoewIlr3z
X-Proofpoint-ORIG-GUID: jjKnHnEmbIxJVxhrTtqoM71IoewIlr3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA4NCBTYWx0ZWRfX9Wb3q9pp4MuD
 1wg3TcnGWrqxYRbSvKIdfXck4YVEmpedceekt4Uz+YqRe9BGVKTmAx3SSqEpX/uOexWs6JEKZW9
 0z5KXaC5B2pRNBYtMf4JY+1GMcNv0eUWXFu2ddFfVys3j9g3rVusYeFphNf+jN+376NQzFqhpon
 9FNXWghgbcJZTbKu41GODgxgWRZIaij2zVC63VQwU8+Dywo0iTPr57aGoZfdO3ym3cEhmKpi7Dh
 wixFPqzPxZJwITNidL7WUmXfkBLg6eYE24r1R7Tt7+eYfAqQlnEXZOnhrvO9KdhHSUECXZexcL3
 6JYp35zwKLv5ajajFxiexUmg9DWfw9PZe7Bw1LloFf45r5Ief5r1GgWZo+kF5zxI2Sa8NBACsfr
 mOWsltcrYKoul7k8rTGEnaMxrWS8YZcrleMqxTCmZRO//VCzrj+mCNtLmI7iAyJQzadFliav+Bh
 AnBK73hE7r19tkCAPtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41691-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[2a0c0000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1076BB00F7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:40:56PM +0530, Gaurav Kohli wrote:
> 
> On 1/29/2026 6:13 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 09:27:19PM +0530, Gaurav Kohli wrote:
> > > Unlike the CPU, the CDSP does not throttle its speed automatically
> > > when it reaches high temperatures in Lemans.
> > > 
> > > Set up CDSP cooling by throttling the cdsp when it reaches 105°C.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/lemans.dtsi | 138 ++++++++++++++++++++++++---
> > >   1 file changed, 126 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > index 808827b83553..c747dd534caa 100644
> > > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > @@ -7281,6 +7281,15 @@ compute-cb@11 {
> > >   					};
> > >   				};
> > >   			};
> > > +
> > > +			cooling {
> > > +				compatible = "qcom,qmi-cooling-cdsp";
> > > +
> > > +				cdsp_tmd0: cdsp-tmd0 {
> > This question was already raised. Are there more than one cooling device
> > for the DSP? If not, drop the subnodes.
> 
> 
> Thanks Dmitry for review.
> 
> Yes, Each subsystem may support multiple thermal mitigation devices through
> remote TMD service.

May or does?

> So, need to define subnodes.
> 
> 
> > > +					label = "cdsp_sw";
> > > +					#cooling-cells = <2>;
> > > +				};
> > > +			};
> > >   		};
> > >   		nspb_noc: interconnect@2a0c0000 {

-- 
With best wishes
Dmitry

