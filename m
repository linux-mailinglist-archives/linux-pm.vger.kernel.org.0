Return-Path: <linux-pm+bounces-29854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E1AEE6FE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0330018871F1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77128E5F3;
	Mon, 30 Jun 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQl7M/F4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322579D2;
	Mon, 30 Jun 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309503; cv=none; b=vBmkirJoZPA42DOsxZdYmqVnPxWQHxkFWI3qbIqYCibIvXVn4PowVYrLHpJ0sQv4WPr9+nKifAw0U4fRoQ0PF4f8NpoqydldmNq62MMqhHw/O6Hu2qfNN0WatTBPgOwFovNh6MKdFvb08mUupZHT+FnsKJ54Awoff+FonHgsgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309503; c=relaxed/simple;
	bh=BB1hru3f2vFyFMuhG/mIR1DVvdU+UPOTAF42hcJno70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYFAMrbFk9mC7FY/7PksE+au+xuc20iVda0Nawyp+C2k3eRpJW32NxJV2esQcfU0tR2MuotALWZMwxwl8xZPFPC6r+6UwY9VGaX1TbYqj1Vw39uHJf/vLlVnaG6FjrHcSw1h8uMyt5yWMiKePtU0YBImH5v4Sh9D0qK8u2MaHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQl7M/F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCD6C4CEE3;
	Mon, 30 Jun 2025 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751309501;
	bh=BB1hru3f2vFyFMuhG/mIR1DVvdU+UPOTAF42hcJno70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mQl7M/F4PHfXi0a8XxDQWi25BMicMMgPbKFva1Ugd3PIf0GVP8104FAnrtIRtOTpJ
	 BropP7Sd6+CnH2Xg9hOBt+C9xBeGz0weLPsu4quG1F8y/fN5gCFhbExs/NDYt/3mKi
	 O3L3r4hfpwsym5mOquO0VsrbmZZr1BKXbVEQm/zSBmK65f2jtMbGELqDswUA2oryJj
	 36/0EaFJ2pFJPyZppYVkES4adT/0HDzNWGOOZqf9JXybovs34muqylbZMZrIvF2har
	 HHwEbja34KOBwf69xyzp0xLWY0qu/I+bmABSooViJIpzJnCk4zClFkSEa6DkG67Q/q
	 PjVlqXIcjvKIg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60d5c665fceso1168367eaf.1;
        Mon, 30 Jun 2025 11:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGRDolWmZYqCb2ugROxKcjZ0A8UpJld9GhazGBbdVS/f8aY4lF2yqaK4ttkngN66/ILOmvatapr+cjFBc=@vger.kernel.org, AJvYcCUlaMPBb5AEGsa712ZJC5WItAiSxpsOpnWB2smBpAxSO7liQgb1Q6jZXhy7vojJ4IAe77teRo85oOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIB0j4/ZWQ6QbTCXEp1af2t/7WVP8utBuyOhXh3MF3sEJy6FGr
	939ld/kcgu/zqToott+fzxO+/vcryP6hMLmynPNE0AfOGU/+OrqYh7LQkV7Qg1K/AaIEZcp9Orp
	fyB/99K4072oeUyDAoTKg5x82VyWvMRo=
X-Google-Smtp-Source: AGHT+IEC/8k5KDPL73q97a5GP1aRN7ZwzGI2n4+tqf7+RFYGgWRvEcbGSeu2b1wHjkMKdVaMUxitXhTAyEI4AnIX+Fg=
X-Received: by 2002:a05:6820:c83:b0:611:f29c:a1b5 with SMTP id
 006d021491bc7-611f29ca486mr934324eaf.1.1751309500969; Mon, 30 Jun 2025
 11:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net> <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
 <CAJZ5v0gcgMJ-qihgc3_OF4djxAy8K0i-cmnjRe4AQrc_YEu4DQ@mail.gmail.com> <a27c8ef8-9b80-4749-a64a-0389c266fd0e@gmail.com>
In-Reply-To: <a27c8ef8-9b80-4749-a64a-0389c266fd0e@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 20:51:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hx+Ra0V7PBNZRKJ1wV-9J-FV5MFhVAsqUzpvHkfdN76Q@mail.gmail.com>
X-Gm-Features: Ac12FXwKs6wW7yWxeQRejTFKwNbV3hb-HrFkzl3ufDUAVNZQxWd_076CipKQO4g
Message-ID: <CAJZ5v0hx+Ra0V7PBNZRKJ1wV-9J-FV5MFhVAsqUzpvHkfdN76Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: Ibrahim Ansari <ansari.ibrahim1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 29, 2025 at 2:28=E2=80=AFPM Ibrahim Ansari
<ansari.ibrahim1@gmail.com> wrote:
>
> Hi,
>
> On 5/13/25 19:31, Rafael J. Wysocki wrote:
>
> > Finally, schedutil needs to be the cpufreq governor which requires
> > intel_pstate to operate in the passive mode (schedutil is the default
> > governor in that case).  The most straightforward way to switch it
> > into the passive mode is to write "passive" to
> > /sys/devices/system/cpu/intel_pstate/status (it may also be started in
> > the passive mode as described in
> > https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html=
).
>
> I'm curious if you intend to bring back support for EAS with
> intel_pstate in active mode down the line?

No plans as of today and this is somewhat technically questionable
because EAS requires the schedutil governor for cpufreq which is only
available in the passive mode.

It may be revisited in the future, though, if there's sufficient demand.

> That would get this working out of the box across distros, since
> `intel_pstate=3Dactive` is the default setup everywhere (and typically
> what users should prefer? as I understand from the documentation.)

It's generally hard to say what users should prefer because it depends
on what they need.

The active mode involves less complexity in the kernel code and so it
is the default.  It is also somewhat performance-oriented relative to
EAS.

Users who prefer EAS can append intel_pstate=3Dpassive to the default
kernel command line.

> Thanks for your work!

Anytime!

