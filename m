Return-Path: <linux-pm+bounces-11188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFFA933493
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 01:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC091F2165E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161926F079;
	Tue, 16 Jul 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="kSGzDMxc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FE1F171;
	Tue, 16 Jul 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172671; cv=none; b=ZEyFvpLW1sRqlH7J1iaQ23cs11viPL3/yCgP11Rd1z56KxqHbmr+jWXhndf+pWSRceT15MmOGlQuQu7vmJMzMU2NpreXnqpB1nEqjjtgg8hWjDgkHzz+AsQPVB0WMwaoK1Pv3W2CijqST8+lHq4bZGT/dx+T1tsfElRf9NokF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172671; c=relaxed/simple;
	bh=1N9JkByx93geOv2LFO0p/vFTOObmt0Ko5RTuf7UZdWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emTPiUoTaDitzc9Kf3rphDkndIokEywW+QrZnB6inoNwbLH3HgSHR5W+FKNDLHVEJGrolV7AUJAlD4VgZeUr/zz67NpcE0lXwMOCuysfcZ+Lya/OqdWsPVqycNv+mqkWF+PS5033gOsESk8lrcIj46U51GAGUVEhVrCgjFfjVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=kSGzDMxc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721172650; x=1721777450; i=s.l-h@gmx.de;
	bh=WFomWFwuXRrIQ4oq+yFb0B7GXxfWN/iB3BVOCqgRPoA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kSGzDMxc2izricOEIJ+zQzZF9WyXzlW3ctxGx9/PHSiD1VDgzeJvNiM+DS2tRnWf
	 tyz5zBQj57F8j38hTnjmaCIfeV1+SqRLk2CDT55PCxryOo/1gwP3fG8FLT60exe8M
	 zSeQFE8IQ/m7WupljLa50p1hyfBJ0+XRMG53/8SBMUoWJjQflsqj18g7xtm3yWT5M
	 Zj2wjH/pqfguE9UsW0JYOzXh4UwVyMesRUw/HR7GIT958sj/Ap+ZUfd5IXOsb30RA
	 5szRG7bYV1ejTUO0+6ziaKlrXUSyKJPT1MUSk506jGT7OsL/J5L3ams+MoEascO1B
	 c+fu0dwacruon3y2Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1sO70Z2SmL-00AsKb; Wed, 17
 Jul 2024 01:30:50 +0200
Date: Wed, 17 Jul 2024 01:30:46 +0200
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
Message-ID: <20240717013046.72047bae@mir>
In-Reply-To: <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
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
	<20240716152025.7f935fb0@mir>
	<CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3hVZE93rGGimUIccRBWDKJghuM4tuRWZ7KHZx5JwjE4omi+Zct
 xfumtHYRfs4ysRPMy4WwhY57R8SfLtAJArRobK7x3KcsB/nP7dlV2LXFIAMXFJGShZWUR3+
 HCn2pq34f90iLZpeAJq3jMDNObrfO+kmBzsOHyngMpv5JrjH0Oii64EErWXnIMSGHHDWGIx
 /WA0sWdyXjCHe1fekDsDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+tarLAN5swU=;cOnuvNaPJ2v3UyvJBToHfX+EpoM
 3dJ3DY20jSRwLRH96LVSbI9JQUnZjDpr9KfHhmqmKYZEhWJo18PG8EZs/EoA/dfRABZKkAo+L
 ArdGIGEuIBOQgGxNKF8YKvwq5tBTu0HGiriLFGAhLhUI4+jAyXZH6Ocwd5hklVydi/ocx6AJa
 fyILCK/TTSzc7N5CTbgKfCFjthZmJuyOkI+CRxI8YuRCeCZZRUoEcjcgEwap7f1QFxTWqReOp
 Ju1ykd9EaPMXBQXBEW21GuMTnHtVZfwaD9nDgfFYyElbrrMRRiuR0Fa9SD+sQ7qIhWwJTHV3M
 Uv42NeQkyy3kBzmll0jBgJW7QmTTQt73y33+Fprb8LCI4M7A4GJThJaqB6gw/shJVZSZoc8md
 fs0/i3ume7/pKxF1zB0zsi+mgxIN3ujwBryzoK8XwxuR1zYxgzTvJvlDFJAb1BpdmgEhAc678
 IMlsRXLyRvdEGtKae/j9MDlYHhKKp0X5BCCRmIz9hb47j4Retp650qwdZ+zbs48P+1wVOWi+U
 +Omi2m/oKWXJtmin3341WIaVS6Wx5xlr3iO95FYKosoiJUfwI0tCFXcRJnLyzYXD7ah3JLYGo
 qbAJIOBy5bcgyj+AbHJwwbdmqBT+oV4S0G2IH0mdkItjCGdX8/osfw2ebV0ctLIU1nqBZnzWk
 IMrxQDCx7uCeyKn/RGehwfWqZcQq1K1KMzMxVRoLQZO87LksdV3+3ppRAcLa5a/yjmEk46X9F
 rKk9W6NBuePiI+qSHY2NEbcM+PvkMA6BHK+NUYdzC9II29gDH0uwjd+OeFzfyX9B0+PsM8Jmx
 E7Suayj+OI9dcW75UEcT24OA==

Hi

On 2024-07-16, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2024 at 3:20=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@g=
mx.de> wrote:
> > On 2024-07-16, Rafael J. Wysocki wrote:
> > > On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s=
.l-h@gmx.de> wrote:
> > > > > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > > > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollm=
ann <s.l-h@gmx.de> wrote:
> > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-H=
ollmann <s.l-h@gmx.de> wrote:
> > > > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezc=
ano
> > > > > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael=
 J. Wysocki wrote:
> > > > > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel=
.com>
> > > > > > > > [...]
> > > > > > > > > > Silencing the warnings is already a big improvement - =
and that patch
> > > > > > > > > > works to this extent for me with an ax200, thanks.
> > > > > > > > >
> > > > > > > > > So attached is a patch that should avoid enabling the th=
ermal zone
> > > > > > > > > when it is not ready for use in the first place, so it s=
hould address
> > > > > > > > > both the message and the useless polling.
> > > > > > > > >
> > > > > > > > > I would appreciate giving it a go (please note that it h=
asn't received
> > > > > > > > > much testing so far, though).
> > > > > > > >
> > > > > > > > Sadly this patch doesn't seem to help:
> > > > > > >
> > > > > > > This is likely because it is missing checks for firmware ima=
ge type.
> > > > > > > I've added them to the attached new version.  Please try it.
> > > > > > >
> > > > > > > I've also added two pr_info() messages to get a better idea =
of what's
> > > > > > > going on, so please grep dmesg for "Thermal zone not ready" =
and
> > > > > > > "Enabling thermal zone".
> > > > > >
> > > > > > This is the output with the patch applied:
> > > > >
> > > > > The ax200 wlan interface is currently not up/ configured (system
> > > > > using its wired ethernet cards instead), the thermal_zone1 stops
> > > > > if I manually enable the interface (ip link set dev wlp4s0 up)
> > > > > after booting up:
> > > >
> > > > This explains it, thanks!
> > > >
> > > > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive(=
) is
> > > > premature or it should get disabled in the other two places that c=
lear
> > > > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> > > >
> > > > I'm not sure why the thermal zone depends on whether or not this b=
it
> > > > is set, though. Is it really a good idea to return errors from it =
if
> > > > the interface is not up?
> > [...]
> > > > > [   22.033468] thermal thermal_zone1: failed to read out thermal=
 zone (-61)
> > > > > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > > > > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwi=
fi-PTP, with index: 0
> > > >
> > > > Thanks for this data point!
> > > >
> > > > AFAICS the thermal zone in iwlwifi is always enabled, but only val=
id
> > > > if the interface is up.  It looks to me like the thermal core need=
s a
> > > > special "don't poll me" error code to be returned in such cases.
> > >
> > > Attached is a thermal core patch with an iwlwifi piece along the lin=
es
> > > above (tested lightly).  It adds a way for a driver to indicate that
> > > temperature cannot be provided at the moment, but that's OK and the
> > > core need not worry about that.
> > >
> > > Please give it a go.
> >
> > This seems to fail to build on top of v6.10, should I test Linus' HEAD
> > or some staging tree instead?
>
> No, it's missing one hunk, sorry about that.
>
> > [ I will be offline for the next few hours now, but will test it as so=
on
> >   as possible, probably in ~9-10 hours ]
>
> No worries and thanks for your persistence!
>
[...]
>
> Attached is a new version that builds for me on top of plain 6.10.

I can confirm that this patch is working for me :)

$ dmesg | grep -i -e iwlwifi -e thermal
[    0.080716] CPU0: Thermal monitoring enabled (TM1)
[    0.113503] thermal_sys: Registered thermal governor 'fair_share'
[    0.113503] thermal_sys: Registered thermal governor 'bang_bang'
[    0.113503] thermal_sys: Registered thermal governor 'step_wise'
[    0.113503] thermal_sys: Registered thermal governor 'user_space'
[    0.113503] thermal_sys: Registered thermal governor 'power_allocator'
[    3.847104] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
[    3.856638] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1005=
30 wfpm id 0x80000000
[    3.856649] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    3.861774] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89=
.3.35.37
[    3.957860] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0=
 cc-a0-77.ucode op_mode iwlmvm
[    4.356978] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MH=
z, REV=3D0x340
[    4.483791] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.549338] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
[    4.571969] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0

dmesg remains clean and everything seems to be fine, thanks a lot!

Regards
	Stefan Lippers-Hollmann

