Return-Path: <linux-pm+bounces-8004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE698CA343
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB96282320
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CB1384BD;
	Mon, 20 May 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDG3ockg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EB138493;
	Mon, 20 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236719; cv=none; b=dVD2BfGcuqVX/s1bROJ8F4nXb2hmuzdjWd/ZFeEv+n1RG+17QgKFw5+cZNd8bZHHVJ14A9O3X5kOLgK2q4Vkbm8E+9tyC70mk8yxUrphMFbkiNHQ3R/AR4Vap3d1jjGo28suNJvXlhhSZka5+SmpS6beL0QFRDrDeW99DvkmzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236719; c=relaxed/simple;
	bh=YWuHbthd0gLxLRAKME12JVYB8XhoGfFLh8UaRj4ZA5A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YT55SMSGPSuIxiJcPZQll0PXDjQa9xZluRtaqXLmSLJAwt8wwWUcVUXuj5tVGerTne98zdhfbwCSe70s+OlZHGFW/Gk5bltnWIG+NLVqtenTkGVdEs9SA3oI2bROo2n1lATBQhuoT11U54npU29FtFPLpCiZ0eMquEv4g7sNVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDG3ockg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A390C2BD10;
	Mon, 20 May 2024 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716236718;
	bh=YWuHbthd0gLxLRAKME12JVYB8XhoGfFLh8UaRj4ZA5A=;
	h=Date:From:Subject:To:Cc:From;
	b=UDG3ockg4g2ME/lkrL8ASupa9NPVk2RO9Ns1ckkTalgdP4y9MBDXdlNEH4kY6FYvr
	 NRzV1O0Lt6qfJmRA+EOLy16AaiOf7nkvPvkHdKhTmTu9HFfyKoCLF7Z/OjFcGg9VYV
	 6YebW/gsiUn4VxrJB/JmHE7/R45C5fPPqknMJYks8h9SFZCRqj8RjSCB0GShEoV2Xi
	 MOBgCw8C2BPYOwq3iU7OUmBtzeWhIWOgweJDF8mJwGf5gnVjU50CirvbgR+XMZAyBY
	 FaoV38+09MdsNFnvo2PmXZ+io+5TIeqXdb9W9oxF+9GSt2IJVhOsJhnFhwW79Mkjmc
	 EzSXJ6WfBSjtQ==
Message-ID: <59680f48-df89-431a-98b9-b1cafd3ad353@kernel.org>
Date: Mon, 20 May 2024 22:25:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [CFP] Scheduling Micro-conference at Linux Plumbers 2024
To: LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The scheduler is at the core of Linux performance. With different
topologies and workloads, giving the user the best experience possible
is challenging, from low latency to high throughput and from small
power-constrained devices to HPC.

The following accomplishments have been made as a result of last
year’s micro-conference:

  - Progress on proxy execution
        https://lore.kernel.org/lkml/20240224001153.2584030-1-jstultz@google.com/
  - Progress on system pressure
        https://lore.kernel.org/lkml/170073688055.398.12687414937207369825.tip-bot2@tip-bot2/
        https://lore.kernel.org/lkml/20240220145947.1107937-1-vincent.guittot@linaro.org/
  - Progress in the DL server
  - The EEVDF scheduler and improvements in latency
  - Progress on adding tracepoints for IPI

Ideas of topics to be discussed include (but are not limited to):

 - Improve responsiveness for CFS tasks
 - The improvements on the EEVDF scheduler proposal
 - Impact of new topology on CFS, including hybrid or heterogeneous system
 - Taking into account task profile with IPCC or uclamp
 - Locking improvements – e.g., proxy execution
 - Improvements on SCHED_DEADLINE
 - Tooling for debugging scheduling

*We will consider the submissions until July 12th, AoE.*

It is fine if you have a new topic missing from the list. People are
encouraged to submit any topic related to real-time and scheduling.
The goal is to discuss open problems, preferably with patch set
submissions already in discussion on LKML. The presentations are
concise, and the central portion of the time should be given to
the debate – thus, the importance of having an open and relevant
problem with people in the community engaged in the solution.

This email has a list of people in Bcc, based on a list of
commit authors in sched/locking/power/time. It is far from being
complete. So, please forward this message to the people on
your team working on scheduling-related topics.

-- Daniel, on behalf of the organizers: Vincent Guittot, Juri Lelli,
Steven Rostedt and myself.

