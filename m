Return-Path: <linux-pm+bounces-19336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09819F38D6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC44E188633D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9142066E0;
	Mon, 16 Dec 2024 18:21:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFD20457E;
	Mon, 16 Dec 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373295; cv=none; b=RUfxuG0aXdTrtob4+rZohWC2MrGIQYIaWYaDuSbGaQ8A9im9MW5qDrJgJaAEJVpW3ekVRaMTfpXGZCXF+m+5tzOScJfyAeAqIItpko9hLFfniKIQYdG2vmYJJ/m6/BDqIYoUGLIDNGtvT4PA5pXHdPYbtTPNsQ4Snz23Znhk0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373295; c=relaxed/simple;
	bh=evREqE1njeUYk2+Y7GUeTOFW7dF6u/bz8AaPFd+OfYA=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=IpUhasR24caL5hbz4TvfZo94fNJuuvq1FZcwLInCFh1JMNeAURcUU7UuJ85BBfndKBmAAiNArvyjr5ThTcHdwInuOQsXXXP4IRbUbVvwJYZB0N0P5wlBmkzkdZoNo8yqxt+DVG6iydGnyLG5R7+WXLZUoFUa3DQOngWU+O2PkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35192)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNFil-004lrv-IE; Mon, 16 Dec 2024 11:21:31 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:49960 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNFik-00FtDO-Lx; Mon, 16 Dec 2024 11:21:31 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ming Lei <ming.lei@redhat.com>,  LKML
 <linux-kernel@vger.kernel.org>,  Linux PM <linux-pm@vger.kernel.org>,
  Kexec Mailing List <kexec@lists.infradead.org>
References: <4968818.GXAFRqVoOG@rjwysocki.net>
	<d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
	<87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
	<E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
Date: Mon, 16 Dec 2024 12:21:01 -0600
In-Reply-To: <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org> (David
	Woodhouse's message of "Mon, 16 Dec 2024 18:14:17 +0000")
Message-ID: <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tNFik-00FtDO-Lx;;;mid=<87bjxbzdyq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+z7hsfZYbh2h99As8mJSOdcZfr7Fg2uXQ=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4471]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Woodhouse <dwmw2@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 316 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (3.4%), b_tie_ro: 9 (3.0%), parse: 1.40 (0.4%),
	 extract_message_metadata: 18 (5.7%), get_uri_detail_list: 1.43 (0.5%),
	 tests_pri_-2000: 22 (7.0%), tests_pri_-1000: 3.7 (1.2%),
	tests_pri_-950: 1.60 (0.5%), tests_pri_-900: 1.02 (0.3%),
	tests_pri_-90: 77 (24.3%), check_bayes: 75 (23.8%), b_tokenize: 9
	(2.8%), b_tok_get_all: 17 (5.5%), b_comp_prob: 2.1 (0.7%),
	b_tok_touch_all: 43 (13.6%), b_finish: 0.87 (0.3%), tests_pri_0: 167
	(52.8%), check_dkim_signature: 0.50 (0.2%), check_dkim_adsp: 3.2
	(1.0%), poll_dns_idle: 1.16 (0.4%), tests_pri_10: 2.1 (0.7%),
	tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Does anyone actually use KEXEC_JUMP?
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, dwmw2@infradead.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

David Woodhouse <dwmw2@infradead.org> writes:

> It isn't broken. I know of it being used a few million times a week.
>
> There are corner cases which have never worked right, like the callee
> putting a different return address for its next invocation, on the
> stack *above* the address it 'ret's to. Which since the first kjump
> patch has been the first word of the page *after* the swap page (and
> is now fixed in my tree). But fundamentally it *does* work.
>
> I only started messing with it because I was working on
> relocate_kernel() and needed to write a test case for it; the fact
> that I know of it being used in production is actually just a
> coincidence.

Cool.  I had the sense that the original developer never got around
to using it, so I figured I should check.

Mind if I ask what you know of it being used for?

I had imagined it might be a way to call firmware code preventing the
need to code of a specific interface for each type of firmware.

Eric


