Return-Path: <linux-pm+bounces-13120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635B963D17
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08302B22EE9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8CF158DB1;
	Thu, 29 Aug 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="IZ/gks+F"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7613172BB9;
	Thu, 29 Aug 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916806; cv=none; b=kLbmKFS8vXR9DNkj+554/vYm0F5nnB+JkPmclqGwPljmcD7qk9hD+/Ij5aD6Upue0pDT55t62vG1TSSSVj3qIvCIJpplgYmk6G77ZAJAS1CTAC0oCy3HxgDLNM+qL3335wiRnMwWxhY42PtfjT822AKp8j7KSsrv0idnU+yZQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916806; c=relaxed/simple;
	bh=E5OX7HAxlA8Vy2WfcHLUZm0GlAKyn3CH/vbK54+PYkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kM/nzJ5vWkzkOXVKDEk18NG07pMdfkBm41xcoM7Lv6bTf2Nay13uCUNd4IGSh+yMND2JYMTX/CM8Vm25IfOQN8FywkopdTyfwaxd/iAJ6fOG0H61AfixqIpM0ZD5cYra1RJVXkwiAYl6VvigCSz8ZEVck+NK8nSkL4kx0Is6TQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=IZ/gks+F; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724916803;
	bh=E5OX7HAxlA8Vy2WfcHLUZm0GlAKyn3CH/vbK54+PYkc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IZ/gks+FRZKpPJaQKWCETYPWQCPq0sGc9qSkO4VCu3B5QhLUZccBjOBnyJQkcbDpH
	 qwHMUglivZjQJZEvzrcDX/pMqs2tg51tlO1uKBVWgqxrDuQ1SpDAW8A/sgJ6o0L1FY
	 RKch1WJBmHdsYSYQkbw0wIcWog4/73bzqYZ2nNwE=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0F7BF66F26;
	Thu, 29 Aug 2024 03:33:20 -0400 (EDT)
Message-ID: <baba6eec7a1f66dc8b82d5e16612d0703dd33c81.camel@xry111.site>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in
 do_service_request()
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki"
	 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	loongarch@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
	 <jiaxun.yang@flygoat.com>, Binbin Zhou <zhoubinbin@loongson.cn>
Date: Thu, 29 Aug 2024 15:33:19 +0800
In-Reply-To: <CAAhV-H6YLg1ipUf-45-0zF6HRcCfkVikwQM5cAD7_VSYyAsfoQ@mail.gmail.com>
References: <20240828062459.1853837-1-chenhuacai@loongson.cn>
	 <affff6410e681152c3fdcf3512df76d734f29aeb.camel@xry111.site>
	 <CAAhV-H6YLg1ipUf-45-0zF6HRcCfkVikwQM5cAD7_VSYyAsfoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 21:55 +0800, Huacai Chen wrote:
> > Do I need to modify some firmware setting to make it work?
> You should update your firmware.

I've already updated to UDK2018-3A6000-
7A2000_EVB_V4.0.05756_prestable2405_0523dbg.fd on a XA61200 before
trying CPUFreq.

And I also tried enabling DVFS in the firmware setting, and disabling
the overclocking.  Both didn't work.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

