Return-Path: <linux-pm+bounces-19238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF719F2111
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 22:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B77A18875B2
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAC1B0F29;
	Sat, 14 Dec 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLMu4fjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17C137E;
	Sat, 14 Dec 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734213490; cv=none; b=oq+xo4LatAKJqDjFhYJoAA/3H8mMgVm4D1ZS4IKYvjoPthBE7t1C2PnhFlzZSJ1Kc4u5WT0XVMWG8r47487oKFz0p+U6jDkgSqcUpe2U08+bZmnbLzU9jxmp7NVJikLG8MwYVbVQ4iY23/M8hcNbTY6tC2Ih6Lx9ALCbodgvqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734213490; c=relaxed/simple;
	bh=nUIB/4IlyrnXcKTGeAmoZGWvaZhZw0wS1lOZ6pmtjMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvKchDPLqHkaSlPN1ZGtTjIvtwK7f0buag/hjKzvuE29kMRGmt0Z///+F1YFpLz27YJUa/sy6ACsrquW6SS5BL+T9+z4IpkYnuRIJxpKaWwdBfr7webB5Prbjjkgy2AYab+DE11k9jU1kT38MaDsjKcL+rMO5rpYUwtTmgzBxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLMu4fjm; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e4d38185so231939685a.0;
        Sat, 14 Dec 2024 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734213487; x=1734818287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0R3xI1UN2GRunhZ03PNs268H2M6C30q31a5zdZmWMp8=;
        b=kLMu4fjmaP+UJcV/2VBKuv56e7xHaPkcP2p8w+nHjXHWJr6Eo4peghg2UM+UIv8OJJ
         UP2bCqgndhLSiuBYBnfDVxPVCqSJ1MVdh3d5CQmkUQoE2ldURUa2v4RU5P7SkdKiqAWH
         ToTh0Km+WMuogj9qC9RZnoBXkNlHRTbaaR8HYMCqsn8DJOAWdzFClXpRv7ok0hnKna+L
         HVNGm9GtC6tWil3PFCYQr0I/vOKcXvPL7QrHKkvVzPlOrcqRoPDzSDG/t5aW3fubCdex
         xAdoIzItflQ30uDYPvSxPXs3OPhvFzRqyNATtZugj9Kpb6nfoQprk4uK1FI0K3sF0cQx
         oxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734213487; x=1734818287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R3xI1UN2GRunhZ03PNs268H2M6C30q31a5zdZmWMp8=;
        b=koNj0qZIqU7/+l8SDZE8TzxkAFBzvyqtZqPCM50O4QKX/AO5DMiUkyGVI1RfpQWRyl
         mGD75gR/kwMuvPIwmtNH3lWSwAJ1H98LY4dcKc5U+3i0NMUI2poQBpuh4ofer73RSfsM
         h1+wvMUZb2CEdN4FithcSxMUvcMcUVKWzZfihdB1mYmlyHzKsghUlH09/V/YbkYtGSh1
         7LNBsHhU7D1J9KO00P7Yej5w2THExeKFfyP26e22cZQ3mRwpnHoe9zCDEotIeETExAN+
         Gn3sIl83KIF7KV7JV5FROHujMRAzOG/ozRB1GgL0grOD2N5qVjQVnXdX8FHjBqlAawxC
         hZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCUGkh5lDPPku3AB9ks3ARm+JnBC/yxcSz0zR5fr+Or6IB6dAtqOCwLLU87H7X6OI9ZZ6qoNkesxI7FyQ2k=@vger.kernel.org, AJvYcCW7FpR+DfKdyPtdjNmpykOE9tYe1i5cljj/GeO4KGFMO8Y3BVy1W7+XwY+iHW4B0Z2szxzfMMkqQVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1w+pI0lqKDNpuYid3XUeDIL6riFm9qirAlydZaAvTTAWtZY9
	Mn84lu+GJsSardFrkZwqz1dppZmm9l43ecv/WIErSfEfP45sO/AP
X-Gm-Gg: ASbGncvqWX9PJGwAPHEa87kqC1uj171e+XpQbqDkeW9xoBeWpCOhWjJxSfsHwLbipF9
	EWs6FP4k3YA5u8WKjKd+60NvJx1DUMfLKJqkRGYraVX/IgfkDr3WQgn9MEUGTEUgvY5gR6ycwFz
	t1FNLc+FNp2glattlLuk5GQkLbmqc4S1St1t/7TR3b93FIhDT+rS7wIR8GzVhiauZ5uemW2ypXq
	KsSeTZgoyQtytVeNVMfJDNi7xgzn9JwtJfiu41+SS5SUwnvuNxaa/UAZ+nlJnAcIw1L
X-Google-Smtp-Source: AGHT+IGt/f+i+UFJ3O+RvOd/bRwD3wpdtAD3wNHRnq4t2hd2j0+Yy4uR/gvcC7FSIKX3AOr1aEX9Ug==
X-Received: by 2002:a05:620a:a005:b0:7b7:68c:cde5 with SMTP id af79cd13be357-7b7068cda7amr362626385a.1.1734213487439;
        Sat, 14 Dec 2024 13:58:07 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bb8cfsm95536385a.76.2024.12.14.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 13:58:06 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Peter Geis <pgwipeout@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] pmdomain: rockchip: fix rockchip_pd_power error handling
Date: Sat, 14 Dec 2024 21:58:02 +0000
Message-Id: <20241214215802.23989-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls rockchip_pd_power makes to rockchip_pmu_set_idle_request lack
any return error handling, causing device drivers to incorrectly believe
the hardware idle requests succeed when they may have failed. This leads
to software possibly accessing hardware that is powered off and the
subsequent SError panic that follows.

Add error checking and return errors to the calling function to prevent
such crashes.

gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink
Setting pipeline to PAUSED ...er-x64
Pipeline is PREROLLING ...
Redistribute latency...
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on domain 'hevc', val=0x98260
SError Interrupt on CPU2, code 0x00000000bf000002 -- SError

Signed-off-by: Peter Geis <pgwipeout@gmail.com>

---
I have pulled this patch out to be standalone and rebased it on
Sebastian's pmdomain work. It is now dependent on their series [1].

[1] https://lore.kernel.org/linux-rockchip/20241211143044.9550-1-sebastian.reichel@collabora.com/T/#t

Changes in v2:
- Rebase on Sebastian's pmdomain work.
- Handle clock cleanup.
- Clean up commit message.
- Pull this patch from the series and submit alone.

 drivers/pmdomain/rockchip/pm-domains.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 31c71b6fddf1..9f6640063fda 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -602,26 +602,29 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		rockchip_pmu_save_qos(pd);
 
 		/* if powering down, idle request to NIU first */
-		rockchip_pmu_set_idle_request(pd, true);
+		ret = rockchip_pmu_set_idle_request(pd, true);
+		if (ret < 0)
+			goto out;
 	}
 
 	ret = rockchip_do_pmu_set_power_domain(pd, power_on);
-	if (ret < 0) {
-		clk_bulk_disable(pd->num_clks, pd->clks);
-		return ret;
-	}
+	if (ret < 0)
+		goto out;
 
 	if (power_on) {
 		/* if powering up, leave idle mode */
-		rockchip_pmu_set_idle_request(pd, false);
+		ret = rockchip_pmu_set_idle_request(pd, false);
+		if (ret < 0)
+			goto out;
 
 		rockchip_pmu_restore_qos(pd);
 	}
 
+out:
 	rockchip_pmu_ungate_clk(pd, false);
 	clk_bulk_disable(pd->num_clks, pd->clks);
 
-	return 0;
+	return ret;
 }
 
 static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
-- 
2.39.5


