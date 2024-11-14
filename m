Return-Path: <linux-pm+bounces-17561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73159C8964
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 13:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B74FB22D1D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623B1F9416;
	Thu, 14 Nov 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mtOgP2S0"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63951F8931;
	Thu, 14 Nov 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585519; cv=none; b=fmEDIlrxDne4CzDPPWldAjpOUs2jotmRgpUUAFFLG6Ptp4zpHpVi3M6PeldsGENQZWvdMS3HGqiR3aN6T8w7+RF6Uf3KmKqvrSH/LBayUfyfiVvtTkvMCfIZV4YUHUF3RdazPhHAQ0LK1rVxUZPBTzkzANFBm8F5Bl+cqKzsg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585519; c=relaxed/simple;
	bh=opbrCb2+/EFIFD1/+ST5yY9PAJrHhAjniteJAzszCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjMyoFtPXEqFfClYMyJhlo+GQL3SRMNv/TYFD49LXfWxmhVSAurOu7Jx7ZbC//QlBBocOOv1O+Pfq7sFRenSnBg79zfZ05WfFX5kAVQxTbqhwvu4VLAHEYsoix1iwPcYVbyh7v+SudqIucmSWcowLN+PVJ+PEqeFONDaAqY7mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mtOgP2S0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4kaHGJ5S7sZTzNrqIdngW3WAgdJKt+QVgXkqBlwP7j8=; b=mtOgP2S0lpX130zqNUPnPIrcfo
	nFA7r6l3WhBBD2baemhkaUw7KwGsQYTqG1UvmelOqtsZFQC48GUZSDpZk332CdzkTUsRV/2taUZRN
	dadoU/gfs1DPBeaK6T8klVovyRJtTYQtQFKBI9EyXlzcnlI9Gs53jcYBORV8l4BQhI9DSQbKvqIZc
	ewgW4q+Y0jlTykLi1foUHeSjIxrukVnmv8hqcUdp5bpoL15r5KG8GcPo7vTBIIx3RLIUiuq3ejgdA
	7hTYOncthUisi+4LUDiuW2KLWLa0BEgYO7aufCnadHxTz/ie4KjGcpL7kq3DB0+Cw86jAO+lhmwDF
	ZK6EzoyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYUa-00000000gVY-1c7W;
	Thu, 14 Nov 2024 11:58:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08B30300472; Thu, 14 Nov 2024 12:58:32 +0100 (CET)
Date: Thu, 14 Nov 2024 12:58:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241114115831.GQ6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>

On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:

> AMD platforms won't be using FFH based states for offlined CPUs. We
> prefer IO based states when available, and HLT otherwise.
> 
> > 
> > Robustly we'd teach the ACPI driver about FFh and set enter_dead on
> > every state -- but we'd have to double check that with AMD.
> 
> Works for us as long as those FFh states aren't used for play_dead on
> AMD platforms.

AFAIU AMD doesn't want to use MWAIT -- ever, not only for offline.
Confirm?

But if it were to use MWAIT for regular idle, then surely it's OK for
offline too, right?

