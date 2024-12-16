Return-Path: <linux-pm+bounces-19318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23F9F3526
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 17:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFB1164160
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F653E23;
	Mon, 16 Dec 2024 16:00:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049D17591;
	Mon, 16 Dec 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364843; cv=none; b=YSo1LKH2Uq824iCGWPs97GsDHMfXmytmiXdsEmOWvVy8oX7r0Mpvzd9C/y/ge+lpn+iIWmhb02L3YjSmTke8M8I341NbEyFzoZRdK/1nI6gSOXULxYs9XG4D62sN1NHRRzJjeW6XaUgLb5gMGEXBjNb0ZFI/8S8aRwCicB81cDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364843; c=relaxed/simple;
	bh=WqA+E0cUeRwexD3lnA8MK4Ylw7AIdkYhc8tIi7d37yg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=EAwc4QEZZPlsQCvS8aUHC6GErtTmxah5MJoj9hCxSgIaFG+isWpzjvw6JZ/jlO17PNx50qQegOZC7S9FR7PYQHq9D0RjMPk93g3By4RspH/vf9W1uA4BqhPtXzGrdwlOJG5+tHs7kM+Dn+R+ME+jFMaAk6eCRf7ZjOMdcxw9zFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:53580)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNDWM-004V9m-Dg; Mon, 16 Dec 2024 09:00:34 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59886 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNDWL-007X7c-36; Mon, 16 Dec 2024 09:00:33 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Thomas Gleixner <tglx@linutronix.de>,  Ming Lei <ming.lei@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Kexec Mailing List <kexec@lists.infradead.org> 
References: <4968818.GXAFRqVoOG@rjwysocki.net>
	<d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
Date: Mon, 16 Dec 2024 10:00:00 -0600
In-Reply-To: <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
	(David Woodhouse's message of "Mon, 16 Dec 2024 13:43:05 +0000")
Message-ID: <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tNDWL-007X7c-36;;;mid=<87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/IoUPRXc2CZDplraCLK6J/GomP+OYV8hI=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
	*      [score: 0.1909]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Woodhouse <dwmw2@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 518 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.9%), parse: 1.06
	(0.2%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 1.15
	(0.2%), tests_pri_-2000: 16 (3.1%), tests_pri_-1000: 2.6 (0.5%),
	tests_pri_-950: 1.32 (0.3%), tests_pri_-900: 1.04 (0.2%),
	tests_pri_-90: 243 (46.9%), check_bayes: 226 (43.6%), b_tokenize: 6
	(1.1%), b_tok_get_all: 172 (33.3%), b_comp_prob: 2.0 (0.4%),
	b_tok_touch_all: 42 (8.2%), b_finish: 0.94 (0.2%), tests_pri_0: 209
	(40.3%), check_dkim_signature: 0.86 (0.2%), check_dkim_adsp: 4.1
	(0.8%), poll_dns_idle: 0.95 (0.2%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 12 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Does anyone actually use KEXEC_JUMP?
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, dwmw2@infradead.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

David Woodhouse <dwmw2@infradead.org> writes:

> On Mon, 2024-12-16 at 14:39 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> The KEXEC_JUMP flow is analogous to hibernation flows occurring
>> before
>> and after creating an image and before and after jumping from the
>> restore kernel to the image one, which is why it uses the same device
>> callbacks as those hibernation flows.
>> 
>> Add comments explaining that to the code in question and update an
>> existing comment in it which appears a bit out of context.
>> 
>> No functional changes.
>> 
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks. I'll round that up into my kexec-debug tree, which Ingo has
> been taking into tip/x86/boot. Once I'm done fighting with
> objtool(qv).

I have no objection to getting kexec jump more in sync with the
rest of the power management code.

I do have a question though.  Does anyone actually use kexec jump?

It is fine if folks do, but I haven't actually heard of anyone using
it.  If folks aren't using it, it might make sense to just use the fact
that it is broken as a nudge to remove that option.

Eric




