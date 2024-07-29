Return-Path: <linux-pm+bounces-11587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0F93FE69
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A246E1C22A55
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5A188CC6;
	Mon, 29 Jul 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwtGSoif"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A4187875
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281920; cv=none; b=YHTnPp/iKL2FMv1RCctdyo/W6PAU4c/aRGGE0YWX7C1A4WHuyDqgOpUavbF/ZR7htqcjkG21Y+eVunuxoLNwfkt+o40daNI+6GK+cDKz7jhK5FWA19Ro08RK4mkWe7QnAxOfsS8Msido424ka+rfUD/nKvDzE2H2U9dxkpIjWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281920; c=relaxed/simple;
	bh=ZML8mLFuS8VLP/FG5rg8wzzubBlaOqUijIW6Mopnh+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJMF3799xtyxQxsY2IllN/XButX61YkISzPgIhAjvx4vncZBgLpHA5rdcZKSJnOeUuLHxRvRWuibXsl7NlXom60fuulaERND6KLCOlWorRguO3l18VbZXi4XRM+u8I/E98fg4irPWhFcIw7PhtOv5czgMWEe2mPCnEzrsxWn1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwtGSoif; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso2153001a91.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722281918; x=1722886718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZML8mLFuS8VLP/FG5rg8wzzubBlaOqUijIW6Mopnh+E=;
        b=NwtGSoif/VWvFAS5lg5xwMQ5CXjWalIIy/PTOtcDRfYdxQqQxU+l+yLr/s/qLg57wo
         yKecWJ7V4VUGeRe/63139B9C6Uz4wrHCSo7JRCmYfScgTL3d9dEEKhsv5nqDGqGgry4d
         eiH/mpU1/WsKUbBcu88OD+TnwE7l+zfHjCh3kqKLtsaN3iVM4cDuu9QCJStNJrHsoHGg
         xy3GFyEHuJEndR7qsqHsQYwDODziwHVRHyqCz/wkobgI9IqjqDuRj/N6oNnxOivhsxpV
         C10enowS+1bExJdsiMrK5+IF9ia3fUP94LOp428UxNcU+ZZj1VjdSRWi+7xxQxBwO3pm
         gI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281918; x=1722886718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZML8mLFuS8VLP/FG5rg8wzzubBlaOqUijIW6Mopnh+E=;
        b=bHuZY1IvtY0QKzQh9ezktOjNbhWB4mg9fChST+ZIlY+6p12lac3pHRNcAPS7i4CayW
         5qNgIqZ7yHNirv0jRFjk18q/CuAeU9nZJHyPJwePMAOjeRCe+gFWUmcNq/Tsu5xYKqhi
         0vP9Gq/MLBHu/N7/HJLp1mqPwG5hymp6Y6E1qyRqsvj/0N63hQnkSThAhRGy7nif26Hx
         4FTJgu2bYwJpECzvqDptxQeLW3wxz//rK1+BH5zIqpq3wdAv6iOekto1lUMop2B8iJmb
         seVeDbChBvWVxOJR5FJ5KeSzTmrL2r3U+t7O7hMj3Lf3QqsAVjtNZd4CQGxyGjkkrsD2
         SJ5w==
X-Gm-Message-State: AOJu0YzX1PRLYtSuFpTrsmXVS1C6zm2OAlkMJBhb539HTJE31fUY97iH
	z5xkqH/1KnAHry8shZz8VePNGJW0yX4Jrl5UF0a/382vlkhr+/H3bDZjdkbucHZrf7jz6IRsEQf
	u9w6O4ezAluUQINXeaoHLxnuV+BoQRHy76RM=
X-Google-Smtp-Source: AGHT+IFGwERtnLOWYQJevblcn4xqy27kqWiDm6AFtglnCHVgBvwRucqf6UjmCUErq2/GCcFkCHc3UrzxQBxmQFpXkaE=
X-Received: by 2002:a17:90b:1282:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2cf7e5f50f8mr6353270a91.30.1722281918394; Mon, 29 Jul 2024
 12:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <872ea739-632a-4344-9e3d-49f8fb846f8a@gmail.com> <CAJZ5v0hD+6YR9HvtrSu_bDGZKMr2D2c1FKmDiDPwqDWV7wc_WA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hD+6YR9HvtrSu_bDGZKMr2D2c1FKmDiDPwqDWV7wc_WA@mail.gmail.com>
From: Anish Rashinkar <rashinkar.anish@gmail.com>
Date: Tue, 30 Jul 2024 01:08:26 +0530
Message-ID: <CAOESE2QC2mUEQGZjsQq4Fe=AmUxTKG6=aqS==ykbowqTCGOyaQ@mail.gmail.com>
Subject: Re: Need help setting asynchronous CPU frequencies.
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the reply.

Yes, I already do keep CPUs 2 and 6 offline, but I would really like
the performance of a whole additional core as well.

I am working on a script which will help me automatically switch
between 3 cores max frequency, and 4 cores at lower frequency when
needed for example when I need the multithreaded performance or if my
laptop is thermal throttling. But I would still really like to get
that core running.

You didn't specifically try to mention the solution of my problem,
which would be being able to set different clock speeds on different
cores. With whatever knowledge I have, I don't think that it is
impossible to achieve this. If I am monitoring correctly, then
different clock speeds are being set on different cores all the time
based on the current power profile. So based on this, is there really
no way to limit the maximum frequency allowed for a certain core/CPUs?

If the hardware way is not possible, what about just pure software
simulation? Like the kernel, manually injecting a few hundred million
NOP instructions every second on a CPU? I don't think this will work
as I have also tried isolating CPUs 2 and 6 using isolcpus parameter,
and so running them at 100% halt, but that still causes the crash.

 And I have also heard that the kernel also takes care of the voltage
scaling? Is it really possible to tweak the voltages of the CPU
through only software methods (access to FIVR is locked by the
firmware)?

Thank you for your time.


On Mon, Jul 29, 2024 at 11:55=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Mon, Jul 29, 2024 at 6:35=E2=80=AFPM Anish Rashinkar
> <rashinkar.anish@gmail.com> wrote:
> >
> > Sorry, I am really not sure if this is the correct place to ask this,
> > but I have tried almost everywhere but to no success.
>
> No worries.
>
> > In short, one of my cores in my processor is defective/degraded. It
> > can't run at max frequency or else it will crash. Either I have to lock
> > down the frequency of all the cores to a lower value, or set that core
> > offline.
> >
> > Access to turbo ratio limits is restricted by the firmware, or otherwis=
e
> > it would have been easy to set the working cores to max frequency while
> > keeping the defective core to a lower speed. Voltage controls are also
> > locked, which could have fixed the problem, and I have already put a lo=
t
> > of time trying to gain the access, but it's too risky (firmware modding=
).
> >
> > It's an HP Elitebook 840 G5 laptop, with an Intel Core i5 8350U. 4 core=
s
> > with 8 logical threads, It boosts up to 3600 MHz. I have to lock the
> > whole processor frequency to around 3 - 3.1 GHz, but it is getting wors=
e
> > and might crash on that as well. Or if I choose to disable the core, I
> > have to disable CPUs 2 and 6, which is the third core. I have noticed
> > that disabling idle states (C states) gives me a bit more stability so =
I
> > can probably raise the frequency a bit more.
> >
> > All I want to know is if there is a way to run the 3 cores at max
> > frequency, while running that one core at a lower 3 GHz frequency?
>
> If the processor is not capable of controlling frequency per-core,
> which is very unlikely for a laptop one, then no.
>
> The problem is that all cores share one voltage regulator that is
> necessary to raise the voltage in accordance with the frequency you
> want to run at.
>
> In that case, the best you can do is to either take the defective core
> offline (which requires taking CPUs 2 and 6 offline if I understand
> the above correctly) and run the other cores at higher frequencies (if
> you care about single-thread performance more than about the ability
> to run 8 threads in parallel), or run all cores at lower frequencies
> (if running more threads in parallel us more desirable).
>
> > All my attempts included trying to get the userspace governor working,
> > but it is a big mess. Using tools like cpupower or cpufreq
> > (cpufrequtils), I can't load the userspace governor directly. The
> > userspace governor loads if I disable intel_pstate or put it to passive
> > mode, but it doesn't seem to have any effect. After loading it, any
> > frequency I set using cpupower/cpufreq doesn't apply. I also tried with
> > intel_pstate hwp on/off. And I of course tried manually choosing the
> > core in cpufreq but either the changes don't apply, or it gets applied
> > to all cores. I also kind of tried manually setting the frequencies in
> > the kernel files (/sys and those), but they didn't really work. I also
> > tried "intel_pstate=3Dper_cpu_perf_limits" kernel parameter, but that
> > didn't really help (I couldn't get the intel_pstate folder under all
> > CPUs, and instead I still got it under .../cpu/ like always).
> >
> > I am currently running Ubuntu 24.04 LTS.
>
> The distribution and kernel version do not matter here.
>
> Thanks!

