Return-Path: <linux-pm+bounces-16076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE69A65DC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A041F2180B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E11E3DF9;
	Mon, 21 Oct 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdZ3CQoz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041271E1C19;
	Mon, 21 Oct 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508769; cv=none; b=FELCccSpzKwSnc9SRll6WGRHn/gWnNRTM48KlIAuH2oDG/3ISyaGvSQ+7Rnmmk/NK4/SaLtjP55ZFx2US4Kp7qq8WBkWBAp3cKVC3N2ZbnmcFlLdbVlIsmFL596Dofwq8Yjei32gN/5z5sETRCgsiu7QZGg17HoQLUsX8MiY2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508769; c=relaxed/simple;
	bh=R7/RPu4AFxZsi+EZ6njnKVrGIe+/202VV6/um7d+mDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYjLc+7pIHVLKemNaWH1Jv8SJd9Yzz797cky6JeQh6Mcg8Gk4tJj4RUGyBurZWbw5/Qk8Mix5dUBnaMKCg0AorCbsNA5z6JtV8qmftMmFQllX1GEpGA4SYplEWlfntpk7fn8KD/EQfiqixekBBM7wDi0dPgaEZptzVvISHcOZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdZ3CQoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94021C4CEC7;
	Mon, 21 Oct 2024 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508768;
	bh=R7/RPu4AFxZsi+EZ6njnKVrGIe+/202VV6/um7d+mDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XdZ3CQozSDYYkApVtuKYyW5LmJYAMAwy6Znwug0H3YUmyvhEg6NjB1v98R6TNtRzu
	 WT2EP2E+vmqZcAtDiFWAAUIhih5N7FKhkHP7izhCiRL7tjKOb3+QmGGMIHXni4osK6
	 nz4kJ0zc6NvTRoZ46tzx3a3TdSH0kS1Dziv7jE8VmmaOjlR5hbKABnZdPNhRq7LMOc
	 TvankPaxTx8p/yPym3eO5Z8ElZ35+a9OIiL7wX9kCltBu1FCYsX0zy9VR55YrwjIsr
	 I2RXjWhACApyZKIgM3N+U7N5+7D2mQ3NeLXWJlA4hkDBaW86LaWAOvai2QvG2Jnq/+
	 e5uB7V7FXRvrA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2886e2b878dso1659160fac.2;
        Mon, 21 Oct 2024 04:06:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGQnZRCNll+pvweFF93jlrbfsjITXHonQC+hVW5NsTtBh1ybRl
	PuxNoQxoC73B4913GWS3ZgoNErRqnFAbhGax0JAHcRGHFMVkL7YhY8ulTrMWMXbfaL7H5GC8GcU
	kRwD6VLEln6h9C37mvbDFK6ClE7w=
X-Google-Smtp-Source: AGHT+IFw9ozZilzB71Zf6F2Ku0o4gspj0Z1sOAsPFF4yN/METxHLnodD3eBvvVLagOHOl/1bmmFhTADmtnQaw+4j00g=
X-Received: by 2002:a05:6871:6ab:b0:288:5c55:dfd5 with SMTP id
 586e51a60fabf-2892c544d6fmr9025782fac.31.1729508767832; Mon, 21 Oct 2024
 04:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2215082.irdbgypaU6@rjwysocki.net> <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:05:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEgr7Q49JSQQ37_2VbdXBTDPZmoYHuCSACJW_3gdmuwQ@mail.gmail.com>
Message-ID: <CAJZ5v0gEgr7Q49JSQQ37_2VbdXBTDPZmoYHuCSACJW_3gdmuwQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] thermal: core: Fixes and cleanups, mostly
 related to thermal zone init and exit
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Oct 4, 2024 at 10:11=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > Hi Everyone,
> >
> > After posting the two series of thermal core patches for 6.13:
> >
> > https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
> >
> > and
> >
> > https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
> >
> > before the 6.12 merge window, I have decided to reorder the changes inc=
luded in
> > these series, so that fixes and more significant cleanups (for example,=
 changing
> > they layout of data structures) go first, followed by the changes relat=
ed to
> > using guards for locking, and the optimization involving sorted lists b=
ecomes
> > the last piece.
> >
> > This series is the first part and the majority of patches in it come fr=
om the
> > second (RFC) series mentioned above.  Of course, they needed to be reba=
sed to
> > be applied in the new order.  It is on top of 6.12-rc1 with
> >
> > https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
> >
> > applied and it will be added to my thermal-core-testing branch.  It is =
in v2
> > to start with because all of the patches in it have already been posted=
 in
> > some form.
> >
> > The first 10 patches fix some potential issues related to thermal zone
> > initialization and exit (for example, user space may start to interact =
with
> > a thermal zone during its initialization before it's ready and system s=
uspend
> > taking place at a wrong time may skip a new thermal zone so it is not s=
uspended)
> > and do some cleanups related to that.  This concludes with the removal =
of the
> > need_update field from struct thermal_zone_device.
> >
> > The last two patches move lists of thermal instances from thermal zones=
 to
> > trip point descriptors and clean up some code on top of that.
> >
> > Please refer to the individual patch changelogs for details.
>
> This material is now present in the thermal-core-testing and
> thermal-core-experimental branches in linux-pm.git.

I gather that it is not controversial and it has been around for quite
a while, and it was discussed during the PM+TC session at the LPC, so
I've just applied it for 6.13.

