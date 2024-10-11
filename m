Return-Path: <linux-pm+bounces-15549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16A99AB98
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD96284667
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A331D1F77;
	Fri, 11 Oct 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBGXVSgz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839D1D1F50;
	Fri, 11 Oct 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672634; cv=none; b=tDn163CNYEAWu6iYv5eEiJD9O/T/9k9InEx1Ck6bF7KcyBIOUac8jO8CkShEwpNUEV9mP7tyAQK3BP1ZS3l8ocmbd4YMaAQT5Cey/M4263YAHvMDH+e1GGmb2tvgwYTu1/GH99DqKMLe/Zjxs7ArrU5cVSzXHCMlDjyNZhXlUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672634; c=relaxed/simple;
	bh=KGqrwrz9rijYsZOFZQqOgtqWXnVwlvn+wECMYTeCqto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4AvubizTamE9jBaTWEfrTMqmCBfJBjITAGpfL+QSABJ3eqHDq3RzdhFNfmYAZmG5QNvi+8qkX2Pc2DhbL+C/jHQiCpEaJBIQ8rdG4hP65lfJId8qFD/n4S41AXQqeQlu1UGIVoGJrhB2bNdcgt/aUGLFzjl1wsSS+0+pc+rLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBGXVSgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E551C4CED0;
	Fri, 11 Oct 2024 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728672634;
	bh=KGqrwrz9rijYsZOFZQqOgtqWXnVwlvn+wECMYTeCqto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hBGXVSgz812BzTB2UGwYHPoFRAXz7b+FlayuWUW3msWatkV52R9P8AHejKdjRKNOx
	 X/kQiKWzKny/lSWCoHfyO8ht0i3d672nU5/k7p2dzKkOkb5Wvmo6JWwkZXGFftz8T0
	 WAFhijnEVLK5+FGlibey/gl7nF9afHEi+422gop5CqS3Y0Wjs9X5ugUBcsRDtKCN+w
	 15eAD6QoqKqLwESXIRkxYm39CUcOBO6QkAGs6AkFaoY0a/e/6B5ryf6a+BR/PbBXgh
	 sa6qmrp4mUdrQySO5iI2sq55Yx+uVoAHiu8Pm8j9WwvDtRR/sCeIcG3I7UXJF10tOM
	 g2gHPO3XoN0ng==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5c89b013aso718529b6e.1;
        Fri, 11 Oct 2024 11:50:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMLL7r/0AnyAaGuPRI8t3FJcs+0Y3m4DHIggFEN1UOJDkRntMx
	ygK0hXKjeeZqsiRE7pMw6SA6c34L4QApY4MMRRg/ALSxfL//g72IeSjTBe7kT7h42QX75tBIQvx
	OWMRceT+lWPtgXydDfDQvNZh9J6s=
X-Google-Smtp-Source: AGHT+IH9VgVC4JpV+eM6owJCRSUovcu4KkR6W0cCww4iTZUWy71hO6bqGE47jJCheZl6Ru+TkBFhu9s3SdRcvXwvf7k=
X-Received: by 2002:a05:6808:4491:b0:3e3:a933:67e0 with SMTP id
 5614622812f47-3e5c902ea16mr4218769b6e.0.1728672633361; Fri, 11 Oct 2024
 11:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2215082.irdbgypaU6@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 20:50:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
Message-ID: <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] thermal: core: Fixes and cleanups, mostly
 related to thermal zone init and exit
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:11=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> After posting the two series of thermal core patches for 6.13:
>
> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
>
> and
>
> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
>
> before the 6.12 merge window, I have decided to reorder the changes inclu=
ded in
> these series, so that fixes and more significant cleanups (for example, c=
hanging
> they layout of data structures) go first, followed by the changes related=
 to
> using guards for locking, and the optimization involving sorted lists bec=
omes
> the last piece.
>
> This series is the first part and the majority of patches in it come from=
 the
> second (RFC) series mentioned above.  Of course, they needed to be rebase=
d to
> be applied in the new order.  It is on top of 6.12-rc1 with
>
> https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
>
> applied and it will be added to my thermal-core-testing branch.  It is in=
 v2
> to start with because all of the patches in it have already been posted i=
n
> some form.
>
> The first 10 patches fix some potential issues related to thermal zone
> initialization and exit (for example, user space may start to interact wi=
th
> a thermal zone during its initialization before it's ready and system sus=
pend
> taking place at a wrong time may skip a new thermal zone so it is not sus=
pended)
> and do some cleanups related to that.  This concludes with the removal of=
 the
> need_update field from struct thermal_zone_device.
>
> The last two patches move lists of thermal instances from thermal zones t=
o
> trip point descriptors and clean up some code on top of that.
>
> Please refer to the individual patch changelogs for details.

This material is now present in the thermal-core-testing and
thermal-core-experimental branches in linux-pm.git.

