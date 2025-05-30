Return-Path: <linux-pm+bounces-27840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C9AC89B7
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951947B3D48
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB0E1EE017;
	Fri, 30 May 2025 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itqviZbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22F38B;
	Fri, 30 May 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592465; cv=none; b=p/tnMcfOfSiaXAcrIQTQWhmO06NPF0xA9y+27PlhboV4RH4L8sVyUApjH70ORbgwwJJb06gG58gZAKNrzVv5m7svGBhJc8FPwzRmei/elv3Urgaw+kyMyG0qEs1QSoTIxTx0137X6CVMQhL+JqiTJ10nOWyznc+carZStNcLals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592465; c=relaxed/simple;
	bh=jeQaQmSzajxhy2ABKGDv12x6kY0gugQNU8mqqLy4bfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtBGpMfgoySj6enFfVunpl1XlERW+mXr17b8qyqMyE/XKLAY1iCpNxXpWI59cO1tbe52LRz9VJlMmfLaRKEFCfsnqO4GYGWbbx/iVFzdAIQeC2WwtZoaRKtocdfp6zaK79Vq1IQwysaD3NgulSVvT+KR29CysYrJQfseODv0NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itqviZbu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x4yJenjzPsXu4YA54k4GxvBdrJDJtbFVIWhgAuxSODw=; b=itqviZbuhTKE8rKglevp6+/8a3
	doOpg792yyQ86+iyeaJouM0F7eSW2PXqfEKD9Z6de1UM80onnwuU2K6jqphpUgA9mMWJ7vg2b3GY8
	rjLfmH22LyBdJD5vHs3R9Bmmds1pyVeLP/gfDxPe5BJYhi1XvlXyfLrsvCoJeZ4vQlqV43gK0Imuz
	z9c8q2KZUo79wdS+scP0cSLDRwShtWgJxXPLkzDS3cg/qSz0tLDDPfzrdLlhOYSUb5QDJNl2okN6O
	WrizLVJgbDKUvRVYOW35+qM0jKL2GY33TzXIfP3M7oVZZ0C64ZKllKz/qz4e3Sr7p6tYLoYDxa2ME
	ewdGL/zg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKum6-0000000Fbgg-34as;
	Fri, 30 May 2025 08:07:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2AE3830066A; Fri, 30 May 2025 10:07:34 +0200 (CEST)
Date: Fri, 30 May 2025 10:07:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	x86 Maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by
 commit 96040f7273e2
Message-ID: <20250530080733.GH39944@noisy.programming.kicks-ass.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
 <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
 <20250528160523.GE39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
 <20250529085358.GY24938@noisy.programming.kicks-ass.net>
 <CAJZ5v0hw1910Gsb57POVhax1hAbEGHa7xksr_FygNd_JL-oeOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hw1910Gsb57POVhax1hAbEGHa7xksr_FygNd_JL-oeOA@mail.gmail.com>

On Thu, May 29, 2025 at 11:38:05AM +0200, Rafael J. Wysocki wrote:

> First off, I'm not sure if all of the requisite things are ready then
> (sysfs etc.).

Pretty much everything is already running at early_initcall(). Sysfs
certainly is.

> We may end up doing this eventually, but it may not be straightforward.
> 
> More importantly, this is not a change for 6.15.y (y > 0).

Seriously, have you even tried? 

AFAICT the below is all that is needed.  That boots just fine on the one
randon system I tried, and seems to still work.

And this is plenty small enough to go into 6.15.y


diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..0f25de8081af 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -814,4 +814,4 @@ static int __init cpuidle_init(void)
 
 module_param(off, int, 0444);
 module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
-core_initcall(cpuidle_init);
+early_initcall(cpuidle_init);

