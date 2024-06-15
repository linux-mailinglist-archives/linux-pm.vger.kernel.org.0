Return-Path: <linux-pm+bounces-9218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D51909549
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 03:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF671C21712
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 01:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C41FBA;
	Sat, 15 Jun 2024 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BG9EAzL4"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D94683;
	Sat, 15 Jun 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415790; cv=none; b=hyTX2bs2b2s30EIKJQ5nivWGUwQM3lJzBqeSb+L0o1GhXCXQZbob2FJMRrNHWMZi6gwj7UISuocwva1ynsGRkO+i2K53zoCMdj489uROOC5ceXEIKxeHu37XpGnuJtqGKz1WzjDSNl7N6z/PhGpLtrxgylWJNt3DN5AYsYH94Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415790; c=relaxed/simple;
	bh=8Zinys3yZee54O7Jb/EuJVXbITn3qoh6d5kKIUE3bw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo63CUpaqKlLzdiuoLV8qrctK5SYT+HMCHHPVCQzSqPwagxRC2S5mclt8QPE2UT7DWuJpVCTHmcZMz5mSNO7fLrZ/qF3hxuU2eOrXrDdT+zeGzZ/G+jO+dgFZmNSepf1j4DaKN5mNFoKF14xjSc/t4A/j/IYjqnO5BicX6eEHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BG9EAzL4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JLTvDV1lNU9XfbpR4Y9KnupD1/9SE9kaeQL+4/ORc5U=; b=BG9EAzL4aNe5yXJ8hUlpJr41e2
	JLmkcwHOSWQpGdf0kCw978PqipCPe5wQqcQYPoTGj5qdH2BjLO25E0I5Xbmuxh7ras6sH5320jBTm
	3ccSVJvWPlOy+8vvwHxDkulKaq+0SdGAZWJst1q9monnCJS8aZ28oGoMDGTo9Tl+bgTbuHmTvuO2P
	TI+IYMfifnbJQlH8/a2+n/YaYq26qvQgQ17tUfDlS6sfPw6xtPsBDwmIN9QHzpgcZspjz1TcJpyVh
	OniE5Iu5C4JJkjb2MKxFjs0W+59zRyHx0N5qBEUaRjm0PVow6X91bGKmnKok4GdGkxX44dC78EvW0
	vYM65rEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIIRV-0000000HUXc-1Tx0;
	Sat, 15 Jun 2024 01:43:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4982300886; Sat, 15 Jun 2024 03:42:56 +0200 (CEST)
Date: Sat, 15 Jun 2024 03:42:56 +0200
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
Message-ID: <20240615014256.GQ8774@noisy.programming.kicks-ass.net>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>

On Fri, Jun 14, 2024 at 12:48:37PM +0200, Vincent Guittot wrote:

> The main problem is that need_resched becomes somewhat meaningless
> because it doesn't  only mean "I need to resched a task" and we have
> to add more tests around even for those not using polling

The converse problem is that you're adding a bunch of atomic ops that
might be avoided.

It might now need to set both the RESCHED and IPI flags -- and clear
them again.


