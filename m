Return-Path: <linux-pm+bounces-11151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B954D93268B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473C5283274
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62D1991D4;
	Tue, 16 Jul 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxQlEcrY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00421D530;
	Tue, 16 Jul 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133028; cv=none; b=EYgHJFHFdcQhasO1pfwHZ3Uqvoii6SmrA0SIUPHbur59bIwgu4X+YYxjtyyT6Hi4eTCk63cTFri6GdOPwob4fl5TFRyl9zPg7rBqSuKo7EM421/KixZTvqjjuA3MiSBhhRBfO5diMz68mNPn6/wjqbmwRCq/12KxIR+QlI6+O4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133028; c=relaxed/simple;
	bh=L1WKGOPLT3EO6aZEdn/m6YYAOzuwnjZIz5btJTgd+2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBqAW0OEB1hkP3mw0rbWTtC2Kh5DcPX3deyCj372yTLFhRBCzJyVeRk8qVsU0G3mQ5Xmjwb7bInC8no6Gfd/ZjwHpSq8TeNLJ3U3kSU18sYGdhbLBOjM6jV0lErQVHE33mbKez8sMppJKVmPLT6LH08bFBH3CCKT1H6InTjBYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxQlEcrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802A5C116B1;
	Tue, 16 Jul 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721133028;
	bh=L1WKGOPLT3EO6aZEdn/m6YYAOzuwnjZIz5btJTgd+2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxQlEcrYo0Ju9x+V9v0grJpP6gnUAB9FbOpGIVmADrni2aNkXVmkuHfUlkyU+CN6d
	 S54+L6BJiCJef9x2Qy5QhiSMO3Onyzpy20yFcbu57n8CwbXXjGbS9U0tX+13M+2eeC
	 T67rlceY/oQaplZ3SVE8GUjLPPFbYMzZIFK4eJ7JOFxP+2B25NWog9n5wEJXAChiBU
	 aIlXflzzDruIj+ZDaK5Wgwu9sANn/rbFlO6RHHyKmQTGQNNUABCWd7RyouXBjd2naC
	 w5AwssGmVAzoQKuoSkiCGalxzOPZSPdZO18fN1RLlBSfjua8GfBVOhki/b+4z2HXKz
	 xjbK8phY8t1ww==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c7adbb7719so159639eaf.2;
        Tue, 16 Jul 2024 05:30:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuF7P6/4rIHGsqzJBB3hTdcuPKa61VZpbfsbCfG90PtmjrJvtu4BWj+S2v+/3vVZR8wLB89QZ7ORD/8gLaxrKQYgf+eboD5lTefX/XMXVAk9NfJGl/B/IULEBYbGOcpiQFEqFr0gM=
X-Gm-Message-State: AOJu0YwSL1tmDBAZh/qbmaTW5HdOU7/+UoFO/os4OgoMEHfOxON6Q3Hz
	M2MJWmsnEZKhgoBDl20oFAkq6ypalWsi9t0Lzuo7cPpGJw1EYxYxlywyxiMJ6Ke0rzoRbnO1kbR
	Wnzb4Qq2aphpM5VpEGcL0TosRM8g=
X-Google-Smtp-Source: AGHT+IHUeqJA5PuHSv0EtqJkTPJnmr4x+ByEXS6UVaFNYxonALWGrMw2bqdSC1IB9gwietFw4TDjD1cesCGXzlr/DXY=
X-Received: by 2002:a05:6808:f01:b0:3da:ac08:cd53 with SMTP id
 5614622812f47-3dac63fb510mr1628784b6e.7.1721133027758; Tue, 16 Jul 2024
 05:30:27 -0700 (PDT)
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
 <20240716125538.09f716d1@mir> <20240716131500.35cf4f00@mir> <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 14:30:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8L-TA7kT92J_nX8PkjyGkqGeuXh4-ATOprhSPKsY7Rg@mail.gmail.com>
Message-ID: <CAJZ5v0g8L-TA7kT92J_nX8PkjyGkqGeuXh4-ATOprhSPKsY7Rg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000bb4804061d5c82c0"

--000000000000bb4804061d5c82c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gm=
x.de> wrote:
> >
> > Hi
> >
> > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.=
l-h@gmx.de> wrote:
> > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann=
 <s.l-h@gmx.de> wrote:
> > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wys=
ocki wrote:
> > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > [...]
> > > > > > > Silencing the warnings is already a big improvement - and tha=
t patch
> > > > > > > works to this extent for me with an ax200, thanks.
> > > > > >
> > > > > > So attached is a patch that should avoid enabling the thermal z=
one
> > > > > > when it is not ready for use in the first place, so it should a=
ddress
> > > > > > both the message and the useless polling.
> > > > > >
> > > > > > I would appreciate giving it a go (please note that it hasn't r=
eceived
> > > > > > much testing so far, though).
> > > > >
> > > > > Sadly this patch doesn't seem to help:
> > > >
> > > > This is likely because it is missing checks for firmware image type=
.
> > > > I've added them to the attached new version.  Please try it.
> > > >
> > > > I've also added two pr_info() messages to get a better idea of what=
's
> > > > going on, so please grep dmesg for "Thermal zone not ready" and
> > > > "Enabling thermal zone".
> > >
> > > This is the output with the patch applied:
> >
> > The ax200 wlan interface is currently not up/ configured (system
> > using its wired ethernet cards instead), the thermal_zone1 stops
> > if I manually enable the interface (ip link set dev wlp4s0 up)
> > after booting up:
>
> This explains it, thanks!
>
> The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() is
> premature or it should get disabled in the other two places that clear
> the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
>
> I'm not sure why the thermal zone depends on whether or not this bit
> is set, though. Is it really a good idea to return errors from it if
> the interface is not up?
>
> > $ dmesg | grep -i -e iwlwifi -e thermal
> > [    0.080899] CPU0: Thermal monitoring enabled (TM1)
> > [    0.113768] thermal_sys: Registered thermal governor 'fair_share'
> > [    0.113770] thermal_sys: Registered thermal governor 'bang_bang'
> > [    0.113771] thermal_sys: Registered thermal governor 'step_wise'
> > [    0.113772] thermal_sys: Registered thermal governor 'user_space'
> > [    0.113773] thermal_sys: Registered thermal governor 'power_allocato=
r'
> > [    3.759673] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
> > [    3.764918] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1=
00530 wfpm id 0x80000000
> > [    3.764974] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rf=
id=3D0x10a100
> > [    3.769432] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:=
 89.3.35.37
> > [    3.873466] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07=
d.0 cc-a0-77.ucode op_mode iwlmvm
> > [    3.907122] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 16=
0MHz, REV=3D0x340
> > [    3.907886] iwl_mvm_thermal_zone_register: Thermal zone not ready
> > [    4.032380] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
> > [    4.032392] thermal thermal_zone1: Enabling thermal zone
> > [    4.098308] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
> > [    4.112535] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    4.128306] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> > [    4.369396] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    4.625385] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    4.881416] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    5.137377] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    5.394377] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    5.649412] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    5.905379] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    6.161380] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    6.418381] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    6.673381] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [    6.929377] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> >                [...]
> > [   21.009413] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [   21.265496] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [   21.521462] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [   21.777481] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [   22.033468] thermal thermal_zone1: failed to read out thermal zone (=
-61)
> > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-PTP,=
 with index: 0
>
> Thanks for this data point!
>
> AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> if the interface is up.  It looks to me like the thermal core needs a
> special "don't poll me" error code to be returned in such cases.

Attached is a thermal core patch with an iwlwifi piece along the lines
above (tested lightly).  It adds a way for a driver to indicate that
temperature cannot be provided at the moment, but that's OK and the
core need not worry about that.

Please give it a go.

--000000000000bb4804061d5c82c0
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-core-recheck-temperature.patch"
Content-Disposition: attachment; 
	filename="thermal-core-recheck-temperature.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyoe2p0h0>
X-Attachment-Id: f_lyoe2p0h0

LS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jIHwgICAgNyAr
KysKIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyAgICAgICAgICAgICAgfCAgIDUxICsr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKSwgMjggZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFs
L3RoZXJtYWxfY29yZS5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3Jl
LmMKQEAgLTMwMCw4ICszMDAsNiBAQCBzdGF0aWMgdm9pZCBtb25pdG9yX3RoZXJtYWxfem9uZShz
dHJ1Y3QKIAkJdGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBhc3NpdmVf
ZGVsYXlfamlmZmllcyk7CiAJZWxzZSBpZiAodHotPnBvbGxpbmdfZGVsYXlfamlmZmllcykKIAkJ
dGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBvbGxpbmdfZGVsYXlfamlm
Zmllcyk7Ci0JZWxzZSBpZiAodHotPnRlbXBlcmF0dXJlID09IFRIRVJNQUxfVEVNUF9JTlZBTElE
KQotCQl0aGVybWFsX3pvbmVfZGV2aWNlX3NldF9wb2xsaW5nKHR6LCBtc2Vjc190b19qaWZmaWVz
KFRIRVJNQUxfUkVDSEVDS19ERUxBWV9NUykpOwogfQogCiBzdGF0aWMgc3RydWN0IHRoZXJtYWxf
Z292ZXJub3IgKnRoZXJtYWxfZ2V0X3R6X2dvdmVybm9yKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2
aWNlICp0eikKQEAgLTM4Miw3ICszODAsNyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdGhlcm1hbF90
cmlwKHN0cnVjdCB0CiAJdGQtPnRocmVzaG9sZCA9IHRyaXAtPnRlbXBlcmF0dXJlOwogCiAJaWYg
KHR6LT5sYXN0X3RlbXBlcmF0dXJlID49IG9sZF90aHJlc2hvbGQgJiYKLQkgICAgdHotPmxhc3Rf
dGVtcGVyYXR1cmUgIT0gVEhFUk1BTF9URU1QX0lOVkFMSUQpIHsKKwkgICAgdHotPmxhc3RfdGVt
cGVyYXR1cmUgIT0gVEhFUk1BTF9URU1QX0lOSVQpIHsKIAkJLyoKIAkJICogTWl0aWdhdGlvbiBp
cyB1bmRlciB3YXksIHNvIGl0IG5lZWRzIHRvIHN0b3AgaWYgdGhlIHpvbmUKIAkJICogdGVtcGVy
YXR1cmUgZmFsbHMgYmVsb3cgdGhlIGxvdyB0ZW1wZXJhdHVyZSBvZiB0aGUgdHJpcC4KQEAgLTQx
NywyNyArNDE1LDYgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3RoZXJtYWxfdHJpcChzdHJ1Y3QgdAog
CX0KIH0KIAotc3RhdGljIHZvaWQgdXBkYXRlX3RlbXBlcmF0dXJlKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eikKLXsKLQlpbnQgdGVtcCwgcmV0OwotCi0JcmV0ID0gX190aGVybWFsX3pv
bmVfZ2V0X3RlbXAodHosICZ0ZW1wKTsKLQlpZiAocmV0KSB7Ci0JCWlmIChyZXQgIT0gLUVBR0FJ
TikKLQkJCWRldl93YXJuKCZ0ei0+ZGV2aWNlLAotCQkJCSAiZmFpbGVkIHRvIHJlYWQgb3V0IHRo
ZXJtYWwgem9uZSAoJWQpXG4iLAotCQkJCSByZXQpOwotCQlyZXR1cm47Ci0JfQotCi0JdHotPmxh
c3RfdGVtcGVyYXR1cmUgPSB0ei0+dGVtcGVyYXR1cmU7Ci0JdHotPnRlbXBlcmF0dXJlID0gdGVt
cDsKLQotCXRyYWNlX3RoZXJtYWxfdGVtcGVyYXR1cmUodHopOwotCi0JdGhlcm1hbF9nZW5sX3Nh
bXBsaW5nX3RlbXAodHotPmlkLCB0ZW1wKTsKLX0KLQogc3RhdGljIHZvaWQgdGhlcm1hbF96b25l
X2RldmljZV9jaGVjayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiB7CiAJc3RydWN0IHRoZXJt
YWxfem9uZV9kZXZpY2UgKnR6ID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdApAQCAtNDUyLDcg
KzQyOSw3IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdChzdHIKIAogCUlO
SVRfREVMQVlFRF9XT1JLKCZ0ei0+cG9sbF9xdWV1ZSwgdGhlcm1hbF96b25lX2RldmljZV9jaGVj
ayk7CiAKLQl0ei0+dGVtcGVyYXR1cmUgPSBUSEVSTUFMX1RFTVBfSU5WQUxJRDsKKwl0ei0+dGVt
cGVyYXR1cmUgPSBUSEVSTUFMX1RFTVBfSU5JVDsKIAl0ei0+cGFzc2l2ZSA9IDA7CiAJdHotPnBy
ZXZfbG93X3RyaXAgPSAtSU5UX01BWDsKIAl0ei0+cHJldl9oaWdoX3RyaXAgPSBJTlRfTUFYOwpA
QCAtNTA0LDYgKzQ4MSw3IEBAIHZvaWQgX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZShzdHJ1
Y3QKIAlzdHJ1Y3QgdGhlcm1hbF90cmlwX2Rlc2MgKnRkOwogCUxJU1RfSEVBRCh3YXlfZG93bl9s
aXN0KTsKIAlMSVNUX0hFQUQod2F5X3VwX2xpc3QpOworCWludCB0ZW1wLCByZXQ7CiAKIAlpZiAo
dHotPnN1c3BlbmRlZCkKIAkJcmV0dXJuOwpAQCAtNTExLDEwICs0ODksMjkgQEAgdm9pZCBfX3Ro
ZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKHN0cnVjdAogCWlmICghdGhlcm1hbF96b25lX2Rldmlj
ZV9pc19lbmFibGVkKHR6KSkKIAkJcmV0dXJuOwogCi0JdXBkYXRlX3RlbXBlcmF0dXJlKHR6KTsK
KwlyZXQgPSBfX3RoZXJtYWxfem9uZV9nZXRfdGVtcCh0eiwgJnRlbXApOworCWlmIChyZXQpIHsK
KwkJaWYgKHJldCAhPSAtRUFHQUlOKQorCQkJZGV2X2luZm8oJnR6LT5kZXZpY2UsICJUZW1wZXJh
dHVyZSBjaGVjayBmYWlsZWQgKCVkKVxuIiwgcmV0KTsKIAotCWlmICh0ei0+dGVtcGVyYXR1cmUg
PT0gVEhFUk1BTF9URU1QX0lOVkFMSUQpCisJCXRoZXJtYWxfem9uZV9kZXZpY2Vfc2V0X3BvbGxp
bmcodHosIG1zZWNzX3RvX2ppZmZpZXMoVEhFUk1BTF9SRUNIRUNLX0RFTEFZX01TKSk7CisJCXJl
dHVybjsKKwl9IGVsc2UgaWYgKHRlbXAgPD0gVEhFUk1BTF9URU1QX0lOVkFMSUQpIHsKKwkJLyoK
KwkJICogU3BlY2lhbCBjYXNlOiBObyB2YWxpZCB0ZW1wZXJhdHVyZSB2YWx1ZSBpcyBhdmFpbGFi
bGUsIGJ1dAorCQkgKiB0aGUgem9uZSBvd25lciBkb2VzIG5vdCB3YW50IHRoZSBjb3JlIHRvIGRv
IGFueXRoaW5nIGFib3V0CisJCSAqIGl0LiAgQ29udGludWUgcmVndWxhciB6b25lIHBvbGxpbmcg
aWYgbmVlZGVkLCBzbyB0aGF0IHRoaXMKKwkJICogZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBhZ2Fp
biwgYnV0IHNraXAgZXZlcnl0aGluZyBlbHNlLgorCQkgKi8KIAkJZ290byBtb25pdG9yOworCX0K
KworCXR6LT5sYXN0X3RlbXBlcmF0dXJlID0gdHotPnRlbXBlcmF0dXJlOworCXR6LT50ZW1wZXJh
dHVyZSA9IHRlbXA7CisKKwl0cmFjZV90aGVybWFsX3RlbXBlcmF0dXJlKHR6KTsKKworCXRoZXJt
YWxfZ2VubF9zYW1wbGluZ190ZW1wKHR6LT5pZCwgdGVtcCk7CiAKIAl0ei0+bm90aWZ5X2V2ZW50
ID0gZXZlbnQ7CiAKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL3R0LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCisrKyBsaW51eC1wbS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCkBAIC02MjIsNyArNjIyLDEyIEBAIHN0YXRp
YyBpbnQgaXdsX212bV90em9uZV9nZXRfdGVtcChzdHJ1Y3QKIAogCWlmICghaXdsX212bV9maXJt
d2FyZV9ydW5uaW5nKG12bSkgfHwKIAkgICAgbXZtLT5md3J0LmN1cl9md19pbWcgIT0gSVdMX1VD
T0RFX1JFR1VMQVIpIHsKLQkJcmV0ID0gLUVOT0RBVEE7CisJCS8qCisJCSAqIFRlbGwgdGhlIGNv
cmUgdGhhdCB0aGVyZSBpcyBubyB2YWxpZCB0ZW1wZXJhdHVyZSB2YWx1ZSB0bworCQkgKiByZXR1
cm4sIGJ1dCBpdCBuZWVkIG5vdCB3b3JyeSBhYm91dCB0aGlzLgorCQkgKi8KKwkJKnRlbXBlcmF0
dXJlID0gVEhFUk1BTF9URU1QX0lOVkFMSUQ7CisJCXJldCA9IDA7CiAJCWdvdG8gb3V0OwogCX0K
IAo=
--000000000000bb4804061d5c82c0--

