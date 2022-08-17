Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1419596DBA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiHQLkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiHQLjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 07:39:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26031832C3
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 04:39:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r16so6668841wrm.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=A8ZUWcf2H4coRkYM3YJ09Cp6IZsz/6g0Idxt2WH37r4=;
        b=X1JqjluQIOGSLd8osUM8ZAeX/CMO+5Iuvjao0NiTxu4/D8DSl3v0ve6VYqZ7Qw29WQ
         omF012Pg4ojCTiQ5MdjueSt2ER0Ai2RvIjyHcP6A36/mR/qesfyVusrcKpsuive28eVX
         bzegCx/Hgx8WbJqOYPiiMCcLXmjN5U5j1FNwqXj3d8rgrTwIbqfxgr/jcS6ZzGUfMB4w
         c6tJKmOZuyLYE2baaOLmFynvnq3i+fOeidvplgvB5Kvx5VcxlZafneL/FL6UBazC7qZa
         xRraDkYpz0rFgpOWxuhZ0eytXA2u/82XZBaz5oU3jcBNoZ+gN+JxDclPhxxm+AmgbHcW
         VVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=A8ZUWcf2H4coRkYM3YJ09Cp6IZsz/6g0Idxt2WH37r4=;
        b=tvSAwL7Gc2I92kRYuV54bs/I3SD01BVoNCUUvfP9DhiMOilrXvPQCYmQ1DnG8QbsyL
         wMCGq9FcGKyb5cpe0lXzcgEBeL4ze7elmGm7MvbRui6NZZo6bphp38criqidCt4ArF+R
         PWvJivkT8cDeZNNUekQaHbwiqjQO/OyujOXWIjkojPUvUG1uXqtKpI1JspWCzaj8/MbT
         6pLYmmDRd17OxiS8mRz0qZtlTakk+NFTy2aO+HYhfgzJXKjUD/qm4TW9ggxX2lHEPFfJ
         Y7qAGrmWT9zaiOmriQX7pXIElioKA5AnyKg5sO0kAspTK9uOWpnh662eXXbxSCxKGhik
         xXjA==
X-Gm-Message-State: ACgBeo2p+1xWDwHgkVV9vNMsFaAW0PH1bOtEN0n4pp+GQac58XPogaGk
        KgEdPFcVwf2gZY+MTu8oqCm2LYg07Q1+gg==
X-Google-Smtp-Source: AA6agR5JKUWVW1vY8hKzruWPyQCab9OHhOohXYTdnmU1ZsiLnLRoJjwgNE+w1Dbkk5QvwJjiavL9MQ==
X-Received: by 2002:a5d:5887:0:b0:220:81ca:ec4f with SMTP id n7-20020a5d5887000000b0022081caec4fmr13609103wrf.263.1660736374599;
        Wed, 17 Aug 2022 04:39:34 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r17-20020a05600c425100b003a5bd9448e5sm1512508wmm.28.2022.08.17.04.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 04:39:34 -0700 (PDT)
Message-ID: <dbd20ef2-f109-0675-6fbe-8d08da5cc5a3@linaro.org>
Date:   Wed, 17 Aug 2022 13:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v6.0-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.0-rc2

for you to fetch changes up to 8c596324232d22e19f8df59ba03410b9b5b0f3d7:

   dt-bindings: thermal: Fix missing required property (2022-08-15 
20:38:40 +0200)

----------------------------------------------------------------
- Fix missing required property for thermal zone description (Daniel
   Lezcano)

- Add missing export symbol for
   thermal_zone_device_register_with_trips() (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (2):
       thermal/core: Add missing EXPORT_SYMBOL_GPL
       dt-bindings: thermal: Fix missing required property

  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
  drivers/thermal/thermal_core.c                               | 1 +
  2 files changed, 2 insertions(+)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
