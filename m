Return-Path: <linux-pm+bounces-41921-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMGRJIj5gGn9DQMAu9opvQ
	(envelope-from <linux-pm+bounces-41921-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 20:22:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C0D0785
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 20:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED37301ABB4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852EF301493;
	Mon,  2 Feb 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hege47Hd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+GZBBeg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B52F25F4
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060154; cv=none; b=F2KFYphm93dxo9hhWwGzJ+LDzjeoio0rtdA4+WLD1Uc8+VXvwwkdGyqfr7Cw0CTIQVThChRJ0p1quwdxCZliIGQPuvWPmOYjjXxXjsNMCAO3dDP+JZVc1eXHWzL8hjvP0tA6Rk1KS302fmqjA6qgAsJ3q1WeDcQ/mjawGSN6FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060154; c=relaxed/simple;
	bh=DYOamzKGh7mXxypwNElwACUDgdhs4fTQAbquZDHGhlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+LA5Ps7rDQlaRcNWJYfD512Y/wyuhEozXjiVazG0xlyBM2nxtR7KUjcTtgQBokXs1mk+cSCvNYcOClXIVPHtifiHEOGexKOTiy17f3YJy1jn/yKbd8L6QuPnuKZqPdPqDSPIBFJRuODEyOvhaqGMaReX+gn4fziFxog7cRP3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hege47Hd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+GZBBeg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612HSjZo3743868
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 19:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=btWkS/c7dprwal4TPhyVpLCd
	6iARVOljRFkoRjoQnrI=; b=hege47HdG5UdDYNVdtzNh0EKWO1NWXkWYrNDKUpJ
	qZgcCBC1kRhLgqFNwgfkpmDbP1q27UF5voi1xmqP7NWXRQE7r/DVpga0Dmd+ojH6
	bDc0QXrXmBhFhGuloC55hF9gQllwqC1SBIf6CTL1MByFiBxVb9qy3znG4sfOEfwc
	PpeWGQ7Uu6cjSRffjRcc0Kl+69DISyFB4a1HF7W0pLIltEkleVjC7zeHnUEa+Vkr
	Dy39axWd4Pv4qKTT1p5PeGvD0lbLSeQ6Dlfmztz3lGUwOFia+IGX2iGRWemg5muP
	x2Rb1ET+nDPs06vlrCAeKFsJJJhXjFr6vXIRQOVZ3mELMg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tp0sht3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 19:22:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b315185aso898904185a.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770060152; x=1770664952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btWkS/c7dprwal4TPhyVpLCd6iARVOljRFkoRjoQnrI=;
        b=V+GZBBegDSpnnZTb5H+sm6BgTP/zi2382WgYfTQprtwJjdq1cQaK3u1fW/FAt6JhYY
         Gh3ANB86EMlQ04GPcaiZ0Sn81zTtfTasu7by+ca4YltMCilPa20c5PzQp5WytjpEaaxj
         dO+r05kCwm2H9g1KUXx6GTlSKTL79tD0ncjwLi5TYtATAed40/Sj96h0KisZU4Gy0g8A
         c1mbFP1J8PJDu/i4WX4CWDHctGoLxOfnlgUC1grOA2xqnKg8tRit0L698yzo3u/lhnf1
         dQ2C3pOFmXM91u15SpA++CJud1Xg3/VhoouF5VUE6L8R5qhCBH4LZAkwCzdTNmhUeJuc
         x8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060152; x=1770664952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btWkS/c7dprwal4TPhyVpLCd6iARVOljRFkoRjoQnrI=;
        b=PRgRnjZ7lt7QJTSTtPZgOgOynCK5ZdNOV29XWtzgYUQbO4EJULBAhGM4bod3VrtwOm
         E1bZEzq/X6ga/iTnaEekXDw5Q83WPDQ134rwzww61wOqjQGbKD1eUAaak8L5j+dzgMC0
         lANplsdSV6PQYHk5fB+C0usxAxwWq+kd/Dxc21RndMlTmIQAU8xzgsjp2dAsbx9P4MnP
         AOLhVWLzMnWprc7GRcfWFDwpCHZPVA/WSNu7qM/gYSRA8sg41Vd01oq1YIi13/SfWG6g
         W7BxTXuOPPidw9tRCfTjtirnKNSjd2qloGypah/fA6IuPsN4/u/2oKM1iSK8gD6UtRfF
         47og==
X-Forwarded-Encrypted: i=1; AJvYcCWtnE5Cixo6EOuvCAr0mNZnNZMpfvi+qxuyhbxUJNDZgNmiyEyWlbYHpXUDMxEkDUJMFvHGRVZo+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8II7bpQhzfv4tvqygWp6f1B9xaSrDIRdtuj4UZLjz6dUh13qP
	X2Lnfaypf7kaxFTadPAK2f6xh2YdBwVoHVS6dOX6Vx9RY52qVZ7jq85S0Uhf2aIX05k436TPJxF
	Aag6r4e0QOWPicpVmTWKMAjlRgr0DJyv+szMQQhLPmkX+qeS+FRDcGNYMS9NSIQ==
X-Gm-Gg: AZuq6aKo9Rou/XTJRHBayUlJ7XhlFbMb27nVI3csh2rsWgMh3QmkeCX67D+q0wIy56J
	mnVKEjdF0mivetvXC8xcCNsM6iohFwIkhY/IM1v11gzZ60YKlYQuiFivlw0J7kIVXftlIyQiXM/
	TY5tJvZtsINi9HbLFW5EGPsf492iZiOeulTm3vBjvreEikqYx9s0IhnRKwdPz1X2c4GCxbAaXl+
	1opjbhwZIAf6rsBD/cNirCtTQByUhf+lPlZBzK2WwEaFRgdjq25amlIj8wKC+ccUqU7+24VKU2A
	dJ7h//wK0sOWqWQ+D87Bf/4zOlAr90uFH0E/I8PR/oDfgJxjRaJla8d6hWUHvSxnpAyGTdju8dP
	u8x8TphusCZGmZb8cjZBZ4yjKyeSl4A7NTe0de+b/GNMUgo4bnO2vao5a1I976Rrb/28Q82+hrV
	bza0OGwJMYwgE2JzjSgBPfa+Y=
X-Received: by 2002:a05:620a:254f:b0:8b2:e70c:427a with SMTP id af79cd13be357-8c9eb2fac2emr1664616485a.44.1770060151652;
        Mon, 02 Feb 2026 11:22:31 -0800 (PST)
X-Received: by 2002:a05:620a:254f:b0:8b2:e70c:427a with SMTP id af79cd13be357-8c9eb2fac2emr1664613685a.44.1770060151233;
        Mon, 02 Feb 2026 11:22:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625f8b70esm35186351fa.34.2026.02.02.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:22:30 -0800 (PST)
Date: Mon, 2 Feb 2026 21:22:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/8] media: qcom: iris/venus: fix power domain
 handling on SM8250
Message-ID: <l6o4lv2sy7x4g33mjigeh6sb6cmrfyz3xshhmbc3el6qvw3oep@okwpfykypawa>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <CAPDyKFoNX087ZhLkQ_n8-42WNQcL06noSuPJPDG87y0andVdNg@mail.gmail.com>
 <CAO9ioeXkhxjghtGVGsOH=1hwC5FvS_4LEXt3hmAEuAbwVjct3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9ioeXkhxjghtGVGsOH=1hwC5FvS_4LEXt3hmAEuAbwVjct3g@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 954jGH8a00dO7nGzFlaBFjNNe7AcfPKp
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=6980f978 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=AedQi1eqkiGwAd17v3cA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MiBTYWx0ZWRfX66qiXwgFqJg+
 m6l9wtQ/T2CpI255nVoYgESTtE2dSC/vR45+JJO8Uop7IRAhLGcX1k56m5zZJeuwJGRuu8I+rIP
 3Xjog1T2VzT+ziah/4iLOF5vjh7/KUMNPMOdC4G6QMkxW2dE1UnOF31h83bs6DBgE/oxlpQyq9E
 dRMlavxDdHai7E9sghDniISkrTEfH0eOK2Qnk70QHuBZDrR/CtSfGJrZ0J5B0ixBTCLCWt5Y6vu
 obEVR4s5HAj7egQhYe5y+OjM9bIbdIJ0pSQsad12zES/y2RTjOmgLX+KqGoYpYyI/nbE+DxbFjc
 5p1cJY4VYN+Dvy5riaEtZqiDf3M6Ly8hYGGNvKQP8s6/h2cjz4FwFWOQvs8m96K+fVzMlrv91E6
 +PJ34VfEl9hc1FPL+Pu5iebh9L2zhp3Ex3TiwDb0ZGHffQekvAhj991AB38iNqzwilQk3fTIm8B
 VYiWpYxiqKLq89UgEmA==
X-Proofpoint-GUID: 954jGH8a00dO7nGzFlaBFjNNe7AcfPKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41921-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2F8C0D0785
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:51:16PM +0200, Dmitry Baryshkov wrote:
> On Mon, 2 Feb 2026 at 16:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Sun, 1 Feb 2026 at 11:49, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > As pointed out by Konrad during the review of SM8350 / SC8280XP
> > > patchset, Iris aka Venus description has several flows. It doesn't scale
> > > MMCX, the frequencies in the OPP table are wrong, etc.
> > >
> > > Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
> > > stopping it from being overclocked).
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> > Do you want me to pick up patch2 for v7.0 - or what do you suggest at
> > this point?
> 
> I'd prefer it if it is picked through the immutable tag/branch.

Another option would be to ack merging it through the media tree.


-- 
With best wishes
Dmitry

