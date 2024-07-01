Return-Path: <linux-pm+bounces-10281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0991E045
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467511F234FB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBA15D5D8;
	Mon,  1 Jul 2024 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6SbAHM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0315E5D0;
	Mon,  1 Jul 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839352; cv=none; b=sKMpO3N3ga4V3mC0a3t6Q6Qc9kggcL5PY+85uoBvnPIcL16Qx+k7JTfMVUAZ+Sz5oK2+hfzG3hnLf/uT9kItx0jEAaXc4cwZDfNa34Y4z3gFEDnWOyheU2mA3jfBCbRacunu4n1lCkFQzGJFoLoWmrB2I3ShvTf/8yi32EHo8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839352; c=relaxed/simple;
	bh=LkrEpxj73d56uxBlFYTh+w5xZXo7xRpTphnpn4stVps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUNdBv0S0d/nCTRNfSc2Iwht308jvQsb4+x6XijP80sgwep3TGVkMeoFl1XPEnVYVe5qkO3gGmwaxIdbGDOg/tXSi6TYXEeiNBGuf+4A4pbvXWs9zs9p5Kd9WAOZS1EvlsEx94DVYKYCwYyYlum2p2IT/zT6v4o0ujZ8xAkODZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6SbAHM6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E6oDgM5eRGEp21k/35TQj92xRJApEt6d952nIatyfBc=; b=h6SbAHM6nLJsYGpv+cgLNoTmex
	o2Hc66FqRdLIxbD/8CVOAbSkS0Aw2O+Q5HIsJMIj2dnySfGZ4tiqZSh2aOcKpmwUNJ1EoBIOmvGBk
	dyOrvyzEtaye3JvoQimUNVkj1bUtZfw2B7QflCga10D5TWue5CCFGFY5EoEZd4jdSjYWO5zffQRS6
	9/KbnRJsTW4tfMaarsvhpChC21qI1rDn91wBPOQZeQPUvFSGgBrDOmgS/44jSKpyu/CYGzdhITgn5
	MLXvFOa6OwODHX7LOK5FS9Nn93I35yGwAEKcQSX/S3+SHY73+ZW2OywGLVE05RkZM0UkCZ/SLXc7U
	5irHrvAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGm0-00000009euv-3RHZ;
	Mon, 01 Jul 2024 13:08:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06922300694; Mon,  1 Jul 2024 15:08:46 +0200 (CEST)
Date: Mon, 1 Jul 2024 15:08:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, rui.zhang@intel.com,
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ananth.narayan@amd.com, gautham.shenoy@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, sandipan.das@amd.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Message-ID: <20240701130845.GI20127@noisy.programming.kicks-ass.net>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>

On Mon, Jun 24, 2024 at 05:59:05AM +0000, Dhananjay Ugwekar wrote:
> Prep for addition of power_per_core PMU to handle core scope energy
> consumption for AMD CPUs.
> 
> Replace the generic names with *_pkg*, to differentiate between the
> scopes of the two different PMUs and their variables.

But then remember patch 2 and recall that intel seems to have everything
at die level, not pkg.

Does this proposed naming make sense? How?

