Return-Path: <linux-pm+bounces-11160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7C9327F9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A403B225DC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAB19ADAD;
	Tue, 16 Jul 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmyH1baT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5C19AD6B;
	Tue, 16 Jul 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138669; cv=none; b=pNwFDnBCVxxu4sBfFFw9tKimdTJF5g8/pGhXZaeJD/LQJDfE71WLG2Rn+r6RowoDLtZlRtQayWMdxIoQL/pUhnpBHj0iG0BKuH/exCBbItTz0+CX1Qi+48mcv+P3aYCBoRtIWXa3174eRDoE4TvFT7kPysYmEN1nuMsm+nmmUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138669; c=relaxed/simple;
	bh=wF9Dke816XWAfTHoVdeZUbVGEun5Aj5wMP8kyqcVj2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo1HqCttJ+VWKsaBgTXTYiwix+qNjSkHpeHwxsJAHtMNOscrRxYBzjT5z1zh3G6YdHoODMjmjUHnuYlR/DTSfi/YDilNfVaWWFAjhLv2v0micOcTK00cdhiM2iBJvDvDGgI68r3rlr3yK+H0WV9jywn93e8T9MrsFUgnVnJ7oDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmyH1baT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC8C116B1;
	Tue, 16 Jul 2024 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721138668;
	bh=wF9Dke816XWAfTHoVdeZUbVGEun5Aj5wMP8kyqcVj2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmyH1baToqPdAUy4eihOsNVo8VFGB2safDXAePWLJaMDhN0q+eaxJVu2R862mRtJ2
	 fFb7mwRTYkGtWMyci7Euef74eufc7eBiSqjGRPvRibG0ZrDVdcvFzhYm5YNEdl3LKf
	 NOR/hrRNCyyBCfhMMuaPEHEqk0thWMvy/bCFcCnU1rGxjczuL1Qu5BgEMyD/rahkdw
	 w+DvQ88P4WvHX7o/rFG/Qjq6luDUpHg6fh9KN/BIrxZK+t+Up8DPul1IDPgBUk8Biw
	 LIOsH4tp3sshyDMsxpMXgopqCZkE2zIAEwn/f52IB66tVjacDJfday5qdzfdDRVpK1
	 Hc1A8FYX+jamw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d5657327c1so227678b6e.1;
        Tue, 16 Jul 2024 07:04:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb2LAILhKHtCaWD7od2T7ePcXFem4cvvsWI51QdfDYTSiigAjQ6bRZa01DXa4mEH3hNZAv2ZYG5x2pbF/yy/tN+kyrYIq2QzmHYOxU8Jb5Yn0wy5GL7UM3w/xgC9qr1qoziKN0T/c=
X-Gm-Message-State: AOJu0Yx6mKz5/PMjD8kH1uwHnjy49EpEzYFkY4vg4W6Ck1FwU3Qtmg1h
	Z8VwWralQXi+lKClMP1ctwbM4q5ib9gEUv40SFBjVpoMHYe63uHuVUOJT0jq/taEMfEZQDKAl/E
	p2VUON9mhiaX8sSLDI8k1z85Nu7U=
X-Google-Smtp-Source: AGHT+IFEIzaHeeyJada4tb+Ryv3LuSHZFPjUy4yLOlIV6tA1P1As4Ovf+XOypmg2YJJ620BAcVrIOmBLZygGhHJnoto=
X-Received: by 2002:a05:6808:19a8:b0:3da:ac08:b74a with SMTP id
 5614622812f47-3dac63f4c66mr2348418b6e.7.1721138668042; Tue, 16 Jul 2024
 07:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org> <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir> <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
 <20240716014830.243bb0cf@mir> <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
 <20240716125538.09f716d1@mir> <20240716131500.35cf4f00@mir>
 <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
 <CAJZ5v0g8L-TA7kT92J_nX8PkjyGkqGeuXh4-ATOprhSPKsY7Rg@mail.gmail.com> <20240716152025.7f935fb0@mir>
In-Reply-To: <20240716152025.7f935fb0@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 16:04:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
Message-ID: <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000eb341c061d5dd267"

--000000000000eb341c061d5dd267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:20=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gmx.=
de> wrote:
>
> Hi
>
> On 2024-07-16, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.l-=
h@gmx.de> wrote:
> > > > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann=
 <s.l-h@gmx.de> wrote:
> > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Holl=
mann <s.l-h@gmx.de> wrote:
> > > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J.=
 Wysocki wrote:
> > > > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.co=
m>
> > > > > > > [...]
> > > > > > > > > Silencing the warnings is already a big improvement - and=
 that patch
> > > > > > > > > works to this extent for me with an ax200, thanks.
> > > > > > > >
> > > > > > > > So attached is a patch that should avoid enabling the therm=
al zone
> > > > > > > > when it is not ready for use in the first place, so it shou=
ld address
> > > > > > > > both the message and the useless polling.
> > > > > > > >
> > > > > > > > I would appreciate giving it a go (please note that it hasn=
't received
> > > > > > > > much testing so far, though).
> > > > > > >
> > > > > > > Sadly this patch doesn't seem to help:
> > > > > >
> > > > > > This is likely because it is missing checks for firmware image =
type.
> > > > > > I've added them to the attached new version.  Please try it.
> > > > > >
> > > > > > I've also added two pr_info() messages to get a better idea of =
what's
> > > > > > going on, so please grep dmesg for "Thermal zone not ready" and
> > > > > > "Enabling thermal zone".
> > > > >
> > > > > This is the output with the patch applied:
> > > >
> > > > The ax200 wlan interface is currently not up/ configured (system
> > > > using its wired ethernet cards instead), the thermal_zone1 stops
> > > > if I manually enable the interface (ip link set dev wlp4s0 up)
> > > > after booting up:
> > >
> > > This explains it, thanks!
> > >
> > > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() i=
s
> > > premature or it should get disabled in the other two places that clea=
r
> > > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> > >
> > > I'm not sure why the thermal zone depends on whether or not this bit
> > > is set, though. Is it really a good idea to return errors from it if
> > > the interface is not up?
> [...]
> > > > [   22.033468] thermal thermal_zone1: failed to read out thermal zo=
ne (-61)
> > > > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > > > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-=
PTP, with index: 0
> > >
> > > Thanks for this data point!
> > >
> > > AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> > > if the interface is up.  It looks to me like the thermal core needs a
> > > special "don't poll me" error code to be returned in such cases.
> >
> > Attached is a thermal core patch with an iwlwifi piece along the lines
> > above (tested lightly).  It adds a way for a driver to indicate that
> > temperature cannot be provided at the moment, but that's OK and the
> > core need not worry about that.
> >
> > Please give it a go.
>
> This seems to fail to build on top of v6.10, should I test Linus' HEAD
> or some staging tree instead?

No, it's missing one hunk, sorry about that.

> [ I will be offline for the next few hours now, but will test it as soon
>   as possible, probably in ~9-10 hours ]

No worries and thanks for your persistence!

>   CC      drivers/thermal/thermal_core.o
> drivers/thermal/thermal_core.c: In function 'handle_thermal_trip':
> drivers/thermal/thermal_core.c:383:37: error: 'THERMAL_TEMP_INIT' undecla=
red (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
>   383 |             tz->last_temperature !=3D THERMAL_TEMP_INIT) {
>       |                                     ^~~~~~~~~~~~~~~~~
>       |                                     THERMAL_TEMP_INVALID
> drivers/thermal/thermal_core.c:383:37: note: each undeclared identifier i=
s reported only once for each function it appears in
> drivers/thermal/thermal_core.c: In function 'thermal_zone_device_init':
> drivers/thermal/thermal_core.c:432:27: error: 'THERMAL_TEMP_INIT' undecla=
red (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
>   432 |         tz->temperature =3D THERMAL_TEMP_INIT;
>       |                           ^~~~~~~~~~~~~~~~~
>       |                           THERMAL_TEMP_INVALID
>

Attached is a new version that builds for me on top of plain 6.10.

--000000000000eb341c061d5dd267
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="thermal-core-recheck-temperature-v2.patch"
Content-Disposition: attachment; 
	filename="thermal-core-recheck-temperature-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyohgzo50>
X-Attachment-Id: f_lyohgzo50

LS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jIHwgICAgNyAr
KysKIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyAgICAgICAgICAgICAgfCAgIDUxICsr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUu
aCAgICAgICAgICAgICAgfCAgICAzICsKIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KSwgMjggZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJt
YWxfY29yZS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMK
QEAgLTMwMCw4ICszMDAsNiBAQCBzdGF0aWMgdm9pZCBtb25pdG9yX3RoZXJtYWxfem9uZShzdHJ1
Y3QKIAkJdGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBhc3NpdmVfZGVs
YXlfamlmZmllcyk7CiAJZWxzZSBpZiAodHotPnBvbGxpbmdfZGVsYXlfamlmZmllcykKIAkJdGhl
cm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBvbGxpbmdfZGVsYXlfamlmZmll
cyk7Ci0JZWxzZSBpZiAodHotPnRlbXBlcmF0dXJlID09IFRIRVJNQUxfVEVNUF9JTlZBTElEKQot
CQl0aGVybWFsX3pvbmVfZGV2aWNlX3NldF9wb2xsaW5nKHR6LCBtc2Vjc190b19qaWZmaWVzKFRI
RVJNQUxfUkVDSEVDS19ERUxBWV9NUykpOwogfQogCiBzdGF0aWMgc3RydWN0IHRoZXJtYWxfZ292
ZXJub3IgKnRoZXJtYWxfZ2V0X3R6X2dvdmVybm9yKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNl
ICp0eikKQEAgLTM4Miw3ICszODAsNyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdGhlcm1hbF90cmlw
KHN0cnVjdCB0CiAJdGQtPnRocmVzaG9sZCA9IHRyaXAtPnRlbXBlcmF0dXJlOwogCiAJaWYgKHR6
LT5sYXN0X3RlbXBlcmF0dXJlID49IG9sZF90aHJlc2hvbGQgJiYKLQkgICAgdHotPmxhc3RfdGVt
cGVyYXR1cmUgIT0gVEhFUk1BTF9URU1QX0lOVkFMSUQpIHsKKwkgICAgdHotPmxhc3RfdGVtcGVy
YXR1cmUgIT0gVEhFUk1BTF9URU1QX0lOSVQpIHsKIAkJLyoKIAkJICogTWl0aWdhdGlvbiBpcyB1
bmRlciB3YXksIHNvIGl0IG5lZWRzIHRvIHN0b3AgaWYgdGhlIHpvbmUKIAkJICogdGVtcGVyYXR1
cmUgZmFsbHMgYmVsb3cgdGhlIGxvdyB0ZW1wZXJhdHVyZSBvZiB0aGUgdHJpcC4KQEAgLTQxNywy
NyArNDE1LDYgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3RoZXJtYWxfdHJpcChzdHJ1Y3QgdAogCX0K
IH0KIAotc3RhdGljIHZvaWQgdXBkYXRlX3RlbXBlcmF0dXJlKHN0cnVjdCB0aGVybWFsX3pvbmVf
ZGV2aWNlICp0eikKLXsKLQlpbnQgdGVtcCwgcmV0OwotCi0JcmV0ID0gX190aGVybWFsX3pvbmVf
Z2V0X3RlbXAodHosICZ0ZW1wKTsKLQlpZiAocmV0KSB7Ci0JCWlmIChyZXQgIT0gLUVBR0FJTikK
LQkJCWRldl93YXJuKCZ0ei0+ZGV2aWNlLAotCQkJCSAiZmFpbGVkIHRvIHJlYWQgb3V0IHRoZXJt
YWwgem9uZSAoJWQpXG4iLAotCQkJCSByZXQpOwotCQlyZXR1cm47Ci0JfQotCi0JdHotPmxhc3Rf
dGVtcGVyYXR1cmUgPSB0ei0+dGVtcGVyYXR1cmU7Ci0JdHotPnRlbXBlcmF0dXJlID0gdGVtcDsK
LQotCXRyYWNlX3RoZXJtYWxfdGVtcGVyYXR1cmUodHopOwotCi0JdGhlcm1hbF9nZW5sX3NhbXBs
aW5nX3RlbXAodHotPmlkLCB0ZW1wKTsKLX0KLQogc3RhdGljIHZvaWQgdGhlcm1hbF96b25lX2Rl
dmljZV9jaGVjayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiB7CiAJc3RydWN0IHRoZXJtYWxf
em9uZV9kZXZpY2UgKnR6ID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdApAQCAtNDUyLDcgKzQy
OSw3IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdChzdHIKIAogCUlOSVRf
REVMQVlFRF9XT1JLKCZ0ei0+cG9sbF9xdWV1ZSwgdGhlcm1hbF96b25lX2RldmljZV9jaGVjayk7
CiAKLQl0ei0+dGVtcGVyYXR1cmUgPSBUSEVSTUFMX1RFTVBfSU5WQUxJRDsKKwl0ei0+dGVtcGVy
YXR1cmUgPSBUSEVSTUFMX1RFTVBfSU5JVDsKIAl0ei0+cGFzc2l2ZSA9IDA7CiAJdHotPnByZXZf
bG93X3RyaXAgPSAtSU5UX01BWDsKIAl0ei0+cHJldl9oaWdoX3RyaXAgPSBJTlRfTUFYOwpAQCAt
NTAxLDYgKzQ3OCw3IEBAIHZvaWQgX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZShzdHJ1Y3QK
IAlzdHJ1Y3QgdGhlcm1hbF90cmlwX2Rlc2MgKnRkOwogCUxJU1RfSEVBRCh3YXlfZG93bl9saXN0
KTsKIAlMSVNUX0hFQUQod2F5X3VwX2xpc3QpOworCWludCB0ZW1wLCByZXQ7CiAKIAlpZiAodHot
PnN1c3BlbmRlZCkKIAkJcmV0dXJuOwpAQCAtNTA4LDEwICs0ODYsMjkgQEAgdm9pZCBfX3RoZXJt
YWxfem9uZV9kZXZpY2VfdXBkYXRlKHN0cnVjdAogCWlmICghdGhlcm1hbF96b25lX2RldmljZV9p
c19lbmFibGVkKHR6KSkKIAkJcmV0dXJuOwogCi0JdXBkYXRlX3RlbXBlcmF0dXJlKHR6KTsKKwly
ZXQgPSBfX3RoZXJtYWxfem9uZV9nZXRfdGVtcCh0eiwgJnRlbXApOworCWlmIChyZXQpIHsKKwkJ
aWYgKHJldCAhPSAtRUFHQUlOKQorCQkJZGV2X2luZm8oJnR6LT5kZXZpY2UsICJUZW1wZXJhdHVy
ZSBjaGVjayBmYWlsZWQgKCVkKVxuIiwgcmV0KTsKIAotCWlmICh0ei0+dGVtcGVyYXR1cmUgPT0g
VEhFUk1BTF9URU1QX0lOVkFMSUQpCisJCXRoZXJtYWxfem9uZV9kZXZpY2Vfc2V0X3BvbGxpbmco
dHosIG1zZWNzX3RvX2ppZmZpZXMoVEhFUk1BTF9SRUNIRUNLX0RFTEFZX01TKSk7CisJCXJldHVy
bjsKKwl9IGVsc2UgaWYgKHRlbXAgPD0gVEhFUk1BTF9URU1QX0lOVkFMSUQpIHsKKwkJLyoKKwkJ
ICogU3BlY2lhbCBjYXNlOiBObyB2YWxpZCB0ZW1wZXJhdHVyZSB2YWx1ZSBpcyBhdmFpbGFibGUs
IGJ1dAorCQkgKiB0aGUgem9uZSBvd25lciBkb2VzIG5vdCB3YW50IHRoZSBjb3JlIHRvIGRvIGFu
eXRoaW5nIGFib3V0CisJCSAqIGl0LiAgQ29udGludWUgcmVndWxhciB6b25lIHBvbGxpbmcgaWYg
bmVlZGVkLCBzbyB0aGF0IHRoaXMKKwkJICogZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBhZ2Fpbiwg
YnV0IHNraXAgZXZlcnl0aGluZyBlbHNlLgorCQkgKi8KIAkJZ290byBtb25pdG9yOworCX0KKwor
CXR6LT5sYXN0X3RlbXBlcmF0dXJlID0gdHotPnRlbXBlcmF0dXJlOworCXR6LT50ZW1wZXJhdHVy
ZSA9IHRlbXA7CisKKwl0cmFjZV90aGVybWFsX3RlbXBlcmF0dXJlKHR6KTsKKworCXRoZXJtYWxf
Z2VubF9zYW1wbGluZ190ZW1wKHR6LT5pZCwgdGVtcCk7CiAKIAlfX3RoZXJtYWxfem9uZV9zZXRf
dHJpcHModHopOwogCkluZGV4OiBsaW51eC1wbS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS90dC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYworKysgbGludXgtcG0vZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYwpAQCAtNjIyLDcgKzYyMiwxMiBAQCBzdGF0
aWMgaW50IGl3bF9tdm1fdHpvbmVfZ2V0X3RlbXAoc3RydWN0CiAKIAlpZiAoIWl3bF9tdm1fZmly
bXdhcmVfcnVubmluZyhtdm0pIHx8CiAJICAgIG12bS0+ZndydC5jdXJfZndfaW1nICE9IElXTF9V
Q09ERV9SRUdVTEFSKSB7Ci0JCXJldCA9IC1FTk9EQVRBOworCQkvKgorCQkgKiBUZWxsIHRoZSBj
b3JlIHRoYXQgdGhlcmUgaXMgbm8gdmFsaWQgdGVtcGVyYXR1cmUgdmFsdWUgdG8KKwkJICogcmV0
dXJuLCBidXQgaXQgbmVlZCBub3Qgd29ycnkgYWJvdXQgdGhpcy4KKwkJICovCisJCSp0ZW1wZXJh
dHVyZSA9IFRIRVJNQUxfVEVNUF9JTlZBTElEOworCQlyZXQgPSAwOwogCQlnb3RvIG91dDsKIAl9
CiAKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuaAo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuaAorKysg
bGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5oCkBAIC0xMzMsNiArMTMzLDkg
QEAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgewogCXN0cnVjdCB0aGVybWFsX3RyaXBfZGVz
YyB0cmlwc1tdIF9fY291bnRlZF9ieShudW1fdHJpcHMpOwogfTsKIAorLyogSW5pdGlhbCB0aGVy
bWFsIHpvbmUgdGVtcGVyYXR1cmUuICovCisjZGVmaW5lIFRIRVJNQUxfVEVNUF9JTklUCUlOVF9N
SU4KKwogLyoKICAqIERlZmF1bHQgZGVsYXkgYWZ0ZXIgYSBmYWlsaW5nIHRoZXJtYWwgem9uZSB0
ZW1wZXJhdHVyZSBjaGVjayBiZWZvcmUKICAqIGF0dGVtcHRpbmcgdG8gY2hlY2sgaXQgYWdhaW4u
Cg==
--000000000000eb341c061d5dd267--

