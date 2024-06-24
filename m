Return-Path: <linux-pm+bounces-9894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C974914EAF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A841F22197
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A61422D3;
	Mon, 24 Jun 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="JSYhimIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A91422D2;
	Mon, 24 Jun 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235855; cv=none; b=KKph//1jZXMS85JgZ1xBzU+nSwCaQMR4Ra/FUjSBIAyLU4VmG1gp4Jo4pkSsGjXGYF6QwY0xPBZTWg25Sf2Py5Z0oYm1x1lUy1cjyQaVzWv8ZL+5BEAXKxrup7U9aUAj2gDPAfI/oB4KjIGUJHQUVihrcyLcc8a1w5TXVXaXwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235855; c=relaxed/simple;
	bh=V0W8v7eOSgBIv9G+frPHE2Z1il1rD80Mc41wOYJ6YAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hO+jFlnGeW/4XchUn6S6TSVZ9/M2sWk2MnBSmsl0dCK/BdLLz+yEo2wLoMyl3raMkf/k05yF9hth1cziuW5TXLfxyeTJUS1TfRYWK9xRUfEQx/0WVKB8YUHdRkXqFlqAl/ArdOgBImb5JxQC6NOx5fSdXOyd5xSkaf0PobYXcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=JSYhimIt; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719235844;
	bh=V0W8v7eOSgBIv9G+frPHE2Z1il1rD80Mc41wOYJ6YAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JSYhimIt3W0mmXQB6OPd6xdvo9R1VcwcAyXMAIwd3fG4+7aARSiJcZPwfM0Kfjqqr
	 Jcbgyx16XcJDRsJWBOTju95k6fSIFWbmj63lFqNkS3wHfxwVogFK2pOjuemG8ynb3b
	 aL906+Hq+wf9Qt4E8qBhe0oxNJc6mRuqxEOnUKvc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D95086760D;
	Mon, 24 Jun 2024 09:30:42 -0400 (EDT)
Message-ID: <1dc3823c0f0a459ae033a69b2eeb3d2929254fc2.camel@xry111.site>
Subject: Re: [PATCH 0/2] LoongArch: Add Loongson-3 CPUFreq driver support
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki"
	 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huacai Chen
	 <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
	 <jiaxun.yang@flygoat.com>
Date: Mon, 24 Jun 2024 21:30:40 +0800
In-Reply-To: <20240612064205.2041548-1-chenhuacai@loongson.cn>
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 14:42 +0800, Huacai Chen wrote:
> This series add architectural preparation and CPUFreq driver for
> Loongson-3 (based on LoongArch).
>=20
> Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
> IOCSRF_FREQSCALE set. And they has a micro-core in the package called
> SMC (System Management Controller) to scale frequency, voltage, etc.
>=20
> Huacai Chen(2):
> =C2=A0LoongArch: Add architectural preparation for CPUFreq.
> =C2=A0cpufreq: Add Loongson-3 CPUFreq driver support.
>=20
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

A question: is it OK to enable cpufreq when overclocking is set via the
firmware?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

