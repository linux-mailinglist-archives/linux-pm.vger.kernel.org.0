Return-Path: <linux-pm+bounces-23126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C2A486E7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1787A36EE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A11C5489;
	Thu, 27 Feb 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itq4eoKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBB270054;
	Thu, 27 Feb 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678342; cv=none; b=L/77+54B3xzcP42R9xFNLZNGJHWq4VgEoVSKrRr5ygP6RPsJ5w8ALPMO+h1g5IE4kWceQiDX5k5cEHerZoH9o2bKAT0n5LeAJge2a+PB5y+JBgNG6rua1Ty1+EI5OqmfXLqurHOGwU8OgOAJlORqiwQEYmBI5RuEOEs7iqfgqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678342; c=relaxed/simple;
	bh=axlj6OwJVLYwr+IYJL39G4o+MqL7DKsYZuPxTQMr9eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtiZiMZPktkL08rpqGeAb8kT5MKg9R3fYcK34+8GS27sDx908r3NZubgcLT9UGzEMOJxR7tCdSqpt27UReeX56uWUutW5QV4xDgn2kJd65yFrH+Hp80c/de3/j8zaN049rGA+lpI9gAqnnvCpClGALSs4H0WBe+1bVGmuEXodXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itq4eoKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9685C4CEDD;
	Thu, 27 Feb 2025 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678342;
	bh=axlj6OwJVLYwr+IYJL39G4o+MqL7DKsYZuPxTQMr9eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Itq4eoKtNVNpeFYQ7F357k3WR+YxDtrfU/WrLbn773ZYNI9GB1aPTUGoFWFTPxK1s
	 ZPRPgYSCBXlEQQYxeeA184qAcY+WqsJUXllKK+DG5A1S+iTbcnxf08pqIG80X9whzu
	 8Keuii1YTeNMBU54jhF7Leb0TuETm/Nr5ngiNPyjMN9kiRfW3+xakpRGAE6IT5vIvk
	 du7MXtbCYIbfuCLkdgF9p1TwiFue1ekqKjL7YM/wWeZEpTMrDhnZzySqX7Fqv7+K4+
	 2y71/+2T8whsUxscXC74/WzJzU2a2XC8kFsnYkP2itqPEPn1f6T+0GeqBTUi9PPnP1
	 u/cy38V0JG4qw==
Date: Thu, 27 Feb 2025 17:45:35 +0000
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
Message-ID: <20250227174535.GI824852@google.com>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-5-val@packett.cool>
 <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
 <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>
 <20250227154833.GF824852@google.com>
 <20250227172457.GA3415187-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227172457.GA3415187-robh@kernel.org>

On Thu, 27 Feb 2025, Rob Herring wrote:

> On Thu, Feb 27, 2025 at 03:48:33PM +0000, Lee Jones wrote:
> > On Tue, 25 Feb 2025, Rob Herring wrote:
> > 
> > > On Mon, Feb 10, 2025 at 10:37 AM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Thu, 26 Dec 2024 01:58:04 -0300, Val Packett wrote:
> > > > > Update the MT6397 MFD driver to support the MT6392 PMIC.
> > > > >
> > > > >
> > > >
> > > > Applied, thanks!
> > > >
> > > > [4/9] mfd: mt6397: Add support for MT6392 pmic
> > > >       commit: 896b1eb4ca771b37ea50feb4d90a78dd4e9cb388
> > > 
> > > This should be dropped. Missing the sender's S-o-b and the rest of the
> > > series has issues still.
> > 
> > Are you sure you're commenting on the correct patch?
> 
> Yes.
> 
> > > Signed-off-by: Fabien Parent <parent.f@gmail.com>
> 
> It was sent by Val and is missing their S-o-b. If you send another 
> author's patch, it needs your S-o-b.

Ah, gotcha.  Yes, that's fair.

I'll pull the patch.

-- 
Lee Jones [李琼斯]

