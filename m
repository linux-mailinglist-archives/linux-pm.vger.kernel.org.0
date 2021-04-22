Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E13368801
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhDVUbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 16:31:33 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:45286
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236949AbhDVUbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 16:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0MX5jK/fHpeb2scr/tNIMSpzhiEmKnJSkyM4UYFWpgubJdStRLMrhc1nxxxWGIy9H0RKgrC3VlBGqzeRct6C6rsZKOdIpBs9nPZnB1FN7UmHqK88KJTGZVdpYx+C7D4BqqX+gw3gikpB+mgZSGGUh/yYJT5jGvdfkKpXkyb5VcdcN6Wk8pOOGdO3SCXyl9vCVwNcedhgeWPDnpmFIbQHiOE4cG/yzMgF9Y9ZiuvenfNt+uAAdUpUeUxOUtcvqk1Ou3PXfHnP37JvZC0uknht20YiTlNSksyEhiC2o71q5Iw9JzL+1OW8kfmpkdw/hYs8QM9agWR9N5yRgW46RClaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0eGLgtHOWOLwonKJbCIviek7MitZN629X4vAgZocRM=;
 b=aqmyrp6BMzVlw1B8Uv9AQUN6Xq1aCreoO1uJrmxU4Fw1nLWoQYRsAjlpWvBWUMvJC7VNBHqtqfX+J5bsu+NBA0m+a5Ngz31PMk8hV85WKgXK0Xh5yB6Ob7Tlgufu/Ebytc2/NuwGo+xwGyHaDUduoQxPlQ4oXDqY/B5tfYeYo7EBKBRTpbo0jeIVnB0QQjXKk1hLd8HygOpAaJKnpoPpCOIOybv+A2ceS3RVmQqMqN3t52Xc+8NFvVvSlpyG12LSn97HXgiQxPji2qgxFFsXlYCpd8EkfOgITYykePkQBA5QKbX7U3LVrxrJxIKQKB0W7SXmWQJaB1ohkHoBLOpbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0eGLgtHOWOLwonKJbCIviek7MitZN629X4vAgZocRM=;
 b=GhgMX9yjpld8E3RzOgUD73UgTbtc5fzlZeicSQlsc/RIxgsILv3eagxPfRLkDGIu91HWZJPg0BbUPrsw4RuYOqArcvPvMbnCj2sNvknBx5oNNthCesvNeGXTEu7v9m8mBsLONJib3HpCQOAi+QxDdligW2My2ObD5uS04m7UYue7Njga4eCOWu4B+zlBNc8EZkjkDybkso6BL5pO5HVgKTuG3MpJ5lAA/yH8WruVcp6Y7XvPulSuLxkGaV5GIWeDwNb4+ADPsvaUpu86mjBGeTKbfirK/glUBQzeCIXgh1nPt/Hslx2rimXRS01wAqUEyx3RVBz+y3TFB7Or5V2wsA==
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 20:30:56 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::26) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:30:55 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 13:30:54 -0700
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:54 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <skomatineni@nvidia.com>,
        <mark.rutland@arm.com>, <lorenzo.pieralisi@arm.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>
CC:     <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH 2/4] cpuidle: menu: add idle_time to cpuidle_state
Date:   Thu, 22 Apr 2021 13:30:46 -0700
Message-ID: <1619123448-10138-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126974cf-5a15-410d-0358-08d905cd8811
X-MS-TrafficTypeDiagnostic: MWHPR12MB1951:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1951761BC46B42245041CAADC2469@MWHPR12MB1951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxezvf9IkdtfQCGnWT64TwHl0SUnYHgEf4puBLe3l6rzYxBJ6+O1YIkJEMYtb4MiWDYNijnHq8BW/cP8yTbtfH7sHBDslxW9NnnTpwZNOT/HBP6fyt1eRhbDcJB4YrOpbVcuXcxZe03975fQdj6K97MZHGexzRuW5OTx+yWPhFoKnGYiLDPY3A3Y5KmhPbJvQlofSF/5wM5rjqzgDTfZohQg+xOPJPVxa2h+gd2IvNVmpXWgeaXDdDiAVJzLqGs7oeQMuiKW7S94qk1O3W+SNHadxQNau0hri2q0nYGbqc9YsME/xNdpZB2kVoUNBbHGGwuvl+yUFqxgbYzZHDEHLxhfsg3bMdlyZ7dKJcP9WMRHn+V5trZ8rh6Hm/WQ9qKf3ZPALuAGtZkzSfRUsV5ut4GTLSn4DMQc6Wwbfm9s/etvGwNmWvXJANLhaglS0doC+2n/h9PAc1xXQH9iismSTmjl3RgZTvEHgIif1k4kuyI6AwLfkYiTmBynf9guM2IgJDZZCDSw1Dg+jxEVCAeDZ7rr66VBdSwXiOnzJ6+y94Hc7qD3Mq5XGZ+Mnon9nbkv1+fW8Z3VoSlvA8PFwe2QVETarwTmdDNblFK7KabmGy3OJ/ZE3wl10QhpI+rLPhQ8ln0dpWptOhQeOuZ2+aV7emj0leuXKwr0NOccmjeNqlQ=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(110136005)(54906003)(356005)(36756003)(8936002)(316002)(86362001)(7696005)(5660300002)(7636003)(82740400003)(6666004)(4326008)(426003)(8676002)(336012)(2906002)(7416002)(186003)(2616005)(26005)(70586007)(478600001)(70206006)(36860700001)(47076005)(83380400001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:30:55.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126974cf-5a15-410d-0358-08d905cd8811
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some platforms use separate CPU firmware running in background to
handle state transitions which may need runtime idle time of the
corresponding target state from the kernel.

This patch adds idle_time to cpuidle state to expose to cpuidle driver the
idle time that the governor menu predicts based on next events and states
target residency for selecting proper idle state.

CPU idle driver passes this runtime state idle time to TF-A.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/cpuidle/governors/menu.c | 7 ++++++-
 include/linux/cpuidle.h          | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c3aa8d6..0da5bc5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -382,8 +382,10 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			 * stuck in the shallow one for too long.
 			 */
 			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-			    s->target_residency_ns <= delta_tick)
+			    s->target_residency_ns <= delta_tick) {
+				drv->states[idx].idle_time = delta_tick / NSEC_PER_USEC;
 				idx = i;
+			}
 
 			return idx;
 		}
@@ -393,6 +395,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		idx = i;
 	}
 
+	drv->states[idx].idle_time = predicted_ns / NSEC_PER_USEC;
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
@@ -419,6 +422,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 				if (drv->states[i].target_residency_ns <= delta_tick)
 					break;
 			}
+
+			drv->states[idx].idle_time = delta_tick / NSEC_PER_USEC;
 		}
 	}
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index fce4762..12db2e9 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -55,6 +55,7 @@ struct cpuidle_state {
 	unsigned int	exit_latency; /* in US */
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
+	unsigned int	idle_time; /* in US */
 
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
-- 
2.7.4

