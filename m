Return-Path: <linux-pm+bounces-11157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8B93274F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60293B2133D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13419AA7B;
	Tue, 16 Jul 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="ScWtrcZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F228387;
	Tue, 16 Jul 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136048; cv=none; b=NvLZJaDt+yLPqKiDI7P0mpCqrTyZz2hD7EkJrigVqPdYaotgzGZG/1w3UozK5RRR65dRc8lFvCkfLSMBONvR2zEBWDcqQfMrmmS25bAUTZMwlMY/G1k2e2zVCWvcD6bDwF0L9HmMBcuJMmjp2iDNwcsA9tq3hAgOa3ZGEG/NOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136048; c=relaxed/simple;
	bh=AtAOBV7bnSPUuscLq8rdkSFWIOQBpUtV0DPaZ6zFNAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKv1i7uHORvYxppf8Sl2JmfSKlFwSUb73Pq1ewK37AnpW23oWzWr5VclsK3P6wiuvAjyIkQXQ+nXbAvqHMWBGbxkSQac/Mv90ZQg/+jE/IV+OyVVwazYLEZUQLMp5Nm/CRvRe00HsxgydN/jxr0+tcXEQ+ry/oeF6XP/JrZdq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=ScWtrcZ4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721136028; x=1721740828; i=s.l-h@gmx.de;
	bh=qaaJnwwOJeq0Tus7RbxDEYWH4Q9zRZMm7LlWwaOaigU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ScWtrcZ4d/IDXf1snaWbM8+UeAS6LD/Qb/hIjACXRE2wGHFLVCQw1urqyoSwMPMe
	 UxVV41zEdTwAWlYCYlkmfW1bhmSAN9nx9pcALGYHFGlBFKtEqIW2GvqRG7os8/Hf1
	 Ot1z6Hczc3HEjfoLcXz9OQgI2kjWI78E0uznUYHT/ACsNcJ31zxepeBdT3Ux6Gs/p
	 wGfh8HbXwwYaUObmwzIen+hlZCfHbOd/Xfuqy11CFkHnb8TG47ZE+edtqtZHbFjyz
	 Lzj4AOYx9r/H3yhy2N5ffjoaX9V0lbAxJACu1JMslRh4HgNwcOtpGAR2G1uQYaJ17
	 h0gnfPQhsDv41nn6Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1sBMGv2vf3-00y6M4; Tue, 16
 Jul 2024 15:20:28 +0200
Date: Tue, 16 Jul 2024 15:20:25 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers
 <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz
 Luba <lukasz.luba@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240716152025.7f935fb0@mir>
In-Reply-To: <CAJZ5v0g8L-TA7kT92J_nX8PkjyGkqGeuXh4-ATOprhSPKsY7Rg@mail.gmail.com>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
	<4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
	<CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
	<20240715145426.199c31d0@mir>
	<CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
	<20240716014830.243bb0cf@mir>
	<CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
	<20240716125538.09f716d1@mir>
	<20240716131500.35cf4f00@mir>
	<CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
	<CAJZ5v0g8L-TA7kT92J_nX8PkjyGkqGeuXh4-ATOprhSPKsY7Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BuctFrxmpgMmHs/b0oCkUBW87B3AItciqXRkhNWTtfjO+U6a0AV
 OGJqvF6/MEURSJXL2nM2BnMegHU1/bppd0jCOqex2pWbjpbTY8GuZRuRSmN4F4O9+Y0XMDH
 NOfB2WegdDtDoNEYouDxMcqdcLh6PY7SaSaL3ytoZZXbWsoymTefO9rhLtN2JgyQMmJhT+P
 Sbi/tgOYFZX2wgM3r95CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fpj+yPuf1NA=;TrF5dYQHwYa6V8q/A0iNoHJ6MOm
 BmthHWWGrUl9mb6Or+DBHmPZGN/begyHO963MSKFPJ9blcZO33e8Yk9Gc2rpJ9y4f+J9vLfH4
 LrwxdQviqYcVs0VfHktRaoLgc2Iimuc47HUwIpJDcpo7WSGMWRiAiN+xJbXpxCeZ1G4yL2mvP
 WpLgCEdjEt5jNxv3cjLK7nKaFQ71HSOSAmtNv2YBGJtu6Qc3Gs2FYbr/dXwu4+jDVV/NXnu+n
 vhY1K11HL8ls3FytCAWMYUVJgzj37BEMNh+b0m0LhkFEam6r0rzhZ/5+/pW3ARxR3Pl0HgH6F
 FkUuQum2qXg60iKMErTx+ZcR1ddQCUPFD4iWuZp3uljyIQq93Qfm6QTfDFrYLHtHxiVZmqHFv
 0DemIFyBpsU/ogi3hNdfGCrum1dXeYtxqvkJpqwE2G8wvAxEcM+I7kd16mc3rFTGJmpuLyu2V
 L3R2zSPrwTiU9H2ZqV+RAxkiAogomSWATyQPR4+wb8yNdqOS6anGYQJOiWyvCaU055DIleh29
 TPeiHGzbm4JjtaZjFon1crqxksB5NVXBQeFgr7R7u0fl66FCk2+X3BVmaeq4hm4IXWLkHo+Lc
 sJtv+bhTZHaCi6Q4FsSr22sv+s3BzF/67ytlkDpLx3xXSJWEEL5y5l5dTqsun4gvOkQTXKObD
 rdsag3j1dY81Qq+wBsTXSqYrtqyHrAgt6RRsR6lmS4MrVFFFlYX9Ccmzhe+tyWDcvlfj/Mlq0
 WWYeKxD8sc4sleI9NY6rpGWQBod9CJ6P3T5PEupVJaSRS0Q8QdwA434fOvxW9SglCdoE+T6Pq
 EA6o1VhWuuhuWCZSUmUtn2bg==

Hi

On 2024-07-16, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h=
@gmx.de> wrote:
> > > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann =
<s.l-h@gmx.de> wrote:
> > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollm=
ann <s.l-h@gmx.de> wrote:
> > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. =
Wysocki wrote:
> > > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com=
>
> > > > > > [...]
> > > > > > > > Silencing the warnings is already a big improvement - and =
that patch
> > > > > > > > works to this extent for me with an ax200, thanks.
> > > > > > >
> > > > > > > So attached is a patch that should avoid enabling the therma=
l zone
> > > > > > > when it is not ready for use in the first place, so it shoul=
d address
> > > > > > > both the message and the useless polling.
> > > > > > >
> > > > > > > I would appreciate giving it a go (please note that it hasn'=
t received
> > > > > > > much testing so far, though).
> > > > > >
> > > > > > Sadly this patch doesn't seem to help:
> > > > >
> > > > > This is likely because it is missing checks for firmware image t=
ype.
> > > > > I've added them to the attached new version.  Please try it.
> > > > >
> > > > > I've also added two pr_info() messages to get a better idea of w=
hat's
> > > > > going on, so please grep dmesg for "Thermal zone not ready" and
> > > > > "Enabling thermal zone".
> > > >
> > > > This is the output with the patch applied:
> > >
> > > The ax200 wlan interface is currently not up/ configured (system
> > > using its wired ethernet cards instead), the thermal_zone1 stops
> > > if I manually enable the interface (ip link set dev wlp4s0 up)
> > > after booting up:
> >
> > This explains it, thanks!
> >
> > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() is
> > premature or it should get disabled in the other two places that clear
> > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> >
> > I'm not sure why the thermal zone depends on whether or not this bit
> > is set, though. Is it really a good idea to return errors from it if
> > the interface is not up?
[...]
> > > [   22.033468] thermal thermal_zone1: failed to read out thermal zon=
e (-61)
> > > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-P=
TP, with index: 0
> >
> > Thanks for this data point!
> >
> > AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> > if the interface is up.  It looks to me like the thermal core needs a
> > special "don't poll me" error code to be returned in such cases.
>
> Attached is a thermal core patch with an iwlwifi piece along the lines
> above (tested lightly).  It adds a way for a driver to indicate that
> temperature cannot be provided at the moment, but that's OK and the
> core need not worry about that.
>
> Please give it a go.

This seems to fail to build on top of v6.10, should I test Linus' HEAD
or some staging tree instead?

[ I will be offline for the next few hours now, but will test it as soon
  as possible, probably in ~9-10 hours ]

  CC      drivers/thermal/thermal_core.o
drivers/thermal/thermal_core.c: In function 'handle_thermal_trip':
drivers/thermal/thermal_core.c:383:37: error: 'THERMAL_TEMP_INIT' undeclar=
ed (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
  383 |             tz->last_temperature !=3D THERMAL_TEMP_INIT) {
      |                                     ^~~~~~~~~~~~~~~~~
      |                                     THERMAL_TEMP_INVALID
drivers/thermal/thermal_core.c:383:37: note: each undeclared identifier is=
 reported only once for each function it appears in
drivers/thermal/thermal_core.c: In function 'thermal_zone_device_init':
drivers/thermal/thermal_core.c:432:27: error: 'THERMAL_TEMP_INIT' undeclar=
ed (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
  432 |         tz->temperature =3D THERMAL_TEMP_INIT;
      |                           ^~~~~~~~~~~~~~~~~
      |                           THERMAL_TEMP_INVALID

Regards
	Stefan Lippers-Hollmann

