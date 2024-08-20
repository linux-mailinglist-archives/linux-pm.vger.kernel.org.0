Return-Path: <linux-pm+bounces-12572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1F958C53
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEF328381A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D71B3F08;
	Tue, 20 Aug 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="RXtjyE/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79064962C
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171809; cv=none; b=uzRXJhKVgwhBOc1TFrE0d7oRpkJzsX3REAj3IA2c/aRkPbYZHNSHcItWD0Ebg7uSvfnbxOk4tA+IUiFPfgPixZK16qaHnD714WB7YIb8Xv+0zxqCRj2chyxnng5HKZeEo8weJocwCfr+XVorPe+UeSLN0WvDMkRCJ9rx6nEUD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171809; c=relaxed/simple;
	bh=NWGl6xmypDOUzvDbdd6/ZYozVxHaZS6LctziiRw3r/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORxUBjG8Jo5scv0hRw6rgQ0qEe+8eg58MAJK4E0V6/DiqEXk0KWZSZkf5baRHpIsPQbZbNDJKlZiqJ1Utl2fTF6cHLaAIQ0x9vKyDSh7S64VgQmdR8wF/DgTlrQR+OfVPR38f/AydZHvebUtPf7CKpismXhkPZg2R7Gbviyq+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=RXtjyE/P; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so4960634a12.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171805; x=1724776605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOaXaSxe4t1PPDAFFFwKxv22YBKt/FKkTrJcGZpyCM=;
        b=RXtjyE/P3BG/2Se4+wuqZn3Cf+Eru8kvIkt31wZ5fw+B8afAMb7hG0T6xvTJUx7Wbr
         zoUrFjiJiuXtxr9Z+MqmRYNKrAE33RJh8GhoPs+yEgDPvAU4HjxwxnBEsrBhvm1Op+iB
         MsqB62OBwp60MSPF6566vcj9AsfrPUInlpHhmjdyA3tAV9AUUITrl1T3f/ZD4SiGfbu/
         6uWsY2WyLKUEJeUMedut17OPFs4qjrtj+z/bBKEb4YGQrewhdnn2JJwzhLS+6xFmNgbn
         m2fv1pOjeajBEdvplOIEsRIkAhMWh66E/XSeviooXq6y/lUHoDntlNRhxiwvaPQgOuOb
         Ek6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171805; x=1724776605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlOaXaSxe4t1PPDAFFFwKxv22YBKt/FKkTrJcGZpyCM=;
        b=o6vHk1sLOYUXOLR6wNrKFKdTvyZW4oJ65U6hoGg1s5IjR4J8z1pFjsXMxZWcWpyJt9
         9DJZIWfUor6lS9ApDj0pWH7cso30eVA41D5+f0vAN16m7BBLPEF5So+7nWGEH5WaCI/3
         XNDS5ZHor2SNsJ7oOpsl1FyH4fpMduCVdAR5wBu/d2RrZKyEPNsBTQx7boHL33DABGQL
         NAufRHpOz2MxkmLgbuD1OeHsdasPAJKJ5lSyhW2T2i96Jjg7hEn0B1D8wTBy5yy7mpVL
         hEtEkfiBkypoD7NNmsfwEvAk6MGOAg/aXbqR7SNOs8NNxkf/7lpzJ0tMXAZv0jzaDjTk
         wCkw==
X-Forwarded-Encrypted: i=1; AJvYcCXvtOdvLDKBLXIx9N/zcdQeI0Vp3t1INzhaUHBoOzr2vWSVCLKI4r4u1myM0f54zWwqbSoGQvGJXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjm4Vd69XLM9B3DQL7aSI7eTYnaeRyvOPYVdHBN+G4oVYBw/I7
	yhcVJAgsZZp1/xatA7YGQTj38x7TsLlbtTs/+Nt+RlTPJG0FLYUCyA1C/5gYANw=
X-Google-Smtp-Source: AGHT+IGd0lN/68+It+jeiTE+VFnqKtHnby+yBIZv2MbicBv5kJa2yRauuDHdIXSJbNXUDYwoNgDzbA==
X-Received: by 2002:a17:907:c7d7:b0:a7a:be06:d8e3 with SMTP id a640c23a62f3a-a8392a22287mr1003338666b.46.1724171805332;
        Tue, 20 Aug 2024 09:36:45 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:44 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 08/16] sched/fair: Extend util_est to improve rampup time
Date: Tue, 20 Aug 2024 17:35:04 +0100
Message-Id: <20240820163512.1096301-9-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Utilization invariance can cause big delays. When tasks are running,
accumulate non-invairiant version of utilization to help tasks to settle
down to their new util_avg values faster.

Keep track of delta_exec during runnable across activations to help
update util_est for a long running task accurately. util_est shoudl
still behave the same at enqueue/dequeue.

Before this patch the a busy task tamping up would experience the
following transitions, running on M1 Mac Mini

                            rampup-6338 util_avg running
     ┌─────────────────────────────────────────────────────────────────────────┐
986.0┤                                                               ▄▄▄▄▄▟▀▀▀▀│
     │                                                        ▗▄▄▟▀▀▀▘         │
     │                                                    ▗▄▟▀▀                │
     │                                                 ▄▟▀▀                    │
739.5┤                                              ▄▟▀▘                       │
     │                                           ▗▄▛▘                          │
     │                                         ▗▟▀                             │
493.0┤                                       ▗▛▀                               │
     │                                    ▗▄▛▀                                 │
     │                                  ▄▟▀                                    │
     │                                ▄▛▘                                      │
246.5┤                             ▗▟▀▘                                        │
     │                          ▄▟▀▀                                           │
     │                      ▗▄▄▛▘                                              │
     │                 ▗▄▄▄▟▀                                                  │
  0.0┤  ▗         ▗▄▄▟▀▀                                                       │
     └┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬┘
    1.700   1.733   1.767   1.800   1.833   1.867   1.900   1.933   1.967 2.000

───────────────── rampup-6338 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
36.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
57.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
78.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
98.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
117.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
137.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
156.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
191.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
211.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
230.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
248.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
266.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
277.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
294.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.6
311.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.4
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
340.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
358.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
371.0 ▇▇▇▇▇▇▇▇▇ 1.0
377.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
389.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
401.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
413.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
431.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
442.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
456.0 ▇▇▇▇▇▇▇▇▇ 1.0

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU0.0 ▇▇▇▇▇ 90.39
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1156.93

                            6338 rampup CPU0.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                                ▛▀▀                                       │
    │                                ▌                                         │
    │                                ▌                                         │
    │                                ▌                                         │
1.70┤                             ▛▀▀▘                                         │
    │                             ▌                                            │
    │                             ▌                                            │
1.33┤                         ▗▄▄▄▌                                            │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.97┤                     ▗▄▄▄▟                                                │
    │                     ▐                                                    │
    │                     ▐                                                    │
    │                     ▐                                                    │
0.60┤  ▗         ▗▄▄▄▄▄▄▄▄▟                                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            6338 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.20┤                                                    ▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                    ▐                     │
    │                                                  ▛▀▀                     │
    │                                                  ▌                       │
2.78┤                                               ▐▀▀▘                       │
    │                                             ▗▄▟                          │
    │                                             ▌                            │
2.35┤                                          ▗▄▄▌                            │
    │                                          ▐                               │
    │                                        ▄▄▟                               │
    │                                        ▌                                 │
1.93┤                                     ▗▄▄▌                                 │
    │                                     ▐                                    │
    │                                     ▐                                    │
    │                                     ▐                                    │
1.50┤                                  ▗▄▄▟                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────── 6338 rampup CPU0.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 37.300000000000004
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1

───────────────── 6338 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇▇▇▇▇▇ 11.9
1.956 ▇▇▇▇▇▇▇▇ 10.0
2.184 ▇▇▇▇▇▇▇▇ 10.0
2.388 ▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇ 10.0
2.772 ▇▇▇▇▇▇▇▇ 10.0
2.988 ▇▇▇▇▇▇▇▇ 10.0
3.204 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 85.3

After the patch the response is improved to rampup frequencies faster
and migrate from little quicker

                           rampup-2234 util_avg running
   ┌───────────────────────────────────────────────────────────────────────────┐
984┤                                                                ▗▄▄▄▄▄▛▀▀▀▀│
   │                                                          ▄▄▟▀▀▀▀          │
   │                                                     ▄▄▟▀▀                 │
   │                                                  ▄▟▀▘                     │
738┤                                               ▄▟▀▘                        │
   │                                            ▗▟▀▘                           │
   │                                          ▗▟▀                              │
492┤                                        ▗▟▀                                │
   │                                      ▗▟▀                                  │
   │                                     ▟▀                                    │
   │                                   ▄▛▘                                     │
246┤                                 ▗▟▘                                       │
   │                               ▗▟▀                                         │
   │                             ▗▟▀                                           │
   │                           ▗▟▀                                             │
  0┤                       ▄▄▄▛▀                                               │
   └┬───────┬───────┬────────┬───────┬───────┬───────┬────────┬───────┬───────┬┘
  1.700   1.733   1.767    1.800   1.833   1.867   1.900    1.933   1.967 2.000

───────────────── rampup-2234 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.6000000000000005
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
39.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
61.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
85.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
99.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
120.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
144.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
160.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
192.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
210.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
228.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
246.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
263.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
282.0 ▇▇▇▇▇▇▇ 1.0
291.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
309.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
344.0 ▇▇▇▇▇▇▇ 1.0
354.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
373.0 ▇▇▇▇▇▇▇ 1.0
382.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
400.0 ▇▇▇▇▇▇▇ 1.0
408.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
425.0 ▇▇▇▇▇▇▇ 1.0
434.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
452.0 ▇▇▇▇▇▇▇ 1.0

                            2234 rampup CPU1.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                             ▐▀                                           │
    │                             ▐                                            │
    │                             ▐                                            │
    │                             ▐                                            │
1.70┤                            ▛▀                                            │
    │                            ▌                                             │
    │                            ▌                                             │
1.33┤                           ▄▌                                             │
    │                           ▌                                              │
    │                           ▌                                              │
    │                           ▌                                              │
0.97┤                         ▗▄▌                                              │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.60┤                      ▗▄▄▟                                                │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            2234 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.10┤                                                            ▐▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                 ▛▀▀▀▀▀▀▀▀▀▀▀             │
    │                                                 ▌                        │
    │                                            ▐▀▀▀▀▘                        │
2.70┤                                            ▐                             │
    │                                        ▐▀▀▀▀                             │
    │                                        ▐                                 │
2.30┤                                      ▛▀▀                                 │
    │                                      ▌                                   │
    │                                   ▐▀▀▘                                   │
    │                                   ▐                                      │
1.90┤                                 ▐▀▀                                      │
    │                                 ▐                                        │
    │                               ▗▄▟                                        │
    │                               ▐                                          │
1.50┤                              ▗▟                                          │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU1.0 ▇▇▇▇ 32.53
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 540.3

───────────────── 2234 rampup CPU1.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 6.5
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.7
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.8

───────────────── 2234 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇ 4.0
1.728 ▇▇▇▇▇▇▇▇▇▇ 8.0
1.956 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.184 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.388 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 16.0
2.772 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 18.0
2.988 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 47.0
3.096 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 53.4

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 43 +++++++++++++++++++++++++++++++------------
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e..8db8f4085d84 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -544,6 +544,7 @@ struct sched_entity {
 	unsigned int			on_rq;
 
 	u64				exec_start;
+	u64				delta_exec;
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7099e40cc8bd..e2b4b87ec2b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4318,6 +4318,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 	p->se.on_rq			= 0;
 	p->se.exec_start		= 0;
+	p->se.delta_exec		= 0;
 	p->se.sum_exec_runtime		= 0;
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5e986af18dc..a6421e4032c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1118,6 +1118,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 
 	curr->exec_start = now;
 	curr->sum_exec_runtime += delta_exec;
+	curr->delta_exec = delta_exec;
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
@@ -1126,7 +1127,6 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-
 	return delta_exec;
 }
 
@@ -4890,16 +4890,20 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/*
-	 * Skip update of task's estimated utilization when the task has not
-	 * yet completed an activation, e.g. being migrated.
-	 */
-	if (!task_sleep)
-		return;
-
 	/* Get current estimate of utilization */
 	ewma = READ_ONCE(p->se.avg.util_est);
 
+	/*
+	 * If a task is running, update util_est ignoring utilization
+	 * invariance so that if the task suddenly becomes busy we will rampup
+	 * quickly to settle down to our new util_avg.
+	 */
+	if (!task_sleep) {
+		ewma &= ~UTIL_AVG_UNCHANGED;
+		ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
+		goto done;
+	}
+
 	/*
 	 * If the PELT values haven't changed since enqueue time,
 	 * skip the util_est update.
@@ -4968,6 +4972,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline void util_est_update_running(struct cfs_rq *cfs_rq,
+					   struct task_struct *p)
+{
+	util_est_dequeue(cfs_rq, p);
+	util_est_update(cfs_rq, p, false);
+	util_est_enqueue(cfs_rq, p);
+}
+
 static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
@@ -5164,13 +5176,13 @@ static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 
 static inline void
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
-
 static inline void
 util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
-
 static inline void
-util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
-		bool task_sleep) {}
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep) {}
+static inline void
+util_est_update_running(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
@@ -6906,6 +6918,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (task_sleep)
+		p->se.delta_exec = 0;
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8546,6 +8560,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		set_next_entity(cfs_rq, se);
 	}
 
+	if (prev->on_rq)
+		util_est_update_running(&rq->cfs, prev);
+
 	goto done;
 simple:
 #endif
@@ -12710,6 +12727,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	util_est_update_running(&rq->cfs, curr);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-- 
2.34.1


