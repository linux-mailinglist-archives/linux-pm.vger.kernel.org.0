Return-Path: <linux-pm+bounces-23124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F861A4868E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4469F1695E5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9D1DDC21;
	Thu, 27 Feb 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UttddZXU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF971A841B;
	Thu, 27 Feb 2025 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677100; cv=none; b=DYpvHbbvs6f1keBcx/x/2JysqfoKWDJDLTyYQNLiiZ7bIdT/my7b4TN5T8U2r+FX5j1G84m5nyDCDJ8c/YWhCTYCgydmWR2KKpbqbacSJGz/K+fSKS4BCzDOj4SGvA8hLMI0aY9t9EPuXo+KIN4tdF7bv7rRHEPTds3FjZZ/l0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677100; c=relaxed/simple;
	bh=30fEOChuXPuQizgWsKYGoHZgd3JOsgWYZ6vexdohouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiycKogpjZvP41C+bNM5q7ZBNh5D4p6W5XzXCbl3J2c+00gEHbCExBdOkYPIAKLDhnrYNxHXNEzHGREMmsG9hfHJ7gUko1KMJDRAGTxmNoajYaEQG5kUrxzl/zUXREr36/dpjBW61M0xHnlRkFJ3NipH5C48dmgVzLM3pZv3PxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UttddZXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54550C4CEDD;
	Thu, 27 Feb 2025 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677099;
	bh=30fEOChuXPuQizgWsKYGoHZgd3JOsgWYZ6vexdohouU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UttddZXUoRgNyM8txwGs+X+ABYWRG4HdDn/zgOU5eY7vezx1Vng7djeduqijLBROR
	 0YWT2HQsDV5cHRCTcAaLz9Ur8Mtb/EXog1TLUN7MevgZIL0cYzCIOAwYaBPM468gqy
	 7GQe4dWy351dHtODgJn19HHh57Css70hxKz0BCXbzTSUB22hLnGsobPKsO2QxkgCbS
	 gKI93a75t/k5qdPBoqgR9qK46m1ED6ftk/p9YHcnMyS71MERHiDMlnLUz2M3GOvYGi
	 6bFo4TJ71uMXHGDPLYc1+0DbMqu9vmqaaLlm6mgwbrolIqx9rFTGNgbH8Etkn8J/2I
	 kOjDwsM8byO2g==
Date: Thu, 27 Feb 2025 11:24:57 -0600
From: Rob Herring <robh@kernel.org>
To: Lee Jones <lee@kernel.org>
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
Message-ID: <20250227172457.GA3415187-robh@kernel.org>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-5-val@packett.cool>
 <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
 <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>
 <20250227154833.GF824852@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227154833.GF824852@google.com>

On Thu, Feb 27, 2025 at 03:48:33PM +0000, Lee Jones wrote:
> On Tue, 25 Feb 2025, Rob Herring wrote:
> 
> > On Mon, Feb 10, 2025 at 10:37 AM Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Thu, 26 Dec 2024 01:58:04 -0300, Val Packett wrote:
> > > > Update the MT6397 MFD driver to support the MT6392 PMIC.
> > > >
> > > >
> > >
> > > Applied, thanks!
> > >
> > > [4/9] mfd: mt6397: Add support for MT6392 pmic
> > >       commit: 896b1eb4ca771b37ea50feb4d90a78dd4e9cb388
> > 
> > This should be dropped. Missing the sender's S-o-b and the rest of the
> > series has issues still.
> 
> Are you sure you're commenting on the correct patch?

Yes.

> > Signed-off-by: Fabien Parent <parent.f@gmail.com>

It was sent by Val and is missing their S-o-b. If you send another 
author's patch, it needs your S-o-b.

Rob

