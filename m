Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23C3BC883
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGFJeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 05:34:13 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:15073
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230472AbhGFJeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 05:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls1+VgcfpPut81U9piU8qjbwniLJ5G3x7Fcz+9R8Od3jHDDvYDVFFIjOLzfWDhnoymge0iAH5cK0c7CBxp4Pcsi2H2+MLZmtTbBR+DCwRGFoPVGBcrhAsgAqmO2edHldMQWe3650DhUvilXuFGZ1unE/Gw7xXz4cLITnteaJTdTZ/wbSl4PDOUm5v/QNcY6ojcBfPyPoJAanhDUFROWpTpEA9gAOP6M78R9AtINd6krXNSMuCXCQVESbnfKY/T0fNA1kyZLVXc2I/cWQfp2D9OfflrlW7IMw2bQbM7mTX6i3KBWDgX1iKnjNakGF5YEfPePWy6M4wkcJIxFTtuM6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TH4dSuE/RICWuqVedJF6PJG/9soufp/J9D/JBeclCA=;
 b=RpFTFnPZHnAOl/P7GnvWmNM5eKV4AExbT0Xo3TwZN3LC88R0CWnoMA5KoboNLcT73WtGHx25Y4fC35mFhoe5QpRPS1pCMFnG/MhfzCxp/N7IvFg2P8We5/7TxO9oJ9MXZNeJFzVuvFxBAfR95hGCsARpNXNFQcwnLcqZ+0ILcoPsdmcCvpH+mQYKNfhdRPVI7CDrz21cQqtGNmbvI6yWMg1Fnd5yWWLXR8RzQ2s90gmbSgsPFZ8TNvDfgAsMus2wem/RLdwXPdPG7+Pp9XKPOC+eVvXaClBkrbhfZh+c/m8j2L0BFgGjQ2wL+rsaXiEpsS/+avcGg8bVP+/MaJHU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TH4dSuE/RICWuqVedJF6PJG/9soufp/J9D/JBeclCA=;
 b=eLWzJFVfx9CquFkIiX1+u1Go5JdAgf/Ltw1jg9Ze7gGWxhWdCY/pEjkCVq/e3XJdm1jSPf8qIc6fClyIgucIRWozBJ8wueunW8M19qYeh+nNxlb1OOEk+U4yya1FV4mV/adU/q74rL+icgW1rPV2jjiftKfzyhN7cBFTexQ4MNE=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5660.eurprd04.prod.outlook.com (2603:10a6:10:a5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 6 Jul
 2021 09:31:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 09:31:30 +0000
From:   peng.fan@oss.nxp.com
To:     rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] PM: domains: not update genpd status when power on fail
Date:   Tue,  6 Jul 2021 18:05:19 +0800
Message-Id: <20210706100519.13851-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 09:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe833d82-699c-4ff4-b0cc-08d94060d61b
X-MS-TrafficTypeDiagnostic: DB8PR04MB5660:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56600FB7660FFA3673EDA765C91B9@DB8PR04MB5660.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQnl1EQ7RBu/o2P83fmKzbe14Y4WV32IInAMiyYEUJ1FSC7aidFMcD70OrvTA8oYMxBN81NS1VxhvCrQUGuGOxkwZNqIyD3uxQAfMYYTp5OHyTsqQjDGTIA12s1GIyjkmzqGxM3M8a7z5o7SgyWUU/b30PRGFGWEYfO3C23msOswKlf9K9kpnCVoONXyZyfOsZ6J9aI9jjbOaDizE64rWk9UOnzgwRhvvmcUR2cIUQ9S5ilvFI9YVclWN+wpBvx7osv0YJXIO0PsggoLNCkgdD8mhPOWqdicHtnLQrYQJJBLWnSf2LDuLwYQDK+IzfhCkwvWElOJuUwRlSV8ly3tZGPsqh30rFhqY3xCLu/RvBLIg2TAojBNVWPuhL7Ds3qXtoPSViu9iRD8ZfiO8bYjbkCsCMz7h6v0WqP0cKU6s7ryM/WE4KhMbM+tTIP/CJT2diX8g0Niom+5vj0RPZChxN33WVv9x5YQplokjAxiiVIPtOlwMwNoM8K8aki+s5PvbcRLY1Tb7JYkE4mMij7UK6gIk6wgVPklgF5q9eGgy21pVJ+ji0Lycdi/Pxgi6oTNvlpKXjM7WmLL583RskUwUNWlcSa1hlNhTVdmSsN0JZJ/Da0IUvZL0Cqu3YT2PfttqB4zu30tJDQPg6ScCUKl1TtMbjgmoGImq71u5zX0YUQF9uniwFp0AeO4j92tA4oSXHCRdaVvbZOznmV/6GbsZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(1076003)(4744005)(52116002)(956004)(26005)(316002)(5660300002)(8936002)(6506007)(6486002)(86362001)(83380400001)(8676002)(2616005)(66946007)(66556008)(6666004)(478600001)(38350700002)(66476007)(2906002)(186003)(6512007)(38100700002)(16526019)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUW2msvlTzJ/8QUwrsjWXQo6N3ENT4H+QfV60IKPHvvC5W7KVuY1wvxBqcFH?=
 =?us-ascii?Q?YTG4lwWofEMKKr0hzQaC1q6F09E5aPNjCnO8QhaDM5FN4E0b5CxVAR25iEaX?=
 =?us-ascii?Q?YDDMd0RN5HTakIS7CAwjWyEG+6a4XCGYTcGPUMU2WMQ0I17kuneZiCLnXjAF?=
 =?us-ascii?Q?xQ2oFk3VJJrpFsQiXHfDm5qkHHSQLQZmo+QaFletaaCLf5kWPb/UrsMUTHd0?=
 =?us-ascii?Q?ZN50Ltnp9g2oTHpUPulYkQ+j2AkJJCVFIyjLCJnXTr2GmiQY7wRuRa7Cmdi8?=
 =?us-ascii?Q?VvnrLQMRuaCz4srdgot96BZIC1aQ61SLhlhkCSPXqwRZKEttIRnhU6smYLT9?=
 =?us-ascii?Q?J9ca1VgkFqKDRw3QJNvpuHU5SnOIkA1hCko8CVOgcYre8ldCZWoFxq18ju63?=
 =?us-ascii?Q?qkQvbfcVZrPYAGc5RePIwhLpmfDxKLtB6+77TsBIGEASAJklQZ7NdcqOn8oF?=
 =?us-ascii?Q?2KiKtEA9300/dZ+XV9F4jNMxgk6IJCaFSoQCp2AylbbsiyeWI7x/Ax4mjw1C?=
 =?us-ascii?Q?CGfweGCaka3Kj4nFsvbsXVGL8KTCfZ7RyGVjdmswNbR6yIJDMg6lyA/zgel0?=
 =?us-ascii?Q?Rl9bYp5yPiNG6Ql99Xs2qyvCzdhKf4qPHiM1UnhyZafLzJifauhPfurC/SYh?=
 =?us-ascii?Q?aV7NC66vX5EHGrxuu9LxKSG4w6PX/hlaH5UTrjYjVGDsqHgI837KdT/bdesq?=
 =?us-ascii?Q?HNvsPvK9z5MomQDw4hXBh+zDoZSM4Tv+Nwxnqt/tA5aqddwRsDTyYzXeCGvX?=
 =?us-ascii?Q?Hf1MD/whNGRWAJE01FTy9A2We4jOaupSTRC4rU/jXFD3SrSUpwGEmLGQsd0Y?=
 =?us-ascii?Q?7wF5vBSvDDz3k7fT7UVnYQbIGUEUvEKO9BKQKqyaflrrfXUYZto0P0oTCxGe?=
 =?us-ascii?Q?WXu+9eRPtizCHA4YndfE8IpRx+/PlJ2Ocfj5mkbByJl9WSGnyj+9pORGvzr6?=
 =?us-ascii?Q?rUPK46nzzM6Ik2SVkrFNaJb6WHQ/BXyKQkBfA3y8bbxF1VR/q/Wjr409W6Ni?=
 =?us-ascii?Q?ePX7m1RR6eGT430y8Sr0FD5owHlmtRZn2kmsADkGdr3UUcvOAFK7TJQrB6/N?=
 =?us-ascii?Q?N2ouJQUXBiaC68cTYBF+jYzCfOC2IL8tAaAhAusU5MiyJpq+56LhJgXWeOL9?=
 =?us-ascii?Q?BM6iHyMpiVz5nEqw0Air2LwcMGbzyWZx87mPkhsdbfmpGdaWjCfMxBlbZ/Bd?=
 =?us-ascii?Q?DIzUnEsMhezlAXEyJptLVwcWo2hsKW7WKOWRNPHhxcsJbObS2DC5OE2GxrXe?=
 =?us-ascii?Q?O1/Rmrj3Ifetr5mge2L95AzfynCeopzSxP3Q9aYBfeWyS+dAvcgAk9UQNB4b?=
 =?us-ascii?Q?o9/m6f7BagZIgQXEtoJPbt8P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe833d82-699c-4ff4-b0cc-08d94060d61b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 09:31:30.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9GLEKGKrIR3ZHXikVnUTK4qjNJkrd6O2fmKBjkg3SZJtfLwfrKSIFupRI0hK3Fg90/vZuy7pyahwnJDsAoDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5660
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When _genpd_power_on fail, the generic power domain status
should not be changed to GENPD_STATE_ON.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/domain.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ab0b740cc0f1..754a5d384479 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1101,6 +1101,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 				unsigned int depth)
 {
 	struct gpd_link *link;
+	int ret;
 
 	if (genpd_status_on(genpd))
 		return;
@@ -1117,8 +1118,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 			genpd_unlock(link->parent);
 	}
 
-	_genpd_power_on(genpd, false);
-	genpd->status = GENPD_STATE_ON;
+	ret = _genpd_power_on(genpd, false);
+	if (!ret)
+		genpd->status = GENPD_STATE_ON;
 }
 
 /**
-- 
2.30.0

