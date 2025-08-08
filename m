Return-Path: <linux-pm+bounces-32075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D156B1EF28
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407107AD9F4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E672222D0;
	Fri,  8 Aug 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Gr2Alh4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9191A3167;
	Fri,  8 Aug 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683425; cv=none; b=aCD7RTWOXLgy2X7T++FTUcOk4TRp9ERMer5K78qnbBvbIW3ArE0MeHl7Z218eg4aYD3XEm3Vjo7Q4VIHmr183vLei8GnRrCJayR729TVwqYmfe7ftYfe7YjeTK2WcduZJRAFcADFgvLRoK/zSUcKfjzhK5/w24y2cVrfxUgsJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683425; c=relaxed/simple;
	bh=gKRagEStvgjsGqBz58+tTFcCLr9nfkR8v6kbDBTUNds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMse1ui8jx4KhzooVDYSd023148miG0sI7klNiGMUgCbwdHz780M/+gjvi7UF2JuKRKo+A41xf7dTmhGRYAY2W66M1W4UvyEaY1uTILOg7y2RChdw7zaVOvSkmQqxkUhqerPunRwf6AbYrOPcym4qQFKFTP6mA7jDS0FHavC4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Gr2Alh4h; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=rm/KaI4gS5txCax60X3cOFqmUOa0+shLoOnPWo3LZg4=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754682419; v=1; x=1755114419;
 b=Gr2Alh4hi11EAN9rear4dDOE8QlaR46SNQPsFD1ooegKRm0HJHYnFWdUO9dBzTAtGiENCnPM
 huKFchm21m8KKgRpiQItKnlXXQDpE80TXeVrwL2HUT8EpOrgrv2g2D3/zqdBH3cPO/qFaOEtuKk
 oY7LL1TFJB9sCPodsO66g3HWZeR+Tv1Len1w/BvMvToZbblZG4k3kJQY8n//8yTuBFcwHdikJUN
 ssJk/LQlEjCXtiG/hpDsFSVMqhJPwPf1tlX++/avZQObwj3Oibn5qL4bFFm2HQ0LRDzFeRj4UmC
 kkzB0oBE0bugbMVT1WJnhN5pklZ8atDGCn8ZRWUbwzF6w==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id ca151574; Fri, 08 Aug 2025 21:46:59 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>,
 Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] dt-bindings: power: Add Marvell PXA1908 domains
Date: Fri, 08 Aug 2025 21:46:58 +0200
Message-ID: <2017616.PYKUYFuaPT@radijator>
In-Reply-To: <20250808-portable-expert-turkey-4f8f19@kuoka>
References:
 <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <20250806-pxa1908-genpd-v1-2-16409309fc72@dujemihanovic.xyz>
 <20250808-portable-expert-turkey-4f8f19@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 8 August 2025 09:34:54 Central European Summer Time Krzysztof Ko=
zlowski wrote:
> On Wed, Aug 06, 2025 at 07:33:21PM +0200, Duje Mihanovi=C4=87 wrote:
> > +          A number of phandles to clocks that need to be enabled during
> > domain +          power up.
>=20
> This does not exist in your example, so it is just confusing.

This is because I have not implemented any of the clocks used by the
domains at this moment.

Actually, I am not sure anymore whether it is necessary to assign
clocks to the domains as I have just yesterday successfully brought up
the GPU with some out-of-tree code and that did not require giving the
domains any clocks even though the vendor kernel does this. Should I
just go with that and drop all clock handling from the power domain
driver, at which point there would be no need for the individual domain
nodes? If not, how should I in the future assign clocks to the domains?

> > +examples:
> > +  - |
> > +    #include <dt-bindings/power/marvell,pxa1908-power.h>
> > +
> > +    clock-controller@d4282800 {
> > +      compatible =3D "marvell,pxa1908-apmu", "simple-mfd", "syscon";
> > +      reg =3D <0xd4282800 0x400>;
> > +      #clock-cells =3D <1>;
> > +
> > +      power-controller {
> > +        compatible =3D "marvell,pxa1908-power-controller";
>=20
> No address space, so this should be folded into the parent.

By this, do you mean that the clock driver registers the power domain
controller through devm_mfd_add_devices()?

Regards,
=2D-
Duje



