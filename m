Return-Path: <linux-pm+bounces-43145-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPn5NpKrnWmgQwQAu9opvQ
	(envelope-from <linux-pm+bounces-43145-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:45:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D4187F24
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799CE3119D70
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23839E18C;
	Tue, 24 Feb 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYUSxdyV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jx78aKBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA39E16A
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940489; cv=none; b=Fh4S7Sj1AOA0B2qOD//D6td1PeBxh24xE6zxG9bvgUnqJFRgGWD72gdKR16tgmackh6Zyp+QsK7tXJKLS57i1XNhLqzpRrgswPGbgn3QYjvPvXI45deoIqvaXoFlxCPIpnfj6qKEgefi3k1KvWmFF3pdlCNUwshbsTnQ3XHMJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940489; c=relaxed/simple;
	bh=r7BiUeIBfewUZ5pTC3H6dpfvxK/A2NLbHqH1U+2yQ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAjjOjtTu1YNzHh8g9AJQm3aMMqXQd/y59JfewUZrJJLCVEqtbgaWJAKriK32xOb/LlImAu3iNQZR/xmR2NKPXn5j8EhHjo5M2AoCw7OXAXpkg+SxLQn+Qlbexeq1OoakZlBve3Kx892r3G23HiC/xlZIkAo++5UU4LTRiKNjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYUSxdyV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jx78aKBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFM8R3884219
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GCmCIvGjw+0aYnHJUo5qfc96
	HyQB54zOIU3mzx1evxE=; b=iYUSxdyVsyH3g8BXsOL8UMF9TNv5I1RzePmurFD3
	XV8ahykewziEWT/9yafl3lSJjS4XDKb7R85kO3T9NjqnV6kg0pNFCK9Ub55cxhw1
	JpJ46NgH1JlZg0i+FcvD+x/WxlSamOFX5mcxlcizib8dG5dBZGb/ycSUnkKMnLAV
	Sv83cSXTIB5sUW9B7bp4RxK/rsnrBF2D/Pmw7x7mPCcOOerkfVRL5oaXBEYqgTyE
	T943Wj0oku7YRScgQfwvcNNIXE+yGlKcg9VNFi5z3b5QpVJsbyb/uYoJpqFwDi0h
	pgp67xGfLrDAL0p90lzI+GVUs+gK3YY4M803dwrgiKbVBw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8uaf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:41:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70fadd9a3so3321754585a.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 05:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771940487; x=1772545287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCmCIvGjw+0aYnHJUo5qfc96HyQB54zOIU3mzx1evxE=;
        b=jx78aKBsCr2yFz14vfwd9bRiOmj00f4oFfVdOU/svKvoHdwXG2OpjG+ZDA4MRrkEjX
         7tmhAKDuavsv5dys9M/Z4mZ+D2ToDaXLGFgKpCtw6d2FC72UKBuaKxt7Ks5p8NIEO/74
         oZfHR4Tn6BUMfWxgIF+WoPMthhB13G51XQbeO3Y40OP3/7PbUnLQz8pIbUwkYqTNfG/Q
         ihldq2j2ipkl68g2eef4D8GdVYplNKZUsa5OLFHHNv17vgG+6HhuKEs600PJfLav5tlZ
         9i4gcP49V3R3cJgMRNifDWq48SBe6C2mY7ubNjOmhZv3kvMzwQC3SsVLMOWIpnir1STB
         42Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940487; x=1772545287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCmCIvGjw+0aYnHJUo5qfc96HyQB54zOIU3mzx1evxE=;
        b=KGCq1McA4Fdh9oZ+eqkcbxeUNbrPCSN804NAPHe5Yq/aBNXtvgrkX+uMJuAIBo8laU
         Yyfx80Pu/fGr8zTvR4Iax/zKi0oa9nUDUznCDTbr1K0J3qB1Vkr1ij/TH+ZK8EqUiQR8
         Es66QlohtwH6zLjWTaRvW3zN9J63UBtiEffqORdjFapanIksB+ED/+7efKlFSyHu0Ny1
         VWr3eR6us7ARH3LqjjBxem5vPkcA7cqpqQ41GWHm2qZ8cjrONPmZD5LaVz06DLRyclRZ
         JqoXKtsKY+9qIWUVryoF+5QYJqPZNF4bxNNKQT941O4ZyrH8Dhcz0cQgIVgFUPrLnYST
         NkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhhlRhNrZofrgrT9y/AsFEFz9WXCm//5/KJuzUq/Z7argENh7a+EpmNGKx/E7LjhhGcROBNb4png==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx194g3R/PR/YyMmi6mLyWZVYTT0fTjTNZUofUhqSbJYXD9V/lo
	zDSjD1HKkkpLa6a2CROx2FkfDUDKJEQzh8qoZVdO6ywC89eaCujC1bnIE9CxdT4T7aUmiJlsCUj
	/RAGxiYWHVQQKZEBr59feF6uoW2/FXKfqlxf/9mDj379yG/8CMkFio/42c8e6lQ==
X-Gm-Gg: AZuq6aLkMkrKLqVz/4AI9xtUcTnal9nTdhfYNaRmPb3QLqPSqBBQp33gnhQJmIgkN0H
	YQDAXEhBhPlL08p42bt9ZPw4+qd/85FCvkL9F+wbLyNQMDwn6igBHfDEUzIpmWFvVUHUlvvbKn3
	e0ikTxpXmXVfZC/HIYO8xXsRC8og7UaEJfzndTiNcMgldUelAiVHyn3EhDq4YBuUav4gTXDvjNi
	x414fFZRsgvwcrybt2M8vEw5lu391N5U1UHkNFqtIonU0Vx3FpAe7GeOKY0ds80QJ8dR5VbvyY3
	2XGXANm074aSSgfR/NAmmrjqTzmzStaO+QFttvIHap6DzrkPFOByRuqrLTogllFzuknvcdxWoHm
	+VKy+2Ne2ywOjaQgx6zzhUwsHajcZrKmyKNO+
X-Received: by 2002:a05:620a:371a:b0:8ca:2cf9:8197 with SMTP id af79cd13be357-8cb8ca6d928mr1569702885a.47.1771940486460;
        Tue, 24 Feb 2026 05:41:26 -0800 (PST)
X-Received: by 2002:a05:620a:371a:b0:8ca:2cf9:8197 with SMTP id af79cd13be357-8cb8ca6d928mr1569697585a.47.1771940485811;
        Tue, 24 Feb 2026 05:41:25 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8195f50sm29415055e9.0.2026.02.24.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:41:24 -0800 (PST)
Date: Tue, 24 Feb 2026 15:41:23 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power
 Domains
Message-ID: <woypnbzsvu5h6rycqolvmcom72ypgg2324yhhpu7vnnpb7fld2@4qf67agnjt52>
References: <20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com>
 <20260224-eliza-pmdomain-v3-2-6e13d3aa70a1@oss.qualcomm.com>
 <f52f3f86-5ec2-4d3f-98b2-5ceddc7b71bc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52f3f86-5ec2-4d3f-98b2-5ceddc7b71bc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: xy4LcS7Xdu2hmjKAfZhL0mpQCXpNuxX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDExMiBTYWx0ZWRfXwDlwZv/Kodnd
 teNJ3Qvjm0odXQtLa67vO36Cu7yemU4rwWI5rnghI5CkSlBq7muzcNEppXBWw9W569pF2+Uewb0
 KyADe64015nV/PXe341vfnA4q7nNx49lEF6o0DC+OAtPOKcCoDEsuauiNkgoxfP9eYL079aepfp
 f9O09ObDGyXs7WYTSVcYt2fYeNy8NoyVJ/o6lwMrI2F2hjpOn/KYrHen2xkjXSP4WRdYLpzrXsK
 GTqBrVKQs+IkiRtbTzTgLSADBoW7KdK+xX6m7Lu6cIQB3YJxeBjc0jCWmr119fz1g7j/XbgRuHT
 IKbEKWnc6X+L7FPSC/A9iJyCej7m2vzNcD4AlYad3mQL4xMPiKE62pKnddAgiMvpeKI0Cm7rlxL
 jRZbX9DZbxI+5cXUqUInWgp0+AHzWrgKntYyBb8lT9Mlo//mU37YMc9Gk1UbGRQyX5bMepiQzKs
 cJmPoTik6+N/mHG4zXw==
X-Proofpoint-GUID: xy4LcS7Xdu2hmjKAfZhL0mpQCXpNuxX7
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699daa87 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zciMAKYT23bm1hcWLKAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43145-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 553D4187F24
X-Rspamd-Action: no action

On 26-02-24 14:38:29, Konrad Dybcio wrote:
> On 2/24/26 10:49 AM, Abel Vesa wrote:
> > Add RPMh Power Domains support for the Eliza platform. The list of power
> > domains is taken from downstream. Even though the cmd-db does list MMCX
> > and MXC, they are not used, so they should not be describe.
> > 
> > Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> >  drivers/pmdomain/qcom/rpmhpd.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> > index 19849703be4a..ef2e08c6b454 100644
> > --- a/drivers/pmdomain/qcom/rpmhpd.c
> > +++ b/drivers/pmdomain/qcom/rpmhpd.c
> > @@ -217,6 +217,27 @@ static struct rpmhpd gmxc = {
> >  	.res_name = "gmxc.lvl",
> >  };
> >  
> > +/* Eliza RPMH powerdomains */
> > +static struct rpmhpd *eliza_rpmhpds[] = {
> > +	[RPMHPD_CX] = &cx,
> > +	[RPMHPD_CX_AO] = &cx_ao,
> > +	[RPMHPD_EBI] = &ebi,
> > +	[RPMHPD_GFX] = &gfx,
> > +	[RPMHPD_GMXC] = &gmxc,
> 
> GMXC should be removed as well
> 
> > +	[RPMHPD_LCX] = &lcx,
> > +	[RPMHPD_LMX] = &lmx,
> > +	[RPMHPD_MSS] = &mss,
> > +	[RPMHPD_MX] = &mx,
> > +	[RPMHPD_MX_AO] = &mx_ao,
> > +	[RPMHPD_NSP] = &nsp,
> > +	[RPMHPD_NSP2] = &nsp2,
> 
> And this one too
> 
> Both are OFF by default ICYWW

Will do.

Thanks.

