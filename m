Return-Path: <linux-pm+bounces-43111-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCeVJe5dnWmxOgQAu9opvQ
	(envelope-from <linux-pm+bounces-43111-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:14:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149F183786
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36CA63135EB1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94195366542;
	Tue, 24 Feb 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0dmDTi/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4j7AlC7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF55366060
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920619; cv=none; b=jqkMdpivSlmxj2ya5BSi9yleNMuA19QLAExE3my9baAW5qYwgNUZtT77qYuzl8uE5hAayqZ/vTvl9+S59fW0J58T1g+9AYYHnTESmapUyaVxPJ+j5SzLDU+N27AHlIllMNm6GexD4y+8JuOho4sBDuJQ52w3EpB/LmTRHoMAgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920619; c=relaxed/simple;
	bh=qYVi6UpYDZWUvVX7mise+3Gu9ph4AYcoIwRD+5oqduA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGXuHTRu3BUOA1aV6Gk+bSmMbuayMNI18iFB7Mdo0yyXaYSI/TNjl8Vc8SckgMpMmJO2v3xkaXrwh/RnLzBMaP4JrGQN0lmjx9h0z79xD6/QrqVlj+JngPpCrBy34f9Z7eF0PrFmkt6dtU6O8sJK19plYM9kC0kDcgWnqd5Oz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0dmDTi/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4j7AlC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LipL2808544
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=akfh5azzDqif5zPoRlnXnETK
	o7tY79FJ80obZSfZowQ=; b=X0dmDTi/TNbDzp4nARzZPDAuuCjz8TyVX0z0seLV
	uhjXfCA5vyRUp2dtvsOOefB3930ilLHDEGeLe1aplBPgjpEybTa05jhuQqxF/s9f
	7KT86wn/e3l+0uucl90XQQNQd5WmksPlZlJPaxWklnxIm0iE6ymcTEDtmE5OBoqO
	/IYyz3uTB/SprJjuVb3V+k8atv8WzVBQlifyJ0wNQWA7BFx9MGxwXZlzqUSnI4F0
	visi726tKWRH8XczoShtcNYIPf0K3SrjvMeatU06yOhGRqaSRqlyBVyGHQ8JMhZ/
	lmGJUvQ0XXecOy6YtCUguNTd5h5rOpYHGuYrhEmWmJqkPg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8rbe4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:10:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71304beb4so3512080985a.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 00:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771920616; x=1772525416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akfh5azzDqif5zPoRlnXnETKo7tY79FJ80obZSfZowQ=;
        b=e4j7AlC7q8KMEIK44jRQTlNeIxivWlAnZ1mqg9QykNPcBkU3ZG4DTZHxYrC1L5i5e1
         uDyiA7WURk11c8LpxzEvOxEfG6GNg3LZhGBMeGKj0dcJRtXSMkdMXu5xy8R8c+0/1aws
         mnM67Xi0o5SWaqSXtiyL8LLdPuKmrZyHiMbQ6VKs3M4qrMV2WvSPUnXBkGqhO4nSkofm
         OSdFUz7YwfFBxXhpUl0jcyuoIH7Uolqzx0wd9phx4E4h9HNAe9t+d5h7BjFluhPoClnT
         EeRY1FxQ3nQACsPEtbC/DYkg86VeLqgOHDvbxCSAUvXTgtoWlBEby+4lZNeEZZCLpLCg
         Z9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920616; x=1772525416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akfh5azzDqif5zPoRlnXnETKo7tY79FJ80obZSfZowQ=;
        b=c4RxEgTEKXmQv0b6Hk8xW4g2NsRmphvuQms8OAfnPqlXirck53YKfS3mBhMm1q+FAO
         uc/0R+LrEGjkfGMU6dbznNqSt8BIzFiTmYhdjpUEMDvnCbTbo7/gIeCF1bU0Xm+pp8oJ
         e6dUywRRNcBqOGnqZc28NeTLss6cKqqbDcp5d7X8k/uC/yeiFls+igHIDl28wnz6F9hr
         EQEqjjwJ3I2B7Ce64If/KnA0ri/JMmf1UAibeNhGQHkYgG83nH1ZJdsLej2dtgy52pwL
         DWYXsO/ExqyCP9geqViYWy3zRFRb1Errs2mZZwgmsj0qelqCdW9Jsa4B2wAJLC0UmOVI
         ogxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWADSqNIbtq3qjCAuvJanTs5kEvIY7HnpOdrxqUxxdroL/CrUlpqZAqfuHUMs44mZcOw5Jv4PKfSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWx/xxsR4KTHvxB9fP5M2Cd4LFbHw3BTn7hnd6I9KKJ19AKh3Y
	jcGtYzwVQBHMq+VdpWqHHzye8sZligCQWERcf65itNmXlmyBoFr06gPHZahMiOnFSOnD8javhIB
	/RGYP0q/kQbn3lhe6DaMMgLt/0BKaxXbbguym2Y6AQRy2Ak9cIUwIyMeIbiDTXBeAquEoqw==
X-Gm-Gg: AZuq6aLBlC7JxajhfcsNYK7Fy8bxotSbGcdZ7tbvMwP46xM6e0nwZWJ3bOY94x2X8vz
	pM4MBiVT5eS6sWvbMx62TUyJrmOnvTd1uNrz8I1nitvN+V4VFYLRoP6BUFnsGAkbb11HDeYfi2S
	9WSL0/X6qGR9l5jd//K6ZOhn61XOlFQadomEXzNdYsoFc1mXpqRBxyUseSZLAhlObLWJtI/u4xB
	ik/5R8ERB4oHAOn2ZoKaZnkqc173VhJeXRodzEcS3MyVDRLiErfVK7iug0gUPv3QtspHcZWRb2K
	FUqwzTbkbRQJ3bqRhZGm4xHHLNhAw9sLy3yWTiGCnu1MlYInGTjM8LIBwLUz0jtyjaUM5PazCeV
	aaJ+7OH3+NLP5wtxvouKnFIbtqSG9zD2HMZbB
X-Received: by 2002:a05:620a:4449:b0:89f:5057:974d with SMTP id af79cd13be357-8cb8c9cc32cmr1357404885a.10.1771920616007;
        Tue, 24 Feb 2026 00:10:16 -0800 (PST)
X-Received: by 2002:a05:620a:4449:b0:89f:5057:974d with SMTP id af79cd13be357-8cb8c9cc32cmr1357400085a.10.1771920615132;
        Tue, 24 Feb 2026 00:10:15 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b81f8912sm19461595e9.1.2026.02.24.00.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:10:14 -0800 (PST)
Date: Tue, 24 Feb 2026 10:10:12 +0200
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
Message-ID: <2dnws4hpakt4oxhbfpcnu5ga45mmx4fjxexou2gaueiqaveeyn@itiyzldq5cxr>
References: <20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com>
 <20260224-hilarious-tasteful-narwhal-c492a5@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-hilarious-tasteful-narwhal-c492a5@quoll>
X-Proofpoint-ORIG-GUID: PrkjU-qkHY4Udm_rkN4X-LOAmbxTJzkJ
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699d5ce9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9fn_TuVGXQWuGc_kkjMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfXy1CRnj/7eloR
 ZyYHIRsCNdKwpTGWo+KRW+IQccYTBMOYOIrOS8T8EAG6wBZZ5elIWvLsGqwDSinD/Wop7rTDZ99
 lsrUBljdRLEtYmgw/XPZdcYoL33XbZUa46owO9Zd+2Vpk1Ay8YGVd/df9ndtY3Hp1HbJSuJv0V0
 mehNCPstjt08r+muclqE1ZwEcnxuMG09oTVpMvt3ZupY5+USAtaVMj+xBbYLK0pHCPGSRD3oEel
 8vERuQquiw7nWAy+VIwM7oGsyWz9beaK/o/s+L9wYBn7yz9oUKCDymh9IczeO0bsMBMUoqA9F9r
 ggf+UBlsh+0Zpf37bKCVAE+EFvynyQhr14mCTjrlDk5gSztML/vSstO8tKXMWEuhLC8jNWi5Ulj
 RmAAnmtGPpmTF+Qe5UQwb3ApbqswZ4aAEbFYu4S+dYCicIo0o9Udgf3GHSd7Oa58eO5x7N0r5DN
 huEvlfUpMcw1jFqyvlg==
X-Proofpoint-GUID: PrkjU-qkHY4Udm_rkN4X-LOAmbxTJzkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240068
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
	TAGGED_FROM(0.00)[bounces-43111-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 4149F183786
X-Rspamd-Action: no action

On 26-02-24 08:29:09, Krzysztof Kozlowski wrote:
> On Mon, Feb 23, 2026 at 10:49:04AM +0200, Abel Vesa wrote:
> > Eliza, similarly to SDM845, uses OSM hardware for L3 scaling.
> > Document it.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > index 4b9b98fbe8f2..6182599eb3c1 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > @@ -28,6 +28,7 @@ properties:
> >            - const: qcom,osm-l3
> >        - items:
> >            - enum:
> > +              - qcom,eliza-epss-l3
> 
> I see EPSS, not OSM here. This is also list without SDM845, so I don't
> understand explanation in commit msg at all.

So there are two issues here:

1. EPSS bindings are handled by the OSM schema. I believe this is by
design as they basically do the same thing. Interconnect providers for
L3 scaling. So the compatible is in the right schema.

2. The commit message should've said SM8650 instead. Will fix and
respin.


