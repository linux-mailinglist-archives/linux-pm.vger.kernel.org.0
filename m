Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106166E0E4C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 15:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDMNRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDMNRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 09:17:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9210EA
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so6154273wmq.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681391838; x=1683983838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5fFOxM2M8ye7OTBHtbOgOjz+8frsv+eTncE5p8viM8=;
        b=T9BU71wavViVUYBMTDE+hcbRAc77asym97Q+vAZdeQ0/tt/SvQZu4WFosGI0lp1zDI
         /4ZUBDyrIVTMjE9tZRT6DXigjhxwaxshTBOZkuxX5shKdEzjR53fag+SEEJARuwGTak1
         Fpob0YAdn9wBMUDHq8H+x7isdAAo/tSUCRx2JSBbs51pOVNhyCvuJjH5fD2j180PtURV
         mwKhNEaZwq55CodUwD1Qt/2Y67nDCt5ZEmuWdTEOdLAtKhMzHGDQfKEGIsaAaomw+Hkw
         C/D67FQB/eQa9XS0sDhRSP74aOQwzSYh67IZLOFwQEOzY3eU20/cjfRnHK9OKBo2YZvA
         t/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391838; x=1683983838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5fFOxM2M8ye7OTBHtbOgOjz+8frsv+eTncE5p8viM8=;
        b=cpDQxvNwwpjDyUV45F4i/wawxmEDm+oabPOPIRzuIqT0+tQZAABaUiW9vpmUnaQ/H2
         b/ycgX1JgrE2sxmuN061CkrYzx2lqobPLzMvpWcPu2vo6+5k9nXCZxhks8arUXnXUeJU
         x+n426seYJ5UN7dhcoMkbvfG04+NvY3Qxpbh+m/7gFPojLki4KNQsiv+KFgXFRFxJCHr
         LkH6RAPCVtn8xCc+hZmYw7DFuuaB26VhPqKDUJZKuCPtjWjs/bhyKNEzdEysgEpBXYFx
         r9Q1DIn2uv5iNqIH2HTcIF9QPp7hWGvdEFAiNLlVM7p1sylPywsPheq7EJRhVxRi91BU
         5EDg==
X-Gm-Message-State: AAQBX9dEvR/D4HDHGvDeQSgTOfNuEjyG8yu54bnnZYSjsmGayTM2/5xp
        WHV/tBKETsu38HXjtcW5sBz/1w==
X-Google-Smtp-Source: AKy350YD+EK+uim1v734a2iSFmcFos4CRGtJzrjtuPy3971LpNkXMYN9/oHNtdckCkZvhe02C9ZFaw==
X-Received: by 2002:a1c:7905:0:b0:3ef:5fe3:c57c with SMTP id l5-20020a1c7905000000b003ef5fe3c57cmr1420333wme.23.1681391838576;
        Thu, 13 Apr 2023 06:17:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:814c:fc8a:da02:39ad])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm1796400wmh.39.2023.04.13.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:17:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/4] arm64: defconfig: enable building the nvmem-reboot-mode module
Date:   Thu, 13 Apr 2023 15:17:03 +0200
Message-Id: <20230413131705.3073911-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413131705.3073911-1-brgl@bgdev.pl>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This module is used by the Qualcomm sa8775p platform for passing the
reboot reason to the bootloader. Enable building it in the arm64
defconfig as a module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e1063ab32658..5bdc9cede807 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -614,6 +614,7 @@ CONFIG_POWER_RESET_QCOM_PON=m
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SYSCON_REBOOT_MODE=y
+CONFIG_NVMEM_REBOOT_MODE=m
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_BATTERY_MAX17042=m
-- 
2.37.2

