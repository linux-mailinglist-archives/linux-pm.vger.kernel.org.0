Return-Path: <linux-pm+bounces-10313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD291F061
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F23287547
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B8144D36;
	Tue,  2 Jul 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwOFnNRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FB54FB5;
	Tue,  2 Jul 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906035; cv=none; b=AP/k0Pg9tk3ntDk0tnpf/+4JkC3IDZudMztTJSst6VskcycCbJA6GhIAQDBGvFqUynnwnwYRXmgP7mLOMkaA+LHNpKLEeiJhS2R6XxTt+kZRUFGi+0G9Azt0orQVy9hddmBv/D0Of/guRMbyLzDuXWrQIsDY1VtyTUPhbrGqWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906035; c=relaxed/simple;
	bh=PcVk9pcskDazelhQkcuxF07f4ocoy3fBKZA9lVRhRdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhdTNyBD6jZGFRZ55Xq7K1lOn531PjvuzB0R2oE/AporRsSOo0V0Ip1H/rUqjWa2CCJgXHj7VLThA6NoSpkt7lXkH2YzwgStcjjFVTSlJcElkjQXR/b0rtUk3vPDlybdNYOXeEFrEDkjrQokHQbyWQb/41/HZWgtAT57TUPOI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwOFnNRw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72988749f0so573259466b.0;
        Tue, 02 Jul 2024 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906032; x=1720510832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcVk9pcskDazelhQkcuxF07f4ocoy3fBKZA9lVRhRdc=;
        b=mwOFnNRwVuZSRKTuD9YocuxaIqIZQIfh2ppMMMQnM/9BMSgy6mzQZpOGJQ5AJVS2JV
         8DT+YU6PKRb3rRkO8cJwBg7G0f8Y6dK8dLGkOP05fHMuP3wOan8vqibOY7hZRnoH7Grq
         mtEd1HBnkCNEesOB3Zyeeldxcz8EOUOgHpWj5VnPZsQzWjAO02WUTinTTq/CgYC5c9mA
         /5JvXRaQT3d/5gYST6nXfJhXmnUwnr9P6F1qSRhtY68r6sgyG4fC1E7W0tCeVY0t47GD
         SKha3CZv17ba5Pb0LWsOre+WPXCtKTN/NeasDB7WNw5FhEnj3859SsXM6m8PuVtphuf2
         kHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906032; x=1720510832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcVk9pcskDazelhQkcuxF07f4ocoy3fBKZA9lVRhRdc=;
        b=oACZLjdQL57B6ah9rGQCpwlAukyfhnqDROrbupAQzGQ351CBiZb+Gb7mMeRiEyLBEB
         PfQUQ/ZaZXJvnbFS/4W8T/0oWE0Hy0rWNjLmw/j9aCOIIRBXyOveDArYYMmWZSlbXEFz
         h/3aRLxjRaFsMTu3eFMuQN3QGtgKh7uKm6hek1OqDC+laL2hqhly7lSd+Siea7rI8+Fy
         0J12r3V8RHY87NFSolz0se3eIOgCoO2wB7ZvS9CWGU5jSOy9SCtNE1/YeuAlAN5HqJqx
         qV5dv+MiuMueI6fS36+8vGCqRMTq+0gLlHTZbOYRJ2IeRKYMMuKVNvnWijtKtHZJPmMJ
         oevw==
X-Forwarded-Encrypted: i=1; AJvYcCUvxSgk4aWIOhMg5KZeGyg3LHzC7TVqczr2Wyw1AiWJTb6ptyY/H9opEQT0VVCqiNohSYRoF1QLnhTn5frLB0G5k9jECllE2R5qfj6mRqQcaZsVW9MacsmKP5yX7Ziruvk8Mm2+vBc=
X-Gm-Message-State: AOJu0Yx2gynxUgxCEjGA0mvhzE42T+kRFHZI/O4PZdHIvfwoFNy9vAt6
	yvPma65mxNMHCL4yk2osAfBo62l1Y5pJhy3XvP1E2SWcAsMzqyojUm8+SfPYjRM+jWhcItWMKuz
	f2LdUrsiwXb4/zUn1yKEf3HMm52g=
X-Google-Smtp-Source: AGHT+IHgGHjnZenrRqWi/oLaXC+N3WLnnNwhl7v5Bn7Ch8VqF+oo9nxaMmCeFy5urpbboScGqmnOrD3RwjIoehRm/gs=
X-Received: by 2002:a17:906:c28a:b0:a6f:5815:f5e6 with SMTP id
 a640c23a62f3a-a751446321amr463320566b.8.1719906031756; Tue, 02 Jul 2024
 00:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
 <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
 <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com> <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org>
In-Reply-To: <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 2 Jul 2024 09:40:19 +0200
Message-ID: <CALsPMBPkE=CCTgm8UcsdL7qEG+1u1H8NFYYTJvEMK3uXvg97Ng@mail.gmail.com>
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:40=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 6/29/24 04:48, Roman Storozhenko wrote:
> > On Fri, Jun 28, 2024 at 9:45=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 6/28/24 05:30, Roman Storozhenko wrote:
> >>> On Thu, Jun 27, 2024 at 7:33=E2=80=AFPM Shuah Khan <skhan@linuxfounda=
tion.org> wrote:
> >>>>
> >>>> On 6/27/24 01:49, Roman Storozhenko wrote:
> >>>>> When the 'cpupower' utility installed in the custom dir, it fails t=
o
> >>>>> render appropriate help info for a particular subcommand:
> >>>>> $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> >>>>> with error message like 'No manual entry for cpupower-monitor.1'
> >>>>> The issue is that under the hood it calls 'exec' function with
> >>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> >>>>> path is defined in '/etc/manpath.config'. Of course it contains onl=
y
> >>>>> standard system man paths.
> >>>>> Make subcommands help available for a user by setting up 'MANPATH'
> >>>>> environment variable to the custom installation man pages dir. That
> >>>>> variable value will be prepended to the man pages standard search p=
aths
> >>>>> as described in 'SEARCH PATH' section of MANPATH(5).
> >>>>
> >>>> What I am asking you is what happens when you set the MANPATH before
> >>>> running the command?
> >>>
> >>> It adds the custom search path to the beginning of the MANPATH variab=
le.
> >>> I tested this case. All works as expected.
> >>>
> >>
> >> Let's try again. What happens if you run the command with MANPATH set =
and
> >> exported and then run the command. Can you send the output?
> >
> > hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> > /tmp/
> > hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=3Dlib64/
> > bin/cpupower help monitor
> > ...................
> > man output
> > ...................
> > hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> > /tmp/
> > hedin@laptop:~/prj/cpupower/install/usr$
> >
>
> Is this with your patch or mainline? Can you give cut and paste
> the man output here for the mainline coupower without your patch?

The above output is from my patch.
This is the output from the mainline:
hedin@laptop:~/prj/cpupower/install/usr$ sudo LD_LIBRARY_PATH=3Dlib64/
bin/cpupower help monitor
[sudo] password for hedin:
No manual entry for cpupower-monitor
hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
/tmp/
hedin@laptop:~/prj/cpupower/install/usr$


>
> thanks,
> -- Shuah
>


--=20
Kind regards,
Roman Storozhenko

