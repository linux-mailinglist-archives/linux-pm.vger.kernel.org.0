Return-Path: <linux-pm+bounces-23085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF9A48375
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3F93AC1F4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A259190470;
	Thu, 27 Feb 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig5dzZ8T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CF1624C3;
	Thu, 27 Feb 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671321; cv=none; b=Sb0C+uYqm69kbqBLIYrn57c+0Ss/LNuP9mwQQYGpYEboeAmysE9dCTfav6g5/tVdULPILpRzpPg9EvvHEjsfNKn40FzYrFm9e+0di2mH8NeVuFYz6GJxy0kEweYYnIjtHTwIC4QWsNoiIKh3WzPDc3pSVhGryi0HAKB9VWei70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671321; c=relaxed/simple;
	bh=CLYYqdvqAO/1n/BWxTVd5NjOz2LQ7O10iJ3SeN8ieto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogUXIv+9nMUmKeoaNUf0DNgwv7IKagsmHzYxrIhrDHtTpSBE9+2sn5TPglmz18CPLsLeCHMbXXRfqchxUpx/uqpv8rP+pqbbbFfTUM9nIIocBy88daT6htbPDr39SNWl2yXIqSsGMHHaEBblTEXvGdwwW2YN7VPSoQWqpg9waWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig5dzZ8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C62C4CEDD;
	Thu, 27 Feb 2025 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740671320;
	bh=CLYYqdvqAO/1n/BWxTVd5NjOz2LQ7O10iJ3SeN8ieto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ig5dzZ8TAwZWWEUogbZOP0QgD1qHUzsLdbmSun7YoUzDjsEP0GthlUE9htneHutDB
	 VaGxjs5Zrax/HT0PddHlA1xYxsrIoWEPVMGSvtKu8iX8aetP+G/BehmXtmd3VEr4jk
	 emRqbvQnnJCENiFdXXZsm+8WqTtKpKvlCx8o47TyAoMyuHPGBQYtSqE1aKJZq9RpZ/
	 WcONZgDt4qBH8kT6NwAjrNzLFHRzpsp4BVFzb/zg/yQf5adlkKhmXNshvNnNtYLZSO
	 wdn7F9NnUAv9M0iagr6jCpFuQkB1xfD2XJ2VPQrTppcC3fOjc3M70M9VrFwyTk58oY
	 wxL5i48eqfGSA==
Date: Thu, 27 Feb 2025 15:48:33 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH 4/9] mfd: mt6397: Add support for MT6392 pmic
Message-ID: <20250227154833.GF824852@google.com>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-5-val@packett.cool>
 <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
 <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>

On Tue, 25 Feb 2025, Rob Herring wrote:

> On Mon, Feb 10, 2025 at 10:37 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 26 Dec 2024 01:58:04 -0300, Val Packett wrote:
> > > Update the MT6397 MFD driver to support the MT6392 PMIC.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [4/9] mfd: mt6397: Add support for MT6392 pmic
> >       commit: 896b1eb4ca771b37ea50feb4d90a78dd4e9cb388
> 
> This should be dropped. Missing the sender's S-o-b and the rest of the
> series has issues still.

Are you sure you're commenting on the correct patch?

> Signed-off-by: Fabien Parent <parent.f@gmail.com>

-- 
Lee Jones [李琼斯]

