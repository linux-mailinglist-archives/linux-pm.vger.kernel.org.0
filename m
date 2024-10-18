Return-Path: <linux-pm+bounces-15978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5D9A435A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1E328132D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752E202F7D;
	Fri, 18 Oct 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbiqDEw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4DF20262C
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267844; cv=none; b=gz2E0mXrDp259VIH9kpLCcorYtDkr29Gdz97aVLWigIz+kxraNfZQrI/UsDvBFr8NzCVGyHfvRiQUNAKRs/7HxBDZCiV8b3lhZg6SX1lkQxM9cjUnaU7ynMl5NoqwmRZWKHmiBDmGNlFoB5ZuVrJDcMEzsV/Kc6+KvjZ+5J51DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267844; c=relaxed/simple;
	bh=JuJzQzslhTotDMx0+6eb0uKjnXES4M9TQkjrM1Mz/Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/WkPupISiuLZrmLJo8s8StIYx+4R+vYZpi70IkQS7fZ0k4m2IGUu2HB8JxH0ulmZ2ib8ggH+PtsrtZ78L4jgQn7qoIYjztnfMMpqtQ4NdIFdQ2GKcTuB2Y+LfJywCxT55uXoBq0Hs5RHs13GWDkz4QVqWHjq0XJXu1lwuXjUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbiqDEw0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so1649828a91.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729267841; x=1729872641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzcmIoSnnRoqVjkfImEkXgtaHxqUHP3HJ7pJbZDej0I=;
        b=lbiqDEw058Wdc7lykBpnzJuj95ENL+gOIUsRC8SLUqZT16XjdW7gRHTFb5Qy8SNCIJ
         j1ctA4wCqqxkDtn6QlTHMMqynmfBa0Ly9ab4CqUuTDyPOckOPN+eq4u/uXTJCHY04Fe2
         Xr25T1/QM6D6HN6JjGkydNVbSDduAWmjSLMg3hZxSkCbhd5+6HPpgU/u5rT20OF3zIeU
         jiJvPqaiNlMzV6Q8zbpu91SfcXTDAo9/SjCwKaxf9xS6X6ymDQopt/TjnQMi5GgqIgoo
         CYQ4JNRmWl76AQltEHe02oVmjeBhd+CcRmmtglAwp69cwdbY3n5LPIwn5NJss56B8YZa
         0akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267841; x=1729872641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzcmIoSnnRoqVjkfImEkXgtaHxqUHP3HJ7pJbZDej0I=;
        b=J4ZHSI1yFqwt3XceiBpb50qSEkeb4mva6aeiRpXByU9iRXwhAJ+T4uuHX8yNCfBDKJ
         qJuoaR/J4ZAdJvOIMoneWjADzURN206wnRf4sJxdyTCpe01klu5bp8ddai59VSvZKbFA
         nxt6iMd0mOHnAoyuw+3WRf9awnNFLm9foYNPy09zdosCGgKwntLcjyZytAN3I/cSTpHB
         19Cd9Z3WoQyIa7cJxNKsLAM9UkVA+1n5WDSTQnFI2z2gwMJaBOmxYXurpETYgBqqdoPy
         +ePYf4mE5gDIb3l9wOhZoI90wStRakB1Re6A8ExsKsEbYnpbsv826g/DHWVHDU7yLPDX
         ItAg==
X-Forwarded-Encrypted: i=1; AJvYcCVOA2VNDHMl53lQfQG2HFXFpbpDH+5PG6FjF3lot6NyQxyB0MUohIwd2HYU88m2C3kxUSbKve3jug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VxPY/qAbRoV96fmBsJp8aUSFvRuaJKQXWioNgsF1dBsX8V1j
	G+xrLkeQ9+K34H2sKwXrlZb+q1a+8MguGXQh8MC6WGWwO/xUQoYBAZuznVJJqR4RRH6jT8pk8n2
	6myx/SjQp60Raxvt1xC8vTeZwLWh4nW+ERrOmgaiGxN8MeK2Mp5pB
X-Google-Smtp-Source: AGHT+IEIaDHKGx3a03jjnaRAfVjQU/2C59OteMdtaOvSmLoZgagpqk8t3RjA9wfG7jz6Ng70z3qsoKYAO9sjNrgLdbc=
X-Received: by 2002:a17:90a:7346:b0:2e2:b719:d581 with SMTP id
 98e67ed59e1d1-2e5616c1e83mr3496300a91.5.1729267841051; Fri, 18 Oct 2024
 09:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67124175.050a0220.10f4f4.0012.GAE@google.com> <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
 <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
In-Reply-To: <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 18 Oct 2024 18:10:27 +0200
Message-ID: <CANp29Y7UFVPYtdd0jVUbkUjdkpXXrv7Z+sczmKvZytNmtgx1hA@mail.gmail.com>
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>, 
	andreyknvl@gmail.com, daniel.lezcano@linaro.org, elver@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, rui.zhang@intel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

On Fri, Oct 18, 2024 at 5:43=E2=80=AFPM 'Jann Horn' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Oct 18, 2024 at 3:21=E2=80=AFPM syzbot
> <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit b8c8ba73c68bb3c3e9dad22f488b86c540c839f9
> > Author: Jann Horn <jannh@google.com>
> > Date:   Fri Aug 9 15:36:56 2024 +0000
> >
> >     slub: Introduce CONFIG_SLUB_RCU_DEBUG
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14cc4c5f=
980000
> > start commit:   15e7d45e786a Add linux-next specific files for 20241016
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12cc4c5f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36416f1c54=
640c0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Df24dd060c1911=
fe54c85
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1192f8879=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1417e830580=
000
> >
> > Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> > Fixes: b8c8ba73c68b ("slub: Introduce CONFIG_SLUB_RCU_DEBUG")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> This looks like a bogus bisection - the blamed commit was already in
> v6.12-rc1, while the file that contains this warning
> (drivers/thermal/thermal_thresholds.c) doesn't even exist in mainline
> yet.
>

Indeed, the bisection result is wrong :( At one of the steps, syzbot
has hit too many random "lost connection to test machine" crashes,
which derailed the process.

I've filed https://github.com/google/syzkaller/issues/5414. Once
implemented, that should get rid of this class of false positives.

--=20
Aleksandr

