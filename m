Return-Path: <linux-pm+bounces-9219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E4909551
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 03:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF3F2856DD
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 01:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC13D60;
	Sat, 15 Jun 2024 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PYbWvkuc"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB761C2E;
	Sat, 15 Jun 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415927; cv=none; b=C2Pc4O2PytQ45JESGspuXf2SjWwRp0PpFjt58KMjbp6m1afuI66lDvABiottkPPGIezuksg75Zi0EE+NT6AAoGHdk62wcJjyYCuSOMtdF2cRTlp7TuHY1nfCEdi0cKdJrSe4QfBQvb5nr6BSlTbo4XAkS4GLsgE3h2shEoFt4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415927; c=relaxed/simple;
	bh=7dVfBiT/JJ48FsOEeTVREWgxZ1AuTVYFkWiXwbQLL/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J03OjpTt8iP8aCNc10zJuJa1Bm0w5ZRHK5XBvXeJSJR3nh4hIDtuBg2X6UKrrc8Y0CmJmEvbse0WxXHF0kb5EclH4l1d7jMNoYJpvYn8yQbTKsRoGKkM2Mm3N/NbLyGx6diyDIAgKTHm2+E+DeBrp1sB62A0kzqCG0je6p9tEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PYbWvkuc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cmiivs9+4WenC6OP/1ZCnI/gkKg1dnHA0OIU4ZJ3byg=; b=PYbWvkucSg2aBQezLwmo+Qcd5e
	buXI3jXr9trafbVS5gAryDT/g51ZN2ZBHJAxUbhpaC2hB7zEs07wi7VegkBqFt449VYmSdHx7elSe
	WogNyhroF0DK54iaxAW50jWdlZDahTiZV5+Ls5WFRE8mrzX+a1Gce1UfgRgk+LFUxWnqraMHJ82U+
	fjuNuq9GYv6VpVV9TPpSg4O/DlYpC/xa6zQU7QS5onXdbc6AjTRUO7+Q+u9isTmIEj0KMnjFgqrDf
	ebusEVDAofzzEFgSzUfwc/6aFrS74znvLxdtqTdMPASh9jObHTMaQX2D8eISlHn4iq1vMo6HzZ/MT
	vTtCcWSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIITp-0000000HUbC-2ox1;
	Sat, 15 Jun 2024 01:45:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38AF1300886; Sat, 15 Jun 2024 03:45:21 +0200 (CEST)
Date: Sat, 15 Jun 2024 03:45:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Xin Li <xin3.li@intel.com>, Kees Cook <keescook@chromium.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Brian Gerst <brgerst@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Imran Khan <imran.f.khan@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	David Vernet <void@manifault.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Message-ID: <20240615014521.GR8774@noisy.programming.kicks-ass.net>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
 <20240615012814.GP8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615012814.GP8774@noisy.programming.kicks-ass.net>

On Sat, Jun 15, 2024 at 03:28:14AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 14, 2024 at 12:48:37PM +0200, Vincent Guittot wrote:

> > The main problem is that need_resched becomes somewhat meaningless
> > because it doesn't  only mean "I need to resched a task" and we have
> > to add more tests around even for those not using polling
> 
> True, however we already had some of that by having the wakeup list,
> that made nr_running less 'reliable'.

Doesn't using !idle_cpu() instead of need_resched() in those balance
paths already do the right thing?

Checking need_resched() as an indicator of it getting work is already a
bit an assumption.

Also, Ingo, idle_cpu() and friends don't really belong in syscalls.c...

