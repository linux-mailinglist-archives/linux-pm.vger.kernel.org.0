Return-Path: <linux-pm+bounces-9033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD659059CC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D16B24563
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034E1822C2;
	Wed, 12 Jun 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqrTaVqb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FD181BB3;
	Wed, 12 Jun 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213020; cv=none; b=Mdmlg/VVeVwnTsRBAVLMELn+hjql7mlKBjO/LDohSwYjfnE8ApZKaEfCCJYUArGZ3y4QhjBWfyuQ2Sz0rezghNdqG+Wns6lJD2/iSGcAn5IenW49VYChWhUIVCGsDrrq6FOrhcm3YGOWgR9k0ERQEB2gVXsQtq+WuNnjJ1GHi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213020; c=relaxed/simple;
	bh=SmhgWhV+k+k1Jn01Ck0bRn6varewMhGpbVWsepDCohQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3sDqbfmFnMzPmE0DGAsvkphsvkw3t7xDLGx3efagXOdohSs2sIakU9rb8+WGir5I6/sPn0gF7ia0HMCefdgbzR23L3t6SF/5qqXxLTxIRwTm1OkctpTrlmT4m9Kh9lH4lPqNHmpmiPz19KYwzwh5pxA51HEWk9cjZ5xXlLlXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqrTaVqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94953C4AF1A;
	Wed, 12 Jun 2024 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718213019;
	bh=SmhgWhV+k+k1Jn01Ck0bRn6varewMhGpbVWsepDCohQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pqrTaVqbhIjv/5M8kgJm/nWlZnSpwPKvcvfMYVmqbQDycCvmXpxhINXk0quLhfJji
	 1tzAVwHYvTQgsXIAFqkJn1XZTdNgEiZWlgI04X/YzeTS91XRmErFPijdGVuxMV4xlT
	 Fx+sQkld9jE73/EbIUyLBv3oLxx4puivwceUHjwZu8JjN6zgDb7AIoUBvooMLllAFq
	 /Fs8A8/4om3TAYNL775gT2Z4Z0QRbBJSxKelhXDCoPcE7qiDklNkc0eclRMMxJKUw3
	 xrd4Zm29I4LsOkbZUCSGMQDMRZ0j7WBR6ia/TOnXdbkaq5LUGuvdoXqwcq1D83o4/Z
	 H2A+c+5PqbVyg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5baf76164fbso16367eaf.1;
        Wed, 12 Jun 2024 10:23:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA4ZcvnHvngM8gCKcTfiNl/wpKcbYdq4a7dWHiLNnRN1veVs8MHcnGhsCG7cRH767eJTSS3QGNKXWhdiiJ5mC4rQw7BHLO5AG2WoP5
X-Gm-Message-State: AOJu0YxpkgS/4txa8yLVwN/vCnSc/+ySX+js3AoVe9eNo6htIhUxfOvM
	vBOP8F5aCIS+pMzFavrOFHGHk9ZQ3I1/oOVSjv64AM+U3eAnc20y2/s5HK7xwiLdsnCaIzVn01D
	wQbHvQG+owwS1jUeLtn1mvP2lTRM=
X-Google-Smtp-Source: AGHT+IGHa3GWElLGP/C9oYLMX2fq5ZVD08YJMHCa8lDrMbl1m3XVOVMRcQJFtQ9HX4T2TFlR2IblQMhR3cRApH+VIiA=
X-Received: by 2002:a05:6871:286:b0:254:d417:351f with SMTP id
 586e51a60fabf-25514bfd75fmr2688487fac.1.1718213018901; Wed, 12 Jun 2024
 10:23:38 -0700 (PDT)
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
In-Reply-To: <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 19:23:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
Message-ID: <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "fhortner@yahoo.de" <fhortner@yahoo.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000a420a8061ab4a412"

--000000000000a420a8061ab4a412
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Restored list CCs.

On Wed, Jun 12, 2024 at 3:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jun 12, 2024 at 11:56=E2=80=AFAM fhortner@yahoo.de <fhortner@yaho=
o.de> wrote:
> >
> > Am 11.06.24 um 16:42 schrieb Rafael J. Wysocki:
> >
> > This doesn't make them run in a different order, it just delays both
> > of them, because the notifiers are called sequentially.
> >
> > However, if you added the msleep() at the beginning of
> > thermal_zone_device_resume(), it would change the ordering of this
> > function with respect to the PM notifiers, so please try doing this.
> >
> > I did so and added msleep(1000) to thermal_core.c line 1634
> > I have also reverted the patch you sent me.
> >
> > The battery readings after resume from S3 sleep where fine.
> > I have tried 2 reboots with 4 sleep/wake cycles, respectively
>
> Thanks!
>
> This means that the two code paths in question somehow interfere
> destructively when they are running in parallel with each other.

One more thing to try is the attached patch (independent of the
previous one) to lower the priority of the thermal PM notifier to make
it run always after the ACPI battery one.

Please test this one too and let me know if it works for you.

--000000000000a420a8061ab4a412
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-core-resume-prio.patch"
Content-Disposition: attachment; filename="thermal-core-resume-prio.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxc3mpe90>
X-Attachment-Id: f_lxc3mpe90

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAgICAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYworKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5j
CkBAIC0xNzEyLDYgKzE3MTIsNyBAQCBzdGF0aWMgaW50IHRoZXJtYWxfcG1fbm90aWZ5KHN0cnVj
dCBub3RpCiAKIHN0YXRpYyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgdGhlcm1hbF9wbV9uYiA9IHsK
IAkubm90aWZpZXJfY2FsbCA9IHRoZXJtYWxfcG1fbm90aWZ5LAorCS5wcmlvcml0eSA9IC0xLAog
fTsKIAogc3RhdGljIGludCBfX2luaXQgdGhlcm1hbF9pbml0KHZvaWQpCg==
--000000000000a420a8061ab4a412--

