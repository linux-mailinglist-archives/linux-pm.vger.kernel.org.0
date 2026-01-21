Return-Path: <linux-pm+bounces-41243-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJg3B2opcWniewAAu9opvQ
	(envelope-from <linux-pm+bounces-41243-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 20:30:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD005C33C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 20:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D342042ECC8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA7275AEB;
	Wed, 21 Jan 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4zQlP9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C3205E26;
	Wed, 21 Jan 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014531; cv=none; b=FmPtyaDNNCqlvyBAOT3MTl754fXZLYG2hNg7OwUnEApJ8sajKGn9CLpgZY5s1oeEHlNT7Lz3OzkD6jsUCryBNq1oZ1fIsmmYzyfxx7JR3XXR3DnN7vvVNtB5QaIpmDfbXu3lmvTEaDt+dUfgv3AUr3lVg9Hm+jNll1RH+wlhFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014531; c=relaxed/simple;
	bh=mxuQx8myh37sFEu9+vJLmpyCKKaNhjPDjdia8zaYzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLUduW0qf+1XzsQLomfF3gGkeRJOO71FsB9a6SvbJODGTiMRpW1MF0VtAyAR3trvnsrU6oJSFQ+Dvk4Rd5b9VretB5a6JS4FY+O8rQ/XB6LkqVN4tCYoYCtbJ9eKCsWCRLCytbTu25PrWShpysst/tm09xAQYylyzkoaI4D7MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4zQlP9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F892C4CEF1;
	Wed, 21 Jan 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014531;
	bh=mxuQx8myh37sFEu9+vJLmpyCKKaNhjPDjdia8zaYzsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4zQlP9qJjB6AQvf49Y9Ufsh9lLsJ6bgZDrju7360I1I550ZnhpWAwEhlEoR9En0J
	 y6/+oLJdJnMdYltuM3MRou3lpBFM3dQjjN6PzEResWJIqV+XkmAk4eyCJq2+1ZLjyD
	 aQLh3joSmHc4hig6Ewwj3u3Tl6EQRXKppt8VR+cgGDTQdrlYJVRKNFZqvklqakPBWY
	 OWXFLzFKVuyDHwqGzad53oDQuURAzIfzlqt4EtTh8VHFtXd/0GY3pZh+ePdP1ub/q3
	 F4FRPA0IyGS9x8qxwRk/fYy0I+TKHGub9a3Sp7PBRLyZBWkY/dcH8M84Au0PkruVH+
	 OEqS1sr2cxlOg==
Date: Wed, 21 Jan 2026 17:55:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <aXEE_5vT03dlTCyN@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <aWpRxyt8HuXkSuxs@localhost.localdomain>
 <a4037857-b161-4536-9a2e-2cf4c168736d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4037857-b161-4536-9a2e-2cf4c168736d@linux.ibm.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41243-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,goodmis.org,google.com,ellerman.id.au,redhat.com,linaro.org,163.com,linux.ibm.com,suse.de,siemens.com,lists.ozlabs.org,arm.com,nvidia.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 0AD005C33C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Tue, Jan 20, 2026 at 06:12:08PM +0530, Shrikanth Hegde a écrit :
> 
> Hi Frederic.
> 
> On 1/16/26 8:27 PM, Frederic Weisbecker wrote:
> > I forgot to mention I haven't yet tested CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > (s390 and powerpc).
> > 
> > Thanks.
> 
> 
> tl;dr
> 
> I ran this on powerNV(Non virtualized) with 144 CPUs with below config. (default ones)
> Patch *breaks* the cpu idle stats most of the time. idle values are wrong.

Right I somehow lost the TS_FLAG_INIDLE setting in tick_nohz_idle_enter(),
which ruins the whole thing.

You probably think I should have detected that with light testing and you're
right. Not checking dmesg was a bit sloppy from my end...

I'm fixing that and will send a v2 soonish.

Thanks a lot for testing!

-- 
Frederic Weisbecker
SUSE Labs

