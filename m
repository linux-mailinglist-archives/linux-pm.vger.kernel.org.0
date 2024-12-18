Return-Path: <linux-pm+bounces-19425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B39F64EF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7268E7A1AD9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A819E960;
	Wed, 18 Dec 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9qlO5Ch"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFB165F16;
	Wed, 18 Dec 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521693; cv=none; b=FssOsXO8fBBAAEHUFRCMcY6uNDl6YW43rqD/c3kNxOBOMdJwNGNdMlFBRwGaKvfUsMdY5T7D1WCg+SJxZT1ELSC9NrFNrk5IzrHZuqmmZDHNTKRyqZvS59YUEEt8M1JPlkZLXT9hn3852dtz57tqYuM/zhL4rcPVIRdOTKZwfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521693; c=relaxed/simple;
	bh=aZwG0QOV9ddmzu9MDnqKsxCiCb5gsfpVMd5wOowRdSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvWWwPc/YuwwHzIWGPPe8ulrFTMDfI72s24tP9BHzzXfZk6V2jmEgwrVeJXQMbH1+ch80shyiXTEDD2I0v8N4Xb20oFzfiM6cQ4fG5jWi6vtEnCISvkZHU1IkBgZfVz9l3Pxh0T4KrboQ5FV2+QNj3OBZ4cVTP9weWPoNRmYPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9qlO5Ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E98DC4CECE;
	Wed, 18 Dec 2024 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734521692;
	bh=aZwG0QOV9ddmzu9MDnqKsxCiCb5gsfpVMd5wOowRdSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9qlO5Ch83fk6BsOJNKDN0Qcz+sH6D7v/bFEHkRBlG4Jn4ctrbqxCHl9OBBOA+SxV
	 qq4qTzo9BIr0J4Ce9c+dLuWclX9uXXotq0ux+g3/ibsLiJOEt0KeewyvHvwDWhQnx/
	 zf/3tZThdqIaHwvDqt7N7pkonQZlgSjzct4NsrCnEeqYxkG6Eo/G8xzmrGgcOGsens
	 ojua7xY9y0Tz5clNzRC49ULCBtZLt8ZoMO+e8KA5p2wBxoXiC7Sfeb4p9IfKZ4G0LK
	 hu8tTNZUowX/n7A4iDl+CuxtgI6uIb9WUkUN/Nx8nk6fYXnKcmNtxjgsCoPePkBcst
	 KillZr+3PglbQ==
Date: Wed, 18 Dec 2024 12:34:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v12 02/11] dt-bindings: power: supply: max17042: split on
 2 files
Message-ID: <igvefqqns4k2tbau56nvu6uorhvr4k4j4hiv5asgohviydvlbg@6c2zhgcgdkth>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com>
 <vunx3s4wqw5fqtwuuuuofjtja7buh5zpxi3iznzgfl4iz7fm4d@wlxbzrnlu7fr>
 <CABTCjFBO6RYwf5GiExPFEyBAfCF7vUnbYFRePdSVPdXNfwZwrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABTCjFBO6RYwf5GiExPFEyBAfCF7vUnbYFRePdSVPdXNfwZwrA@mail.gmail.com>

On Wed, Dec 18, 2024 at 02:25:31PM +0300, Dzmitry Sankouski wrote:
> =D1=81=D1=80, 18 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 11:28, K=
rzysztof Kozlowski <krzk@kernel.org>:
> >
> > On Tue, Dec 17, 2024 at 08:30:00PM +0300, Dzmitry Sankouski wrote:
> > > Move max17042 common binding part to separate file, to
> > > reuse it for MFDs with platform driver version.
> > >
> > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > >
> > > Changes on v12:
> >
> > Malformed patch.
> >
> > > - add addtionalProperties: true on common file
> > > - rename *-base file to *-common
> > > - remove compatibles from shared shema
> > > - move required properties to final schema
> > > - remove max77705 compatible from binding - it will be used in
> > >   mfd77705 binding
> >
> > Sorry, all this is somehow complicated effort of not calling the fuel
> > gauge what it really is: separate device with its own I2C address, just
> > like all previous designs in that family from Maxim.
> >
> > I keep repeating this and you keep going that way, maybe because it fits
> > your drivers, but that's not the way.
> >
> > Best regards,
> > Krzysztof
>=20
> Fuel gauge ICs designed to sit between battery and charger, or even in the
> battery pack itself, with a goal to track and protect the battery.
> Given powering diagram:
>=20
> ----------              ---------      ------------      --------------
> |usb port|<--[input]--> |charger| <--> |fuel gauge| <--> |battery pack|
> ----------              ---------      ------------      --------------
>                             |
>                             |
>                             |---> [system bus]
>=20
> There's no fuel gauge ICs with input and system bus measurements on the m=
arket.

OK, good point, assuming that this is the input not for example the
charge on battery. But even if the diagram is correct, we represent here
programming model exposed by device, not physical components of entire
PMIC. Therefore you could have more components there yet still it is
one device: fuel gauge with its I2C addres.


>=20
> This device indeed has its own I2C address, but that's not enough to
> say it should be
> a separate device, because we have MFD's with its goal to share
> resources like a single

There is no such thing as "MFD" device in terms of hardware. MFD is a
Linux construct.

> i2c address for devices with separate functions.

>=20
> To me it's more like Maxim put its fuel gauge together with some hwmon
> solution on the
> single i2c client logic.

Which still makes it one device, unless you are capable of re-using this
other sensor-part on its own or in other devices.

Best regards,
Krzysztof


