Return-Path: <linux-pm+bounces-32592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFEB2B85D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 06:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A6518912A3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 04:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE225A33E;
	Tue, 19 Aug 2025 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjh3zYGi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAB23D2AB;
	Tue, 19 Aug 2025 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577557; cv=none; b=nKaHPnSYOZ20VuHsLddAC7y6AZDcgEKe4Qtc+TJ8xT9jG1EPRqNxIUYbItIL0ACBLdjG5He+qrpesqoA1Bj0ZAVTNZcLt8KLiO1BFMG1oR42ksZpKaXC6eKpxLHmuqB/Vaz02ie/Db//XGjjdVHgpyDWgH3KFcGmTeO9TJdYoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577557; c=relaxed/simple;
	bh=WHew1r8R+bfM46WQx5nuDOt4K8ddsRbz1pm1CF4fM/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oNdbYJcMho3Q94LkEdY+PT6lfL2YS0owG0QQFrAinsCR2zHLbCquGKbb3RSCy1dH28o496I4/XcsQo8FTml/+SUMvzmVWDwxtTcORT9uhOEIZZCEfIGYDBFZmEBFn8nzKGPzDPFyzc53RQbEPxFzVmzf1wSILTXiobO7tG8pSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjh3zYGi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso3619029a91.0;
        Mon, 18 Aug 2025 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755577555; x=1756182355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVT+IFtq68eU3AEx5uWMtcJcJIzpuQeKdRPh4FrimX8=;
        b=Pjh3zYGiWDU4j2ypNY1mJl7akEJlkeVeu4IqBbTHOzTbs9Qzn+2A56Cf5Lf6SOy/7R
         Pgic7jQKW0UCDkIZT3OgHu14V2LoA+/KIJP6EZ3AGcpAPNq9gvGMmXDz49780UDaZ1n8
         zBVbOdgPYv8eoHXdVgg5J/9wyJzY+R3vsX8WYbzs4Q+uDh3Hd1/6eosK63TfWOxkpfgv
         HMs1xLWvbovugmMROwFRCstbfJQE/hAVaNGwVPrT/RCeRlLIuogXYmTe5x68ME6jTRBL
         46HhsN8PjQRhz1cTCffOtB8hFU6jz8uXCYsW3bhTPTurkmyHgO8kc3R12rodshxxB9IC
         Lf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755577555; x=1756182355;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVT+IFtq68eU3AEx5uWMtcJcJIzpuQeKdRPh4FrimX8=;
        b=VOQE2s8f5jSSz2VCAg7BhYEg3sIuZ66UFPMX0xCt8gv0QvCx1vZppFf0rPfrtJ06tp
         Bfwx+Uljtnlk91I/1LibY7QrwgplJDtoj5r/tcy65d6PSDaR2zDQyEjzgd2Mzv+g4OT1
         7Wtyj2gWCKOl2HarYPs3pGdaupEh3Qf4jLogYdy9p+P73TXky3Za7oWWlKm5PQe4vTl4
         +gptz6b5Ovp2RAA0irZWk8FgDrcUl0aaa18bAItYEUvT2NY8Z1AHjQM6BnoYEypJRQgp
         QYRO5Njd1xLLYZfiX/U7tt7bWDv7LP7Z0veJ07oZ0VMxUyRyuVV+GvP2twjbzWv2J/zM
         oVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyQUptFEu3pYkHCslt7Gd444si+FSSY7Xmz0ua7NP9/c7YvEHM1J/gl7hMTdUCH6YN15nWjU+whQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTpkZiEmFq37D5Up2MSJ/s+x50lmQI4t8WbGbRUkwyY6mIMID
	EE1ZFdZlwLorQ6VP0sdZkloPaF5EUF7CeXa6vIMY3Qjs3XJ6UtcP8PbRea+wWQ==
X-Gm-Gg: ASbGncs8CdbWDMWHvOpncWGxjZ+Ix2tSpVv/LARhEkDBPO8Vybr36UV2wZYe7QX/ITd
	enWLwomsWvR/j6xkDliqoxzBUmZZPVWmLuFcvynwKimouFHg84X7GOl6L8Zk/yY9+d2SfQMNWBp
	WVFIc0doA7rO0ehsClEXn/RYLExIJ8UUTOmGcsqgVrTZkzuBy01nI00N1lrQkvO+j1+9iDeb7YB
	CShGa5VDhPzjSO4HEwIo/2gTvkrjxum4PaAjxSzKBuhePHkkTIx2Lp+uD167T9p2rPKdKvs9yXc
	N/gtYrwN5KctTa3ugN0LKKAHKBhIdbTPsaL1q/YQRqFh0HBvcGwStNW1c1iU8PURnio1j3FESJ9
	oQI7OqeSDWczC65449AjzycqTQY7GX0dieAqZ+ZJOem/3Irb8/ZR6
X-Google-Smtp-Source: AGHT+IHboZ9MxN1evAx3IBSVDdj/1S9wTfFhwfR/60lh0rEkcU2RUQHNZ1dVATUxun5j8oRheVhU+A==
X-Received: by 2002:a17:90b:3c44:b0:31e:ec02:2297 with SMTP id 98e67ed59e1d1-32476a672a2mr1985041a91.19.1755577554950;
        Mon, 18 Aug 2025 21:25:54 -0700 (PDT)
Received: from [127.0.1.1] ([202.126.91.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d79a24dsm9280612a12.58.2025.08.18.21.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 21:25:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 19 Aug 2025 12:25:43 +0800
Subject: [PATCH] regulator: consumer.rst: document bulk operations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMb8o2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NL3aLU9Pjk/Lzi0tzUoviU/GTdpKQk4xSjRPPUJEMTJaC2gqLUtMw
 KsJHRsbW1AJFjMpRiAAAA
X-Change-ID: 20250819-reg_consumer_doc-bbb3d2a7eb14
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755577550; l=3188;
 i=javier.carrasco.cruz@gmail.com; s=20250209; h=from:subject:message-id;
 bh=WHew1r8R+bfM46WQx5nuDOt4K8ddsRbz1pm1CF4fM/w=;
 b=qWT1coaUeFSOn6DzSVx+m3pHX6Mrqhq4rtqrRUqB4g850C3OCv10tmAJ2yuMo79uvhL4y3Hpf
 tXUsPGmOxpMDBU7qr6TmmVeTIhZLVuk+/VRq8C+EAuTHAvVQeA5vmFF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=/1fPZTF8kAIBZPO3D8IhqidB0sgYzPDkljBZXsXJZM8=

The current consumer documentation does not include bulk operations,
providing an example of how to acquire multiple regulators by calling
regulator_get() multiple times. That solution is valid and slightly
simpler for a small amount of regulators, but it does not scale well.

Document the bulk operations to get, enable and disable regulators.

---
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/power/regulator/consumer.rst | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/power/regulator/consumer.rst
index 9d2416f63f6e..c01675b25a90 100644
--- a/Documentation/power/regulator/consumer.rst
+++ b/Documentation/power/regulator/consumer.rst
@@ -23,10 +23,18 @@ To release the regulator the consumer driver should call ::
 	regulator_put(regulator);
 
 Consumers can be supplied by more than one regulator e.g. codec consumer with
-analog and digital supplies ::
+analog and digital supplies by means of bulk operations ::
+
+	struct regulator_bulk_data supplies[2];
+
+	supplies[0].supply = "Vcc"; /* digital core */
+	supplies[1].supply = "Avdd"; /* analog */
+
+	ret = regulator_bulk_get(dev, ARRAY_SIZE(supplies), supplies);
+
+	// convenience helper to call regulator_put() on multiple regulators
+	regulator_bulk_free(ARRAY_SIZE(supplies), supplies);
 
-	digital = regulator_get(dev, "Vcc");  /* digital core */
-	analog = regulator_get(dev, "Avdd");  /* analog */
 
 The regulator access functions regulator_get() and regulator_put() will
 usually be called in your device drivers probe() and remove() respectively.
@@ -51,11 +59,21 @@ A consumer can determine if a regulator is enabled by calling::
 
 This will return > zero when the regulator is enabled.
 
+A set of regulators can be enabled with a single bulk operation ::
+
+	int regulator_bulk_enable(int num_consumers,
+				  struct regulator_bulk_data *consumers);
+
 
 A consumer can disable its supply when no longer needed by calling::
 
 	int regulator_disable(regulator);
 
+Or a number of them ::
+
+	int regulator_bulk_disable(int num_consumers,
+			 	   struct regulator_bulk_data *consumers);
+
 NOTE:
   This may not disable the supply if it's shared with other consumers. The
   regulator will only be disabled when the enabled reference count is zero.
@@ -64,11 +82,15 @@ Finally, a regulator can be forcefully disabled in the case of an emergency::
 
 	int regulator_force_disable(regulator);
 
+This operation is also supported for multiple regulators ::
+
+	int regulator_bulk_force_disable(int num_consumers,
+			 		 struct regulator_bulk_data *consumers);
+
 NOTE:
   this will immediately and forcefully shutdown the regulator output. All
   consumers will be powered off.
 
-
 3. Regulator Voltage Control & Status (dynamic drivers)
 =======================================================
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250819-reg_consumer_doc-bbb3d2a7eb14

Best regards,
--  
Javier Carrasco <javier.carrasco.cruz@gmail.com>


