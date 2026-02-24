Return-Path: <linux-pm+bounces-43115-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOCJBWhinWksPQQAu9opvQ
	(envelope-from <linux-pm+bounces-43115-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:33:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBF183CB4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864B53031CE3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4112313543;
	Tue, 24 Feb 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAbBfwva";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HyxABrLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D51366827
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921937; cv=none; b=tJ/mjCV8t3HINqNW6m6pxIjUeOsOFqC1qZMHL3ky9lev0MnTpKEYVYzWL4S3brt49blvnxmpww0I7yMqCkPg9HlJlDazlPW8i2a7UyY/jtmIYSeOynuSlTenw4gqkKFQuccFIGyhCu585utS3VgpPWJNWB506IL1GsceMxlFMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921937; c=relaxed/simple;
	bh=6RCrh616U7vYgiCSgrgXGgoZWHtvW4U7qcEBUGz0fCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEtLcuiGSSJx9extaXR5pLCijiYfZ12bD+jfklk1/o0NR3XVgY6D3gInBnKYXtLle0f2MxqoS4+fYyQulGBTs+QjYteZywKrI4ApEtXvXvX6aBkAaLIJgfqPm4X6VSwwCYxvnm2zZ1Prqu/Og8HhEYKhIJSOEphF0PpL0AISRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KAbBfwva; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HyxABrLF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LTAQ1460161
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+HNa961znk3JfzZLWEYNK+x7
	vHC2NAm/Djus3UwnZsg=; b=KAbBfwvalSpRulAeu9ys4zttIx5qGIFPvvMAq6r8
	sm8R6ehZcP6y7jD/ZqRexJIPi3+1y8UcmNRCWtxt0P8Wx8Z8X9cLcfjXJvKjVoeL
	faW9vxVKe3+wUYr4vux8izSF9ct2vOeITtSZwZBFTbrYC8AB1FxW71B2kzpLKC4U
	nEO3TdNWgFGxQHCJuKSTuquZWbprbz7M09qmH0HHkx2G3k8S6wrqu//wM5ovxwQw
	nx6zkmowgFVf71k79Tuy3PcSmvLPEoImRDtW3EuXwwz/9N7K9Z1ETO4vaCNOgzky
	yq28NtNtfmbEV3ZSqd753I775srAac7ma914pBFkssqmgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e38pgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:32:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c881d0c617so4474518985a.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771921935; x=1772526735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HNa961znk3JfzZLWEYNK+x7vHC2NAm/Djus3UwnZsg=;
        b=HyxABrLF4hfTaODQWUjATC3F1cj9Udtx+sg3BAjHLtwbXU55DTHrFC9SW+R10wpifH
         5G+xUMd9ItGkdJEqVBRNEzxS3rBJYJqd6oYYs2IZPHu0FIWAa42enRX3Jgr9sSFh6REZ
         kFiGxb2d/cXagyxEvs1vUXZk1lyd3VOjs8AmNdAQoVWIkGhUYTMj+0iDbcTbWyK8vM3r
         qvdzeSJxSBGXVcxQpp5CJBqwF+J0IzkrSo1zogxxjrT26I9SLyqSo93bwNi06ilyn0ot
         xcnXC29kgkUvUiZbeWyzcWhY6MiRFDRCADPaloUZsOywCDhRMNV1Vin7m6zTN6zJsKmW
         lT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771921935; x=1772526735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HNa961znk3JfzZLWEYNK+x7vHC2NAm/Djus3UwnZsg=;
        b=RoKibCz4+zrlCGOxQWjYHZCqstZ+Ik4Ap7sAI2jNUdcuPuu/7sIf9IG4whRgbjpltX
         8UOwIPXLzo0yQIxd1bs8CvTCfOivDNZO793ME5z4t7yRLm0J07pf+nYDG5oXzSzN+wPL
         LvGL0FuswCwPT8dzIfq1koK1B7iHPpSU0mizHSqna+7d4ZgdZtvI/YU5Wmr2mojMcvdy
         AIPfBeDdhL93TwLzmANu1GsKMYnYgYmnXiZLkP0l+j1n2/KgLt+0ut1tW2P2Gfgaouxw
         PGAfJ8JK8xHJwsyb8SU6PRCvEVucE2BcZAF+ne8ycXhI/9SWToTL1GpnB/M54kyYZFWu
         Zedg==
X-Forwarded-Encrypted: i=1; AJvYcCU5mDOqC0RXN5ZtM6o5f/Am284mFB1nu3SQZ/wnbbj5oAPbDtPpoFpVes1tYfRXnFsRJLCOAB3sgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHFnbxWvuzDMkJcL/yI4f3dltVrnDGUAaiyccOpXhBzG+h1jc
	4jkN5xEpleFFlc/C8NUogRX8JBilXXliOe00ni9Tf77rRbX75PIdjdCKvvuLaDDX8fUe9PGf9Qk
	0VT2am4HS7LquYL3WG1VSxTpsw9zGBiJYYHvIsIo/yH5oLB0NY/AkxQnfk96i1g==
X-Gm-Gg: AZuq6aLHQ3q/MJwdEQ01ArN+E/knQH4xGpTtKnEipSPsVvCHt7YhhywppP+dvzP/MFb
	AEDEsi+Shv/XwUo34uj6SS+6ssmNmBgF2Cv0z/ZJAB29mAWkI2HgMXhaUVMhs2Rz28r/e8jdBO8
	UkDZz6ozy7W78rlIdzin8DWL9MwNIO9lJa9hBMu2PYOpzelgn+cjTYoWraN930bW5i8ETIUbARb
	o62nOVEQF3tR6ZTnbPQXuwlH2NjbzMJhnxLRkVY/UAxFOVVKMb3E4rttVyAB3WxSaBdmmgVUAbV
	X5U5bPELrVyE08M0+bGsg7z9Lia+eXtuqkD9nrFLqIwRqVkyYXeWp1I5EiltzuxVgeUtPoMqMsw
	cYAUhYf81w8SNly2ZQVTSjgHMZ2it/aS9BZ8E
X-Received: by 2002:a05:620a:c44:b0:8b2:ed29:f15f with SMTP id af79cd13be357-8cb8c9f3a90mr1531725485a.21.1771921934839;
        Tue, 24 Feb 2026 00:32:14 -0800 (PST)
X-Received: by 2002:a05:620a:c44:b0:8b2:ed29:f15f with SMTP id af79cd13be357-8cb8c9f3a90mr1531720485a.21.1771921934106;
        Tue, 24 Feb 2026 00:32:14 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb4bb3sm250878505e9.14.2026.02.24.00.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:32:13 -0800 (PST)
Date: Tue, 24 Feb 2026 10:32:12 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: OSM L3: Add Eliza OSM L3
 compatible
Message-ID: <jpce3oli4ngfrt7hk33naatjvlhjkr4j7vzo2uf5uux2dswcoi@fs6lspkitpbb>
References: <20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com>
 <20260224-hilarious-tasteful-narwhal-c492a5@quoll>
 <2dnws4hpakt4oxhbfpcnu5ga45mmx4fjxexou2gaueiqaveeyn@itiyzldq5cxr>
 <08471da2-8577-4114-ab26-bcbc81536999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08471da2-8577-4114-ab26-bcbc81536999@kernel.org>
X-Authority-Analysis: v=2.4 cv=DfIaa/tW c=1 sm=1 tr=0 ts=699d6210 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-5qs52AMC2amogaWbVkA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: zScL2PHxwK6xfMrJnF7IUfxoVhQw5roW
X-Proofpoint-ORIG-GUID: zScL2PHxwK6xfMrJnF7IUfxoVhQw5roW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA3MCBTYWx0ZWRfX3kAZmaAJXCBX
 ucAgJm/Jxg6/rn4+I4T+hrddplUtOhG7QIDqI+l4qxWMCtrD3sGDrzaVLK/nwJ1K7lJdIARQI22
 8lINkLK9FGB9ewg3T/KX2B2UmWotjWAMJr0Kghwi/2s6Omn4Pasfnos9V/txq2Wn1Md+KUJsJ46
 9KxRwH5pz+qtUewVdoc2ycDvLkcQAnedT5Tk3BTtZwWdwYa6nGTvxiOeVYcpHkUqyHtF/5WXLCU
 L383UfbxTGGsJgRLQ1whjqHAxxryOhmA82Rmez9LO3mn/aORcwomzUGiNp+kcJZhFNFY1pI5jVq
 8w9J8xM+S2ke5iyR9jN9xE8VrNi5bT1F/UucV63iYVJkNBWsvPbLEfSYRBVSXDmQa0RqL7DBkqA
 JN1qiLWO1HmJDXc1ESzRd+qGF6v/S69pwx+DIRyyk6jSnmR7vyuZ3YKFpbdoc/rigcmT02eSYnG
 DpLXYuF7/MqONbDbY+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240070
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43115-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73FBF183CB4
X-Rspamd-Action: no action

On 26-02-24 09:14:01, Krzysztof Kozlowski wrote:
> On 24/02/2026 09:10, Abel Vesa wrote:
> > On 26-02-24 08:29:09, Krzysztof Kozlowski wrote:
> >> On Mon, Feb 23, 2026 at 10:49:04AM +0200, Abel Vesa wrote:
> >>> Eliza, similarly to SDM845, uses OSM hardware for L3 scaling.
> >>> Document it.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> index 4b9b98fbe8f2..6182599eb3c1 100644
> >>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> @@ -28,6 +28,7 @@ properties:
> >>>            - const: qcom,osm-l3
> >>>        - items:
> >>>            - enum:
> >>> +              - qcom,eliza-epss-l3
> >>
> >> I see EPSS, not OSM here. This is also list without SDM845, so I don't
> >> understand explanation in commit msg at all.
> > 
> > So there are two issues here:
> > 
> > 1. EPSS bindings are handled by the OSM schema. I believe this is by
> > design as they basically do the same thing. Interconnect providers for
> > L3 scaling. So the compatible is in the right schema.
> 
> We do not talk here about schema or bindings at all. Look at your commit
> msg:
> "uses OSM hardware"
> so again: EPSS or OSM.

They are basically the same thing.

Will use EPSS instead in the next respin.

