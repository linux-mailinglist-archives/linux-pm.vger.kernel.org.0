Return-Path: <linux-pm+bounces-1287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D998173E0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75361C21E45
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEDD13FE6;
	Mon, 18 Dec 2023 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8S7Ru0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B2200C0
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so1774405a12.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702910402; x=1703515202; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQTHmPqAi3BiL6/SuUuJyEm6v6KImHr4PNYUjCrz2Do=;
        b=o8S7Ru0TO0sOoJc4eHASjA7/NQDC/MG6s8TZpndgov9Y+waUpWvu+byzmaTaXLOOMS
         xgoPPyuUE4uLkM4F/m9EKfwrHABK62mkAvdeC0b+rsXQ/1xrVCwylKltOjE8AXEUdqVj
         ut18DPxyCCNLJEehmzIDRyDyww4QpzSN2oFbZh+fkSMcNoZ7G5VXBytNDQmSRMe/FKXO
         8T6zKO7rFla4gx+GvaHpzsgu7oaC40KyfYJWiuJZPduKlP/fdZyYbxnadFuerNwSMT2Q
         E9tHyhP6p9Brv61LgTVZPceH2tUPT2Hf5z1XOIOclovbkTMq9rfd7RUdgXovPY0yzKBK
         XbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910402; x=1703515202;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQTHmPqAi3BiL6/SuUuJyEm6v6KImHr4PNYUjCrz2Do=;
        b=MkNzYPeKp5Y4bp6RPibM2vIGiIxQeijPV+GxFmq+eTEZXIJBO7H2gzxqfjTuFudgLD
         iLUrt65XaikK8ZvEaUlj+s+UtTIzGJX6b9213UczSyJb76ipvFWtFIhICuQAJ0WoExL0
         sjC8knkNVVkJOc7fANz+5p0W+EruTf1F7uM0qr87Na9owxilDnPqNbjs1d3OAvz/FZQl
         bGtBXz1Oh2sFB67sU6epQTFjntmp5l9kD2MjmVDdedVvaNzpkfySkJbOdYdfa2Fo8jOe
         JLSQGo4bl6fg942wiv05q5kYa+B8znTblv7N2ReW0DOOOOvOAhMDl+k9oc9PT1v3EBuh
         ElNA==
X-Gm-Message-State: AOJu0YwojcGjwGtlllNBpFjUg5fxbXB4GYRcM6kdydKXz1z94aSzbKAu
	Lncc2jBCGIS1wxa8bAxKLMbLEA==
X-Google-Smtp-Source: AGHT+IGieG6PHSpO7kAdb+8EmH7ka7SFF91cTZxrMXWbWpVh5X/q1rwqv3Vyvx+8ZcYUYPpLejfn/g==
X-Received: by 2002:a17:906:1f4d:b0:a19:a1ba:bae7 with SMTP id d13-20020a1709061f4d00b00a19a1babae7mr3766338ejk.141.1702910402457;
        Mon, 18 Dec 2023 06:40:02 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090611d200b00a2362ef4387sm654930eja.49.2023.12.18.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:40:02 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 15:40:00 +0100
Subject: [PATCH] thermal: core: Print out thermal zone name on
 update_temperature error
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-thermaldbg-v1-1-451bcb723e1d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL9ZgGUC/x2NywrCMBAAf6Xs2UAejai/Ih426dosxLRsqgil/
 +7icQaG2aGTMHW4DTsIfbjz0hTcaYBcsM1keFIGb31w3l3MtqyczVZIXlinNBuM12DtGOIYz6B
 Zwk4mCbZcNGzvWlWuQk/+/j/3x3H8AJUeitZ3AAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702910400; l=1225;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UU7uKTLN3epJ08kwExjhQmhXBD0r95XXPC6qw1eXEh4=;
 b=Q+80yXiJ0lRIuo9VrUzn28vbeGgMSh97SH+S/F1mpK+OYOMmKiVcZfD0RqeQlgjdcaarchEAE
 ydCTp+GOpjcBkEoRxIlKLtjUyc9Aqg37NWxIYBTeZHmiULKGfh7qFkg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, we can encounter an error like this:

  thermal thermal_zone48: failed to read out thermal zone (-19)

It's good to know that there's been an issue, but on some occasions
(like the error happening in the middle of a platform crash), one may
not be able to look up what kind of thermal zone that is.

Add the TZ name to the error message in order to speed up debugging.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2415dc50c31d..a6ccf93eb34e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,8 +403,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 	if (ret) {
 		if (ret != -EAGAIN)
 			dev_warn(&tz->device,
-				 "failed to read out thermal zone (%d)\n",
-				 ret);
+				 "failed to read out thermal zone %s (%d)\n",
+				 tz->type, ret);
 		return;
 	}
 

---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-thermaldbg-a59300435456

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


