Return-Path: <linux-pm+bounces-41742-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKmSNXwHfGnfKAIAu9opvQ
	(envelope-from <linux-pm+bounces-41742-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 02:21:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD7B6231
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 02:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9592C300B126
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0532FA18;
	Fri, 30 Jan 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTBUgMxd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S+6ZevrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186D26B973
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736056; cv=none; b=l+xJahR684wt3wGwuVkcTcoFUmOqrirCThKw6QwTyXNB9vrt9+zoPQn5MPgaX1NFvLYE3T4s1gdfO73AV5r0nKgTyW43VBAur5Q1RkBND9EuRJfBttiGjYPiylb6ov9eCRaZgtSZKgTNIAE61l9vJNjo0DK4RGKA9W9utDCXLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736056; c=relaxed/simple;
	bh=aV9mNGX/QgwIoTLNO2jlS4Amiel3Mem12yLf3mLvol0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAe6FX2rl7T9DbA6V36x4YVCSPCwe6xlcjp/Lnh35n3MnQUCKVup/EqbZk46r7ayAu8LJJFpnrjwLbWyBrtlPkEotf0thaMpRCVOQcHi+S02z/VBA1FApzVv6yy0v0UCZh4C0Ikv3dn45ZniKBwEmEpLWFPeBxrkoecViEMcmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CTBUgMxd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S+6ZevrA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TJqu4H072155
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 01:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PoTbLF9kWs00/2KweNE2sFqCe/FXLyrVNbOL4WgTYoc=; b=CTBUgMxd7XktnKNK
	ijgl5aXG5tROYNsZIynJjRa+EpwGwxtVfULLwTwgA8HuciAo7gslg65x40HGJ6uv
	35Dz5lrwzy5yMtXgfVIMsoF6KmXFTCJmV3HRey1Vs8pl0XplyjKTRi8BCoN1RPtg
	B35Yl7SRa525QKK1WFFpuBVCr26SGCa28Q05QzuV1uDEYZxpx13/h2ybUQL3Kj3p
	UOYQMINBooXR9/w4tIQBNe45MKzPHA1IsZedSbx52bF90wRcH/8WAlkM9aeInAIy
	9i95zs7SsbZaNR9sAoRcgEo5pVKP2cYs5WtBu9dJIhO+RHvzbM+Ng8h2A003tckJ
	3EMW1A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3k8q6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 01:20:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f568048ccso1953982241.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769736053; x=1770340853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PoTbLF9kWs00/2KweNE2sFqCe/FXLyrVNbOL4WgTYoc=;
        b=S+6ZevrAuyHUclOr4LUzujE6ubsHy1dD4RGg3Xo2+f9YZhwv9rrESznPB9oetY9SuH
         54JjJ6SFGcoLSKnpfEW44pfyhYAvmSRmc8wWxHvB/1+YXm1Stg624sNTByHHxqK9PE+q
         H1h+Bvlocl+W/RIA3XAQEDWnxiB1wFlxPRlrzO2m/nEyhtD8YKLP0nJ9Fjt0ZjrNNQz3
         2zs3N4RlhWxN7ClGcoWCmQdiIb8pt61G68u9NRN0KyQtROwaIritB6nPWit6Hia8TuZY
         TOJ+PFoN/QiJ5ZpZXHGNmOi9fiWK/82oGucvo5+cbBTQOFF/HzTeVrmig2eRY6pId36Z
         rXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769736053; x=1770340853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoTbLF9kWs00/2KweNE2sFqCe/FXLyrVNbOL4WgTYoc=;
        b=wfLEyYzNPZrJUTds5GVCY2if4xC+gu+ZqsQfi9uX3GK24Blp7r0mi797nOu5c02yN1
         LLRYbclHu3Lxf3McmZUUckfU/++/mDxa5PPT1v82uLT2OoVDwiAsqAn1pyd6BSUu1qoH
         IWGZqVXPxdWJpPkhnj4Hn/p9VfvBgyYhQVUepy3hZOfHmBVL6emOOC9br7YzgfA2iswd
         fO+IDAUl6cgPCAnW39cNKCWXX8fAisnGzi6oaTqBjNp/5lC8cwuz73jjo1JizzSAOgW7
         wh2ROWoiu0Le0PN7evFqzE7g4puKe9hXR6/3j277VjfcQziyKZehEnTNvuy2JOczXEt0
         5M0A==
X-Forwarded-Encrypted: i=1; AJvYcCXXDGBFEuqIXwiBnsUlAYrBOcVh47asLT2h4NnGlhjITe/SXa804Uz3wf9kr35Bi+yS6UuGckkrug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu2rTUlmLHx2xGvCE+3kd6XXU2mT+jUNhR+paohEiQ1d8i3+7
	9gII12RCjijBV7XzpQ95FUl0ggCVPFGw5YsooiNJzOGtEStRM8oZn8G6B4uERBGSu0hg9fYA71T
	Uo9G/4jBdDtRYBf64Nn3P14hdqgeNaqRo9aSvLmijK6yz1J450BmIT6NSWvva4A==
X-Gm-Gg: AZuq6aLWwA/nDmCUAOwJtK7RI6X9nwgx3hRXAYesmk8MGTXqqIJaRRTo44xXQViD02Z
	P1WmaOwANkGYhfDDLvTLt9gyxIbXPAPELmHAyjWrMdfT2tTOHNCDzJmzhzHc/hgcyryn/WQb/Qz
	FT2/SdDnbSwmDeygHSoVTuM9wLaH3sgdAkq+xLt4wuXE26MKPgWsunI8Z7aGo3mQhd6ST1Qvp46
	27GJHr3LN/IbYRN04NlzrQZRMVujMpAJalpFtUK2SgMEP1CYWMgMiRwiRfv3RFZRZyFLQTO4nSk
	z4IqOp5OShzxVzwD67jio+j+8a71FeCdPyXtQL4fmcFC49vCh2RIGFOcFfE8TFvKoV74S7gicyC
	Nr+rZ+2iXG2s/Bq/HM7YLjoR+ZFTR56vv99R/FPExKXdH6Km/Kuzej2oD3cWF/pFZlrkILDEZQ8
	0ZFEY16IQh+3fkz8TxHyJ1InA=
X-Received: by 2002:a05:6102:291f:b0:5e8:1d93:921a with SMTP id ada2fe7eead31-5f8e24dec68mr412662137.15.1769736053278;
        Thu, 29 Jan 2026 17:20:53 -0800 (PST)
X-Received: by 2002:a05:6102:291f:b0:5e8:1d93:921a with SMTP id ada2fe7eead31-5f8e24dec68mr412647137.15.1769736052758;
        Thu, 29 Jan 2026 17:20:52 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b2d95sm1448055e87.60.2026.01.29.17.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 17:20:52 -0800 (PST)
Date: Fri, 30 Jan 2026 03:20:50 +0200
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
Message-ID: <wyvog73ymk26b5chg7afdjdqln2hcrvir5h234tuiuazmc5ktu@ptr7w2nbmlky>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
 <o3gdovqbkmclpmrhjtg3lknhqcecwfrp73bpbv6nsspzvkjfm7@qqkrzte3cdy5>
 <3a1b3a2b-d73a-4dae-b866-14abec2ff18d@oss.qualcomm.com>
 <stmlthovu36kyhhnn7s7rpn5l53chnvmn3lmyepzpg33o7hpo4@cnoknywqgry2>
 <62666d7e-7b8a-417e-8224-4cc69b3e7c29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62666d7e-7b8a-417e-8224-4cc69b3e7c29@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697c0775 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xFKFi8ZNh1L_vYKN6ewA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: YGMj2FeXatq5m97oapDfWjpjoor4BngQ
X-Proofpoint-ORIG-GUID: YGMj2FeXatq5m97oapDfWjpjoor4BngQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAwOCBTYWx0ZWRfX7jWbGwdv0aUK
 oFmNP5DBT5ETf9Ya6PDr7+TXi5KkE8s9GKDzMF7rwOTRMRLUefY5DGoJ59S5Jo7W/q9unTc9Y+K
 sKjxSNtcP1WG04xN2K6RdZW4cP4RiVbX5hVbUGYBilmm+fYWSjpVIYzImqzMdkhawPqvbZw5xWI
 SlS+bE6FFTZ5F6jWMutzwyGrH1vwR3VC0jRsmOYf8t8cKNDqMoFpGydXeOrHRea5WdJAi3Kxuvb
 WyS2gNk13P7VEHiAU/8AaiOMXt+I9SRGrPJI3/fj1yqpka1nvidieZiBCh/+/skvy30q3r8cfrq
 0KR4jhYyQ83Wa48OnT7vKdFrUCx8la5ANjKH+rUcWI327zXku5PvoFdADFMWOQSQYOu1YxENmpt
 91VU3ukb2HP8rsE7IbolGaeUGFlWOjJHd63vYpISN5UC8t5AQ7XQ6S7eHTRRLS0qaOp7uicE4OU
 z+C+KHw++NK3Y2SzdOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300008
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41742-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.11:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DDD7B6231
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:10:49PM +0530, Gaurav Kohli wrote:
> 
> On 1/29/2026 5:59 PM, Dmitry Baryshkov wrote:
> > On Thu, Jan 29, 2026 at 05:40:56PM +0530, Gaurav Kohli wrote:
> > > On 1/29/2026 6:13 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Jan 27, 2026 at 09:27:19PM +0530, Gaurav Kohli wrote:
> > > > > Unlike the CPU, the CDSP does not throttle its speed automatically
> > > > > when it reaches high temperatures in Lemans.
> > > > > 
> > > > > Set up CDSP cooling by throttling the cdsp when it reaches 105°C.
> > > > > 
> > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/lemans.dtsi | 138 ++++++++++++++++++++++++---
> > > > >    1 file changed, 126 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > > > index 808827b83553..c747dd534caa 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > > > > @@ -7281,6 +7281,15 @@ compute-cb@11 {
> > > > >    					};
> > > > >    				};
> > > > >    			};
> > > > > +
> > > > > +			cooling {
> > > > > +				compatible = "qcom,qmi-cooling-cdsp";
> > > > > +
> > > > > +				cdsp_tmd0: cdsp-tmd0 {
> > > > This question was already raised. Are there more than one cooling device
> > > > for the DSP? If not, drop the subnodes.
> > > 
> > > Thanks Dmitry for review.
> > > 
> > > Yes, Each subsystem may support multiple thermal mitigation devices through
> > > remote TMD service.
> > May or does?
> 
> 
> It does support. that's why need child node to trigger different mitigation.

Then please inside a DT bindings provide a definitive example, demonstrating
that. Otherwise, reviewers can observe only one cooling device per DSP.

> 
> 
> > 
> > > So, need to define subnodes.
> > > 
> > > 
> > > > > +					label = "cdsp_sw";
> > > > > +					#cooling-cells = <2>;
> > > > > +				};
> > > > > +			};
> > > > >    		};
> > > > >    		nspb_noc: interconnect@2a0c0000 {

-- 
With best wishes
Dmitry

