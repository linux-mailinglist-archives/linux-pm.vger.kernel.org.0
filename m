Return-Path: <linux-pm+bounces-10800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE892ACAC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 01:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7099D2826CA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A214B94E;
	Mon,  8 Jul 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgULJloF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026C3A27B;
	Mon,  8 Jul 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482609; cv=none; b=TpV6krs8P2/+Lr1R8VqKBUUK32kp5jUXxV1W670PSMv2EM61R4bbhneKLFuIQlT2tT2tYwJEyTcvrVmrX8WcYheavEfMW2yT7VrnD5E9PHd3nF4xPclB5p0f+egvODYzz0kKMXkhvtTVpD+sA7QBiy0OWi1jhW/7vI5dg9WIc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482609; c=relaxed/simple;
	bh=9jdW4RDO/F1V/md+tqiw7JFPy3R6Vm6pJq19f3yXpAM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LjQhsz45tYFU+YnhQAhojvyZj+HNcKsv5kE1xqTflS+P6kCtVTsx3suBqvVVEpLtUGX7VRNXXSM5qissKMylS99PI51Mr3DNC3wx1EkJWFKlAfNwxij2NvX7MugbQcQLX9dGfQKl/KdzOE/8lHbZ3HbEGfCNpYBqxPXFqUwyXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgULJloF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAC0C3277B;
	Mon,  8 Jul 2024 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720482609;
	bh=9jdW4RDO/F1V/md+tqiw7JFPy3R6Vm6pJq19f3yXpAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgULJloFLGGkbtNRNWJRp6zMRDqGHp/7uoHjEPeEu/vgsQO3S62QPq4X4dRPla4hg
	 NqyaBf8vHBP6KWrvKJ20R1U59izqIY3FBhSu54KLY5BmI9x+ftpY2LRQxMnnoUP8gN
	 tNwS5ci+genjX6R8DmsvZcgNMuKULwKG4Naq2ivquyBl2PLTDxwSTU+2DXyZKOpMyx
	 NynR5TxBr0Iv/2E3I1bp6E+DoWr75euZPlQkrZGiGfE3SjoYE5DxcRaNyHtrceclSM
	 CuMIw5e4A5loWbY8s++kPT8HTRO6DYCan4SHk6VX8oAnL3bJrDgV8g3Ptdmh477FQT
	 PUhulxAA4NuEg==
Date: Tue, 9 Jul 2024 08:50:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 suleiman@google.com, briannorris@google.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 0/1] PM: sleep: Expose last succeeded resumed
 timestamp in sysfs
Message-Id: <20240709085005.8a348fdfed6afcb8635aea11@kernel.org>
In-Reply-To: <171993028355.95379.9391483220285994310.stgit@mhiramat.roam.corp.google.com>
References: <171993028355.95379.9391483220285994310.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Rafael,

Gentry ping. I would like to hear your comment on it.

Thank you,

On Tue,  2 Jul 2024 23:24:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 8th version of the patch to expose last succeeded resumed
> timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
> The previous version is here.
> 
> https://lore.kernel.org/lkml/170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com/
> 
> This version is just update against for the upstream kernel.
> 
> 
> On some system like the ChromeOS, the system suspend and resume are
> controlled by a power management process. The user-space tasks will be
> noticed the suspend and the resume signal from it.
> To improve the suspend/resume performance and/or to find regressions,
> we would like to know how long the resume processes are taken in kernel
> and in user-space.
> 
> This patch introduces a last succeeded resumed timestamp (just before
> thawing processes) on sysfs which allows us to find when the kernel
> resume process successfully done in MONOTONIC clock. Thus user processes
> can measure the elapsed time taken by its resume process at any point
> in time.
> 
> This will help us to detect abnormal value (longer time) process in
> the resuming and quickly decide the root cause is in the kernel or
> user-space. The kernel side we can use many tools (e.g. printk or
> ftrace) but for user-space we need to define the starting point of
> the resuming process. Actually, the kernel side needs to use local
> clock because the clock subsystem is also suspended. But in that
> case, user space can not use that timestamp because the local clock
> is not exposed.
> 
> So this will be used something like
> 
> where_the_user_space_resume_finish() {
> 	clock_gettime(CLOCK_MONOTONIC, &etime_ts);
> 	fileread("/sys/.../last_success_resume_time", stime);
> 	convert_timespec(stime, &stime_ts);
> 	user_resume_time = timespec_delta(&etime_ts, &stime_ts);
> 	...
> }
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (1):
>       PM: sleep: Expose last succeeded resumed timestamp in sysfs
> 
> 
>  Documentation/ABI/testing/sysfs-power |   11 +++++++++++
>  kernel/power/main.c                   |   28 ++++++++++++++++++++++++++++
>  kernel/power/power.h                  |    1 +
>  kernel/power/suspend.c                |    1 +
>  4 files changed, 41 insertions(+)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

