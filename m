Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857A7C80A8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjJMIs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 04:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJMIsz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 04:48:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA98BF
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c8a1541232so16350055ad.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186933; x=1697791733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sgnTvvfVpiAPPJ8fiCTAGKK94xzxBt3csYQrYp95xs=;
        b=R2ylfw32owgpzXLev8WI4JbQpc3yML7eAnkdXT5dDeEAebPG0A/7OBW7J/dELPNu2w
         mJPUnQnN9+p6WFmju7Ewbaadn0kh1hsG+x9k/4dhf5zHJjQhJ+Qay8p8av5bpGpdM8Cx
         vM649EOJpmNOx3KT5sN1lBRqEFJSGLoLmBANaJfhJMjyg1CPMWB2U8Epyl4gzPJjRpNB
         PsTNY9980KC3u+d2e2ZSni/xHMJ1zJUrObOExCefmgzo38lj8R3CcK9OzW81CBRguljO
         dv5RQVWjKrKXc+DgATL9uDr0REFwOLN9GuRkI/RmNGaEgYZgv+rjTI06EtTj5Fxg62ta
         Ob8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186933; x=1697791733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sgnTvvfVpiAPPJ8fiCTAGKK94xzxBt3csYQrYp95xs=;
        b=JCQlWJHjpRlNfuKgVqgB2G4F85ctKHXA4LL+6ifdnQPaUd55ex+KTtks8x1eMkk6lH
         2WzFjDYG7qbJbXhQ+sFfKTVIL93aOlYUFgjxNS22XP48K4QoGsb24miBiPWYrrv2zorz
         Wh/PW/LevTvBeJGgs6ONa0GdSGa8g1lOdlSbqIZbKuhQY2ixIw69gI81AzHAVw4wOGoZ
         2e68aelqKChJ/Au1JytInOOO8EAMi2n8PW5I1Nq9xbkI6JnURSqToFP0dSvO+JJLroWG
         CliA7gvoKDJBEU2phQtCJvoPFi8bwi6y2LJuLadVQWzi/u0r9Od6unw8vB1NRUJMbPVn
         mTxg==
X-Gm-Message-State: AOJu0YxJoWRQAmxmaipR67ZcqZGzYzQtUnPUyecoONjfCJWyi4KdVd1k
        n2tinJSJ7VOQfydEtmPcpSxLlg==
X-Google-Smtp-Source: AGHT+IF2PPXyHg4vc+2knzO5ZIY73/rxsaTy2n8oV7cgwV6Vqk1cB/jpSupaaNzdiEAXhUNvDwonwQ==
X-Received: by 2002:a17:902:e84d:b0:1c5:ec97:1718 with SMTP id t13-20020a170902e84d00b001c5ec971718mr30704438plg.6.1697186932843;
        Fri, 13 Oct 2023 01:48:52 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902a60900b001c06dcd453csm3323741plq.236.2023.10.13.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] OPP: Fix formatting of if/else block
Date:   Fri, 13 Oct 2023 14:18:37 +0530
Message-Id: <58b984a1144b0db1dd6bdbcbbfbac69326f02dd1.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add {} to both if else blocks or none.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ae5c405bbf9a..85e2af3d6a49 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -208,9 +208,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		mutex_lock(&opp_table_lock);
 		list_add(&opp_table->lazy, &lazy_opp_tables);
 		mutex_unlock(&opp_table_lock);
-	}
-	else
+	} else {
 		_update_set_required_opps(opp_table);
+	}
 
 	goto put_np;
 
-- 
2.31.1.272.g89b43f80a514

