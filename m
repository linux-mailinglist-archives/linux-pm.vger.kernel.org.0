Return-Path: <linux-pm+bounces-17865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8999D5195
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193E41F21F74
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659711AB6DE;
	Thu, 21 Nov 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IIvpo0H+"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF91A76B2;
	Thu, 21 Nov 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209781; cv=none; b=NozHIubXxaY4ntlmZPnxydqzCt3FLoaYBzR5WaZHWowmHQoqZ73H+QcvarxiR+wvrv61GzQnM3UweYSSKhjrNGtdoc1A7vvwzLGOf/U2zTH7TcVbKr2fbVlIVob8Y2HxywbsHjTN07JRaOfSlXAzu6IaZRAGWH/vqsGo9VikTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209781; c=relaxed/simple;
	bh=qHRObA7A09XrRIPUfIpjJaOVmA/kIZzCpRdAuzU9SHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub5LTOqWsEhj+oC85kQIB9PDwtdzQSo6dPkuhOD8vR0O0UtE0KNE3Z2R7HhntgQmpTjgdSRN3DXr2Chj5Uot/LBbn9y1FO/r0PpGFBejVYbQfzYM3g18Ru1wBqtosBxzqcaAYfNuhl0kIvYmZVX0Sn9XvcScNKrewtRDSMYZTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IIvpo0H+; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 456AE2E09581;
	Thu, 21 Nov 2024 19:22:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209775;
	bh=dcKL22xxxdJltV2kWHGeg4GmpDoyNBRNF19vSTdCqc8=; h=From:To:Subject;
	b=IIvpo0H+IHRPyZGFCTTBL5X+SAP/UGRLP8xpQXvgV7aNZN1E83j83aIEYsIH77j7l
	 PBaGTd6rH5z3nNWbg+nEPE3Kcab2et0rc/8IJBEmO3ojS7M3Ix/FJpT+hyiTEWNkRr
	 JMMJ4Hoon4Q+Gdk6V09nVnREUxzNJzN2rJAbub8I=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC 04/13] acpi/x86: s2idle: add support for Turn On Display
 callback
Date: Thu, 21 Nov 2024 18:22:29 +0100
Message-ID: <20241121172239.119590-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121172239.119590-1-lkml@antheas.dev>
References: <20241121172239.119590-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173220977544.5013.1531931796239805566@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Turn On Display callback was introduced in Windows 22H2, to allow
devices to resume faster from sleep. Essentially, if the device lowers
its power limit (PLx) while it is in the Sleep state, this might lengthen
the suspend sequence in an undesirable manner. Therefore, this callback
can be used to restore PLx while still remaining in the sleep state.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h | 1 +
 kernel/power/suspend.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 733dffb09b28..01ee64321cda 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -142,6 +142,7 @@ struct platform_s2idle_ops {
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
+	int (*turn_on_display)(void);
 	int (*sleep_exit)(void);
 	int (*display_on)(void);
 };
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3f4bbefa9b82..a42e8514ee7a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -264,6 +264,13 @@ static int platform_standby_sleep_entry(void)
 	return s2idle_ops && s2idle_ops->sleep_entry ? s2idle_ops->sleep_entry() : 0;
 }
 
+static int platform_standby_turn_on_display(void)
+{
+	return s2idle_ops && s2idle_ops->turn_on_display ?
+		       s2idle_ops->turn_on_display() :
+		       0;
+}
+
 static int platform_standby_sleep_exit(void)
 {
 	return s2idle_ops && s2idle_ops->sleep_exit ? s2idle_ops->sleep_exit() : 0;
-- 
2.47.0


