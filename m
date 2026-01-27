Return-Path: <linux-pm+bounces-41545-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBQeO/XNeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41545-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:38:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2495D76
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D0830818AB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B135C18E;
	Tue, 27 Jan 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvV6MVxn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTgR9RT3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A535B65F
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524334; cv=none; b=iqnnTXjVIJ8UuEfmkRWP8QvtQ/bedOa7Pu8VRhzEpH9xlkD9zzM4TdXoriFuwXu65rjeyYFJ6VK7WVQTj7aKCi0M7GfCPHvKKPt9dImOEz6H8Te5OgoBg1xZDKwb9YgnmButH59XfWMb+lEB+YtLFNUtqFwOAmeVwEVAGqke8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524334; c=relaxed/simple;
	bh=7VXB1W83ikac6HwtZPI8A7T7A1xzAjgKY7T53e0jxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Beua51jmwWmhRDcfljIxjJQNViKC4TQWYMtMMkSsSgptBqi9qTdangsZ4h7VpZKLv+1YvCO+aJ0RL1L7QcgvO0TQc5AP7sLfO25QF+PDbTe+bASQwwfubL0HA8B7mren7n9Emva8jyvWxZJDtQVQcW+U147wb7SHrioYWvyk2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvV6MVxn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTgR9RT3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBwo331136098
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/JZfqn4pG1aepAs8U6hjEKbh
	NO9LoeCJ/TwZWLdXsS4=; b=VvV6MVxnKqWgkVcxcrN5sXdR5t1kQ9UQCjChNu/y
	VBJIo3GtInplcwgriuEkXIR7YpkYt5qQSflvYRp5ThsY/fEo2eQF6DVEn8KvPR8Z
	ANuxtmAXQaVpmzMqCVIOU5YPmI1TsQ77FEJBNfDReQJGcFGcxaVh3tprqH3bZogN
	yFHhRRYklY/hWtSdFNzv0uCitkHh+cLCESFqpu4g1hsFOT3hlj/X3zK9ZtT+7n29
	C6+Q47VN4aug5YKETtElqopTK4fObc+e4dXAfJkdijeNullYnJ4BvrQpqq9UDbfe
	IRXSM7x4fsdrLR3dNX6bqV4iqBj7URNqz1hWxjopawlhPA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjeh5j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:32:12 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f52597aca4so6229955137.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769524331; x=1770129131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JZfqn4pG1aepAs8U6hjEKbhNO9LoeCJ/TwZWLdXsS4=;
        b=NTgR9RT37U1+vGNJm4EdLaoG7E5OzxcrnxX/4fDQcsISCqBpoQ7zUypVLMRlqHleVI
         CBkhkv6iTjhTpnMuOCUTt3Vli9+6LVKRcqTMi7Ki7Ed46hynJ8OW6P4+aJqjAWTwUMlt
         QAClNCTn6o2THT7J9f8ch9wgawlD4POJ160cI6R2bx49tC2ne1CsDPG8/JpaROk0GPGY
         t7QVUscRDqISiJyMzMzHA7gQl7Lxok188mxz8zx6gH8z6rtErPgaFY+IdXyLISgvHCkM
         3NTi3WC5IS5gXMR15SEKMcRM3Nqan+iNhMQeAJdW8a4c/NY/HNDfcSgsGBlvDBMoc562
         AcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524331; x=1770129131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JZfqn4pG1aepAs8U6hjEKbhNO9LoeCJ/TwZWLdXsS4=;
        b=gzOweaN0WY7yRKuchff1UmxQfDYCs4RTywU+6zjGRAo8G5pMAozAw2xCyZdVZiikPP
         uO1zDRupfJnk7VAp69E2CiSTE5JHjkBzUb9eFDxUEFJSVm71q7iFL8EWBbvjrRxTFWHk
         j07UcgLCVoCSivnleK2UOhjbhjT7LRwOPJadAlSrq/dmbrJoSoSwtJPtt/OYZjcT12Zw
         jOAuRKOiSg2rR3I7OPeUJ1eEOOBEk/Pzv7ylUnU2ZDIgEHCgjXDzi5NmKfRpSl2qFEMH
         gJ3YCQ8FbrtAym6+7ZNH+W1OTouY5kS1S70qUIXBPiaKSExsQ1tyvnJNiPYSgrHCX+8U
         BRWw==
X-Forwarded-Encrypted: i=1; AJvYcCXF38YADLovcQ3hz2oKm2LMdP6yigm6hOYIsx8kieWIj74LHo/uZtydD0QUajWkbxz0zWhA1/6m4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6D/6RbhL+Sb2+KBSrVDcrw89l1G72iRv7hkgnSnVyHU9HfXg
	FygPN1bsEwl6ZG2yfpgcDilTptHzSctvY46q3A+gKovy/gXJGIqOiWsxRyasRauH+zeUXY8XWRV
	SNBVobRryDDHYjcUM30BspJxwZqYVRsBAgWJE38PxFiD+QVe/Z8yC4eHObGb6gQ==
X-Gm-Gg: AZuq6aJLcTxC3ytPb+dNKS2BcBeDa+boue1xyQtCJ/WLRSaELbrIVhgcP7Yl2Iqn6Iq
	dRcMIQfFji1XnH5knullm17qL+a1GxK3FhXvmn9bHh2s7PhnrF6n4jjOKdE/AmMBk00m2LDf1MU
	RCIpIJei2ID28SwPT/ul1uYP5c7mHKT1ootKZusD4KMdF/QC1oQygI2e+iVSy1Am6DXXej+45Tn
	O7s1QYXqOIKWNCHYB0nKT2VWStcGkJOG/n1pYJUBOyQFRygipUxWKAhW5SeTfSdlzRtLeYUda9L
	3YPjgVgxg0WRepXL9kz3BUXQQFRNhi7gRcaSY+oLYAZLbWGT9A/MYVEnhHqkZ36Qnvt86ZYbwgY
	6dXR34hL8pNeVD9z7vsGZP6Ob
X-Received: by 2002:a05:6102:94f:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f72380ed5bmr763976137.38.1769524330883;
        Tue, 27 Jan 2026 06:32:10 -0800 (PST)
X-Received: by 2002:a05:6102:94f:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f72380ed5bmr763912137.38.1769524330210;
        Tue, 27 Jan 2026 06:32:10 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm62354795e9.10.2026.01.27.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:32:09 -0800 (PST)
Date: Tue, 27 Jan 2026 16:32:08 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add Eliza interconnect provider
 driver
Message-ID: <jvvj6eehw3gxthrldtafc26xua4ai7nheojfdflbgabjwxbdxl@ymrgczsq4zhy>
References: <20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com>
 <20260123-eliza-interconnect-v1-2-010ff0d100c9@oss.qualcomm.com>
 <8015c8d1-6eee-44e0-9a50-df23126bf7f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8015c8d1-6eee-44e0-9a50-df23126bf7f1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfX/vP3hrfsDlny
 c+SRFM1LBQXdIn4jZFyL80Ix67r6C8Weynl6EorZPWQfBduOOCqy8D9GQm5Pum4NjXZRsO79xSB
 s0zWkdsK/c5rZGvh8mke2SBKERznQ0slgO/ALbGT6B9JXtI1lyH4YahWJbeQQzCrM5nbzlqBvSv
 flYT1WLRZvl9MCg+/8INneEM6HkUvcOusABRTSj4dF1j5xx2+Eifo4V7YZVnzNOIbogWfsVOynf
 lCAcM4dMwpXOixRuqESBVAwhSxFVWcM7FAbypRcnmRYk/Q26Xf0bEZ1agPVHkKLuzYZ0gM0dxXj
 j4GsQDXTDmHHOacFRSxaz+ZjdGRx9o0W5NLRCVNrtubVFs7t2m13Mr3jG7jYaFxidZrxakn1u/b
 U/i4lwxAm/H92NQttAvNtpA9j99zG555dQ183OGswKdGgpVTWT43AH+iKzyasW1p+SrsUsBFCnH
 EgiufOUjH87l5EccELg==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978cc6c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=npw072eAQMWWEgrtj34A:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: PO2i4fcFi7oA8cNKqYTJccNLjxL4Xs56
X-Proofpoint-GUID: PO2i4fcFi7oA8cNKqYTJccNLjxL4Xs56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270118
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
	TAGGED_FROM(0.00)[bounces-41545-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5DB2495D76
X-Rspamd-Action: no action

On 26-01-26 11:26:07, Konrad Dybcio wrote:
> On 1/23/26 1:43 PM, Abel Vesa wrote:
> > From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> > 
> > Add driver for the Qualcomm interconnect buses found in Eliza
> > based platforms. The topology consists of several NoCs that are
> > controlled by a remote processor that collects the aggregated
> > bandwidth for each master-slave pairs.
> > 
> > Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> >  drivers/interconnect/qcom/Kconfig  |    9 +
> >  drivers/interconnect/qcom/Makefile |    2 +
> >  drivers/interconnect/qcom/eliza.c  | 1586 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1597 insertions(+)
> > 
> > diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> > index bb1cb8a640c1..53398e972458 100644
> > --- a/drivers/interconnect/qcom/Kconfig
> > +++ b/drivers/interconnect/qcom/Kconfig
> > @@ -8,6 +8,15 @@ config INTERCONNECT_QCOM
> >  config INTERCONNECT_QCOM_BCM_VOTER
> >  	tristate
> >  
> > +config INTERCONNECT_QCOM_ELIZA
> > +       tristate "Qualcomm ELIZA interconnect driver"
> 
> Please don't scream

But this would make it "the one-off" though...
All other ones are all caps. :-)

> 
> > +       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> > +       select INTERCONNECT_QCOM_RPMH
> > +       select INTERCONNECT_QCOM_BCM_VOTER
> > +       help
> > +         This is a driver for the Qualcomm Network-on-Chip on eliza-based
> 
> Whispering afterwards is odd too

Will fix.

> 
> [...]
> 
> > +++ b/drivers/interconnect/qcom/eliza.c
> > @@ -0,0 +1,1586 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + */
> 
> Stray empty comment line above

Will drop.

> 
> [...]
> 
> > +MODULE_DESCRIPTION(" Qualcomm ELIZA NoC driver");
> 
> Please don't scream

Yep, this one needs to be "Eliza". Will fix.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

