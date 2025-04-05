Return-Path: <linux-pm+bounces-24836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F4A7C6F1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD1316ED2C
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92F1392;
	Sat,  5 Apr 2025 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gxE6oNB1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839233FC2;
	Sat,  5 Apr 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743812093; cv=none; b=Xq9siVwGPVP0LejEgkGzV6khs3kqRPUul+e13X6n/imUYJFwrC7TdZONmu7Pv0FEb15VEZwbuKeaqaJP1UbbXidBVObDCJMLCRlDoEWAJAObWeKUW7oU1m91rojcSiMZkU+DuR6hR0EUMTVrpCB6QEztPUsy9wF0NXtyfVBkQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743812093; c=relaxed/simple;
	bh=2PDiuHCv6NuIuQn7IFy8fJ19sOLKo5hhh2nWhtmTanw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0m4lsAj9qK6plWw9DWBjG8FzmW4hYBcjpi1QdZH8RzvKpv5i/RuLizbZ5uMg6WsoT/k2WD/DnkMNnu8Ow/Y22IT5aR8Rqksv5ZV8rwtvCg2D2bgxKNlej6S2+zDEZUfBnl2gN179gdMRNQSgyV6DLwIYHjEt2SbyfAEhtXXirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gxE6oNB1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+LNAEAqr4R8wtjIDx+9s5/FKgqYgAbqHcHA0HXz/Cpw=; b=gxE6oNB1pYm3i/LAvot8m/u5Nz
	Ik67ru1tpkxKAZVvkJ3MpIoWpdQ8HzX7p3GM4iKn/lP5S9e28UqlmhoMfFqy2/4Zi0TdSe/MDupup
	t60fFuJX71qey+0cycQR25zkzi1n0aCc1cemqfSX5p206X9E8sy15XRWdpudUs7vQmSzI8hkK56C9
	+SZReB5NaNnhtun1YuAYHFn4DPp3O5Zh4Kdgd9pC1Fjnyp7xMkgimdigcOxhGfeWHRJ+ckawXSW9n
	3+is/O3UmjK2kXya3H4pIiPK8uWF8dZ8Gp/urZ9PjIBYlDw6UTOkbXALBqdOHU/kFcqdlmLZ+8BTb
	iyQ0oPEQ==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0rBR-0000000DAH4-3dH3;
	Sat, 05 Apr 2025 00:14:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] cpufreq: editing corrections to cpufreq.rst
Date: Fri,  4 Apr 2025 17:14:47 -0700
Message-ID: <20250405001447.4039463-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change a few words and abbreviations/punctuation.

Change one echo command to include a trailing '`'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/pm/cpufreq.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20250404.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-next-20250404/Documentation/admin-guide/pm/cpufreq.rst
@@ -231,7 +231,7 @@ are the following:
 	present).
 
 	The existence of the limit may be a result of some (often unintentional)
-	BIOS settings, restrictions coming from a service processor or another
+	BIOS settings, restrictions coming from a service processor or other
 	BIOS/HW-based mechanisms.
 
 	This does not cover ACPI thermal limitations which can be discovered
@@ -258,8 +258,8 @@ are the following:
         extension on ARM). If one cannot be determined, this attribute should
         not be present.
 
-        Note, that failed attempt to retrieve current frequency for a given
-        CPU(s) will result in an appropriate error, i.e: EAGAIN for CPU that
+        Note that failed attempt to retrieve current frequency for a given
+        CPU(s) will result in an appropriate error, i.e.: EAGAIN for CPU that
         remains idle (raised on ARM).
 
 ``cpuinfo_max_freq``
@@ -499,7 +499,7 @@ This governor exposes the following tuna
 	represented by it to be 1.5 times as high as the transition latency
 	(the default)::
 
-	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/sampling_rate
+	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2))` > ondemand/sampling_rate
 
 ``up_threshold``
 	If the estimated CPU load is above this value (in percent), the governor

