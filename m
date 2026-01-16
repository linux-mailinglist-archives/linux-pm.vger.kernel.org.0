Return-Path: <linux-pm+bounces-41000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3681FD31AD3
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CE243046DB9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854892690D5;
	Fri, 16 Jan 2026 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QTM7us57"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85057243954
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569449; cv=none; b=F9e6uE6Vngb4FY4a2skNn3R5I83aptkBfCk0QQKHmRwnE77sWumBHwDyP5dqnYQLQg53m+65IqzP5Lhe7vcR7a5ECsF8KsvP0ll6imWiFiMH5KXJhYlByJtxbPEa4RSToyYJ0QHpc3eb1xOY7C2uvt5qVTi06xwaXkZXI2C8kkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569449; c=relaxed/simple;
	bh=bCuXidJmykHrH5/xvuIi+xpUlM7CPaWZgEz+0RvmlPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QC3uvKQbGoQU3Z1kQ2hSYqr1Naffk8a7jkDrNL5RfxQe1e4JvQaq9G1lxLFKOwoXR8lH05HoW0BK4mLrnzbttVkO9vDvKgvL3PLWvskViU+UWTJBLv3ZR+FKvzIml/XOx2YwI5zWztH0r+DhJpz5XG3X6B/VOArKBeEBD0fIwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QTM7us57; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so3429388a12.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768569445; x=1769174245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dr1dBlLLfYPYJFN+bHMPl6dVd/Smnn8ihazbVyoDL5M=;
        b=QTM7us572usDv7AeGtPhpASxDmrX5F1AwqpHR7EV525CzknOU59DMIueJ8/VjToFvg
         cmEbT08FyE+QFpO1L9Pvc7OO3NSk18sq6LSW7yd8Nf3Qj74DrdbTeS9uwghxelNNCYj0
         LERiEbgHdZYprYoKOvRSCBPRRWqDqk7SxWe7ek7yrWQibjUTKH4JbxkEzBSYQPgCJR4O
         hSko0JfMSbPqjMGtbQMmLTHXw5ji3D6rbmqiUg8GN6bFi+RSe5NxppaLXgyEIit8+M3/
         Fz3LKIeuKHYXCi5e7rFp+NsStST4khP6gAaawa3qImFMxQgMtNl4cY7g4h47GulLih//
         n+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569445; x=1769174245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dr1dBlLLfYPYJFN+bHMPl6dVd/Smnn8ihazbVyoDL5M=;
        b=Oy1EMhtEy4b9gO8RapBHFoXmZWeAhrKfx92ofNciPv7+scoxZqr1L8Gzsfv/3WNGYN
         nTB8lj4T45ZtM6Op2xZVJx2O82OhkhDBIx29yWTT5HK4NsW1o9IB9SNBWM+Zona7FzOz
         9tsZ3cYyBTh5LEkIF1i0s/lvlyvvYYp7LL1l6++IoQHZkvBGgrVnqXIiybhgLqJaUEke
         42xIR7Ax0L8tb9KxaiQfhhj2bABB7vG2tjTyv4k9jmqznET6Ev06RUvwsD5ZepIdu5rT
         NdKARzy6rZzTygorjTeJCWzFpXzHdDZlZyvMtmVx0alb20LQ22KYwnUQC/qVDrjLUKOt
         qIhw==
X-Forwarded-Encrypted: i=1; AJvYcCWwH3CnnSa9TtXitYOA4b/h8JmJ7PStURwp2EWbDnw33vjHOovrc0jIwQTTNRdEzBybS4S9f2S+MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVVSiFfvL3hj3YD/iJ3JhGdffVKkeuVSMgMA9y7nRJsy8PAwJ
	UoJoGDWk80MkQzNuUnFQRkqzNv5ewM9iy4yA+DKWsm77agvrrfhtrkgwd0OFO9RRevg=
X-Gm-Gg: AY/fxX5E/ji3qgn7Cedg2usPFH3uHqCHvLrJPKIOhNWXXL3FQEcYdC8OChLo6bF68b+
	QWHPliiJqXYaay9uSrZrYLohIIhG5+oHHFHN6R/0Q/4/w5vh895GaXCFwzO0JIZIxkgm38HiCJe
	isI4D3jb7CVHcgrPJvF9YuUPwDHmfxZEI598rER4fedsFTWlaffuJxgMSVYJZMAk5zg8vSTrxXv
	/pMf7mhrR6hridl6CucfG1arAKtFbtQODsoNTthVMVuLskl0t0w1PhUdprHtkw47PdYUf7Hy41B
	bVd77GHotGhk7dw64AENEW/9ehMGiMuD+TZDK9LIB70Bz44PK/Pbtyj8dpoIUmLEUT8vp9sC9tZ
	e1R8C3lsfrW+/7+Tb96QGNxJ7M/VkzQWNSfB62lCkzbwxnpMjUI8IHip8K4xPi8wgJ4oY/EsStB
	j3Da5lWOcDRgUggIplC6EGZ/E/rwJqtMXKhWyY4z1fwMraQr1dIDNuwQW5KdynwpBT
X-Received: by 2002:a17:907:1c09:b0:b83:f538:c2a6 with SMTP id a640c23a62f3a-b8792d273femr262706366b.6.1768569444776;
        Fri, 16 Jan 2026 05:17:24 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm235507366b.69.2026.01.16.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:17:24 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Jan 2026 14:17:20 +0100
Subject: [PATCH 1/5] interconnect: Add devm_of_icc_get_by_index() as
 exported API for users
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-milos-camcc-icc-v1-1-400b7fcd156a@fairphone.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
In-Reply-To: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768569443; l=2212;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=bCuXidJmykHrH5/xvuIi+xpUlM7CPaWZgEz+0RvmlPc=;
 b=gWnOVQzJkci4lXcmtXJVm6rHU7f4/LCiwxPAkRBMrt9HO3Y81FpwwOdbP5nuH44jBz3Bhr6mu
 g+++h/05vt9DCDUphmho3T0LS2WKvANznToIrzPt/SpmQ9c1vKStIai
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Users can use devm version of of_icc_get_by_index() to benefit from
automatic resource release.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/core.c  | 20 ++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6cc979b26151..2242554525df 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -443,6 +443,26 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(devm_of_icc_get);
 
+struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
+{
+	struct icc_path **ptr, *path;
+
+	ptr = devres_alloc(devm_icc_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	path = of_icc_get_by_index(dev, idx);
+	if (!IS_ERR(path)) {
+		*ptr = path;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_get_by_index);
+
 /**
  * of_icc_get_by_index() - get a path handle from a DT node based on index
  * @dev: device pointer for the consumer device
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 4b12821528a6..75a32ad0482e 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -47,6 +47,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
+struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_enable(struct icc_path *path);
 int icc_disable(struct icc_path *path);
@@ -79,6 +80,11 @@ static inline struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	return NULL;
 }
 
+static inline struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }

-- 
2.52.0


