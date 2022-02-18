Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC264BB486
	for <lists+linux-pm@lfdr.de>; Fri, 18 Feb 2022 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiBRIq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Feb 2022 03:46:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiBRIq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Feb 2022 03:46:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362362B31B6
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 00:46:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so13258721wrg.11
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ6qNiHE6Sk52IIqBzCxNgH1aeXYsx0LWdf4PlC0/pM=;
        b=xCZcy10umt1iU95uyF1HDYYAtoQT78wLBto1E1531wwqDoYbBKH0rb15jQuo6LSfIB
         m1XjAakEsHtG9xF+d/yo/bbCpg31K6DwPr1KSF3253UJ1NhZ++v4Cp3TzX3g4w2ql0bB
         DPf2r2TgY1NZVM8KR7Hv/qURaVzT16y8b0dV7R6GrYE/1rhTAVuRhGqbUEiAr/s49nZk
         EjbgKmFEVeZgrGc411xRC5rqnd8h+s0dIFwYCvSvB1Us5W9Ih6tT7qu4YRLUgW+0idr/
         VLQxU8T39OGFGo6KKCsw33/XxIcyUdsXf+TYyNOrCdfc+T+x0CKKsDoDiv4JhuwI5Vcj
         1O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ6qNiHE6Sk52IIqBzCxNgH1aeXYsx0LWdf4PlC0/pM=;
        b=ewpHCT1t4EYsHLSqQo60jdfDvwuI/uLXTmAGAy6faircxgDUGBi2lOIXObSkei3R8k
         OTpWIXakoVJ5vE0UxpzJHHWbzO2OhB1F83cknBjEf/3EC9LIPBXyjeWJL6524mCDGMRc
         NIWWMczSErXsj5aHnrS7FM3WVI2Dp6ZAVymmugN7HoyIkJDb2TSa4yWJhbMECPbu5ynY
         mOSU4xjraV6yFPrRk/qXibWlmY5F0IeBCJciSaHxWrqLninyDAsWrpEPJAGEwIxnkdao
         9iACIjLLa+Y0PwX7SVqUhgxw9tSqfzJaUGkkUALM6rUZll+C3oqgYJoClzvwC8spv0hl
         Io7Q==
X-Gm-Message-State: AOAM530K5BW5EVfmfhLntpuPJzB9KmxrIEa+9bRywfkqz51OK8wy+Z6w
        K75ktGC+uL6vCt9QGw82goWpZA==
X-Google-Smtp-Source: ABdhPJx/pRcqGHwuxBzeIEjRMPudhm97e4ozdTUkpYkJ+1+gL+yuW2Vqla8lpknIsa8Rn2BnLDLhSA==
X-Received: by 2002:a05:6000:1809:b0:1e4:b195:7cd7 with SMTP id m9-20020a056000180900b001e4b1957cd7mr5253868wrh.46.1645173969772;
        Fri, 18 Feb 2022 00:46:09 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x7sm33525478wro.21.2022.02.18.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:46:09 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/2] thermal: Add support of multiple sensors
Date:   Fri, 18 Feb 2022 09:46:02 +0100
Message-Id: <20220218084604.1669091-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Following this comment [1], this updates thermal_of to support multiple
sensors.

This has some limitations:
- A sensor must have its own termal zone, even if it is also registered
  inside a thermal zone supporting multiple sensors.
- Some callbacks (such as of_thermal_set_trips) have been updated to support
  multiple sensors but I don't know if this really make sense.
- of_thermal_get_trend have not been updated to support multiple sensors.
  This would probably make sense to support it but I am not sure how to do it,
  especially for the average. 

[1]: https://patchwork.kernel.org/comment/24723927/

Alexandre Bailon (2):
  dt-bindings: thermal: Update the bindings to support multiple sensor
  Thermal: Add support of multi sensor

 .../bindings/thermal/thermal-zones.yaml       |  20 +-
 drivers/thermal/thermal_of.c                  | 491 +++++++++++++++---
 2 files changed, 449 insertions(+), 62 deletions(-)

-- 
2.34.1

