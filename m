Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86973887F5
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhESHID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 03:08:03 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:59623
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237212AbhESHID (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 May 2021 03:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDCkusT0Tm78Gw/rEYoiG6ABqAR9vYHAX5ww7vrcSXK7ZVw2elzryPQZp0kSsI98ED2dNvKBUNOrsZJbq4Z7h8WCU6GEchGPSCht7Bd0pqWqStzRjajIM/LzbgakbpG64AS4cqyqTMt0m1xJrO70CsidMpQ4+uunyyCpIYvWzRPRUt6S5L5rE26iwgZjwbJMSY9Mj7EDIysYD/oVVJNETvD9CxLuD4Q1/gbdhooqHY/1H4Ep+aHL8Ef5cjRv4/iYtaeMl2ylYBEymcx8fcMuMcmdvZD7Xn/l69TTyjVEsVrTzN5zJH8gi5sVZurR34RTemISOqDi8WXs7pusUluZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkR+7TAxuu8ffN6pAnysMAJnPU1k5M2DTEtGiUVILEc=;
 b=EM9jupM5zdTfXMhX4SGX/9801iXyUPgucyBMkipjOOqYA23H555xIsEy1U/ALvbenrr/8PFQVcEiyZuAz/74uoM1mCQCZhDr8Lvmp483iw+eE0bwQjk5iQ7dK/3NC6Xa7J6+lpTf/BkywK5nYJmUoAxRXEBuKc310BgwrOjmfagDvX9JuUVtt48EuU0OHlq2VeHox3sEXWhxZkybkT0aRkbEX6NG95WG0PWZVh9saMwN0zOte/DsiyLEYwx9FcyDwY8yBHuj6+eBLaExpgdH75/XxRvw5L+XH34hDQpMkw8bZ9k/To/BCmE5xKkzYCEK3y2RBFP8JxXecOWx2OiIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkR+7TAxuu8ffN6pAnysMAJnPU1k5M2DTEtGiUVILEc=;
 b=OK+cjAfRm3lwEkUSOL/+dS9VtLxkDLco3cx98uxzD0zmMXTTnk1wiDZF3BBH6m9uXPEkKFC8xLXpp2OREeMPkmzy7tgh2QThXX1WnI9pGsktqVfZTBpC4u7pe0Tsac+6HHBOLXHKnbKEATGY4iRhHi/xRKstc2U3MmsI9zkYRNU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:06:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:06:42 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/2] PM / devfreq: imx-bus: Remove imx_bus_get_dev_status
Date:   Wed, 19 May 2021 15:05:44 +0800
Message-Id: <20210519070545.1728197-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0056.apcprd02.prod.outlook.com (2603:1096:4:54::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 07:06:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14566ea2-4c74-406e-dc35-08d91a94a7a8
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB77333299649580D7B3F79C49802B9@AS8PR04MB7733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zyb7AaVd0icYT2J5viBmjMhS+15iaWYir6HYCFgusUiVSY683CYC2kwTT+hNlDhtMTa2tJpohx/k8RXGqGU886iGdWuOvG4G5OatbbyjLpcerZZlrKG0BhTqFHh/ZpPeZcNMdVnEuxB7zH68JhwDvMRQIlCFglyW7C14Rrt/C2pjuXtsYE2TAFppw1EKs1gkgQjDfXsJnp0Brm1C/g5wBP8mYyS4lMa65yNDEfPaaVuhGtgq5GQzTT4tPDpyKVME3YHC5wxU7gI5LTC4z0vQC66rX5DIO7IQpA/LO1Qb7k6RaWv3QXCulmKm6zfLQwde8rASUXW8xP5PSOsC2hsA2aqJsss7kqkSXcr7KNqolC1lAG1nd+5+wR/7qKygXlHaIhYYuNmVAnX3EzHOcGBSefsMrM8Z3kgIq+WXWsRYqE/P2gwRHQX1ocetka2RPOey4rlM7WVRHu1hccPL2IXWk5F1AI8yXlLxhNRYVXclBx9830TqXo+TEEvnaTcdqE/oiV2nn2Ztx+e0xcEs8CT6yraxZuUiSYR+Y7tpl+sSha09n2aLpR4xZJyk5aJuoHJbLTM97sTmdPDcDZqi36axpglV96ZQjh0zujqwxzOXYk1LoYSDHFPAv58TD657BrH9qracLQ7TKOMJU7tffew7NaqBvF+NI3iHpTa9PtDY3VGR+KszymX61t4RyvOIeJF3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(478600001)(26005)(2906002)(6512007)(36756003)(1076003)(83380400001)(316002)(66476007)(6506007)(52116002)(16526019)(8676002)(66556008)(66946007)(186003)(8936002)(6916009)(6666004)(6486002)(38350700002)(4326008)(5660300002)(2616005)(956004)(86362001)(38100700002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KB6bM9OYNzMNqRFa4efA1/eSkxAxBdepwmtTko7hBUT1cLqPsqFWHBYdUoqJ?=
 =?us-ascii?Q?1e3b7S548VONghLKPnbz3s5DIxFqb7KoW97LB3Y5PF8CaEXp00R93OK7fbnz?=
 =?us-ascii?Q?agZtbdWA/SGFcTEkVAGVSvpMnDo2QPxDwT68AFYeM1aB6G3H7l1lJfgXldnc?=
 =?us-ascii?Q?V19qF+1PnqZPRpPFtIR12Gi5VeakkiOfrNm5Njhh4yZt+Orp3VYGiBhjpdY7?=
 =?us-ascii?Q?aj0ef0JPWip4jPPcbwEcvKjW9MoNZxyrX0Ll+IoR2fzC2crOFpv6PLiqtesF?=
 =?us-ascii?Q?s0J0zNHt+3cJETzhwu23f73C9SL/nID0ISVRbJV4I95QKG+WX+1sps8vZvOE?=
 =?us-ascii?Q?dQtVDudkKUsDFo9/by4Hpn/TCcuSLMDkuvOxSH4EMAWz5DCLKhB/D444ISXq?=
 =?us-ascii?Q?US/piHmXNEGUcESPsVrnKZUlTCVnWvuP3RWKyhRaUwuCErbKw7JZ9yU3yk9p?=
 =?us-ascii?Q?6d8927V5wQUFfAvsv/xAcDdmnbGXhEuOKn8BTb+/vgE2yYMldC1sKmMLXQN9?=
 =?us-ascii?Q?IQcFWc4ysN0pUbeH87CB7OXdeLDpK0xsgtIUdMaIpqOP9T1UV+pdknsdNQ8M?=
 =?us-ascii?Q?cRLFcMML/8GcGOb8SaXq0xNq3H/FuwkXH3hPZGHmtNho13xcf7PGtm0KXNMr?=
 =?us-ascii?Q?XlzAcsDtfr+FUhUL0aEaCsd2nKIvnDsJtwNf+f6Jm756yxLbdYEZ7UXcBDCR?=
 =?us-ascii?Q?/ZA8gEqge3LvI9OrDYJ3xcKz66KfPQ3bZLH5bxKb5KtOzCzYWUazZ/qrmbI6?=
 =?us-ascii?Q?hjg9PIDjd9tppsth6bVACjIIS/52V99kG7+zAG/E6y14uGSwnzXJfKSTaaca?=
 =?us-ascii?Q?AFNSJDoLwd2xLHz/aZ+1y5Tioen7ReGTkhQdATjIqdo8mJQjM+7G+QV8DWQw?=
 =?us-ascii?Q?FRvsSl6tx+jucSy/wbeHt/utZF9A3HNXqJwQyk0qWaFtjdqao4H9hmxHYKzX?=
 =?us-ascii?Q?/zoVqAdke65qG/bPsGIXAT75H8qynOAMlDxVHNFGHS03QTKWMeAxIyPvVZRE?=
 =?us-ascii?Q?ZrQl3kDC5w40WNXudR5pcP0GMqIfkj6Ns/EnDOHBZsbu/g1329K7LJF30Dx6?=
 =?us-ascii?Q?SLDaxmA5Kk6IkVjeaG159VRtuVFCBT34rZTEDVOpr1jxp0wUrfU78aG+f53q?=
 =?us-ascii?Q?seDPyVSS6oBj4Oe09SBEhSEYq1yfbdMwDi6Gbfx2hsrEwfZKSpvkEI5izKQ+?=
 =?us-ascii?Q?/TWXXdRXEakChliAMBp92GYttriwyA3C3bdCOMQ0r+QWAaLRQiUkQVYnJIGg?=
 =?us-ascii?Q?GVA6OjnTNaraHBxFmc2WTkhouYJziA/Wb7BQSwt2qQyBnf+XZGaM+rWERY6y?=
 =?us-ascii?Q?z92hrFdfgf4VUWhOu7p5YQ+r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14566ea2-4c74-406e-dc35-08d91a94a7a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 07:06:42.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E/vgIqUQfAO+yYJczxLB8h67YELmHlZPCP/f5akE1qzvGXWveuVzLusOQLnsp35jwlX8DoYJeDEOW5KNMhzgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current driver actually does not support simple ondemand governor
as it's unable to provide device load information. So removing
the unnecessary callback to avoid confusing.
Right now the driver is using userspace governor by default.

polling_ms was also dropped as it's not needed for non-ondemand
governor.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/imx-bus.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 3fc3fd77492d..f3f6e25053ed 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -45,18 +45,6 @@ static int imx_bus_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-static int imx_bus_get_dev_status(struct device *dev,
-		struct devfreq_dev_status *stat)
-{
-	struct imx_bus *priv = dev_get_drvdata(dev);
-
-	stat->busy_time = 0;
-	stat->total_time = 0;
-	stat->current_frequency = clk_get_rate(priv->clk);
-
-	return 0;
-}
-
 static void imx_bus_exit(struct device *dev)
 {
 	struct imx_bus *priv = dev_get_drvdata(dev);
@@ -129,9 +117,7 @@ static int imx_bus_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->profile.polling_ms = 1000;
 	priv->profile.target = imx_bus_target;
-	priv->profile.get_dev_status = imx_bus_get_dev_status;
 	priv->profile.exit = imx_bus_exit;
 	priv->profile.get_cur_freq = imx_bus_get_cur_freq;
 	priv->profile.initial_freq = clk_get_rate(priv->clk);
-- 
2.25.1

