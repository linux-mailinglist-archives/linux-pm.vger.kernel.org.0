Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D859E255448
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgH1GIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgH1GIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:08:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31500C06121B
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q3so1424800pls.11
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufKBHISWCWvOqS3pagmUuZtAX3KSE6Mpoh1OD1fJ0nE=;
        b=y0gXzthAdWxwTpuW9Oxu/1ExcjTSHnwN3OeQ01rK2TQQSHvAVnRS2HCUZZ/sAuJXhI
         kaXZ0UHK1ULuqWEACaMuE0zlCIEMN6RY3c1VjXWLNomn2lFXNoVdw7NGiHvpR3GAd6wp
         uXR63D+BuKNT6qDtbaD9I9wdebXGIjbYqPqoyYpXX1XDsnMvfag98hH429aGqlYT/nsU
         7HNPurBFa/hE1eJNYduC9TXuquAgsXTI4tSIIKfkJ3Pz2043EModpk9VNJawn8/pC94x
         d7EcnD7omCPhSw00DvrUuXGybqDgwsGYBPW0NGf8yrf8U9vdseI0gU7QDXFjnl2/5j5l
         BzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufKBHISWCWvOqS3pagmUuZtAX3KSE6Mpoh1OD1fJ0nE=;
        b=eWlCDcFz6eoCfMV9FRu40tNM+z/jeQp1Z1PJRFlAzSkbBNCXabKoRDUpxPH0lLw+vC
         YaUCK5PHkbByzWaUS2AChv4MM8hOPvijbiq0xfpYtxdooEjV8+As0wL1fhhIbm8OGA5e
         sVhghbxbkVQZt/NLMvc+Yv/pGJJDLH9zlweHMbwJQiGgV25SNH48D8oKJM3GvnLTuEED
         MVfH+Q3ydpt8A3HOv1y2SVWT4Tcqy6EXO/YrGTQKVQ1Fm3/1Rl5sZIFX/a2yqyvHABUk
         rhY57nbkE78NTvUa/dyzgisHuUf0/qju6+tu3JDk/odUji0nhkEOq5DHlY6M2ZLieKXE
         JKuA==
X-Gm-Message-State: AOAM533NrTlrxr3OyASNAwlJCtbw+Wyc7RQPxZBIMUD0sxWYC+iC/oQ+
        uy7bijPYsUdpXat/DxtfobK4jA==
X-Google-Smtp-Source: ABdhPJy+5cVwOjOgnDKJ3qyp2HX8wvR/pXAmhS6KoRfL1isEqkXJJ3c6TmzNNqgEnIdAsynxvzWcrw==
X-Received: by 2002:a17:90a:8c8f:: with SMTP id b15mr306637pjo.84.1598594918497;
        Thu, 27 Aug 2020 23:08:38 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id i14sm200061pfu.50.2020.08.27.23.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/8] qcom-geni-se: remove has_opp_table
Date:   Fri, 28 Aug 2020 11:37:53 +0530
Message-Id: <7e28e6f93f463ffbe91b2a5c18b82e7123500f44.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

has_opp_table isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2: No changes.
---
 include/linux/qcom-geni-se.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 8f385fbe5a0e..02d1417c8ecf 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -48,7 +48,6 @@ struct geni_icc_path {
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
  * @opp_table:		Pointer to the OPP table
- * @has_opp_table:	Specifies if the SE has an OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -59,7 +58,6 @@ struct geni_se {
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
 	struct opp_table *opp_table;
-	bool has_opp_table;
 };
 
 /* Common SE registers */
-- 
2.25.0.rc1.19.g042ed3e048af

