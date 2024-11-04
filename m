Return-Path: <linux-pm+bounces-17003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F269BBDD2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59B1B21C06
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160F1CC177;
	Mon,  4 Nov 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="v73xZXuw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4A18C926;
	Mon,  4 Nov 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747671; cv=none; b=YcFKPp5mkBy0xcQ3raiZT0/2LVxllOXxjCT9TRST4h6KWyGlyNGj0w0Z5w4fWqGEu9xkDV35F48xvmw20grOMHjRT5VF0PjXdFHCZ1wZpo531z7oI01jUCZCKQ/hlTUM/tCb3MKTaGGARiFoN8ydjZiw9uR5kda6NF5B4nNTyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747671; c=relaxed/simple;
	bh=o4Q21EUOtQ5gP8TVU/SzyX8KbHV1rScUhI+UDQ2yHfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyFbNLI1CCZSRKTz2USS98tZP4rO4qUnPmHFwS1ZGp9+G/Pre40ho3KcMe6E1tOPH1CVlUQs62CQnyg5VuBf7Ft2hjmFjMh/b+yb/6tCsQ6zJAGTWixDcwedNgKVwi4JO662Us2bKF+erQBV0fllFayinmTbP5H00FIAiK61JE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=v73xZXuw; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PljaPNPt6R2nYVku9vBFHgDoW/TWpHwXI6NoLjiVHnU=; b=v73xZXuwTsYAUpHnxPLfsov4D0
	1OOd+L5YITYru9ut7DOvY9bNkEc2XKaSf730FSo76TcYGoTYxqFv1T5YFDB1kcL3H0UF2ELxgIwzv
	fnXHRRoq7N5FvXRLQMQLF8YAEH+Zgd/vw/GSi3qALx+dLNqUWFiLtODMcq/vBL/RrItgZPQG3oPfe
	nCTzMv4VJxUAmstFs6PFFgy2nsEZmKHIWqfrpa/qXakPaGxCWBrlXtWAR0nG4QYnza+Mbq/7wEXM0
	8AZtOpmiiVrV0mnVj0YGmfalBdDjKNRUqQsN825VsP9zLVZiijB5DFoTaH+FP+6DpS8mzPP0Pknyd
	RpYRZI/g==;
Date: Mon, 4 Nov 2024 20:14:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Kevin Hilman <khilman@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, zhipeng.wang_1@nxp.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
Message-ID: <20241104201424.2a42efdd@akair>
In-Reply-To: <7httcmonip.fsf@baylibre.com>
References: <20241103210251.762050-1-andreas@kemnade.info>
	<7httcmonip.fsf@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 04 Nov 2024 10:35:26 -0800
schrieb Kevin Hilman <khilman@kernel.org>:

> Andreas Kemnade <andreas@kemnade.info> writes:
> 
> > E.g. omap2plus_defconfig compiles cpufreq-dt as module. As there is
> > no module alias nor a module_init(), cpufreq-dt-platdev will not be
> > used and therefore on several omap platforms there is no cpufreq.
> >
> > Enforce builtin compile of cpufreq-dt-platdev to make it effective.
> >
> > Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as
> > module") Cc: stable@vger.kernel.org
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> I'd much rather see this fixed to work as a module.  You already
> hinted at the right way to do that, so please do that instead.
> 
no clear idea how. What aliases should I add? The cpufreq-dt-platdev is
not a real driver, so I could not create mod_devicetable aliases to
match a given device. It constructs a device under certain conditions
depending on the board compatible, so no simple list of compatibles, it
contains allow and blocklists.

cpufreq-dt then binds to that device and that one can be built as a
module (which then made cpufreq-dt-platdev also a module, causing the
trouble). I do not see any benefit from having cpufreq-dt-platdev as a
module. ti-cpufreq has a similar role and is also just builtin.
It does itself no real work but provides a device cpufreq-dt then binds
to.

Handling module removal would probably need to be added and tested. I
feel not comfortable having such as a regression fix and for stable.

Regards,
Andreas

