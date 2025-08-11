Return-Path: <linux-pm+bounces-32186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B413DB21538
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2973116DACE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0F2877F1;
	Mon, 11 Aug 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI7YMUgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40F20468D;
	Mon, 11 Aug 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939807; cv=none; b=diP8HJn8b7oM4+lgfHK6zIHgOrW7z9A78iXWE5SgyEI8fvbtlir1LXyG1Od/eWy8iij3zxxs45xvW1+gl1yk1KVOktp3Szx+dRC3PXkjLsCOmCs8qaKEQ2URsXWvo2QLnXWpMuQ+r10Ae6BbCJRs/S9o8AMay9f1LHLov7a3B6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939807; c=relaxed/simple;
	bh=EQv5zkwD85rfHIT2oTVnhR5G8BtpZ13906SjohWcIQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVtpSi2hQhdAQ9KC8K9iPWNI1miiF5QXH7HXIEXych7Avg+mvd0qN430DqssBj1E48iC2GjwrMMuWwJXGeq/Sabxbx3Xl9v5VuQoI9RfOpCGFcug/BaC65piAmB96mwOpZD7AX8/8xP9PH+nN0bx4rgCCVvSrotLNJyeRNZYbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI7YMUgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8467C4AF09;
	Mon, 11 Aug 2025 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754939806;
	bh=EQv5zkwD85rfHIT2oTVnhR5G8BtpZ13906SjohWcIQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bI7YMUgZqR61/W5PBWBmQ52CgfEdQSHN4CkOhSDaEhg41bDLkM8YtJ+pDx+SsUZuB
	 15JeL7ncHaF7tLAhE47WytR3fjOOLcXLlrsDk0tsXOkNeJUl4eDeEw+QZwwT64xE2H
	 S6WnNCxuAapw40JqwsqdL0ERilWO+boYKumB5vdwHaBBbqo46NBB1ZaWcsstY9QI13
	 ZYFSruQueIXMnrYZyxnm8MaMdvUEk/ty8MIRPmlgCrNY4vX3KberjGnP2etvWxR9Tv
	 1sLSHHQruymaohjpOc533Y/mLS0qXQ7/0Oz7JATTyTrO4m8FWE7fVtiKBGwx9UDWWU
	 we/pnq3Lacahg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61998205433so1910729eaf.1;
        Mon, 11 Aug 2025 12:16:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa6BS1zn7ymN27/6CNOx1cOPR9Ev70ehu/Ia01+f0vozCGCBgsrs6MMiLNCTsaAjKqRKQ8pC5zPbw=@vger.kernel.org, AJvYcCXrafIDCw9Um/rZULb1lmlL4+ZPqUPiHSsy1AV00JCoZczE/u+pSZOfYaKGW7EnBPzo7tu8P1mlsNn7lbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREAtEBy/YwZ/Eypm1kKCLPIjcfDaGwZW+WTnT/G3A5BQc0Uil
	w9nBUVtTy/fBViujpo7+2PgZy1sOCiDnoPkybGTn6NuSs2Cu/3rNy2KB8ET1iq2XCHKE5PKkYKp
	2JP6FXP0iQR3K9mtL//AAX98mTO9KbY0=
X-Google-Smtp-Source: AGHT+IF2zSZZIosAYExOasl238GMcLY2lYeeBQb+Te5qzYEj3bLhdX5gjZegK0iicd2XMJrZ9K12DE+GNq/+9/5ashU=
X-Received: by 2002:a05:6820:1607:b0:61b:931a:a9a0 with SMTP id
 006d021491bc7-61bb5a9f480mr646692eaf.3.1754939806100; Mon, 11 Aug 2025
 12:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com>
In-Reply-To: <7hldnp6apf.fsf@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Aug 2025 21:16:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
X-Gm-Features: Ac12FXz1mGha12K-Zqq9KAKtqqa9MGzcJH5sFZI3F3YpZw-3ERkcio0DeD1jVK8
Message-ID: <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@baylibre.com>=
 wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> >>
> >> Some platforms and devices supports multiple low-power-states than can=
 be
> >> used for system-wide suspend. Today these states are selected on per
> >> subsystem basis and in most cases it's the deepest possible state that
> >> becomes selected.
> >>
> >> For some use-cases this is a problem as it isn't suitable or even brea=
ks
> >> the system-wakeup latency constraint, when we decide to enter these de=
eper
> >> states during system-wide suspend.
> >>
> >> Therefore, let's introduce an interface for user-space, allowing us to
> >> specify the system-wakeup QoS limit. Subsequent changes will start tak=
ing
> >> into account the QoS limit.
> >
> > Well, this is not really a system-wakeup limit, but a CPU idle state
> > latency limit for states entered in the last step of suspend-to-idle.
> >
> > It looks like the problem is that the existing CPU latency QoS is not
> > taken into account by suspend-to-idle, so instead of adding an
> > entirely new interface to overcome this, would it make sense to add an
> > ioctl() to the existing one that would allow the user of it to
> > indicate that the given request should also be respected by
> > suspend-to-idle?
> >
> > There are two basic reasons why I think so:
> > (1) The requests that you want to be respected by suspend-to-idle
> > should also be respected by the regular "runtime" idle, or at least I
> > don't see a reason why it wouldn't be the case.
> > (2) The new interface introduced by this patch basically duplicates
> > the existing one.
>
> I also think that just using the existing /dev/cpu_dma_latency is the
> right approach here, and simply teaching s2idle to respect this value.
>
> I'm curious about the need for a new ioctl() though.  Under what
> conditions do you want normal/runtime CPUidle to respect this value and
> s2idle to not respect this value?

In a typical PC environment s2idle is a replacement for ACPI S3 which
does not take any QoS constraints into account, so users may want to
set QoS limits for run-time and then suspend with the expectation that
QoS will not affect it.

