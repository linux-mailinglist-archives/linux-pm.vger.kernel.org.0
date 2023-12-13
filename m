Return-Path: <linux-pm+bounces-1055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9181100E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C621F212AA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC23241F7;
	Wed, 13 Dec 2023 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1z2MXIG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF541A7
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 03:33:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so85966731fa.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702467181; x=1703071981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSuSsAGCz1bsucla0R6QxbX9WoW2LywF9inDSTsLob4=;
        b=p1z2MXIGnOqP1TPTOq3yDs7kb75pDyyvPmg581vNx78x1TlTqNcb+oVWfmi9eNzuyD
         FOwgu+6pooiqC+fLlFmmVRUNDnhnK696T4n8QBD66TX4BMBN71MXMzvqtGB5Hx6RzPU3
         z1a8t6EVP9wQ3wSfrRznDx1i/2QWiiTe9ucDaZpJxzLstBfJ2tr6+hjVZZU4pj7PyrTx
         Z3ab2zSdSFDxOBqqeWgZaM3ttjlU0wt580nIZRyRB4p6b+af9GBmPuSOwW+8v3Q95+o8
         xURJwliApXsx37Tezhc5rNY+vpOdhYUZzOPcP3Ct6TwbW9LiMcw3Tuvih+d9pW8w2qnY
         CKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467181; x=1703071981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSuSsAGCz1bsucla0R6QxbX9WoW2LywF9inDSTsLob4=;
        b=veDadsaBxMS3RBZpRJwAEwUNnDeLjUcIVRYcuj4/8mdIPIrTfogTPCj3M8SHlJ5T60
         6k8XybvZEQ9of/2X+l4AJ7mFRa3X7RlMbIZj3jPoBLNo57iWcWhwn2stcoZO7NBwMOMy
         OlS5dteUBejxngjQcIFHMHx+fLplPchKj0nTmom88hQvy+zlPM9ZyaJveUnV9Q7pO2re
         zj9Cj/J7LIwSZdBy1OJC4ElD4qLopGPf4H2yhhg6efmZEeYLsgq2AyDOTgNOcdL8nxX9
         v4UgIe0dcbyEXipFG3NE/tMZZROxxadqB51RajonNfUm5W17BE+pCsQXivMWEHdVpjz4
         PQ/w==
X-Gm-Message-State: AOJu0YxtAc7rST7foj609fB/8EIPlxGVPU/xhAZ4W1yKq4GAmmn1NeLL
	yz6gjTtHbZtnA6dOCnGgXn/MFQ==
X-Google-Smtp-Source: AGHT+IFfjiu96YZAhVw8RGb9KnLHzIXPeGt+cwOiHP2URRoBPSCcNNJIUlGsZdw4q0wcKrg5WYPNmw==
X-Received: by 2002:a05:651c:1a24:b0:2cb:28f3:244d with SMTP id by36-20020a05651c1a2400b002cb28f3244dmr2529901ljb.6.1702467181130;
        Wed, 13 Dec 2023 03:33:01 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e9946000000b002c9f71e61f3sm1812273ljj.6.2023.12.13.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:00 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: domains: Drop redundant header for genpd
Date: Wed, 13 Dec 2023 12:32:45 +0100
Message-Id: <20231213113245.29075-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "power.h" is no longer needed by genpd, so let's simply drop the
include of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cf65b5a9783c..9ee1bf2ece10 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -23,8 +23,6 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
-#include "power.h"
-
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
-- 
2.34.1


