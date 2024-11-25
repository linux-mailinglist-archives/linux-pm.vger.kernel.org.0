Return-Path: <linux-pm+bounces-18046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0399D8390
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E600280D5C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB281922FB;
	Mon, 25 Nov 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeaGLV9d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC31426C;
	Mon, 25 Nov 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531229; cv=none; b=EsyWV5O/bvm9FNxu2Mq9Md++R+rRSPCVoTH183x9O3WzgQGrbJE1P4f3TKICVT96DKkXezKVwexA/i0MSKNkoQ35EdQ6gYrbYgqHcRpw/Kts8LE2XyPQ6skWxFV0vBpI2crlm0R8n99EhJjT0PczGhYZyIG5TMfemBCjiA/pyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531229; c=relaxed/simple;
	bh=G/datk7oqw8cvx8u/D+KjPxZE1wz9JwUDpwNoNpXq08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBC6Mzn6OsngZW3jeCuy1uvDre5Vv2zi07QAnlqZPOPJe+Q4gkgqL+6nRELp2D8/nyVg/WVS30pLTP6stZsbawhY1+tfKzDrxesM3ouAYFCT5VemVFMGXbT/hQIAfKi0oo+Zqiq9KVrPdthVrfDm3Vv48ieR50Jzv0DkUnpgUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeaGLV9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C19C4CED7;
	Mon, 25 Nov 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732531228;
	bh=G/datk7oqw8cvx8u/D+KjPxZE1wz9JwUDpwNoNpXq08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DeaGLV9dFKeZX8SdwkbUCcJvGlCUNmbJhHsjjSOhdCzceuOqp4AJw8iypFwr1YDDr
	 WQzfikkP1If+nWFK2VDlTyvtMtHkVgHlurDU8RiU5XzD2FQKcE6x9hDBbEckk8XIuN
	 CrZoO+p/l1nynlTmt/hHjn7e62wAI/47F10+uTHu+Aj0zv9yg1N22UNnDnbkYvw1v0
	 +fHRyp3+j3cU3t7AdBIZt6+m2tpvh6wvg/PeQtYWRypkvVSw8XLlD6KfJHqQlatI1v
	 e9FpwI8xzYcL0DVrJU/zehyVfWmArR+qecQfFikGl8a9j3h4liZQRZuPE/810VzOwk
	 xbHdZAeo6R+Jg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2958ddf99a7so4029201fac.2;
        Mon, 25 Nov 2024 02:40:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOVOgTQdBvMNzQwCbdrXhBIzKuyjZ44VgkFQ1D1qobm7Epq2ijwltrabnv7LFioglxZZlWFNcPZ0c=@vger.kernel.org, AJvYcCXwLUvVxM9x1Yq8iLZitVDN1hZ5Y0WQXc4Cuq4WqcrjfYXP0ldxv1pV7e5UTuk0Wo5I0jQv96FZ+rf1IdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L5JN4ExS/2vkdfpJUhkkisPsRE2Yw7JQSj63GTM6fQoKDG7t
	IHBgwcBuA+qiUmt78qL3M/dk7ByRJCSDK2qCcXbBgfLdnUkDncFj7H0GzxB5kxo33bLNkDpwa+u
	oKqGNxP6NORyDD6+rcqlOtASfIzA=
X-Google-Smtp-Source: AGHT+IFiaXeJWjqSVoTy9CvZGyuaBmr9EOAWhed2l/+YyOu7nEZz9EjLiJLrW3DAeiYqUVLxmdTHhoXactj/7Gr5zPs=
X-Received: by 2002:a05:6871:68c:b0:288:c383:788d with SMTP id
 586e51a60fabf-29720c37be8mr10707079fac.21.1732531227786; Mon, 25 Nov 2024
 02:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
 <Z0NeGF4ryCe_b5rr@sashalap> <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
In-Reply-To: <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 11:40:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKPDrpcqk2tG8UNba3z2JL5XTUJeWcatErKC+i7om2JQ@mail.gmail.com>
Message-ID: <CAJZ5v0jKPDrpcqk2tG8UNba3z2JL5XTUJeWcatErKC+i7om2JQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000651ed90627ba5c09"

--000000000000651ed90627ba5c09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sasha, thanks for the report!

Linus, thanks for the analysis!

On Sun, Nov 24, 2024 at 7:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 24 Nov 2024 at 09:10, Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Mon, Nov 18, 2024 at 11:23:46AM +0100, Rafael J. Wysocki wrote:
> > >Hi Linus,
> > >
> > >Please pull from the tag
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > thermal-6.13-rc1
> >
> > Hi Rafael,
> >
> > After merging this PR into linus-next, KernelCI started reporting boot
> > failures on a few platforms:
> >
> > [    6.921489] [00000000000000d0] user address but active_mm is swapper
>
> This is an odd arm64 way of saying "NULL pointer dereference in kernel".
>
> The NULL pointer is in the user space address range, so it
> superficially looks like it's trying to do a user access.
>
> People are more used to the x86 page fault error reporting (and
> honestly - they are a bit better worded in this case too).
>
> If I did the disassembly correctly, the code disassembles to
>
>         cbz     x7, 0x168
>         mov     x5, x7
>         stp     x6, x7, [x20, #24]
>         mov     w19, #0x0
>         ldr     x0, [x5, #208]!      <--- faulting instruction
>
> which does match that address 00000000000000d0 does match "x5+208",
> since x5 is NULL.
>
> Matching it up manually with my build (different config, different
> compiler, so different register allocation), it's this:
>
> // drivers/thermal/gov_power_allocator.c:527:   if (last_passive) {
>         cbz     x6, .L177       // last_passive,
> .L134:
> // drivers/thermal/gov_power_allocator.c:595:
> list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>         mov     x5, x6  // _21, last_passive
> // drivers/thermal/gov_power_allocator.c:529:
> params->trip_max =3D last_passive;
>         stp     x0, x6, [x21, 24]       // first_passive, last_passive,
> // drivers/thermal/gov_power_allocator.c:593:   int ret =3D 0;
>         mov     w19, 0  // <retval>,
> // drivers/thermal/gov_power_allocator.c:595:
> list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>         ldr     x0, [x5, 208]!  // __mptr, MEM[(const struct
> thermal_trip_desc *)prephitmp_29].thermal_instances.next
>
> so it looks like it is that
>
>         list_for_each_entry(instance, &td->thermal_instances, trip_node) =
{
>
> with the 'td' being NULL.
>
> The code seems to do that
>
>         const struct thermal_trip_desc *td =3D
> trip_to_trip_desc(params->trip_max);
>
> So apparently params->trip_max is NULL.
>
> That's where I stopped looking. It's almost certainly due to  commit
> 0dc23567c206 ("thermal: core: Move lists of thermal instances to trip
> descriptors") but I don't know the code.
>
> Over to Rafael and Lukasz,

You are right, the above commit introduced this issue and there is one
more hint on it in Sasha's call trace, which is
thermal_tripless_zone_device_register() used for registering the
thermal zone.  Of course, this means that there are no trip points in
that zone, so params->trip_max is NULL in check_power_actors() and it
needs to be explicitly checked against NULL.

Previously, the check was not needed because the list of thermal
instances was located in the thermal zone object, so walking it would
just produce no results.

IOW, something like the attached patch is needed.

Thanks, Rafael

--000000000000651ed90627ba5c09
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="thermal-gov_power_allocator-fix-null-deref.patch"
Content-Disposition: attachment; 
	filename="thermal-gov_power_allocator-fix-null-deref.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3wwbphu0>
X-Attachment-Id: f_m3wwbphu0

RnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgpTdWJq
ZWN0OiBbUEFUQ0ggdjFdIHRoZXJtYWw6IGdvdl9wb3dlcl9hbGxvY2F0b3I6IEFkZCBtaXNzaW5n
IE5VTEwgcG9pbnRlciBjaGVjawoKQ29tbWl0IDBkYzIzNTY3YzIwNiAoInRoZXJtYWw6IGNvcmU6
IE1vdmUgbGlzdHMgb2YgdGhlcm1hbCBpbnN0YW5jZXMKdG8gdHJpcCBkZXNjcmlwdG9ycyIpIG92
ZXJsb29rZWQgdGhlIGNhc2UgaW4gd2hpY2ggdGhlIFBvd2VyIEFsbG9jYXRvcgpnb3Zlcm5vciBh
dHRlbXB0cyB0byBiaW5kIHRvIGEgdHJpcGxlc3MgdGhlcm1hbCB6b25lIGFuZCBwYXJhbXMtPnRy
aXBfbWF4CmlzIE5VTEwgaW4gY2hlY2tfcG93ZXJfYWN0b3JzKCkuCgpObyBwb3dlciBhY3RvcnMg
Y2FuIGJlIGZvdW5kIGluIHRoYXQgY2FzZSwgc28gY2hlY2tfcG93ZXJfYWN0b3JzKCkgbmVlZHMK
dG8gYmUgbWFkZSByZXR1cm4gMCB0aGVuIHRvIHJlc3RvcmUgaXRzIHByZXZpb3VzIGJlaGF2aW9y
LgoKRml4ZXM6IDBkYzIzNTY3YzIwNiAoInRoZXJtYWw6IGNvcmU6IE1vdmUgbGlzdHMgb2YgdGhl
cm1hbCBpbnN0YW5jZXMgdG8gdHJpcCBkZXNjcmlwdG9ycyIpCkNsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcG0vWjBOZUdGNHJ5Q2VfYjVyckBzYXNoYWxhcC8KUmVwb3J0ZWQt
Ynk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvdGhl
cm1hbC9nb3ZfcG93ZXJfYWxsb2NhdG9yLmMgfCAgICA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC1wbS9kcml2ZXJz
L3RoZXJtYWwvZ292X3Bvd2VyX2FsbG9jYXRvci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9y
aWcvZHJpdmVycy90aGVybWFsL2dvdl9wb3dlcl9hbGxvY2F0b3IuYworKysgbGludXgtcG0vZHJp
dmVycy90aGVybWFsL2dvdl9wb3dlcl9hbGxvY2F0b3IuYwpAQCAtNTg4LDEwICs1ODgsMTUgQEAg
c3RhdGljIHZvaWQgYWxsb3dfbWF4aW11bV9wb3dlcihzdHJ1Y3QgdAogc3RhdGljIGludCBjaGVj
a19wb3dlcl9hY3RvcnMoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LAogCQkJICAgICAg
c3RydWN0IHBvd2VyX2FsbG9jYXRvcl9wYXJhbXMgKnBhcmFtcykKIHsKLQljb25zdCBzdHJ1Y3Qg
dGhlcm1hbF90cmlwX2Rlc2MgKnRkID0gdHJpcF90b190cmlwX2Rlc2MocGFyYW1zLT50cmlwX21h
eCk7CisJY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcF9kZXNjICp0ZDsKIAlzdHJ1Y3QgdGhlcm1h
bF9pbnN0YW5jZSAqaW5zdGFuY2U7CiAJaW50IHJldCA9IDA7CiAKKwlpZiAoIXBhcmFtcy0+dHJp
cF9tYXgpCisJCXJldHVybiAwOworCisJdGQgPSB0cmlwX3RvX3RyaXBfZGVzYyhwYXJhbXMtPnRy
aXBfbWF4KTsKKwogCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5zdGFuY2UsICZ0ZC0+dGhlcm1hbF9p
bnN0YW5jZXMsIHRyaXBfbm9kZSkgewogCQlpZiAoIWNkZXZfaXNfcG93ZXJfYWN0b3IoaW5zdGFu
Y2UtPmNkZXYpKSB7CiAJCQlkZXZfd2FybigmdHotPmRldmljZSwgInBvd2VyX2FsbG9jYXRvcjog
JXMgaXMgbm90IGEgcG93ZXIgYWN0b3JcbiIsCg==
--000000000000651ed90627ba5c09--

