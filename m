Return-Path: <linux-pm+bounces-11141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C481593238D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516431F239DC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12A195B3B;
	Tue, 16 Jul 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idF7+Vol"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994A6AC0;
	Tue, 16 Jul 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124342; cv=none; b=WayYgc9Ej0Yk9npFv2rWIltKTglsJ+z3dJz9wHZ2BI0SZ6NBhmayNAJh+VO9J6wkVGsHwqo2m2UdPtYR7sf3IMeMDnBATDyf0RYyzFHDMrWprdRFmzajxR+3RSMuR8iy2s+aIPLBrIztN8qqjU8eurVTXC/dpbOuiTEr3WSDOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124342; c=relaxed/simple;
	bh=3HH7tpmWFSP+dhRnFSSeS9gaYAvPC9EFa28iRvV+4jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJW4PicigJGoffECt7Htd4rStfdOWUj9e4UfASzRidGrxSNuiDRN1Uf8zC1vj8hzuTZ56rquHyZbYtSl7n5nnF0Rt72MEvS3E0RkUnDSDa86GMfGK1R2+3S6DW+lpP2I3ruvK89fmAB0LvUUhYSg29o4dC2MiJKyr5ZfvfQ08Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idF7+Vol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6769DC4AF0E;
	Tue, 16 Jul 2024 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721124342;
	bh=3HH7tpmWFSP+dhRnFSSeS9gaYAvPC9EFa28iRvV+4jU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=idF7+VolEzPNdIlwD7rkTqddJzD8giIOT0efbDXi0KDleQtmxUo606kF/sk1ODKvX
	 zW/b10UDK9WMj3NTyaHnsnCwt+eqtoIB5j1r5gM1qLM4k8SgLC+rG6g505hHuYcutM
	 VBGTp3TwhseYNW+jPQRFnrkD6RJKwyNP8WfanJUAcBq8L7dn4+v0miI8Aba6bDYLk4
	 BMm155oFj6Ia5ILRKHa9N6mxVv0NSCPRfMEvg+USGoQVnudFZTWBiELuI3kkTKz5fe
	 ttRxxet0KIBBAsC9K9OgqPZ/BKkC1U1w7JI4rYMWbT5JA+ua+cokRbWpxW/84TnBcj
	 47A0UBKzetGEA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dab33691f4so244668b6e.1;
        Tue, 16 Jul 2024 03:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUulieGUrbXPK0NjjZD5EtoGMiRT+hdRbP8jdl7Q3lHpPL+0m27ayqSbYROg5DfO9+fvLkzoI01A6s0W04Tp4nNaXd5tTaLPK/WWOx7ActDOpEfLRnOij9gmWldGSfuNY0Ud1ubsAE=
X-Gm-Message-State: AOJu0Yx3FA9Q5qXmkzouG7AakxFMsne2NkcJ5pyD8uWwBvWTgfO6xKtv
	iHu4p5nCjSgb4k+uvnYerqo+i6CheGQ60o2AwWeOM0nwNkDf7UALtAYUIYCvM8qKttcNJuOyYtI
	2mx38sM+f5MeAkLQwR1IUn3Ips6Y=
X-Google-Smtp-Source: AGHT+IHcYLGl/BNeveuEej0FXU7F2GSt/VQUbldR/wnBvL0aSUpsVrHBnvkbfNBNfNj0mMPGv7+3BeT3zcujhbKkUbk=
X-Received: by 2002:a4a:d0a2:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5d254ef812emr1668717eaf.2.1721124341690; Tue, 16 Jul 2024
 03:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org> <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir> <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
 <20240716014830.243bb0cf@mir>
In-Reply-To: <20240716014830.243bb0cf@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 12:05:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
Message-ID: <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000005c3a061d5a7dd9"

--000000000000005c3a061d5a7dd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l-h@gmx.=
de> wrote:
>
> Hi
>
> On 2024-07-15, Rafael J. Wysocki wrote:
> > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@=
gmx.de> wrote:
> > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > <daniel.lezcano@linaro.org> wrote:
> > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wro=
te:
> > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [...]
> > > Silencing the warnings is already a big improvement - and that patch
> > > works to this extent for me with an ax200, thanks.
> >
> > So attached is a patch that should avoid enabling the thermal zone
> > when it is not ready for use in the first place, so it should address
> > both the message and the useless polling.
> >
> > I would appreciate giving it a go (please note that it hasn't received
> > much testing so far, though).
>
> Sadly this patch doesn't seem to help:

This is likely because it is missing checks for firmware image type.
I've added them to the attached new version.  Please try it.

I've also added two pr_info() messages to get a better idea of what's
going on, so please grep dmesg for "Thermal zone not ready" and
"Enabling thermal zone".

In the meantime, I'll prepare thermal core changes that should
mitigate the problem independently.

--000000000000005c3a061d5a7dd9
Content-Type: text/x-patch; charset="US-ASCII"; name="iwlwifi-mvm-zone-enabling-v2.patch"
Content-Disposition: attachment; 
	filename="iwlwifi-mvm-zone-enabling-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyo8yn7x0>
X-Attachment-Id: f_lyo8yn7x0

LS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICB8ICAgIDIg
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaCB8ICAgIDEgCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jICB8ICAgNjEgKysrKysr
KysrKysrKysrKysrKysrKystLS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgICAg
ICAgICAgICAgICB8ICAgNDggKysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3Ro
ZXJtYWwuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiA1IGZpbGVzIGNoYW5nZWQsIDEw
NCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCisrKyBs
aW51eC1wbS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCkBAIC02
NzEsNiArNjcxLDcgQEAgc3RhdGljIHZvaWQgaXdsX212bV90aGVybWFsX3pvbmVfcmVnaXN0ZQog
ewogCWludCBpLCByZXQ7CiAJY2hhciBuYW1lWzE2XTsKKwlzdHJ1Y3QgdGhlcm1hbF96b25lX2Rl
dmljZSAqdHpvbmU7CiAJc3RhdGljIGF0b21pY190IGNvdW50ZXIgPSBBVE9NSUNfSU5JVCgwKTsK
IAogCWlmICghaXdsX212bV9pc190dF9pbl9mdyhtdm0pKSB7CkBAIC02OTEsMjMgKzY5Miw0NiBA
QCBzdGF0aWMgdm9pZCBpd2xfbXZtX3RoZXJtYWxfem9uZV9yZWdpc3RlCiAJCW12bS0+dHpfZGV2
aWNlLnRyaXBzW2ldLnR5cGUgPSBUSEVSTUFMX1RSSVBfUEFTU0lWRTsKIAkJbXZtLT50el9kZXZp
Y2UudHJpcHNbaV0uZmxhZ3MgPSBUSEVSTUFMX1RSSVBfRkxBR19SV19URU1QOwogCX0KLQltdm0t
PnR6X2RldmljZS50em9uZSA9IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlw
cyhuYW1lLAorCisJdHpvbmUgPSB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJp
cHMobmFtZSwKIAkJCQkJCQltdm0tPnR6X2RldmljZS50cmlwcywKIAkJCQkJCQlJV0xfTUFYX0RU
U19UUklQUywKIAkJCQkJCQltdm0sICZ0em9uZV9vcHMsCiAJCQkJCQkJTlVMTCwgMCwgMCk7Ci0J
aWYgKElTX0VSUihtdm0tPnR6X2RldmljZS50em9uZSkpIHsKKwlpZiAoSVNfRVJSKHR6b25lKSkg
ewogCQlJV0xfREVCVUdfVEVNUChtdm0sCiAJCQkgICAgICAgIkZhaWxlZCB0byByZWdpc3RlciB0
byB0aGVybWFsIHpvbmUgKGVyciA9ICVsZClcbiIsCi0JCQkgICAgICAgUFRSX0VSUihtdm0tPnR6
X2RldmljZS50em9uZSkpOwotCQltdm0tPnR6X2RldmljZS50em9uZSA9IE5VTEw7CisJCQkgICAg
ICAgUFRSX0VSUih0em9uZSkpOwogCQlyZXR1cm47CiAJfQogCi0JcmV0ID0gdGhlcm1hbF96b25l
X2RldmljZV9lbmFibGUobXZtLT50el9kZXZpY2UudHpvbmUpOworCW11dGV4X2xvY2soJm12bS0+
bXV0ZXgpOworCisJbXZtLT50el9kZXZpY2UudHpvbmUgPSB0em9uZTsKKworCWlmICghaXdsX212
bV9maXJtd2FyZV9ydW5uaW5nKG12bSkgfHwKKwkgICAgbXZtLT5md3J0LmN1cl9md19pbWcgIT0g
SVdMX1VDT0RFX1JFR1VMQVIpIHsKKwkJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsKKworCQlw
cl9pbmZvKCIlczogVGhlcm1hbCB6b25lIG5vdCByZWFkeVxuIiwgX19mdW5jX18pOworCisJCUlX
TF9ERUJVR19URU1QKG12bSwgIlRoZXJtYWwgem9uZSBub3QgcmVhZHlcbiIpOworCQlyZXR1cm47
CisJfQorCisJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsKKworCXJldCA9IHRoZXJtYWxfem9u
ZV9kZXZpY2VfZW5hYmxlKHR6b25lKTsKIAlpZiAocmV0KSB7CiAJCUlXTF9ERUJVR19URU1QKG12
bSwgIkZhaWxlZCB0byBlbmFibGUgdGhlcm1hbCB6b25lXG4iKTsKLQkJdGhlcm1hbF96b25lX2Rl
dmljZV91bnJlZ2lzdGVyKG12bS0+dHpfZGV2aWNlLnR6b25lKTsKKworCQltdXRleF9sb2NrKCZt
dm0tPm11dGV4KTsKKworCQltdm0tPnR6X2RldmljZS50em9uZSA9IE5VTEw7CisKKwkJbXV0ZXhf
dW5sb2NrKCZtdm0tPm11dGV4KTsKKworCQl0aGVybWFsX3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIo
dHpvbmUpOwogCX0KIH0KIApAQCAtNzg3LDE0ICs4MTEsMjYgQEAgc3RhdGljIHZvaWQgaXdsX212
bV9jb29saW5nX2RldmljZV9yZWdpcwogCiBzdGF0aWMgdm9pZCBpd2xfbXZtX3RoZXJtYWxfem9u
ZV91bnJlZ2lzdGVyKHN0cnVjdCBpd2xfbXZtICptdm0pCiB7CisJc3RydWN0IHRoZXJtYWxfem9u
ZV9kZXZpY2UgKnR6b25lOworCiAJaWYgKCFpd2xfbXZtX2lzX3R0X2luX2Z3KG12bSkgfHwgIW12
bS0+dHpfZGV2aWNlLnR6b25lKQogCQlyZXR1cm47CiAKIAlJV0xfREVCVUdfVEVNUChtdm0sICJU
aGVybWFsIHpvbmUgZGV2aWNlIHVucmVnaXN0ZXJcbiIpOwotCWlmIChtdm0tPnR6X2RldmljZS50
em9uZSkgewotCQl0aGVybWFsX3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIobXZtLT50el9kZXZpY2Uu
dHpvbmUpOwotCQltdm0tPnR6X2RldmljZS50em9uZSA9IE5VTEw7CisKKwltdXRleF9sb2NrKCZt
dm0tPm11dGV4KTsKKworCXR6b25lID0gbXZtLT50el9kZXZpY2UudHpvbmU7CisJaWYgKCF0em9u
ZSkgeworCQltdXRleF91bmxvY2soJm12bS0+bXV0ZXgpOworCisJCXJldHVybjsKIAl9CisJbXZt
LT50el9kZXZpY2UudHpvbmUgPSBOVUxMOworCisJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsK
KworCXRoZXJtYWxfem9uZV9kZXZpY2VfdW5yZWdpc3Rlcih0em9uZSk7CiB9CiAKIHN0YXRpYyB2
b2lkIGl3bF9tdm1fY29vbGluZ19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgaXdsX212bSAqbXZt
KQpAQCAtODQ3LDMgKzg4MywxMCBAQCB2b2lkIGl3bF9tdm1fdGhlcm1hbF9leGl0KHN0cnVjdCBp
d2xfbXZtCiAjZW5kaWYKIAltdm0tPmluaXRfc3RhdHVzICY9IH5JV0xfTVZNX0lOSVRfU1RBVFVT
X1RIRVJNQUxfSU5JVF9DT01QTEVURTsKIH0KKwordm9pZCBpd2xfbXZtX3RoZXJtYWxfdHpvbmVf
ZW5hYmxlKHN0cnVjdCBpd2xfbXZtICptdm0pCit7CisjaWZkZWYgQ09ORklHX1RIRVJNQUwKKwl0
aGVybWFsX3pvbmVfc2NoZWR1bGVfZGV2aWNlX2VuYWJsZShtdm0tPnR6X2RldmljZS50em9uZSk7
CisjZW5kaWYKK30KSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL2Z3LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jCkBAIC00NTgsNiArNDU4LDggQEAgc3RhdGlj
IGludCBpd2xfbXZtX2xvYWRfdWNvZGVfd2FpdF9hbGl2ZQogI2lmZGVmIENPTkZJR19JV0xXSUZJ
X0RFQlVHRlMKIAlpd2xfZndfc2V0X2RiZ19yZWNfb24oJm12bS0+ZndydCk7CiAjZW5kaWYKKwlp
ZiAobXZtLT5md3J0LmN1cl9md19pbWcgPT0gSVdMX1VDT0RFX1JFR1VMQVIpCisJCWl3bF9tdm1f
dGhlcm1hbF90em9uZV9lbmFibGUobXZtKTsKIAogCS8qCiAJICogQWxsIHRoZSBCU1NlcyBpbiB0
aGUgQlNTIHRhYmxlIGluY2x1ZGUgdGhlIEdQMiBpbiB0aGUgc3lzdGVtCkluZGV4OiBsaW51eC1w
bS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaAo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZt
L212bS5oCisrKyBsaW51eC1wbS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9tdm0uaApAQCAtMjM5MCw2ICsyMzkwLDcgQEAgdm9pZCBpd2xfbXZtX3RlbXBfbm90aWYoc3Ry
dWN0IGl3bF9tdm0gKgogdm9pZCBpd2xfbXZtX3R0X2hhbmRsZXIoc3RydWN0IGl3bF9tdm0gKm12
bSk7CiB2b2lkIGl3bF9tdm1fdGhlcm1hbF9pbml0aWFsaXplKHN0cnVjdCBpd2xfbXZtICptdm0s
IHUzMiBtaW5fYmFja29mZik7CiB2b2lkIGl3bF9tdm1fdGhlcm1hbF9leGl0KHN0cnVjdCBpd2xf
bXZtICptdm0pOwordm9pZCBpd2xfbXZtX3RoZXJtYWxfdHpvbmVfZW5hYmxlKHN0cnVjdCBpd2xf
bXZtICptdm0pOwogdm9pZCBpd2xfbXZtX3NldF9od19jdGtpbGxfc3RhdGUoc3RydWN0IGl3bF9t
dm0gKm12bSwgYm9vbCBzdGF0ZSk7CiBpbnQgaXdsX212bV9nZXRfdGVtcChzdHJ1Y3QgaXdsX212
bSAqbXZtLCBzMzIgKnRlbXApOwogdm9pZCBpd2xfbXZtX2N0X2tpbGxfbm90aWYoc3RydWN0IGl3
bF9tdm0gKm12bSwgc3RydWN0IGl3bF9yeF9jbWRfYnVmZmVyICpyeGIpOwpJbmRleDogbGludXgt
cG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBt
Lm9yaWcvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCisrKyBsaW51eC1wbS9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKQEAgLTYwNiw2ICs2MDYsNTQgQEAgaW50IHRoZXJtYWxf
em9uZV9kZXZpY2VfZW5hYmxlKHN0cnVjdCB0aAogfQogRVhQT1JUX1NZTUJPTF9HUEwodGhlcm1h
bF96b25lX2RldmljZV9lbmFibGUpOwogCitzdHJ1Y3QgdHpfZW5hYmxlX3dvcmsgeworCXN0cnVj
dCB3b3JrX3N0cnVjdCB3b3JrOworCXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0ejsKK307
CisKK3N0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9lbmFibGVfd29ya19mbihzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCit7CisJc3RydWN0IHR6X2VuYWJsZV93b3JrICpldyA9IGNvbnRhaW5lcl9v
Zih3b3JrLCBzdHJ1Y3QgdHpfZW5hYmxlX3dvcmssIHdvcmspOworCXN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eiA9IGV3LT50ejsKKworCWtmcmVlKGV3KTsKKworCWRldl9pbmZvKCZ0ei0+
ZGV2aWNlLCAiRW5hYmxpbmcgdGhlcm1hbCB6b25lXG4iKTsKKworCXRoZXJtYWxfem9uZV9kZXZp
Y2VfZW5hYmxlKHR6KTsKKworCXB1dF9kZXZpY2UoJnR6LT5kZXZpY2UpOworfQorCisvKioKKyAq
IHRoZXJtYWxfem9uZV9zY2hlZHVsZV9kZXZpY2VfZW5hYmxlIC0gRW5hYmxlIHRoZXJtYWwgem9u
ZSBhc3luY2hyb25vdXNseQorICogQHR6OiBUaGVybWFsIHpvbmUgdG8gZW5hYmxlLgorICoKKyAq
IEVuYWJsZSBhIHRoZXJtYWwgem9uZSBpbiBhIHdvcmtlciB0aHJlYWQuCisgKgorICogVGhlIGNh
bGxlciBtdXN0IGVuc3VyZSB0aGF0IEB0eiB3aWxsIG5vdCBjaGFuZ2Ugd2hpbGUgdGhpcyBmdW5j
dGlvbgorICogaXMgcnVubmluZy4KKyAqLworaW50IHRoZXJtYWxfem9uZV9zY2hlZHVsZV9kZXZp
Y2VfZW5hYmxlKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikKK3sKKwlzdHJ1Y3QgdHpf
ZW5hYmxlX3dvcmsgKmV3OworCisJaWYgKCF0eikKKwkJcmV0dXJuIDA7CisKKwlldyA9IGt6YWxs
b2Moc2l6ZW9mKCpldyksIEdGUF9LRVJORUwpOworCWlmICghZXcpCisJCXJldHVybiAtRU5PTUVN
OworCisJSU5JVF9XT1JLKCZldy0+d29yaywgdGhlcm1hbF96b25lX2VuYWJsZV93b3JrX2ZuKTsK
KwlnZXRfZGV2aWNlKCZ0ei0+ZGV2aWNlKTsKKwlldy0+dHogPSB0ejsKKwlzY2hlZHVsZV93b3Jr
KCZldy0+d29yayk7CisKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxf
em9uZV9zY2hlZHVsZV9kZXZpY2VfZW5hYmxlKTsKKwogaW50IHRoZXJtYWxfem9uZV9kZXZpY2Vf
ZGlzYWJsZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopCiB7CiAJcmV0dXJuIHRoZXJt
YWxfem9uZV9kZXZpY2Vfc2V0X21vZGUodHosIFRIRVJNQUxfREVWSUNFX0RJU0FCTEVEKTsKSW5k
ZXg6IGxpbnV4LXBtL2luY2x1ZGUvbGludXgvdGhlcm1hbC5oCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4
LXBtLm9yaWcvaW5jbHVkZS9saW51eC90aGVybWFsLmgKKysrIGxpbnV4LXBtL2luY2x1ZGUvbGlu
dXgvdGhlcm1hbC5oCkBAIC0yNzUsNiArMjc1LDcgQEAgYm9vbCB0aGVybWFsX3RyaXBfaXNfYm91
bmRfdG9fY2RldihzdHJ1YwogCQkJCSAgIHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpj
ZGV2KTsKIAogaW50IHRoZXJtYWxfem9uZV9kZXZpY2VfZW5hYmxlKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eik7CitpbnQgdGhlcm1hbF96b25lX3NjaGVkdWxlX2RldmljZV9lbmFibGUo
c3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KTsKIGludCB0aGVybWFsX3pvbmVfZGV2aWNl
X2Rpc2FibGUoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KTsKIHZvaWQgdGhlcm1hbF96
b25lX2RldmljZV9jcml0aWNhbChzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopOwogI2Vs
c2UK
--000000000000005c3a061d5a7dd9--

