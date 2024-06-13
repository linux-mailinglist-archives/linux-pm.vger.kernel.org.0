Return-Path: <linux-pm+bounces-9090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6216907647
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A81F27024
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B1148FFF;
	Thu, 13 Jun 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijlEn8zx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108D1448ED;
	Thu, 13 Jun 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291682; cv=none; b=gMnWIfgdKb+ZLO4cSDXu06GvpK4mMk2P35kdIPxyZLt3mg68V5VzjNFmIU1oFFbW2Vvw5xZJC/04MQqdapuCfOckP1x36Fk3AFBrVMwhVxxXfzYnOX6BDeeQj0e9uyFrqpare2Z6x9XqTjCiRPN3HXsEOL56ySltbEmZ5X5k0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291682; c=relaxed/simple;
	bh=OSIoFPP6ehaEIJXs+89MIW5R38UOvWK3VJSPoOB54oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0H3NvMkHlsvCKR5Iloq+mzg2jOufut3Zijt8EAbsWFXqzWC5L+g5HwmJtrqMbjc8zeWspi7cvWUaUH0GDkNfK/NACDJ2lO23naXJ6XDOTbBqaIt8xcAuzC4TnP0jInjG1nk0JKK3Edm853OUnd9Vx8fu55HFtSZb7kMOeNms0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijlEn8zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B067EC2BBFC;
	Thu, 13 Jun 2024 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291681;
	bh=OSIoFPP6ehaEIJXs+89MIW5R38UOvWK3VJSPoOB54oA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ijlEn8zxPhPR00qsRkxvJ35VZGdeRjO0h5xFd/XDzboC7Xu4f8r+0MNMxHDqWnLZN
	 PuxUMKDS68lsFAyxvvqUTPbgh6i+0ODEuHejFHF7MF4eAWAARs5nfTjO/ExuAMvLce
	 icIh1xcYqw5bzS2bqrC7QYw2f0kCOrgq8IcpFQ4E9j/IMZ+6uPljgPpH00oaNhCCIE
	 e87cm49l9EsATTdgauu1Gpkb11smfXl+lvRiWLHKV5myUAI4cZ4uKO1Yt/WPRaMQUj
	 TpQgizCrCx7Yt+1Q/86vBQpEHpgrIbC6JCLgJ8lmOlZq25AqxCLO+98k7Yk0996OuH
	 47oA8Gwsk0tDQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5bad112b623so38694eaf.3;
        Thu, 13 Jun 2024 08:14:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFC2oMDMtU3/azuVdTu3dOF6BhZKjCdiCjkIEDaqHjTeFaJ6/MLjs693O4ow+E5ZAs7v7wCeY6fzfU1BbYJtY0m2qT8tjslOT/dGPI
X-Gm-Message-State: AOJu0YzsXqW3Iaq3FIgYeCCQ1fop++YqTKmyZ3QU0wuvgnI7KP1fM8qk
	q9kTckVnFEeuruaxTD5wdNj/py2TZLhvQYDcADilo22occecG5OGnJ7emc+SF1OiR8ytOINlqGy
	Lpy6QcXyRf1Ere4LPa0oFrVE/k8Q=
X-Google-Smtp-Source: AGHT+IHYvaAwxGtXqI5rPPSqH9crCQlvA3HdSLCIiKQW22jl1kgK8okggtUecAAkWCBRX2CtT92znfX3IEUSA3o3JXM=
X-Received: by 2002:a4a:b4c1:0:b0:5bb:815d:e2ab with SMTP id
 006d021491bc7-5bdabf41a2bmr663673eaf.1.1718291680932; Thu, 13 Jun 2024
 08:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de> <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
 <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de> <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
 <312649b1-eea9-4346-af93-76a821e88eb7@yahoo.de> <CAJZ5v0jfvRWK0M3Xf=36e74cVQ9rN5T1WdZZVnuk1XmZ=xu==g@mail.gmail.com>
 <78549853-1763-40cf-9974-3fc737fad093@yahoo.de> <CAJZ5v0h5pQDaA-bEOmcz_TpE87kFqWLFLJC+=OLjg5ZtF3hxpQ@mail.gmail.com>
 <91d94429-fc7e-4828-914d-1a251ee1ba99@yahoo.de> <CAJZ5v0gPZHDfuK1FRdTAG8Eqjf0NWUQdf-_GCWsWf6dCBE=1dg@mail.gmail.com>
 <543787c3-db5b-4f63-b5e0-df508300db73@yahoo.de> <CAJZ5v0h7jDw3yX689nZdB+YeJbCk0vFoUgVb4Yi0cqDxjL5chQ@mail.gmail.com>
 <40ec1e53-2bc8-48aa-9909-fac9072adb57@yahoo.de> <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
 <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
In-Reply-To: <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 17:14:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
Message-ID: <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "fhortner@yahoo.de" <fhortner@yahoo.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000437c47061ac6f571"

--000000000000437c47061ac6f571
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:23=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Restored list CCs.
>
> On Wed, Jun 12, 2024 at 3:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Jun 12, 2024 at 11:56=E2=80=AFAM fhortner@yahoo.de <fhortner@ya=
hoo.de> wrote:
> > >
> > > Am 11.06.24 um 16:42 schrieb Rafael J. Wysocki:
> > >
> > > This doesn't make them run in a different order, it just delays both
> > > of them, because the notifiers are called sequentially.
> > >
> > > However, if you added the msleep() at the beginning of
> > > thermal_zone_device_resume(), it would change the ordering of this
> > > function with respect to the PM notifiers, so please try doing this.
> > >
> > > I did so and added msleep(1000) to thermal_core.c line 1634
> > > I have also reverted the patch you sent me.
> > >
> > > The battery readings after resume from S3 sleep where fine.
> > > I have tried 2 reboots with 4 sleep/wake cycles, respectively
> >
> > Thanks!
> >
> > This means that the two code paths in question somehow interfere
> > destructively when they are running in parallel with each other.
>
> One more thing to try is the attached patch (independent of the
> previous one) to lower the priority of the thermal PM notifier to make
> it run always after the ACPI battery one.
>
> Please test this one too and let me know if it works for you.

Attached is a slightly modified version of the last patch I sent.
Please test it and let me know if it addresses the problem you are
seeing.

If it helps, I think we are done with this at least for now.

--000000000000437c47061ac6f571
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-core-resume-prio.patch"
Content-Disposition: attachment; filename="thermal-core-resume-prio.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxdeempy0>
X-Attachment-Id: f_lxdeempy0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAgICA2ICsrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuYworKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
Y29yZS5jCkBAIC0xNzEyLDYgKzE3MTIsMTIgQEAgc3RhdGljIGludCB0aGVybWFsX3BtX25vdGlm
eShzdHJ1Y3Qgbm90aQogCiBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHRoZXJtYWxfcG1f
bmIgPSB7CiAJLm5vdGlmaWVyX2NhbGwgPSB0aGVybWFsX3BtX25vdGlmeSwKKwkvKgorCSAqIFJ1
biBhdCB0aGUgbG93ZXN0IHByaW9yaXR5IHRvIGF2b2lkIGludGVyZmVyZW5jZSBiZXR3ZWVuIHRo
ZSB0aGVybWFsCisJICogem9uZSByZXN1bWUgd29yayBpdGVtcyBzcGF3bmVkIGJ5IHRoZXJtYWxf
cG1fbm90aWZ5KCkgYW5kIHRoZSBvdGhlcgorCSAqIFBNIG5vdGlmaWVycy4KKwkgKi8KKwkucHJp
b3JpdHkgPSBJTlRfTUlOLAogfTsKIAogc3RhdGljIGludCBfX2luaXQgdGhlcm1hbF9pbml0KHZv
aWQpCg==
--000000000000437c47061ac6f571--

