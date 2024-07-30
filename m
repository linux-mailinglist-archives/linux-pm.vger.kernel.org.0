Return-Path: <linux-pm+bounces-11719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42394217D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A835D1F25706
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AED18C910;
	Tue, 30 Jul 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLI5bs82"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055E18B482;
	Tue, 30 Jul 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370659; cv=none; b=ga6AeRI2gaVLSf+cFFwNsxdI+luhGoAAimazdoVU+RyEMVJIZoVXXUDKJKYtVvXwcBK6axkTRnGZd9KSO/q+wJqZ6bwNUvz2FIOMY8nHokvle2LYYaAl5W8bB/DpExkOQMSVU+FDvRe6qYLg29U9rVYbeRUsDWNWIPekXc8DFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370659; c=relaxed/simple;
	bh=hiPhK21c5P7EMNupOAOqRzWrDTeHJmYPdjtDirfzxtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkjaAxxW5BlNEzTmKGiQ1DHfUEQEdMBD1NQIqxq7VOYqVA04VVi9/rOPiEYx5TYtaiCKbdv0bGQvbFGbjIJenZIwQ+plRCPiOzjlWjClcAr3nI/iyYT27ylLhHaF90n+bsC+Tr8BOL9q4dJVA6Y7a2u7/tWE07bsbUCub0xjfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLI5bs82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD01C4AF0F;
	Tue, 30 Jul 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722370658;
	bh=hiPhK21c5P7EMNupOAOqRzWrDTeHJmYPdjtDirfzxtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hLI5bs82CIN9xksE/zYd3/aBzI4qgx82L11GZyJh0mvH31Igvfx2kCvoDqTka6a2s
	 xaTc46/T1hk5jQWVZEGulqu16IGVfH99Ts1KIn1wa94idHtxhQAjyPnseRtE+CLgIF
	 3mGnFnkIOHs+RQ4XBKsT3L+RFKrIGJyx/QsIxi8m1SZOLbhG3Eal1jpfY/bQDwyYMd
	 IaHRk6Lf/J8Q1ms4n84q2NLGhlcXUijBiNiyOCrP/3UQqaO3M9AkMXAqECkMWcqavY
	 Oa9tx3AXEn/r7KeXr1P0nhHAAiZTqzTsMobSy/q3FpLmX7fbDmglwbQ204ufwKNp4J
	 idkf0gV0e/bjA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db26a895bfso183073b6e.3;
        Tue, 30 Jul 2024 13:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRe5dpU1U0tIgEBHmVD09cX1L8ul5nQZ1ZdZg/rKuu2bs00EatKKfYFtsVgaS3+UmjC3CAoa0vjTw=@vger.kernel.org, AJvYcCVo1KKoDpxgdwdHQzeJa9pkus188raiTnRCCQVvwemM8F7nTRap57gWZKCwl2C3/eAA4KY4WtYnwGm6/r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lggoAcwk78NXBn//Pq9x0Jr3Wp5bGXvcdB5Ai7bTPt6UwfwF
	eoNy7GwRrPIPOPW1J3EKJKBiD1z1m5HxayNsLklXTL5p4bQqKyKYPGT4RWJCxxkQcyCrybtUwff
	Yg8irX/DYW7+cfDEKBlOH71f4Tz0=
X-Google-Smtp-Source: AGHT+IFpzgIUQWTq1kr8AvdOCiJmJ0G7+o8CulyHu7qoiO7iXp+lA9nyN9c5UPQSK7+IehsxfARb+YwES8XN61f6CPs=
X-Received: by 2002:a4a:df47:0:b0:5d5:bc1f:daa with SMTP id
 006d021491bc7-5d5bc1f0f75mr9835767eaf.1.1722370657984; Tue, 30 Jul 2024
 13:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12509184.O9o76ZdvQC@rjwysocki.net> <4448b729-5998-440c-939e-08e719070ac5@linaro.org>
 <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 22:17:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hF+P34O3NDg1GXo9RWGhz5v+BYJj+6YCgipXT+4eEijQ@mail.gmail.com>
Message-ID: <CAJZ5v0hF+P34O3NDg1GXo9RWGhz5v+BYJj+6YCgipXT+4eEijQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Avoid skipping trips in thermal_zone_set_trips()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:46=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jul 30, 2024 at 4:57=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 30/07/2024 16:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Say there are 3 trip points A, B, C sorted in ascending temperature
> > > order with no hysteresis.  If the zone temerature is exactly equal to
> > > B, thermal_zone_set_trips() will set the boundaries to A and C and th=
e
> > > hardware will not catch any crossing of B (either way) until either A
> > > or C is crossed and the boundaries are changed.
> >
> > When the temperature is B, an interrupt fired which led to the
> > thermal_zone_update() and in turn it calls thermal_zone_set_trips()
> >
> > As the current temperature is equal to trip B, it makes sense to set A
> > and C, as B has been processes when handling the thermal trips right
> > before calling thermal_zone_set_trips()
>
> So say that A, B and C are active trips and the thermal zone uses the
> Bang-bang governor.  Say that each trip point has a fan associated
> with it, so that every time it is crossed on the way up, the fan
> should be turned on, and every time it is crossed on the way down, the
> fan should be turned off.  Denote these fans as f_A, f_B, and f_C,
> respectively.
>
> Say the initial thermal zone temperature is below A, so the initial
> thermal_zone_set_trips() interval is {-INT_MAX, A}.  The zone
> temperature starts to rise and A is reached, so an interrupt triggers.
> __thermal_zone_device_update() runs and it sees that the zone
> temperature is equal to A, so thermal_zone_set_trips() sets the new
> interval to {-INT_MAX, B} and f_A is turned on.
>
> Say the zone temperature is still rising, despite f_A being on, and B
> is reached.   __thermal_zone_device_update() runs and it sees that the
> zone temperature is equal to B, so thermal_zone_set_trips() sets the
> new interval to {A, C} and f_B is turned on.
>
> Say the temperature rises somewhat above B, but does not reach C and
> starts to fall down.  B is crossed on the way down, so f_B should be
> turned off, but nothing happens, because an interrupt will only
> trigger when A is reached.

Worse yet, if the zone temperature starts to fall down between A and
B, after setting the thermal_zone_set_trips() interval to {-INT_MAX,
B},,nothing will happen when A is crossed on the way down, and since
the low boundary is clearly of the "don't care" type, f_A will not be
turned off until B is reached AFAICS, which may be never.

> > I'm failing to understand the issue you describe
>
> I hope the above helps.
>
> > Were you able to reproduce the issue with emul_temp ?
>
> I haven't tried, but I'm sure I'd be able to reproduce it.

