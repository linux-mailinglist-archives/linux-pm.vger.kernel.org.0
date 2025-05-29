Return-Path: <linux-pm+bounces-27800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3016AC7A74
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA8D3BD5A6
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363821B9E1;
	Thu, 29 May 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMPLC4n/"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AB347B4;
	Thu, 29 May 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508853; cv=none; b=HqWFYEtDrNIJC9/XtEuDqBBJ1LvXa1BgsbHGVATFNP3pLQFZpVJNyEoSrqM5fYuSkt3juLtFA+8KqWB97yGbnWBxsfQLXantfpeIE2TwYBp5lU3IRWhZI/Lm8KW0+IwGqEWTSM1S2Kf5tIJnlsp3rFUQaD/vh5gFdb2VP8AkjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508853; c=relaxed/simple;
	bh=WDxv2j8hLFwbgNu+HkSYh8bKjpv1x8FKIC4QbwCa63A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ8v5h7G8a4zg0vznXB5GueCOls4Ew0iLjUUKUMhhq6NUBQoLhaT1frshMvol81yqEMaqO2iVwjcH7G6C7SgnHcjGm51nNTsYeOky81ORNjbu0g5wr5N8zrf8gFu9EQEtAOhpyB13dEjw7L4g3AzV9bh742kakEpzDt432ZsFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VMPLC4n/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hN1kbETS3aGUaklzGKMpRd++J1JSJtz4mhvGfXe5618=; b=VMPLC4n/9VoWqhO8poGd7oa+c+
	SSFvqyJgZ8PZrr4Kupuv/AWaXgpEchVka98Qyj49NCl9n1eHXAVnzhaNUtduyjTVPa8ehHnoKiCPz
	AVvLjyz+FIfuADWy4yhJkDJuNjwyw0ZO0f4tlycc1Z+8BmX8uOD8qML3nOd4l4OA3F+S6W0TEAU5a
	xLlR8M7F/M7rsnI0Y7meibEzyoBC38oq43P7OoIYZyDtPm8akpbpBF8UBOkiRqBTCm1N+6D3Wfr9l
	YVi/HUBhzCcJ/5WC4MAHZ4qu3LMyScCACzh75w4cl+9YrNCyGHFc5dyYmd9ITnuhwJY4yoBtWjMcQ
	d/QyWvkQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZ1T-000000006sL-1Wf9;
	Thu, 29 May 2025 08:53:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7227730057C; Thu, 29 May 2025 10:53:58 +0200 (CEST)
Date: Thu, 29 May 2025 10:53:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	x86 Maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by
 commit 96040f7273e2
Message-ID: <20250529085358.GY24938@noisy.programming.kicks-ass.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
 <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
 <20250528160523.GE39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>

On Wed, May 28, 2025 at 07:09:21PM +0200, Rafael J. Wysocki wrote:

> And I object to leaving a user-visible regression behind.

So we go fix it differently. 

Why can't we initialize cpuidle before SMP bringup?

