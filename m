Return-Path: <linux-pm+bounces-41985-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMshObEmgmnPPgMAu9opvQ
	(envelope-from <linux-pm+bounces-41985-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:47:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABFDC381
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA8F630AA9CB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A73D331D;
	Tue,  3 Feb 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGrg7t3I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97B3D1CD7
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137151; cv=none; b=EeNQPUayuajkIDTT8xtdxNV+SzLP4YGwibkr3z/3jFJC0NQ73JnypQxc1YQeBYr2KFTQSU9lIq8uJ1xNBxyM3yzFMAe8wGyh5mHMl84BQMisbSi16DZkOOI3qaBGvaXioEB5qMG/G+Np7a18FINLetouT+RGms5fUosGbQ3uVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137151; c=relaxed/simple;
	bh=2IX2Jb8lpm29me5/jiISeudswVSt0f7Ria8TXxFoeRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0yPff3385C2f51lTNbFhcbv22Avjgvy1L59yOfb4Zv2NXhLD7MWw+NYjzj9uFrKQqkGnfFVf5hslr7vIqKdo9LBcUQi6krljGtDF8CL5QsT/KVSRGl1x4TMaMiPJAf/9ji+0D4hC0eWgvfSlIMhLM+Dzi4/QOYP7lwJlWQ4UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGrg7t3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B134C16AAE
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137151;
	bh=2IX2Jb8lpm29me5/jiISeudswVSt0f7Ria8TXxFoeRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kGrg7t3IWmjdERwFOnkzMrnUbb6MWFzrSh4KCwA32aU+pCCQ0i000gHl+iGOfrVtv
	 zN5eBHBgQZiTOWxn35PPieRlNlA9lysH7hCuEtG7oC+CZ9P2vG/DOsJH45cc5tdGGo
	 reMevxpRE7GIU5ln/w1bjMIT7ZQtgyQMVDnTftEw4oHqVDkhOI9hQq/Uqm7Blv1Zqj
	 uRY7zVbZH4hN1SwLon7WxhTarICx15PElV4CM6GcMeNLCojIzA6B8bCSl3ARx32OrH
	 sIQXSNKj9m4cXih8zUkmpi+OF1WrpLqgdVJliQzyY00znwt6zAZAjpu9MglEzyYCSS
	 lP+R4DYb+d/Qw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-668fdb244c4so357643eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 08:45:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXadwY03I8P/uG8+mt4mwp/cd4KLBFUGkMlhoiAWu2Ou5szYdnf0hCMm07RbRnprRgxIGAySeN/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyndEzzzBIolqf+ZuhyKN0qNBKYqbdYfT+8abv9QQ4kLQDq5Xx1
	460XvFvpcISN9yKuhBJU1eX9Ph9c3YCgA53vkbU8fW+cfA9PmSd0Q1Zc/v1Q7Np8JFMumqTkSDT
	4uRMpbP2EUvlIJ6hEau09U85UHHZE5j0=
X-Received: by 2002:a05:6820:f006:b0:662:ffc4:8349 with SMTP id
 006d021491bc7-66a23df0466mr89575eaf.81.1770137150149; Tue, 03 Feb 2026
 08:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com> <003e01dc9013$e3bc5060$ab34f120$@telus.net>
 <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net> <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
In-Reply-To: <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 17:45:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
X-Gm-Features: AZwV_QhB2zexcuvHiHohqEhk5MUVIDPfQO25Kl692r5gItoGoTXA2N-3_AmANog
Message-ID: <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Christian Loehle <christian.loehle@arm.com>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41985-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FABFDC381
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:31=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/3/26 09:16, Harshvardhan Jha wrote:
> >
> > On 03/02/26 2:37 PM, Christian Loehle wrote:
> >> On 2/2/26 17:31, Harshvardhan Jha wrote:

[cut]

> >> FWIW Jasper Lake seems to be supported from 5.6 on, see
> >> b2d32af0bff4 ("x86/cpu: Add Jasper Lake to Intel family")
> >
> > Oh I see, but shouldn't avoiding regressions on established platforms b=
e
> > a priority over further optimizing for specific newer platforms like
> > Jasper Lake?
> >
>
> Well avoiding regressions on established platforms is what lead to
> 10fad4012234 Revert "cpuidle: menu: Avoid discarding useful information"
> being applied and backported.
> The expectation for stable is that we avoid regressions and potentially
> miss out on improvements. If you want the latest greatest performance you
> should probably run a latest greatest kernel.
> The original
> 85975daeaa4d cpuidle: menu: Avoid discarding useful information
> was seen as a fix and overall improvement,

Note, however, that commit 85975daeaa4d carries no Fixes: tag and no
Cc: stable.  It was picked up into stable kernels for another reason.

> that's why it was backported, but Sergey's regression report contradicted=
 that.

Exactly.

> What is "established" and "newer" for a stable kernel is quite handwavy
> IMO but even here Sergey's regression report is a clear data point...

Which wasn't known at the time commit 85975daeaa4d went in.

> Your report is only restoring 5.15 (and others) performance to 5.15
> upstream-ish levels which is within the expectations of running a stable
> kernel. No doubt it's frustrating either way!

That is a consequence of the time it takes for mainline changes to
propagate to distributions (Chrome OS in this particular case) at
which point they get tested on a wider range of systems.  Until that
happens, it is not really guaranteed that the given change will stay
in.

In this particular case, restoring commit 85975daeaa4d would cause the
same problems on the systems adversely affected by it to become
visible again and I don't think it would be fair to say "Too bad" to
the users of those systems.  IMV, it cannot be restored without a way
to at least limit the adverse effect on performance.

I have an idea to test, but getting something workable out of it may
be a challenge, even if it turns out to be a good one.

