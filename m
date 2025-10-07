Return-Path: <linux-pm+bounces-35781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7BBC0E1C
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A558D3A2BAC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF3248176;
	Tue,  7 Oct 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7Abe05p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350363207
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830204; cv=none; b=hsIgXc38l6oBYCFCTG0QXYuV6bXI52MXJY02+JMEjMkzYcZ+CVDSjo8W16Ewen1HzKN74+wUvY18rebk+Q3QvY3OlSPs11zjbeGr8OBWM8yLoQFg0EATCo1YGt68/gu8StEk82PABA0OtQApMbcOiS+5DW9itu7KoyOAeVwgS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830204; c=relaxed/simple;
	bh=c6HwI8L1IlpZvsCzHGuSxeQ3GszR4eLOsRtO5jFSI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5dveAXdK6Oqwopb4WydN/pJXzlQ7vBHSTgpBPLzzJn72+lIRL36ZlTBD8C7+WXWXtFMuMNkru9QbAqB6YR5ylrWWaqdUQRVtFdCZtsiOI/87PBCXNkNfTrB7RwnZABcAbSyRa6Twot3s3W+a8ZXjVXyxdzvDF2xDy23mlgEp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y7Abe05p; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so57128431fa.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759830200; x=1760435000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSmNQbC023YaXpseHaoEKu4/PJTwQxs0VDin5nInWZ8=;
        b=y7Abe05pFKOPzXObl7W5zVhChsWCXMj7Q9+K0WVRdS4jSpPe6l2DyFvhZmr3cKhtMT
         9SzZPXPVUO+CgVfmn4dOWvyHWsi3HDya4AEWtatzNfLKvPJPrpgUXaanTUJSilCm5afX
         rAsAzfHy7KRKGW0l9ihwgTXsrkMD+Vc2PWhuya4Y1QID/+9rC5p+PEzY7mX8hh8sTCPb
         9csC9oVcxCtYe+bQSPf0qeoOaBK8kvfqn6j71SiuPXAF4hStKUW3NBovakQ3nAU5BIJ0
         /b77+nzwllkrZ4UE2QoVXtA07JDwcf4vJid7dCLV0korrAW9/kze7ZRxeemsF1ROJZtt
         xUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830200; x=1760435000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSmNQbC023YaXpseHaoEKu4/PJTwQxs0VDin5nInWZ8=;
        b=uD8r3Zl9Y0VyBR/j5lPB/hx4kDaOlhxboylo9VCrJDp/zqE/PGXbWJLhsNNeDykMPA
         Cv/hWjMb9U5yIhNBMxtL/W5Ftub+alxycDXQgm3gTocWb3EjrpbfLYDUQYdi7yjuAetl
         N71ZLNuirBxKUNB7PoEihudneT95CQRpizWKz6f+pPuVN/2nH9xFTIPNIroEG8kZcyyj
         1O7Q/LKyv2o38oS3oT32HZxn/7ibgAhXKEG0E21JKZGVl4DMYybp2nYMDSzk5V11o/iG
         g2OSQUIcMUa/wX2/arYiARNAoB0fGdtr0avPRJBHU3y1Afel7wY0JvjxOgY33ASNiwwf
         mVNw==
X-Forwarded-Encrypted: i=1; AJvYcCUvcCveaR5VBCa0B54/Qx8ZZtXmUbMmNsKNf9j8rXGfy1HXw2I70Oqm3fZSRZyw+0H/lBiJVVs8dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42OHSj6Pjous70CxSOlpw2Ex4FBov2hZhjvxE8lYVjeBPxbYN
	C1IBlQJlt9hEq1mAmMlS/PSAxyiszJkpPA18XZ5SWOHJHNw5B4TtI+ijdPWw12poZ6k=
X-Gm-Gg: ASbGncu+9uYCMJFcM6fybYT0kKxb7+vQlie2p/W8OWRXSyzdgbIcQgeb7IjPUec8NnF
	KkPuVkUHjNX41/nIgOrBucgaGdAUeRdXvyI5oht38YecdIedn3Vmh3BUj1tez7l2oCrH4foJcva
	OKooJRjTbVCakBmaircWsjhSHa+Vb23Y3rPDzk4LR0xVtM+th/LDmBzk7jPlJkyqyFxTlLGCxXg
	cxzoD7SDNBlzQfyHg1P0PXeQDeYxLclHIX8iMwpDrn9r5T+4NfgPtmQ3Hxmlt3QoerCue01+jbt
	QnVp94F26anRT3poVK96QwvjDPxvhR2KtemkL7VIHWyIJslhXV7N40+ecQxRUXETXLkSyzXAv/2
	Wl28t/6aH+YT56mwxSVGijg03++oPeY3pOwzPEcbSVcYiuX9ZNWHmTIeMJyVwH3evVaxopGA8Wz
	BLX9F2HI6u59/qwX3C9NV8GBi8
X-Google-Smtp-Source: AGHT+IHun025wmd/VNOXL9AvwM+T6Skk1T6ZSwLUE4guDBJ/m66mfRMTd3uDpjq7T4WB14NukVXiGg==
X-Received: by 2002:a05:651c:2222:b0:36d:3113:63ac with SMTP id 38308e7fff4ca-374c36c4a1emr49732751fa.7.1759830200228;
        Tue, 07 Oct 2025 02:43:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112438fsm5940932e87.14.2025.10.07.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:43:19 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver core: fw_devlink: Don't warn about sync_state() pending
Date: Tue,  7 Oct 2025 11:43:12 +0200
Message-ID: <20251007094312.590819-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the wider deployment of the ->sync_state() support, for PM domains
for example, we are receiving reports about the sync_state() pending
message that is being logged in fw_devlink_dev_sync_state(). In particular
as it's printed at the warning level, which is questionable.

Even if it certainly is useful to know that the ->sync_state() condition
could not be met, there may be nothing wrong with it. For example, a driver
may be built as module and are still waiting to be initialized/probed. For
this reason let's move to the info level for now.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Sebin Francis <sebin.francis@ti.com>
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Due to discussions on v1 and because the default Kconfig is to use the
	FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be best to
	keep the warning level for the "Timed out.." print and only change the
	"sync_state pending..." message.

---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..c62e428b95b0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
 		return 0;
 
 	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
-		dev_warn(sup, "sync_state() pending due to %s\n",
+		dev_info(sup, "sync_state() pending due to %s\n",
 			 dev_name(link->consumer));
 		return 0;
 	}
-- 
2.43.0


