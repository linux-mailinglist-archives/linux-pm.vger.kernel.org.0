Return-Path: <linux-pm+bounces-27733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF8AC69DB
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1390A166F98
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F882857CB;
	Wed, 28 May 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ndnJc5FP"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9572214211;
	Wed, 28 May 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436916; cv=none; b=oN4wG9okM4XejT7Nj/j++D52dHxWTJ75RDze2Z8sLcPJpyY4pOeyIKkmkpu5xKjybWHjxLnTmaYl2v4rokPb8jAIQPx7x+uIC1r/Tlbpp6zY8fqweQVuvjyMnpyYdaylwXi0wAau0+ft8Vqw/LO2H6+JZHl6KoeTJzUhzBpS6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436916; c=relaxed/simple;
	bh=u06uU+f22ZydMweS4ad4ipwJZCaFj54prJ9Y8i2zNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBLvBUyjYWfZVef32EbL5fRmd0nHV0u+VnqgbHDqJxFWvArRssYgLl7z8ag9ZDUh1i4kIzWdDVkT0hhuFXMOtPmg0V5fwDQEMOq32rjOnAUzyQkqxMTAHRW1/6ZJw2BoEjqdgARtBHqOWcxAghOVPE9MQI2L9sIhM0ZV32AXDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ndnJc5FP; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6D2D166810C;
	Wed, 28 May 2025 14:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748436904;
	bh=u06uU+f22ZydMweS4ad4ipwJZCaFj54prJ9Y8i2zNxA=;
	h=From:Subject:Date;
	b=ndnJc5FPKZ/gAEhXWrUWuQ6N9zgrgwaDt4sG1DWP0owFVQwK1CZf7V3HCLkv2cHX2
	 Vpud6wmvofFI8Oj6VQryqoPqtveIFlwXF6gBVPfR9m0i0XuxdjgA/L4yVB2OxZ/alm
	 uGdy/tdhka3APiXK2yPQIWaQf6BkyPiQsNrvicF3jeSY/WgCVAw9vNb/0Qpz6grmvn
	 uEZJNphV2DHygPhapge0M1qhWVO4Pv6egj76Vf7Mr2n+VgT4HfVLGYOISquf4OqYEL
	 g2QNMwFWsEV0YVZPoJcrfoiZ70lJTSx3zhosD8y2QYFxXAbmXtuZES0XRjfJsAiANR
	 opTZ0doBCBCpA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Todd Brandt <todd.e.brandt@linux.intel.com>
Subject:
 [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit
 96040f7273e2
Date: Wed, 28 May 2025 14:53:13 +0200
Message-ID: <2006806.PYKUYFuaPT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEHEdcPvDb44RX7oLy/l0XZsAaDsySGk2yiU1eNtMaRD1jj7PwTFn2xAYp8o0iAjmTVoe6ZGZaOOMsZJ49A4eudkghxFhzckY2diivE17GlEIoxg8trE3zRqjV8o1kzpBEeyA4kmvhEP8t9tE65NjajAvWfVkFgA181gCxV6f8eY7uKPMacthbKQ3Wz9UMXuYmHytYdGi64pBHYmmT2Ez24Ij5HjNr+/vUcx/BtM21yBQTYe5pReKOOdaAoHDKaLGS+flJe0i2Hnac7cR4W640PkdYrwZeJ9l9p6kmWypBNs+6zOHQhZIav6rMmxp2+ZzutyIyh9KbgLbUrwlyhqOqdtl2rGjTR5BH9A90WJYQyuIZurD17gJfpCkyLGNysSpxtW7hXgoSYIra1Vf33ek+bFEz6UddXUA/mwUC3mCONoWF3H1gmhoE3XsXPCpfm8yWTyMdi/ClUWfpSzCrtYPaZx7iM52v158hmVMM8NGgrnMCVo+EokCwQNDW7DcJ1MZ/K/cNm4omDL2tNcglj+gjRkxhMcGvexr96oj8BqOdFVIW3zxovRr/D3RjjHBj9iWkH+9lE1Yvk4IEUnxYZMsR0dQQSHj59TQkzopjwVGSB2EMZOqr6j8tY6TywLhLCMl4hFxYK60pOTdWG2WlfYrIRARlPzTBPqVQG7yeOR4IygA
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

Hi Everyone,

Commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
that shipped in 6.15 introduced a nasty power regression on systems that
start with "nosmt" in the kernel command line which prevents it from entering
deep package idle states (for instance, PC10) later on.  Idle power, including
power in suspend-to-idle, goes up significantly on those systems as a result.

Address this by reverting commit 96040f7273e2 (patch [1/2]) and using a
different approach, which is to retain mwait_play_dead_cpuid_hint() and
still prefer it to hlt_play_dead() in case it is needed when cpuidle is
not available, but prefer cpuidle_play_dead() to it by default (patch [2/2]).

Thanks!




