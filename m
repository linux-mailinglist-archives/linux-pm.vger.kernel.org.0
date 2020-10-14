Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FD28DBC9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 10:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJNIjl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgJNIji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 04:39:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157CC041E63
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:12:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so1216826pfj.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5AM3x/y1nzauZWL5St/sb2x4lNQI0pK6A00PCLZ7oA0=;
        b=hfFkYs+0aEJl3WvXklRoLUZJ5lyk9bQQblQeuvJ5bi+EjGT9siTZb8pzza/CVloe8/
         LuCdcztOY6+/FAt40Wjqf0Lqc1I/8BWtmP1PncojwonXMexjCj+ugHYr8fipiaOKJutR
         zDG1SKShnIGWu8IfG0vFvhZXHvr7AOpNijYnXV52ZzvccIi3eDxoYCofVUyEbEjsNQZi
         tT/ioBzMw7gA5b0TWYyzDeUupyuAv24OjCRBn2t53Zb697HkyuP2NvTI9i7J45a7QiA6
         XGY/RNG2LlW4QnVQfAq8tfr+2GF0P2T0/qJ+OKM0Bi3ZFSKkigZh7t7Z1Sdlanv9ao+9
         VzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5AM3x/y1nzauZWL5St/sb2x4lNQI0pK6A00PCLZ7oA0=;
        b=oE0rp32HuU3qOkk+BNXxE4TDfIRh7gBkyFfuQcaYaIrqIjjI+3criUaO8Mf2gQyA6e
         HsTwWg7YsDYtMUXIqtT086gc84RoKBaHx3Ir+WSwlR3+Py91MiTPOKzN0BYAMxhfj6GC
         MUFNO1yCkD0X90enC6KfG0LuNCK+71MpYgfKwEg3OkpL5yGpDU/GphFG+qGbrRtQ95yv
         pt/MKz0I3uDPzM4zOYEOf5OEyr9f9aFXDBKDEqACBDy/Y0cKoDV4qujJBHM4KD5AfUUE
         vBigIiw31hGlfDIBieZwoH9Dsiye+zJlywjXrY3QunuSaERyvDmnxnjcgm+Iy6UIWnFm
         kXkQ==
X-Gm-Message-State: AOAM533cBmaQszKNmS4iue4+kFhDLDsjOxUmsWDd9+YSis+H2BhvqGpC
        2WlsJ6SBivSTLOTAtM++KyKMew==
X-Google-Smtp-Source: ABdhPJy19PHrHP+yvNrkIhSvDNbu1NJBddZYB27hbxXiD6mJPUfEEludHfeHMY/qhjPpLd3EGUEWFQ==
X-Received: by 2002:a63:c806:: with SMTP id z6mr2264251pgg.430.1602648763165;
        Tue, 13 Oct 2020 21:12:43 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n3sm1340919pgf.11.2020.10.13.21.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:12:41 -0700 (PDT)
Date:   Wed, 14 Oct 2020 09:42:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: cpufreq regression on imx6q sabresd
Message-ID: <20201014041239.krv32ryb7t6ta6k6@vireshk-i7>
References: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201013092746.ancm24mp7tu4wjve@vireshk-i7>
 <AM6PR04MB49666E48C1761543CE86B07280040@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49666E48C1761543CE86B07280040@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-10-20, 11:58, Aisheng Dong wrote:
> I think it's caused by the patch below:
> 90d46d71cce2 opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
> 
> My kernel is next-20201012.
> $ git log --no-merges --oneline -n10 drivers/opp/
> a5663c9b1e31 opp: Allow opp-level to be set to 0
> cb60e9602cce opp: Prevent memory leak in dev_pm_opp_attach_genpd()
> 0ff25c99042a opp: Allow opp-supported-hw to contain multiple versions
> 2c59138c22f1 opp: Set required OPPs in reverse order when scaling down
> 60cdeae0d627 opp: Reduce code duplication in _set_required_opps()
> 475ac8ead803 opp: Drop unnecessary check from dev_pm_opp_attach_genpd()
> 90d46d71cce2 opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
> 922ff0759a16 opp: Don't drop reference for an OPP table that was never parsed
> dd461cd9183f opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
> 8aaf6264fc7f opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
> 
> If back to the version earlier than that commit, the issue was gone.
> e.g.
> git checkout 922ff0759a16 drivers/opp/
> NOTE: no dt changes. Only opp changes.
> 
> As I'm busy with some other urgent things, so still did not spend too much time to dig
> Into the code to see why the issue happened.
> I may find some time to look into it later if no one else look at it.

This should fix it.

Subject: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()

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
viresh
