Return-Path: <linux-pm+bounces-17580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7F9C9500
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87FD1F24321
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87321AF0A6;
	Thu, 14 Nov 2024 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncWveWLR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F71A3AA9
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622170; cv=none; b=CBf0zbAqeA9v0jYkvA2BQEygf4EUcO8rorJenkaCnBcnwG/IjYNlmOjD1Zl6cTvR9t9vCJpQALK+ylCDV7Oh4nLrmcA1NES0+xYbjXUWYVmuOUtQIx4p54ozIvuGFcbb57XKRTfjgIcZqF0MzQT7iHamIWZVtj0VNdXouZ4qSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622170; c=relaxed/simple;
	bh=8Li9dbipRi67x9ritkmAGyqaBXSPwodVtwEZtflJOfE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=u0F+dIJWr82QsNhPRSB1pZEA57WYZKH84mO3zkDAe4PJfAcm1ZXea+xUOGPjI/8t7Rm2Ge8nksblQ/+Wmyzh39nGIUFE3Pg7fInJmoJNQm4QyLPw/57IxyKqzicR9kDovQGcG1laeRhwxse6EiasfL4jqHlc92s3eUQRTMudfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncWveWLR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e381f195051so1070410276.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622168; x=1732226968; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ago2o3UQiq/UvHQifwpLEeZFy32WS/EGuJY0sQIwcHg=;
        b=ncWveWLR98i++CRR53kSnsEcd3VtJyJYJ+cAji8LLjvac2x5VC1Qf9nDbqzMBFhJ5G
         YLU0Qlw7TQhp3I4XtKIFNedqm2bDdeHCA2Y2BXduOtubfqgmDXZHshFmCB1/V443aPqG
         8JV99PrwGeQ+7Xf4RGTI7lP1UZe9eGsG9Y20DK6ruj2MMLKltxadX8/Mly2zYgD9J7Rb
         LOKhOhW0V5pD2fz2XO6njA+GIJFhrLC/uZWV/+EC1wyigoKb9DL67MxWyH8aFlj3FLE2
         6FehysuajvVcSB4POxGR1AoQPx8SlFN0j+DoZjjPcB0HEn3LPI364y1s944o1bU3S9Qb
         Nx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622168; x=1732226968;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ago2o3UQiq/UvHQifwpLEeZFy32WS/EGuJY0sQIwcHg=;
        b=Rzhg8tvgp7yR9lsfHvMKQ/Y3Ah8gxMxGQH+LjfTKq0bRhufkmQ9fNn/XYyH47qCUZV
         IpBY/5NOz89LVaO5scVg9TKERZbcT6uN1ugZfB7smvFvdpQCcFeGSjTnKdt8GOmBtV1e
         h0AJOolfpyexIhyqQDRJxGhND08F7iejvnVQmTQMmK6Fyfbj7dxKmzmiqKcRmjh0gKxg
         sxd93NmSk/r4PCXaOCx/q9Y5i4gAm4rzKVWmBXLc9T3SCvvgXgQTJ7S1OBzzDGh7t7Mh
         daqVlgWt3ubFSDbspj/M0VAcosqgEd9VLrbH0w+YZRzosDYBJXYCiht3AkQnG11olTEz
         FvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxTjTg//fInkJDLq8eovzRFYbosDJCqG3OP/0vn9jRWrj45hx9TF+Aw1gQ3hWGO8N4fyuTVbRMhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmYK/gwhRS+dYdvQW3+B3wRb+C/KurJNhhsnLcfg+GZkUijkQ
	PGGiVdavsMxwFunNBOYTDgeTqu8lBFaRJw5LDuUibjXOVA4B0AoO1m22wdukHUvukBIpVCLXDTo
	Jh4dHO2Ybnxc99g==
X-Google-Smtp-Source: AGHT+IFypZ2XxBScnr7OMU5NLNzJY9RRvPDtshjbm5xyicXj2hqd620PfBLUoZhie2hT/UzPPn8nIzUu60z3CnQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a25:b19d:0:b0:e28:f35b:c719 with SMTP id
 3f1490d57ef6-e382638d1e0mr10195276.6.1731622168088; Thu, 14 Nov 2024 14:09:28
 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:14 -0800
Message-Id: <20241114220921.2529905-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 0/5] Optimize async device suspend/resume
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A lot of the details are in patch 4/5 and 5/5. The summary is that
there's a lot of overhead and wasted work in how async device
suspend/resume is handled today. I talked about this and otther
suspend/resume issues at LPC 2024[1].

You can remove a lot of the overhead by doing a breadth first queuing of
async suspend/resumes. That's what this patch series does. I also
noticed that during resume, because of EAS, we don't use the bigger CPUs
as quickly. This was leading to a lot of scheduling latency and
preemption of runnable threads and increasing the resume latency. So, we
also disable EAS for that tiny period of resume where we know there'll
be a lot of parallelism.

On a Pixel 6, averaging over 100 suspend/resume cycles, this patch
series yields significant improvements:
+---------------------------+-----------+----------------+------------+-------+
| Phase			    | Old full sync | Old full async | New full async |
|			    |		    | 		     | + EAS disabled |
+---------------------------+-----------+----------------+------------+-------+
| Total dpm_suspend*() time |        107 ms |          72 ms |          62 ms |
+---------------------------+-----------+----------------+------------+-------+
| Total dpm_resume*() time  |         75 ms |          90 ms |          61 ms |
+---------------------------+-----------+----------------+------------+-------+
| Sum			    |        182 ms |         162 ms |         123 ms |
+---------------------------+-----------+----------------+------------+-------+

There might be room for some more optimizations in the future, but I'm
keep this patch series simple enough so that it's easier to review and
check that it's not breaking anything. If this series lands and is
stable and no bug reports for a few months, I can work on optimizing
this a bit further.

Thanks,
Saravana
P.S: Cc-ing some usual suspects you might be interested in testing this
out.

[1] - https://lpc.events/event/18/contributions/1845/

Saravana Kannan (5):
  PM: sleep: Fix runtime PM issue in dpm_resume()
  PM: sleep: Remove unnecessary mutex lock when waiting on parent
  PM: sleep: Add helper functions to loop through superior/subordinate
    devs
  PM: sleep: Do breadth first suspend/resume for async suspend/resume
  PM: sleep: Spread out async kworker threads during dpm_resume*()
    phases

 drivers/base/power/main.c | 325 +++++++++++++++++++++++++++++---------
 kernel/power/suspend.c    |  16 ++
 kernel/sched/topology.c   |  13 ++
 3 files changed, 276 insertions(+), 78 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


