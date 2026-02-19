Return-Path: <linux-pm+bounces-42872-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO7iKXQkl2mZvAIAu9opvQ
	(envelope-from <linux-pm+bounces-42872-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 15:55:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18415FD49
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A555E3004DEF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90CD340DB8;
	Thu, 19 Feb 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WStp4k0S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alXG7suR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF130BB8C
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512943; cv=none; b=KAJiZJUsEFNQ7SZQ5rizn+mU9bTCLmf6d7aTC0mkMRXWQgPjCjv53H4vFrTGdxd8CW0SnqeVGl2LwnGMVfgCKS8QdDOOCs69k9sgJccJ65wTUSeIoqQkDSM72pxSVEjMChZXi+hmQfZ5ucev9dyRJOx8jGyrMi12osdt+dZ7Fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512943; c=relaxed/simple;
	bh=tbdcuT+g6r07HPBhB3hTvqmblkDZqNlP1F4Qz725D4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYQ5WxMAgyqIYsA4uk9A6kBibhZUqnAbPWeU/vSm3a6+bwGGFmUZxyzXeMJf/iWB5J+lSO8+PDo5dzdlAGo9E7qqvglh24eZe7qGKpJAPLmOw9R6conWUK+3n/gZibLxicXGaU2h5s2d6qVoBCDfdhcRS4f4OXCZPiYqonDWhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WStp4k0S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alXG7suR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JBK85c1924573
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 14:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZOhIku1tj9AxR9gmaDfARB9d
	FySATSSKwk2jp4g0rjE=; b=WStp4k0SKYItCw/iGfMON55XZApfSgkxXao6UZzR
	qIFL83OYLMWxcpSbA1e7VV7OxDf05x84fh1UN/mOht06GOIafbNqwdpih30DPqLJ
	8zrXCL79qdUigK8CpYdgrmjQfm1c2wWexr0nZ2xKvwgu1weU6dtz6bAQFub7QQpK
	0Sm/YjVhWphQ36KXwRIamTXdlQqaVSdoFofcRj2TZlawykk7SxECaWQziixiWQOu
	A1jCQMYWSx5jAGmbesvbhdjKyXKYaIOujk9dPdmWcSd+ga6ibYujEZpJF6wacUOn
	KNqyjQFlLOgwsfHCbCdfAzBVvIE6xbFMCLn8E5+gus5glQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdga222-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 14:55:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71156fe09so739563185a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771512941; x=1772117741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOhIku1tj9AxR9gmaDfARB9dFySATSSKwk2jp4g0rjE=;
        b=alXG7suR7QWtAarMZ+MjdDzL+LWqSn2daNg9hbZtZDgPgE+a8RNEVepXy0VWkdZqL3
         ENGej7SyZVTI6W6BDz6VXHF30EPis/ZI7bWARcw0qBT8fwhnhEBTgRw4z+UD9cVAcfkg
         XmWkAHFioSJklV9jliwUziAW41Bog7CKEPGZ8Y2i8XqSck1f02/yGPS4IZAzgR9dEOxl
         ROoUv4DTJnknBrn21rykOWCT8rLHWBZU0qsW035j2LEDoi0/adVBV4QJLT5dfrAM33GB
         xfiwj4nWJXBETfrWK8iMzmrs0ojF9pXo/gbiq0jklzB2i3lEv67iHZZrtH9SpntRGNMJ
         idOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512941; x=1772117741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOhIku1tj9AxR9gmaDfARB9dFySATSSKwk2jp4g0rjE=;
        b=S1K0E9OXLhwHRMMUDJ8b5XQlcqSJtUHRejRxPYzvwqT0nMlQYiIpQ8I6SHn0Op9X+V
         Cr2kZuCBmG3Pxfy2rbi+a4vH5nG0ZWK/wwkv5IeZq7Yyq1Fo3KB4Az6W1FD8XwTEHopU
         ETt4lnqkehyodCBHw1/tOPmEILxmI776v9ZJz4kfcWo4sAvyP9SaupY2l1MJ5V7PV5pc
         JJzUcH6NP8aMQgeOzgAMbinDiOPS8w2rvE8QVdl7hV0LHE/e2YRlfp/riUOZhf92GUYX
         YX7C1engG5Mqa7AmcviD9+kBRN+yHT3dVKPt7qOzaSAgH4QzrunzJ0YCZlMPlS9xvoxh
         rcig==
X-Forwarded-Encrypted: i=1; AJvYcCX1lr7fmm7PiESGmLxWiDgpV9SGenV+9k8JgjVbqYHPghcWdWeO77pPmE3IFnbbD7mPaaAr740SEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqBSSkuxDa3a+tUWGbwUXKToUXnJ9D8rU43Fl8jH/riRfYy4n
	h1CMJohxEtO4F6m21DS3OXRh7k9g2T4ntuGpn9EpcKttuqlLkPgw+UvAlyKT2pKBScjcc3wArhr
	k7Ozw1SiOUWW8AhuK43ZIQJSwkM+QUhBt7xaOAgIVIvJQXSzzHZqNBzSRk+Ai0F5lorh8GA==
X-Gm-Gg: AZuq6aINF5M+9+rzWjEJVlT6bOOs7jTvWmyMe7sbvN7qp3b0eqEefxkMUO38/16tjfD
	cLi4egVIIXxi4xnyTO7lEdqdBMRF09TUBTYqQzgQCGmx6pBjCfcrM9IeWAruNAMXiHXC3dlmc+1
	5MEo93bemY+/J5KCR5rRKLJmRWLGxbrTUsEAEWiTGku59RwxNkQ0XE1RfaHy5Fbjh5YwEaqXsTd
	ukYV1lrdvZzyFsq/KXshAgCWW51a43AsLni/h3hmyUi5feyv8nuH6AHXPu8NfAbD8Sb9B1uSvLG
	uCIHuBUddPT0oUul2phv6qBwVLH5Up+9i1uN+j0azBKcMlUb01Sx9eZLNQkcv8FBZ00c61qqxDw
	EfigyZyzFAZlrrUbkrWOj5Eoa3QhJRjg53oslbUT91n11iI+8/GkvCp7eredqLXCWNrxAt0l+mn
	1AE5IQJP562Adq3MrFdK0Fusbx9tSAgI0dTgA=
X-Received: by 2002:a05:620a:bd6:b0:883:c768:200a with SMTP id af79cd13be357-8cb4bfa47e1mr2162863885a.32.1771512940463;
        Thu, 19 Feb 2026 06:55:40 -0800 (PST)
X-Received: by 2002:a05:620a:bd6:b0:883:c768:200a with SMTP id af79cd13be357-8cb4bfa47e1mr2162860785a.32.1771512939905;
        Thu, 19 Feb 2026 06:55:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5ad73esm5317879e87.68.2026.02.19.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:55:39 -0800 (PST)
Date: Thu, 19 Feb 2026 16:55:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <6kvygrdcavcsn23g6ghbutw6ycq43oodu25u2dnywo43ev5fwn@fr5pmk7pzg7n>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
 <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
 <20260219104832.3fe5tlnvjqus7zz2@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219104832.3fe5tlnvjqus7zz2@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-ORIG-GUID: pO3l1yT16N9riXUghRwnv6j5yWbK9n1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNiBTYWx0ZWRfX2FL+oQUDsF/G
 4KCrtxVoV3BZZL+122ZykDwig7rH9PMaYKemuB8pR7b0BFTLu5+E0WPWc0ssAwVzDqOYtbkoX1P
 LDYs3PdKwlKghlIvQ44Fsr5NxHOVsuxej5UyJTce3rLTXtH8hjO6zixTULCQ2PxVgJ9hZ5+bykv
 PG/xo+cyP3F6BAiq9HsqXEEcs2ntqZhwr9YaeUPGKbD50piMXfgje2SQHARtCtPUffeb0w/oFdP
 nuve4i/soIJoxyI+ExdMwNb7oG2bRivVGKf7a67g72mTvJZNloFYf2DKY8m6Io0TZp5iG2u7G5a
 w0YZpOUFymT+Ph65RLcdLzGX928CuM+II/c3zWkRp/d7Yj0MU1bv4BiGp6oUAO+bzMLTHDEDTSh
 mcusv5hP6cfm4P8B38SdzjbbKZvIYjanliScFIHkBwarLkgdL+E47bsi3AkhAw3h9KwazfNhZLw
 FO78/hZe6MjEez9J2wQ==
X-Proofpoint-GUID: pO3l1yT16N9riXUghRwnv6j5yWbK9n1g
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=6997246e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Vb7ys8ifLKOb9fvY7foA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42872-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,sonymobile.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:url,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C18415FD49
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 04:18:32PM +0530, Rakesh Kota wrote:
> On Tue, Feb 17, 2026 at 01:27:29PM +0100, Konrad Dybcio wrote:
> > On 2/13/26 7:17 PM, Dmitry Baryshkov wrote:
> > > On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
> > >> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> > >>> On 09/02/2026 14:23, Rakesh Kota wrote:
> > >>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> > >>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> > >>>> documented as a fallback to "qcom,pmk8350-pon".
> > >>>
> > >>> Drop everything after ,. Do not explain WHAT you did. We see it.
> > >>>
> > >>>>
> > >>>> While PMM8654AU supports additional registers compared to the baseline,
> > > 
> > > I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
> > > an actual name for the chip?
> > 
> > Right, I would like to see some clarity on that too.
> > 
> > I see there's a PMM8650AU and there's two variants of it, perhaps that's
> > one of them?
> >
> To clarify, PMM8654AU is a different PMIC from the PMM8650AU, though
> they do share the same PMIC subtype.
> 
> We are specifically using the "PMM8654AU" name because that is what has
> been defined and used in the upstream pinctrl-spmi-gpio.c driver
> compatible. To ensure consistency with the kernel driver
> representation, we are maintaining that naming convention here as well.

Ack, please mention that in the commit message.

With that in place,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

