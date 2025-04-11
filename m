Return-Path: <linux-pm+bounces-25194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808CA850A2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3653A7B1614
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF55C96;
	Fri, 11 Apr 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="embZIpTu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226E10A1E;
	Fri, 11 Apr 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331988; cv=none; b=MShvdWWG2U9FonI9qnczqWqFvJoTe9t12J3pxWg0jg/HZBmRzYMM9uuWFmoc76/o7QLcm5oB0kF5YLTLliNPWMCm/4HEizJlUXuouXGE4Z0f9j+w+0SScxnWuiXTbHxyXB1XyBeFyVM78hFMKXXO5B2SLv/6BJdq2KtqTKpWeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331988; c=relaxed/simple;
	bh=hUmYTmAvcs2uf7zk3vjXCVXow3V8zdSVau9bQr5WKPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjnA+S70WT4/AN5WOJtHEA5j+A4JzAn0tkGwdzzfdf719uMvOVGgtdOArMYiS36zmQz/7hoByVRlgVxB0vIogHIMSzhHLugam8o0ZEpXpduRRe1SyQfVh0Hmod5LmsDf3bo2gGpDk2MFhUdJFuNN84w3nbmA/PT2Y5ErWKQ6Ls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=embZIpTu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so11731251fa.2;
        Thu, 10 Apr 2025 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744331985; x=1744936785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T38zkrO9x36m4etdaLiyiX7JPZf+RzDpwj3Zgm9TBys=;
        b=embZIpTuZjxn0jsIwnxfYFIIQf12YpS1MlBdZ9YOQ5yTi0yQwlrwrZrnjdaRIDNXYG
         Z8dEik7aMcXxYZy+Ciz7wIYoGYGhVtMOw/HiAaXOo9V97YovR/kNtpJy8WZtpDz1XtKQ
         9bYADYQ3SQQjFFyMDtanKc+tJCMEdXEQU5dGZe2UHzZRQJsgIDJyGWPz42xLhv227qJa
         VPgWZq2OIG6SeiaarGLEkB58Nqm8MO8AGoL+fe0zTtvZkDYrSZ3vs/yElIuL/vWaI/TM
         V2fiJooRtqrjB2zAZn/DK4FRkqwghP55ScAOP8Ox4u4bvr6ptHwqa2VmDgRibdElTUxJ
         GjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744331985; x=1744936785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T38zkrO9x36m4etdaLiyiX7JPZf+RzDpwj3Zgm9TBys=;
        b=YhbyO15c7fP0dfPSZBhtVvyxz1vWexWcE7FA5Y3F5uvdv93LFqoSrlnDGU3nwyHs1q
         rEHEGbjM5A8kz7Hda6n4r0lnkSNZhl1os/4lCfC+gvo4mXz2JV8L5Jdy+SU6sKUzm9FO
         bjy+TrkI3A03GC1ro/1PLgoxPA4/ypspKGY3W1kLGQYUlVxXg9dUafy/d/6aISoLb9wS
         7U5JvlNabYxbrJpYnWCA3mYLCen/kLto4tubTs2iPm3YodPFvxX6P4VAVF2iSgYPVDDR
         myvSwGrpRjlbINAd5iSHdZ5byOc7G3DKaEDDzCYElCkLvfNlL9+rXEQsU0uqZzsF7nUL
         KaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdPXlTGuxu+8Bl6+ynCMeiv7SnjTam5WEdNUYhUdvT35ECEi0S98ccm4WKVaAEAvFta93OuTa1XV8=@vger.kernel.org, AJvYcCWELvvoV+C23HnGtw4CeVOFD/kiFWeyeO44WGgpjzfRGb56hIHHDXaBX+Rh6J4bNA3K4JQOcGYoacl4@vger.kernel.org, AJvYcCXa89xU0RpIQF1qfT/ShVnH/QT+GC1vn9WocujAHMrtDofu0nBdtoUAg1qZuD6hQPAO1BA5ibpzcjs2z84c@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh4T8uSI+7c8R2YwKPQcchaesDrQlYQLknSwlrIXNEwj2MEQ0
	/GKBbQ5ippjQSENNN5jrd12ca/NygBAL1jy84wZKyjg+BGUNdi1f
X-Gm-Gg: ASbGncvwyfHZ4Sh6kePNKzTX9Qlveliz3VW0IG2Ik4yvAmAcu99xunlM0UOr0FRTEnY
	dV9TQ8eWE1Q92WDhrsFJRRCJRTpgtfnv9tHwGyFkYe7qC9+9ZQoDm4LdYXxng48H3Ep+uha14el
	xKIq/lpLfY5phLi4J6cc0K9RET1NJ2uGKaDh1pPoXlZD9VhQL8qXIkJzkxpYj02I3CamRqg1D08
	B0e3CXBgvBz4BAlXYQnmSLY6JZ05XgqfwcuvTMCy3ZuCJNi2dawCSPMzONrPzRsF5T5YqCSsNXi
	QU+Z0foZJUHkGOkfnEClSAP8JaMTCDd/N23X59Ml3zBojW9hsw==
X-Google-Smtp-Source: AGHT+IFbxnSm5FcYra/NhgQKMu+OkU4ccH3bURF6g7KgB4DcFLTWIFmK1C48nXnn+TaTiHuSf8qBLw==
X-Received: by 2002:a2e:ad86:0:b0:30c:1358:6400 with SMTP id 38308e7fff4ca-310499b4447mr1902191fa.5.1744331984565;
        Thu, 10 Apr 2025 17:39:44 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:39:44 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 2/6] thermal/drivers/sun8i: replace devm_reset_control_get to shared
Date: Fri, 11 Apr 2025 08:38:22 +0800
Message-ID: <20250411003827.782544-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, but they share a common
reset line. We need to use devm_reset_control_get_shared() instead of
devm_reset_control_get()

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 1f3908a60..dc4055c9c 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -391,7 +391,7 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(tmdev->regmap);
 
 	if (tmdev->chip->has_bus_clk_reset) {
-		tmdev->reset = devm_reset_control_get(dev, NULL);
+		tmdev->reset = devm_reset_control_get_shared(dev, NULL);
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-- 
2.49.0


