Return-Path: <linux-pm+bounces-32062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5140B1E6C6
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386F3BCE39
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D64239E80;
	Fri,  8 Aug 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vb1cfBF/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWhwFypf"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD52248BA;
	Fri,  8 Aug 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650205; cv=none; b=VkZZZQMFscLfuHZkmzqhGsrTzuzPGYSEnr6TYox+Emx/niTBzfQzmPeSMMKI8Yf0Bp1ivVa/UmgxvE1rO3+PNOZcGQ1+ULAFJ/LKpocTzSSFWJxYDUoXvMCF2rqwo4elbVNkQ8Y+TzU+3ZDHNal/YKRkzyuRfZyJT8bD/RZu2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650205; c=relaxed/simple;
	bh=7ovIFhWjXZuDLJZR4cDBmjSpBjw0GzEJjCyqgUwvTE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAlto70YDOMd7GRvOZUZMWGOAkk6VZRj4oR0ZfDyg6WrCnH6QbXcWIahbR7/42Xm0rbaIN5k/fFo5sIZZRQC38qP+uScT0AHFxD+4aqWEZf6+iV7wLxNa87j53MK1ahmDRtB3iKrnMo5JT4S3qMo5uW3TVkNKlfI2PcEK7DKfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vb1cfBF/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWhwFypf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 12:50:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754650202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ovIFhWjXZuDLJZR4cDBmjSpBjw0GzEJjCyqgUwvTE8=;
	b=vb1cfBF/7YK6hJyG15Ng7vqjhAkhPrbdIxz6thQRmzP0FY1QBq10oGYFTy5vNAMIkOF/Er
	3iQgKB1rC8lZW5fDe3Qa/WN2skT13W5dkveRH3nI+HYxbopV8DDi7rFO6cc+AZ6joH2Bbr
	HEwQv4vneewlJA+Iqvay0ZqPvBkM/pjpYBxVZZ0dtJynRV8+V/6yFP/TiurLSYMEjnFvH0
	+C/BnUlOFxoiZuz1R3s6L3ZuTR4E/ndvg60LCsMMADC+Er66ekEIYKnc4IwtIzxXlDdCI+
	V6eYVFhCSJxMCYTprygpDsUC2h4MxFE0z/kk1ihi8SOjsZBnjdlpsDjRyESkMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754650202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ovIFhWjXZuDLJZR4cDBmjSpBjw0GzEJjCyqgUwvTE8=;
	b=zWhwFypfYEil3TXTW4XJRR1LLvHkMukwxXK0TXus3PnXdZkKU15He4ft3uenbQeY3iceOb
	rFpu98P1TY7Z4UAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-pm@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: loading amd-pstate-ut kernel module crashes with PREEMPT_RT
Message-ID: <20250808105001.N6t7p2-N@linutronix.de>
References: <20250731092316.3191-1-spasswolf@web.de>
 <aJI9xbIllYV7ON8S@BLRRASHENOY1.amd.com>
 <d501ba67cbae1113c50fccf97155c1fa67a533ae.camel@web.de>
 <aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com>

On 2025-08-07 12:25:23 [+0530], Gautham R. Shenoy wrote:
> Hello Bert,
Hi Gautham,

> Thank you for confirming this. Let me see if we can delink the
> cpufreq_driver_lock can be delinked w.r.t access and freeing of the
> cpufreq policy object.

You identified all the spots. Please keep me in loop.

> Thanks and Regards
> gautham.

Sebastian

