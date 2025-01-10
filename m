Return-Path: <linux-pm+bounces-20173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3FAA0846C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 02:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B461A3A5837
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E241DA3D;
	Fri, 10 Jan 2025 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="2jaaeN64"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718EA3398E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471194; cv=none; b=gkNjoyef1cW17xvjkXn97YHaHOxVRCjOYhqXDZhHJmQTd42HkZtPCacR03yK5rOh0I1B2RrQk1OV/OxQEQmz4VkS61dHrjkMS5gle28cDfgNFEV4uY+5/pfUKkekiqr+NjqBvu5kyDHAeTHzaDGChOH47Oa6vLu5JdQRNSEnjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471194; c=relaxed/simple;
	bh=sqlLvdh5R9mO29Q+IDZOopl6eggUHxgH9TYqjMQqVmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdmh0g6YF4Sb15CSDdkwc7lZK+Q16uEFgxMuAmoWMCeYUvOvHIi8qPRVP8vd2j8xZc0WNCJfiOOBX/3i495FpVP50jRRE483ipGBWXMWiFS+zTC5PjXd9UX6P/u2l9uY+BU8KGJN9gGKHwblyB56SnXGzifoqsaypZbZEiX2yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=2jaaeN64; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so2220654a91.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 17:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736471191; x=1737075991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNY7mI1CB1gcO9SOxyJp+bPP90aou890VxLIJyQYcQo=;
        b=2jaaeN647vnzsrhmmmuU261EJHMO3jGDkL1lDUzdiCFhH/y+3lgUy1K06m5+WM0src
         fO9PQB6vEZM5kXaVflzvgc38xU5c8e7bXMYyVB+kZ5ZzrVBuyU+6YrlhrAZx9l8CFJyr
         TkeO4ka37wTTr0shORAOxl13xaUusjVpkJffE3NeMdoJxMLnQsZFR/8XtILlWlBcqW/P
         XkLO0Tl9bH6HL3dbEmnp1GmyKHNcZ4g+RNhRgQNaNMLp98KXaZ54lVMiMNAuf/2EZ/DP
         H0wG/f6u4mwaBx9Xk1NuZqlnZeWjewf7alZtNdYrNwynZDea/VS0sAKVPRfER0WLGtB/
         NAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736471191; x=1737075991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNY7mI1CB1gcO9SOxyJp+bPP90aou890VxLIJyQYcQo=;
        b=HVi2OD7smM9os0/rfZjLvnthfONZWDxUIM4XJRwaicnMDBEct8LeLGCn3VBNQheWDX
         1IxZ5VaZ7/YMuGXng0LsirAIrmxY5dybyHiiwJk97txzeee0k0PwyNyAveeJJMNpJ9kG
         JWGNtPRxwVLWVa4Rh/2UTlA3fOcUH29L+yTnojLZGtG7UkQ4e1mq5ezKlxaKp30QP0Wr
         EsPwtnhX7FN0qgZDTa9ENSVrRRz6Now+gFvDqML/DqquFNb5SyQptVEP2S2HJSGKYz7h
         iobbo1MQEbqmES/NnFF5gyrsUQjftECwN1S92jQUG852Tq4R8EDpZJdVnhcPbM5NT5Bt
         lyQA==
X-Forwarded-Encrypted: i=1; AJvYcCW8QualVGz4iKDnzbS2LMFIPxv8zNXDMedzzHFYcdlyzvBuhFz+KYzeKEb22wANkhpwwkNiAuUq6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTsRElBms7gmUZONBE4j8NY71noOuE06+uDWDqfeMfdiBuRVH
	DvxIJpq8ijXKFoCnvBHL3E2abJQEPplNUceQaudKehRAsdASrcGOJ9p0gKg+NOA=
X-Gm-Gg: ASbGncsyZrnDBQllT2Q/kvPeEKLRn9JkG0JEZPzfwllrLCnGorqxgQeuGcNF37uuXJx
	3vHZ9R2bWVd8+GMsKYIp/BhjoA7FYWztGnowNN2FOSOD/6FvAZQeQZV0469ZUnxVft9LOde1nAP
	6/C+G+EJLMcIPzBfVR5WQf/XCz/8nymXuZiyztwfgFLLGhw/vbtapV4jJN58d2Ccdve5ZaLrdFV
	HNL/EIZEU50zuZEb4HQY+SPN66eAsnlH8kXK442m4FQnHb1MVHTd3euigUJ0F6JAptFhWpFV+w5
	R8t6wL9bqohHid9zh7aQ0w+cx0bFPLIOkQloBJMKFo0=
X-Google-Smtp-Source: AGHT+IHbxF9XcpbntsB+hpDO00aqIbQ8EwEWyLEChDqPrhuWof99NJFASg3p4v6VSqG4WiDy8hZ5Vg==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2f548e98373mr13434911a91.8.1736471191625;
        Thu, 09 Jan 2025 17:06:31 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d113sm3824705ad.170.2025.01.09.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 17:06:31 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	dan.carpenter@linaro.org,
	linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Fri, 10 Jan 2025 10:05:54 +0900
Message-Id: <20250110010554.1583411-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powercap_register_control_type() calls device_register(), but does not
release the refcount of the device when it fails. Call put_device()
before returning an error to balance the refcount. Since the
kfree(control_type) will be done by powercap_release(), remove the lines
in powercap_register_control_type() before returning error.

This bug was found by an experimental verifier that I am developing.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/powercap/powercap_sys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 52c32dcbf7d8..4112a0097338 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -627,8 +627,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
-		if (control_type->allocated)
-			kfree(control_type);
+		put_device(&control_type->dev);
 		return ERR_PTR(result);
 	}
 	idr_init(&control_type->idr);
-- 
2.34.1


