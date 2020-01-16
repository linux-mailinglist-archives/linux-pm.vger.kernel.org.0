Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5613DDBB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAPOmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 09:42:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58990 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPOmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 09:42:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116144243euoutp027043974f79128baca227cce76b5ea498~qZRWsiMiC2958429584euoutp02j
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:42:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116144243euoutp027043974f79128baca227cce76b5ea498~qZRWsiMiC2958429584euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579185763;
        bh=SFlSY5enk2NR7TvDU2U02lhcxcge/KC7e93n46VsVd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB48G8WNjCB4BoOHcDMmC7pvEFh8u4IJnDURTJh5q9MbchEPE8EIHwp0i8Skahtp7
         JUUebEfbWkIyZudIanxh2Tf2drba6sOIScdbeBEdyKHmcjvZfHWUCMiQWDxVLv6SHj
         e8UyoomIBJuxfjTMdFhU8FvkX1w11MSTYbqruLi8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116144242eucas1p1d729d2f8bef381105f8bb0f77bcfdf0c~qZRWRkcSD1363913639eucas1p1V;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B7.F2.60679.266702E5; Thu, 16
        Jan 2020 14:42:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7~qZRV7yP4t1420514205eucas1p2f;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116144242eusmtrp1ffba0c7783bbf33374fa349423bef34e~qZRV3QOBf0584505845eusmtrp1X;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-43-5e20766272a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.64.08375.266702E5; Thu, 16
        Jan 2020 14:42:42 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144241eusmtip27154e268eeeee0ec6f2693221b6a5bc9~qZRVWCd1a2133821338eusmtip2j;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        georgi.djakov@linaro.org, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, krzk@kernel.org
Subject: [PATCH v4 2/3] interconnect: Relax requirement in
 of_icc_get_from_provider()
Date:   Thu, 16 Jan 2020 15:42:01 +0100
Message-Id: <20200116144202.12116-3-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116144202.12116-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87pJZQpxBrNnqVrcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBLFZZOSmpNZllqkb5fAlbH783Tmgk8cFe2fFjA1MO5j72Lk5JAQMJF4+GEGWxcj
        F4eQwApGiW9Pe5khnC+MEgfudDNCOJ8ZJe4sO84C07L78XKoluWMEkf//WCCa1nx6gDYYDYB
        R4lJUx+A2SIC8RIft/1jASliFtjJKHHk7x8mkISwQLhE+7HVYDaLgKrEzZk72UBsXgFLidbp
        D6AulJdYveEA0FEcHJwCVhKfH6tClAhKnJz5BOwiZqCS5q2zwe6WEFjGLjHx/hVGiF4Xic2/
        /0KdLSzx6vgWqJkyEqcn90DFiyWe7rzPCtHcwCixadkRZoiEtcSdc7/YQBYzC2hKrN+lDxF2
        lDh05DILSFhCgE/ixltBiBv4JCZtm84MEeaV6GgTgjCVJHbN5INolJBoWn0NaraHxN9Zj9kn
        MCrOQvLMLCTPzEJYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg0jn97/iXHYy7
        /iQdYhTgYFTi4Z0RpBAnxJpYVlyZe4hRgoNZSYT35AzZOCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYlxyedSO8SuiE1o9FMV/Ee78yG9dOt9P/z+Ag
        8jHt51Pnls5TX3nr74h92HTPlHFhBl9jw8IpDuIn0g6aNvR81TH9lGXp8OzxHf/tHXahM75V
        lZ1/9bMwcqKtetK6PUJyvucMv0ROXrpPjifJc0FLwLmThq9Plxjf+77/5DGVlSGuc2oF03rP
        KLEUZyQaajEXFScCAIVa5SY2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7pJZQpxBp1vuC3uz2tltNg4Yz2r
        xfUvz1ktpu/dxGZx/vwGdovLu+awWXzuPcJoMeP8PiaLtUfusjtwemxa1cnmcefaHjaPvi2r
        GD0+b5ILYInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy9j9eTpzwSeOivZPC5gaGPexdzFyckgImEjsfrycrYuRi0NIYCmjxMs376ESEhIf199g
        hbCFJf5c64Iq+sQocW/PGkaQBJuAo8SkqQ/AGkQEEiVuPXrMDFLELLAfaNKdNjaQhLBAqMTi
        x1vAGlgEVCVuztwJFucVsJRonf4Aapu8xOoNB4CaOTg4BawkPj9WBQkLAZXc3tjNClEuKHFy
        5hMWkBJmAXWJ9fOEQMLMQJ3NW2czT2AUnIWkahZC1SwkVQsYmVcxiqSWFuem5xYb6hUn5haX
        5qXrJefnbmIExtK2Yz8372C8tDH4EKMAB6MSD++MIIU4IdbEsuLK3EOMEhzMSiK8J2fIxgnx
        piRWVqUW5ccXleakFh9iNAX6bCKzlGhyPjDO80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MEoW3vqtH7BeNaCGIY3z2HVGt7OWvw+lPmmT4jIwfbrBcM/LDQHb
        RWL+1T+1s3o4eUrhfcNfgbfV5T+ynd2tYO+mq3ZSnvlyzRIRFX/TdfZ5+4pX3hZpUxXlYteS
        CdYpnTBF7av0gy1LzU9smL+G89CxcmENpb1XvFvf9EzzeBNc7Pxi6hHZJiWW4oxEQy3mouJE
        AMh6sPi7AgAA
X-CMS-MailID: 20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7
References: <20200116144202.12116-1-a.swigon@samsung.com>
        <CGME20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch relaxes the condition in of_icc_get_from_provider() so that
it is no longer required to set '#interconnect-cells' to <1> in the DT,
and therefore it is not required to supply dummy node IDs in the
'interconnects' property when node IDs are dynamically generated rather
than hardcoded (statically allocated).

In case of the devfreq driver for exynos-bus, node IDs are dynamically
allocated and '#interconnect-cells' is always zero.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 0be1764d3528..5ea270af5ff4 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -335,7 +335,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-- 
2.17.1

