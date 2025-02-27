Return-Path: <linux-pm+bounces-23083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E754AA482F6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD04D7A3B9C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC126B2BB;
	Thu, 27 Feb 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5l6V4qm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m18xiogJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A8140E30;
	Thu, 27 Feb 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670232; cv=none; b=P5aXbWmACZpah3ADt7tHKJFADC88NKN/42RQ/x8epJYI8zvb9ndiT2qBUuyF36ChMpgIFmd8Q8c8pyX1HrjPqntn4DNwDsOZjmxC0i5wKwFO9paXHdUs9yX+AIUujRSLcj+OyOly4F3r+xRi7q91u7+Vw6+UPPdkFSmVKP9TAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670232; c=relaxed/simple;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SjxESOUR3wWetGrg3K54GpUAsHHwOZtVvboE/zYmaSMppiSQmH+JbYLrYjz8arbuz/3Zh3EqaOXz+RsbP6PC5/dz8bUUDdaR6woB47GCx10hU9vUS0qBagOF1OaLiHt9/eroHtxnvBSyrAotpV+9xlzefI7qtDct/v4bi+lI6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5l6V4qm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m18xiogJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740670227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=;
	b=e5l6V4qmYG4H0zM87CUzcBa5SIGuUCm2KMFYJn+AjPhI5lG+zuTBV1dqlvDj66MuqLj7Xj
	ycSdw2YXLtaxpaqPNsxIupGBOAig8PexZbOhmtktwOpcuwOdqKnOZp5Mcl3onjvz4LJ2bk
	gX5zlTb77PuYbmzzbEAFKPScY53Axe5M7NTSnvFq3wRXivj4BxFGG2lKvg7vATHNz4NShI
	uxZ20GcDKBuESiUWhf3tkvzra9iJvT0OE0BZxAPBIvHyiPnqfKJxTDpS3chEj9/IRZUycL
	3h8Y3eSlgoJQFnShHQkC45oqsm6C5RdSFeA+ZHDDNQAltVfptK49Ka9BcOi9qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740670227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=;
	b=m18xiogJlgB17Q9YWLFgqD0iKxg/sqwt/cdC+kwED0mwXbfxesRAYhUqN4K6DI1O/F2d8v
	qC/Z5h/HYN0TOFAg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Todd E Brandt <todd.e.brandt@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Marcos Paulo de
 Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
Date: Thu, 27 Feb 2025 16:36:26 +0106
Message-ID: <84cyf376ct.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-26, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Hello, I've being working on some patches that help to clarify the suspend/resume
> of printk machinery. The last patch on this patchset address one issue regarding
> suspended consoles and blanking.
>
> This is a part one patchset that I would like to see merged before I send more patches
> that will rework the suspend flag (a global suspend flag istead of per console) and
> the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> register the console instead of using this flag.
>
> Please review!
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The series looks good (adding the spellchecking that Jiri
mentioned). Thanks!

Reviewed-by: John Ogness <john.ogness@linutronix.de>

I think it is worth mentioning that the series was motivated by this [0]
discussion. And since I just mentioned it, that is probably mention
enough. ;-)

John Ogness

[0] https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz

