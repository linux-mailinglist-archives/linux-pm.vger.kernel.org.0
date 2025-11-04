Return-Path: <linux-pm+bounces-37394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9662BC335BC
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8B7189B24C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B172DC77B;
	Tue,  4 Nov 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ck9/Kb0e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbUwdjEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E12DBF7C;
	Tue,  4 Nov 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298399; cv=none; b=rh4cZ5SbTMOAyF0tEjkBr67KVseCCJYcaDHXWFT+UGJvja0GZPY+YeQK49QsPP82q1TmuFibote88gb3hn6BQdw60ynBwYkFNiFfpAon5eejtdbUu0QdZVm0gKG3G8/MtBTjRyVXXjBNI3blj4+YVvDgk60iy3hRJnQZZDMT+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298399; c=relaxed/simple;
	bh=6hW9k9llq8m1Kkjc+boksRi0fM+t9oeMFc+qhPZB7To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTH1XhkT15wtTER6tKogrCS2dFCleM4ytPZWz4pMlrsc9MY8YIuPkSqvfmYokwHGFLKZMM3DEoZPGNUkVyLB99bbaQf+IPf3nyoNFh9UkOyst8R6EsVBN6fcvnWdYuIzgLOhS0f+u6KpqYMt6dTUyBLN1/UcoCm3RlxBCv/wxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ck9/Kb0e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbUwdjEF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762298396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hW9k9llq8m1Kkjc+boksRi0fM+t9oeMFc+qhPZB7To=;
	b=Ck9/Kb0eie7pz087suaUDAtbkFYyXpqXdxCHZTr5dWeJ5JqTwCy4nK9zrYog/1fIyAMm2n
	dyJS74bDt+JVfKR5IF+H6zdNSZLJf3zemFdD3gvEtoNYdpgqzO3Vmv27+9t5VwUu5TpaQn
	WnJB0TH4DpkXp4w00HXwtcpFV9ECl7hLLo07hWwaOgEBvaxKw9aV5EjyKbxu6raIurTRtr
	mGlakJxJF/kvIVrs+9lpqvZRSlNMsjjrsncQc0j/KKr5JBhi3H3PMnO53flZXsfgwt7VKM
	t0a88iXi5qjpGE+2yqs3WYjBkOR9hDgJk8jBRd88j55/GxhR3IiaSNYRHvjugw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762298396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hW9k9llq8m1Kkjc+boksRi0fM+t9oeMFc+qhPZB7To=;
	b=TbUwdjEFjcX/Ax3oYG35NLH4DurhRtvskG1RxFeDEChnx2+zg6lkfLxuLJV5+6skNFttVO
	70tcpXjJhCVmMEAA==
To: Sherry Sun <sherry.sun@nxp.com>, "esben@geanix.com" <esben@geanix.com>,
 "pmladek@suse.com" <pmladek@suse.com>, "senozhatsky@chromium.org"
 <senozhatsky@chromium.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>, "kkartik@nvidia.com"
 <kkartik@nvidia.com>, "fj6611ie@aa.jp.fujitsu.com"
 <fj6611ie@aa.jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
In-Reply-To: <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Date: Wed, 05 Nov 2025 00:25:55 +0106
Message-ID: <87bjlhz8pw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sherry,

On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
>> Thanks for confirming the fix. I will make an official post on LKML
>> with the patch today. Since the i.MX nbcon-driver is already
>> mainline, I will CC stable. I will CC you as well.
>
> I'll keep an eye on any fixes you send later and verify them if
> necessary. Hope this fix can be applied to the mainline and the stable
> tree ASAP.

Even with this patch [1] I am able to reproduce the problem on one of my
test boards. I am using the following extra boot arguments:

no_console_suspend loglevel=8 initcall_debug

And then:

# echo 1 > /sys/power/pm_debug_messages
# echo mem > /sys/power/state

This generates a lot of output and leads to the same suspend
failure. This may be due to the out-of-tree nbcon-8250 driver I am
using, which introduces extra irq_work usage within the driver. Could
you please try the above boot arguments with your i.MX board?

I am wondering if blocking the queueing of irq_work during suspend
should be generally implemented rather than just printk avoiding it. It
also seems to only be a problem for ARM32 so perhaps it needs to be
addressed at the architecture level.

John Ogness

>> [1] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f

