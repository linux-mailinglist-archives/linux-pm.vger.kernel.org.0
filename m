Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FC4EE7FE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiDAF7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 01:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiDAF7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 01:59:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D22258FEF;
        Thu, 31 Mar 2022 22:57:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w7so1650249pfu.11;
        Thu, 31 Mar 2022 22:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=2goerCXFIjJfRhdsQA7H1cbzpZCM5jdQytvLfoXzf9I=;
        b=M/+9D16q/zvVvZPUM76N+Q/ECCI9Ey09mr5VSHiUnT0iJdutYgmJUmFbw9dhps+blM
         Z5b1K+gWKiE/oPTLuc1jO7K05hvGLIC2qvNV81UuJzjBv7vTl3VFGBrBs2/gVBj7WKGT
         dffQXCb6szBFcgWGu0yDyqGirBFfinu8pOmrLZd1527uEnEL3L5cQ7PcXm4/Z9+tXkGa
         2QTWDz55dfgFJFUYlOeJ1LbfmLXsq04kp8cPJb3cohGHLreediS4DgCwfUy9L9m24npI
         pt91s66KiS4tC6VVECjKOFvW6C4kIN3jTfNugDxiHT14Uf1J/32o/DBzKOZR3abDUleA
         YYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=2goerCXFIjJfRhdsQA7H1cbzpZCM5jdQytvLfoXzf9I=;
        b=tDsF2vEbsG7N6bstYcoR3vZhzjT4ZdX3qQn6MJumV0linOZ+M/xUuCriikqQky4jC6
         Ehs2oDopC3IEnIQXILHI9d5/e2csVST1vQ35103LGAyeufryN/exnd5IYmU0rR5ldF7A
         vst/rOd8z+v1ePV512s92NMHbswknl9PXwxOVHWJexkvKiVJP+lYyGEv814qUSwHKdKA
         maDWh6ndKqLQtfLCVP8vwZTi4v73R7Kh1E/8ImhanP3qPCWKj3dq8FpdCTKevO/d5Pty
         bs32j49lFtII0D7JcS7XspCFPMGMTtOFfV5NnNcUi4I6/uPQIQszu9XjbGkIhsWKvYi8
         4N2g==
X-Gm-Message-State: AOAM533kIL7tbAxt77DHbTA2bm0j8ZJFu/N1y4F8K4fhQj+/ahZnImj+
        IPgnjJzXVqamhcENUQ9gFFE=
X-Google-Smtp-Source: ABdhPJxWzeDVS8xBfJp7EzS6sGdBaSQiZhITr9tSXxxyNN5e9ZsqIE2Tfy02Z3WdOjnGFXyQQmLpeQ==
X-Received: by 2002:a05:6a00:1a06:b0:4fc:d6c5:f3d7 with SMTP id g6-20020a056a001a0600b004fcd6c5f3d7mr9204515pfv.53.1648792679389;
        Thu, 31 Mar 2022 22:57:59 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm1495139pfj.151.2022.03.31.22.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 22:57:58 -0700 (PDT)
Message-ID: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
Date:   Fri, 1 Apr 2022 14:57:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -pm] docs: driver-api/thermal/intel_dptf: Include isonum.txt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For the "|copy|" substitution to work, need to include isonum.txt.

Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
Reported by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Hi,

This fixes a doc build warning reported by Randy at
https://lore.kernel.org/r/73d98132-1d08-ef29-edb7-9e062b9154b8@infradead.org/.

        Thanks, Akira
--
 Documentation/driver-api/thermal/intel_dptf.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 96668dca753a..2df82719c5be 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. include:: <isonum.txt>
+
 ===============================================================
 Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
 ===============================================================
-- 
2.25.1

