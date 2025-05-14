Return-Path: <linux-pm+bounces-27111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D82AB606C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 03:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EB19E70D0
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8EA15ADB4;
	Wed, 14 May 2025 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfX7moft"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DE151990;
	Wed, 14 May 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747185621; cv=none; b=Fj5KZTON8y5MVo+C39jlZ5B8RJjd0nsbK8fSTuO6cbmoM0hB2S9XW5b1m5lpV6yA/kGt2tddy4qxvcg8OVtqa7WHcl6Net3YmVQLQQHnWh6nFn7oYLO5UdTGU78X21r7VXz+0RG5Z7ByaCs6jc73npb29V/WuDDCKX0xalPmEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747185621; c=relaxed/simple;
	bh=6TH+CfOf8nH8p092bYaPHuPFIDKQno5bG+ApPzD2hCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8a81Edfq8zKBl5J4kzM1Hlep6U+vjIadLHlb1ULH2kMHUcXVbjfeZqJohvQeEM7o/ie/cHyH1A8A4MhCsQ3imZJMZDGegJpcxOWpZm/9ecMneLK5mpPWsKM+Hgphw9HugsDQwIZW2F5sqqSfKF99C9sGFNwmuVsWFO+gXLvY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfX7moft; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c14138668so1612089a34.2;
        Tue, 13 May 2025 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747185617; x=1747790417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjhw+8R2L2eVYt9u5Zf9479vJ3/o77t8mJ9Bz83DtoQ=;
        b=bfX7moftQbj4hAbiGEsEFqZK1HNmygwOkTebz/QvQV1GANNaOD5M+EA4hxaZtrpec0
         1VQHB7om3PCvpMWY9+ktWfPIf3JZ44c0PpAd1mxwzO8KP6kahWC4NeGGNDShxfBZS/Zk
         9iSqFtYY26Sj/36tgI4ba7GbZ2PB8uGuSKo+5OMKWc9rIU7fZxp9/Bk/F230cGeQgMYZ
         BM/KnE9az4ornikZ/8pE09D+br7MTVBW+ztB4c0d9DiXpDznNDHgDNakJ/U7bmkcKESp
         PCEbNO+WuXlY8xQoeljtHccJC02jrEqw18NLjC7rr7xgwGJPUtHOfildtRRCkFyv++HD
         svug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747185617; x=1747790417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjhw+8R2L2eVYt9u5Zf9479vJ3/o77t8mJ9Bz83DtoQ=;
        b=EC7E5bW80OzdXAOG+xHHhji+pETFXnhJPaF1BFMM7l54h2L1JeBSXToDEgP1hQUUbH
         w8SH2R93ZTqlpM/1ZX2L/kL9c4yX+zEbFVzTk4OhCAa0jjv+HgLqAaYFxmCVLGD3RmrG
         peera0stKBlV9Idq8Thwgqb/724Hem6Lp9qyGgL1DLZ8rfinvKcRqIW6Wyv1cC+jRJr4
         ZDAIJeBvZB3wv2k5TXPwt7rWej8GVhXRWmgY8FcRit2eIfuEYQP0ll8qDC8+AqRao7dj
         2aHdQEfPvDEVx7Nh1IO8OPGtnaRwJHrNjJHrC0BO6u0JRrKUQZ+b1TaOUJfQLzHZ+GSm
         XA7A==
X-Forwarded-Encrypted: i=1; AJvYcCWK99Yv6OhLnDmIxytRA5js+I70YswnIPMB5Zx3vhbaF4SIRccpmOF3iT+gK8rQ56B9tvl285LHpMTC9z8=@vger.kernel.org, AJvYcCXUGg20IGU2BdSah6CVexCUBVH0S5ISrA5KVLjm1aXsXbN50NTKwm0Sx7zngZLHTW91833BHiFEwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDm7wBQIG8h+hJ4bHm9KuBl3dScJ+aEhyj+vdKxsgbY55ovql2
	/nc2kuHu3f5ziYY6o2jXOr8OpY+lK3ZHt4Xys1lnWJqTRsxH94lDN+eE0ET+KwP4envYlFAY2yZ
	UFF46wUjzS81z4Qc0Q4l12CXEUTj2Wfm3KN4=
X-Gm-Gg: ASbGncsIIp2NH42Q7Uiypu31+1b4EQHodGzvuWRLUB3QuIHM+9GbLVC8fbrHSWPJLhO
	/EFXYcIUZDeSFtd7fsKqtmbaHQkVxrgkI+caK4MV4CFpqgtSbTEkFaiw4cdWrmNVpnMG03Dkg1x
	g6IuRZFKOU9DZkSEeX65eoluXr+Ey+LToGET2LM3zCE1TeyC1Hu/ddqZj3mut5T8zT0Q==
X-Google-Smtp-Source: AGHT+IHkZ/hgevBC9dQiqQ7Y9K8Hy5o5zbMHYNDgVh2fgORnUsRO27N4/XTRi5pSH9FtbfVkATvj1JiZs9S+RGqo4q8=
X-Received: by 2002:a05:6870:71cb:b0:2d4:d07c:7cb2 with SMTP id
 586e51a60fabf-2e32b1366a7mr696824fac.11.1747185617429; Tue, 13 May 2025
 18:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510184709.44935-1-suchitkarunakaran@gmail.com> <09c7ad5e-4061-4c0b-b097-fa575c12a244@linuxfoundation.org>
In-Reply-To: <09c7ad5e-4061-4c0b-b097-fa575c12a244@linuxfoundation.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Wed, 14 May 2025 06:50:06 +0530
X-Gm-Features: AX0GCFtYZvMyu3LNA6tisPv-kVuwpVvfEoES84vyI6pfnQg2CB3GgUX9A07nmkk
Message-ID: <CAO9wTFjyEngVR10ixYj=G8udRBeKaxAQquPCdi0V638t3WqQfA@mail.gmail.com>
Subject: Re: [PATCH] tools/powercap: Implement powercap_set_enabled()
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, 
	linux-pm@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the suggestion, Shuah. And I did compile the kernel after
making the changes.


On Wed, 14 May 2025 at 03:33, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/10/25 12:47, Suchit Karunakaran wrote:
> > The powercap_set_enabled() function previously returned a dummy value
> > and was marked with a TODO comment. This patch implements the function
> > by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled
>
> The short summary should say cpupower: Implement powercap_set_enabled()
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >   tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++++++----
> >   1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> > index 94a0c69e55ef..7947b9809239 100644
> > --- a/tools/power/cpupower/lib/powercap.c
> > +++ b/tools/power/cpupower/lib/powercap.c
> > @@ -70,6 +70,22 @@ static int sysfs_get_enabled(char *path, int *mode)
> >       return ret;
> >   }
> >
> > +static int sysfs_set_enabled(const char *path, int mode)
> > +{
> > +     int fd;
> > +     char buf[2] = { mode ? '1' : '0', '\n' };
> > +     ssize_t ret;
> > +
> > +     fd = open(path, O_WRONLY);
> > +     if (fd == -1)
> > +             return -1;
> > +
> > +     ret = write(fd, buf, sizeof(buf));
> > +     close(fd);
> > +
> > +     return ret == sizeof(buf) ? 0 : -1;
> > +}
> > +
> >   int powercap_get_enabled(int *mode)
> >   {
> >       char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> > @@ -77,12 +93,10 @@ int powercap_get_enabled(int *mode)
> >       return sysfs_get_enabled(path, mode);
> >   }
> >
> > -/*
> > - * TODO: implement function. Returns dummy 0 for now.
> > - */
> >   int powercap_set_enabled(int mode)
> >   {
> > -     return 0;
> > +     char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> > +     return sysfs_set_enabled(path, mode);
>
> Did you compile this?
>
> thanks,
> -- Shuah

