Return-Path: <linux-pm+bounces-956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CC80ECDE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D92128177A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D761668;
	Tue, 12 Dec 2023 13:09:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9FF4;
	Tue, 12 Dec 2023 05:09:50 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9db92bd71so762850a34.1;
        Tue, 12 Dec 2023 05:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386590; x=1702991390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAqdKm0EKgBcxE4mTrx8v0yfSJhP1XzxWLOd6J96gro=;
        b=PgCgL2mhf9YSWfl7kVX/RsNplqW8QzyWVZBqVK3BHUGlrc9Ch4QT1jhE1Rc8vFC7DW
         2k6CWKR5mVaoy3dMx8TDoMVKkxpDqDpzi6IA6iREGOvi/DmDobGd7SKwxMpep5qvuEZ+
         TaI1CJqCb4rnfIWaI36o5Lxn/40b5LYKPOwEWygw0+RCEUO2gCWl/Lb9v9tbOXWYvoOm
         k69XCs7lK2oqbq1pog0lZQgo238putL6c6DC0NMkMA8YhEKGeoiCpxMbH9LWaAb8qHAy
         /2y+q0QHVF+FVa4Ln6dmxV0ytis/ZBb8cqKYcNakihjpUj5jJcGjQQtSIc11SOvxrsnp
         mbGA==
X-Gm-Message-State: AOJu0YzGirGriDseSU43hLkf34Q3iqn8xFvLPBF/jLDDs0+mGJ/7FZ1E
	3cnB38uhGfv73y/JR7ePYLGGHl8gX8bjwy8FZC5CbqfJLL0=
X-Google-Smtp-Source: AGHT+IHLfzGUAAnaJfxtVuphP3ffds6u7IRMNEbo1BSNizPMYveg8tZYJegMpmdSons2fjLjTENixKhoYazZJqKvQrg=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr12505756oob.1.1702386589661; Tue, 12
 Dec 2023 05:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-5-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-5-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:09:38 +0100
Message-ID: <CAJZ5v0jBzqa8UVbarJbFDcqyLsMEVYSuCtcxKk6PUSv3TDnUOQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] cpuidle: s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:32=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> In order to further distinguish software and hardware TIF_NEED_RESCHED
> polling cpuidle states, rename CPUIDLE_FLAG_POLLING to
> CPUIDLE_FLAG_POLLING_SOFT before introducing CPUIDLE_FLAG_POLLING_HARD
> and tag mwait users with it.

Well, if MWAIT users are the only category that will be tagged with
the new flag, it can be called CPUIDLE_FLAG_POLLING_MWAIT or even
CPUIDLE_FLAG_MWAIT for that matter and the $subject patch won't be
necessary any more AFAICS.

> This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> kinds of TIF_NEED_RESCHED polling states while keeping a necessary
> distinction for the governors between software loops polling on
> TIF_NEED_RESCHED and hardware monitored writes to thread flags.

Fair enough, but what about using a different name for the new flag
and leaving the old one as is?

