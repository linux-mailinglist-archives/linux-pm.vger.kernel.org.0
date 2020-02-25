Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9A16B8BD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBYFIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:08:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39817 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBYFIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so6541039pfy.6
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdantuu/5XxtE9f3CRUqpZsUq5/+hM9onGf3l9IzGoE=;
        b=eseBaJptDm8Ew+v8SqbkusD/nIsIJS5Q63dC5indg6vPCEKfEsMcIPCQ8LryIf6XAJ
         luL/+OrUx2Oy46HC+ptZ0HilMyfsc3zomlNmnYnHrzOLjZXAFyJ08p9/b5DGXYu8eaNo
         PUEltGUedjDLPkqZYyTqtRnfnUv2t/X/LDaRewmylTEofSd4xUVGA5OvCe0kLjUwXBn/
         CRfUhK+/zob1g6uYsBJXymtFuGPFlDawi9R0laHsTU7R41pTUTtrKve6Bra6du4WP12c
         XCipO95SvbpgfSoF3P77ZiAEQSxcEhkwIXQFr7HKn24Gcs06BdepRKmhhhLGfZjwPG7U
         nieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdantuu/5XxtE9f3CRUqpZsUq5/+hM9onGf3l9IzGoE=;
        b=SVwUERgGoNYMwHCG+Qa4TIs5n0yDO41d/j3rzLsoM2uLbXEaFqorR120nrhd/UKUn3
         bJZ6MIdF+8Pfdp8b5k+cQqIEzw1TzlxdmHTxy/MQGcba70mpJPFhOoD/yY7kvqkc6EhB
         6QZ1GN6n8eX7QCof3LteCM8jGBJlolMXLyNfQFu1L4kvDdBOHO0hj8CoqObHcjEE+MW/
         uMe4gBs/fpPmLdyah1evGVjIjQnnovzvfWP7OzAS7KTAqPQb8zsMeYZty92YcolosN6u
         fyqPtSvR0UqGlXAYTYW15tJIA6cgzw/6fSy+5x7kFlGlmeFfMoqYOY9ixCPZ8Obv2bcO
         zTJA==
X-Gm-Message-State: APjAAAXypoLzifPU0BliWIHzg3E706pMesV0wwVId1SDwXyDLgcs0QnF
        ndAg6KaQ4DVFV5n5OQSNedBIdg==
X-Google-Smtp-Source: APXvYqx5Kz8YB9icmd79yhCto0VvLnWu8Muf2e9T+i5OFmjE22x563qcKYydlVaxtypL+7AeLyRalw==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr9354407pgo.124.1582607321206;
        Mon, 24 Feb 2020 21:08:41 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:40 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 2/6] driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
Date:   Tue, 25 Feb 2020 05:08:24 +0000
Message-Id: <20200225050828.56458-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When using modules, its common for the modules not to be loaded
until quite late by userland. With the current code,
driver_deferred_probe_check_state() will stop returning
EPROBE_DEFER after late_initcall, which can cause module
dependency resolution to fail after that.

So allow a longer window of 30 seconds (picked somewhat
arbitrarily, but influenced by the similar regulator core
timeout value) in the case where modules are enabled.

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v4:
* Split out into its own patch as suggested by Mark
* Made change conditional on CONFIG_MODULES
---
 drivers/base/dd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d75b34de6964..fe26f2574a6d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,7 +224,16 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+/*
+ * In the case of modules, set the default probe timeout to
+ * 30 seconds to give userland some time to load needed modules
+ */
+static int deferred_probe_timeout = 30;
+#else
+/* In the case of !modules, no probe timeout needed */
 static int deferred_probe_timeout = -1;
+#endif
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
-- 
2.17.1

