Return-Path: <linux-pm+bounces-32955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A549B3319D
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 19:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DBA171455
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13C19F127;
	Sun, 24 Aug 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPj7xYNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8BAD4B;
	Sun, 24 Aug 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055775; cv=none; b=BCcxHrTr0sPmbElCP6Bm0+vVY6F3JbpS+bbVdrzuZu5rYbFXQdvNwG2xN7rtCrvmkVDN9yX0X0ObS1G+5LsLoFrijgDIhwOYCbACUPW/G4QozstxWDKq3hEaxZPSoWmSaXpm4ZTuX5wkiyGxdIi5oZhPWjvfwsoTFXU9zPARLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055775; c=relaxed/simple;
	bh=loXs/jo4qfFXMlkm2z8nYRPzXOQfnC57z5Oyez0mHNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLXccWOHn9GxnE7FwI80I5tNgto4EOyNlnoq50Bwg/VLa97ydqgHpBl5AwUXSjWlVvryobgqEiQw98J4n7ijUaeCtqS6SYMA369WNQbZHVMuXT8+sECeUVJMPerthu7cIES+lUX+hZvwIOMzIOSNhQwGFbINKs+mn9u0SvXU9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPj7xYNv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704799d798so529730b3a.3;
        Sun, 24 Aug 2025 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756055773; x=1756660573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGubwTO/u7UU9GAVy2y9Cz3yDwUPil/uEw+i5zqYVb8=;
        b=hPj7xYNvi2dTy5Ak/pyGxcZFo2jdO8NrLmVU3qF7PGGe41S0osrT6tVpq4OQSSPlw/
         LcezEoPY5UfeQrzCypMIzQ/BsNUCSXlWCH22EGq02CAN9UqPuNKD7FcfqZyUu3zJi3S1
         3J3syC82KSzzVxYgQ7iMAx/9a6ZCcdXcsDt3q51jlN7cpfiIpmUhtUZKY/7lVjzDiidd
         B/5wLj7rYoOb7PI1PcHCI1ZPZ1muKh0wWtlS89av/hFsocKB9xhxQ7myO4NCkNGKbC1s
         0snEqEwthNhON+k03P8I6MQKo82kInr3Gri+qYsgpZfv/xNCakM2YAM91V3woFOc1j0p
         Beiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055773; x=1756660573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGubwTO/u7UU9GAVy2y9Cz3yDwUPil/uEw+i5zqYVb8=;
        b=R8E1RW7OCLYoLXBRUn+brMLBqd72OPWs9WxqVwJjxmNS8K8urhwfDw/Ou9HU4THs7O
         nkberjgsfae/S9kI7qflpHJuktaJizyaWGWxLjteAwt8w1wE4HPRL6r907VRteHb7A/d
         0vX+6tEOiTuKOG7DO5ahRRDjhZ9BCrfLvBnilYt7Ni0VnO26xdukenrtFj6BWRIySOVc
         VZ6VGtvvAOu51KKAhGT/hGlVy27G3y/amVGzTLKfGkIVqwvQR4XcxWLXnRgBNfXY3VU6
         n8ZglUTbEokc4f1H+yvAYZpBCx9RCWFiZaKhu4wtbJbUg3ZOD0q3faEGvmI2wrqzNC2g
         MMCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjR1GXgKoMRM4yC06SXQP3OplisO2swZ2h/3d4/Q5FJ5Ju4iNDVgBgVBZQFPs1lLlXBnKsye12bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/4J8357Rj2eUViZdC5h7Wz969Ifv/HHN8aJiL/9rQ/6K+QaB
	pdTS/0Ntksz0Xb0Wt8OVRgzxnGN/U2U9QNwrQI/vV43S1bgeW83vjLBvq2QDvw==
X-Gm-Gg: ASbGncv1EDL0TiioUqD6HwMpaGm5GzvI0GyL89ZSFoLO/jr0Ogd7vs0ONYbJPAKybDv
	CAXddRgCpl9P5juILSSeabl4X5ZER9PTE5hqdq+ZggxY7zlT5OGWGh0FGMiqd7GGqfwd6bH5bKU
	THKk9te8BVR7v3HY4cnxYILMzTck+YW/fHffFnQkd/8kBMouHUZyCzT5SXOVONT217yL/g+FRW8
	k88MS90KqXS3RNxGJL8m8U3edJ19rHbkPeBuLd1UGnHusjRr2Bl6RfKuDZnfJofeorqdpDk3tV4
	R6UCZnHBt9JV8HlGTfiShwqMsl7S+YUsOIs/5VS6/g+fe2uiv26YBu8dmrsKo68fgUTZNT9/fCt
	1Vul4JjOq3TObAgKpHC80iBmFEOsgbDHyyz7G7FH47qGqepoJjwis
X-Google-Smtp-Source: AGHT+IEfQZ4Ieqvae0mSTpMDiaD9T6c0tbiLw1AxCOrXAkivOV5Ytnrk+mUfyFXo8uw4+XhBy7Si0A==
X-Received: by 2002:a05:6a21:328b:b0:240:27c:fcc6 with SMTP id adf61e73a8af0-24340d72168mr13590441637.42.1756055773039;
        Sun, 24 Aug 2025 10:16:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704025a46dsm5058136b3a.106.2025.08.24.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 10:16:12 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] cpuidle: sysfs: fix coding style issue
Date: Sun, 24 Aug 2025 10:15:43 -0700
Message-Id: <20250824171543.17662-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Fix a checkpatch.pl error by adding space around '+='
operator.

No functional changes intended.

[checkpatch.pl output]
	ERROR: spaces required around that '+='

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 drivers/cpuidle/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d6f5da61cb7d..cbf2e021c6ba 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -34,7 +34,7 @@ static ssize_t show_available_governors(struct device *dev,
 	}

 out:
-	i+= sprintf(&buf[i], "\n");
+	i += sprintf(&buf[i], "\n");
 	mutex_unlock(&cpuidle_lock);
 	return i;
 }
---
2.25.1


