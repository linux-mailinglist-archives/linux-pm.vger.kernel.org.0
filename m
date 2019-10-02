Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC9C90F7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfJBShx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:37:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJBShw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:37:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so137329plr.8
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNovxVKu/GraUWwguMxsijijnyMSGCiZNixAkZg3ZPc=;
        b=gbpUqrW6UQVF5gtd6cmjBJQ/FJPxYDkUfiISNx0FtcRl5Wm3TVOxGXqq9/twCLZvHN
         uqzDxdigX8Lk5q1LOKDLSSgATs1g05cM3ScdGLjhCE2OoB3kfisa4qK8TcR66oInxHmr
         iolsTU9QFBNPE5rkDXTFwVAOoFvcsb5g0DF3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNovxVKu/GraUWwguMxsijijnyMSGCiZNixAkZg3ZPc=;
        b=CLc5OpIP+K2+a0CXoHw3/UAK+Cgwhs2Zjh2wqBMwlL/KSzRMmSCAbjqOxZuRCfZlRs
         1fzdi9aYpYbZyH6g7zq5E9rNdaTJk71B7lRAAA/Bwxg0aT0kjJiEBQzGQxI7ffTlIZM+
         nRIazVq1fzVs/OCFdrCanjQUyXKBMS/4g7DZwoXN1Z5is/iU0vpFfLxoVPe/Lpfy5HAU
         j9cVJvRSkAfbWjNEyqz5Mk4jB4XZrBVCOxMXPunvSElIyH0KErBXbQqa2cHpceQBnZ+Y
         z8eNov6TLsaTipynqcsuulz2sGYHG0I8HEkOeCoC/YOv+3vDuMfXklqy5HDQFrf0CB1C
         AN2A==
X-Gm-Message-State: APjAAAVGRQ5hHpuz9y2E0V4Nf2F+XcdtLcsqYW7JmO5cTYppcPPVH9Ic
        xmiJ/d3aevs5zd1jilJkCQ21QQ==
X-Google-Smtp-Source: APXvYqw5LSPiUMD/zYmaDgpBkxUHpC6NFYfd0t/r6Kfw+63kgfrNAEYNCRQwWP9esOAKitLCeSBsrQ==
X-Received: by 2002:a17:902:bb87:: with SMTP id m7mr5174146pls.179.1570041471486;
        Wed, 02 Oct 2019 11:37:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w6sm192916pfj.17.2019.10.02.11.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:37:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PM / Domains: Add trace event for genpd_set_performance_state
Date:   Wed,  2 Oct 2019 11:37:43 -0700
Message-Id: <20191002113736.v2.2.I366ab5442f66ddff643948c6923cc6916ddfd840@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191002113736.v2.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
References: <20191002113736.v2.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tracking the performance state can be useful for
debugging/understanding power domain behavior.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- split original patch in two, one for genpd_set_performance_state
  one for genpd_power_on/off
- updated commit message (original subject was "PM / Domains: Add
  tracepoints")

 drivers/base/power/domain.c  |  3 +++
 include/trace/events/power.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 88eff9c4e79a..1130b984808d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -332,6 +332,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 		goto err;
 
 	genpd->performance_state = state;
+
+	trace_genpd_set_performance_state(genpd);
+
 	return 0;
 
 err:
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index d92cb53c20ed..2c2c7bb5bef0 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -559,6 +559,24 @@ DEFINE_EVENT(genpd_power_on_off, genpd_power_off,
 
 	TP_ARGS(genpd)
 );
+
+TRACE_EVENT(genpd_set_performance_state,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd),
+
+	TP_STRUCT__entry(
+		__string(name, genpd->name)
+		__field(unsigned int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, genpd->name);
+		__entry->state = genpd->performance_state;
+	),
+
+	TP_printk("name=%s state=%u", __get_str(name), __entry->state)
+);
 #endif /* CONFIG_PM_GENERIC_DOMAINS */
 #endif /* _TRACE_POWER_H */
 
-- 
2.23.0.444.g18eeb5a265-goog

