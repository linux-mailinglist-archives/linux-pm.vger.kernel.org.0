Return-Path: <linux-pm+bounces-21853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D395DA31428
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0551888128
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238A1E5B61;
	Tue, 11 Feb 2025 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl+DX5ig"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EC3BB54;
	Tue, 11 Feb 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298935; cv=none; b=ZQHKZCxuZ05q5NMIdWr1ZG0eJikrFMYcr/asGWZ3RN3eP0u76F6sKlHIILdJ0J3aSJO4AJ4nOowavaB4w4XFqrm2xPnlGMLN171gIFdQWu1K6A8eGm5lyWmTiX9obHMGY9ddN0jbyS7mWHzfwDBqeIvsTlBmgr4RwuvBxNMTZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298935; c=relaxed/simple;
	bh=/GDgxa2V50tFPQOr9OXJ/5PrkxuGxrhpmwMTgMzj/T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uc1Eo9DIEdZkhEjCJqSXlSC1r59vNi9OeQo5y0fo5OlU4g9pWH+XNEPYevE1uMUsEFxwfFwJpZUKQSioUPBbZTtitqdl+jmXe9I4qWsWj1TKja2HKV5th6xnC5mcoA4PXuW32jeREpVrdVY+99bqY9TkXZN2fQpbC/xNiejMW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl+DX5ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A7C4CEDD;
	Tue, 11 Feb 2025 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739298933;
	bh=/GDgxa2V50tFPQOr9OXJ/5PrkxuGxrhpmwMTgMzj/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kl+DX5igmocajTRVwBOsdZaBjIkP6B6H3j2G+72XnR5gu5LDvnJzhET+0Vb1TMSD6
	 A2JJP0TP1FLV+XAsv0hHXSjSVvmEa9pb6Aq69DOXfje6W4aQvorDhKm+HheB9iwZk0
	 HuKXXpkcwLgd97YlZP+3rVJgybJj/l5FR2DN9O8+m+fzpo18vRtEJF4U3KODj2pDqk
	 5Y4+pUbVH2gHNtjDAj9Di2bjvymszhio/t1iBscgngU+cs1w6NolRNEgvJOkRh/XYU
	 fLOI0ULS1WWzZnBE83kphBPURC+LTNVtCov0hoitU4GLBR2kBgB0FgKhKc+Y6s6q+5
	 vUSGvKMQjmT/A==
From: SeongJae Park <sj@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: SeongJae Park <sj@kernel.org>,
	"Naresh Kamboju" <naresh.kamboju@linaro.org>,
	"open list" <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	"Linux PM" <linux-pm@vger.kernel.org>,
	rcu <rcu@vger.kernel.org>,
	"LTP List" <ltp@lists.linux.it>,
	"Linux Regressions" <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Vincent Guittot" <vincent.guittot@linaro.org>,
	"Daniel Lezcano" <daniel.lezcano@linaro.org>,
	"Dan Carpenter" <dan.carpenter@linaro.org>,
	"Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: next-20250210: WARNING: at include/linux/rwsem.h:85 madvise_unlock
Date: Tue, 11 Feb 2025 10:35:31 -0800
Message-Id: <20250211183531.4359-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <fa1a7a10-f892-4e7e-acb4-0b058aa53d88@app.fastmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Feb 2025 10:32:55 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Feb 11, 2025, at 10:23, Naresh Kamboju wrote:
> > Regressions on arm64 Juno-r2 device while running LTP syscalls tests
> > madvise01 warnings on the Linux next-20250210 tag.
> >
> > First seen on next-20250210
> > Good: next-20250207
> > Bad: next-20250210
> 
> Cc SeongJae Park <sj@kernel.org>
[...]
> This is mmap_write_unlock() triggering
> rwsem_assert_held_write(&mm->mmap_lock);
> 
> That code was changed in these commits:
> 
> 415553982a1e mm-madvise-remove-redundant-mmap_lock-operations-from-process_madvise-fix
> ec68fbd9e99f mm/madvise: remove redundant mmap_lock operations from process_madvise()
> f19c9d7b57cf mm/madvise: split out madvise() behavior execution
> a4d5a73cdc14 mm/madvise: split out madvise input validity check
> 948a0a9ea070 mm/madvise: split out mmap locking operations for madvise()
> 
> You could try reverting them to see if that fixes it again.

Thank you for kindly Cc-ing me and further providing this nice information,
Arnd!  I posted a fix and continuing discussion there:
https://lore.kernel.org/20250211063201.5106-1-sj@kernel.org


Thanks,
SJ

[...]

