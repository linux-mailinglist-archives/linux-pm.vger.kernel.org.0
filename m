Return-Path: <linux-pm+bounces-2528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D0838507
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 03:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4963290300
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5137C0BC;
	Tue, 23 Jan 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jlxuETIp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE67C0B5
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975728; cv=none; b=Qyjz9k9of2U1I2rUPTVIa9ACMuGoK7Ilj6bDOK14RHrUPoqedZGpiBy0LxjmJkBA0Cr5D9jywevUWu+eYr+bcFtGvfiFPOuw9louC1r9ffaCNp0Q1YQJsEELI+DsDzPibWgmeeQSze1b5eXLgAUK6C9dJwtibipE3CEbzNcRYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975728; c=relaxed/simple;
	bh=R+kv9l/ZUzM8R/FElAZPCWzzxzFAddYDRk9QLtHUjGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcCPfnZFjym9hpy8O4YwGdfkpYw6v1HuBKFKhMNPW4DeDj01BDwp6Zdjav6DkWgwaE1/DmWHDWlR415tK/1Uhgy+N+IWB4RsK8cZ6P0x+VmoTTZpI+0VMR2063yPVHxBTJ4qLI09ZnAaPPJK97QocLLm+SLq8kL2UHuksJChEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jlxuETIp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a277339dcf4so415861366b.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705975724; x=1706580524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o6pnpX/gRRzVtSBelmPlR+54VBb1uBa/4Pwf2be9x4=;
        b=jlxuETIpd6q3tab8WM4HKNWnsRGEui4Z+zs2siiFXbFnb+46nFf5LplBA0j/nETlrO
         5QC3f+C5KDbfeO/xbV0HQYdQsx5xGrEZFhcwn1iI/EmFLrYCdxzG87BOTgIqOeJGnPqU
         otJsOU+Ox+j8VyftjD2aIqkLaFWw3HvbubehE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705975724; x=1706580524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o6pnpX/gRRzVtSBelmPlR+54VBb1uBa/4Pwf2be9x4=;
        b=WmXBEZ9ujCVyRvvUgsbTaQ0cPoPlJUEl4lgP3zdNBh17aGUEoeZSkxhIOxL/F4yuiy
         L2NBtbU9g+F70usMOwt8IN6aOjsLKAWNSc5HY//UxLMpmBsdZaNhG9ie+xYKqh+lmv+8
         ZxkL+Eo70noKXGTBz9b6t9uxLrtWDucGqb9IKdfgHzyCwrVfJLvkwpXWUgj1uswBeAzs
         jBW6VguvwC+23jUudHtSmvZcQ9SKjqK8PYtWcU9QLtj3o7chrzSz+T97fl25WeKGXcKr
         4cv8js8rSdsR9Eh/J5VxUGgYD1DBOCgRFLsUI9WeqJHXh9aqjbaItv+usqFZZah49w6l
         UbXw==
X-Gm-Message-State: AOJu0YySY7XPwUqKUT8Z/qGH1X0Mdk7oJzPlvYtyJbNGEzx+Qfacg4WU
	oHyzXS37n5gd4LEtcBif1GsCduXVrGoBlaQZwvvWlcr1IUO4oE9Bf8Q7I+GScAsKSmZqbitWyho
	=
X-Google-Smtp-Source: AGHT+IEQRAZmvhkDx4UQV5Sd1d7vCB1aXsD0Epwm9G3QeRyZt4t8/6PPZ0wD7MZx7Qdq7+lG9cZqmw==
X-Received: by 2002:a17:906:8a55:b0:a2a:2498:93c5 with SMTP id gx21-20020a1709068a5500b00a2a249893c5mr2360813ejc.73.1705975724530;
        Mon, 22 Jan 2024 18:08:44 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906c20f00b00a2ae7fb3fc6sm14029260ejz.93.2024.01.22.18.08.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 18:08:43 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so3504816f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 18:08:43 -0800 (PST)
X-Received: by 2002:a5d:4683:0:b0:337:c6b6:fe5d with SMTP id
 u3-20020a5d4683000000b00337c6b6fe5dmr2533245wrq.102.1705975723146; Mon, 22
 Jan 2024 18:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
 <170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
 <20240117090706.3522d23763fab9dcea21aee1@kernel.org> <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 22 Jan 2024 18:08:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
Message-ID: <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:08=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Wed, Jan 17, 2024 at 1:07=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel=
.org> wrote:
> >
> > Gently ping,
> >
> > I would like to know this is enough or I should add more info/update.
>
> I still am not sure what this is going to be useful for.
>
> Do you have a specific example?

Since there seems to be some communication gap here, I'll give it a try.

First, I'll paste the key phrase of its use case from the cover letter:

  "we would like to know how long the resume processes are taken in kernel
  and in user-space"

This is a "system measurement" question, for use in tests (e.g., in a
test lab for CI or for pre-release testing, where we suspend
Chromebooks, wake them back up, and measure how long the wakeup took)
or for user-reported metrics (e.g., similar statistics from real
users' systems, if they've agreed to automatically report usage
statistics, back to Google). We'd like to know how long it takes for a
system to wake up, so we can detect when there are problems that lead
to a slow system-resume experience. The user experience includes both
time spent in the kernel and time spent after user space has thawed
(and is spending time in potentially complex power and display manager
stacks) before a Chromebook's display lights back up.

If I understand the whole of Masami's work correctly, I believe we're
taking "timestamps parsed out of dmesg" (or potentially out of ftrace,
trace events, etc.) to measure the kernel side, plus "timestamp
provided here in CLOCK_MONOTONIC" and "timestamp determined in our
power/display managers" to measure user space.

Does that make sense? Or are we still missing something "specific" for
you? I could give code pointers [1], as it's all open source. But I'm
not sure browsing our metric-collection code would help understanding
any more than these explanations.

(TBH, this all still seems kinda odd to me, since parsing dmesg isn't
a great way to get machine-readable information. But this at least
serves to close some gaps in measurement.)

Brian

[1] e.g., https://source.chromium.org/chromiumos/chromiumos/codesearch/+/ma=
in:src/platform2/power_manager/powerd/metrics_collector.cc;l=3D294;drc=3Dce=
8075df179c4f8b2f4e4c4df6978d3df665c4d1

