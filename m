Return-Path: <linux-pm+bounces-25481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932EA8A4EC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CB73AFD13
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA3176AC5;
	Tue, 15 Apr 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHjyEEVJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289946FC5;
	Tue, 15 Apr 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736755; cv=none; b=heqJPT2M78YKn7MrMxOssM9gBY/fhLsz5g55Mvn2LYHmcFQwxl6PjJh6hO/LY0egvEBS4Anm0yjNNMYJmDIBLYx5+QvdEx7z03Kljx4Q6zVwdNBbhdnfkiBmlOH8JibDQO7KgmyXSAaY6+kBec5WsQdOCbT+HPQ+cI5S8oxXR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736755; c=relaxed/simple;
	bh=HsKHEdkEbY3fGX/jXwfPRB8xGPMVKkEpNhsdWRk1pXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz9kqaMIVJGJz3JjD+t6XYjxyyMEOjWURGNwwUEmGz/bLcef8PEWj7rEXHBT4OHNcoo36L7j5KtVICtGjJMnBRlP0RKMz4zA4CMUXPXB1uX6qita6uPSlIb8xE6fL5g6rECorfxcr0nHi17XAyBid6K2dsVKcTxrkve0a8LxdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHjyEEVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92811C4CEEC;
	Tue, 15 Apr 2025 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736754;
	bh=HsKHEdkEbY3fGX/jXwfPRB8xGPMVKkEpNhsdWRk1pXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHjyEEVJA6e+nZzLGD0w1RxE+34AI8XIBwnNSStboNgMnIN//JFS5QmKqllwx/MWu
	 gNeiaxMNGiTBsyXTr3/+Cf8Ed9V1vFYd2Tp7JZUbCMB+XUVYcvjm1WjQJBt3D4nF4n
	 X/oduN66KPImgi4CEO5ZACgd4hP+iTD8dETf6FnCevl566QFSXzqLFRXTT+e8+psWl
	 NHTigiZgWrNw+FMjQLLcqZDRdxCQlGggvyKwlb2aduoGBTp0lUSiD8cCqtnoZFQosf
	 IwB3VK59BkbNm1LnAfpHo4emfZsdxIPMOiy4EHYuzrsTBSvbq4jscehyqos22QZcyS
	 JMqh46O1GL5YQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7f876b321so1881691fac.1;
        Tue, 15 Apr 2025 10:05:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTHSDUZfmL9DbEpx7aA9u2DDX+uehpBLP2gUHNgUxuSg8UK3v3OqDIE7l5qkcOq8QzVAaC4BL8DZ1rR/w=@vger.kernel.org, AJvYcCWtEUSNFrph2+d7aleabLivzngeV2JVdU2cvw6DX+kshRqKDZ14eumDoIXUhrIx45TUplMB5hQBWc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZiaUryfPSm2TFn0OzYVrdfbM4NS/orD+Uo2lKoU6ia9UGz+6
	qNiVycJqUKz9utT8//rQoOkPmawuaMMi6sIYYSRl/Q0FHODQqfqSG259y9aT13BlKAD9iPUvFH0
	0ZKfMpDJ5MnrxSBa0j5u1v77p6y8=
X-Google-Smtp-Source: AGHT+IEYV2kVtH8X6w7XB4diHvAseLjJYsXwDutomeeI+5p30ScQANM3FB+C5eOT903S2jofLe8TluCgUBLEm2CcJbE=
X-Received: by 2002:a05:6871:6117:b0:29e:40f8:ad9b with SMTP id
 586e51a60fabf-2d0d5c868bdmr11309377fac.14.1744736753828; Tue, 15 Apr 2025
 10:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415004215.48757-1-changwoo@igalia.com> <d29e4ea6-2bfe-4017-b7c8-0d77613959f4@arm.com>
In-Reply-To: <d29e4ea6-2bfe-4017-b7c8-0d77613959f4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 19:05:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jx44heAgXPwCDriGo-xyjX2pUP+PG1cQwjme_=EHo3rg@mail.gmail.com>
X-Gm-Features: ATxdqUHI6abZKG4tAU291VyM3De8vG2jlmR6pAnWPQoREbt37JQq2DgLfPWHgnc
Message-ID: <CAJZ5v0jx44heAgXPwCDriGo-xyjX2pUP+PG1cQwjme_=EHo3rg@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Add inotify support when the energy model is updated.
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Changwoo Min <changwoo@igalia.com>, rafael@kernel.org, christian.loehle@arm.com, 
	tj@kernel.org, len.brown@intel.com, kernel-dev@igalia.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pavel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:31=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Changwoo,
>
> Thanks for the patch.
>
> On 4/15/25 01:42, Changwoo Min wrote:
> > The sched_ext schedulers [1] currently access the energy model through =
the
> > debugfs to make energy-aware scheduling decisions [2]. The userspace pa=
rt
> > of a sched_ext scheduler feeds the necessary (post-processed) energy-mo=
del
> > information to the BPF part of the scheduler.
>
> This is very interesting use case!
>
> >
> > However, there is a limitation in the current debugfs support of the en=
ergy
> > model. When the energy model is updated (em_dev_update_perf_domain), th=
ere
> > is no way for the userspace part to know such changes (besides polling =
the
> > debugfs files).
> >
> > Therefore, add inotify support (IN_MODIFY) when the energy model is
> > updated. With this inotify support, the sched_ext scheduler can monitor=
 the
> > energy model change in userspace using the regular inotify interface an=
d
> > feed the updated energy model information to make energy-aware scheduli=
ng
> > decisions.
> >
> > [1] https://lwn.net/Articles/922405/
> > [2] https://github.com/sched-ext/scx/pull/1624
> >
> > Signed-off-by: Changwoo Min <changwoo@igalia.com>
> > ---
> >   kernel/power/energy_model.c | 47 ++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 47 insertions(+)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index d9b7e2b38c7a..0c06e0278df6 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/cpumask.h>
> >   #include <linux/debugfs.h>
> >   #include <linux/energy_model.h>
> > +#include <linux/fsnotify.h>
> >   #include <linux/sched/topology.h>
> >   #include <linux/slab.h>
> >
> > @@ -156,9 +157,53 @@ static int __init em_debug_init(void)
> >       return 0;
> >   }
> >   fs_initcall(em_debug_init);
> > +
> > +static void em_debug_update_ps(struct em_perf_domain *em_pd, int i,
> > +                            struct dentry *pd)
> > +{
> > +     static const char *names[] =3D {
> > +             "frequency",
> > +             "power",
> > +             "cost",
> > +             "performance",
> > +             "inefficient",
> > +     };
> > +     struct em_perf_state *table;
> > +     unsigned long freq;
> > +     struct dentry *d, *cd;
> > +     char name[24];
> > +     int j;
> > +
> > +     rcu_read_lock();
> > +     table =3D em_perf_state_from_pd(em_pd);
> > +     freq =3D table[i].frequency;
> > +     rcu_read_unlock();
> > +
> > +     snprintf(name, sizeof(name), "ps:%lu", freq);
> > +     d =3D debugfs_lookup(name, pd);
> > +
> > +     for (j =3D 0; j < ARRAY_SIZE(names); j++) {
> > +             cd =3D debugfs_lookup(names[j], d);
> > +             if (!cd)
> > +                     return;
> > +             fsnotify_dentry(cd, FS_MODIFY);
> > +             cond_resched();
> > +     }
> > +}
> > +
> > +static void em_debug_update(struct device *dev)
> > +{
> > +     struct dentry *d;
> > +     int i;
> > +
> > +     d =3D debugfs_lookup(dev_name(dev), rootdir);
> > +     for (i =3D 0; i < dev->em_pd->nr_perf_states; i++)
> > +             em_debug_update_ps(dev->em_pd, i, d);
> > +}
> >   #else /* CONFIG_DEBUG_FS */
> >   static void em_debug_create_pd(struct device *dev) {}
> >   static void em_debug_remove_pd(struct device *dev) {}
> > +static void em_debug_update(struct device *dev) {}
> >   #endif
> >
> >   static void em_release_table_kref(struct kref *kref)
> > @@ -323,6 +368,8 @@ int em_dev_update_perf_domain(struct device *dev,
> >
> >       em_table_free(old_table);
> >
> > +     em_debug_update(dev);
> > +
>
> I would move this out of the locked section, below the mutex
> unlock. Looking at the code in em_debug_update() you are trying
> to send such notification for each EM's table entry * number of
> fields, which is heavy. The RCU copy that you get will make sure
> you have consistent view on the data and you don't have to
> be under the mutex lock.
>
> A different question would be if the notification has to be
> that heavy?
> Can we just 'ping' the user-space that there is a change and ask to read
> the new values?
>
> Another question, but this time to Rafael would be if for such use case
> we can use debugfs, or we need a sysfs?

debugfs is not really suitable for this IMV and the problem at hand is
a symptom of that (but there will be more issues in the future
AFAICS).

Before starting to invent new interfaces for user space, though, I'm
wondering why the BPF code cannot obtain the energy model information
from the kernel?

> >       mutex_unlock(&em_pd_mutex);
> >       return 0;
> >   }

