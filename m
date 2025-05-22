Return-Path: <linux-pm+bounces-27492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5ADAC0725
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011929E6111
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEE2236F3;
	Thu, 22 May 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM0ss1GM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DE195;
	Thu, 22 May 2025 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902732; cv=none; b=YLK6Y6P0E33LTGa1/5ErZ13D+588njshHLEBzPAQLuK+efPcWqprLAVqjEema+vwtnmwEVPHtAkOUyO/eULyjnrYu1yBx1svKItFZ3wxF3M8Q6NIlj9xf2GLtym2iY9y17AQKR2NU3gdggyeq2bE0pTCOCpqYyoUd8Ync0JU0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902732; c=relaxed/simple;
	bh=WZQ6HWfccKpwFuwd6OP4pxDr+2OU5kN37ioPZebYFl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iwUN/XBEfbYopsDe4MWszv/f9vMwfC3d9oEMdjG+/yjI3oV7FDkAsceb8/AkIUR2JaPPTerNWgN+QkPHxVo368bRGYmdYP1GgQmRF+JhyktYyc8t+E1P0szjOogBug2a7Rk5TECgurjnCBglWCnvizI0QlTpG+7B6bSEuyUsTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM0ss1GM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso4392485e9.2;
        Thu, 22 May 2025 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747902729; x=1748507529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrIJdQiEhSsbGgqftG4sW4hqql7zVGZrpv/yvD1/dGY=;
        b=YM0ss1GM3VIAb1pDTO8vPvQVtWKTnCSHMogESU1yixqLQDUlCdM8Q0BjCvjw2G5iHk
         WxX+jy2IpIDbHU6kfIf7LQAGDHCa2Ak7TOhLVZuisID/0B4ukAVgjgFjlW/HK0OQA1Ma
         elBLHmSc915XNtMy2cLXOk3NLqKLGIQyI9QfaVAXoR1dOs+6wNEVntBNKiPoMm4ZbvB4
         n+n5GXDJmib7AxLZuwV+j/lpUPljea98f1JWQdDdeuhu4VuASZAmVaSe4eJrIqS/qCan
         xwNFG9InQJXwkkqUkbhLGH18Tup2pp4/QLmrm8e/KPMRF8l3aPz2yeQvRZ1922fR82yR
         FsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902729; x=1748507529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrIJdQiEhSsbGgqftG4sW4hqql7zVGZrpv/yvD1/dGY=;
        b=g7xjfiUxUgJtCB/OcQxnMpScxiCMMBGJ60ReCXFeGSCm5SDDWUz0A/p97xSxBPwYE8
         ewzubPEn1K1TXICAamdssbswGk9BMI7+3xVM2s4ZOAtAcaL5UFXKedPAp0YaPX+aEcCV
         BGb6OlItg8OP6IRvzAzD1koaNqSsY2/FdUC21KF1+0UWLE+YS8Fcbs5D4Xnvwx2159ZN
         dP0SS2hbAi2V7Iear1SEJ/MoU5NAmidBDJ57DKxHGYsItsblMCW7IS5ht+GI4NXobkzE
         NOAC1EtMAen3Qs1Qo/PsSUEb+8UOFhFZ15KgvfnqmGG5wbLTubqfgNF/eLoI5HobWzQ3
         ToRw==
X-Forwarded-Encrypted: i=1; AJvYcCUE8UTYHb3LAqzqFxlx5cC6wT5IJX63ml6YtQPNI7kv1b8xxZ5iBvLZLrFNfHEnWvCNPvdiiT7ZT5Oz27g=@vger.kernel.org, AJvYcCWWPwJQQ6jQM5xzhPvUEdqHr/SgMnwQfYqnjBlztDe0fmYnmS/CL1O3nLYxzputzazZa2oK1nFrKYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00v79L5vWhep+sVPVoVlmiRjqtS9cdDkeiHpDg+qtDAifSQ9g
	tMvO0Ok+h6GRKIaglbHQ6vy1dSL5p1Ln6QSjgsOxEbAYgRFo/Q07f//d
X-Gm-Gg: ASbGncuHf+8/KeSimNFaTqyfJeLxU2JO/eq8fHB8av/BHu6W6n1qAuj83Z/saYJXgrs
	bDRFDpFjm7IRg9jsooIRWJhX6n8hLjC1gNw+LZvnQROnXrGWmhvmZ8PvZPalDDM/Ueln/q/4IFS
	lDTw6zQxfguiwQlbhoGxNA0HsydQk6xnrRlj3Y31AGt+LX0TXSKUu6UFKVN49HPX5PBk4nf+2Aa
	4YZcfZ+JWjWdZtZgLNNn5XCEhsK6wqPo0fHHyUcV38ezwyGp41ceNSaA3Y0piUR7tTGWgOHLed8
	8LcYHiL3olx6xh7VHlIohnrwiKP7xx6saOZ6NiLqgyhs5piFPg==
X-Google-Smtp-Source: AGHT+IEWxTNbNldirqzkPayemAcdRy+LiGEXRQOfWvBP6iR1PKB5wnbTpTszol6POISM5nSMgXTsUA==
X-Received: by 2002:a05:600c:8709:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-44ab48784e8mr9569075e9.17.1747902729154;
        Thu, 22 May 2025 01:32:09 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f7ca2dd9sm93544565e9.37.2025.05.22.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:32:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal/drivers/airoha: Fix spelling mistake "calibrarion" -> "calibration"
Date: Thu, 22 May 2025 09:31:57 +0100
Message-ID: <20250522083157.1957240-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 9a7a702a17de..b9fd6bfc88e5 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -352,7 +352,7 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 		priv->default_offset = airoha_get_thermal_ADC(priv);
 		priv->default_slope = EN7581_SLOPE_X100_DIO_DEFAULT;
 		priv->init_temp = EN7581_INIT_TEMP_NONK_X10;
-		dev_info(dev, "missing thermal calibrarion EFUSE, using non calibrated value\n");
+		dev_info(dev, "missing thermal calibration EFUSE, using non calibrated value\n");
 	}
 }
 
-- 
2.49.0


