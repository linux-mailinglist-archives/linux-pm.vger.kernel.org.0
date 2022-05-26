Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9D534B5A
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbiEZIQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiEZIQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 04:16:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46ACC03A7
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 01:16:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a1709028ec400b0015e84d42eaaso745353plo.7
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BAxCptwO7y2xVPn5yxfUXuZaiLDAgG5VdQuxNau2t/A=;
        b=SSAklAtF5M2MvdVlYodbyAxTphyyK02Oj42SVcd3FTLXmUoOWmKohwP0jyuy7Dywnn
         z+Rwg5B5m390JADA/tH9Kd5hrRor7L7xc2HarYOOY1eeh0X5ooFq6gop9u+FKPEH68sX
         PSmyWhcvNVI+KSAsfLsiJwAoZy4hoOLroAWm7/PcoZRZ5RRn7c5QPkSzY4al45bC9y1m
         rxt4J+H9awRoebh/t2rs9NdCgcDLPVKf5pbTahtHh4OEILiQvhD1Izdrf/nBW5LrZ6Hr
         cCTqNUjkmGwlDPIsIOZy6KsBLIleiDr0kGVZMU24uQyWpnq1xNF84jdZo+Qvww3Nq5FM
         6uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BAxCptwO7y2xVPn5yxfUXuZaiLDAgG5VdQuxNau2t/A=;
        b=IR32ENjnRbfYyVv0VWMmI5aiA2h0Taj6AY/nPhVkS9JNXAfhkv24KiGnZliphrpjqK
         kKcfto2nx4AAAq8N1yaWkUBysypOlLM5OvCiOEKhCAP+xMOw8wyf2sX54G6T/FjGDgrz
         1u9vi4k9QQvqEAYt3K5caO92v87MUqvKY9LlI3LifFIDTeqBrpooeF8wtUzHm+HF6wUN
         8h6X4Eha+su51n1HiRjEokrNGLl3e/3mzaz7pi99JFyBNOUQ9oWDuXjk0o7WPRbPUGPo
         BvgqfuP0Vt+uSOjSHcanITB/Sb+jKsiWrrqD7X8kyzrQxIJtFdiaVdgUhuMZSEDRQMb0
         uWWw==
X-Gm-Message-State: AOAM531v67liu4LH8QuLJICfgmcA9mcAhMIv55hpXpi9XkoQQEhOzSOV
        /DqxTzDw2FgbmmDeFq9sHCSwP2H0TfJwkv4=
X-Google-Smtp-Source: ABdhPJz4snZQEDVmZXj6RODHXR7rp3pbTlyyKgm6WM3ongSTDnEvvxBi0qJKrzgY36D1YxzBeGXt+A93QwpkuHs=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a17:902:b58f:b0:15e:b2f4:b75 with SMTP
 id a15-20020a170902b58f00b0015eb2f40b75mr37115965pls.25.1653552965291; Thu,
 26 May 2022 01:16:05 -0700 (PDT)
Date:   Thu, 26 May 2022 01:15:43 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-5-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 4/9] Revert "driver core: Set default
 deferred_probe_timeout back to 0."
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.

Let's take another shot at getting deferred_probe_timeout=10 to work.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..f963d9010d7f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,7 +256,12 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+int driver_deferred_probe_timeout = 10;
+#else
 int driver_deferred_probe_timeout;
+#endif
+
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
 static int __init deferred_probe_timeout_setup(char *str)
-- 
2.36.1.124.g0e6072fb45-goog

