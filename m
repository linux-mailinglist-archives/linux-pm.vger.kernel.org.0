Return-Path: <linux-pm+bounces-12558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FC95846C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9831C21FFE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41418C93A;
	Tue, 20 Aug 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn3ADgew"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3497581F;
	Tue, 20 Aug 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149662; cv=none; b=VjwZ5FMaiyL25q6uNe2/i5QlNApRJ5WirCrjnKWbkhGUvgE99F7XXnfTsTGZHbCpprevOkx/qLO7gW+DQG4ZIMj3RvQFHxzRM+CfHck3U5iZlyZn1KE002kBogAfjC+ayNFpWpgLFjkkzm1Io1OyeGPIRgaAXufL7geuzi1vMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149662; c=relaxed/simple;
	bh=uj1mc9dma5D/TA0A5fG99E3lG/cctuHSADUVSQEHd5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY81VyXHqotAOs551PwqIrFOVkUJ+Q0NVnIJCr8uC0z7C5w7CDBE2Hs7G4rmEgJ4C5nQqyMfYxP7mJ5Y1zcIUUA8uE5tvWbjqUuTm9Rt0ys6Bv867Gs+DsD3wt3LIV6YhY3RP4nk2eNn5R1xgS61mSqd/yMd4Pwch1wGdKNmW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn3ADgew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99518C4AF11;
	Tue, 20 Aug 2024 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724149661;
	bh=uj1mc9dma5D/TA0A5fG99E3lG/cctuHSADUVSQEHd5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gn3ADgewFupOlQBAvWw5ozANB+sC8JJJLZgRA44kGZc3L+Wf75Oo0eZZJMqlUeAGY
	 Rh+x/GLK8xn0agNTlNL7hvF0qRczx4sf2J8iBtMPiFgWwuSn6Vl/RqpVqPglZzIGUA
	 6qE02ZUeKVz9tc8rsa43HSeREbZ3wET3gC4UY7MAlGCYo2AeY7hyUe5DDo7O046v1v
	 82vmyXb9SX8+1CK+hOrA6ZWE4sYzhyLIeAiIlm46hzfe5oCJ69kPBq9oFoZHIz/HkT
	 wylNG/8r3bcxKZXdHC+5IW61nfNEGIC2/gyE/9AF2Figwx/b+skLcrvnL4tOZtH+nh
	 XlrmDDYXW6U7g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2702920904bso430497fac.0;
        Tue, 20 Aug 2024 03:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU51J+Lup43RaNhdZY7JlhYgP6qFpVQfTNwiSFkpB+ShIWPF/My0gM958wlyVzjxZK4eW+VnMDJuug=@vger.kernel.org, AJvYcCVw8TjCn89ehJarafZzjRkec9kHNMivGFUAL3XSsDX6DfKwQjC+d+mPRss9nBhxXJsjGOdlRpfm6hn5+pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Mz+MJ+BuYoGMJ5yaNxl1BcVVjmfVrzLr3218XWr3zxckI2I1
	DJpHtuEPARfcax6w1YU8rdCiENF576dTgLXz4dTFU9uiMwabfEUtjDqd72vWviPARG7TUUdcKu5
	jSop8sTSiELSN8L7AQGw07QjzBX4=
X-Google-Smtp-Source: AGHT+IFb1UV/1ktn4Q8KJFeVM3iSif7xxRIdNFKgzotdso2YGeYOhGFLxhjbxA/laFg15SWubNOQiWTqHmjcy1aORM4=
X-Received: by 2002:a05:6870:b253:b0:25f:401a:2ec3 with SMTP id
 586e51a60fabf-2701c0a7b6fmr8310927fac.0.1724149660774; Tue, 20 Aug 2024
 03:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <3837835.kQq0lBPeGt@rjwysocki.net>
 <6bf771b0-d57d-5a8c-ec36-6f8a041695d9@huawei.com>
In-Reply-To: <6bf771b0-d57d-5a8c-ec36-6f8a041695d9@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 12:27:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_Z43bLWsa9gg_SZFBURi1XrZn4Cnxurm8KCawAWqtUA@mail.gmail.com>
Message-ID: <CAJZ5v0i_Z43bLWsa9gg_SZFBURi1XrZn4Cnxurm8KCawAWqtUA@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:27=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2024/8/19 23:58, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> > acquire the thermal zone lock, the locking rules for their callers get
> > complicated.  In particular, the thermal zone lock cannot be acquired
> > in any code path leading to one of these functions even though it might
> > be useful to do so.
> >
> > To address this, remove the thermal zone locking from both these
> > functions, add lockdep assertions for the thermal zone lock to both
> > of them and make their callers acquire the thermal zone lock instead.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: Rebase after dropping patches [04-05/17] from the series
> >
> > v1 -> v2: No changes
> >
> > ---
> >   drivers/acpi/thermal.c         |    2 +-
> >   drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
> >   2 files changed, 23 insertions(+), 9 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -785,6 +785,7 @@ int thermal_bind_cdev_to_trip(struct the
> >       int result;
> >
> <snip>
> >
> > Index: linux-pm/drivers/acpi/thermal.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/thermal.c
> > +++ linux-pm/drivers/acpi/thermal.c
> > @@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
> >               .thermal =3D thermal, .cdev =3D cdev, .bind =3D bind
> >       };
> >
> > -     return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
> > +     return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &=
bd);
> If so, it seems that the for_each_thermal_trip() can be removed or no
> need to export.

I beg to differ:

$ git grep for_each_thermal_trip | head -1
drivers/net/wireless/intel/iwlwifi/mvm/tt.c:
for_each_thermal_trip(mvm->tz_device.tzone, iwl_trip_temp_cb, &twd);

