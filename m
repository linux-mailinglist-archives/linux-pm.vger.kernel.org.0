Return-Path: <linux-pm+bounces-35972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE9BD343B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAAC189DA84
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B7309DCF;
	Mon, 13 Oct 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="hjT4mlMZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBF309DCB;
	Mon, 13 Oct 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362949; cv=pass; b=cNgWb/uvDJtkvDR4IclFACBU6LfkDtv8XiGMORhv5Hmat+7QQa2EWnMCYROl6Y2M5dYn73S7zQlgmdW2Crxnaeo5BQGuGIY6gDqd0N5s7o1PXB01ja97W9I/nDRAseJfLDjKLq2B2XmkhzLZ42jyXuc1hbL+t8r0DwcZbhRincM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362949; c=relaxed/simple;
	bh=gDpPd5UzOQn8zDPGA7FYXf9y+izfyQBl4gvsqPled8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jge2RyXNAYD3f+1ABsHpG9H6qmodobPJMI2wOPuP87378HgG5Zt/yotmGhJ0vRNDxgUkVWvvIrUldCgXl9S+s9dOZXdBZGVeyhrjGqg6s8g2I/0cLJ/QCZs3wU04q8WDlJ4uvP2pnueXeeFbPTnzsQ2TCv0EzxajpmqbYUlHOZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=hjT4mlMZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760362921; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XIXkd09YTcHrxyEMy3Q47jCyFRdZdGg7DG/PawiO9mFO9t3j+QNvOECuDBMMf8OY8ZecH6Aig5NBab5wViVuE0Xn4ifoDV6O7Ax6Nva+yk0jiGWzm3gj/Fm8UclkzUuOPXIUskYCj4TPy913l7BWPkcwu8Ubxc2+qm9woMBl+CU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760362921; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gDpPd5UzOQn8zDPGA7FYXf9y+izfyQBl4gvsqPled8k=; 
	b=KZLBIJiEBTseT5PnJagP7TnThgzIguQKMRE+d5O1+q+QCFVGTiwXQ7MKaj5tBtz/rPPAieZ32iPp0WxsefkdUqLbzruXbNT/nkWwufQh6jE8OZB7ca0gBgoHL1q2vCZ8f4kBi7PAAhNztBrYalYB0i3yGtgms1G8fqfan5tO1jQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760362921;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=gDpPd5UzOQn8zDPGA7FYXf9y+izfyQBl4gvsqPled8k=;
	b=hjT4mlMZjMIWKVYikSKVmQYnNeZ5wGoair2n5QNpespSgO7wN5w1rrNzg0r9x4xs
	s9GP8XPPyEtfMZnBIE7gL6+eaSd5d1nOCTwK4OXYRh/mwjSu8vtFZXHtK/w2sqfmsAF
	BBJD9gPU7RSQCmYYPl7sa9/uXQrEsTMpEfG/k36M=
Received: by mx.zohomail.com with SMTPS id 1760362918105978.3996948303734;
	Mon, 13 Oct 2025 06:41:58 -0700 (PDT)
Message-ID: <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
From: Sjoerd Simons <sjoerd@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, conor+dt@kernel.org, mbrugger@suse.com, 
	y.oudjana@protonmail.com, =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado"	
 <nfraprado@collabora.com>, linux-pm@vger.kernel.org,
 ulf.hansson@linaro.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 	mandyjh.liu@mediatek.com,
 lihongbo22@huawei.com, wenst@chromium.org, 	matthias.bgg@gmail.com,
 krzk+dt@kernel.org, kernel@collabora.com, 
	linux-arm-kernel@lists.infradead.org
Date: Mon, 13 Oct 2025 15:41:49 +0200
In-Reply-To: <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
	 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hey,

On Tue, 2025-08-05 at 09:47 +0200, AngeloGioacchino Del Regno wrote:
> In preparation to add support for new generation SoCs like MT8196,
> MT6991 and other variants, which require to set bus protection on
> different busses than the ones found on legacy chips, and to also
> simplify and reduce memory footprint of this driver, refactor the
> mechanism to retrieve and use the bus protection regmaps.
>=20
> This is done by removing the three pointers to struct regmap from
> struct scpsys_domain (allocated for each power domain) and moving
> them to the main struct scpsys (allocated per driver instance) as
> an array of pointers to regmap named **bus_prot.

Trying to boot v6.18.0-rc1 on a Genio 700 EVK using the arm64 defconfig,
ends up hanging at boot (seemingly when probing MTU3 and/or mmc, but that=
=C2=A0
might be a red herring).=C2=A0

Either reverting this patch *or* having CONFIG_MTK_MMSYS builtin rather
then a module seems to solve that.=20

--=20
Sjoerd Simons <sjoerd@collabora.com>

