Return-Path: <linux-pm+bounces-36312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E07BE5D85
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9332419C5649
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EF2EB844;
	Thu, 16 Oct 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k9xM5Ui"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6C2E974E
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659160; cv=none; b=Ywa9KHT9QKFEqnSB+08qofJT0NKRmwqpt0d63fcDaigOpOh9PYzWdOeSw6LAEhCgUJtQVkvvhzpOgYIaAZ1q+9UakAfhxtor6742wDrTYgZQkpb7cxH/ZS5FxJcvJiPi+xyxaxFwVskNHXAunci1OOEQoX9CYFYieqz8ueubGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659160; c=relaxed/simple;
	bh=WE1Ux7Rt098ZLRDNgjhehsgJW8hPOrR/KgyCdv0Yg+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN+48WAKOCb/o2IGQxgbqhNGPuGOccvZ0mhtv6eb4JSd08S6ls0kNPjEsK3glkfS/1nVrxYnEfW+pim0JuntOmbwXpMNGXnMaKKRj2SPPnSUDSRJ3JQ6pdMUX9y8Begk2GnD2qrJr2s/8pevnyiPfLrnKUZGxrl4A4y2eGVWp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k9xM5Ui; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baf262850so1307998a91.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659158; x=1761263958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4ZD2TO+dabREMxCZUv1sX5s7/hIQJuO7N3PFIef3ns=;
        b=3k9xM5Ui527/LG1tJnX7O+N2FjFrFXSjnRe4e1KVDLD3HSgRZRJ/wxaTdf/Fg38WgA
         c8LJpy5IEefnDg/YE9NYAktMI+F0x5Y0Lrb2OwML106Fp8cgN0aP70Ty4XP1th887y/R
         SdfYpGDw5TpZzrv9icNjGgTxg5Upwl0YSeaxvDzBPhtotH/3TCRvAyIyD9xDXFMRWRoI
         BMFhJhF8gqRubmcF2s9a8NTJfzV56k6OaO7zVtbSZt+lNjdZ75xdSO+KSi0ZHFNNlCef
         kIGxJEGa5PmF8ybOJlQK5IMgQeJPupuYT7/5Hdn5vZIaJn8xQO62BkuuVRUBDm6f69Mk
         vCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659158; x=1761263958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4ZD2TO+dabREMxCZUv1sX5s7/hIQJuO7N3PFIef3ns=;
        b=Z9PFZw7/iX5e1UdXGtcS7s3XfoUJgD1gU1S+ja25aiW8apMY8LAtV2khQkr6DEONkd
         uHj1wGs0KMP6xIQATr4bGbpgkd8d8nvYqgM5JP3kYX69r/XoCVw0r7EyZgxQxZg9/gD0
         V8xDx7b3WYBungih6aKTREoJDJ1NEKIxPxVVtGcIgpDXmNwwSxDhzuYkln+LAaQEZ6of
         Y307E+sXC4TSbxqMXkoHEwLzkNN9sia29dU6DWarg3wO5jxy3XtrVXnDPD6YMpVuBUHD
         A5Dba4JbY6/VJpg++Z/Wv+P+Ypg5CierkvbDG7UXdcNok5PMlBZ5p/hicUYcTgYSeYoC
         yLRA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Q2ho52qBOnZqJwdTCKfUvJYOx1hp3XUxQ/3qh1rtZSHDxDpGdLiWioHy3z4DeuK7kdURolx8Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZMoManoF0omtXAQq5VubLZrixrbnhx03E1Oai7j0GLqeEgrK
	wr2l/eSm1/e+ViRxUot3ZQDyyzJOnOPvQRYaDcy6RWbrPDAgkgL/hVECkMqr5/n1YFAtZbX5FJ0
	4o1RFXA==
X-Google-Smtp-Source: AGHT+IGIeuq5jBttQfOPZDegsqumWfJZ/LOWeQkhcn8gZ4JaojN86hrd1bFUOoF/UZUtJUupg3tr8KyZFtw=
X-Received: from pjut11.prod.google.com ([2002:a17:90a:d50b:b0:33b:beb0:be7])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c11:b0:32b:9774:d340
 with SMTP id 98e67ed59e1d1-33bcf91909fmr2098196a91.33.1760659158090; Thu, 16
 Oct 2025 16:59:18 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:59:09 +0000
In-Reply-To: <20251016235909.2092917-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016235909.2092917-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016235909.2092917-4-jthies@google.com>
Subject: [PATCH v2 3/3] usb: typec: ucsi: Report power supply change on sink
 path change
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the UCSI interface driver to report a power supply change when
the PPM sets the Sink Path Change bit.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7b718049d0d1..cad3913bd7f9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
-	if (change & UCSI_CONSTAT_BC_CHANGE)
+	if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))
 		ucsi_port_psy_changed(con);
 
 	if (con->ucsi->version >= UCSI_VERSION_2_1 &&
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cce93af7461b..35993bc34d4d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -382,6 +382,7 @@ struct ucsi_cable_property {
 #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
 #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
 #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
+#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
 #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
 #define UCSI_CONSTAT_ERROR			BIT(15)
 
-- 
2.51.0.858.gf9c4a03a3a-goog


