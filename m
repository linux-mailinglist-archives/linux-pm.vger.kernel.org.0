Return-Path: <linux-pm+bounces-415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB69F7FC0AB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AC31C20C26
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564A39AF9;
	Tue, 28 Nov 2023 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kai/m4r7"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6719AC;
	Tue, 28 Nov 2023 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DaSxSk00T76/qmCPgVeD4qkkC3Ewg2huSC46XkFQpW0=; b=Kai/m4r7JmROqhB2gxx2uYcqY5
	BT2Sa80TbKPKtCutvjTYk9B42PvEvOUIrxjPiGc/eMz1gpg8fqZ4t2MJXAYPRteCCpbvw/lLJhiAn
	3pmPz7oj343D6q0v6slZOkbOzPgJFVSPsnxy02S3/yyARh8VVqwLzVOWLmW1DNCQpwTim6z8WTm52
	BR6BDtRTD9s0s64jJnf3FtO2tZbtltVdFOYpw8PsjmJYhQWYGZl0NfHbznc/0c8sHHZvwml2PUAAP
	z5/VwBywP/Y2RtVu7LhYNkm35ak0lS7e72Xnlu3JgMd/X4iE0Gusufsc5MSeIOPGsOLLfwtWzViiv
	HH8VERrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r82Hn-00GgI5-2Z;
	Tue, 28 Nov 2023 17:54:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F4033003F0; Tue, 28 Nov 2023 18:54:15 +0100 (CET)
Date: Tue, 28 Nov 2023 18:54:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Pavan Kondeti <quic_pkondeti@quicinc.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
Subject: Re: [PATCH 0/2] freezer,sched: do not restore saved_state of a
 thawed task
Message-ID: <20231128175414.GD3818@noisy.programming.kicks-ass.net>
References: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
 <a86228f5-c1ae-4afe-87bd-5144633a9601@quicinc.com>
 <20231128173119.GC3818@noisy.programming.kicks-ass.net>
 <8be8ab72-0670-4821-b235-1f8e4ea170b2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be8ab72-0670-4821-b235-1f8e4ea170b2@quicinc.com>

On Tue, Nov 28, 2023 at 11:33:23AM -0600, Elliot Berman wrote:
> 
> 
> On 11/28/2023 11:31 AM, Peter Zijlstra wrote:
> > On Tue, Nov 28, 2023 at 05:12:00PM +0800, Aiqun(Maria) Yu wrote:
> >> On 11/21/2023 1:36 AM, Elliot Berman wrote:
> >>> This series applies couple fixes to commit 8f0eed4a78a8 ("freezer,sched:
> >>> Use saved_state to reduce some spurious wakeups") which was found while
> >>> testing with legacy cgroup freezer. My original testing was only with
> >>> system-wide freezer. We found that thaw_task could be called on a task
> >>> which was already frozen. Prior to commit 8f0eed4a78a8 ("freezer,sched:
> >>> Use saved_state to reduce some spurious wakeups"), this wasn't an issue
> >>> as kernel would try to wake up TASK_FROZEN, which wouldn't match the
> >>> thawed task state, and no harm done to task. After commit 8f0eed4a78a8
> >>> ("freezer,sched: Use saved_state to reduce some spurious wakeups"), it
> >>> was possible to overwrite the state of thawed task.
> >>>
> >>> To: Rafael J. Wysocki <rafael@kernel.org>
> >>> To: Pavel Machek <pavel@ucw.cz>
> >>> To: Ingo Molnar <mingo@kernel.org>
> >>> To: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Cc:  <linux-arm-msm@vger.kernel.org>
> >>> Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
> >>> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> >>> Cc:  <linux-pm@vger.kernel.org>
> >>> Cc:  <linux-kernel@vger.kernel.org>
> >>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >> Shall we add Fixed tag and Cc: stable@vger.kernel.org ?
> >> Since it is fixing a stable user thread hung issue.
> > 
> > If you want this routed through urgent, then yes.
> 
> Fixes tag is added to https://lore.kernel.org/all/20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com/
> 
> Is CC'ing stable what triggers routing through urgent?

Fixes tag should be enough, lemme go find that other copy then.. so much
email :/

