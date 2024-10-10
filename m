Return-Path: <linux-pm+bounces-15426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB5997991
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 02:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83FB1C21F12
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 00:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FEA63D;
	Thu, 10 Oct 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PRUq9Kk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021218BEC
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519577; cv=none; b=iGIbIgtBDyEIK0LVnxSG0HJFIiACzUA8HxRGz2Z9KSkT/7hS5yDgUCPA5HlN00zhkhzLzIjd9D+KKnrUCxM80MZCs9bbCuRQahzJoc3UhhdRe1w/Dkb0E2mfi12wRbAiCXWW+Yk6YuMFJGd7ZsN5H8LXGNq8W4nax6TPakFi8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519577; c=relaxed/simple;
	bh=SFNWuHwKZc6gHwh8fVddaI3cpGflv1ca3j33w2CBd2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6h9NWBDUjDvLVjX1fTZNbAbpMhNAYrDZnZ41ehocureBx3DLWT8ZHCkYlk9vjRjqPKb5GlSMgZljA8aTQq2W8HgU/rJEntgyt013/z3xcE07vemHfM9hKMKOG0qAjdBy9EIYNliI7vKiQLMvd6hNMJ5YrK1bQ7r2YQg2LB+esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PRUq9Kk0; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db54269325so275154a12.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728519573; x=1729124373; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5oEEOIJNVv5T0TeWex13g8S0i310/CeWWhyQlNL8TqA=;
        b=PRUq9Kk0XLJ8z1rNQAJnLVNbYY7q66aq5eRNaCsLO410zl20AbWGrgACf6BXGhoOcS
         jDp1nxEMvLizkuLFfl5GaqgtoqI6ZezmuyvYWD59RnP3VksTOcT76tWQ3OVfx4H6gXCR
         vjt4WjDZZgcUQ7xomE+fi+CJ4lItAEvBcfQ0fyJWgnWe69XdoACpym70Kvr8IXAQiHDI
         BUa3JhJuEcM93CeBkWgOEwFM+G50ePGCXYAI+G72vpmUXQX3mwIXqnyMllOLPzB3whpM
         3XwimR8Zs+rOXT5xOhF2v3Lx97YUavW9C+il1we41+rst1DGApaFT4fZgji5rQZ/rK0S
         2JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728519573; x=1729124373;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oEEOIJNVv5T0TeWex13g8S0i310/CeWWhyQlNL8TqA=;
        b=uoAHuryvFjvyzbs0SK3sZJ2mnnClNNBXaPGzakTw3Thwra6yXnUa4EKD86UpLQrl8s
         ZLRLcCGFZ+9PX4MHIbeB3fVVuTdyafFG3aM68a/HEm2Lq64GegevKawKsz4YUi0vsk5P
         bwDZwY0u4jH6BBZ8k+XH9KXg5kUK56zTxRu5idMQiAP94TWkGxiUf7s4+2C1aRuFp9O/
         ifJrkad+pWx4SH90L8p2RIqKV1pgAK3JkdmvmL//FrkgmU+CoyoTN7UTIBxxVDMAuLq5
         iE1F/TF5LqAzQR4wkH+hau8OSatbfdGx6St1iJRDZAfrPcmkDQEtwBUXC08PhAzE1VIo
         WRvw==
X-Forwarded-Encrypted: i=1; AJvYcCV9VoyBI4YaYQ4hQRHYEKcovi0XXxRdOwYyH+KikaOBPF01bKYVW9WgR5FwpKynS73/gFCQd/muUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5hnVKFkOwZWJURKTK3fO5Z8JLX9WQFYAzJ89FmH1lY037fSl
	ghYRN509MFN+Z/rJAhhbe+arnkq+NR1xhx0YHsUKxHjjsM49wu0QYMoE3M10ueg=
X-Google-Smtp-Source: AGHT+IEAOtkGiFzJXWZ7utojQpdMsBfu7PmU0MntDUkwmLoOU+Z0HD8z3hXWDYdA9qJt7EHCM6txxg==
X-Received: by 2002:a05:6a21:3a44:b0:1cf:6c86:231c with SMTP id adf61e73a8af0-1d8a3c3b5e0mr8104461637.26.1728519572988;
        Wed, 09 Oct 2024 17:19:32 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa937b5sm8015b3a.125.2024.10.09.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 17:19:32 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan
 <saravanak@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org
Subject: arm64 s2idle vs. workqueues
Date: Wed, 09 Oct 2024 17:19:31 -0700
Message-ID: <7ho73shkrw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

Looking for some pointers/tips on debugging s2idle, and in particular
why it is not staying in an idle state as long as expected.

I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
AM62x), which doesn't (yet) have any DT defined idle-states, so is just
doing a WFI when idle.

I'm doing an 8-second s2idle with RTC wakeup by using:

  rtcwake -m freeze -s8

and what I see is that 3 of the CPUs stay in their idle state for the
full 8 seconds, but one of them keeps waking due to the A53
arm_arch_timer firing, and processing misc. workqueue related activity
(example work listed below[1].)

I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
the freezer part of suspend to stop/freeze them.  However, I am a bit
surprised to see this non-frozen workqueue activity happening often
enough (few times per second) to prevent all 4 CPUs from being idle for
long periods at the same time, thus preventing a deeper cluster-idle
state.

Is there something else I'm missing that is needed to keep these
workqueues quiet for longer?  I had assumed that most of this workqueue
work would be deferred, and shouldn't need to wakeup a CPU just to run.

In case it's helpful I have published a trace.dat from trace-cmd which
captures power, sched, irq, timer and workqueue events.  With
kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
are all nicely idle for 8 sec while CPU2 is waking due to the timer and
workqueue activity.

Any pointers to how to improve this situation, or what else needs to be
tweaked here would be greatly appreciated,

Thanks,

Kevin


[1]
function, workqueue name
------------------------
- page_pool_release_retry(), "events"
- vmstat_shepherd(), "events"
- vmstat_update(), "mm_percpu_wq"
- crng_reseed(), "events_unbound"
- kfree_rcu_monitor(), "events"
- flush_memcg_stats_dwork(), "events_unbound"
- neigh_managed_work(), "events_power_efficient"
- async_run_entry_fn(), "async"
- deferred_probe_work_func(), "events"
- tcp_orphan_update(), timer expiry

[2] https://drive.google.com/file/d/1U51eTTeb4_13-CZWa2llHXTh9DfZ_4sF/view?usp=sharing

