Return-Path: <linux-pm+bounces-17400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B159C56E1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CD51F2103C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA82309BA;
	Tue, 12 Nov 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAkHWhHq"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E6230989;
	Tue, 12 Nov 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411950; cv=none; b=u6knIELUQPWpE4evFkqQS6alSWbnDatIWNbUVqv8XsmBKkuCS81+xJb6mPZGVRM3wRXdq0QK9ome13wS5c0eX3QNWT3PFKDJNbyXdU2IaaPda168CJWaLFUPr8hZ2Un3bp3+JSZrkwdC4hLxw7XC8BfIFLRASXo6rLVSzFBB/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411950; c=relaxed/simple;
	bh=rwStpxnanly060PEUm3Ory3Ei/C3/hXuY2xfwxrCRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPr5QMR49WHUlWGsWfn77bVxyLTnsmivWXOItQgF+BgfUYKfkHWes2aQDsEQ/72uk2JQLJYm1PB6xqjoa30efWTtL2s1lLcE7yHOEVZB7TjmeFlAPHyPejEmKulTfPMK9m9zEsTpmCcs/M7zsw1CkguxjWuTvVwvPh/bFkMiz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HAkHWhHq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rwStpxnanly060PEUm3Ory3Ei/C3/hXuY2xfwxrCRZA=; b=HAkHWhHqQmq0ysSeQcV2mDrJ48
	q7nWiDT5YfVgVeDp+asNKOigehmNCDAMwbiyezP37Ho3nJ72/a/wS2rVc80QljLw+wY0vrS364kWC
	q93IwzP8NNCM1I0dvYpEHycbjt67nsusczwxVOlZQLmxCMugvd8Ly6x90tVgQLcpfvlX4a8dmCd6x
	QLn5r0mTSKkedro7OpxSBFQd4FGUeVbmnJiPb9vyHaoZkt3vnRuUzlteZc9eGWd5MFQjEWMi0llgI
	rq+TA0kv6jBPtlzZ63tJ+noGKquaxLz/jWYO8U39FbdyOvTxl2t6/tV+hmAqwOZ7/K+rTCI/mpjCq
	2/DhTcGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tApL6-0000000D3Rl-2Z0a;
	Tue, 12 Nov 2024 11:45:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94D10300478; Tue, 12 Nov 2024 12:45:43 +0100 (CET)
Date: Tue, 12 Nov 2024 12:45:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 0/3] SRF: Fix offline CPU preventing pc6 entry
Message-ID: <20241112114543.GP22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>

On Fri, Nov 08, 2024 at 01:29:06PM +0100, Patryk Wlazlyn wrote:

> Removing the existing "kexec hack" by bringing all offlined CPUs back
> online before proceeding with the kexec would make it even simpler, but
> I am not sure we can do that. It looks kind of obvious to me, but for
> some reason the hack exist.

There's a comment there that explains why this is done. If you don't
understand this, then please don't touch this code.

