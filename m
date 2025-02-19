Return-Path: <linux-pm+bounces-22388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BAA3B1F8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF61885134
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A201C07ED;
	Wed, 19 Feb 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XphNSzuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FB1BEF95
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948777; cv=none; b=SkL9nPbd2ezfAKj3xs6ocuWrYpDu3CmHaAxFNPtz08XaswfVXvDEtKX+f85IvPYU6ImjrFNnb7UFw5XD54Lptubjr73JpR3taQQE0hBU7aTphN2XVrNhEp4lTtNnech0L1h4lQZ6yYqszglopNXtwgE+K2M6YVmvKU5EF29FykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948777; c=relaxed/simple;
	bh=cv3hCe4BuBG14Kjuep4L778ZA7qPBrSRnDpuZRfu9MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mnZfTdv/yLbGMEMgX5K/4djerjnmsjW4rTpNjfyM773h6udepwHlCWdwtidA8LlVOsUQaCmow+IZpwD3tbpcWtD/gU3FiOUu5gdmP8fb4HTb/tYdsAMETk3+68/q+Qu+Q97BE3jfeTQIWiS07HE9jJK0CFKwjLbSHs23yHRgeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XphNSzuM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso87182025ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 23:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739948775; x=1740553575; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbSwhSK8ZTFU53yoJhkN3FQ31dlIF5Rf10aKcQvqhsk=;
        b=XphNSzuMTezC/G70n80MM8IS2aTOHkHmK8IfvFttz9e1GZQzeGvP25saipwePT/P2x
         uqs5/6zjtRsGMtCDc9vhFGehTK8X6ZTVg3H9bgn+0sSMe+bVbz9hVDxgExjXPztcF2TR
         uLbjzPu2RVOO5NH+ZbumBITwiVeRTAqabtfbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948775; x=1740553575;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbSwhSK8ZTFU53yoJhkN3FQ31dlIF5Rf10aKcQvqhsk=;
        b=hd6FKueBGLfUoH55Fodku/62+A5QNVlDUSO93XepkKnNX7QS+LDCcudFy4Mv0fvlze
         PxYWrIUv53oKs4I+Bfdrz8gLrrM3WTVA/ficPuuH68/KhSpaIaUIAapZuNFZbSQIQRt9
         75exSUsDreC/mSu8i5hUWGQCPasQf7RRnhX1cDdeYqQAqirISzi0P5XNx1lBFHdyYB3f
         v0JGdyaIDTSuaiT1jLzxQRLtQx5eK79muG9e2qrVVvut3i9TmSb03ST1eQB5YOJ90V/z
         0NiPDIHLwrcjJlVh5aPRo5QzRMsfJU1MY6JER1PnparFJhCTitENuzR2UV9MKd5bd6xd
         Ls1g==
X-Forwarded-Encrypted: i=1; AJvYcCWD4VAaly0FFawapz/pidVO4zByGGUnykWdms8cTKz4p/+Z9DOYahtnDx6qlpO3Xl5oqvyWLpB5lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63khuEeSopaRKZ/3lHv2paPK2a2hS5/fLh1XKTUxj0S87mKZt
	Yf5KzjH4RmNunHAq0/h8R7QaXBpy3jz3jkxNntPsYd3kFrNTp8T1xVVcJ6wviQ==
X-Gm-Gg: ASbGnctg1RdAemp77scPbVmPMYQ4JD7ngQD4a4mx9/51ct8Fe8lN8TIUSxM6/eqYrxd
	4Lt5cb/ifyNmPkag9BB8VKV/2Iq/PAg1KqCut22Gs34RI08kEr+fMbPpBg+h1l0cQSk8bCA8yEb
	ZrpKqEnVz48xZSLmvFz+UFO+USw11I2A423/k8tLMImT+tSeb/jAiL236GRKyIZJ8VERoEHykrB
	p66TeFBXjxUfobMSN3pi/vyJBvqAa1pqr29HVCwNACaFFuMnqgZ3Q2wed4+pOQAAGXI8Mq+BeNL
	tLyUq85oI41lWtzhRHRMrWwEMNral3ELkkM=
X-Google-Smtp-Source: AGHT+IFF70Ep2+kZNZBAW5v+lfMi3f7HgzuKvf31SQmVgrU+IbV3fzArna+RG0S91JC0hM/gYW+80Q==
X-Received: by 2002:a17:902:ea11:b0:220:ea7a:8e63 with SMTP id d9443c01a7336-22103f19fc8mr260207975ad.17.1739948775287;
        Tue, 18 Feb 2025 23:06:15 -0800 (PST)
Received: from giver-p620.tpe.corp.google.com ([2401:fa00:1:10:224f:3294:90fd:ad2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5584dccsm97702795ad.205.2025.02.18.23.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:06:14 -0800 (PST)
From: Yu-Che Cheng <giver@chromium.org>
Date: Wed, 19 Feb 2025 15:06:01 +0800
Subject: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
X-B4-Tracking: v=1; b=H4sIANiCtWcC/x2MWwqAIBAAryL73YJKYXSV6GOttRZ6oRFBePekz
 4GZeSFxFE7QqRci35Lk2AuYSsG40D4zylQYrLaNtqbFIA9eC8eNVjwC2tp5ZzzrQAQlOiMX4x/
 2Q84ffqwEn2AAAAA=
X-Change-ID: 20250218-fix-thermal-of-247b71be0faa
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>, Yu-Che Cheng <giver@chromium.org>
X-Mailer: b4 0.15-dev-42535

The current thermal_of_should_bind will stop iterating cooling-maps on
the first matched trip point, leading to subsequent cooling devices
binding to the same trip point failing to find the cooling spec.

The iteration should continue enumerating subsequent cooling-maps if the
target cooling device is not found.

Fix the logic to break only when a matched cooling device is found.

Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone callback")
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---
 drivers/thermal/thermal_of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5ab4ce4daaeb..69c530e38574 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 				break;
 		}
 
-		break;
+		if (result)
+			break;
 	}
 
 	of_node_put(cm_np);

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-fix-thermal-of-247b71be0faa

Best regards,
-- 
Yu-Che Cheng <giver@chromium.org>


