Return-Path: <linux-pm+bounces-41025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B9DD33129
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A5D130A54D1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CD3933FD;
	Fri, 16 Jan 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1RwDlWF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86EA1E7C34;
	Fri, 16 Jan 2026 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575435; cv=none; b=VLMLHZXYSk86z9qmU/x70vi0ZJp1o8T1bvzvhKAH1rPVCXslalf5QcGNdb25FDry+6KOMJQCgr1DV9k8cUq3PImHXJ3pH/DxJW9F4YrT7WxQNkMuba6YdUpgLvDsGFYLaeNkE6AC9765wNcFtQRzHwUgF3iPz4jg1rN6etqc9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575435; c=relaxed/simple;
	bh=MaxWatC6BXDD9MxNLBGBdUdv+FaJKviCzEvHGFX/ndU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1j0NTTRMif7Ju4zs+ytoyaJT5gdGMdNPPFKyy/s3wFeE59SVN0U6a1U2u4u1TKzPl59rARt5EmasIm87NXblGeijUqSJ/fRYwIfvE8ylADBqOUgmuYBMMHu76k7CzIuAxoQpjLE+CcG0Lvw95f9fn9982wkDREqjDffJezMiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1RwDlWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23473C116C6;
	Fri, 16 Jan 2026 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575434;
	bh=MaxWatC6BXDD9MxNLBGBdUdv+FaJKviCzEvHGFX/ndU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1RwDlWF4zmzyFZbSx5OidA/+WFRcuq22Me/qt7d0WzVBLoMhOI0t+l6v0daYAatm
	 953IxDldYcPn7EkgpHIDFA7QU0DlFZqoyuTDFzwqqTZO7oGf5g3UOjc684CSh6cLkM
	 pk3Iy2EQx7aOjiXCS9sKoO+Tn0LnZzKJJnfKRyUl6qDhwoxJfNxNIDKkWELwamyqOB
	 CDY5kLMmbmGp2XbeQWlj7Mvwhp8JSjZOlwE0uRPq7pFkQz2NVGVSgiD0cVvBUu8+VF
	 xXLXhxDgxWK/+c9YOxkbYJ9KoAp3rcXvzXLCZDRM4rzHixmMN+84JKTwAgr/ZMCIHA
	 Wqet92hhJ6A3w==
Date: Fri, 16 Jan 2026 15:57:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linuxppc-dev@lists.ozlabs.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-pm@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-s390@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/15] tick/sched: Refactor idle cputime accounting
Message-ID: <aWpRxyt8HuXkSuxs@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-1-frederic@kernel.org>

I forgot to mention I haven't yet tested CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
(s390 and powerpc).

Thanks.

