Return-Path: <linux-pm+bounces-14614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDE9847A0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C212828B3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCB1AB502;
	Tue, 24 Sep 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nixSv3zh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sHp/KihZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158951AAE28;
	Tue, 24 Sep 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187854; cv=none; b=nTWcceW+Gxi8sxCELKxxl9Z77MuNCDovYIlFRZJ444LUCoDUS6JDz+j9W7i5oPcGHxEsc9tl33jB9Ql5G7Ei+wNab0pp3hnQ/5UIeStfow/fAf6HOCZTFpQ9EKR7u15w+//wtYLUbTKDwzLTiGzgwgVwKFfDZtHxSPf5PH6ePbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187854; c=relaxed/simple;
	bh=JcCYzesWxqDtx/pR9FhSxH4KbXiRZHPFo5QQaciYBFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omn3Cl45zEXWLRIiFYwzgYTLZKS44CNbw6LLBQO4dtQVl1QXISxVStLLCX5l9OP/seQXmQE69TCGpTj/68uR90eLROjO0eiVZxxF7R+ebRF/VxXfSIr1QDag1X/imqdqs1WpT5KjA5ewGu9aXabfkS/FT36RM5nWi4oXFuFDhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nixSv3zh; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sHp/KihZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XChlq0LYnz9trK;
	Tue, 24 Sep 2024 16:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1727187479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBYNsYxxyqoLVlRhhufzAZNp5xIY9E3/4hpzU0yAgig=;
	b=nixSv3zhZusg/TK7WaBoTgAWWWANA02Bj8glSU3Btcf4G8jBkRBxGuq3ruPo8lvuLYbfEK
	OWmsEtTrzzXgVDkLs6d60/0GkurdRfuOeViLp4mS1ezeqQ7LPpeePQ23dtzC7ee2yFot/F
	ySlomJly04UWA/earKCXVd1pet3K1p0E4gPijt91PN8qWBjgf/+gH3E/LL69SXs5p+/Bbq
	j9PJDO6ERwD9dNBSQeRS85DyLIuGaSQxnka3CmCqziHsNuIRP9D6PmshbPdTU43teUx7Tm
	BZbPbI84911vOX4u1279iYCobzqZ0omBTEdRJOavvxYT/eTjMsU1KxeaJsiFVA==
From: Tor Vic <torvic9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1727187478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBYNsYxxyqoLVlRhhufzAZNp5xIY9E3/4hpzU0yAgig=;
	b=sHp/KihZkEC0YwBhSNBjbVrCi07s3Rs7f8xsHRqVhNGz+q6s3JugJpDTh4oG5X2pcfbu0p
	6CtjkWDU1l60F3V5H9X/a1gvj2hQ91NDsMnb5n0hRrYzELg27lPhZK38/YaJmApikotFcP
	0H551wirnE+mO1c6a61rl3BLohfANGlK1Ydp5KfezOkz5pM19I/8+jtWtFGXh1KLuwfftd
	TAZcdmzUWE99i7BUldohAzFEiXizR78EVhxC2sG4UsvL+Em8XNjI/wWj8eVSwZyJT68DrF
	JKlKD5Vddc5eN0FciW0uWFeACtlCESvQz26wh7/LvvEF7NK+Ran8LvVCTIBRMg==
To: trenn@suse.com,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tor Vic <torvic9@mailbox.org>
Subject: [PATCH] tools/power/cpupower: Add documentation for some recently introduced options
Date: Tue, 24 Sep 2024 16:17:47 +0200
Message-ID: <20240924141747.6428-1-torvic9@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a4d2ce7d405e0b5a525
X-MBO-RS-META: sfpe1ie5y3mfyddnq4wmqbzgbw5js8t6
X-Rspamd-Queue-Id: 4XChlq0LYnz9trK

The 'cpupower-set' tool has learned new options with commits:

  f2ab5557119a "cpupower: Add EPP value change support"
  df8776b03689 "cpupower: Add support for amd_pstate mode change"
  eb426fc6bdd6 "cpupower: Add turbo-boost support in cpupower"

However, the corresponding manpage was never updated.

Add a basic description of these new options to the existing manpage.

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 tools/power/cpupower/man/cpupower-set.1 | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-set.1 b/tools/power/cpupower/man/cpupower-set.1
index 2bcc696f4496..500653ef98c7 100644
--- a/tools/power/cpupower/man/cpupower-set.1
+++ b/tools/power/cpupower/man/cpupower-set.1
@@ -3,7 +3,7 @@
 cpupower\-set \- Set processor power related kernel or hardware configurations
 .SH SYNOPSIS
 .ft B
-.B cpupower set [ \-b VAL ]
+.B cpupower set [ \-b VAL | \-e POLICY | \-m MODE | \-t BOOL ]
 
 
 .SH DESCRIPTION
@@ -19,7 +19,7 @@ described in the Options sections.
 Use \fBcpupower info \fP to read out current settings and whether they are
 supported on the system at all.
 
-.SH Options
+.SH OPTIONS
 .PP
 \-\-perf-bias, \-b
 .RS 4
@@ -56,6 +56,40 @@ Use \fBcpupower -c all info -b\fP to verify.
 This options needs the msr kernel driver (CONFIG_X86_MSR) loaded.
 .RE
 
+.PP
+\-\-epp, \-e
+.RS 4
+Sets the energy performance policy preference on supported Intel or AMD
+processors which use the Intel or AMD P-State cpufreq driver respectively.
+
+Available policies can be found with
+\fBcat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences\fP :
+.RS 4
+default performance balance_performance balance_power power
+.RE
+
+.RE
+
+.PP
+\-\-amd\-pstate\-mode, \-m
+.RS 4
+Sets the AMD P-State mode for supported AMD processors.
+Available modes are "active", "guided" or "passive".
+
+Refer to the AMD P-State kernel documentation for further information.
+
+.RE
+
+.PP
+\-\-turbo\-boost, \-t
+.RS 4
+This option is used to enable or disable the turbo boost feature on
+supported Intel and AMD processors.
+
+This option takes as parameter either \fB1\fP to enable, or \fB0\fP to disable the feature.
+
+.RE
+
 .SH "SEE ALSO"
 cpupower-info(1), cpupower-monitor(1), powertop(1)
 .PP
-- 
2.46.1


