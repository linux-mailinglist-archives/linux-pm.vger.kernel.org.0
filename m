Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70AC28CAF8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbgJMJ1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391427AbgJMJ1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 05:27:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7AC0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so23123334wrq.11
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8a9970NyoL8j/WouYPI3QrVUX98ELJ53wzM6Z8s7NI=;
        b=XHfjcF0ZziDDiY5hGxeJXZG6wHx+Mq3O7G0F92FKfFobe2YcU9Phyc5G0rUD1jDbGk
         w0yxK2uXGTFkfgajQvrtp7y46i/m/OD/KTnxf63f6ZEuCTWkzZbfk970AUST0c0le71N
         KpegIlZ3ee5uccsOOK2TBrIfT2n8JmAOS5wYyLwN/Von53kMhx8OaVjSPIpBD3ElrlWQ
         tMIjAzJTVBxjOZ+7+xJBG1XLMThQKZBdskghBck7fhMnD2XuIDQsDFlOqBOda7agxQ0q
         tYmpBahs9mj53RdVlX4Jx1+t1/6NQN1N/3sBLPr6uxvcGrJS2AarVnv8FlF2vm8ZyaxV
         um/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8a9970NyoL8j/WouYPI3QrVUX98ELJ53wzM6Z8s7NI=;
        b=Iyp2m1Zym7vaj94uE8CVO3JZQax61MbhPL/i82o++dJWbLVBhSpp0/36ppJQfgWbYo
         BdCx8KvJ/wa9xhSecH8hIRL8mycLLnuhwb870Jleb5HLIBQibbn1DD7X+pB5boTH71bx
         fi6S+aIHPaalarGSY6GCVdLp97W5Xr5Vza75wuwHR8T/u8Q85EEs3N/XGxsoI9PF/ztf
         kY0rEJa0p7wwyYKV2woGoG4j9V79m2m7caNoUFTdiHeb5WxvahZ4cXQFQ27cOMx+oooo
         TxIuZ/C7gqH57hkGylzkiyKaVcrVaCon12yOKHlcJnv6eYz/nkpwJ5LlseUJVpuL7qA7
         Gbnw==
X-Gm-Message-State: AOAM531rEXgYd/EcRMLDdxp+UNGkcIlfu+MKwXGeVH67xe9iirZ9L5sB
        SB4lfcrXIq0vB8Qj5O0vGVtdMA==
X-Google-Smtp-Source: ABdhPJysxJ0YjqYhgvuz7yO6DNijyqhaPhUZZeVNIIdsnRzkGQZ9wKFCrAovRtTSeI2LSqBeku+mIw==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19794943wrq.129.1602581235480;
        Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
Received: from localhost.localdomain (147.169.185.81.rev.sfr.net. [81.185.169.147])
        by smtp.gmail.com with ESMTPSA id f6sm14484830wru.50.2020.10.13.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:27:14 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] cpufreq: blacklist mt8516 in cpufreq-dt-platdev
Date:   Tue, 13 Oct 2020 11:27:09 +0200
Message-Id: <20201013092709.3336709-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013092709.3336709-1-fparent@baylibre.com>
References: <20201013092709.3336709-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MT8516 to cpufreq-dt-platdev blacklist since the actual scaling is
handled by the 'mediatek-cpufreq' driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b8d48ed37156..73cb8f2ad9d4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -124,6 +124,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8516", },
 
 	{ .compatible = "nvidia,tegra20", },
 	{ .compatible = "nvidia,tegra30", },
-- 
2.28.0

