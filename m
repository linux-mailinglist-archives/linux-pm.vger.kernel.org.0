Return-Path: <linux-pm+bounces-39161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E7C9F298
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 14:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141CA4E0644
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436F2FB621;
	Wed,  3 Dec 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seIqWJ6Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B42F746C
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764769263; cv=none; b=pl+pTcXXlgjlvoKcEqLX/oVS4zEJJ5GNqZkxL+pXOXxgfK2Azn3g+oeuZGMEiMX4e5/0okT0N50lQERTeT4k852qpSeN02ikOrCV+8ODp8up31SaTVUzNrTlcunQicVdoJZFLnLTFMPpPIGmOVjsoSoq4Qq/4yC5cbODk7DQWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764769263; c=relaxed/simple;
	bh=WgeCBu7yk+EAa6yjfYBdefiJzHhmgcwaJ/PwZrzocL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzZV7z4/v0WFf8pz+MX3PpmkGfXljyz2CQuE+Qhwf0vTxVLuVAwKkAPqeLsyD6vBfnv0m60kSxLZldVE4m+QRVkC8djqZvyphH7hDcDnGByiK6v4UsEYZjdZSXkpoeqit5rPAtTyfqpBbRwI7q/U+k8njZx8gudxkHN75AHK6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seIqWJ6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25BC19424
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764769262;
	bh=WgeCBu7yk+EAa6yjfYBdefiJzHhmgcwaJ/PwZrzocL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=seIqWJ6Z236TfaiWifLkufCSkhJaCtuFSV7kzMmfS3Wntg0m9xoggeiduBV9GySKc
	 OlAPWE69Liys69SXhCf0itYtw0kKZq2EO5Jir3DgjXqWsq8G1WKjpsIJMnVNKBqIa5
	 8X+bbbXaEdyGYrAyYMegW9U7pKuvtcvKaUYA9pyYoYrsYh9fetgaitUgD1wCVidmkq
	 8AdnQSI1t3wnXhxzqq0DVgGg0BPB6m3rJaQgOAuUtPWiqD6ehT/DJK2JFYw67KwcYG
	 G+G6U4tU89ZYKmUdp6WTC1+olc5PgbdyGcYDm/WP5LyIQIlpGB9M8C/RmhvJUwC5x0
	 3nXhZ4DpnwPKQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75fc222c3so2701056a34.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 05:41:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkrft/cuRXbSYAm4bqoSgWIdYqdvyKU2Lef2h+0iya6sJuZ1MqpbTFLXduoEFqEVcJdmenMtStdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cRX8M49HkPogji/K8wx8eLDeKK02NNhqiymofFQ65tCRohxq
	VFk7dere/4Y9QXtbuDWKACvCHP6QXiB2iCc1tLGmYeGC7FNqNdhBB6bla/Eus7wbi1wiQgmgK6R
	VSv7vFSD7PK8WiHM64kXHnRVIJk4D7WI=
X-Google-Smtp-Source: AGHT+IHGJHeqVkEM2pfPZ2VCgrRsv4aUtjBFxweid51gvGR4ZmOw13QuuV1jRxSVUTQScHlkpe5V8vcP4Q1fSMqF9xI=
X-Received: by 2002:a05:6830:909:b0:7c5:2e2a:d386 with SMTP id
 46e09a7af769-7c94dc0ba4cmr1300869a34.21.1764769261795; Wed, 03 Dec 2025
 05:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03c013c0-be12-42ab-91d1-f87395c890e3@intel.com>
 <c711e3ac455a552c130851d7a45916a3ac992390@intel.com> <51f6228d8bb6df524995b5ad4c49cbdfcbafb952@intel.com>
In-Reply-To: <51f6228d8bb6df524995b5ad4c49cbdfcbafb952@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Dec 2025 14:40:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hw_zUUf1Ns_tvq8zC06T0NKzUrqKrN25VFwaFs5rJPNQ@mail.gmail.com>
X-Gm-Features: AWmQ_blBYlpsZxQ2SlxK-jH9v9TrW3GjxfOR6u6X98onqzEikEtr68AEj2gajoo
Message-ID: <CAJZ5v0hw_zUUf1Ns_tvq8zC06T0NKzUrqKrN25VFwaFs5rJPNQ@mail.gmail.com>
Subject: Re: BISECTED REGRESSION on v6.18 (was: REGRESSION on drm-tip)
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, brauner@kernel.org, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 2:36=E2=80=AFPM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:
>
> On Wed, 03 Dec 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Thu, 27 Nov 2025, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@in=
tel.com> wrote:
> >> Hello Christian,
> >>
> >> This is Chaitanya (again!).
> >>
> >> This mail is regarding another regression we are seeing in our CI
> >> runs[1] on drm-tip (with both xe and i915).
> >
> > Referring to drm-tip is downplaying the problem. The bisected regressio=
n
> > is in v6.18 release. It's breaking suspend/resume across a lot of
> > platforms on two drivers, i915 and xe.
> >
> > a3f8f8662771 ("power: always freeze efivarfs")
> >
> > As far as regressions go, it's pretty bad. Please prioritize.
>
> Added some missing Cc's.

This should fix it:

https://lore.kernel.org/linux-pm/12788397.O9o76ZdvQC@rafael.j.wysocki/

