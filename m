Return-Path: <linux-pm+bounces-10501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B265292561C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41F91C23010
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B89139CFF;
	Wed,  3 Jul 2024 09:07:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B5288B1
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997667; cv=none; b=kvq/U3YDaOZ580GTrnC+tcFLQgZjBkSAWOjN/TGig+QtNsaRAbeLASbGxvw5W15/OvOij9x8mskK5U0+vK9U6xnW00Vdd99tD/XmZN+b8LO6jrcR4gHmjHYZUFsTn3XnuYKRcjgdkboAdfpmWwvmzjPstb1fbt048lo9sSQfadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997667; c=relaxed/simple;
	bh=s6h9XDw8jWbAhqrj73COkhstUIbRDr+18bT4dnChEwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtdHEAQ988ED2VG74iB99QI7h2otl3D0bRxfAK6tRtFVU/bn8SZY1y0qPctpXD6jFOLsPSEgiHHAMWs+5BFG5PGIDJiLUQQVflCHvLTViQtMJSrvvg4/XnPTcASNzTuwJ3QXF+DJ34LujsvJzcVTFHacbhb9uYpxnIYygfvHjaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOvxX-0000Iq-GT; Wed, 03 Jul 2024 11:07:27 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOvxV-006oeI-NR; Wed, 03 Jul 2024 11:07:25 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOvxV-0004B9-29;
	Wed, 03 Jul 2024 11:07:25 +0200
Message-ID: <8b983eeed06426f0a6b43226a1bb40edac522a20.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/6] regulator: core: Add helper for allow HW access
 to enable/disable regulator
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das
 <biju.das.au@gmail.com>, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
Date: Wed, 03 Jul 2024 11:07:25 +0200
In-Reply-To: <988df019-00d4-4209-8716-39e82c565bf1@sirena.org.uk>
References: <20240616105402.45211-1-biju.das.jz@bp.renesas.com>
	 <20240616105402.45211-4-biju.das.jz@bp.renesas.com>
	 <988df019-00d4-4209-8716-39e82c565bf1@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Di, 2024-07-02 at 14:30 +0100, Mark Brown wrote:
> On Sun, Jun 16, 2024 at 11:53:55AM +0100, Biju Das wrote:
> > Add a helper function that allow regulator consumers to allow low-level
> > HW access, in order to enable/disable regulator in atomic context.
>=20
> The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b84=
54:
>=20
>   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
>=20
> [...]

Thank you, merged into reset/next.

regards
Philipp

