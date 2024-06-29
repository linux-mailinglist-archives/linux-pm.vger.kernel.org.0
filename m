Return-Path: <linux-pm+bounces-10235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5391CC2C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DFB1C21CA4
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31463BB48;
	Sat, 29 Jun 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ7PQKqU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4F2262B;
	Sat, 29 Jun 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719658101; cv=none; b=eLCLm8ZZgrd7RlT3AliYo5HIPSB5F2ydPXjvw+dqJO5p0q0MYowCQ9P3t4PgZn4HNo/1ePBSb0CYA2V6ZofiQdBfZ4NPAebw3zOYekRxZbVZV+G8DxAxH1jOgOHFl0fTw/ESjQi9lFtcsQWpBeVHJK4Cn/0PKg7Xi2eKqtu9yfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719658101; c=relaxed/simple;
	bh=0Ye8tW9dDlcP1jcupUeznIGXv6zjnZ/fNgSZRIqVTrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdH1dviFzPut094Uyo6hioiAKizdc/1npCdVup70h9aOQGJG4OYq+1iD0BtUXBK0bDydCJVhnSsor9NPVHgKZhiYrDfxDLPTc1RDJpMaQziYxAEPLBAGt4TH89uZvtbo5dKX+Q0tPqTjfyIftEfCel/+2SR5ITAIgO4b+4M5S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ7PQKqU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so1969784a12.1;
        Sat, 29 Jun 2024 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719658098; x=1720262898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64kMVZoPrXjlUkgSmfchl/aJqol08dyEPE4ZDdt67HQ=;
        b=IJ7PQKqUW9Y2Zl5K1717oK8e2MvRYwZkn3TsaeHSaste50OWRohE8gdCIH/QKpQsnO
         +1xaOm7tP8L6HyaixBhwkRxogD+uW8M43iLuUMt84kB/u81xWYPPTBocB0/2ZbCpMt1i
         8PGdKyb7fajhTzFl8wzrKG8B49d+47RfwS3dQSvMDNIVkGZ8mwYMm907A3uQAFnvGGtw
         md9U8JjY3xq58rY8kggwBtkSve21GjnRvPV5AzwtgMeBsJ/8jYc4opkq5WO4nSTqTIb1
         hKlBZw208E/wYd/a0NMaBghykcaUU2FZePKjXDxgaseAlYtnRcCWHw1Kdt4YgKOYHvZQ
         IhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719658098; x=1720262898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64kMVZoPrXjlUkgSmfchl/aJqol08dyEPE4ZDdt67HQ=;
        b=jyyuleTTOnMn9SqMshzjolm3szHMx87nY1YvwZ3NC8THIu6wBwwE6s7NnNP+og+ZJM
         6bZ10lYJr+UunfRP5MzchOD6X1ijjDfL5IweL6jI6LRjvQkxac6xCfTyIVGI0PS74Ren
         4BKmS6svV3xKgiJ6To18DpBBEywpNVce1dhYKeQT04NKLcPT1TKD2+WbRPAk9xSj4pob
         p0+c1Pf7NPbETk/48u6mMJ9Vt0DCx5l2LSDw0aGdM9o+suScyw2Ckorrlls9vnDxoPvX
         nsBbPMh1HZi94Scn/JxLxopoQPqEFPV62bs+WJ7p21Zv7x79QR8DN/DxYJrHzuynQ/gm
         5M1w==
X-Forwarded-Encrypted: i=1; AJvYcCVmkBeETir2AGuVH0EiOykKeu4IgXikN8whoLvtOPo8FncBzLhAnXEuqBSiHJquq6MQllEVBtuVHuXrf8mw53FUDc3eEtrVJAeSyy7GFLuuD95EkF189EiwwGxDLaebbhAr87OXwj8=
X-Gm-Message-State: AOJu0YyyUvKhwUeoSgUZwfkeZFBixRFA3YiznNZG2Ms17zShv8FeESJU
	0887HpJ0hfL4cbpBpMWN2MYdw7Yh0bbJA3L9s4iruZrj0ZXx7BN4kfRGXgmxHnLY2bCC/0dJcdD
	dRuSAteQ6Od7CiS49oAWPibEi+Dw=
X-Google-Smtp-Source: AGHT+IHyCy4PZqdoqF+JWBvoGTHZWjd49tVXTAiDXT4EpmHavx2FLqIx5deL0amJecUczrlSU/upVHdgX424wMjFCYM=
X-Received: by 2002:a05:6402:1941:b0:57d:456:e838 with SMTP id
 4fb4d7f45d1cf-587a0b037ebmr512880a12.31.1719658098001; Sat, 29 Jun 2024
 03:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com> <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
In-Reply-To: <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 29 Jun 2024 12:48:05 +0200
Message-ID: <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:45=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/28/24 05:30, Roman Storozhenko wrote:
> > On Thu, Jun 27, 2024 at 7:33=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 6/27/24 01:49, Roman Storozhenko wrote:
> >>> When the 'cpupower' utility installed in the custom dir, it fails to
> >>> render appropriate help info for a particular subcommand:
> >>> $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> >>> with error message like 'No manual entry for cpupower-monitor.1'
> >>> The issue is that under the hood it calls 'exec' function with
> >>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> >>> path is defined in '/etc/manpath.config'. Of course it contains only
> >>> standard system man paths.
> >>> Make subcommands help available for a user by setting up 'MANPATH'
> >>> environment variable to the custom installation man pages dir. That
> >>> variable value will be prepended to the man pages standard search pat=
hs
> >>> as described in 'SEARCH PATH' section of MANPATH(5).
> >>
> >> What I am asking you is what happens when you set the MANPATH before
> >> running the command?
> >
> > It adds the custom search path to the beginning of the MANPATH variable=
.
> > I tested this case. All works as expected.
> >
>
> Let's try again. What happens if you run the command with MANPATH set and
> exported and then run the command. Can you send the output?

hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
/tmp/
hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=3Dlib64/
bin/cpupower help monitor
...................
man output
...................
hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
/tmp/
hedin@laptop:~/prj/cpupower/install/usr$

Just in case, the following is the output of the debugging session showing
how the 'MANPATH' looks like just before calling 'exec':

Breakpoint 2, print_man_page (subpage=3D0x7fffffffe1cb "monitor") at
utils/cpupower.c:84
84      {
(gdb) n
89              if (!subpage)
(gdb) n
93              subpage_len +=3D strlen(subpage);
(gdb) n
95              page =3D malloc(subpage_len);
(gdb) n
96              if (!page)
(gdb) n
99              sprintf(page, "cpupower");
(gdb) n
100             if ((subpage !=3D NULL) && strcmp(subpage, "help")) {
(gdb) n
101                     strcat(page, "-");
(gdb) n
102                     strcat(page, subpage);
(gdb) n
106             if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
(gdb) n
107                     exec_dir =3D strdup(exec_path);
(gdb) n
108                     if (!exec_dir) {
(gdb) n
117                     man_env =3D getenv("MANPATH");
(gdb) n
118                     if (asprintf(&man_path, "%s/../man:%s",
(gdb) n
120                             setenv("MANPATH", man_path, 1);
(gdb) n
121                             free(exec_dir);
(gdb) p man_path
$1 =3D 0x55555556db20 "/home/hedin/prj/cpupower/install/usr/bin/../man:/tmp=
/"
(gdb) c
Continuing.
process 26122 is executing new program: /usr/bin/man


>
> thanks,
> -- Shuah
>
>
>


--=20
Kind regards,
Roman Storozhenko

