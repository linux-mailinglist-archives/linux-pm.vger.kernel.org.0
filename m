Return-Path: <linux-pm+bounces-37351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02130C30726
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091674E72CA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF02D3225;
	Tue,  4 Nov 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZxxKFQk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISp9s7bN"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4F34D3B2;
	Tue,  4 Nov 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251382; cv=none; b=jHgEw/0PEO9hzexVTqVNdL5T+q93Ok1GidRb1AoQ1nFwrstdDYc+3uUOk9Qd75+PRYkbG/RPu1eWuP590J5o7XIQmEB5ku8iVkmOJfTFaAFwGIG84O0bbYYua3qxAy9+1RnH7ARgqc507oefKYragmraYz7QpWbUKeVxaMRXFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251382; c=relaxed/simple;
	bh=b0NWX2NHAto+3Odhbhmhi+Qkza46c6iqSStc0dGyRT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVcqOgx6SFCtzcFsPYu9geDW//+YSDRg6P3ui2gzVrT5yNH5jc0977354bp/z1zGLedsq59GE8/8Gtnhse0onuJbOfO6Bq75PxzNo6NQDkIgYslGWD6b/74oMnRv2tX307YRUEWyw7mX5cnObSmE+fkHyMhXy2bYZY4iIT+K6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZxxKFQk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISp9s7bN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ahD5Q7OGPrmb6gtHMTBb/j+mcYIc6r9oz8m1gCQKzkw=;
	b=nZxxKFQkQxDeTEhMor0tYsjLgHi2Q3lUykSIczYPuW12V5RDnTRuUFkKYSyi+JhAjyklpU
	2qVmRCsZ5sLnToWUhvz96tZ5qMqFTJq0eu5uW+ovMNTiQWE4fj/vfOseCtZGUzk/UBSTiF
	9HOoU0Gq3eK/xnK+wSmNpRgUlU5reEWESRNYUujAxkIXSFXVyQ9apSjg8R5vd1TtmraZvY
	RNeUDkRqTMHzN9DJRm0o/eafE4ZQig7COmAHyQfshsZ1AASowIIHmTThD4jveOETYWe+I2
	JpJ0KuzKWqt0qfGzqrBQXy3dVzl1+PTMnELkKMzU/28DTrMjeO/LIwdsEY1AbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ahD5Q7OGPrmb6gtHMTBb/j+mcYIc6r9oz8m1gCQKzkw=;
	b=ISp9s7bNn0PZzFlxM7xLGL4vfVk2NJSIv1Mkt600MNf1fC+g/Ncv3tYL3fni+HZVWtA9Mu
	A9iRmYbPaRlBMbCA==
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
In-Reply-To: <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Date: Tue, 04 Nov 2025 11:22:11 +0106
Message-ID: <87qzuem7bo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
>> Thanks for reporting! I believe this is the same issue reported by NVIDIA [0]
>> when we tried to switch the 8250 UART driver to nbcon.
>>
>> We have been working with NVIDIA recently to address the issue. There is a
>> patch [1] we are currently testing that looks good so far. It is based on 6.17
>> but should work fine for 6.18-rc4 as well. Can you give it a spin?
>
> Thanks a lot for your quick reply, I just tried the patch [1] on my
> i.MX8MP EVK with L6.18-rc4, it does fix the suspend issue.  Now i.MX
> UART nbcon can enter suspend with `pm_debug_messages` is turned on.
> May I know what is the upstream plan for the patch [1]?

Thanks for confirming the fix. I will make an official post on LKML with
the patch today. Since the i.MX nbcon-driver is already mainline, I will
CC stable. I will CC you as well.

Note that the patch still needs a formal review from the printk folks
once it hits LKML.

John Ogness

>> [1] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f

