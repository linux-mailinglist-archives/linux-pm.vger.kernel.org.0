Return-Path: <linux-pm+bounces-40325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A59CF9017
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9B430BF306
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853433E34C;
	Tue,  6 Jan 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwpLZ4Gv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A633DEF7
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712033; cv=none; b=l07HDpkWmN+AzAKaemV5zliN2lehbjIm7mYwGNP/uUiutF4rfBO9cF8ZjZT29am7Po57+0ZOThtsOy5wFtQQorWUsj7rluzCJJL5UB2dYoU4zpmzuOMYiEg78xp/lmmlFs0Bauwu3ljWjr4IMjL1yB9chMpPw27wrEXfVQQllsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712033; c=relaxed/simple;
	bh=IQu1Edy/HWKz08uAYzo3PsbrFyGQXi8NI559zIHsYyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uyz66vPb+nTCOj/9PMDEgaS0roU35Id9HANShPIQOwQ048ztMbqWBDYV55zbUcnPsgFPmP4TXPh0JtVE5rUBSpICdrdcmVOzfHIGcg7aSVT1XPUG+Bot6yuVtDDerp6oShPkj9Y3SSK6fmOeCp4x2conbgP+RudspPkF4pGfGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwpLZ4Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBD5C2BCB1
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767712032;
	bh=IQu1Edy/HWKz08uAYzo3PsbrFyGQXi8NI559zIHsYyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LwpLZ4Gv/rLh9TOdLjDFrTwucroei2WbfyfQ748EF/Mixcf1SBZ7zGqZnvN3Cl67f
	 G3QK9601kjEphYjnk4vmdZbVf3k/2hTZdTTy+LNeVt5x3G++qme34VifB+NJICW3vJ
	 09c9JKB3N8bg1N+oyoE39OERHvzumzFiSIObvrQx+DaaND/DEPHGRZvAnPS/seHHSo
	 1+Pxa3g00WVBkt02qKeOUAugvQXcehMej7dfbRiaqJbD+thxrzi1yFRdv5sPnQpBjO
	 oI0Uiz8GA0cZx2M4JzwK1SkdfPms+hGSpML/mW9cUOjE9JxmPv5KeuXRQN9dP7cxp/
	 8acHsRKVIWusg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594270ec7f9so1246348e87.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 07:07:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwgXYPBXuGGScrJjjPF35pPAYzt4O5n462Aez+PSClnS/fsjbnW0fBvWUv5UvE+YU/xnOVZ7zllg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwLZxoQl4khLsDFPzpkn9k0XKEf6PygrvrMfRrZLv4AQ+iQB1
	WUL9IrEglwNa5EGMjz8ev2sU31gQgz7/O1v/OCiO5EEir7AcBexjbrpVEb9WgZxx6PO9cHJooWG
	9nN6RW9atvl+YHXvnzRWXETyCORC57i44X6cPmIFgVA==
X-Google-Smtp-Source: AGHT+IHAOfkiONe5tfkuIatWxpK+1+BQ2Mtd3EKyiolyupo7EAbMOL0eppnic2LZGQzoSV374+2boUr3vUjOlxckYmM=
X-Received: by 2002:a05:6512:3f0b:b0:598:eb13:c14e with SMTP id
 2adb3069b0e04-59b652cb22fmr1135214e87.35.1767712031036; Tue, 06 Jan 2026
 07:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
 <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
 <87f25d02-2805-9da7-0d7f-05ce8a022d25@oss.qualcomm.com> <CAMRc=McH6jsaKROyMGAhH_gGSiQtqvuVmrUODgtSp0hX8g06=A@mail.gmail.com>
 <466fac7a-e16d-9c49-80bc-c07ba5a5f334@oss.qualcomm.com>
In-Reply-To: <466fac7a-e16d-9c49-80bc-c07ba5a5f334@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 16:06:58 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdNfW9pafvWy8L5iv5StR1b4_jghL7j-08cyPZVeO1Mag@mail.gmail.com>
X-Gm-Features: AQt7F2phEQiXdqhKlEbA_1Ii19T6QcgYifTgwXE_RDm9f9TtDMKssHYYLEX6HPY
Message-ID: <CAMRc=MdNfW9pafvWy8L5iv5StR1b4_jghL7j-08cyPZVeO1Mag@mail.gmail.com>
Subject: Re: [PATCH v19 06/10] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 3:45=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> On 1/6/2026 6:04 PM, Bartosz Golaszewski wrote:
> > On Mon, Jan 5, 2026 at 7:06=E2=80=AFPM Shivendra Pratap
> > <shivendra.pratap@oss.qualcomm.com> wrote:
> >>
> >>>> +static int __init psci_reboot_mode_init(void)
> >>>> +{
> >>>> +       struct faux_device *fdev;
> >>>> +
> >>>> +       fdev =3D faux_device_create("psci-reboot-mode", NULL, &psci_=
reboot_mode_ops);
> >>>> +       if (!fdev)
> >>>> +               return -ENODEV;
> >>>
> >>> This will always create this device for everyone who includes this
> >>> module. Move the of_find_compatible_node(NULL, NULL, "arm,psci-1.0")
> >>> call from probe() here instead and don't create the device if it
> >>> fails.
> >>
> >> Ack.
> >> Will move both calls to init before creating the faux device.
> >>
> >> psci_np =3D of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> >> and
> >> np =3D of_find_node_by_name(psci_np, "reboot-mode");
> >> --
> >>
> >
> > On a second glance - and I may be totally wrong - would it be possible
> > to switch to using the auxiliary bus and create this device from
> > drivers/firmware/psci/psci.c? That would be even cleaner.
>
> Till v17, device was being created in psci.c. Lorenzo wanted to move it
> outside psci similar to design of cpuidle-psci.
>
> https://lore.kernel.org/all/aRIfc9iuC2b9DqI+@lpieralisi/
>

Thanks for the link. Right, there's no actual psci driver binding to a
struct device, rather we only have a set of functions called very
early into the boot process.

Nevermind this comment

Bart

