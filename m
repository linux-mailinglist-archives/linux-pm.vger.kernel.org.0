Return-Path: <linux-pm+bounces-37347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455CC2FDF8
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 09:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EDBD343826
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689530596F;
	Tue,  4 Nov 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKZmuY5x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eex7FxTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD62BEC4A;
	Tue,  4 Nov 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244920; cv=none; b=s1eq0tsTm+ydQSrnUAZS/7lW5KsVGb2gpWETb17JG3EkBo4MHxX6VzvnMUcY4DH/7JhZgnKtwMQuvsKCr43wjyAWObGDPl3HJsX677PdpPHHbl8EfPMYB/jqF+NoIXUGqYpdxGuqsMVeRotD768UwI12t/XwQsu+awYB/DHPDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244920; c=relaxed/simple;
	bh=KRgnztshsryrhUg3jdsgqyFuCbUMtBMYBmlbKr9IW+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dvj41mggBg0mB5aNLEGcuyAha2XApoZLq6li4ot+CmC3usLBkq7K64g1GWKt9T9SyLWxykan/0Qh89plB0+cvE93ZlHi2yNwcETSxYv4tknWgXNWpLs35/7GblN+Z5NUBMUMD2uT03OfX4nb1H6kVmRTr4ybujRw26/MuJdOSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKZmuY5x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eex7FxTa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRgnztshsryrhUg3jdsgqyFuCbUMtBMYBmlbKr9IW+U=;
	b=IKZmuY5xEME0fUnU+ODBigfDbR+GDPF0wsKdSVh7NOi0bmWHRzMOE1+0gnFtaFQt7K91Rz
	E04TcsoIRqznH5cFa9OSmu3xy29RxdOC55tX2z1bSHMqtM8qHadmIWKAkhDtXbvuIe1tBU
	K4RbiKQjDYBb5Mw1NaCvQvWD2I7w8GsEe7XlKItzPPXsGtmTI48td9ACPTPdw1uBXMzREk
	W278jp0r3Zw0t+VfuaxbbPP9dZ/WDVrmrV4vRW1F9Q5u6Ck78mImmH2yLPBnhiQTQSLExJ
	ZeAvo11+JhYTJmBZHxgLXPglB25/mYc5dGndQrXI9Z3aU0oELQnh5TRyqrRh6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRgnztshsryrhUg3jdsgqyFuCbUMtBMYBmlbKr9IW+U=;
	b=eex7FxTaHfR53OT+DalJPlNTNLYO8jGKZD67BZ8V9MMyZJtH0QV8Sb1L7hk0hnTx2mgWoJ
	rTfNJ2OPUF/kHqCA==
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
Subject: Re: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
In-Reply-To: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Date: Tue, 04 Nov 2025 09:34:36 +0106
Message-ID: <87tszamcaz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sherry,

On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> Since the latest i.MX UART switch to nbcon console with commit
> 70acca67bdd3 ("serial: imx: Switch to nbcon console"), I'm
> encountering a suspend issue on an i.MX8MP EVK board while testing
> with Linux 6.18-rc4.
>
> The system fails to suspend when both nbcon is enabled and
> `pm_debug_messages` is turned on. When `pm_debug_messages` is
> disabled, suspend works normally. Additionally, if I revert the patch
> that adds nbcon support for the i.MX UART, suspend also works fine
> even with `pm_debug_messages` enabled.

Thanks for reporting! I believe this is the same issue reported by
NVIDIA [0] when we tried to switch the 8250 UART driver to nbcon.

We have been working with NVIDIA recently to address the issue. There is
a patch [1] we are currently testing that looks good so far. It is based
on 6.17 but should work fine for 6.18-rc4 as well. Can you give it a
spin?

John Ogness

[0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com

[1] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f

