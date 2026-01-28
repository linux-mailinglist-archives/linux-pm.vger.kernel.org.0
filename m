Return-Path: <linux-pm+bounces-41652-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL/cDreOeml+7wEAu9opvQ
	(envelope-from <linux-pm+bounces-41652-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:33:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC9A993C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 822B730098BC
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE43344DA4;
	Wed, 28 Jan 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihjnMdmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733D343D75
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639604; cv=none; b=qYmLS0nAKqRerAt/Ir51Ls85wTAU88YXCblWjD5UrqMOrqLVdrQpALf4wWlvtRQui1RWANe4xq0KdvpxSjhY2JJfFEgKdgNXt2wYpnPKAIk1fs2+Ngtf0HfTiphYeM+QMdbIueKqEp6xp3hSEz5NAJB8xhO9cK3YcuxfIMyH/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639604; c=relaxed/simple;
	bh=D9uKfpeWHNBio5oH1DcAL26H2VLljL1egsD4t2eIGUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bu8+8M9yAryIWDXN3Yo3E/PFC5tHhyqEr0p2LcTaHU9CcIi5sDlrf2kAnOcxI3MFqt9Unm6PUtmmKC+pc1JXgJCCut3tqiuPQ1e9ZXhxiEv8G3EG/a54G3/wLf3DYaWZyadYNBN8uYpDo5eVEjrhUfUtfan1l/tbvA7obRDxnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihjnMdmz; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c532d8be8cso42118385a.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 14:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769639601; x=1770244401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njPB1RSPP56Oj1b/hlNI9WV3wRfeQUwqPZNJy/r65hY=;
        b=ihjnMdmzyIAu36TmcwXhKfVzu3JjtyqTU8iGLxqe+j52JdUQtBgR4fxQQ8HgPgYUCj
         TX1FG9z88Z7epVgKC1wzP3om7sUjDCdCrVGzxHtzv012pkfnbu4yhY2+mwwG3Tj+KWqF
         VR4FOKgDw37MdnL/xupwdjmKxaBfnvH565DoyXWgDDPeHhoFr1wKM9092ceVFXRLHfC7
         hWUX/6oyif8iNrJcPVRgqEtczK/iW27bO+jBhcxsqCKMb4AjxrNsIQ1xM/PWhMRLmXME
         X14gPh+Vqr8xNxt1aJubx3A0B3JVgE3oaHe5sD6dJ9+6oaTfHWR1ZUiEoVl5zR8gw55R
         S48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639601; x=1770244401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njPB1RSPP56Oj1b/hlNI9WV3wRfeQUwqPZNJy/r65hY=;
        b=P0a3mduEHZz87ydQEdTvSmdks4P8EnTMkE7jrjy5ahiVsmuALZ3xnbuJPugpkfK5V8
         Ah6WoP3xpCpl8Hzd4N6E7Ei6nwO58nOxfrlcfRPsHYbF6+sJvCpESCz1dSkviBNm19nW
         o/OJ0HCuWez1XyAKr/4a8ifzPf5zYw0WxDHbpjvo6MphxzH6LN38ZZ1tEpr/wEYdnWPe
         I7CTsxuSF/kn+RY0+9D8CALFMKEzm2GGs0KC6JG91MosZE1+FjZbYwwAvGkkQXK0/Jrz
         WsYelH2y8wzDR+Wa2Atc1AUoMDwov6JFLwK0j7O3A6Htst6nBKHBxC7zsAKJLn4BUput
         MVFA==
X-Gm-Message-State: AOJu0Yxt2S73GMgrlsRc4z/71HVdwRnmTcIkB6/qY6Bul9Sh1D4akggQ
	f76Q+L254U0da+xY/r5oY17O+uyEvXYoCCbSi6OVtAFUM/nRFnf6NNmjtlNTW2Fhh7U=
X-Gm-Gg: AZuq6aLca+ifaJJj4AL3ckb9KsW98mZ0FD9430WKf5T7G1UCfdY7uIcXfBsiWf1Xp4Y
	CSdOTBriZ4+yKH40kFjg6G8Uw8oMU/rJSAonvk+SBbXHLVgokqbR3zSt3q6w65r3SR9GyfeM6s0
	AH43RNhqxOd+qTAva1XW9vu8nGd+S4lEQd029Uc8MNiMqmX/O+boTKorNTyhvjE2EYzIVMSfXNX
	kGR10encSJBAdCUC59y9F/ULqe2FLkMN/3wbhwTyFR/zysLU0jGdlvQqhKnS58lihNJAW7J/kuL
	cZdr0pFso6Pd66yg+cKTswAH4kt2Q19lblHGVLEJA1XrI9qGD03F6kJz3GbLGufITdzN6nPtVi0
	8K8Ma9WFehcn22E4TKhUNkmlcWVMocO2iSPjOpwxSa5UGB7mHuZUWS+tkFQAK80V/yKa4DiSbsv
	lEf7qCAV/Mz5volUT2SUrJQ3fMBlTUTjQ=
X-Received: by 2002:a05:620a:3942:b0:8c6:af5b:d50a with SMTP id af79cd13be357-8c70b8f2f76mr850329385a.43.1769639601472;
        Wed, 28 Jan 2026 14:33:21 -0800 (PST)
Received: from [127.0.0.1] ([154.7.78.65])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8c711b95e4esm304528085a.15.2026.01.28.14.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:33:21 -0800 (PST)
From: Patrick Little <plittle@gmail.com>
Date: Wed, 28 Jan 2026 16:33:11 -0600
Subject: [PATCH 1/2] Documentation: Fix typos
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-documentation-fix-grammar-v1-1-39238dc471f9@gmail.com>
References: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
In-Reply-To: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
To: Joseph Kogut <joseph.kogut@gmail.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Patrick Little <plittle@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6507; i=plittle@gmail.com;
 h=from:subject:message-id; bh=D9uKfpeWHNBio5oH1DcAL26H2VLljL1egsD4t2eIGUM=;
 b=owGbwMvMwCW2/Ptzn70V3ucZT6slMWRW9a3b4iUrOlnJm/t5xOekCcvdK75GCrT9sTh9UnOuZ
 NeqhVrLOkpZGMS4GGTFFFl2uokVZjlPz53ptXoSzBxWJpAhDFycAjCRUxsZGc4qzdhbFmt8uWrt
 0XT93JeVHUnBGbs2MjyUWb9v4cntiwMZ/qkruO+xbVkgXhF6rabD5pt4jf++r/48d+7X9MgLeZo
 v5AUA
X-Developer-Key: i=plittle@gmail.com; a=openpgp;
 fpr=B94616716A43976D994AAB92A7F7E74CBD784BCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41652-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,arm.com,kernel.org,lwn.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[plittle@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C0FC9A993C
X-Rspamd-Action: no action

Fix typos in Documentation.

Signed-off-by: Patrick Little <plittle@gmail.com>
---
 Documentation/power/energy-model.rst     | 14 +++++++-------
 Documentation/scheduler/sched-energy.rst |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index cbdf7520aaa6..65133187f2ad 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -14,8 +14,8 @@ subsystems willing to use that information to make energy-aware decisions.
 The source of the information about the power consumed by devices can vary greatly
 from one platform to another. These power costs can be estimated using
 devicetree data in some cases. In others, the firmware will know better.
-Alternatively, userspace might be best positioned. And so on. In order to avoid
-each and every client subsystem to re-implement support for each and every
+Alternatively, userspace might be best positioned. In order to avoid
+having each and every client subsystem re-implement support for each and every
 possible source of information on its own, the EM framework intervenes as an
 abstraction layer which standardizes the format of power cost tables in the
 kernel, hence enabling to avoid redundant work.
@@ -32,7 +32,7 @@ be found in the Intelligent Power Allocation in
 Documentation/driver-api/thermal/power_allocator.rst.
 Kernel subsystems might implement automatic detection to check whether EM
 registered devices have inconsistent scale (based on EM internal flag).
-Important thing to keep in mind is that when the power values are expressed in
+An important thing to keep in mind is that when the power values are expressed in
 an 'abstract scale' deriving real energy in micro-Joules would not be possible.
 
 The figure below depicts an example of drivers (Arm-specific here, but the
@@ -82,7 +82,7 @@ using kref mechanism. The device driver which provided the new EM at runtime,
 should call EM API to free it safely when it's no longer needed. The EM
 framework will handle the clean-up when it's possible.
 
-The kernel code which want to modify the EM values is protected from concurrent
+The kernel code which wants to modify the EM values is protected from concurrent
 access using a mutex. Therefore, the device driver code must run in sleeping
 context when it tries to modify the EM.
 
@@ -113,7 +113,7 @@ Registration of 'advanced' EM
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The 'advanced' EM gets its name due to the fact that the driver is allowed
-to provide more precised power model. It's not limited to some implemented math
+to provide a more precise power model. It's not limited to some implemented math
 formula in the framework (like it is in 'simple' EM case). It can better reflect
 the real power measurements performed for each performance state. Thus, this
 registration method should be preferred in case considering EM static power
@@ -172,7 +172,7 @@ Registration of 'simple' EM
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The 'simple' EM is registered using the framework helper function
-cpufreq_register_em_with_opp(). It implements a power model which is tight to
+cpufreq_register_em_with_opp(). It implements a power model which is tied to a
 math formula::
 
 	Power = C * V^2 * f
@@ -251,7 +251,7 @@ It returns the 'struct em_perf_state' pointer which is an array of performance
 states in ascending order.
 This function must be called in the RCU read lock section (after the
 rcu_read_lock()). When the EM table is not needed anymore there is a need to
-call rcu_real_unlock(). In this way the EM safely uses the RCU read section
+call rcu_read_unlock(). In this way the EM safely uses the RCU read section
 and protects the users. It also allows the EM framework to manage the memory
 and free it. More details how to use it can be found in Section 3.2 in the
 example driver.
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 70e2921ef725..4e47aaf103eb 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -244,7 +244,7 @@ Example 2.
 
 
     From these calculations, the Case 1 has the lowest total energy. So CPU 1
-    is be the best candidate from an energy-efficiency standpoint.
+    is the best candidate from an energy-efficiency standpoint.
 
 Big CPUs are generally more power hungry than the little ones and are thus used
 mainly when a task doesn't fit the littles. However, little CPUs aren't always
@@ -252,7 +252,7 @@ necessarily more energy-efficient than big CPUs. For some systems, the high OPPs
 of the little CPUs can be less energy-efficient than the lowest OPPs of the
 bigs, for example. So, if the little CPUs happen to have enough utilization at
 a specific point in time, a small task waking up at that moment could be better
-of executing on the big side in order to save energy, even though it would fit
+off executing on the big side in order to save energy, even though it would fit
 on the little side.
 
 And even in the case where all OPPs of the big CPUs are less energy-efficient
@@ -285,7 +285,7 @@ much that can be done by the scheduler to save energy without severely harming
 throughput. In order to avoid hurting performance with EAS, CPUs are flagged as
 'over-utilized' as soon as they are used at more than 80% of their compute
 capacity. As long as no CPUs are over-utilized in a root domain, load balancing
-is disabled and EAS overridess the wake-up balancing code. EAS is likely to load
+is disabled and EAS overrides the wake-up balancing code. EAS is likely to load
 the most energy efficient CPUs of the system more than the others if that can be
 done without harming throughput. So, the load-balancer is disabled to prevent
 it from breaking the energy-efficient task placement found by EAS. It is safe to
@@ -385,7 +385,7 @@ Using EAS with any other governor than schedutil is not supported.
 6.5 Scale-invariant utilization signals
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-In order to make accurate prediction across CPUs and for all performance
+In order to make accurate predictions across CPUs and for all performance
 states, EAS needs frequency-invariant and CPU-invariant PELT signals. These can
 be obtained using the architecture-defined arch_scale{cpu,freq}_capacity()
 callbacks.

-- 
2.51.0


