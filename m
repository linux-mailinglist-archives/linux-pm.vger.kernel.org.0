Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DB50395
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFXHea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:34:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39715 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfFXHea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 03:34:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190624073427epoutp0380c0fe702b8101db63fb7591e72993b8~rEioJsos30974209742epoutp03h
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 07:34:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190624073427epoutp0380c0fe702b8101db63fb7591e72993b8~rEioJsos30974209742epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561361667;
        bh=hemYUVKcGXHPpvU5K4qf2wgUfLKg+lVK/vDiZZht2ds=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=pLwFYyx4jUUb8aYl+FA24QdgY0V18OxM0adal6zmZfoCVnxW4fizA8dPfzRwcYCHG
         eUDcibnTDGpNGRe7cJItEJzO4cy37rmR7kTV697srFC8Dc34lnYHchvROI+gO2QjGa
         9j9GqjBvqVTmFpJqp2zbuVVmGYIGKMWtdp6cAvsw=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190624073424epcas1p3745daaf40398429cc4bdf8bf92d87455~rEilAkNHp2996729967epcas1p3m;
        Mon, 24 Jun 2019 07:34:24 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-8c-5d107cf69a41
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.0A.04257.6FC701D5; Mon, 24 Jun 2019 16:34:15 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "digetx@gmail.com" <digetx@gmail.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
Date:   Mon, 24 Jun 2019 16:34:14 +0900
X-CMS-MailID: 20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX/d7jUCsQftSJovrX56zWqz++JjR
        omXWIhaLy7vmsFl87j3CaNH5ZRabxc9d81gc2D12zrrL7tHb/I7No2/LKkaPz5vkAliism0y
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5QUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRntJzq
        Zi04yF2xccN8pgbGU5xdjJwcEgImErNfnGbsYuTiEBLYwShx+dUSli5GDg5eAUGJvzuEQWqE
        BZwkmn9cZAOxhQSUJBpu7mOGiOtLdDzYxghiswnoSmzdcJcFxBYR0JTYuKKXBWQms8BpJonN
        a3+yQSzjlZjR/pQFwpaW2L58KyPILk4BP4k1/3kgwqISN1e/ZYex3x+bzwhhi0i03jvLDGEL
        Sjz4uZsRZsyMKf+hRlZLXJu+mB1kr4RAC6NE7+opUEX6EmfmngS7gVfAV2L5l/OsIDaLgKrE
        pI4nUENdJFbfPQ1WwywgL7H97RxmkNuYgZ5Zv0sfokRRYufvuYwQJXwS7772sMK8tWPeEyYI
        W03i0O4lUPfLSJyevhBqvIfEixP7WCFhOJVR4tIe+QmMCrMQIT0LyeJZCIsXMDKvYhRLLSjO
        TU8tNiwwQY7cTYzgxKhlsYNxzzmfQ4wCHIxKPLwCG/hjhVgTy4orcw8xSnAwK4nwLk0UiBXi
        TUmsrEotyo8vKs1JLT7EaAr0/0RmKdHkfGDSziuJNzQ1MjY2tjAxNDM1NFQS543nvhkjJJCe
        WJKanZpakFoE08fEwSnVwMg9qeBd6cwT1wPKzPILH169UrZ+Ev/TEwz3tyv+2r+3S2z117b8
        feeyRBncSg4esZG1v6O2tmX6Ezv97YmuST8EFH64RZQnmGn+OiwRyptR4cd7Md/giG2nzprp
        va8e9wcVCn2TfPj0gP6RVSW9H77zVixLY8hZFtv0qPmB1/mLlZPcHdi+piuxFGckGmoxFxUn
        AgDqdthpogMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f
References: <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
        <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p8>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> 
>A question:
> 
>Does this driver support Tegra20 as well?
>I'm asking this because ARCH_TEGRA includes ARCH_TEGRA_2x_SOC
>according to /drivers/soc/tegra/Kconfig.
> 

For this matter, how about updating your 13/16 patch as follows?

---
 drivers/devfreq/Kconfig         | 4 ++--
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 7dd46d44579d..78c4b436aad8 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,8 +93,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_TEGRA_DEVFREQ
-	tristate "Tegra DEVFREQ Driver"
-	depends on ARCH_TEGRA_124_SOC
+	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
+	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 5cddf2199c4e..a6ba75f4106d 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -726,6 +726,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra30-actmon" },
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.17.1

