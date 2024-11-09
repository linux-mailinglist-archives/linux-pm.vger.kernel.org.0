Return-Path: <linux-pm+bounces-17274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC29C2E2E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5501F2196C
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316071991A5;
	Sat,  9 Nov 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fNGukyW9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E506E2BE;
	Sat,  9 Nov 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165984; cv=none; b=hw4qW9BBJIumVSIqNPPbf5FIoJ1zg0c4AOyOjvB+8S3MNJI06ANkh3cL2GcLOW4hpWgzYKFU2DZgC6OyyN8hA8vgkNmhEJurPHX3bTYZBAEecpaT6qu6Fz5z2jXiheSOHS3IN0/iwLlIwMrYGrIJZyxRzn+1rn8R9GzQzVtW1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165984; c=relaxed/simple;
	bh=C2Fu967BHeELtFrqODTzmYpCvZ5v2z8G/kwBzGgDw+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSqggUUK0BcS1rXnNM8k7OjmkvUyNg7KYTeoTIc18ZOJ3JG0rsqK8h2wTgO2olbvjFnV3oLnk9gJyXBF8pkz2Br2UVPq/uK38JzF2VASA925ofjoLndX0EbosZ9JCDDWi5kEObrk4DpsNyCryl+/xcdRwz8VE6cUwTDjXKi1JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fNGukyW9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731165980;
	bh=C2Fu967BHeELtFrqODTzmYpCvZ5v2z8G/kwBzGgDw+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNGukyW9cXlI5Me5NYcTub74uTNzYhzKxvGR92Pe0/y7V+RLnTESg08QeiXLF9esi
	 vI5cC09w0mrhryCs7vuCsjJheM9NCHjMjRcdRL4fRduv2RzP6DeDNebvMyp1uTBAmu
	 ZClu81a4fVOQy9t8LaOd7l9ptYQW1oEBexJaafHHC+LhjAjDnkoO0aolxdPXaWp4YI
	 TJxkS7rCscphXs3c+/P8LiqWxZ2t0C8Yq/3giiFj1EIgIMPfotDMzth20mWzSMhBAP
	 wGeXj2JvuWvJSy3wHvIESHMZ6iGRlclA5qO++vWcGiuA+7AeimDAzn6mggMe63PF/A
	 ie3FZQcz9f2Vw==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1FFE817E35FA;
	Sat,  9 Nov 2024 16:26:17 +0100 (CET)
Date: Sat, 9 Nov 2024 10:26:15 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to
 IMMEDIATE_MODE
Message-ID: <a641e6b8-0078-4910-9826-a088e69b734d@notapiano>
References: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
 <CAGXv+5EOcg0pQxj=iOn_ff8-t6pyGKwemA9mdn=VCpxg6Uzt+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EOcg0pQxj=iOn_ff8-t6pyGKwemA9mdn=VCpxg6Uzt+g@mail.gmail.com>

On Fri, Nov 08, 2024 at 04:21:07PM +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 8, 2024 at 2:51 PM Hsin-Te Yuan <yuanhsinte@chromium.org> wrote:
> >
> > Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
> > IMMEDIATE_MODE will fix this.

Do you mean that the whole MT8192 SoC is not able to enter system suspend? I
just tested that on a fairly recent linux-next and it was working without a
problem. We need more context here.

> >
> 
> Probably should have a Fixes tag.
> 
> Also, Nicolas previously reported that the threshold interrupts don't
> work with the immediate mode [1], which is why filtered mode was used
> in the final version.

Indeed. I suppose it would be possible to configure immediate mode only during
suspend if this is really the problem.

Thanks,
Nícolas

