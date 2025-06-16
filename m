Return-Path: <linux-pm+bounces-28853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FFADB8B8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E01723D7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969D288C04;
	Mon, 16 Jun 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="SAeJUQgu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FC2853E5;
	Mon, 16 Jun 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097964; cv=none; b=VLxU1vCtUCABzevzoadYphhDYzTopogmgzJIVmMZrhRUfxWPYSM4umAyFPrGSetfBteu227tLdUCc+yGMVazo3An2m/aT6CSM5AOg7tmik6brrMkQgndZU5s97fH3sIxq7wnLUTAZN3eqRRsQqfUp2ewFvH8zIDBdhzDrZ3t+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097964; c=relaxed/simple;
	bh=D4eLze5Axvit8hLX0d5/vlrb0Iv++TCuRDiYVH+TJOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aknOozEXp4jGHbNR6eP8TRMmMfTw6/wXJtsKsy1pnx1JAhOqVGn9O6JGz4QrroZ+0IjS5sxPEBy26B2iuxk3Mzz2F9nWdj8bUwOPPxPhoi9ymNyNB9Xtptfm9wz7m4QOQXmVIq449NBVM/88WJAYhP2DmU9uaTsXhfV6uQvnjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=SAeJUQgu; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8119366DC60;
	Mon, 16 Jun 2025 20:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750097960;
	bh=D4eLze5Axvit8hLX0d5/vlrb0Iv++TCuRDiYVH+TJOM=;
	h=From:Subject:Date;
	b=SAeJUQgudqQJESLvdmzjn7dL5BgbpVN/e0qT9VLREuEFIUa6ynhibUJ/F9RVKB0NF
	 2+k3Sfo1MhnHlER3AhT6uYWfTWWFeOc5gWzVumMwu5ipu5VEOWA49sx2+uBs1hgucl
	 ds2IKisES3SKizu4mzruO6jKPFjUf5uluLwqy1ispkWKiM0CDLIz9CYyE7R1yOzbo2
	 4gQrSUOeoP2N5yiWl5CrNwnX+F2uN9jbKTxo1MnoyslqKC1MEqz0e8jwReDSxHblfl
	 4VpYyoW51EqbDrYM27FffizrgIqjias4LCKaNXmPLLQRVAEJwZHiMxmeB4MzlhOkjr
	 L5fu5BYBTWKsA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Shashank Balaji <shashank.mahadasyam@sony.com>,
 Russell Haley <yumpusamongus@gmail.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode
Date: Mon, 16 Jun 2025 20:19:19 +0200
Message-ID: <6173276.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTF/I4x6zZceSr9PpSvCQ9iNejtSEb4amLQZYAOrXMGCwU3OPukZULDXLJRB2Ru/igCon2RjW5s/5tXTxXUbO4u2LLgc7+RQyZFuID53nbnaLXshf7Pa7GSn7fhNSfsecRRfQR9H6mHErZLFTVqaoS6sdnnM8kaYymqvDuhRZnasowwmF/Rnd/HfXRMw8GQG4zUE946pZo1MLH0KQfwO9rAhzoVDoLNDvD5qlqXn+FdCjRcAcD9lZ1EYhHFXyhaXw2MYRV4OXUQwwmf4uDzEcvT1EWQxCzyuh/qXTaAk0v6gHJ0+W6gmwB5Mbo1ayn+BI43KxwcVPBhZWO9lE4ef5c1/crmURsPWB7OKlACH63XR0HvlnAQblV4EuAldnPzSM3SnIfkxOtda+rDBCIMRNjHAAl1OH+wDD2TNNDOMjWIC6JgFMDSFz6sVjlzPyxacQ31SZAlnnGI5KLh2XNd1t4yjc4JG8GngHmds0UOUc28Eneysb7waTukQ6PrNZgkztlpDV8ubwwcJtsBXYvODr8qToZfB0dRnBlHn+7hfJlpvKVpWdDI4vLmz/ztO8tvD3p9FJwgpqnry/iLXuqeRZW9iyysaClNhbB6kRExudVvbJh8ETKwxtjHNyZbBNkSIRmnHhusI5BfJhagZ7Bni7YvyNGYbM2XsgZsHjfhlKuuYsA
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the passive mode, intel_cpufreq_update_pstate() sets HWP_MIN_PERF in
accordance with the target frequency to ensure delivering adequate
performance, but it sets HWP_DESIRED_PERF to 0, so the processor has no
indication that the desired performance level is actually equal to the
floor one.  This may cause it to choose a performance point way above
the desired level.

Moreover, this is inconsistent with intel_cpufreq_adjust_perf() which
actually sets HWP_DESIRED_PERF in accordance with the target performance
value.

Address this by adjusting intel_cpufreq_update_pstate() to pass
target_pstate as both the minimum and the desired performance levels
to intel_cpufreq_hwp_update().

Fixes: a365ab6b9dfb ("cpufreq: intel_pstate: Implement the ->adjust_perf() callback")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3249,8 +3249,8 @@
 		int max_pstate = policy->strict_target ?
 					target_pstate : cpu->max_perf_ratio;
 
-		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate, 0,
-					 fast_switch);
+		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate,
+					 target_pstate, fast_switch);
 	} else if (target_pstate != old_pstate) {
 		intel_cpufreq_perf_ctl_update(cpu, target_pstate, fast_switch);
 	}




