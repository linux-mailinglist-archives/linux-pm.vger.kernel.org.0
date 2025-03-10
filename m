Return-Path: <linux-pm+bounces-23760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1AA592B5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010EC188E398
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460B22069E;
	Mon, 10 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DnjZuGux"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976C220681;
	Mon, 10 Mar 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605855; cv=none; b=UBcNgYZ/EkfEL+9c3c9HWwQ22LzvxBNi4tWG5WYyqqG1EaWMauxIeJxFfCEJzYGRrOZrWJClbNxR0yGOlpJjAdPixQoYb1HUvGvnQ9YK60FX659nq5yzd6V/6gRsXhQ5ztui1q3DVnL/tKpIWF3uyX/ni5HsxviEnWFEauATT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605855; c=relaxed/simple;
	bh=OeLaqDjCUWAjwPd9YXgc8Nf2jUeZmFsbQrRX1+n7oCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dkw3M6/TO0fGE7XI0pTOtpu8maB7FJwa9V2+jI6fd9y4Uj7gTTu9DS3uMGdUgEQZpTtdnCIxY3E02QU4VPGcmnwWqYTeWefiQtrZMgPVsq306Bo4JMbLBu9R4Pjt26E+hRCLw8qaD5vp7ojNcB0zet6usN3dtk/JrGS0d6NjeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DnjZuGux; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73C8843281;
	Mon, 10 Mar 2025 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741605844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIOxtXonhRWejNWq5rxRyT2kvdpRAuigNbl7XmTldVo=;
	b=DnjZuGuxEwPfPqwor/sH5Pai+QeBH4BGQz6SCaIyuecx+hsULkaMmRZ24I9+i1YqAFsiEC
	88/Ot/2+dooGKqzx/g7D+5Lglw5VLxEK0gkrEOPY1+OKpvolevV4NeZcZDJNu3I7TtspQ8
	J/wFp7NguwsuDNj5GMNyhkDnnsXgy8lO0uCYMPDR82VzmOWKureunDkzhhbvzW6+hBCw4k
	iuGaf1RSN9GnEjBjNvnLPPKbh9T0Rzwr6Gn5Lr8zwmCI7vGhiGnBakvIVjlclwTOO7Fra1
	dtqVi4uUqoN/SxwTVUoFsMx8XuEv4pnkXnKuWPhvhqKqvxMIhs3ioV/+sI8Gxg==
Date: Mon, 10 Mar 2025 12:23:58 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Binbin Zhou
 <zhoubinbin@loongson.cn>
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <20250310122358.3c07ed18@booty>
In-Reply-To: <Z86gCjzuC5UFZBIL@smile.fi.intel.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
	<20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
	<Z8sqJhbqEBla_Ch7@smile.fi.intel.com>
	<20250308003425.7b89bfb6@booty>
	<Z86gCjzuC5UFZBIL@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfekieegtefhgeelieehhefgtdekffevgfegvdeggeelkeehjeetteethfevudfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvledprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehrjhhuihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshgsrhgrnhguvghnsegsrhhorggutghomhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

+To: Alex Shi, Yanteng Si (Chinese docs maintainers)
+Cc: Binbin Zhou (contributor to English version of printk-formats.rst)

On Mon, 10 Mar 2025 10:17:14 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 08, 2025 at 12:34:25AM +0100, Luca Ceresoli wrote:
> > On Fri, 7 Mar 2025 19:17:26 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
> > > On Fri, Mar 07, 2025 at 12:19:08PM +0100, Luca Ceresoli wrote: =20
> > > > %pC and %pCn print the same string, and commit 900cca294425 ("lib/v=
sprintf:
> > > > add %pC{,n,r} format specifiers for clocks") introducing them does =
not
> > > > clarify any intended difference. It can be assumed %pC is a default=
 for
> > > > %pCn as some other specifiers do, but not all are consistent with t=
his
> > > > policy. Moreover there is now no other suffix other than 'n', which=
 makes a
> > > > default not really useful.
> > > >=20
> > > > All users in the kernel were using %pC except for one which has been
> > > > converted. So now remove %pCn and all the unnecessary extra code and
> > > > documentation.   =20
> > >=20
> > > You seem forgot to update translation(s) of the documentation. =20
> >=20
> > I'm afraid I don't speak Chinese. :-) =20
>=20
> At bare minimum we can drop the same line in the list.
> Also in such a case we may ask a Chinese speaking person to review / corr=
ect /
> suggest the changes. I would not leave a leftover as it will be forgotten=
 so
> easily and documentation becomes not in sync.

Alex Shi, Yanteng Si: what is the process to update the Chinese
documentation after changes to the English one, considering I don't
speak Chinese?

The documentation [0] seems to imply it will be done by you after the
English documentation update, is it the case?

Otherwise, for this simple change, I can add a patch that looks like a
somewhat correct one for Chinese:

@@ -523,9 +523,8 @@ clk=E7=BB=93=E6=9E=84=E4=BD=93
 ::
=20
 	%pC	pll1
-	%pCn	pll1
=20
-=E7=94=A8=E4=BA=8E=E6=89=93=E5=8D=B0clk=E7=BB=93=E6=9E=84=E3=80=82%pC =E5=
=92=8C %pCn =E6=89=93=E5=8D=B0=E6=97=B6=E9=92=9F=E7=9A=84=E5=90=8D=E7=A7=B0=
=EF=BC=88=E9=80=9A=E7=94=A8=E6=97=B6=E9=92=9F=E6=A1=86=E6=9E=B6=EF=BC=89=E6=
=88=96=E5=94=AF=E4=B8=80=E7=9A=8432=E4=BD=8D
+=E7=94=A8=E4=BA=8E=E6=89=93=E5=8D=B0clk=E7=BB=93=E6=9E=84=E3=80=82%pC =E6=
=89=93=E5=8D=B0=E6=97=B6=E9=92=9F=E7=9A=84=E5=90=8D=E7=A7=B0=EF=BC=88=E9=80=
=9A=E7=94=A8=E6=97=B6=E9=92=9F=E6=A1=86=E6=9E=B6=EF=BC=89=E6=88=96=E5=94=AF=
=E4=B8=80=E7=9A=8432=E4=BD=8D
 ID=EF=BC=88=E4=BC=A0=E7=BB=9F=E6=97=B6=E9=92=9F=E6=A1=86=E6=9E=B6=EF=BC=89=
=E3=80=82
=20
 =E9=80=9A=E8=BF=87=E5=BC=95=E7=94=A8=E4=BC=A0=E9=80=92=E3=80=82

Can you confirm the above is a correct change?

Luca

[0] https://docs.kernel.org/translations/index.html

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

