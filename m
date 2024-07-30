Return-Path: <linux-pm+bounces-11686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB2941AC1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EB4281BDD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FE189915;
	Tue, 30 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHfH2ivJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD3183CDB;
	Tue, 30 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358022; cv=none; b=IKEPCCW9tUviE5BsxvIZCZSpfTtQ0Sqo8vZe7ErAH1ZEvHLK6NZEcJ8fOFFuHAk1Z3RwSVq+bFS2Guljx5asG8TYrIfAhNTrXLMuntmZ6W+u8cvL49E80a35s7xpKhfkQqxD5RqcHxfu8bHySWn/d9z72RgrgA2SIFJvjRiLEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358022; c=relaxed/simple;
	bh=JllSbRzlrers/Isw10IwBzM9f4MiLhTlrWMJBS2vqWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOLpfPREoMjTuQudSUmsm0+7A+EUDiGznmCrbBWVtbp/isnIhcr0jPmC7jIAnAILveelOs8C45HU+WymtByV4YFISPWk0G5+9cpmyJ5AGLqkUjzt5QKE7ijB8T/BeUFTmVZLebrWhkrY18op0wJhM2wSU/NrEiW48kbYXrCoJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHfH2ivJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861F3C4AF0A;
	Tue, 30 Jul 2024 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722358022;
	bh=JllSbRzlrers/Isw10IwBzM9f4MiLhTlrWMJBS2vqWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pHfH2ivJx+Ab1kMY+qN2fz/yab2yQNe1J8LVwjxwaRuN7f3FdAeq+IgwaukOlgQSv
	 DjcQiRA7hOUSJDJvwhWCUNM25EsR+zfs+fdtEpPVaqBiOquGt+F1kq6yhmwAIcDZ5L
	 003ps06q6NM7HPDvSIE/F1QCX10Hqdo+8y8YHIBgFgE16Z39B6ZJJ0uJ0RHabvUDDs
	 zlehGt7F1M/r3K7sxXzq6SiPNlsVSdIfmgrHBgtJQA+1fYnDu4WpKm4QmVJ6GRo2xv
	 hlbw1/B6jTlRZunQ5U8EAehicbpHBPQh/f53NX3xWVP1j+PlSKY7KzAvlKaSHc+FGn
	 1b7yLB7PSYwbw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25075f3f472so1139352fac.2;
        Tue, 30 Jul 2024 09:47:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/7BmE/fuUhCl6xOH56fLyh5XX6EdDu76lMWXbzZJ9K15mwn2N9H7RmrjniAiYU+8RB9OgPqS2WQg=@vger.kernel.org, AJvYcCVzvrGA8ltL3eZWzmjyxHiAWgO21DY4PyqVHlDNvx8hGBKxUb6DmqbTRobyCJAA5BRvJIHWEc7cTD8xuGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFs9R1YJ19WfpMWDH9QNlLaTqo18akBiz0uVQoIrnKDbGwQ2vO
	q1m3UsQDEY7gCZHWwZjokxbjVcj6gh5QJtrFuYFP2KDF1jpL2ROls1M/6omGcrWjDAJiXmffFi5
	vccK6KVOxUaawxIavyh/lSnmQtpQ=
X-Google-Smtp-Source: AGHT+IGkDoCuqQatA6HP3k9V79ecnwsp3VCyAHDjBJyn5K5eDCz8O4Pp5O3yGTKVoy96vlE2U6d7SSIvSTg/qbg6Q4M=
X-Received: by 2002:a05:6820:2205:b0:5c7:aeba:77a0 with SMTP id
 006d021491bc7-5d5b12f2301mr13131826eaf.0.1722358021819; Tue, 30 Jul 2024
 09:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12509184.O9o76ZdvQC@rjwysocki.net> <4448b729-5998-440c-939e-08e719070ac5@linaro.org>
In-Reply-To: <4448b729-5998-440c-939e-08e719070ac5@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 18:46:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
Message-ID: <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Avoid skipping trips in thermal_zone_set_trips()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:57=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/07/2024 16:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Say there are 3 trip points A, B, C sorted in ascending temperature
> > order with no hysteresis.  If the zone temerature is exactly equal to
> > B, thermal_zone_set_trips() will set the boundaries to A and C and the
> > hardware will not catch any crossing of B (either way) until either A
> > or C is crossed and the boundaries are changed.
>
> When the temperature is B, an interrupt fired which led to the
> thermal_zone_update() and in turn it calls thermal_zone_set_trips()
>
> As the current temperature is equal to trip B, it makes sense to set A
> and C, as B has been processes when handling the thermal trips right
> before calling thermal_zone_set_trips()

So say that A, B and C are active trips and the thermal zone uses the
Bang-bang governor.  Say that each trip point has a fan associated
with it, so that every time it is crossed on the way up, the fan
should be turned on, and every time it is crossed on the way down, the
fan should be turned off.  Denote these fans as f_A, f_B, and f_C,
respectively.

Say the initial thermal zone temperature is below A, so the initial
thermal_zone_set_trips() interval is {-INT_MAX, A}.  The zone
temperature starts to rise and A is reached, so an interrupt triggers.
__thermal_zone_device_update() runs and it sees that the zone
temperature is equal to A, so thermal_zone_set_trips() sets the new
interval to {-INT_MAX, B} and f_A is turned on.

Say the zone temperature is still rising, despite f_A being on, and B
is reached.   __thermal_zone_device_update() runs and it sees that the
zone temperature is equal to B, so thermal_zone_set_trips() sets the
new interval to {A, C} and f_B is turned on.

Say the temperature rises somewhat above B, but does not reach C and
starts to fall down.  B is crossed on the way down, so f_B should be
turned off, but nothing happens, because an interrupt will only
trigger when A is reached.

> I'm failing to understand the issue you describe

I hope the above helps.

> Were you able to reproduce the issue with emul_temp ?

I haven't tried, but I'm sure I'd be able to reproduce it.

