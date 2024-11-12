Return-Path: <linux-pm+bounces-17365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7109C4B81
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 02:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60478B22409
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B21F754C;
	Tue, 12 Nov 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQrgGs8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZsYcMRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49CC5234;
	Tue, 12 Nov 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373665; cv=none; b=bS/c3qRLfKRdd85I8rZu+eWwhyTooD8pRwd26PNRHBmRWYL7QyWa2EZDxEBEFRWgAA9YuSJqp1CKJtpPVbTv11ce98j1OWjo8H7Auv0qgdafDdilSgmdzkRwUL1cflBd1K62Wovk2++/Qr8o0wLWNEcwFm4ESVjzSNG83KVr24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373665; c=relaxed/simple;
	bh=NiT2v4KtxIZJPnmu+e9fr80tgReDlEnejBG+0hbQIRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VtHT3RHe0xcu8ZV87sOVmXfuP6CZ/PR0ylvsYotlJZ+Vseyph/nKIeK0Wk8C0ffhYesJyWvdrp/Kx1CmXmyVpeMvNxdrBmsJzO3QOS4A4n+mKH8xgrRb/PImwyLUPmJYKNNceQHWYl/lqdAXcPaE3xhy2cHXUPxFK1O907sQIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQrgGs8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZsYcMRK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731373661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5s/m46v24gtVwgvBpriXEpuPGkdMoQKTK4XbSOPcW0=;
	b=NQrgGs8cbfXP1icrl/Q/tDfZ4FitRa0D40dfkQS46xkpmA8JpxTbKqFUOGxJve0B7CtTaX
	uMw9rqrv/A3NdUJm9eTMXMaaXRXiO9BDhJbXshSIwSACg5IMFyTqV7yAEKRtv1HJ7EoIS7
	Sa3vfadfL+Wn4OoYxYkDcfrkIssTyoNO5RwqHMordzHU+HAwHwwenle38s8iWW69PZdKM/
	pw2Mn52nyRFZTMr58zGCMzi4dg6/v1tRWQtLh4Sqnr56FugYEMXBohLxB9KFAxb8fu37h+
	/qKEgIH9SjHXWdRssjqsI11zXH40i1Xclbma7ckvqcb9pBwL+CUtZhx7D6RleA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731373661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5s/m46v24gtVwgvBpriXEpuPGkdMoQKTK4XbSOPcW0=;
	b=wZsYcMRKaH6IYWLT6361xLxBJTLTZi6Yd3Jr63R1BT0K+f10LZUOCMik2bAsGOl5jkpse4
	amiJtHAq0cX7ZnDw==
To: Len Brown <lenb@kernel.org>, peterz@infradead.org, x86@kernel.org
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH backport to 6.10] x86/cpu: Add INTEL_FAM6_LUNARLAKE_M to
 X86_BUG_MONITOR
In-Reply-To: <20241108135206.435793-2-lenb@kernel.org>
References: <20241108135206.435793-1-lenb@kernel.org>
 <20241108135206.435793-2-lenb@kernel.org>
Date: Tue, 12 Nov 2024 02:07:27 +0100
Message-ID: <87h68dnttc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 08 2024 at 08:49, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> Under some conditions, MONITOR wakeups on Lunar Lake processors
> can be lost, resulting in significant user-visible delays.
>
> Add LunarLake to X86_BUG_MONITOR so that wake_up_idle_cpu()
> always sends an IPI, avoiding this potential delay.
> Update the X86_BUG_MONITOR workaround to handle
> the new smp_kick_mwait_play_dead() path.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219364
>
> Cc: stable@vger.kernel.org # 6.10
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> This is a backport of the upstream patch to Linux-6.10 and earlier

You either fail to understand or intentionally ignore the process for
stable backports, which is in place since more than a decade.

Documentation/process/* has plenty of information how that works and
you're around long enough to know that already.

I don't care about you wasting your time, but I very much care about you
wasting my time to deal with pointless emails. I get plenty enough of
them every day.

Thanks,

        tglx

