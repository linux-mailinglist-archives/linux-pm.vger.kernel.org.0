Return-Path: <linux-pm+bounces-32074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA807B1EF0A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 21:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41635A0302
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EE288C1C;
	Fri,  8 Aug 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="FwqlN8NA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878C285CA1;
	Fri,  8 Aug 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682719; cv=none; b=WA5MFbg44TcXr+ALovn1YVHKnRd5iJ3rsHcJpoysaDEM4TKsH6ZHGg4ycpIwgekIgArq94PJVkHbzTtMd05/WhqzzFoeOsnH7E2v76KeAKyVrb9m39oGSrcB6krEq1K4uX/VJ5mwOmKKiQAYC+ZsF02J2xquiMWBnS7WiAUIJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682719; c=relaxed/simple;
	bh=qdUpktaT2gX2CFPhryadTKFXcXwjP0lNYT9ptGL5Ero=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCIQLTYJ+k8T8ZwsNGdLjOEK2PRYrCEDs8fqYJGDD+sp+mNErQQcZwVBTGcXYBi7cwvc36N3Wh9/2bf2+6cMPbs0goQ5QQUBIjLQ2lEmXGc/Xc6KjkruXeVH9s9gIzzL3dBN7FuYo2zI4O1iWfe2Le5QhYMmGYuh5Jla4rvbtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=FwqlN8NA; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=qdUpktaT2gX2CFPhryadTKFXcXwjP0lNYT9ptGL5Ero=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754682705; v=1; x=1755114705;
 b=FwqlN8NAHSWMHPWImW/qCeBBypphh29Fvae2amh997SZV8FG1egAwUkT8FL1GgXqTn4q2iwQ
 /kyfnHPdWEAbwqgvMeqnP/LgTJs9LhXgdtelqkz4VIlyPZ0vqk7CjDNBjLrAq8lWoEuSE4SgJ5j
 2xgL0xif2573ngFwGRjxWB7cbN8+IKMbrjQfJfr8g/TCj9k3DlIL9CDxp5XuKYv2KWjWfJBkUoQ
 osu1EaE7Yi6W3z4EScUg2i6ALlRfcwRiyYptDRcTJ31iv3eJfx3yS3XS/VrGmcbKjZffQOYNWD/
 g1U0jMCC6FxYWCqR7LS9XiECNiF+Ix7GYD1AdvFDLdT9Q==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id be47afdb; Fri, 08 Aug 2025 21:51:45 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Conor Dooley <conor@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>,
 Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Marvell PXA1908 power domains
Date: Fri, 08 Aug 2025 21:51:44 +0200
Message-ID: <3650391.iIbC2pHGDl@radijator>
In-Reply-To: <20250807-avatar-comply-30aa8001aa82@spud>
References:
 <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <20250807-avatar-comply-30aa8001aa82@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 7 August 2025 17:40:28 Central European Summer Time Conor Dool=
ey wrote:
> On Wed, Aug 06, 2025 at 07:33:19PM +0200, Duje Mihanovi=C4=87 wrote:
> > Hello,
> >=20
> > This series implements support for the power domains found in Marvell's
> > PXA1908 SoC. The domains control power for the graphics, video and image
> > processors along with the DSI PHY.
> >=20
> > The series is based on master as the MAINTAINERS and device tree patches
> > depend on the very recently merged initial Marvell PXA1908 support seri=
es.
> > That series can be found at the following link:
> > https://lore.kernel.org/all/20250708-pxa1908-lkml-v16-0-b4392c484180@du=
jemih
> > anovic.xyz
> It's not clear to me, nor mentioned anywhere I could see, why this is an
> RFC. What are you actually soliciting feedback on?

Apologies for that, should have mentioned it right away. I was unsure
whether I was handling domain clocks correctly, which is one of the
things Krzysztof since commented on.

Regards,
=2D-
Duje



