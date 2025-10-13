Return-Path: <linux-pm+bounces-35992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5740BD5B78
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43194ED440
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479222D3A9B;
	Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtN0njAf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216082D46DB
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380208; cv=none; b=OpRhJGePjTjQxXOl+RgBBgA8ld1BDTv9TiczGAowyJsfp7GcPxhUSPhIliNvTCyK19kFPeH9i+JgXw9lqSOmaAoUMfvk+t8CydImL9qSO2YkJXgWkuFiyNrz/8V8Wch1fExKGt48+sNfNwR+emCYtTzWAYuYZXkj6fcnCcshrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380208; c=relaxed/simple;
	bh=UweM+L90OGCDu2JgL8AKhNEC7OIFbFzIiTiZKCcYqIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8V323b+YkUmDw26mW9CBr1Sj1tR4mYgBsLRRz0oRFwShISQIuELp7ip8ddxDJzPNJjFoqRpW5+JI1BXYY+x+dFTLlCQ4rkbfriCqIlep1dtiZUTQYThf6jNC+dKXcjE26MPIjLmhUZcDnga3bneI2di27ZgCs7CZdNzxwIHzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtN0njAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC6BC19422
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380208;
	bh=UweM+L90OGCDu2JgL8AKhNEC7OIFbFzIiTiZKCcYqIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qtN0njAfBQ0B+t11crFgpb6Hk0VQnAhENFU67Jt+3SU5ItPie2s3PutyQ9gzujDnl
	 s91ld3ZcaFl4hniBVcGq5j6ieos8EXRJ55Ttcow+N2bv4V78hYVqZdNBsoNuSTD/ew
	 pPgzCGUqCenzrmDb1k6PGYtapzdqTOSLkI6GGBkUt45JzsRv4ZKEoakYcmqtFGLL3k
	 oL5sNAMMkquKnLFG0bYtdeC4h6iwME1gAme5j7RXV+YOraBYstr5Waso4bEYLqZaIi
	 dRG3DR8a0K4gv7Soc+kdH1nhysmTs9QShOzMj2853xL6EeRdWOC3JJtDVV1NyuCuf9
	 3Mn3VpK1xGVsQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-441de7ba142so385171b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:30:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvdAmAkDxGkkA1gOAmg+gScWQKiqGlx9RHexTEOzpPNbCCkf56gpXXQWsbVXEAHtBPLASpSlfAcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuHkHe1EQ8jeY3ZeB8/FQJnPmz8YvV+NlzmVlfUZ6YcCEw/+i
	vuJp+y0XpzWeCRD9Qd2xDh4vJSzmuq5C/G6sbFwnZkbjFdkzc8KdtUdwyYhcqLV18f7FUVtamQ5
	cl/O2JEsEZwFvveb3cu9hsJH8w39hnyM=
X-Google-Smtp-Source: AGHT+IEidsorgj7WZjmq240EhlEZc8BnvKKAzSXOoGbRoYt0lU05odHT7I8aBQr229CSF34G8HWT9HQudIxjW0ChoE8=
X-Received: by 2002:a05:6808:1203:b0:43f:29ec:a210 with SMTP id
 5614622812f47-4417b3e9520mr10710947b6e.47.1760380207222; Mon, 13 Oct 2025
 11:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013174729.1101186-1-superm1@kernel.org> <20251013174729.1101186-2-superm1@kernel.org>
 <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com> <92a24599-efc7-4684-abc0-bcf3fb203744@kernel.org>
In-Reply-To: <92a24599-efc7-4684-abc0-bcf3fb203744@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:29:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNzfpW=ot9JSYoAbOdpWEzkoxxYx+zKkofCni3EeA-jw@mail.gmail.com>
X-Gm-Features: AS18NWA4p6B2QnnjTVdeSaW5EUz4KzwEi_ifHtYzW-l80mppmBMWYn7Koe0-WnI
Message-ID: <CAJZ5v0gNzfpW=ot9JSYoAbOdpWEzkoxxYx+zKkofCni3EeA-jw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PM: hibernate: Nominally skip thaw sequence for
 all devices
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, airlied@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:27=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 10/13/25 12:58 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 13, 2025 at 7:48=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> After the hibernation snapshot is created all devices will have
> >> their thaw() callback called before the next stage.  For the most
> >> common scenarios of hibernation this is not necessary because the
> >> device will be powered off anyway.
> >
> > And how exactly is the image going to be saved?
> >
> > It is only in memory when the "thaw" callbacks are invoked.
>
> Ah; right.
>
> I suppose one option would be to thaw "just" the backing device, but
> this could turn into a relatively complex mess because it would have
> relationships (parent/child or device link) to other devices that need
> to thaw too then.

Right and that's exactly why everything is thawed.

