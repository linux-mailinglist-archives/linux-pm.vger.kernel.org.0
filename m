Return-Path: <linux-pm+bounces-1141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C4812C65
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B60B2134A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF339FC1;
	Thu, 14 Dec 2023 09:59:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B51FE112;
	Thu, 14 Dec 2023 01:59:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C78BC15;
	Thu, 14 Dec 2023 02:00:06 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1B73F762;
	Thu, 14 Dec 2023 01:59:18 -0800 (PST)
Date: Thu, 14 Dec 2023 09:59:14 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: anarsoul@gmail.com, bob@electricworry.net, conor+dt@kernel.org,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, lukasz.luba@arm.com,
 martin.botka@somainline.org, rafael@kernel.org, robh+dt@kernel.org,
 rui.zhang@intel.com, samuel@sholland.org, tiny.windzz@gmail.com,
 wens@csie.org
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS
 controller
Message-ID: <20231214095914.4a98ba8c@donnerap.manchester.arm.com>
In-Reply-To: <CALHCpMjz4YiE_=6Cxq7RqF_3qPaw8UCA=6eLy9ZZuofRhr7mcA@mail.gmail.com>
References: <20231128005849.19044-6-andre.przywara@arm.com>
	<a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com>
	<20231211000528.57cb646c@minigeek.lan>
	<CALHCpMjz4YiE_=6Cxq7RqF_3qPaw8UCA=6eLy9ZZuofRhr7mcA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 21:09:45 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

sorry for the delay.

> =D0=BF=D0=BD, 11 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 02:48, A=
ndre Przywara <andre.przywara@arm.com>:
> >
> > On Sat, 9 Dec 2023 13:44:34 +0300
> > Maksim Kiselev <bigunclemax@gmail.com> wrote:
> >
> > Hi Maksim,
> > =20
> > > Hi Martin, Andre.
> > >
> > > May I inquire? Why do we need a separate sun50i_h616_ths_calibrate()
> > > function? Why can't we just extend an existing sun50i_h6_ths_calibrat=
e()?
> > >
> > > At my glance the calculations in both functions are the same. We just
> > > need to handle a special case for the 4th sensor. =20
> >
> > You seem to be right, they are indeed the same, just written slightly
> > differently. Do you already have any patches that unify that? =20
>=20
> No, I don't have any patches for that yet. But I can do it if you told
> me where to
> send the patch. Should I put it here as a reply?

Can you make one patch on top of mainline, that prepares the existing
sun50i_h6_ths_calibrate() function to deal with four sensors? I would then
include this patch of yours in the next submission, and put Martin's H616
patch (now probably just the struct ths_thermal_chip) on top then.

Please send this patch just to the list (CC:ing people like Martin and
me), starting a new thread.

Many thanks,
Andre

> > I don't know if Martin or I find time to do it this week, but we could
> > also optimise this later.
> >
> > Cheers,
> > Andre =20
>=20
> Best regards,
> Maksim


