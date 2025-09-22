Return-Path: <linux-pm+bounces-35149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F8B8FC1B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3767A2111
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EA287254;
	Mon, 22 Sep 2025 09:31:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25F279DAD;
	Mon, 22 Sep 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533468; cv=none; b=GIQ71txFTZcRvOs0WSHf33Ih5ANTD2UCdU7X1DHDBXp5q58c4bJD7t5pL19bSFFQnwlSruWa9Zf69XnVJbiPIhC2q3fbUVAjwg40KHIV6taBwyLW7AsGTyohVN9D/KCJjnUnbY2zVYE9c9/djG8XSJJnZ0coEp6bpx5ql+pZIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533468; c=relaxed/simple;
	bh=PhrTQha9+wsRa000TsVoYqxA9+ogH3hKIDIHjWjgaHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSPXEeyANvN2KlVPuwqwlXdAIEl4Kl+zAOjLP5TfZu+ur6D7WxMIkzgr8vxLcih8H13r54Cfi5D10yDDj8WpWTWXaObLOsAXiKZe2E+2iD3K1BKBjGWclDsfNVR1Glw2LOho8UiIcDMSooJv2jqO4NuftnleXNOtrY1oKHbXPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d7e934b2979611f08b9f7d2eb6caa7cf-20250922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5fb6092d-f6d5-47fa-af2e-9468285061cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:03ccd001aaf2432aee1f691bbbbeb582,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d7e934b2979611f08b9f7d2eb6caa7cf-20250922
X-User: zhangzihuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1987420254; Mon, 22 Sep 2025 17:30:57 +0800
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	viresh.kumar@linaro.org,
	zhangzihuan@kylinos.cn,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH v1] cpufreq: Replace pointer subtraction with iteration macros
Date: Mon, 22 Sep 2025 17:30:54 +0800
Message-Id: <20250922093054.106986-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0i4V=ayEXRfJXduR-15jvVHgP_Cmc80WfhQoDv7N5xGjw@mail.gmail.com>
References: <CAJZ5v0i4V=ayEXRfJXduR-15jvVHgP_Cmc80WfhQoDv7N5xGjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> >  drivers/cpufreq/freq_table.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index d5111ee56e38..ca06a0236e70 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
> licy *policy)
> >         struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
> e;
> >         unsigned int min_freq = ~0;
> >         unsigned int max_freq = 0;
> > +       unsigned int i = 0;
> 
> This initialization isn't necessary because
> cpufreq_for_each_valid_entry_idx() will initialize i to 0 to start
> with AFAICS.

Got it, I’ll update the remaining places accordingly.

Thanks!

