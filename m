Return-Path: <linux-pm+bounces-11113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C231493172B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ACC1F22660
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D018EFCA;
	Mon, 15 Jul 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuLmpcXn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964318EA71;
	Mon, 15 Jul 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054913; cv=none; b=aH9v1BKa0MlVi9CtzoIFAwfTpmz0vXyCVKVe258bY6XDkli/MXxM5BOoX1RiVE9WIY2dcF+WtwVBEElQg7lm4TibWOb9xEjclwaM1ty3UnUC8qxCUsdtdwsD7Oy9R4M5/sgoZzSfjBuBHt9AySLjZOkdNaXPuLpdc5HAAdtOaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054913; c=relaxed/simple;
	bh=pyLnaIhd0fXf/UCYMJynz2U9MpH89pmUOfH2FVN9Srw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiNOIcGVyo1B+CfiMg4nAqd89lKUF7w04sHnsxNgDWRKlU3zVs1zay1JsHs64rOh2tdMdQy/d2hUzRxmUhglSEQkcULA4VXm5112CA1Naov75ioKBqg4B2JBR3Rg6icKK2C0MUBKjyDiQ/t6gsTc1phs54+VQXhBg7wCMoJPM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuLmpcXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB54C4AF11;
	Mon, 15 Jul 2024 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054912;
	bh=pyLnaIhd0fXf/UCYMJynz2U9MpH89pmUOfH2FVN9Srw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OuLmpcXnSRNsqNDoHRZE9CGfdWMU1c2SpVINd03yjpUINNYH8EV42YVl/72aQDr4D
	 avD6mOQIu8SD1+2h/vKmcuGJqcv3KispeGMW5TaOPb2SESsDXytYyPV7Gbq8x+4nfQ
	 AmE69xnltgEb+wBG4Ri7ZjRJNznLV9X4tT0qjrHI9UZNc8TG7gV0+osHp4vuS1Kj9A
	 kIp687XvbZR/1yYX5wHH5T6wcl1heF4VcCzV3CPOwSKsUiK10GEADrZZy69mKkvI7b
	 Loh7yLTCmK1R+15iue8e+4xd3RDAmf8cV/U6IHPiAQ3ZjHNZmjvn11MK0DCS+lyQ2O
	 dfyTVMVir5udA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24c5ec50da1so656507fac.3;
        Mon, 15 Jul 2024 07:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEzWFBF3e+/0x3HTOsVbxFWkYsBvijKN5DRwEH7Uz7NRNJWoNJ/rWBOaosRmAQZ63nTniZNRfqeOyDs98PXVsw6QQwTtPH325WdxnFWc5Ub7QuVL2ELvQW8lIVIixidi7+jIOx+6I=
X-Gm-Message-State: AOJu0Yzi9wSAQKYKGLgaLE+2yccxAKoZQmQNp/MjZG1tUZ+In0hvT+kn
	pZnhV0WTBbr8ZnBWO5D4vV5vSUAgYl9kSoBP62VPFa1izgKJ+GddpFCOD8Bd8M+lsgFi9WAcAKD
	d8ApUiz5ptCKDhohFvkz9Ik4MMk8=
X-Google-Smtp-Source: AGHT+IEG4n6o4zPg9wlGizi/Dot1V31Uxmrcd0XWu4wS2dYxfddsSkVaNzr1A1fFFbAVX8+tBMnOqj1c/BM0QuSD7sU=
X-Received: by 2002:a4a:d6cd:0:b0:5c6:6029:1568 with SMTP id
 006d021491bc7-5cabf08b42amr10526570eaf.0.1721054911662; Mon, 15 Jul 2024
 07:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org> <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir>
In-Reply-To: <20240715145426.199c31d0@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 16:48:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
Message-ID: <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000a63df1061d4a5224"

--000000000000a63df1061d4a5224
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gmx.=
de> wrote:
>
> Hi
>
> On 2024-07-15, Rafael J. Wysocki wrote:
> > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>
> > > >> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_tr=
ip()
> [...]
> > > Does the following change fixes the messages  ?
> > >
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > index 61a4638d1be2..b519db76d402 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > @@ -622,7 +622,7 @@ static int iwl_mvm_tzone_get_temp(struct
> > > thermal_zone_device *device,
> > >
> > >         if (!iwl_mvm_firmware_running(mvm) ||
> > >             mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> > > -               ret =3D -ENODATA;
> > > +               ret =3D -EAGAIN;
> > >                 goto out;
> > >         }
> > >
> > >
> > > --
> >
> > It would make the message go away, but it wouldn't stop the useless
> > polling of the dead thermal zone.
>
> Silencing the warnings is already a big improvement - and that patch
> works to this extent for me with an ax200, thanks.

So attached is a patch that should avoid enabling the thermal zone
when it is not ready for use in the first place, so it should address
both the message and the useless polling.

I would appreciate giving it a go (please note that it hasn't received
much testing so far, though).

--000000000000a63df1061d4a5224
Content-Type: text/x-patch; charset="US-ASCII"; name="iwlwifi-mvm-zone-enabling.patch"
Content-Disposition: attachment; filename="iwlwifi-mvm-zone-enabling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyn3llhq0>
X-Attachment-Id: f_lyn3llhq0

LS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICB8ICAgIDEg
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaCB8ICAgIDEgCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jICB8ICAgNTUgKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgICAg
ICAgICAgICAgICB8ICAgNDYgKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC90
aGVybWFsLmggICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogNSBmaWxlcyBjaGFuZ2VkLCA5
NSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCisrKyBs
aW51eC1wbS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jCkBAIC02
NzEsNiArNjcxLDcgQEAgc3RhdGljIHZvaWQgaXdsX212bV90aGVybWFsX3pvbmVfcmVnaXN0ZQog
ewogCWludCBpLCByZXQ7CiAJY2hhciBuYW1lWzE2XTsKKwlzdHJ1Y3QgdGhlcm1hbF96b25lX2Rl
dmljZSAqdHpvbmU7CiAJc3RhdGljIGF0b21pY190IGNvdW50ZXIgPSBBVE9NSUNfSU5JVCgwKTsK
IAogCWlmICghaXdsX212bV9pc190dF9pbl9mdyhtdm0pKSB7CkBAIC02OTEsMjMgKzY5Miw0MCBA
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
bXV0ZXgpOworCisJbXZtLT50el9kZXZpY2UudHpvbmUgPSB0em9uZTsKKworCW11dGV4X3VubG9j
aygmbXZtLT5tdXRleCk7CisKKwlpZiAoIWl3bF9tdm1fZmlybXdhcmVfcnVubmluZyhtdm0pKSB7
CisJCUlXTF9ERUJVR19URU1QKG12bSwgIlRoZXJtYWwgem9uZSBub3QgcmVhZHlcbiIpOworCQly
ZXR1cm47CisJfQorCXJldCA9IHRoZXJtYWxfem9uZV9kZXZpY2VfZW5hYmxlKHR6b25lKTsKIAlp
ZiAocmV0KSB7CiAJCUlXTF9ERUJVR19URU1QKG12bSwgIkZhaWxlZCB0byBlbmFibGUgdGhlcm1h
bCB6b25lXG4iKTsKLQkJdGhlcm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVyKG12bS0+dHpfZGV2
aWNlLnR6b25lKTsKKworCQltdXRleF9sb2NrKCZtdm0tPm11dGV4KTsKKworCQltdm0tPnR6X2Rl
dmljZS50em9uZSA9IE5VTEw7CisKKwkJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsKKworCQl0
aGVybWFsX3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIodHpvbmUpOwogCX0KIH0KIApAQCAtNzg3LDE0
ICs4MDUsMjYgQEAgc3RhdGljIHZvaWQgaXdsX212bV9jb29saW5nX2RldmljZV9yZWdpcwogCiBz
dGF0aWMgdm9pZCBpd2xfbXZtX3RoZXJtYWxfem9uZV91bnJlZ2lzdGVyKHN0cnVjdCBpd2xfbXZt
ICptdm0pCiB7CisJc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6b25lOworCiAJaWYgKCFp
d2xfbXZtX2lzX3R0X2luX2Z3KG12bSkgfHwgIW12bS0+dHpfZGV2aWNlLnR6b25lKQogCQlyZXR1
cm47CiAKIAlJV0xfREVCVUdfVEVNUChtdm0sICJUaGVybWFsIHpvbmUgZGV2aWNlIHVucmVnaXN0
ZXJcbiIpOwotCWlmIChtdm0tPnR6X2RldmljZS50em9uZSkgewotCQl0aGVybWFsX3pvbmVfZGV2
aWNlX3VucmVnaXN0ZXIobXZtLT50el9kZXZpY2UudHpvbmUpOwotCQltdm0tPnR6X2RldmljZS50
em9uZSA9IE5VTEw7CisKKwltdXRleF9sb2NrKCZtdm0tPm11dGV4KTsKKworCXR6b25lID0gbXZt
LT50el9kZXZpY2UudHpvbmU7CisJaWYgKCF0em9uZSkgeworCQltdXRleF91bmxvY2soJm12bS0+
bXV0ZXgpOworCisJCXJldHVybjsKIAl9CisJbXZtLT50el9kZXZpY2UudHpvbmUgPSBOVUxMOwor
CisJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsKKworCXRoZXJtYWxfem9uZV9kZXZpY2VfdW5y
ZWdpc3Rlcih0em9uZSk7CiB9CiAKIHN0YXRpYyB2b2lkIGl3bF9tdm1fY29vbGluZ19kZXZpY2Vf
dW5yZWdpc3RlcihzdHJ1Y3QgaXdsX212bSAqbXZtKQpAQCAtODQ3LDMgKzg3NywxMCBAQCB2b2lk
IGl3bF9tdm1fdGhlcm1hbF9leGl0KHN0cnVjdCBpd2xfbXZtCiAjZW5kaWYKIAltdm0tPmluaXRf
c3RhdHVzICY9IH5JV0xfTVZNX0lOSVRfU1RBVFVTX1RIRVJNQUxfSU5JVF9DT01QTEVURTsKIH0K
Kwordm9pZCBpd2xfbXZtX3RoZXJtYWxfdHpvbmVfZW5hYmxlKHN0cnVjdCBpd2xfbXZtICptdm0p
Cit7CisjaWZkZWYgQ09ORklHX1RIRVJNQUwKKwl0aGVybWFsX3pvbmVfc2NoZWR1bGVfZGV2aWNl
X2VuYWJsZShtdm0tPnR6X2RldmljZS50em9uZSk7CisjZW5kaWYKK30KSW5kZXg6IGxpbnV4LXBt
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9m
dy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9m
dy5jCkBAIC00NTgsNiArNDU4LDcgQEAgc3RhdGljIGludCBpd2xfbXZtX2xvYWRfdWNvZGVfd2Fp
dF9hbGl2ZQogI2lmZGVmIENPTkZJR19JV0xXSUZJX0RFQlVHRlMKIAlpd2xfZndfc2V0X2RiZ19y
ZWNfb24oJm12bS0+ZndydCk7CiAjZW5kaWYKKwlpd2xfbXZtX3RoZXJtYWxfdHpvbmVfZW5hYmxl
KG12bSk7CiAKIAkvKgogCSAqIEFsbCB0aGUgQlNTZXMgaW4gdGhlIEJTUyB0YWJsZSBpbmNsdWRl
IHRoZSBHUDIgaW4gdGhlIHN5c3RlbQpJbmRleDogbGludXgtcG0vZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaAorKysgbGludXgtcG0v
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmgKQEAgLTIzOTAsNiAr
MjM5MCw3IEBAIHZvaWQgaXdsX212bV90ZW1wX25vdGlmKHN0cnVjdCBpd2xfbXZtICoKIHZvaWQg
aXdsX212bV90dF9oYW5kbGVyKHN0cnVjdCBpd2xfbXZtICptdm0pOwogdm9pZCBpd2xfbXZtX3Ro
ZXJtYWxfaW5pdGlhbGl6ZShzdHJ1Y3QgaXdsX212bSAqbXZtLCB1MzIgbWluX2JhY2tvZmYpOwog
dm9pZCBpd2xfbXZtX3RoZXJtYWxfZXhpdChzdHJ1Y3QgaXdsX212bSAqbXZtKTsKK3ZvaWQgaXds
X212bV90aGVybWFsX3R6b25lX2VuYWJsZShzdHJ1Y3QgaXdsX212bSAqbXZtKTsKIHZvaWQgaXds
X212bV9zZXRfaHdfY3RraWxsX3N0YXRlKHN0cnVjdCBpd2xfbXZtICptdm0sIGJvb2wgc3RhdGUp
OwogaW50IGl3bF9tdm1fZ2V0X3RlbXAoc3RydWN0IGl3bF9tdm0gKm12bSwgczMyICp0ZW1wKTsK
IHZvaWQgaXdsX212bV9jdF9raWxsX25vdGlmKHN0cnVjdCBpd2xfbXZtICptdm0sIHN0cnVjdCBp
d2xfcnhfY21kX2J1ZmZlciAqcnhiKTsKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuYworKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29y
ZS5jCkBAIC02MDYsNiArNjA2LDUyIEBAIGludCB0aGVybWFsX3pvbmVfZGV2aWNlX2VuYWJsZShz
dHJ1Y3QgdGgKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxfem9uZV9kZXZpY2VfZW5hYmxl
KTsKIAorc3RydWN0IHR6X2VuYWJsZV93b3JrIHsKKwlzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsK
KwlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHo7Cit9OworCitzdGF0aWMgdm9pZCB0aGVy
bWFsX3pvbmVfZW5hYmxlX3dvcmtfZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0
cnVjdCB0el9lbmFibGVfd29yayAqZXcgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHR6X2Vu
YWJsZV93b3JrLCB3b3JrKTsKKwlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHogPSBldy0+
dHo7CisKKwlrZnJlZShldyk7CisKKwl0aGVybWFsX3pvbmVfZGV2aWNlX2VuYWJsZSh0eik7CisK
KwlwdXRfZGV2aWNlKCZ0ei0+ZGV2aWNlKTsKK30KKworLyoqCisgKiB0aGVybWFsX3pvbmVfc2No
ZWR1bGVfZGV2aWNlX2VuYWJsZSAtIEVuYWJsZSB0aGVybWFsIHpvbmUgYXN5bmNocm9ub3VzbHkK
KyAqIEB0ejogVGhlcm1hbCB6b25lIHRvIGVuYWJsZS4KKyAqCisgKiBFbmFibGUgYSB0aGVybWFs
IHpvbmUgaW4gYSB3b3JrZXIgdGhyZWFkLgorICoKKyAqIFRoZSBjYWxsZXIgbXVzdCBlbnN1cmUg
dGhhdCBAdHogd2lsbCBub3QgY2hhbmdlIHdoaWxlIHRoaXMgZnVuY3Rpb24KKyAqIGlzIHJ1bm5p
bmcuCisgKi8KK2ludCB0aGVybWFsX3pvbmVfc2NoZWR1bGVfZGV2aWNlX2VuYWJsZShzdHJ1Y3Qg
dGhlcm1hbF96b25lX2RldmljZSAqdHopCit7CisJc3RydWN0IHR6X2VuYWJsZV93b3JrICpldzsK
KworCWlmICghdHopCisJCXJldHVybiAwOworCisJZXcgPSBremFsbG9jKHNpemVvZigqZXcpLCBH
RlBfS0VSTkVMKTsKKwlpZiAoIWV3KQorCQlyZXR1cm4gLUVOT01FTTsKKworCUlOSVRfV09SSygm
ZXctPndvcmssIHRoZXJtYWxfem9uZV9lbmFibGVfd29ya19mbik7CisJZ2V0X2RldmljZSgmdHot
PmRldmljZSk7CisJZXctPnR6ID0gdHo7CisJc2NoZWR1bGVfd29yaygmZXctPndvcmspOworCisJ
cmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MX0dQTCh0aGVybWFsX3pvbmVfc2NoZWR1bGVfZGV2
aWNlX2VuYWJsZSk7CisKIGludCB0aGVybWFsX3pvbmVfZGV2aWNlX2Rpc2FibGUoc3RydWN0IHRo
ZXJtYWxfem9uZV9kZXZpY2UgKnR6KQogewogCXJldHVybiB0aGVybWFsX3pvbmVfZGV2aWNlX3Nl
dF9tb2RlKHR6LCBUSEVSTUFMX0RFVklDRV9ESVNBQkxFRCk7CkluZGV4OiBsaW51eC1wbS9pbmNs
dWRlL2xpbnV4L3RoZXJtYWwuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2luY2x1ZGUv
bGludXgvdGhlcm1hbC5oCisrKyBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaApAQCAt
Mjc1LDYgKzI3NSw3IEBAIGJvb2wgdGhlcm1hbF90cmlwX2lzX2JvdW5kX3RvX2NkZXYoc3RydWMK
IAkJCQkgICBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2Rldik7CiAKIGludCB0aGVy
bWFsX3pvbmVfZGV2aWNlX2VuYWJsZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopOwor
aW50IHRoZXJtYWxfem9uZV9zY2hlZHVsZV9kZXZpY2VfZW5hYmxlKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eik7CiBpbnQgdGhlcm1hbF96b25lX2RldmljZV9kaXNhYmxlKHN0cnVjdCB0
aGVybWFsX3pvbmVfZGV2aWNlICp0eik7CiB2b2lkIHRoZXJtYWxfem9uZV9kZXZpY2VfY3JpdGlj
YWwoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KTsKICNlbHNlCg==
--000000000000a63df1061d4a5224--

