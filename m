Return-Path: <linux-pm+bounces-30505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592DAFEFE2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EC11C464B3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A121FF26;
	Wed,  9 Jul 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIKG/3eG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409CFC1D;
	Wed,  9 Jul 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082281; cv=none; b=DjfZPmJUqU+NjYyk/Y5MYguNWrhqNq5bUftoyXIYES0IgQtZ0KW3WHVw9Vfjq/duZSyjBA8tNLVuhY3cJOcJXkX4sqprGOO0AKgXdLoHASgw1WkY2z55oxbqXgx6TqB6Mh0HqhAoJK1Mlrr893EAmiAUSw3Y1ydKtYfcrYFoGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082281; c=relaxed/simple;
	bh=nEAZeGARqGzJQhxm4s2rG9HkgzS2kOIUSL1iaCVzm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnkW3zHqwhOF7h6DF9VxW8dp9w3yNYMXmEbDmMyQOTOqp0I8nbY6cWKf599lOYu+zM8q9DdvBsCpyWLn8OMSAmss4gbXMYumyhWilEnjzo787RT+uibA7mm8rwtA7pGvdi4Fk1ZMQe0PhjMrZRHLQxQf4Lzb49mbitZmtEUWAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIKG/3eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38BBC4CEF6;
	Wed,  9 Jul 2025 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752082280;
	bh=nEAZeGARqGzJQhxm4s2rG9HkgzS2kOIUSL1iaCVzm3g=;
	h=From:To:Cc:Subject:Date:From;
	b=fIKG/3eGKzZNhhdOns11GXctZ0COMjvT8x2A1EgUd5DN1gEZhVckYa4HOVNkXqfsD
	 1ET3VfNxoUKU3jdOD9XLZX5RpyTZynWqBlRLOfa1YzPC+44B4vY+Wz/PHMrxitJU66
	 pxklV3wf2bRIPmiShv6T+SqTgt2atmjrd/tVikPPQrdeS//TIpCsQOxz7pmK8CtHe/
	 AoEhgip5KDSNwxUVpxFiSUQcKuQK+FU146/nofRef2XUAv8GCZEKEQ/imoB4pkXAHn
	 lQbJP2nBFB/mAompV/nbHmPq9yHrhWY5Yu3yEN+C6MI1Ht4mtp5AFIpcH/sbpooocq
	 2A/w1XcY0KGRA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>
Subject:
 [PATCH v1] PM: sleep: Clean up MAINTAINERS entries for suspend and
 hibernation
Date: Wed, 09 Jul 2025 19:31:07 +0200
Message-ID: <2798682.mvXUDI8C0e@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since Pavel Machek and Len Brown do not actually maintain the system
suspend and hibernation code, change their records in the relevant
MAINTAINERS entries into reviewers.

While at it, use the Len Brown's kernel.org address in the suspend-to-RAM
MAINTAINERS record.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9785,7 +9785,7 @@
 
 FREEZER
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Pavel Machek <pavel@kernel.org>
+R:	Pavel Machek <pavel@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/power/freezing-of-tasks.rst
@@ -10661,7 +10661,7 @@
 
 HIBERNATION (aka Software Suspend, aka swsusp)
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Pavel Machek <pavel@kernel.org>
+R:	Pavel Machek <pavel@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org
@@ -23943,8 +23943,8 @@
 
 SUSPEND TO RAM
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Len Brown <len.brown@intel.com>
-M:	Pavel Machek <pavel@kernel.org>
+R:	Len Brown <lenb@kernel.org>
+R:	Pavel Machek <pavel@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org




