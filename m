Return-Path: <linux-pm+bounces-43025-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ELyCmFDnGk7CgQAu9opvQ
	(envelope-from <linux-pm+bounces-43025-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:09:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84994175E80
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24AD43098776
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D022364EB5;
	Mon, 23 Feb 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TU2Vf9PT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V33PvQzK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427A364EB6
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848195; cv=none; b=NAfZtI36dLGmRNfkIfF9MlkvEACarNO8n34fg9yORFYolI8DYla9JSu8/XX/CurZBF58xxF+RAuXC8GNZ2/oq2Hk6WQJ50fP4O9Hp2d2teVaLPb4zR7BN+52VYi4BCamyLKYvxwJE2RxmQV4Dp44W8Q7nvJukPESBhnIFSJxhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848195; c=relaxed/simple;
	bh=aFYheHq5CbMGyvnma5hiF3215SbnBlmGJw5XalDiNNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTEPGrxRKqVKaBm+oZKoSN359DWELb3G8AwLThzus69mLOfzQFSu3Tm0OLnYNZl0EExljwjIVrJOr5COHfGW5Eu8fV/s2Q9gxkRxPJlH7VcxwjRyKcsSbXpNUPrIU0L3E2mCc1ZL3DAfjVSzXgG8pf8eEhtT2Hl1NN/4xaV7lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TU2Vf9PT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V33PvQzK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAYR2E3409194
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H6Tj2SRONh44Lu/POxVg3ZUc
	n9MRh70VD8qFqYEbM4U=; b=TU2Vf9PTv1YWKR+kEYMpkdfRl43hAqnYrg3aCu+S
	UlNj5y1wbWZf9fHQhPTMPWXdtqJzVyA7zqTvEleDshrs6Tga4Snlps3yeEeCwSlq
	PlOuvKYLuT03Xnfxs2eaI+pcnrv3UTSCkvnltxmBZMZoNEADt+cGvGZ1aBAfM3eo
	U1sDyyroszaPCBkl+YvE7EDvZtlSVLc3zNHnDlO9Co1+ohszhXzxZy/HMvE8qSHb
	tZFXvne0A6DMkV34mUjw7o3FEp7awp2pvnaJ1Er1S+FOZn5/rHwfMnMKw3sFH4pb
	zN4RIytvK05NOenxjWGutEJPcs9RKyBnyxhzEDzLoYL6Gw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8tr7q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:03:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3a129cd2so5624743185a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 04:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771848193; x=1772452993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6Tj2SRONh44Lu/POxVg3ZUcn9MRh70VD8qFqYEbM4U=;
        b=V33PvQzKXdA7ug+wlPLuRl9P3/tYOktm5nWlcFQJpMtqNWAucvLLjKtdoTKsIQqKOJ
         ArIVdLGLf4A69SaAeIfNFWzk/Si/g3n5M5XDuKOV+S+SgqcjU65QbxBCiPhDDK3lYe0z
         MQn/X0Ks/guiUrP+mIS0C5jIMf6gl/sOpHz7gAG9YdQyQm3nxNnpODFyCJ/9YzZApQKG
         hUWzFlSpNEtm1fKdyW57mPl7uHzu/Niw1FaFAnZTxL+jsKoKazDu5rHmssLb7UcIOB7X
         dCyaNySoKP6/2HQRixyMtN9ieH1xtPwWQiZddaAwI0L/Re4/C87XJROe/YtW+F6/tB+E
         Ce6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848193; x=1772452993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6Tj2SRONh44Lu/POxVg3ZUcn9MRh70VD8qFqYEbM4U=;
        b=wcwuT49vUcaBPB7FMrI2c0xUBYsn5uhXHN/h+27Mepm21HiFEPGbgH4ouYsZrrkVIs
         /mNDCpVFUMT5VY0cBkv8cPIL0H9VodO7WvrgQH7J+qiMuDh61eYWkSyOwQJlMVk+dBi0
         6xFmUHFLOBOtz6GwfOBds+U/fIvW2JlcfikfC/JsuDTLLj8exFJKu/n4Q8TClcdj9y3D
         N3ri2sLOBjbGiKqTVqBvI5HSTZ7FE7d8DuRhcLvigWwUTKglgJpHny1lJEdg3jMXk09e
         TCwaVj8WdvKltaaktZgsK0MK2v2nE27CZnqHH0irdNb6b7gW9Hf0xzjcYyFgKW+9uOxy
         GDLA==
X-Forwarded-Encrypted: i=1; AJvYcCU6RJSeTPfR6WeJhhPILiKS3I3xhFEZ/hojS7E+KgSZdkD3ypT33BTdgxJVoXAdesRiv3+rm3K/dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiCaJ5elw5nm//CEm5gSJBSi/E8IjVhw4KnFLOlcFPGVAo11L
	0C/cdR5U2VUTbSe22a6eAqL87FGUhGZB1b/lL0hdyZ6uZNRczuednsMWlD+l1/TNUQwfi08ianB
	nQNAPZ/Fd8NHytPw8u0I1v9xpRIuz2lVm+4RqQR6rsqnfD0feTM4h09tcx8jGgQ==
X-Gm-Gg: AZuq6aKoLt0BtQtxSU8Xsd8XZvSR4kwlPDuXevE0DO6xAM814OpkgZBHp+pAw56PO/N
	5N+nZB+dY2qDRCApp1GvtTaI2CqgN4DkCeWnK7AXtsMEMbbMLyWo15oLyulTN37F/YAw2Axq3aT
	sFQsYCzHEzSHRgVDGDqAoWc90SZjJt5VsAtt+VSt59K0NEpD/h8DB7WslV/O33/KOkyO5sYhd6N
	WQ/oXvu0Lk93Va5h5ZOGwpjDdKOMVVs4VE3syzAyUVIF7026MEyuzZfhCKi+/L+vLD+44eyo0Zk
	o/fbrDpJNWxN/mTNvWl+y6MpRJvzNFKnWn5bgu3hNGJ8qI+Dkxk/E5rHCKj9h2e19jY2x3ERBE6
	ZIo7lehEg5JZVWxQKF13p6BeNxD6Rm73MKuOD
X-Received: by 2002:a05:620a:4506:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb7bfc8d11mr1703397685a.28.1771848193063;
        Mon, 23 Feb 2026 04:03:13 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb7bfc8d11mr1703391785a.28.1771848192351;
        Mon, 23 Feb 2026 04:03:12 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4cc81sm18411301f8f.26.2026.02.23.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:03:11 -0800 (PST)
Date: Mon, 23 Feb 2026 14:03:10 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains
Message-ID: <fegadnng7qyfrrwvjr7grzvctxkdan27oeja3sv4ilqpkfjnou@t6qbd2jkkeav>
References: <20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com>
 <20260216-eliza-pmdomain-v1-2-c51260a47d6d@oss.qualcomm.com>
 <vl4v6mrd3vcbrurrsb3ak5wxjk73e6sfxfayoneup4q7jjl7g5@47wjjuf5ifev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vl4v6mrd3vcbrurrsb3ak5wxjk73e6sfxfayoneup4q7jjl7g5@47wjjuf5ifev>
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=699c4202 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Yw25RUV23QuEbprx2WUA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: LozQLwE3Inj9X14OMcjoDEsBqzAIkBjZ
X-Proofpoint-GUID: LozQLwE3Inj9X14OMcjoDEsBqzAIkBjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMyBTYWx0ZWRfX+IBcIcj4oRBw
 fx6ckpAHtXgyRZa50HO5BORcHK9Dj2UgfhG8K47y7AoLG4BeLIhE5aFh+GJEhg3Hi6PUPlA3uwv
 GAxVC/IN2y12JLo8q5Rq+KFe3zD7Rpq+839eyCeQplwKXWGGDphIs5cqFjT+Uv4pQtnmoQycVp1
 m+XHN8bmv4wuSgO2SkybHqC5IMrTsXhSbSvAhUK7xib/I4n7OHoXAMEe/d0TzYb4EXLQ5bNXn4C
 kJNn1xxPzZZe8qjfwKA4KwJMP5QXk1GtFc25lhWqLfe/Zcjs33DZ7uS/qOcLiCPZldzpJZxvri0
 LRBVhdRX+rvBc2NsCgxfZ8PeStxzvO3EPhLnGvKxvt32C0rZ31ElUwt/ISnRJvA/tXmdfaolYCU
 mDNkQHijc4WuIBPpuqlyw3medm/x0Zuslsx/eZ/A/W9t/9AA7dMsSlepdWVjfTo3P9LnJutdpiX
 05o3hP06uh8eO/vPPoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43025-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84994175E80
X-Rspamd-Action: no action

On 26-02-17 10:15:22, Dmitry Baryshkov wrote:
> On Mon, Feb 16, 2026 at 04:23:19PM +0200, Abel Vesa wrote:
> > Add RPMh Power Domains support for the Eliza platform.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> >  drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> > index 19849703be4a..0c9a3995e06e 100644
> > --- a/drivers/pmdomain/qcom/rpmhpd.c
> > +++ b/drivers/pmdomain/qcom/rpmhpd.c
> > @@ -217,6 +217,31 @@ static struct rpmhpd gmxc = {
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
> > +	[RPMHPD_LCX] = &lcx,
> > +	[RPMHPD_LMX] = &lmx,
> > +	[RPMHPD_MX] = &mx,
> > +	[RPMHPD_MX_AO] = &mx_ao,
> > +	[RPMHPD_MMCX] = &mmcx,
> 
> Should it be mmcx or mmcx_w_cx_parent?

I believe so, yes. Will respin.

Thanks for reviewing.

