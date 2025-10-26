Return-Path: <linux-pm+bounces-36852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B1C0AE1B
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7E7189D826
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B6253956;
	Sun, 26 Oct 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac6DUDQD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29B23F439
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497080; cv=none; b=C4sxlt2ZCe4omucPXmAGTERZMFCF770loJqzG8EKisECrt+3QMtKSpc1gnxZS9td1afY94WE7qfB8O2PbImfPuuEgFcNVYmbYWuQLJaqD+JRk1/HqYX+AcEoQXyViaQQu7RkFg9q41bXojWKH6o4MUhrjcbUbdKF193lF9nAYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497080; c=relaxed/simple;
	bh=eQUOoR9FD3UwTeZyPSZWJNKIzcKibTzjwuLGuN9r9W8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaeiPZcQ3bDYLhDOcvbAMwGrFRGSVHLbYrGlhIUTYXfFG7wUul3OFKb7pqj95W/MsTTwwGqSHiLyZgmE9OJNXsfbKTLrZvJq9Ml3XKEAdsu1tnYhTxsGYhFrGgY6SSaGAa8wgINqsFrg2TzF9tBy8WFw+JNjoCz/3qy1Slc/enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac6DUDQD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3551814b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761497079; x=1762101879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFfVLgzVjo4apr0F+9sFbXPgvyArU5e8XxuMCreDUBs=;
        b=Ac6DUDQDiSqha8TOhpNWOy1v4k4BWEPkFUBk1QP17CIF8yHldefaXWI5zassdy+prA
         g4N2SlPHpaaoQ4FBct+YD4Eahk6TU6cWdOZVy+ImjTiMWa7rXG4V7ZoiqSyk39iLlgnA
         Ex1rKWoOpHTHwEYEOVEKOORBXLK5bhWtr6KLAewwf9x4yU6fkTMmVu5DYlb0P8XOzkkM
         Lu4pddOAZk0KwUO5NFoSFh7FqoIvmAcRPBSiU6srzeU1W7LLm27MdqZvxQTfZIJiHNwJ
         4yrDENrUACx21mLAxbjsdNIp/NV7ORfWcCxuFEm/QFNeVvZrOdsrptiuEvctu9czYL2n
         xmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497079; x=1762101879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFfVLgzVjo4apr0F+9sFbXPgvyArU5e8XxuMCreDUBs=;
        b=FscGX0izOokJFEDkV8xMfy9VYnOzaKawMOp0r16eKL/Cx9tLixjlD073KUyyoknAbp
         a9bYgzq9ByolXxKdjFhK1lgQU5G5p8/ycFyUm15/OIPR/YayFQjMkj7cRbR7mD8nkTfR
         DxC1JMFJXgLNo9QC6L+Hy6zReYL3lLsJ2IizFzSgNUOv/+OiRXcZ2YgcoQjigonoIGVn
         bxCADwOLYVQN88avX9WB1YQJuHvP78ndLMEBStY+QFeDZeOiSz0GEIxCMKduYMTtaY3U
         vmk7L9tRDzjU341j8Phdn9JmnyY24pdOIPtDloDlh4kJ7BQml3ukio0qHEuJ3yioAGZZ
         bfyw==
X-Forwarded-Encrypted: i=1; AJvYcCW4g+haNnDKi8/HvQMi0EI8/GRbAE3LKsmkOd8Af6hV6WEzJYZZw4HwXxCD6aFPpfVoNJ1KKM+3dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsQ6VqmAWd+lpzqcpgnaem4cyHXMaD9WcY8DMBgQqw+r6DGC/
	quchIGHyRgChEHLZlTxc2pxQYRUk/YChfMlEN59d9CzqGIQ6Xb1OwJYd
X-Gm-Gg: ASbGncsZDpjZ7Rk57XRVTQX7qyUGS4wHNc15nLmf6TC+ELHTxYmO9Eu+LNI3XXhwn5H
	3D7tOjxc6aWeCn2H/zbc+aI0YultkG0SeebVZm3zFWXIWTzolXuMlVNj5WsbqAkyEykRma02FSu
	Qr606d5oRp7sT7eDj4pJNnYXxbvNnuJLi2UWxoZG1USeFgPb8qpyMsNEvPv2qAdY/vc/oZLSlwC
	0Zt9ipeM7qtgJWE/4kf7RmfQ7P8yMEYgTPyU72obhwmYlJGzbaCazg7t/CC8QBpR2x/RJCLjolU
	hOARfhtG9mY39Ux8o4/99FA1uOjgv9/fjEvmaUy6R+n/VhdAKdLh+V5t5vKTxOkmWiBPa2zaA9+
	2NYbZh0j4mC8hQPEEOScFezIO1yRUanlhwPwd3CJoFrc179OoayM1oJ3kZ5Z2ZqY+CYthijFVUX
	UoqfgkuqXEDf0PaQFq+VKSJ4SYp2RP+XDD
X-Google-Smtp-Source: AGHT+IG49PJG/CbqXkaLHQC41z6X6jQK0xuoXYiEh+MDaaZLvv+6LBLNMogH8+OEV/PxbJSmU+sHyg==
X-Received: by 2002:a05:6a20:7d9f:b0:262:1611:6528 with SMTP id adf61e73a8af0-33deae4e085mr11445565637.29.1761497078563;
        Sun, 26 Oct 2025 09:44:38 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414072492sm5307768b3a.53.2025.10.26.09.44.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 09:44:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yu-Che Cheng <giver@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] thermal/of: Fix reference count leak in thermal_of_cm_lookup
Date: Mon, 27 Oct 2025 00:44:22 +0800
Message-Id: <20251026164422.58128-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function calls of_parse_phandle() to get a
device node, which increments the reference count of the node. However,
the function fails to call of_node_put() to decrement the reference.
This leads to a reference count leak.

This is found by static analysis and similar to the commit a508e33956b5
("ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe")

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/thermal_of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..932291648683 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,12 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
+
+		of_node_put(tr_np);
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
-- 
2.39.5 (Apple Git-154)


