Return-Path: <linux-pm+bounces-8936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D0903957
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44F22891A2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF5178CE8;
	Tue, 11 Jun 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOAygGw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404016F8F4;
	Tue, 11 Jun 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103279; cv=none; b=J1YxqRWaHdjn6YDZOjxLflHHZ1rbzPDaeWZh1W8gyVRqTJ1jvj9Rmu4FoJlCV1iny4KeHEvoNoJH5pLXlgntCYK1W+tu0CfjPEHuDeReILZff0O/EMefEkmj3LuyuwNXFagU3oRIw3iTvyvroc5/rfpfImLUPGdt8y5TRxUUoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103279; c=relaxed/simple;
	bh=PAYGrjPv9JUHWmXhYOj5cK6zsnCJK22hJuq/sV/ZXRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAFxfVME1kbqpkOxHrbqWlwumWB4RrcivMafW+Igjrqfit/Ny3G4QkkYAHLhgqYui8E2OrqUwgzqHvXLI4RFilpdbFDmjH7M7qWG9zLcQ6oNZReryCv7w40U/K0tuIFpIxsbTL6hrh9G7edZdrZcWVFQOy9m00/bP2EWELLvzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOAygGw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD436C4AF49;
	Tue, 11 Jun 2024 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718103278;
	bh=PAYGrjPv9JUHWmXhYOj5cK6zsnCJK22hJuq/sV/ZXRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eOAygGw0J6QuNRcyS5QRfDqWfmYUZ0/QnPp70fjpIrxk+HLMbdYB3mkNgUEExz9nr
	 ltERDyMLfJlr9CRKiYVXoKalf/BVvlHBYZc4qkaoJmaNGXCaqg2s8XYjScoCp4ttJH
	 1ZuDocBL2aK1Xio7X7sCTVn59XWc7z4TY4R461rTa3O7WWJQ1MHUY+FkdVROJ0PASi
	 ZNx48iSVL0n4raFGOpTJyHDzfTsGNtT3wBy5pw2TQUfx/k2rRietUkuucRPrfd5Ltm
	 z8C5qKubc6CcY1e1u02QCMtNAGGVKNv6tebVLpzQ5M5fCV89ziBoax0SeDNqBGTH9B
	 P97CDfMHAdkKQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b3364995b4so944725eaf.0;
        Tue, 11 Jun 2024 03:54:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3h2YNyFBljuyPzZkvQsJrD7yUVNlR5M/P+QY5lddxf4guqMmUIO4snDHFNLIIILIlFR75BQJ6ev7Im9NLoj/UY8NxUery/BcsHcL26iUumaTqHnfnSvWvUvvHO8hHGJeRzVEFzcA=
X-Gm-Message-State: AOJu0YzC9IX2hPdzRuSsNKE531GrTOKoOLMNqgMg2xo/t2qZG9nr07zk
	UeN7JD9KG/Y1e03keOT2Y4RRjJXAQjWh7A9/UgcyZXjIBxsUFjg1zVhw8xJpnBXOKrAkTjQA1GS
	acWRciBf62CbEVcK+NBgdXNvtWlI=
X-Google-Smtp-Source: AGHT+IEvLU9vFM/yZqdIexWRcV9B6Dlv5GthnVTgnzxcy/oRi4DXidDCDamIF23U0+rv4RC56WRKknyLhYhbv12T8x0=
X-Received: by 2002:a4a:a283:0:b0:5ba:c4ed:ee98 with SMTP id
 006d021491bc7-5bac4edef89mr10794590eaf.0.1718103277894; Tue, 11 Jun 2024
 03:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com> <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Jun 2024 12:54:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
Message-ID: <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
Subject: Re: cpufreq/thermal regression in 6.10
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000091410b061a9b1798"

--00000000000091410b061a9b1798
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi,
>
> Thanks for the report.
>
> On Sun, Jun 9, 2024 at 9:53=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
> >
> > Hi,
> >
> > Steev reported to me off-list that the CPU frequency of the big cores o=
n
> > the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
> > frequency with 6.10-rc2.
> >
> > I just confirmed that once the cores are fully throttled (using the
> > stepwise thermal governor) due to the skin temperature reaching the
> > first trip point, scaling_max_freq gets stuck at the next OPP:
> >
> >         cpu4/cpufreq/scaling_max_freq:940800
> >         cpu5/cpufreq/scaling_max_freq:940800
> >         cpu6/cpufreq/scaling_max_freq:940800
> >         cpu7/cpufreq/scaling_max_freq:940800
> >
> > when the temperature drops again.
>
> So apparently something fails to update its frequency QoS request.
>
> Would it be possible to provoke this with thermal debug enabled
> (CONFIG_THERMAL_DEBUGFS set) and see what's there in
> /sys/kernel/debug/thermal/?
>
> > This obviously leads to a massive performance drop and could possibly
> > also be related to reports like this one:
> >
> >         https://lore.kernel.org/all/CAHk-=3DwjwFGQZcDinK=3DBkEaA8FSyVg5=
NaUe0BobxowxeZ5PvetA@mail.gmail.com/
> >
> > I assume the regression may have been introduced by all the thermal wor=
k
> > that went into 6.10-rc1, but I don't have time to try to track this dow=
n
> > myself right now (and will be away from keyboard most of next week).
> >
> > I've confirmed that 6.9 works as expected.
>
> Well, I'd need to ask someone else affected by this, then.

If this is the step-wise governor, the problem might have been
introduced by commit

042a3d80f118 thermal: core: Move passive polling management to the core

which removed passive polling count updates from that governor, so if
the thermal zone in question has passive polling only and no regular
polling, temperature updates may stop coming before the governor drops
the cooling device states to the "no target" level.

So please test the attached partial revert of the above commit when you can=
.

--00000000000091410b061a9b1798
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="thermal-gov_step_wise--revert-passive.patch"
Content-Disposition: attachment; 
	filename="thermal-gov_step_wise--revert-passive.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxaa98980>
X-Attachment-Id: f_lxaa98980

LS0tCiBkcml2ZXJzL3RoZXJtYWwvZ292X3N0ZXBfd2lzZS5jIHwgICAxMCArKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMv
dGhlcm1hbC9nb3Zfc3RlcF93aXNlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2
ZXJzL3RoZXJtYWwvZ292X3N0ZXBfd2lzZS5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwv
Z292X3N0ZXBfd2lzZS5jCkBAIC05Myw2ICs5MywxNiBAQCBzdGF0aWMgdm9pZCB0aGVybWFsX3pv
bmVfdHJpcF91cGRhdGUoc3RyCiAJCWlmIChpbnN0YW5jZS0+aW5pdGlhbGl6ZWQgJiYgb2xkX3Rh
cmdldCA9PSBpbnN0YW5jZS0+dGFyZ2V0KQogCQkJY29udGludWU7CiAKKwkJaWYgKHRyaXAtPnR5
cGUgPT0gVEhFUk1BTF9UUklQX1BBU1NJVkUpIHsKKwkJCS8qIElmIG5lZWRlZCwgdXBkYXRlIHRo
ZSBzdGF0dXMgb2YgcGFzc2l2ZSBwb2xsaW5nLiAqLworCQkJaWYgKG9sZF90YXJnZXQgPT0gVEhF
Uk1BTF9OT19UQVJHRVQgJiYKKwkJCSAgICBpbnN0YW5jZS0+dGFyZ2V0ICE9IFRIRVJNQUxfTk9f
VEFSR0VUKQorCQkJCXR6LT5wYXNzaXZlKys7CisJCQllbHNlIGlmIChvbGRfdGFyZ2V0ICE9IFRI
RVJNQUxfTk9fVEFSR0VUICYmCisJCQkJIGluc3RhbmNlLT50YXJnZXQgPT0gVEhFUk1BTF9OT19U
QVJHRVQpCisJCQkJdHotPnBhc3NpdmUtLTsKKwkJfQorCiAJCWluc3RhbmNlLT5pbml0aWFsaXpl
ZCA9IHRydWU7CiAKIAkJbXV0ZXhfbG9jaygmaW5zdGFuY2UtPmNkZXYtPmxvY2spOwo=
--00000000000091410b061a9b1798--

