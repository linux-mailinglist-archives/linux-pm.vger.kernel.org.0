Return-Path: <linux-pm+bounces-20263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD881A0A146
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 07:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9465316B52E
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800081547E7;
	Sat, 11 Jan 2025 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0OkLkrcw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB014F9E2;
	Sat, 11 Jan 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577071; cv=none; b=qzs6PtauR+J8sNdSIV6jiK7OjUo/7kPHjLzBy2O6SIJFz8jh/LJqp0LfHt5XMk0DjSoJcjwOJOAsVxvmz6KRMYyiWP/u80wkEtTUjPwd3UIIt8zPrGxhbP2wYdafHEA3nc04uUydPfs4qYl6bAIe4jDFqCHlFU0qTioXj4AONlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577071; c=relaxed/simple;
	bh=VCZQ5q/WHmwfCQG3NNy+362FBTnxtBZA/OMCUYCyo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVXY0h3dZzijN/dhC3W0NaYv9sLWim4b1d+l82Ns4d0Fxue1ZnoAC+URoY/lOU/uHdy3dAhaHEYE4O6Yi8Wh+MLq0RLpdOt1YsRx78+dKLAKm/Ahy6cbqKCaUuN/a5O3rEUX3oWxpxwxrLncVf53iXEWOcrvHS4Hc4ICH7nyFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0OkLkrcw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0KMsKZoEMMrWxESyMUyDMhcH3AMxH+i7GiFFV+pC27U=; b=0OkLkrcwvxmhm7RDM5FXtXf7/j
	uYK1UqxP6xWRBURx8XANZqSSiuNlX2haqUp9206GGSGQdJmHjzNyJHmwzWd5r1Y4d6H1Gjq7WvVmq
	Jb4K0FTuL7WApf1SHT6I5+Zp/wMWtClUrRBdaJwtuLgrGtOyE/y24IkARK24qCFynhlosLsruoqb5
	PRzsqMjGDXR4KVJySL+5hrsXnXdve00cm1PwL1+onscCRaPi/1mFl6H8Kxf5R4JZqmI8Fesnw4stt
	Y5iX7SeanHbALNreA8LuZDvcvgWiAg0L8UIg8b/+ap9Okz4ojWryo7uUQ3yTDELB4A2cbo1hersx3
	hJVzsNhw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWV1Y-00000000Hbi-0tuy;
	Sat, 11 Jan 2025 06:31:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] kernel/power: convert comment from kernel-doc to plain comment
Date: Fri, 10 Jan 2025 22:31:07 -0800
Message-ID: <20250111063107.910825-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify a non-kernel-doc comment to begin with /* instead of /**
so that it does not cause a kernel-doc warning.

power.h:114: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 *      Auxiliary structure used for reading the snapshot image data and
power.h:114: warning: missing initial short description on line:
 *      Auxiliary structure used for reading the snapshot image data and

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 kernel/power/power.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20250108.orig/kernel/power/power.h
+++ linux-next-20250108/kernel/power/power.h
@@ -110,7 +110,7 @@ extern int hibernate_preallocate_memory(
 
 extern void clear_or_poison_free_pages(void);
 
-/**
+/*
  *	Auxiliary structure used for reading the snapshot image data and
  *	metadata from and writing them to the list of page backup entries
  *	(PBEs) which is the main data structure of swsusp.

