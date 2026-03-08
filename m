Return-Path: <linux-pm+bounces-43913-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIKjCs0GrWm7xQEAu9opvQ
	(envelope-from <linux-pm+bounces-43913-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 06:19:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2422E951
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 06:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C96A3014428
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 05:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A282BEC30;
	Sun,  8 Mar 2026 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Eke5bygl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kZQKc6Pi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A92C0F97;
	Sun,  8 Mar 2026 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772947106; cv=none; b=Zk5aPExZrGp2v/909We3GMPMeNYuvTlqVl/31Zl0z9S3TovMfIbvZm8QzGxwhKlAeMdLKsfZNUG34SdCysRcrDAOGBmD42r0qdjoUFJN5xrE5kdWyt44g56SP1LXtvIFlLeJtxkLpjl3HfOwSwppNeUcgjS0HDfIYTyEH3F5vMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772947106; c=relaxed/simple;
	bh=jkMSpeyiXMumeCgs7R3LeudHrmmiyPYo7I0sKbUDMdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wl0rbNub+1t2V4rTsmOWDt1KajEUJNe/qqgQ6flxr9PugRXWy2uIxWjmLfpBdX43n7U+Yar1wUIHGCNqlobXJpS09keBWI6JlcMd46+RvThJKctYU4h4ULGNK2kp3Zd86ah1m8EafGYRLb23m3GBqiIp9ppg6swv24ecWq9lmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Eke5bygl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kZQKc6Pi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fT7hR4T1Pz9tcd;
	Sun,  8 Mar 2026 06:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772947095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0TE+7A2kmuKkKWE6ucMW8ur0y2V3+9v8BXKbbsXZtiI=;
	b=Eke5byglpJoybzZexXW6CuxnwDdIUQsu04QfrjTdBdR3rhrFiUFolpgqtczTojHb9TPEbF
	nep9f1EvQrVA/AMxj4y1vvcA4Q3iPQyJtxPUzeH/+UxbquTi8ASQ+GnZW3ByRMkmlwiFEK
	zPCZY6Um1R/M7AUsU8hs+swJMQ4OHMYF1OluOYFwobTcMbeoYBLItPPpVTq7hv2Mu5hXp1
	K69svMqxl8ZRgUi4hHGzNjsFFLZFG/hS1gXJZWI6HTHkdGI44yYhF0a6+UXD2iAsMQs/rL
	CkDM91Zv/xftzUCL1O/0QGqCzI0h2K80OBEME8cEcoMN41pSwTTV4DIPigx1IA==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772947093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0TE+7A2kmuKkKWE6ucMW8ur0y2V3+9v8BXKbbsXZtiI=;
	b=kZQKc6PilSaJml360PU2s6sIsSjaLz0jsecj3ld0mS2Beovyj9UYs4u1wgZIpAfLIcixwm
	825LZMLnGXtc26Nk0M1BBJp10NHUjkt640Oz3U3erm+W+JSw6Az8pCg7bfdm2+5TRHFa/a
	oWm8NuE9YxfZtz17aY0N9nckKlo4TolOCszzTa82sS26ZmMthx75g1+agOmhm48EgxsmQY
	Pa5o8FzlcgPjQe9RKbdvekF3ts1+R9p2NGr/swbIrP6c22RqEVUyfdwWkei3ypwDa+iNmZ
	yWKQc8znOFVZibuHRk9fmXkDiGEiBYCgbVJvKO0q520vLKunirjz2uvTu8mFMw==
Subject: [PATCH 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
Date: Sun, 08 Mar 2026 13:17:38 +0800
Message-Id: <20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMGrWkC/22Oy27CMBREfyXyuhf5kWs7UVXxHxULP67BgpDUT
 ikS4t/rhm2XM9KcOQ9WqWSqbOwerNAt1zxfWxBvHQsndz0S5Ngyk1xqrriBenJx/oFISwWFVjp
 jnTOoWVsshVK+b7TPwysX+vpu0PVVssWt4dSQ7QF7H/tkJA+EXGNE6wdrI9kkjZLc+L5HI+mPO
 1GtblMZu/fNRHINdXGBprzCIuDWAweb9IBxUFYI2pdcQ11d2YV5+vgfojjCWUC4nKFpw02AAOe
 Dsxg1Sa33k8sXP993czluCO8qQeO107FDoXsaEJu6ShG5bUM3oEKhpEpohI7JNyF2eD5/Aax2d
 T9nAQAA
X-Change-ID: 20260307-shadow-deps-3582a78aa756
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772947080; l=2292;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=jkMSpeyiXMumeCgs7R3LeudHrmmiyPYo7I0sKbUDMdo=;
 b=RQaAAJGU1ge1++GAza+Fbqk1kkbMrqJ90icGN/P4rTL6Er2uFx4fFtXtrMOZPllFaCmmZIfXI
 iR3tl0U5obuBFUNHQuURrbCZiQ+FHhNl+zgsq96/sQVDPnvMlAm/Tgm
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: xaggukirckx879mdesfjst8tnpxrc4ao
X-MBO-RS-ID: a621523f8cf1d5fdc33
X-Rspamd-Queue-Id: 94C2422E951
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43913-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuwei.wu@mailbox.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,riscstar.com:email]
X-Rspamd-Action: no action

This series enables dynamic voltage and frequency scaling (DVFS) for
the SpacemiT K1 SoC using the generic cpufreq-dt driver.

Tested on OrangePi-RV2, the execution time scales as expected
across different CPU frequencies:

~ # echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

~ # echo 1600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.07s
user    0m 1.07s
sys     0m 0.00s

~ # echo 1228800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.40s
user    0m 1.40s
sys     0m 0.00s

~ # echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.72s
user    0m 1.72s
sys     0m 0.00s

~ # echo 819000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 2.10s
user    0m 2.10s
sys     0m 0.00s

~ # echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 2.80s
user    0m 2.80s
sys     0m 0.00s

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Shuwei Wu (2):
      cpufreq: dt-platdev: Add SpacemiT K1 SoC to the allowlist
      riscv: dts: spacemit: Add cpu scaling for K1 SoC

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 34 +++++++++-
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 86 +++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c            |  1 +
 3 files changed, 120 insertions(+), 1 deletion(-)
---
base-commit: 5164e95565d3fd508ca8a95351323f5716dfb695
change-id: 20260307-shadow-deps-3582a78aa756
prerequisite-patch-id: 154bd4f720ce5065d58b988de8f273207b44572e
prerequisite-message-id: <20260206-spacemit-p1-v4-0-8f695d93811e@riscstar.com>
prerequisite-patch-id: 5da3e75b18291a5540d4f66d7a0600fb8975ef62
prerequisite-patch-id: bcf41917414ecef8cf743095d130f6004c32f6a5
prerequisite-patch-id: cfe3800f8c791ec4c63e070af9628e88e0fc31b9
prerequisite-message-id: <20260305-k1-clk-fix-v1-1-abca85d6e266@mailbox.org>
prerequisite-patch-id: 7c7fb9f87dba019ece4c97c45750349a7cd28f3a

Best regards,
-- 
Shuwei Wu <shuwei.wu@mailbox.org>


