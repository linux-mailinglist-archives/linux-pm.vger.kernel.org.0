Return-Path: <linux-pm+bounces-10103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67491A330
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A09A28633F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EE13C80B;
	Thu, 27 Jun 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju3cGWCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59913C801
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482106; cv=none; b=rpYrl0Sd7iooBP3VnIRqZwQL1mrEUbhtHNIEkaE0iX9wN5YXy8TYCqEGGOV4IYr9+T61C+mTFKMJQgBDUIonC8lt2YDixzp0Pxdl8oWd2Rk6HgFCpUtw1OkRFTWx3t9l3nTR7GDkjIzOMBBQ5aPZnP7bCI3GLl3tiy2RqsX+N5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482106; c=relaxed/simple;
	bh=8Z5WPgt8DYSrKHeJki7Qr07yX0FWtIjikT/Gga+0x8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCe9OMQ6qmOkVm6H55+CEHg+4KVc1V4r6KY9vTjgw861aPUKjYjKRy4KmFwv0ZPibaL84/FUHBQXBPna2CIPw8Q7Z2t7oIuVqYvG8w9+R09qgWMG5lSJJP43fFqaZqod7ldnlEYBfihk6d8btST5ww1ci5wfaNxOk7/y7qaP8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju3cGWCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D644C2BBFC
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482106;
	bh=8Z5WPgt8DYSrKHeJki7Qr07yX0FWtIjikT/Gga+0x8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ju3cGWCTuRrPYZYKVNP+VV4uBqPj+8CnXiblLbr92oDbxXZ/Ybt7FukAi3gkPEe/5
	 m2Vnn0JeSkSPSqrZzp28nfp+7nLK8nDJlkUY+RsFv72FsUrmOCn7eyUB0AMob0gZ0Z
	 jV9C4MPwsxq43ug8BtGUoBLvzZhvvxVBjhGFxMFX2ABPj+vAyUqABouHdHVe2cpf0q
	 Q7FSomTHNGvnO5a4MuoKEG84hgAjYskuVwtPbte3bU75lAcK5DptB/BKn7x7M6z/lr
	 LY/i23AeJ9MILKwUQ1d/aUzVaqSks0MvSdFCp9IUABCgkqoUyIfFZcThKQc76LVD0K
	 v/8qmZClG+bRw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254939503baso902801fac.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 02:55:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmX5ZFUDmBDIKOtT75TXHUijJ+Yvklc5r7OcF4+pUB3vEVv8R8TLtvwpS4ftRf6R2MyOj1DNg0Amosa6OquErIyJsfn1uV2OQ=
X-Gm-Message-State: AOJu0YxoUlW+BG+8ZaTQlfmj/xmT8NsFj6V/LSQ7zkdO2adwiqE5zHa4
	qPKzmvL5Qnw/epE0HdEfDmqY0uSHkCguC1DFwQbW0mImK4EU6lc5FQlCB3BGixhUpDhen1OZk9A
	sFS6YYsvZ0gQr2V+uOYt+rc39Lus=
X-Google-Smtp-Source: AGHT+IHp3u+B/Nvf/WvSatD00IK3uw+nXt64Qn4H6BclCAv6ZuYKp20u5Ga8mX3h5oGB90g25Yi97UzATUx4mtUJRdE=
X-Received: by 2002:a4a:3c4d:0:b0:5c2:23ee:c85e with SMTP id
 006d021491bc7-5c223eed359mr3613935eaf.1.1719482105544; Thu, 27 Jun 2024
 02:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org> <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
In-Reply-To: <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 11:54:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
Message-ID: <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
Subject: Re: Trip points crossed not detected when no cooling device bound
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 12:24=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/06/2024 23:21, Daniel Lezcano wrote:
>
> [ ... ]
>
> >> Oh, I see where the problem can be.  If the zone is polling only, it
> >> will not rearm the timer when the current zone temperature is invalid
> >> after the above commit, so does the attached patch help?
> >
> > At this point, I went far when bisecting another problem and I ended up
> > screwing my config file. So I had to generate a new one from the defaul=
t
> > config. Since then the issue is no longer happening which sounds very
> > strange to me.
> >
> > I'm still investigating but if you have a suggestion coming in mind, it
> > would be welcome because I'm failing to find out what is going on ... :=
/
>
> I finally reproduced the issue. That happens when there is *no* cooling
> device bound on *any* thermal zones.

Interesting.

> Your patch seems to fix the problem but I'm not sure to understand the
> conditions of the bug

It's probably the same as for commit 202aa0d4bb53:
thermal_zone_device_init() sets tz->temperature to
THERMAL_TEMP_INVALID and if the first invocation of
__thermal_zone_get_temp() returns an error (because the .get_temp()
callback returns an error), monitor_thermal_zone().  If polling is the
only way in which the zone temperature can be updated, things go south
because the timer is not set and there is no other way to set it.  No
updates will be coming.

The reason why the presence of cooling devices can "fix" this is
because thermal_bind_cdev_to_trip() sets tz->need_update to 1 which
then causes the thermal_zone_device_update() in
__thermal_cooling_device_register() to trigger and that will update
the temperature.

