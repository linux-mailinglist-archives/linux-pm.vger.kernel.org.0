Return-Path: <linux-pm+bounces-24254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA50A67615
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53047171BB9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C020AF7C;
	Tue, 18 Mar 2025 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmV0S5AS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3650126C02;
	Tue, 18 Mar 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307354; cv=none; b=TvpNAJ4PpygaYsxRjCdLXl8IWE5oi2k+s3vZRXcVgAe9m++UBEAMUh6AXL4aagRJfqq3Uon7xC6Z96JeasDwn0mhehEWBfMMPaWcIpnNp9S7mBBsnpzEqpUC8F98nc+WfwUGNM6TqQJ+P5zJE+P5J3GLJs1sne3xluHk9u+1/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307354; c=relaxed/simple;
	bh=UPjz8VZLsmlRm8QL0tudY2jJ5QityH3qNmJhumK1VPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WXMoKmGQjhLdZM4xJ1DBsPi9yq7D3gkbHA7uWhTCmggxUfN6+yOIjrc6iz3Iwe2UqP5EUA4liJW9y2BLgpxYY6r70Zu+GHhhuW6LP18XWaLRVbD2MLqIBmTplihU10btH7qy86Sx+wUwQn3zuYdVPyJ7o6iP8xOIh1nPkLqODeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmV0S5AS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22580c9ee0aso98308255ad.2;
        Tue, 18 Mar 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742307349; x=1742912149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw9gppKSxeHcWVBwaNXUHs12mj3KdYVNHxjn9Ui98is=;
        b=jmV0S5ASI17IMU05Aw+Ta1EYvaqXcdDF5F/GLtrxq+FaThW1ouyt6fEuJlTmuQaYf3
         LdLiV2br1IKNNSW7gmEpdV2ik6Xp/fYStJ9brQ/slWDKkYDjh6XUZifjm8hJ9ZLpPiO6
         j512zZ71bAOA4W0uHh7bJsaiNa9H/8hvt/ekDwFSng057DzpwfpyqwgehDfiks+BWBVo
         JQikj3+7elulFd4p7804Wkik1CHg/g9CofXdLqelM/XJun/LO02lQREFkEk4btQh5Z3n
         ghGFsp5UcQQPxIsfxOaCoYV9vYvk3TBF/Jh1Le2UKV47kLlz+8/wb2PgDStSkXevQF2R
         3AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307349; x=1742912149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw9gppKSxeHcWVBwaNXUHs12mj3KdYVNHxjn9Ui98is=;
        b=NEr0IifvLk5OJwBkRaPwb6oSWK6OQk81sELA6i1XcvDBrNIPaZgdzpTzgveu+vxzoM
         uSQoO0iIKQGy4VJeg7BQZHlv5+C69h5QMt3m7iPTFkjBf7s/SccaPv9rpoK6xWAoBz9F
         yJ5LO7W+cu4k78+JCwPJKG6m3Da3/5FSCQrrikYL6bI5mJL6aQUwwO90bpAfSzJYYiQh
         l48OIOQIJvbQ0/tUcKiZoEquYwj4y3SGjripvXpOhADIr8J3qlYCXsimZqo8ZqKilWET
         dfL4npVTzgeuaPiH0Ga4c6UF0RYt9fvl0PH1VZX933iQqh/8uFZOVDxqKQTJWeWhgkwZ
         x5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pC6uIz3wPkavJ3LxjShTVHDJ8NIL9AK1t53HQuGgYQAs2qSZpBBD34UgZznuO5OfIpbgOtagivja6XX5@vger.kernel.org, AJvYcCVK4UmHSr36xsktwucRuFD43otMwDM8bhD0/6bkvpZ7fOt54V1WAbLiBUQP+VeZZupryTKth3de31U=@vger.kernel.org, AJvYcCXy4i179N5ny8CyDhPdQ2nwaRqDd+PWHvSTakFlmOQ6Yh0dNO37EKISpFcBcJSdirS+CcOX44VlzTnA7r8s@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxGOoFy0dj5tPW4NKgeycndvnbLmOSOkUV7CJ3XF8/LnmTF67
	hBRQXHLNUDXgBEXbergfSp6yv37nuwSDxXCJZeK+n1c5hl3y+0NH
X-Gm-Gg: ASbGncubVspdquLPw7jhdhOKKjMoAo9BQQCEvE8nRR5tIod12GINGPoC4WjqaQXQNR7
	QHytVpUTf9O3qV26mkdot9gafiYvl3gjaK5YiMyLhOcLmsNbt+31Xkep4Myb2TOr03b6SUg8+my
	B9sNUp4/OwBy9GtWGttcVpFcmjHWOSalJwG380oZciIAPtkR75y/0Tq+HgKWCPDd2TmA5kFwFx+
	A0/+Q6KKSWuzD9LRRqkvT1xcPLSIRxl0ia77EeCqAQxQmA/0D/gBHcrenRcqJ+RaU+LzFcLy39T
	f+h1JxhlX9yW7d9wdNKw59tSOYd4nfB8F958/9cVPhtEo4Vrh779tIFCH01f8n1J7qEZ
X-Google-Smtp-Source: AGHT+IFi9iMKBjpAg9KEVjkwVMJon/TRhaWEAz63sZWNS5Zv3rQiYjSCerddG2l8xfiUyKGEzOgSxw==
X-Received: by 2002:a17:902:d488:b0:223:66bb:8993 with SMTP id d9443c01a7336-225e0b1001fmr211198205ad.43.1742307348944;
        Tue, 18 Mar 2025 07:15:48 -0700 (PDT)
Received: from localhost.localdomain ([183.242.254.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-225c6bbeb94sm94430715ad.199.2025.03.18.07.15.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 07:15:48 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] cpuidle: qcom: Fix refcount leak in spm_cpuidle_register
Date: Tue, 18 Mar 2025 22:15:42 +0800
Message-Id: <20250318141542.21748-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a reference counter leak in spm_cpuidle_register() where
of_node_put(cpu_node) was missing when of_parse_phandle() fails.

Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 3ab240e0e122..c9ab49b310fd 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -96,12 +96,12 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+	of_node_put(cpu_node);
 	if (!saw_node)
 		return -ENODEV;
 
 	pdev = of_find_device_by_node(saw_node);
 	of_node_put(saw_node);
-	of_node_put(cpu_node);
 	if (!pdev)
 		return -ENODEV;
 
-- 
2.39.5 (Apple Git-154)


