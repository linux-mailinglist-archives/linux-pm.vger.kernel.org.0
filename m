Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E98220706
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgGOI0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgGOI0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888AFC08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so4502529wmj.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCk19GsQjhT9V6ZH5VfzAX6PQXTZggJu/iEJMuF5hMQ=;
        b=V2Eh8BkZ8dcCa53IaQSf1cFlilO/zt8ksPMcm3ZyMf7Kh+zTEEuh90evBOvEi61Q2K
         54BEgKiKD5KhfqA0S1X2/Xd7JybfTairskcEafqLYETq1pXo/nwW50FaHThpGQJCKMDn
         N3w4k2sMMWuls8XD56YVqhTbHLtGtFTQdrBDWb/tFACe+fXHnJj4BsEkhGl8V6oDKxYs
         xzRwW8j16fa41Zbo1mO6xdgn8cV+YCawvLHsJt/E0QV8Vg3yLLpnjDCgblt7FADeb/9C
         es0UE0y/wxLnmsVmvRJLRckXYkWxyYcO5DGgT7rfz45lcFYKT+dOAz1YXilbEV5zMmX7
         /WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MCk19GsQjhT9V6ZH5VfzAX6PQXTZggJu/iEJMuF5hMQ=;
        b=frf13vyo4yYt+37YvVOXUtXdeZXFcDHxkNUYbjQTuepAvzOuG6FJTtnN4Z/rkRLWtJ
         i01CwGINVO3Ini5QfAQNJU7XFyXHCoDycktWP8oLMwM3PRBaWPQBLA6h+zY5xaNWc3rd
         u/ByuGyJpgAVIYvzQS5muc1MaEuExyw3PrOHlVze8xmqvQPReRwsvzVfNMs2l/BtKzLh
         9wnjRU2izYLzWxAKpDlZbMnF6cKr3wRyz+iGUYL+EfC4Jf9e1sVUWd/lfCO6EbUcuJIK
         F4gXMctBICGMAkXFVDLUSaQf97QSkCXfA1SGLRsS3qkt93mocABf0bStNbT7ICTJgR+1
         h8zg==
X-Gm-Message-State: AOAM530NHVFhUmO7Ptn/0RcOajYsO/oUgJHdyO0uY9Y5LJ3xOgIKD5AU
        6mcjhCw3J2FStcQOPkSNklcQysja2eQ=
X-Google-Smtp-Source: ABdhPJwMbYK/KKybcySvzNfcd30nLvna3tfOpKszLpsbnWbTflEcZDNIxJlMqKGZU3TgUfFpWQURiw==
X-Received: by 2002:a1c:6354:: with SMTP id x81mr7228802wmb.98.1594801604289;
        Wed, 15 Jul 2020 01:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 05/13] cpufreq: pasemi: Include header file for {check,restore}_astate prototypes
Date:   Wed, 15 Jul 2020 09:26:26 +0100
Message-Id: <20200715082634.3024816-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If function callers and providers do not share the same prototypes the
compiler complains of missing prototypes.  Fix this by including the
correct platforms header file.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
 109 | int check_astate(void)
 | ^~~~~~~~~~~~
 drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
 114 | void restore_astate(int cpu)
 | ^~~~~~~~~~~~~~

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index c66f566a854cb..815645170c4de 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -22,6 +22,8 @@
 #include <asm/time.h>
 #include <asm/smp.h>
 
+#include <platforms/pasemi/pasemi.h>
+
 #define SDCASR_REG		0x0100
 #define SDCASR_REG_STRIDE	0x1000
 #define SDCPWR_CFGA0_REG	0x0100
-- 
2.25.1

