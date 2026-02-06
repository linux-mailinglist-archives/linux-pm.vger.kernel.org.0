Return-Path: <linux-pm+bounces-42241-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QISXJqlshmlaNAQAu9opvQ
	(envelope-from <linux-pm+bounces-42241-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 23:35:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A2103D74
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8DD1301A513
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B42BEFFE;
	Fri,  6 Feb 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2SVvC/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EE1E86E;
	Fri,  6 Feb 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417317; cv=none; b=V8ZJbOlVOg2yr17LCl/O9sF95lWLNBAY4OAoAniwikZSttCPc8FzlxOzYtjfY0OU5NdJYSq7Da02hL7y5PEXCBql1rAUd9nClQXREtUPKOK6U07h93vlLcqTKiQwNJrqps0RtfypzaJlp19b4Nkiv0R7QcOUHytnWHunNW8KLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417317; c=relaxed/simple;
	bh=pCN1+Vk7aDCoWI7wtIHCxSIf8mtraNIBweDErysiq/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qamMvOxMAv31xAHjoj2gdeZ9oyIa4CgrmxpTg5dt+uvu+SR9A8HKl1YtamGARiMIZS0P1dJJ2K/jcCQ4e05g1+GG8Adczv7dgoXI5DMuV6FDeFnFXtW2NpLvjZc0wNcreRa8KSQFaPuGv0ap5okwUqV/zjnUjLQp3aMiy7Rta8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2SVvC/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB67C116C6;
	Fri,  6 Feb 2026 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770417317;
	bh=pCN1+Vk7aDCoWI7wtIHCxSIf8mtraNIBweDErysiq/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2SVvC/9neUKjwY9SuJQZzfGdjfayUl+p9mdM5bYYOyQyUI750s7pRb3O4VmhwWvf
	 rpReglSno/G6AbwA9t6nP+/kvP8u/xyit/sw3KwGGS/ZHc7gP18inMvT7Nvjhp7wo2
	 /6sNy0nKHOunh6ramFJrLHeCvt6QsRPPUWZZsdSGiQ3CjelpYWCqi6ezYUNlXwrQOw
	 TAkX3Quvnx1lxFLNQxEmWLe5Ge6rbAIluUugpHPmsfLSeq4KedxNq4CjdA/CFUexDs
	 NHAwPdZnkXnJ1DnMnnfffHCK6wj2cojO32tXyZsM+4Ur/INBmaD0GXlZOM4u7vZFhs
	 H1hUFKRQAlfWA==
Date: Fri, 6 Feb 2026 23:35:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH 12/15] tick/sched: Consolidate idle time fetching APIs
Message-ID: <aYZsol2OIzMxoJXv@pavilion.home>
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-13-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206142245.58987-13-frederic@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42241-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 182A2103D74
X-Rspamd-Action: no action

Le Fri, Feb 06, 2026 at 03:22:42PM +0100, Frederic Weisbecker a écrit :
> +static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
> +				 bool compute_delta, u64 *last_update_time)
> +{
> +	ktime_t now = ktime_get();
> +	u64 res;
> +
> +	if (vtime_generic_enabled_cpu(cpu))
> +		res = kcpustat_field(idx, cpu);
> +	else
> +		res = kcpustat_field_dyntick(cpu, idx, compute_delta, now);
> +
> +	do_div(res, NSEC_PER_USEC);
> +
> +	if (last_update_time)
> +		*last_update_time = res;

Urgh, this should be *last_update_time = ktime_to_us(now)

-- 
Frederic Weisbecker
SUSE Labs

