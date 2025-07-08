Return-Path: <linux-pm+bounces-30409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09919AFDA2B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 23:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589F2173336
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D020D51A;
	Tue,  8 Jul 2025 21:46:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1909461;
	Tue,  8 Jul 2025 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011218; cv=none; b=oGtaFd1q0PXjmpkCkMOwo52dZwg1VdbIDa4QMEh1bYIrjYibBn+Lndse2KJeZrO+Sdajal5oV2ZaiQ/m0myknEc/qqHzaSG8tkuomj1jJnDISrhYVZfiuA/DZnwf/sFXMxokoArcKXoR2SkIQJmsB2xDNQ9KDN4scSHvfFHTQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011218; c=relaxed/simple;
	bh=jwnMcgagJQV6o7x9MWruk3Ny5m9kmySmbNw9OijF/Vc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Fkh4VIMm2zwPtSv2K7VvTDJi+ENMRPyrEGTxDbkyRFLQYqvp6SUggQQjhnupaNHMWTqqPlW6boy2lHfz918352IZlxCsSGkE/vRNe6EY28VfgobXizdVpaFarqajTiFT8cR8lNIaY0HEd/SPk1NAsYJVHhxmucBR24UySY94dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:57132)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZG9N-008LxS-Uc; Tue, 08 Jul 2025 15:46:53 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:36886 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZG9M-00Enas-U3; Tue, 08 Jul 2025 15:46:53 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
	<87ms9esclp.fsf@email.froward.int.ebiederm.org>
	<aG2AcbhWmFwaHT6C@lappy>
Date: Tue, 08 Jul 2025 16:46:19 -0500
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy> (Sasha Levin's message of "Tue, 8 Jul
	2025 16:32:49 -0400")
Message-ID: <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZG9M-00Enas-U3;;;mid=<87tt3mqrtg.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19OibnjGVd1ekZqgNZch7WHltki3akpgkU=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4997]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sasha Levin <sashal@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 437 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 10 (2.3%), b_tie_ro: 9 (2.0%), parse: 1.41 (0.3%),
	 extract_message_metadata: 4.7 (1.1%), get_uri_detail_list: 2.2 (0.5%),
	 tests_pri_-2000: 4.1 (0.9%), tests_pri_-1000: 3.9 (0.9%),
	tests_pri_-950: 1.69 (0.4%), tests_pri_-900: 1.39 (0.3%),
	tests_pri_-90: 62 (14.3%), check_bayes: 61 (13.9%), b_tokenize: 7
	(1.7%), b_tok_get_all: 8 (1.7%), b_comp_prob: 2.4 (0.6%),
	b_tok_touch_all: 40 (9.1%), b_finish: 0.88 (0.2%), tests_pri_0: 325
	(74.5%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.9
	(0.7%), poll_dns_idle: 1.08 (0.2%), tests_pri_10: 2.2 (0.5%),
	tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>
>>Wow!
>>
>>Sasha I think an impersonator has gotten into your account, and
>>is just making nonsense up.
>
> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/

It is nice it is giving explanations for it's backporting decisions.

It would be nicer if those explanations were clearly marked as
coming from a non-human agent, and did not read like a human being
impatient for a patch to be backported.

Further the machine given explanations were clearly wrong.  Do you have
plans to do anything about that?  Using very incorrect justifications
for backporting patches is scary.

I still highly recommend that you get your tool to not randomly
cut out bits from links it references, making them unfollowable.

>>At best all of this appears to be an effort to get someone else to
>>do necessary thinking for you.  As my time for kernel work is very
>>limited I expect I will auto-nack any such future attempts to outsource
>>someone else's thinking on me.
>
> I've gone ahead and added you to the list of people who AUTOSEL will
> skip, so no need to worry about wasting your time here.

Thank you for that.

I assume going forward that AUTOSEL will not consider any patches
involving the core kernel and the user/kernel ABI going forward.  The
areas I have been involved with over the years, and for which my review
might be interesting.

Eric

