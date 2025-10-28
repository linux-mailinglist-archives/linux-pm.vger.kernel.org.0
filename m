Return-Path: <linux-pm+bounces-36954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0135C13140
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 07:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70D0A35357F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AA29E0ED;
	Tue, 28 Oct 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwVffNQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76055298CA5
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631728; cv=none; b=UKqZaNBqJrtqr5ORtQurJcdcVLE1hY2qBZHU2vZ1bbm90oqF8jI3lYnStOO8+j+jPsGVEa/KaItBcODUbvC16ArZYhScdXjT2DxlhBCkPZP0oBkCZ+M6M2FjsW/XSrbC4uAiLCb7exj/ExH3Q/apYs2UcbNJy/GdvGOwfNF16i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631728; c=relaxed/simple;
	bh=q7Tc2QsMBaN+HdSGE3XhX0GNjhdhA21Ns2bjotQEtBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0ah4iahGrdsq68Ig313Ff8b5EAxEsMRFilaZLi8uiVn6XeNqYB4trgxzlSyES/pq8/dxMX+e8emhHVgeT6yY2ia0wYONLUUmkOb/yCLvZIBd97d3uOOMNQ71L0QErpQYk/xAR6OHqCfBMIoxcdEhL8Mr6P3GQ4qetgKsC491X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwVffNQz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5296091a91.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761631727; x=1762236527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtQOQB0/xeiaea1mof+0CkoSu6y09kgD2fJAIO20kBU=;
        b=BwVffNQzNrjA44edQduAm31/Ty1+eD1ko+O4xUYxdOqVIm1Mcbq5LNZ51gZFDMx6oz
         yctWAtLsp8LlKZAQUrtgGHv/Y8h6qntuXD/bqkBiJTQCMoZYk805s1rJwaM+9VPs26mu
         EElDlKL01yxVt0sem3jv4wlmkEvUZKk6sm9HZDEuYja18cKdmkQavc9w5/nR4zlc8o9X
         bddjEKSReP54w+lofIR/6jTmQtVWEhrpWsPDlNaLlkhmpNG6oZe5UKEG3a6xojMM3NS6
         m8xP8Iud3W/RU/JGX2luB62fvOYulnRbS7bX5QnMHtjbnQAeFDcpTIL4wF527QkBG6Ev
         DjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631727; x=1762236527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtQOQB0/xeiaea1mof+0CkoSu6y09kgD2fJAIO20kBU=;
        b=rMG6MqnYw6Vnj01xWVf7rNe/5PEKiPXMLD0TnpWiLbymMin8QE+NhbmQnjIAnoYpHK
         X+lXQ3KfQ+oVPx8cQQfGCrw+8ATxQOwQppfqpNmcdT9Ml3ipOQfVB92veee30sDn3WOY
         iT5UA7t7KLSmiowWnRb9JptTudSxRb3RIen6EwKcO4R7UN6o0B4dcdV4gPENn7BmIbK0
         Xnnaz1QKoVH5M8DAwmIy9C20+Z17BqItij0uA7NRLsijP53qLrpLOCD9vikvxtbLn27E
         b6HLZISiDAIkgqRKHRnSL/MmQ1YzpG+O4J+HKnur+giPZaqpa4h5km7rfEaCdZIyx05d
         rFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIvSQXanaSNAQlTXdytrcBQhVIk1K3V+xoAjNV1qUNGO4JAwzI/ptHSjlmLuZ+rs+YEWuLBP9vwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUAPqgfRPM8BCOdyCq1nSySBKb49wsHg4QXAdfRYgP5XJTBM9
	XcXDrCMJ+YeDbVX65r6cOdymKd2iHiXluU/eEhbJnfDh/NrUm9EB/0lV
X-Gm-Gg: ASbGncsrya1bEShD21o9weZy2oSsvoE6s/7KmRr+mV7aR24C9dX0/HWHBnoRmr/0F/x
	qPKf++yRaeAqvjUwUQOL1Cvgu7LVbCkY0yWzgZZWZ7bVOXDxTmanVcmjyVV7+61Zf+AXpBYX30v
	DPVRJVa14VAY3HBuqG8FDfEPOfv6U6TFJ0Yy/DGKR6w/HYligcEPIOeLilGPBAp7rDVml7x8Y0Z
	H7oZxSfWHpnF9TX1g/9uPjcKysb0motn/rZbGsKIQhHqOr/aVWa1pz+sfAjv97MnbrEiHbLDMQZ
	irGR/eJ0S2zf4WVwDY4Nssixx8gKpAXluM7WepTPb4nwqPz9OlUR42JJIODkdTHi9tGxGEoH0QA
	Oew2CLtFhYNrXZtE9njiYEUjYIIgQ/iTW4TKSmtC9wLMU2FpqcBiDrW0gm9scXEVQceRa6AhHuV
	jfOAEbJVmQQazpeDzb5ma82A==
X-Google-Smtp-Source: AGHT+IGM18PVXmk/Ly4QV9wJ4WdGZzC+O29UfRf1c8szMur4qUVhZWR85AkuIgff1YJgN9jGYRTafQ==
X-Received: by 2002:a17:90b:58f0:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-340279e5f8bmr3103225a91.7.1761631726760;
        Mon, 27 Oct 2025 23:08:46 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm9533462a12.5.2025.10.27.23.08.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:08:46 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] thermal: thermal_of: Fix device node reference leak in thermal_of_cm_lookup
Date: Tue, 28 Oct 2025 14:08:29 +0800
Message-Id: <20251028060829.65434-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In thermal_of_cm_lookup(), of_parse_phandle() returns a device node with
its reference count incremented. The caller is responsible for releasing
this reference when the node is no longer needed.

Add of_node_put(tr_np) to fix the reference leaks.

Found via static analysis.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/thermal_of.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..2bb1b8e471cf 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,11 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
+		of_node_put(tr_np);
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
-- 
2.39.5 (Apple Git-154)


