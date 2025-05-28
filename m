Return-Path: <linux-pm+bounces-27739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB8AC6B1E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952AA1BC6DA4
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A62874ED;
	Wed, 28 May 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="a9rwiP4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4228643A;
	Wed, 28 May 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440790; cv=none; b=NAJJeQyJj3GQV2gS74A4bbJKV77RGDvXrhfoAvpSBn3pmdxJejsmi6obdVPrO3gcsJ07r3WmwQ5N7205H827nBhvfJjdhQezngaaHEWWJhfaRrOfzKVnB/ZPPlW8vdyxxo1sUUb0oOQZsl5OxiDhd5/Q8r4vIvGNniSadViIq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440790; c=relaxed/simple;
	bh=keU5ngDbfNyJ99ZyYcjp9U+daYH5n6t4r62lhQZewAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9UnJvPxPqai2o3cztoPz2lCu5YflQE2Z66Lwb2KSLFh/fgbZRcZ+2Qkx43a9r1bsOyboUYJk6ke7TTsyznKd4MLRESqvnzfLm4U18Y3GX0/3RofaS4+3abb8zK0Kh2pZKfvQYBl97JbwaBpv9dY7S/GxWlRel+PqBqBiKZep7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=a9rwiP4Y; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 96BD66680C5;
	Wed, 28 May 2025 14:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748436902;
	bh=keU5ngDbfNyJ99ZyYcjp9U+daYH5n6t4r62lhQZewAM=;
	h=From:Subject:Date;
	b=a9rwiP4YBID5AEMl88r98X0/YUjecAMXTGehm+rI8XaSaDPHnfQct6wkChpjCUR2M
	 1YifvrF2Q3LcSuC5HIqDvTKY2DCp1IPDWJ5qoBN8hti6XCCZM1XTh+o3S4S1ET9/IL
	 TnFFTfvJG5msYWh8BUHEuQZIJ26ZmqMcpvEqaiOXuQBcffT7b/S86RFFbmizl60+RO
	 MnzYRJYcGRgpV/dnRppojDMibcZWpy3MvBp6JS/DRIcb/vPoVzvm52mu3jFBlFTFxe
	 HhGxzUwUZfj1mSd8OCF1nxt42gFsIEWuKMY/4mitvxFnsm7wrDcvZyaUwRAzv4tg1b
	 9spZzrow5b17w==
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
 [PATCH v1 2/2] x86/smp: Prefer cpuidle_play_dead() to
 mwait_play_dead_cpuid_hint()
Date: Wed, 28 May 2025 14:54:49 +0200
Message-ID: <3633769.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <2006806.PYKUYFuaPT@rjwysocki.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFxkQHn3iCFbbSyiDpq8O8fxHSz0xYZKn6328KRsDmyVOaUGJ5g9Pr88Mn+X1Ui8c/1Qb79P6Egeac0Wd4sy6JCX3KJ8P1U64eCx1OWa9IyZBsPPK141xkOOqyv/1Zw1QatQDlGB1yvkLOMXmCIAxkp70zSNBD+o+hqAg2qBFKsovAAPZZDWVM7txTozblkZF1eJ0XJ7pt6v7XqlFsO0rolzhHpavgnhWYGpyOXvsRTfKUvYlv9wsRDHePo6aQnJXczz+S8EYGfHpo5I4rhmR4dky+Ke+Gndp63BdmPoFR5Kj/OTkj1EaUzRCA+oOB4QoAjMMFv2OYrjxrYTUWJw73Tc20c4APwngYflEi8giQzRlt560/yFzju9koWkC242yDLQqC7sYVR1SeRj/Pv9uNTh+Oe9h9mxtQVLPALHvGM81Vaysotj4uNCPrBIKZKaj+LeTDWutps2VJAGLFbTexMH27DhYJ+SorOA3NUpZMbd15anfnRxafGyaX5ouSUbJenPXRNPCdULXesceieZqGBJEcqxrYGsXN4Y1gx4fuHfsY7W0mRke7t0MZl1qcpy5Dqjff3t4Pp9ajDtI9fs1J/ifowUmZ2P0NBQXP4NiKsUIzfvKMeeMQ3YBxVXxvmdWH366PtoP6liJLj/jpdwS+F94D5sbaqKUMmjsivEd2gbQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Currently, mwait_play_dead_cpuid_hint() looks up the MWAIT hint of the
deepest idle state by inspecting CPUID leaf 0x05 with the assumption
that, if the number of sub-states for a given major C-state is nonzero,
those sub-states are always represented by consecutive numbers starting
from 0. This assumption is not based on the documented platform behavior
and in fact it is not met on recent Intel platforms (eg. Sierra Forest).

For this reason, it is better to let the cpuidle driver for the given
platform put CPUs going offline into appropriate idle state and only
if that fails, fall back to mwait_play_dead_cpuid_hint(), which may
still be the next best "play dead" variant if cpuidle is not available.

For example, when "nosmt" is passed to the kernel in the command line,
SMT siblings are disabled early, before cpuidle gets ready, but they
need to be put into sufficiently deep idle states to allow the whole
processor to reach deep package idle states, like PC10, later on.

Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/smpboot.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1377,9 +1377,10 @@
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
+	/* Each call in the following sequence returns only on errors. */
+	cpuidle_play_dead();
 	mwait_play_dead_cpuid_hint();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */




