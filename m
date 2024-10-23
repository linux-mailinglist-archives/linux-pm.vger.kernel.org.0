Return-Path: <linux-pm+bounces-16283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F59AC24E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258221C23A7B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE916130B;
	Wed, 23 Oct 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqP+fa3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4A15E5C2;
	Wed, 23 Oct 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673643; cv=none; b=Sf5sPSIEiF28juCoX9xZhkAjlKO+mz1+2/Tb9ZuyNq7I/9mUOU+YDGf+G7zaAOY8XXlwQ9I1qzrbkC/TwrQgBW5IuGSJpqPM8uQZkwKNdbUoD8KGn5qG3fPzRdenFFVjOYm7haZVy/uwT2+D7BdO21oPmyYmsZhlF+uXsfJV+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673643; c=relaxed/simple;
	bh=ApNScjusw9COW7dg4eABDkYvK2VGujpMdndrtlBkTP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qjh8RqQcL0kqnwOoP4xgu0UZjgnGHE18c3c97jjMuN9d9nc9KVGr5BIjUjYF0lqQikYYxN++V4hXOtcVS9J96VFkB5fH7xXPmiIDhb/WoRT0cutROknaa88uK4F222ItkP+ZJwWdIRhb5lQOSI0JkIxeHiSoD9huCQlAeMokRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqP+fa3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EACC4CECD;
	Wed, 23 Oct 2024 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673642;
	bh=ApNScjusw9COW7dg4eABDkYvK2VGujpMdndrtlBkTP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NqP+fa3vzwlgtzw8OpNSS5jMGlMjYwI2zYcLPOyppiPGEdy3Z2RZyvEn+eOuSzEmY
	 s/N2Q9xvtQ6zwUrmyQJmxqIqdaM896V1AM1cEKJJaMaD8WOB37qT9C3Lj8NXITtP0X
	 NlD9RMtEqKmziGfeTwbZA08qryPZVcfAXeEr72ipW/3VbPnGyyax/jFqYanXytAdJH
	 Yr0ZOTOaWP+Z/4QMKhdpmBsehuakoSSIQKQQ3tNwA51N4+sfB5gjNjZW7uIRQBB4W7
	 BF5wqXJe2Md2AOAsC4iCuOwzgfhaynq/AsCZIljYWSRBT4QzunNXM9SbX2Wh45FQhW
	 WLLLVttZR04GQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181eb9ad46so2776542a34.1;
        Wed, 23 Oct 2024 01:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrDxtoPE4veFP2GOZsi/li0ReJ/GWv3pTrr7ItIoPVKhJqYcYFYxqMIunPd+pYQwvYsjYgii0XVW0=@vger.kernel.org, AJvYcCXhgbiMQCWrUm68CzTlbzXfUgPDY6f4v2+BCNhjLpHC3sToze8YtM5K1tGzy1qVeP5XYeH8JkRi6BSAuE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOy5BKyizQYx/oGuNPQFFAAFFL1K76Wvu6uFhVVZqBm/Zmq/Rv
	9eQ+PgrN2/QyuvKH9GSY0rQD2dwGpA9DRyyrM2LdkTe1SN8MC6uQ5q56kR2CUiYdLyJf5qZ27Ic
	YQOgGOkCgL/940m+/60v/ZjrATO4=
X-Google-Smtp-Source: AGHT+IE3ntcjwsVArx+GzJHQ3+lVvqmedueqG2j1Du85tZk68RR/9806Xd5Z6vE9VFIrKjpNlJfGfC1H+HXqKHlvjCA=
X-Received: by 2002:a05:6871:29a:b0:270:25e:b341 with SMTP id
 586e51a60fabf-28ccb5dd58cmr1688532fac.36.1729673641868; Wed, 23 Oct 2024
 01:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4958885.31r3eYUQgx@rjwysocki.net> <CAJZ5v0g_ALycyT7Y2GwebF_ON-EMP_WGoTn4+1V0ZisK1vwROg@mail.gmail.com>
 <b6b42279-bc08-49aa-ac1e-98fe816bf342@arm.com>
In-Reply-To: <b6b42279-bc08-49aa-ac1e-98fe816bf342@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 10:53:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijx0pNZ66Q+AOxJEnLoLkkvOa1k25jdBr+fV0kTZ0S=g@mail.gmail.com>
Message-ID: <CAJZ5v0ijx0pNZ66Q+AOxJEnLoLkkvOa1k25jdBr+fV0kTZ0S=g@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] thermal: core: Use lists of trips for trip
 crossing detection and handling
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Oct 23, 2024 at 12:51=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 10/21/24 12:16, Rafael J. Wysocki wrote:
> > On Wed, Oct 16, 2024 at 1:37=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> >>
> >> Hi Everyone,
> >>
> >> This is a continuation of
> >>
> >> https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/
> >>
> >> derived from patches [3-7/8] in the following patch series:
> >>
> >> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
> >>
> >> but mostly rewritten.
> >>
> >> It is based on the observation that putting trip points on sorted list=
s
> >> allows to reduce overhead related to the handling of them in some case=
s.
> >> Namely, it avoids the need to walk all trips in a thermal zone every
> >> time the zone temperature is updated (including invalid ones) and
> >> generally leads to cleaner code.
> >>
> >> Patches [01-08/10] are preliminary, patch [09/10] makes the key change=
s,
> >> and patch [10/10] is a super-cosmetic cleanup on top of the rest.
> >>
> >> Please refer to the individual patch changelogs for details.
> >
> > This material is on the thermal-core-experimental branch in
> > linux-pm.git along with
> >
> > https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> >
> > and
> >
> > https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/
> >
> > which are also present in the thermal-core-testing branch.
>
>
> If it's not too late, I can review that stuff tomorrow for you.

No, it is not too late, please review it!

And thanks a lot for all of the reviews so far!

