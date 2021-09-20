Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609D3410FE9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 09:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhITHT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 03:19:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53824
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234688AbhITHT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 03:19:26 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20C713FE05
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632122279;
        bh=K975uWTYLGkLbkETM9T3s7Y45GbdozAN4S3IGUhBhMo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aHW8I2Ape/j7CC/v5qfy8w82uDqgd9bw/1PWkgZmB6fL3Qmrb/2ZY3xqBAW1sl8FB
         O/nbrIOk0nk81LowJuLZ6S+FpWCmjF+EoWzgwiiyz8yMN6FJ0YIh1VgCpqlGQ+8aiM
         0imNYMDdWjnKSER+Wfa5FV1/TR7+cJMlTBRCJfH2m9FIIzLMmb6mkXtDV/EmLnhyhh
         a4oA9Sx+gl1DyTnQjlMUYnxkRhmWuM2Y/GvyOTY6LsLV3L/ZieWr3d/JQ6JiI8tTsJ
         uLsUEG4/Ir/SXgF9PF81kp9Jw00GtFvch+W3+OYU+bPOg0pGANLRmqRxWSyeB7moaB
         S15lXlHllFSrg==
Received: by mail-wr1-f71.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so5002367wrd.11
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 00:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K975uWTYLGkLbkETM9T3s7Y45GbdozAN4S3IGUhBhMo=;
        b=0pPlOYkWU8vgD7kzxWB2wq84LgKQiHXJ29feHUj1/RKND/pWerTk37uBNtfrNssTYT
         UlS8nORtZlZ+L74sfhH0tfDUbcfWbqn2FOa28GJXg0VDDA2ucguksGOvIAEL78+thbBp
         oI2qhbHjelw3LDOl30f0HTuJIB7bUVAbPHYDQZRX6bPB1BqsJabgMNGfYjNygpKUqPiH
         WbEmUh56HiPl+30UsxYHlPZ6C9wdv17en0LNaXcypRu/oDdbaCCullijSV16FCOtU1Gf
         SqM0z2cTkUWV2VRodK1r5A7cUueKre5tp44W8wPX+Yz5iEBZaZjgTjMjHz7VMCU577lL
         o4rg==
X-Gm-Message-State: AOAM530BaPl884ImIip0VnqPTuJEgHbY4xsHhlWpk0QqGFdxY7+0w5Cv
        KdPHbjeY90aYNkErg7886eOqRpVUU3UTKXp7aXWRg79nBAi150LyhFsFRC14ScY8afN3BsR/MdN
        VwTmlJGiGh4zikjFgwJN7MlII99JkQfaZ7qwD
X-Received: by 2002:a5d:668c:: with SMTP id l12mr25958811wru.436.1632122278652;
        Mon, 20 Sep 2021 00:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW4RCYsQAwDVi//vMFGQ0H5hMTUOpmow8nulLe+L4fg0CAxTaF+uxW5s557hhH8OPbHt+Sdw==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr25958797wru.436.1632122278512;
        Mon, 20 Sep 2021 00:17:58 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id a202sm6990798wmd.15.2021.09.20.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:17:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/3] devfreq: exynos-ppmu: use node names with hyphens
Date:   Mon, 20 Sep 2021 09:17:51 +0200
Message-Id: <20210920071753.38560-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devicetree naming convention requires device node names to use hyphens
instead of underscore, so Exynos5422 devfreq event name
"ppmu-event3-dmc0_0" should be "ppmu-event3-dmc0-0".  Newly introduced
dtschema enforces this, however the driver still expects old name with
an underscore.

Add new events for Exynos5422 while still accepting old name for
backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 17ed980d9099..541bd13ab61d 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -94,11 +94,16 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
 
-	/* For Exynos5422 SoC */
+	/* For Exynos5422 SoC, deprecated (backwards compatible) */
 	PPMU_EVENT(dmc0_0),
 	PPMU_EVENT(dmc0_1),
 	PPMU_EVENT(dmc1_0),
 	PPMU_EVENT(dmc1_1),
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0-0),
+	PPMU_EVENT(dmc0-1),
+	PPMU_EVENT(dmc1-0),
+	PPMU_EVENT(dmc1-1),
 };
 
 static int __exynos_ppmu_find_ppmu_id(const char *edev_name)
-- 
2.30.2

