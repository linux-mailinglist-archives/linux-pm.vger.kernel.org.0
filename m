Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1347FADC59
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfIIPqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 11:46:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43827 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbfIIPqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 11:46:15 -0400
Received: by mail-io1-f68.google.com with SMTP id r8so4859209iol.10;
        Mon, 09 Sep 2019 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+8o/RGK/NPs8632xDSooMJK/phaky0Ro4hwcCw71TCc=;
        b=JVGesG1mnmTyr6WT/iYtanVie5DVOtHQYVM7hTxh57S3deO0Wr539W3FHqd7jUBIQM
         8HFwZj9JD+ynD2ZPR3LHJZAlIdbyODk7eftG12HWNqjYYoBtRE5a1J5kB9q5EshinA/U
         xnUpCaqgHXXq/93EOzbizgqirgU26zOXiSSbeAI9mlZSatKKRR0CSVrUl1dRYsdvhNZ6
         yIz1SqQABjMOyqEGTKVbX7mfrlSOeqvxq15YOwJZXsMY219Ruaypo+eEazOhnxVXNXcd
         usjQyCxidilCtP3QrlAES09YnUE6I21FOvWgdRjDUN2bm54zPmT1w7FFGFUxAmw1I7b0
         TUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+8o/RGK/NPs8632xDSooMJK/phaky0Ro4hwcCw71TCc=;
        b=Lwz4MzHkfNsDMvMRwDaBpqVIUQHhEqCN/YzWAbu1sXqkCEqNUhRceWOYPxMvpk0yee
         yC/ef1NbPTe9KFEOInw712YL0Q+2DvFMKVIf+CSim0jtjPJirzNbq6LPyP1h4EJR79lE
         Ghdv0rRyoWRlMazs7wuv/tOjwXTW3jwj8NE9Sf4zY+vCoMjSH9+DYkchwcEBc8UOCJXR
         B2VoSobzATXUnmJ9YtqeA7sC9htbJ3nkMTGe9w4vq5iqv9+T3zE9WY2ZgRnOaOQ+HBPU
         RMp/K2M4rSs/aXVVnBxIAD3vr4C2yvwnRKz4YhuEyUGMvGmy4M2ihgB+hAgjcNREBvCJ
         TS8w==
X-Gm-Message-State: APjAAAWHMlZbd3AbDm5jfTIr3XFGQ4zVFNV+fP3YUkqwaS5zWKeAlh7k
        8BfLtmfFSms7/HvGo2jTeT+CqJ2jE7Y=
X-Google-Smtp-Source: APXvYqw3jiFsdDxXaxUuwsb4anV8XMwCTd4KNpVihyxLf9uoXYjoahKJ+etNOiOjAaM9BUZpQd2S2Q==
X-Received: by 2002:a6b:7e45:: with SMTP id k5mr13113583ioq.178.1568043974166;
        Mon, 09 Sep 2019 08:46:14 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id a21sm10402395ioe.27.2019.09.09.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 08:46:13 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     neolynx@gmail.com, letux-kernel@openphoenux.org,
        andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com,
        hns@goldelico.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
Date:   Mon,  9 Sep 2019 10:45:01 -0500
Message-Id: <20190909154502.19804-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AM3517 only lists 600MHz @ 1.2V, but the revister values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch simply enable adds the am3517 to the compatible table
using the omap3630 structure instead of the 3430.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f2f58d689320..6b69fb1d6bdf 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
 
 static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
+	{ .compatible = "ti,am3517", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
-- 
2.17.1

