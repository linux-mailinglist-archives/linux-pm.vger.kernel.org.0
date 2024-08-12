Return-Path: <linux-pm+bounces-12067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176FD94EC0E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF93228277B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D30176FB8;
	Mon, 12 Aug 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOM2K2I7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502631547EA;
	Mon, 12 Aug 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463299; cv=none; b=k7nlsyBJrlx3urKz50P3fv8mm1aQzJtglXup6ZVFjQLVimgQrMYR1A422BRagSi058V6yFKf70yrsvzpo5+SLiolpp9yE+0pGOaQKQ63gVHtkr5AH3OMLbNYh9VoJ3c44WHGhts0e6MSD3ROkr4CNnKilU7cjuLnAyxe96Mk9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463299; c=relaxed/simple;
	bh=Napc90aktE/QuypSDHJKVOFzOHDipFwPsvcMXXd1YqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itYxe5ZIeQ4K6dl6PjSzaJaWC6LINQmTFYuMlfatLbUE7J6nspv8a6ufuFz+rGjzG1VpS+f3MLLHHWgMSnQtXYgQUkJSlrXUi6fjLJRI/WaFitjnSqo+klk9gdW6gvNhWKdpNsNdm8YALZ4a5dNB/HPC0BlgSX7JC6ukGjjLeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOM2K2I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10909C4AF0F;
	Mon, 12 Aug 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723463299;
	bh=Napc90aktE/QuypSDHJKVOFzOHDipFwPsvcMXXd1YqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rOM2K2I790JrIr456SMxJrgfz2kZ3cEv1I8W0gQtlroZsL5sc3YHtKBHJOdzJRPN8
	 E1ToZdHSs2UreW0v0wkyHxahjIkTVl/UAN4IUw8B87cuWTTSdr9o2YILGrauhn6kVV
	 PD+GQbo4YahogMAS8UlhKaOtRHKWsCeQhLeApJh1dYxa5IB5GvAnvIjueD3rVchUSr
	 DgHnyrRPVl7EyP+iX9xRZeifnLLmfWX5CMhHKVCGKJzJjaY4XcXxj7T4ie5lhrE0pz
	 cKdOEyV80lD1vUO4FjwHZUOu2kc7n/4qizeQg0pwx1IPxhwaoB3yhnHg1IRwPJbeLc
	 m9a45m0yUVgzQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093e583913so344012a34.2;
        Mon, 12 Aug 2024 04:48:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFbFaCAh038wzY6uhNzTuVoqdisiM59CFGw4i5G082oNEuozhn
	hdC2eBnsJSGh6pZx/4dBP4VPi/MUkzXFx4wDPA+KURxVBU46uN5oklmueZkOSe6NfEzZA/IZ+r3
	ECpt7kTspqmEYuZ4L1vEDHZzNSPI=
X-Google-Smtp-Source: AGHT+IFIXZr7aG3vnivowVZqpiVqQtOBNWoxXpSdf0tK7uzKA0D60HpySoFGHhj/rE3BYE4vLv95VaxZxlXcT4+WKnE=
X-Received: by 2002:a4a:e9aa:0:b0:5cd:8f2:5c8d with SMTP id
 006d021491bc7-5da6897d40fmr60373eaf.2.1723463298367; Mon, 12 Aug 2024
 04:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1960840.taCxCBeP46@rjwysocki.net>
In-Reply-To: <1960840.taCxCBeP46@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Aug 2024 13:48:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h8t1wAYenPPE2vZAerTJSrHnOuY=jqaLAQ+wNooJEduw@mail.gmail.com>
Message-ID: <CAJZ5v0h8t1wAYenPPE2vZAerTJSrHnOuY=jqaLAQ+wNooJEduw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: sysfs: Get to trip attributes via the
 attribute argument of show/store
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

On Mon, Jul 29, 2024 at 6:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This series reworks the trip point sysfs interface to get to trips via th=
e
> attribute argument of show/store instead of using the attribute name to g=
et
> a trip ID and look up a trip using it.
>
> It also adds a small cleanup (the last patch) for a good measure.

This material should not be controversial (which I also gather from
the lack of responses) and it is a clear improvement IMV in terms of
code flow simplifications and the reduction of its size, so I'm going
to move it to my linux-next branch as 6.12-candidate.

Thanks!

