Return-Path: <linux-pm+bounces-1026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB180FA1D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 23:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1881C20E23
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F764701;
	Tue, 12 Dec 2023 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMo1bj+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA723BD;
	Tue, 12 Dec 2023 14:17:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333074512bso3898435f8f.1;
        Tue, 12 Dec 2023 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419420; x=1703024220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ89YvrOqku4UfXm1LiD3M7ba2ZGC3MrhjCGhcqvrpM=;
        b=PMo1bj+EzKDopEu7dedF3dK2z5Q+EZmfciPbRhOkg/3cOD7LRvuLiBBsIakJLDebvC
         Vq8hCeeyh3SyLsZSZmrgPI8nanXLvyD8VRmBFBn8X+z107pE2kOxaWgMdsumP4yDiok9
         XjyKUUrgddbB1Pixfd3BB7D0BMoQSF6yNNzMTzl+JeTET9ZjiSKXOosz8BZ6RW6LgOGA
         YovI9967CUsYfQOuK6zlFwrX3UQRgdteMG7YWMgrcvdWyZFZI5sKQb8bGho1ZVShmDwg
         dvkeQPR0vMf76ErYOjYYQB1+W4Uc1DNp+B2pkVvocH3sPxrXoY0mbNdhRcw293AQDDHA
         yjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419420; x=1703024220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ89YvrOqku4UfXm1LiD3M7ba2ZGC3MrhjCGhcqvrpM=;
        b=hqVuiGLJcRFJpt15iThBq2zLyXPXCi5QYuKCFZo4xER0Z+CZRBwmyAMDIrmMk1oUNV
         G+72XgAQJb9wqyjD/kh49Ig+aa/M2ppe4iA/jyuQu7dh+WVNHo2Fe8RyjDQfnSoCWt+V
         kaQEkj6rCX2oWhdZs5VWHUSai+fbU+4TUEeTnDDQvsvUUhVaazAC0n/eyAk8l+DMsFZh
         6bJjRm3RkuaWa/3wNRAF5gDy0Pmy2wMtX5W/Uk7qwTcPNywQRnL2CikJdTDOQctc/OV0
         h/ED9/C8iP7nIODDqP7zrtYXHB+OFF4u86iBJKiVIfKsWLKxPyhjdvgmVz6iEfcD48WJ
         MY+A==
X-Gm-Message-State: AOJu0Ywr08JGXVf0EqXbqsKwvC+jFauEaSDPJLe6V+BvlVULvkhEzh87
	OYk3uprAjNjdBNibN7lSZz8s7EIZkkA=
X-Google-Smtp-Source: AGHT+IFeWW81nf2WWg8qv9w9rgm6Uvxq2pHl5HscOB/An/EEw3ukFuK0YWWXXYQ795X3sy+lnOpN1Q==
X-Received: by 2002:a05:600c:3acd:b0:40c:451b:45e0 with SMTP id d13-20020a05600c3acd00b0040c451b45e0mr2270512wms.120.1702419419910;
        Tue, 12 Dec 2023 14:16:59 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m11-20020a056000008b00b0033332524235sm11669113wrx.82.2023.12.12.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:59 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/thermal: tmon: add support for cold and critical cold trip point
Date: Tue, 12 Dec 2023 23:13:01 +0100
Message-Id: <20231212221301.12581-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212221301.12581-1-ansuelsmth@gmail.com>
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for cold and critical cold trip point.

Add new char to represent these new values.
Saddly trip point name initial char can't be used as it does conflicts
with the Critical trip name conflicts with them, still a more or less
symbolic char is used to represent these new trip points.

Use:
- N as Negative for Cold trip point
- Z as Zero for Critical Cold trip point

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 tools/thermal/tmon/tmon.h | 2 ++
 tools/thermal/tmon/tui.c  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..26d1c829af7d 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -58,6 +58,8 @@ struct cdev_info {
 enum trip_type {
 	THERMAL_TRIP_CRITICAL,
 	THERMAL_TRIP_HOT,
+	THERMAL_TRIP_COLD,
+	THERMAL_TRIP_CRITICAL_COLD,
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_ACTIVE,
 	NR_THERMAL_TRIP_TYPE,
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 031b258667d8..6b58ffa4df6c 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -307,7 +307,7 @@ void show_dialogue(void)
 	wattroff(w, A_BOLD);
 	/* print legend at the bottom line */
 	mvwprintw(w, rows - 2, 1,
-		"Legend: A=Active, P=Passive, C=Critical");
+		"Legend: A=Active, P=Passive, C=Critical, N=Cold, Z=Critical Cold");
 
 	wrefresh(dialogue_window);
 }
@@ -535,6 +535,8 @@ static char trip_type_to_char(int type)
 	switch (type) {
 	case THERMAL_TRIP_CRITICAL: return 'C';
 	case THERMAL_TRIP_HOT: return 'H';
+	case THERMAL_TRIP_COLD: return 'N';
+	case THERMAL_TRIP_CRITICAL_COLD: return 'Z';
 	case THERMAL_TRIP_PASSIVE: return 'P';
 	case THERMAL_TRIP_ACTIVE: return 'A';
 	default:
-- 
2.40.1


