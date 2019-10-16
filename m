Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A087ED948B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfJPO6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:58:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37453 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfJPO6Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:58:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191016145815euoutp02dc85c3ac6e01de13d58abd24201c973e~OKIqWI7ol0995909959euoutp02e
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 14:58:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191016145815euoutp02dc85c3ac6e01de13d58abd24201c973e~OKIqWI7ol0995909959euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571237895;
        bh=mvXJGAa/sROCmXNX3W9XG8ie5vO3G5aWnbMGSADFAsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUcl/P7GIe7rUPGZZ5v0Xtd0URpqKNmk6uskkuhkJE6xfdeGtW2j4W0MxTTgsDBai
         WG2uLzE9ql+3QgMxLgr+jn4LuooYpHIr7tdO9iBpglX/zMQ6nK2H36EbLBUSELNYZn
         nlTLzDQVMlX6UtNDwXtfRmnY7B3GVPHJLio23pUM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191016145815eucas1p190572899b52b0d1ccc2c3782c2642daf~OKIp50kFn2429324293eucas1p1U;
        Wed, 16 Oct 2019 14:58:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.30.04374.70037AD5; Wed, 16
        Oct 2019 15:58:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191016145814eucas1p10d50d438abb850fd82f622122b223196~OKIprQsxC2429324293eucas1p1T;
        Wed, 16 Oct 2019 14:58:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191016145814eusmtrp20428acf3acabc120ce9c09c8ea5e0f80~OKIpqmLvx2387823878eusmtrp2i;
        Wed, 16 Oct 2019 14:58:14 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-58-5da730078f5a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.0E.04166.60037AD5; Wed, 16
        Oct 2019 15:58:14 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191016145814eusmtip2408da62f7fa498f4db3ac74bb309c465~OKIpFyC640671206712eusmtip2i;
        Wed, 16 Oct 2019 14:58:14 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, roger.lu@mediatek.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 4/4] ARM: EXYNOS: Enable exynos-asv driver for
 ARCH_EXYNOS
Date:   Wed, 16 Oct 2019 16:57:56 +0200
Message-Id: <20191016145756.16004-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016145756.16004-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfyyUcRzue++9P1zOXkf5TmK7pcWWH9PqbazF+uP+I/2hlOUtbwjH7kVk
        li3lVzjK3MhOKHUYdwwnP8JxWc3NmGztlsWsCY0LE0f341X/Pc/zeZ49n332IRBRFepOJErT
        GZmUThZjAn73+M7kWTygOSZgynyUUivaUUqpm0Qpg6EDpzQLsyhlKtUBSmEY5FFtOiNOPRnQ
        4dT0ghqjRlcKUGp/Vs2nOufHscuOEo2qCJN0Nj2S5E8M8SVlXSogMWk8I9BoQUgck5yYycj8
        L8UKEuoWzHjaOj+rzryD5oFCfjFwICB5Dm61llmwgBCRbwHsN+p4dvIbwOk/e7idmACsm1Eg
        h5E2+To3aAZQ2zCI/ovUVm1gVhdGBsLSsTJQDAjClQyGGxPHrR6ErODBH7XFuNXjQobD+c1d
        G+aT3nBztcSGhRb/ytgQbm/zgi0dH2zNDmQIVLxste0HyWocqivNwG66AvOblrmAC1zWd3HY
        Ax5olVzgMYDP3n/F7UQO4Dd9PZcOhqP6KdS6KkL6wPY+f7scCjuNHxGrDEknOLfqbJURC6zs
        ruZkISx8KrK7T8FdVTXPjt1hyeIBd2AJ7FnSctcqB7Bxex+TA6+a/2X1AKiAG5PBpsQzbJCU
        eeDH0ilshjTe725qigZYnuXTvn6zFwzu3RkBJAHEjkI5aI4RoXQmm50yAiCBiF2FyvymGJEw
        js5+yMhSb8sykhl2BJwg+GI3Yc6R+ZsiMp5OZ5IYJo2RHU55hIN7HjgWtnXjfOFar9OWR27p
        vZ9RvhdK3rUpjVLlm0g6J7zi+eLFgsr48uirt2hD0peWuTNrec7Xx04LW7HIqOCaJdO174NF
        3lOfPavq7ndMjuZtZLU2nBzQvuhObMwFYU5Bm3ozHRrQ/zo21tyzFjBT8KpP3T4RsU2Otg8P
        ExO/mn3WxXw2gQ70RWQs/Re5LxZfKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7psBstjDXYvMrfYOGM9q8X8I+dY
        Lc6f38BusenxNVaLz71HGC1mnN/HZLH2yF12i9a9R9gtLj/eyGZx+E07q8W/axtZLDY/OMbm
        wOOxaVUnm8fmJfUeLSf3s3j0bVnF6PF5k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextzHf9kLPrJUzP37k7WBsYOli5GTQ0LARGLthI/s
        XYxcHEICSxklJuz4ytzFyAGUkJKY36IEUSMs8edaFxtEzSdGidYf5xlBEmwChhK9R/sYQepF
        BOwltn8TAalhFpjNJHHmVy8rSI2wgK/Eg+a9YMtYBFQlvr7tZgexeQWsJd4c3c8OsUBeYvWG
        A8wgNqeAjcSMOWuYQGwhoJrTl1awTmDkW8DIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
        xLcd+7l5B+OljcGHGAU4GJV4eCcwLo8VYk0sK67MPcQowcGsJMI7v2VJrBBvSmJlVWpRfnxR
        aU5q8SFGU6CjJjJLiSbnA+MvryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFM
        HxMHp1QDY6rwdfG7nUfCH60QuPF78YMdJXtsiyp2X5dLzJo783p1edvsOU8q2wTmOPL8b4t4
        zMj7dWqfx7tT9o9P7O9a8eh27aOpYl8TLHbJGvTsCipiVVpbG3mVf/J1Qamgq083Nm11bPF1
        qWtV+MN3+dau6pePLPR2i4RPm5hi15zf+bAhreKb2rdjc5VYijMSDbWYi4oTAebe24yHAgAA
X-CMS-MailID: 20191016145814eucas1p10d50d438abb850fd82f622122b223196
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191016145814eucas1p10d50d438abb850fd82f622122b223196
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191016145814eucas1p10d50d438abb850fd82f622122b223196
References: <20191016145756.16004-1-s.nawrocki@samsung.com>
        <CGME20191016145814eucas1p10d50d438abb850fd82f622122b223196@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable exynos-asv driver for Exynos 32-bit SoCs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - none

 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 9dab1f50a02f..4ef56571145b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_ASV
 	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
--
2.17.1

