Return-Path: <linux-pm+bounces-36447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A5BEF11D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 04:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50C934EB460
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 02:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A18261B8C;
	Mon, 20 Oct 2025 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UeELagL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601425334B;
	Mon, 20 Oct 2025 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926438; cv=none; b=VY5fwWekYmUyjnQW6RtcyGCrVnx4VeYv9wYEYMoAtYG+rMGr7LIGEmv2x0Mtg7lrmEziX/zBPfzeGatyfqCW8iJU0ckbukl5hFjzwOrNoPbjHgumCR+Q2byysKuQH46vzEfFRhupmfzRJa3FZhpOkVkcfniFGvDBwlSXtkfoCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926438; c=relaxed/simple;
	bh=Ha9MQzysPOX3yOhVlEYOWL+C8FnPK4ezGU3JCiwFods=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deAc0GD8TCzpxHKp3f52qsvF4RZSyYH3OGbJHJslMJMv+gj0CpP6mHH3Hm53YGk2PQQyKIIG2AkCSDdpyq1G9Fx7n8ZEN7goxF+C9oKNyGLX4fQXTev5rRFqQkeGNg+JX49LPiGmHhuuFJKi/hy3MWmof8ndt9n+GPA7Cdt1A14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UeELagL1; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760926361;
	bh=pzVyONwXb/8XHbx8LYvOWLQDfxHTrG02yDRUj8ZtCNM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UeELagL1ILWThB9FPowkQSbPLJiFBzkMvR+1JsZULQvmcMhRWWc7TxHxbaA9jaCi8
	 PYJKSFAszzFcuBQA/qFJN7tATY7netK/6K3FekVdBHh7jTUi+sKetLaGQiMN4LFKE1
	 F+zNNdsu7lDPs1vFMujsdJnBUZrY0SCpc1aHMOyU=
X-QQ-mid: zesmtpip4t1760926354t9455e896
X-QQ-Originating-IP: 0E8AicbofZVPioFvNQJImVcnsnCyOThZafGWr0XuzRI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 10:12:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16094178770994634205
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: dakr@kernel.org,
	gregkh@linuxfoundation.org,
	kernel-team@android.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	saravanak@google.com,
	wusamuel@google.com
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
Date: Mon, 20 Oct 2025 10:12:28 +0800
Message-Id: <20251020021228.2336745-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
References: <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mutteg8H72qDJ/2nTiJF1bGCAKl502sWOHI6Itwz4lX4Qhf4aXU6lueu
	2eO7HbB3SYRMkpmEjkqJb4iERy96p0hReLyW6rejBv/ok0Y8EBZ/A5nW1Cb1+LwG9fbi0Rz
	uygkCk2l1If9f/Zbwqu8//uHeN4lXb2mFbhcu8SYWG5ojYnhWMI/K+J4ADzvqdi4XuEBc/J
	iI6gutZOu1uva4fKppqMQaqHgEdCQnJ++2YQXM/Hkfn4dTXhvT7jpA0X1XhpiecH/uoid5Q
	IH1ShWpuB/VxF7V1XsKKTkoNNL0DBhXvCoQVyp3D/jF3mXPrbEU3iXXeV1KYUjM6SFh/YH4
	yf7naDEU2RbuDj+qvP/qx9G9tbNzO129J+s0uNfsVSyRXAJKIWzGEl8OQj8yw+GwZ/madA9
	22JQdBNqJRh7uZt+LHSNINSCsx5cGD58C5YopBL+4AK4tfxCueHJ7EcAZp08pjMcjVDneeD
	RvRwqBuARJhNlAEoiNCqjIm+I/NfSgIJR26CkRnILmWM8Tq4aTEuyjdpeULHZoP8vVTXuo9
	QUklmmqth3aLwZCzz7OjzUBFnmGuLFQov+OtsNEWBrat/lgEwOmrXhM66W1FV32XFMTVEg6
	gneWJcwcRb+dn0HquSI9nAcKwuwrsdjyHgBHH1+GB2yp/L+gkqicAncsqcJaaeug0EOHHZu
	qnfUc2qUX0QyE5P6EPebd3moEzXaXdLaNBW2k4ni3/Bq01W52wOA8TwTR0BamRHuOh8acNg
	gywCamJxXjmwuiemPwsdpp1Ehcc9fqJ0v/OyGArrH9TyZ/hWet1bU7DNnS+So/yqtvn0Nox
	VKEcGFpU3r4A27qnJV4Bxb8hHhUfAy1ve7wTwPqDPuCDte9mdp4eFo3Cr27xJgwexSUz9H4
	jaIoHZ6+Aj5TsgjlEjub6hvmMa7Xl1WBZqwQ/5WRVBVTd+VGuG4PbHMrLSV5pCoCUeME6s/
	fb87H1x3ODo83vbRN1yGPP65zZ6mFXM3zNOa9mioMUqgBOQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Rafael,

Thank you for your attention to this matter. I'd like to clarify the 
difference between our approach and the Google team's solution, as they 
address fundamentally different use cases and environments.

On Mon, Oct 13, 2025 at 8:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > No, it's different. We don't mind a long filesystem sync if we don't
> > have a need to abort a suspend. If it takes 25 seconds to sync the
> > filesystem but there's no need to abort it, that's totally fine. So,
> > this patch is just about allowing abort to happen without waiting for
> > file system sync to finish.

Saravana is correct that our problems are different. Let me explain the 
key distinction:

**Google's approach (Mobile/Android focus)**:
- Problem: Unnecessary wake-ups during sync operations waste battery
- Solution: Abort sync only when wakeup events occur (user interaction)
- Philosophy: Wait indefinitely for sync if no user action required
- Use case: Mobile devices where users expect to press power button to wake

**Our approach (Desktop/PC focus)**:
- Problem: Indefinite sync hangs leave users with unresponsive black screen
- Solution: Proactive timeout to prevent system appearing frozen
- Philosophy: Provide user feedback and system recovery within reasonable time
- Use case: Desktop/laptop where users expect immediate system response

> > The other patch's requirement is to always abort if suspend takes 25
> > seconds (or whatever the timeout is). IIRC, in his case, it's because
> > of a bad disk or say a USB disk getting unplugged. I'm not convinced a
> > suspend timeout is the right thing to do, but I'm not going to nack
> > it. But to implement his requirement, he can put a patch on top of
> > ours where he sets a timer and then aborts suspends if it fires.

The key difference is **when** we need to abort:
- Google: Abort when user wants to wake up (reactive)
- UnionTech: Abort when sync becomes pathologically slow (proactive)

For desktop users, a 25-second black screen with no feedback creates the 
impression of a system freeze, especially when caused by removed USB 
devices or failing storage. Users cannot distinguish between "system is 
syncing" and "system has crashed" without feedback.

**Question about integration**:

Since both approaches serve legitimate but different needs, could we 
implement a unified solution that supports both mechanisms? For example:

1. **Combined approach**: Implement both wakeup-based abort (Google's patch) 
   and timeout-based abort (our patch) in the same framework

2. **Configuration via sysfs**: Add a node to control the behavior:
   - `/sys/power/sync_abort_mode`:
     - "wakeup-only": Use Google's approach (abort only on wakeup events)
     - "timeout": Use our approach (abort on timeout)
     - "both": Use both mechanisms (abort on either condition)

3. **Default behavior**: Could default to "wakeup-only" for mobile/embedded 
   systems and "timeout" for desktop systems, or let distributions choose

This would allow different systems to choose appropriate behavior based 
on their needs.

Would this unified approach be acceptable? We're happy to work on 
implementation details with the Google team to ensure both use cases 
are properly addressed.

**Additional concern about integration timing**:

I noticed that Samuel Wu previously mentioned in his response to you 
(Sep 30, 2025) that our approaches could be "decoupled" and that I could 
"build changes on top of theirs." However, after reviewing their v4 patch 
implementation, I'm concerned that if their approach lands first, it may 
make our timeout-based solution significantly more difficult to integrate.

Their current implementation:
- Uses workqueue + completion for sync operations
- Introduces pm_sleep_fs_sync() as the main interface
- Adds complex state management for back-to-back sleep attempts

This architecture makes it challenging to integrate our timeout approach 
and add mode switching functionality. If their patch lands first, adding 
our timeout mechanism would require:
- Modifying their workqueue-based sync mechanism to support timeout
- Adding logic to coordinate between workqueue completion and timeout
- Implementing mode switching between wakeup-abort and timeout-abort
- Ensuring proper interaction between the two abort mechanisms

The main challenge is: how do we add timeout functionality to their 
workqueue + completion design? And how do we implement clean switching 
between "abort on wakeup events" mode versus "abort on timeout" mode? 
Their current design focuses solely on wakeup-based abort, so retrofitting 
timeout support and mode selection would require significant changes to 
their implementation.

Would it be possible to consider both approaches simultaneously to ensure 
a clean integration path? This might result in a better unified solution 
than trying to retrofit timeout functionality into their workqueue-based 
implementation.

Best regards,
Haowen Tu

