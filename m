Return-Path: <linux-pm+bounces-35756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC4BBFCFF
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC1A189D83F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B822156C;
	Tue,  7 Oct 2025 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiEbFGw8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274C217723
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795225; cv=none; b=moeRV8plxRhc0AUQXElDSEzfnRRUpJmABDYbepiIQfIr/ViDWrJyQYkiCXwhOHMbL/Nuqqe0qAFnAQqOICrKfZ3Dk1x7mJN4uAdII6l1s4KPs3t/iJUEv5KHPpb99g9WrBF2lWYFczjBG/gqXkNH87G+2qew0E5tupkCUM1aWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795225; c=relaxed/simple;
	bh=McZ/Cz+3YMUncfglY4ZLNaseNHW944rk9LCxaUVXOoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMXMiA6LKXKfailSgT/CIGPzAeuCH5m9GKyFMME9Sp9TTLPuB2btdd37DM+yRS1qo3E3cd/npMVuE+FDBIg4EXh6Mt6gUzUjisJonPksbcG7p6qtGmDget/oKcGHb8t5w9N6z8FDzr+yJqTfgwMvvfzYmIblzieuClPQMiWoDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiEbFGw8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso9053976a91.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795223; x=1760400023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aX+L3x30EvRej5n6vrQ0kCgHgreWzDds4tYuLwFNAIQ=;
        b=tiEbFGw8jxGtb0582Md0VDdU6aN19MB4oK37nvt77RBTPSTQJB2JrAf/QNh40nyUzk
         MPjEPwyzR5+RHRJqi6ZVvf0ZfOuP834Jfw5Zh7EpeRHrFkt/ta6fmJTAWpslMf0RMg+G
         CEH87NjOiUQ/i6+OqOpRr68AEybw4YH1D1U14kaU2JqanjbemTuCdgq4wuq0S81POwUc
         1BF/hgNr8uQrAljCwEdwLXPMSy5fnYlJ9aKpgS/XSGDUaBSKEL4m/d9A/4EEIeFbvhlG
         8LCMVmD+CbmoBAgvTnpbuCc9Y8w3/r9xCNxDaHRDmgCwE2fP0xo1j7u7m8ukNFmlzFvm
         OTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795223; x=1760400023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aX+L3x30EvRej5n6vrQ0kCgHgreWzDds4tYuLwFNAIQ=;
        b=BAakr8ecExa491XjNDNQDCtj39/fEIbpTYthUmRNBVHeG8AjqIw/St0bjVW3IzHUm3
         LEAMpFo6Grl2m9GlB7lRDKW3oSMKEkwHE0GB+j21kOec0aT7VnKxlnQyVnWi9I37CA1N
         yydJ3EUpy06NBoDu6AI88byPZpRi/9v+sPChXEyHJ295Pmi8t+v0OClq4ecp8HOcf3cI
         xGXFgxbzUiGV5UCddGOgO8YyaHtUWG+HAvog+qod38j5oT7ZC0vC/qL7UVRe5VGNT2KQ
         5gy6yllMwIcp4FMqz66WDnH8fBb80eY8ZQHXz7iZBt5kILYhrxIA4rvY4Q0B1sNz0jw/
         ciAw==
X-Forwarded-Encrypted: i=1; AJvYcCVBCjYQgQnNP5FM/7M15vMYnf/ZC/rCw3h1wTgAD7Vo0281kM+/NJc+orUJP8+uY2M1ARwC4NhwXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweqWNYmyq4AfCdsWJ+2GzdIqLjkROntUWTesfw1WaKg4FydJ+x
	PVynMMwB3uBeur6XO0Q+uG71cQOYEqASr8F52a8DukkefOG9QoxyTkSqDxStoXOhRK+ZxEbzx2j
	N85P4iw==
X-Google-Smtp-Source: AGHT+IGDoEP/SfOiBAkMPYdIPL/5i5TrNtJtl0UOJt+bU99REJjTTBrtPSg8geiVHRKHdH7VyXGDm4KMtPM=
X-Received: from pjzi16.prod.google.com ([2002:a17:90a:ee90:b0:32b:8eda:24e8])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c04:b0:329:ca48:7090
 with SMTP id 98e67ed59e1d1-339c27d2763mr19089364a91.37.1759795223265; Mon, 06
 Oct 2025 17:00:23 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:03 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-3-jthies@google.com>
Subject: [PATCH 2/6] usb: typec: ucsi: psy: Add support for DRP USB type
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The USB Type registered with the power supply class is based on the
current power operation mode of the port. When the port is using USB
PD and is connected to a DRP partner, report that the power supply's
USB type is USB PD DRP.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/psy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 2b0225821502..985a90d3f898 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -209,8 +209,16 @@ static int ucsi_psy_get_usb_type(struct ucsi_connector *con,
 {
 	val->intval = POWER_SUPPLY_USB_TYPE_C;
 	if (UCSI_CONSTAT(con, CONNECTED) &&
-	    UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD)
+	    UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
+		for (int i = 0; i < con->num_pdos; i++) {
+			if (pdo_type(con->src_pdos[i]) == PDO_TYPE_FIXED &&
+			    con->src_pdos[i] & PDO_FIXED_DUAL_ROLE) {
+				val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
+				return 0;
+			}
+		}
 		val->intval = POWER_SUPPLY_USB_TYPE_PD;
+	}
 
 	return 0;
 }
-- 
2.51.0.618.g983fd99d29-goog


