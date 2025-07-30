Return-Path: <linux-pm+bounces-31621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F8B161FE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C29216AF59
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC32D8DD3;
	Wed, 30 Jul 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Rawgom"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C52D8DA6;
	Wed, 30 Jul 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883721; cv=none; b=SEv3YFY0zrM/TsVxxUd/9QfRWNrdFUXxyWJCLVpLIw55YtX+IgA1KSSfgRjjGSASJQu9Rw3UvKoKJn0WJYn2VQQGjjsVbiompCs5K8nH+j0GjOAzptKuCM/5gNx0ZOSewzbBAGy9BfoeE+mHv9y9VG2hVcORA1Fs6kgOPCkjt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883721; c=relaxed/simple;
	bh=YU/dW/YfvlTH/hER2tJp/xqGvn1giFSqovo//0fzglE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C7LRqH1rWf/ASqN6UZiNgcwGLHQS/JSmysgKO8B754BoETJtWpwW6mn1Y/8wWJLQMFbHYZDAsIQotHTJjX3k0G5jq45la+B9I1K6Hl7/MGOgXRYR85Ac3HNEVWcTIoJab4PKpsaGggGjsltbdQZ53bDkunxZe6gF1omYBFmWhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5Rawgom; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a54700a46eso3295887f8f.1;
        Wed, 30 Jul 2025 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753883716; x=1754488516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDRUrR7jLFhjPK5l5cm5SkFUJ3UJ78G28JJkY+HeZyU=;
        b=C5Rawgomg+cfd5gLvtMmmvQ9d8KxfV5VdfHvcvH6ZB6lhw5gOdKCBXFN44sp3/8y5J
         IHgtskMXKvy9d668I4d0t3mJzDigl2vmrSJjJwNNRi5S/uwqphK4oDywR0Ce3tUBa4lZ
         CxM4jY8dgCf998URg2H9AaUKFWUj5ESIIPnpX3hcdTYgzHLTmXoQOYQRI0YxbA96Io9X
         X+pXOicMLLW/M9ZyhuoyNoLQR+LTh0MG7AlIhthn3Io8urJWBa3a+gl5MQ5RXdJ/ZUcS
         MZTWaDoZP6D77DaL98oJqV6JZm0KzsPTEFBoq4EzHytwkSHqeOIA9hZ+7oEQ1aAr5/J2
         yLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883716; x=1754488516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDRUrR7jLFhjPK5l5cm5SkFUJ3UJ78G28JJkY+HeZyU=;
        b=jHHEwBVh9bk8WL8i63LTu6keeUpgGa5EsuPCYaaYrOIHitK9VzWWnnFhZIxsnoLAbZ
         HITOLIGWurKjfvfOKY/hvNLo5ZaO8pWJyl6/jU+MFFp5O/iNZgXmftAcGaN1yQFmjxs0
         /JVnK5lSvGR09VMpg3PYYVBsLKaQQomYXfr2vIUimIbyaKs53hNrJvRhMybwJcWoGaEH
         OREyWUIuDpK1nRmN+XhpdngjxOwppOlYE7C9BPgOr6+7lRYFkxoGFGjiBWeCgwgWibkp
         v6RuVxnUDPjRSsfbKjLs1X7A4diUFHYJ1dsiXubDyIBEjagwqpnPH8I7kBjE7dAJaXQJ
         6xlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/MjNvnhFkFOARVn6wN55hxAWBnR0lIDnZ2uhTWZLLpz/HBxf20q3eZFfEsms30wImwV6KrF/GZLHkxoU=@vger.kernel.org, AJvYcCV/Z2POQ2NQDY+BVprGrbTqhZar9ZVW558dtbaNzHfhJFYrh5X9GoRjZS87rUSoPYmOSASNLlKzxh5Gj1I=@vger.kernel.org, AJvYcCXIAR+9FlqLU1R+WfKSqVk4QfWTkCWp/OQldSj4+ew8MpG7AxHkJyu0ce0LAsX+pRRQJDFprfG2fRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpajSpZYr0yK4aHLwInEWQFhQRPMBdsopfPXY35PX+m/tq9Qj
	qLeLWOq1kiLcaGtY8Ee8uCfIeAodKcgf2LpUJ7iqkjydRkjhb9v9KihU
X-Gm-Gg: ASbGncsCVFFI7oFyqdi93OgS/Cv0TiBB4iW5kkSCkJvi2DcrQPZ8uxTg+LhiyonySwA
	gKghpYeoXZyyjJzvpZmltzHHJ9exYdhdrWa5+tD0FyjiL8g6EL0J4ZiXNgMKxZ/HNM932JVStDN
	6b8iu94LQKf4Nk8T4XnDKmB3XHSx4VdRWxMuCo+wjnfQs2BZQHawTGhMYojgnsXP57zAWq7I+kF
	+ZjVJyuRTg3LQvthAT8q7syLMdu/HZS9s3Aay8+1Plt3fe0hylMm+opjx2OX0YaJDtbc0LdwDN1
	9/CHm+ypV7KoUR2rXcPKj5jJFLWLOefbQY81vlTOCQymmADqS6UHEzhhIhDti4MbyN6kPenowKn
	ToV9viOL5HKPd8mL3DXaX
X-Google-Smtp-Source: AGHT+IG84gA8NDQL60kl/IRMOVr/pEda4caIsf6Y3Ezh+Bzhl38QjVGbmdzGZ66AzfHUoXZVqkeigA==
X-Received: by 2002:a05:6000:40df:b0:3b7:8228:7a35 with SMTP id ffacd0b85a97d-3b794ff8988mr2691890f8f.46.1753883716203;
        Wed, 30 Jul 2025 06:55:16 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778eba147sm15966246f8f.27.2025.07.30.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:55:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: tegra: Fix dereference of pointer tz before it is null checked
Date: Wed, 30 Jul 2025 14:54:41 +0100
Message-ID: <20250730135441.2078022-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently pointer tz is dereferenced before it is being null checked
leading to a potential null pointer deferernce issue. Fix this by
only defererencing it once it has been null checked.

Fixes: 6fc2e1a5f98f ("thermal/drivers/tegra: Switch to new of API")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 53a5c649f4b1..53fa6099b67f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -585,14 +585,19 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz,
 					const struct thermal_trip *trip, int temp)
 {
-	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
-	struct tegra_soctherm *ts = zone->ts;
-	const struct tegra_tsensor_group *sg = zone->sg;
-	struct device *dev = zone->dev;
+	struct tegra_thermctl_zone *zone;
+	struct tegra_soctherm *ts;
+	const struct tegra_tsensor_group *sg;
+	struct device *dev;
 
 	if (!tz)
 		return -EINVAL;
 
+	zone = thermal_zone_device_priv(tz);
+	ts = zone->ts;
+	sg = zone->sg;
+	dev = zone->dev;
+
 	if (trip->type == THERMAL_TRIP_CRITICAL) {
 		/*
 		 * If thermtrips property is set in DT,
-- 
2.50.0


