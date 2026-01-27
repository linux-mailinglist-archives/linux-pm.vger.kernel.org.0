Return-Path: <linux-pm+bounces-41531-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAH3FH2veGlasAEAu9opvQ
	(envelope-from <linux-pm+bounces-41531-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:28:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC6E9456F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A74AF3007501
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E234EEEF;
	Tue, 27 Jan 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oigmcdOg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4yrhrpI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601B34F253
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516918; cv=none; b=Yh7MYF/dUp0iJWu201wFuWSRnaYuYMI8sGDYCFlpJoTjoZsC3uI/vo03PhUyFBXvn7OG5W8WPh9sfcV+5PdpYjeERzGaAwuk8o4he/rvON41DMqOncewiyNgekj6F3Dh5+zcKQc1VWeXW4BV4fzNe9IZO0cVSVTj1lhHrNKjLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516918; c=relaxed/simple;
	bh=0TnhOHipXq5IeJyOW/ea8YZad9WsYXgYzXEoGIEyjLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQNoygUIu19FvKk58nYMUliE3WOYzqFtkznFsJglA8DdRuZjAUQN6GGj/yAPTcUdD+Kj5CXkW+sxnyCQgVR8mIFORTby3cbwwcFivvG/eKhzlQ0HAztyoBj06uB+J1w7WxtzPmaEFs1OH9WFFwt8gPAq2FvQ85qylXToh0M+bcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oigmcdOg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4yrhrpI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R87I9A2379234
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r08M33JEjquttJJCuf2dkn9t
	t3ROqh3wPBfGPr9pLQM=; b=oigmcdOgqMacdpd8S/wlreL8YZQhRANHFufMxqmM
	uF/PTXEo3hVEMUE6YqmNpMXVuMURm2v9bznzdGLIwVxku4ihEszsAfMg8TrRWIWq
	tjIqZw5773FoCb4+lxbH/dWVS+QZAoAYjOn96hvkOLg13Grs4UFlYiiFbrO9hwN2
	gc+ltnHWhD+ch67GOrN5KhmMVFxe+wLO1te9mLNIyDr2+JJVZ/M8LRXxk+NL0C+2
	2lGGdk4rfiOCrh+4B/ZqCj0Zh6H3bcIftWZvvNjrcktXD/NnIzp2tcZx6Om6NO6Q
	WSl0FuTC3p9Kke/hr6cYTmRmTLC2hLPOij/TZlBgZMctsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr8urp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:28:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6cfd52556so1504147585a.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769516915; x=1770121715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r08M33JEjquttJJCuf2dkn9tt3ROqh3wPBfGPr9pLQM=;
        b=e4yrhrpIbP+gMKK4TBGUOjkPEb9M4thdjpMbMTANXmeg7aZ7NQmF4PF0aKfO0F73+P
         4ReVU9JZFrPhJAWo2ozs8vb5CmbAOK7rUDNPMgAkr7RjMO/m9SGsQeqU7LE+1LsImDk0
         z15c6HkiWW+Q7RPQATabCk+Z+89tJfBh0NlGJeLc9GXXEJAe2nMJQbTDhhzsMLUeGgm+
         umo3tv7NjQVabiRIEDHtEfhZc1+aIA5fY6EjJ6qhN2UFkV9j20sPZl74eBbgmbHKtll5
         a/QNRQNqYnYo3UHGz8/4lCTkaBGASdQpEmKEo7nu0Sx9IwPj5+4qNK0HbLUpSXszbjQI
         zL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769516915; x=1770121715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r08M33JEjquttJJCuf2dkn9tt3ROqh3wPBfGPr9pLQM=;
        b=ASTFR2upp9wWROstcd+CR5buhAOG5cApOvbO4R0U6yuhdSbIoNwp6Dj+d2liEfI4Q4
         HrAF7oiwQ8DTojuA8U9bzGi6TTju3W2vutEpklfsVMdtGqlkaB+GHBqsTRDcSVTyfMjl
         zpYxb1DrG/WKN+t4qZp+XsRu78TQSnlJEnWjIDI9b8jrNvGahTNbSQrVHELvhh1zSuKA
         EuMHjVtKQ+yjh8b2k98TNxNBWAYJV6v+085qgl/HmT00DToZpBtjnJWpkRN1GJ7VrTW2
         WV2AFMbKNpF3kIpPPiWofaCY38mvgpdBF7tz3UEct4QACuCuxkylCSZNlMqtKozx11D+
         73uA==
X-Forwarded-Encrypted: i=1; AJvYcCW1SIKD7CRxQyajIkX9Ujwg3znKry8ZIuom6TI2/5PF+dRjFnLvF8WmIyuR4Ok13pnps0sT+7F5Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iA6/PPQspakR0x275HwbgYGWVN3M857D3wIYu4I+LuEs9pb4
	GhwLNHgelj5uj5yKlCa3O/PWOQx5nn4D2Ig9W3xuZpZEgfD3jNh32BxkwDKlkLkSupJw+n2i50S
	0Cu2tz08uYWFNLJuX077NRnjc0UKPzlBM3fo9Kc/1GCBwT9IKyWC+TwsuwQybfA==
X-Gm-Gg: AZuq6aLGNXtpEtmqeRQZ5qgB+dlVo83EgHzJgRcXlzwOdRyrgW5aO2cDN0AqhuNfilz
	Na4RSDLZKSCL1xhiXJTw6WxX8MuDnbsJK4GvgK91wz+rKnAozBzdaT+ZPbOjvN0JRBfAZd/bgI5
	byPoj2Nrn5WhDVE+kHseR5/mT7K56h9mPhqx6FQcGLb4TgdNq84FC5cj2PU/z6Cnn7q122s1ML+
	Gbg1wT7JgE9QpcElVEia6olqFHMwwClrUYAD9U3gNdpo+Rj0BQVo84FJQJhhQZjRUNG5M0hYPwl
	rb01einVxBMJwdOEljfCKKyO4/YLDhNIEaRWABJE4LFAJjhincnkgcxkGUmJgCtVPvbW2tZiHBj
	jOY9srZcr/0k81s6mxyuOQ4g8aV8ike+pUu08IC94eG6AGvINQB9nWcmrlHT9QDD7BLekJbvC4P
	b5Ro1f8m6ZEGMPzur24I4kERE=
X-Received: by 2002:a05:620a:178e:b0:8b3:19e:307d with SMTP id af79cd13be357-8c70c232baemr127000885a.40.1769516915253;
        Tue, 27 Jan 2026 04:28:35 -0800 (PST)
X-Received: by 2002:a05:620a:178e:b0:8b3:19e:307d with SMTP id af79cd13be357-8c70c232baemr126998385a.40.1769516914789;
        Tue, 27 Jan 2026 04:28:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385d9faf287sm31093541fa.10.2026.01.27.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:28:34 -0800 (PST)
Date: Tue, 27 Jan 2026 14:28:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: glymur: Add Mahua SoC support
Message-ID: <yba2z3v7klftzhmd7bghgj4y7orun2yo2bxzlwop7xflsj7apq@nx7znegfkmhu>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
 <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
X-Proofpoint-GUID: xVDQBJP5xce_7vVgt8Gy0NWphhZpKjvW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwMSBTYWx0ZWRfX6OwqHd6BbAvh
 HAEXtnz979dAfhGioBWD6Ztw1Z/556NDODK+1OLIw6u23HFS/Rjs7FtrPs84H8t0eFGqSxEKPph
 R3X5tMt/uqv13Upruh8haIaAqowD2/TS3Elx26NtrHOYZz+OQetul3C3P/DSI2lRP33oZiPoezY
 bpnnV9jLX5SM+X5MfKi51aU+Et0RQ8jWp0I6SpCVuKpBO+hkdmM1tQnHXPoS4N0zjC6j7oHdAcA
 kKpipeK0po5A2AHI/WvvCZXyJN0oqstgGZtFTYkVRj3gJbarusaMDgn0YtJfP/5YcjDwywbS5GN
 ycQYQoaH9C99bEGtij4fU7JGYqGM40YxLEuhLYt95Py3cbOTBug11YrM7zctQTaqjtk0dxPzRgu
 uu7f/aVSf5C0bwNkHzTmRsaJbjel/XElJ5rRsnVmiH2PLsniW1WZeue++F2Gv4xLo4cqnfl94cK
 ZaW5q7owPf0pvcoD5xQ==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978af74 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GtF0_HNWVELJq49vNZ0A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: xVDQBJP5xce_7vVgt8Gy0NWphhZpKjvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41531-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DFC6E9456F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:22:07AM +0000, Raviteja Laggyshetty wrote:
> Mahua is a derivative of the Glymur SoC. Extend the
> Glymur driver to support Mahua by:
> 
>   1. Adding new node definitions for interconnects that differ from Glymur
>      (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
>   2. Reusing existing Glymur definitions for identical NoCs.
>   3. Overriding the channel and buswidth, with Mahua specific values for
>      the differing NoCs
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/glymur.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

