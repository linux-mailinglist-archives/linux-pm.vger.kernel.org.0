Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7934761C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhCXK2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhCXK2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 06:28:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81497C0613DF
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 03:27:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y5so16994708pfn.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=g9iyCmKt9j7N3Numx34OcndHvuD7K8yaOLuNRmiCrps=;
        b=WcG1Bo5BZ6Hwgugfkis5NHOqz+/TjXZDQFSGE+syryZ6OYENWbgB6SV3i+Xf7WSXKS
         8BZe8RUcaUHclOw1YBJ5BxCC041uncrYLgMkN10sTcFI51h7fPyTJ+Ftxluu+YAYTCb0
         AeQRAxV/xVzAHt9Ud1nytvoDasU/f+sYLhSAMyssx1XWgRbyp759paysLsf8mc+WJCAP
         Khp3DF/DJLqq6DWdiDIbHSEshbJ7zaephtlqKAEWui23L0mo2mXlHgBDwt9m7YZ8Ia3r
         GT2CGc6pv2tevRPROSYVfnEnoR7I12XN+RUzYL9EyIGTkODRZWvMAIps5CYVwoA69kVb
         nVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=g9iyCmKt9j7N3Numx34OcndHvuD7K8yaOLuNRmiCrps=;
        b=UKjDOffI/EI1DR5jtJ/69B2IsdmUD1LBoVWtcuIJL+DY+N/7mY1AoHhAK6bQbk82h3
         zsBjgxbAU74bugh/fZFyoUtoP1YgRS9QU2/3tkh0LAInCGdKSduYp/862HZvtmi2oG1Q
         1Z1HAPoGlwbAVyYoyXI6nd3TG1+PPp5220ZsoezE1PEAFM1GPuNYaxW1grfoLQDBIKXV
         5lF7mHrUfOhKvQ8BQ/Hd49pLJFaddTukSD0RKDyGVubyR7sRIbPzFg2/54uMsJS3Jirn
         0057CBiq48UQLQvRJ4PnHbQKXGFqHeH/1oh8G2+byAZwgj9VCJEJWd+TKRliQ1NgleYj
         wRSQ==
X-Gm-Message-State: AOAM530w3F8/veCr48El+bGeAYw/ouBb/KASf+msdz38EupLM4jRjtZL
        Rmw7vwcErtrA1d12oaOCTAU=
X-Google-Smtp-Source: ABdhPJykuGIfkKU8uzinOfLHKJD87RsBhAtlu2wAxvx/fIhz1sImyz0O0Vk9aNWurO2sT9OqXn30TA==
X-Received: by 2002:aa7:9824:0:b029:1ef:2104:c72d with SMTP id q4-20020aa798240000b02901ef2104c72dmr2342650pfl.20.1616581675701;
        Wed, 24 Mar 2021 03:27:55 -0700 (PDT)
Received: from MacBook-Pro.local ([154.48.252.70])
        by smtp.gmail.com with ESMTPSA id e190sm2226447pfh.115.2021.03.24.03.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 03:27:55 -0700 (PDT)
To:     linux@dominikbrodowski.net, sherry.hurwitz@amd.com, trenn@suse.com,
        linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com
From:   xufuhai <xufuhai1992@gmail.com>
Subject: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state issue
Message-ID: <35ab0d0a-f9ce-b4d7-cd85-3cd8a8638ab6@gmail.com>
Date:   Wed, 24 Mar 2021 18:27:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xufuhai <xufuhai@kuaishou.com>

For the old  AMD processor (family < 0x17), cpupower will call the
amd_pci_get_num_boost_states function, but for the non-root user
pci_read_byte function (implementation comes from the psutil library),
val will be set to 0xff, indicating that there is no read function
callback. At this time, the original logic will set the cpupower turbo
active state to yes. This is an obvious issue~

Reproduce procedure:
	cpupower frequency-info

Signed-off-by: xufuhai <xufuhai@kuaishou.com>
Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
Signed-off-by: lishujin <lishujin@kuaishou.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..6f9504906afa 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 		return -ENODEV;
 
 	val = pci_read_byte(device, 0x15c);
+
+	/* If val is 0xff, meaning has no permisson to
+	 * get the boost states, return -1
+	 */
+	if (val == 0xff)
+		return -1;
+
 	if (val & 3)
 		*active = 1;
 	else
-- 
2.24.3 (Apple Git-128)
