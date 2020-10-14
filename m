Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB628DC4B
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgJNJEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgJNJEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 05:04:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE5C041E6E
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p11so1108733pld.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whzGQ73mzzjs9c9ed5e3sLfewX+szU+TbiYBfpWMSEo=;
        b=zZAvvpghxLBCHne8Id5hFwl6kmydFgjV/XPVicNfeIwAk8pPo/4O6jwdNRcY3NQVmf
         p1/QsSzjHerEz8nRvjbkIXSUe3NTkZr9POQVoiQ0dS+v201/yN/e4510l0TVoxs5a/OU
         KAOUyh73MiUfz+E6dSTUa0uzzLn3OTlW5N4qG6Azc4JSVuJs5tNc/oi3rCD8gXg4SzMd
         2vwSHoK3fJxsoNgq+JOIzv182as8mPJFuEnjl4/v/16x0hWeNQeHP1oifOkt4ifZqquX
         bRgs3uBbp9XntvL0kc96v75/3btMtlcQBddscOuMwZsMYKzFwBVJlvvFfkDvRETlo9BN
         TPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whzGQ73mzzjs9c9ed5e3sLfewX+szU+TbiYBfpWMSEo=;
        b=nDOUsSCGudUpulkw5+DLYRtRpUnU2O8+jMakNz8JOp03nv4vj9295+oD853Iil2fRV
         ZcJqWAaLYEMclwtMG0xJc8I3IDodP3LNxEdDTRoICgJUkCiduDZP5PId0T873TZoQX7B
         TlI2AHD7tTI5DHH59lVu3FM7OLE226cMo7oixaAtT0wxHOm9zfGPGvog0QdT3F+Bko5Z
         80dY8Ew32oWI1y+D/XHX7IwS6+eVlhi1CaE7b8OfIIrqbQjq9m/UprjDLqzSuFKHt3kM
         G6w1uK9hXm/hHNgy9Z47DO2jR+j6/eCFqSRZOyBOg2ROP/roRoBH3nX7ThwXx6vgrU7T
         fx/g==
X-Gm-Message-State: AOAM531pE4Hhe353TGPENywDVucKhqIK47IhBJItPuuGr9jOV42Uk0S4
        d6W66obj7F7IUzBMQZHsfxIW1Q==
X-Google-Smtp-Source: ABdhPJzW0xxJSqTbXlczLEjBDwdx6ffSNItDE7RJyY7WO2f7eMwMC3fFvpoE6xE7G60GsV+9EATP+w==
X-Received: by 2002:a17:90a:c248:: with SMTP id d8mr1610634pjx.193.1602649592092;
        Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id d26sm1366862pfo.82.2020.10.13.21.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:26:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Don't always remove static OPPs in _of_add_opp_table_v1()
Date:   Wed, 14 Oct 2020 09:56:28 +0530
Message-Id: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch missed returning 0 early in case of success and hence the
static OPPs got removed by mistake. Fix it.

Fixes: 90d46d71cce2 ("opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()")
Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 874b58756220..9faeb83e4b32 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -944,6 +944,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		nr -= 2;
 	}
 
+	return 0;
+
 remove_static_opp:
 	_opp_remove_all_static(opp_table);
 
-- 
2.25.0.rc1.19.g042ed3e048af

