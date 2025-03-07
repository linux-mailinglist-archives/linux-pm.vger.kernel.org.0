Return-Path: <linux-pm+bounces-23661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87538A5764A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3027A6341
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8442135B5;
	Fri,  7 Mar 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XysOcXqC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08585208990;
	Fri,  7 Mar 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390729; cv=none; b=oXndnI80Wa/ukGwLfA3a44pJmXvFgxfdu9ziuOQ6y01PZTQOAtvZwBlZe7hSuiXlIMIyKkezCqu1St/nkaLY00cQEBY3YcQgHFGevjEViVlS4+ZACB7/mMmVPZnfrHvXfnmzsNLVhHrey2FKsge7v+51vPuWBCMGcvseQwKX4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390729; c=relaxed/simple;
	bh=P4vyWk3reiE07secgDDnsAhYfN69/dzogtDPEgwwIbQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lp48wCNvQ6a2oqIQvTCzmXOg3J8HHGPBWBgj81aVxaelZGHaJODYpw5Ei1E7Ce2miQfOP6R5ZRaHitHdj9P0FfHoUxSfEFLTRrUruHikMTEy5/01vhVVY7yBwChqEEZSzzcnbDPz8rMCCEkgPV35U7wXwoknBrdKWASJh6Sv9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XysOcXqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D7BC4CED1;
	Fri,  7 Mar 2025 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390728;
	bh=P4vyWk3reiE07secgDDnsAhYfN69/dzogtDPEgwwIbQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XysOcXqCwMhS/vjHd/vkus1NSBXvMx+V20sF2wi+4D/DHzvdTO5N8cLEgm4REpjkc
	 zszDsIMRor4cnRLho6jBpvF22DJex74YlJEan3P0ygsToJOndi4aAk7Ly1GvYj/fOi
	 RBy4GV/oU2xKuxl0WCsiVtVfuTXtAdo0IpF5RqqymSYj4Va/7za+OMeBX8yu6Vf77U
	 e1B/xP7+KaGYVx6dG576dsR5Ri5UjTOvY0ZiqSkSlE4BK1jTFdYULIQDwEe4lLKDT7
	 aINNGQE45jl1Kj91ObuWnVv3B0T7yJ2lkMrLT1o0Y97L5Il4qJw0ofDIVrmto0tl24
	 8/lypsITcWvnw==
Message-ID: <8e6c0123099039c2f69715f57ef7ba42.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com> <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format specifier
From: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Lukasz Luba <lukasz.luba@arm.com>, Petr Mladek <pmladek@suse.com>, Rafael J. Wysocki <rafael@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Zhang Rui <rui.zhang@intel.com>
Date: Fri, 07 Mar 2025 15:38:46 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Luca Ceresoli (2025-03-07 03:19:08)
> %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprint=
f:
> add %pC{,n,r} format specifiers for clocks") introducing them does not
> clarify any intended difference. It can be assumed %pC is a default for
> %pCn as some other specifiers do, but not all are consistent with this
> policy. Moreover there is now no other suffix other than 'n', which makes=
 a
> default not really useful.
>=20
> All users in the kernel were using %pC except for one which has been
> converted. So now remove %pCn and all the unnecessary extra code and
> documentation.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

