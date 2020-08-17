Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F91247A90
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgHQWl0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 18:41:26 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:40480
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728989AbgHQWlY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 18:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmfzrUCx+oyG0HbgyaB77NM1Uvm96Kdzqfr8+lxdKqZbD8REZ46wj9yy1TrKKYC6gBP5FaeYTnUvLzkgZ9WUg5xbNrMmbz1SQrXJ6RjrDFK+hH7nerWIMXaVaKjnLBZb5pTLHVHvRm3ePTxZLXZ/IJEKBWB+lI3dOoXZR7VXktNVgp+dD0v5LIl7cqhF12fth6iqTPphlw/pTPdE3iVByQHfgsggNa8pwn7EdsyGZjqT0ppQaDpNz9jNeBdCoJ4xLqoNzGTngUkLeWsnYheQPjwret3tvRKo5AJsAfd0pUIn6di7t0tTbxhJLI0m3TeQtZGRS02Q5zjFePUNMoWUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miTzta9JA9FSI2Sh4Nht3dztXcL67ZHgsCRnFF0W3bg=;
 b=KXLl515P2nVl85GF4I5oeR1UPEySn5uDF0qGsw1XoyeCMbtSGb47g5aW+gMjCLCIp/56TGo3OC8roMOp6Zc4r0YmsIy8QcTxPjNGJavfmqWP5Tf6kzeBmMHZyd7Dfi7em4GX9F/7pnW21oKpzDNutpsq4q+6jnrT5v9sjV11P2BVBxEup0cbgIa89GD0ghs7iN6kV9u5+50TSOEs9KwMCJhTWSjr5SgnR5lKnu06Om+P6H24IrLOTuxZSFBc2iNhd//JbgvCyrPkUDEbHhOxTNscWEY79d+pJWoT98qVPWs8UdPhwieFjQlHwz0SE63OU7TvMXO8PEZOCIKJm2iwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miTzta9JA9FSI2Sh4Nht3dztXcL67ZHgsCRnFF0W3bg=;
 b=mBOw/wjT1iX5Y7iIMhJcPcAi5oEDCiUF1hno1UPOlEgaZ55H9mr9RdEQoMGRxSi9pPSjJuUlJpjv/PfXngTJQeOoY9wzahyoFT6QRoOyktjRJd1OQo2czzcVRZi83XTUDyoZ7OBh1jsa9lLPr+TRqjJfhwcJ6aTkQh8rEUHtjA0=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 22:41:21 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0%5]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 22:41:21 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Victor Ding <victording@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH] powercap: Add AMD Fam19h RAPL support
Date:   Mon, 17 Aug 2020 17:41:09 -0500
Message-Id: <20200817224109.11040-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:404:65::19) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by BN6PR17CA0009.namprd17.prod.outlook.com (2603:10b6:404:65::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 22:41:20 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52da7bd2-e7a0-4c9a-89a8-08d842fea9d3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0017EB79041F5924980E500F875F0@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7trp3bpZoYBBE+HlpZL1Vm3oPh3e8sRClLOlT0GDu3C7pJOdImouJ6ylt3bSykQE1KH0jHRMgmwEfZ0EKSf2nNve9LcmwCtOPkuBL2sqQ1YpHDk7ztZ4m4Z9SXT7rKNEAVAhYzgK5d7swPnzr41yQjQZ2s0WOBMWP3Bva5yg7AwtpnXMDtEz+Q9DONRUo61y5gFt+ruHXnJKHHg+Iq4pKNpFZsKvnTHuPVDp8TOwjFQsxiaywVMZ0rZHw0hvaadiclq6SOF+LSMVGsNLf/Y/CqlPTv4REe3elGZdSUJL+oIkpQ8m44pYeJRpuJPCrVs+8e7MAdQtk+B9yE31EC0ij5/AaLZ8xeH82dkbkKnVknlf7nw1DP0kl/jATmWdhnGg3hbJxIHc0llGZIw9c5w57KdtGAEyHXmwiKGJrZSeI4jN9upNot1hnEDEt0c0kCEGE+GnTQq0johWGF2fJuuyNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(5660300002)(4326008)(6486002)(1076003)(16526019)(6506007)(186003)(66556008)(44832011)(66476007)(66946007)(2906002)(8676002)(8936002)(966005)(6666004)(478600001)(316002)(69590400007)(26005)(2616005)(86362001)(54906003)(6916009)(36756003)(6512007)(52116002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +5YSmXfyyP/HwyP9zdMrJog7+yvRstdyjH8sd/1gw+nBwijNQgYPhQ4BYrtMR6HVVU8S51oIw8Cg+Xp/mceCB1SFu1R+1XU1j1yVuzlUFCig3b6kdug5wvYjcXafYDjJrEQMaD5sh702YEYjf1CWdYNEEzwW64z54mw8gwgEIcW4JrIGj42eM9xgShzsfThmHOL/njzevYb1jXDqNboEsIKMGwy/i0cjMaf/VQCY8YmrCP+Ud+fD5MYi/FnCRF921+XhAnnowQWzB2wC5Gw1+qATj6dWVaQS5cCSWoH+xmGPQrR18Z49ykRSz/ebDkizS3Ki1Z12C6t1Y02cYr7UYpjNis8PaauhbN5gvPSzhfWYIBU49n/UOG12tAv/JOAU8/D5g5tHF1H0YofX6rJ1gw/gNQxqkg8BMPt1M1+FIBq17eacbG90fM5IULM+ahie0bBh40qNC2e0SG7WCZ3Q+y2eK+gey4BSxL6C8rYF0HHL6LPcBGGKgk5JgXZ5x+rswNWrxakMX39Yw80wXIMIvEb5kENfIi7bQs7Q9HjIcb8dpGyV3327wxeHcmXSdu3MuHDXy21N2eLSeJloVeft1jFeC6hyjcy/0h4eiGgLIaLY8yeowLG0pTsoqrtB3i3Byy5oBXNZNsTgT4PMD29tNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52da7bd2-e7a0-4c9a-89a8-08d842fea9d3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 22:41:21.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks4RtoFw+2OhA1nw+m7KwLlHke9VsnQHGuXleWojTVeCJS/q64KlU0oX5R0se6fjMhzQQYVWM0baGtA1U0FokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AMD Family 19h's RAPL MSRs are identical to Family 17h's.  Extend
Family 17h's support to Family 19h.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Victor Ding <victording@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: x86@kernel.org
---
Depends on Victor Ding's "powercap: Enable RAPL for AMD Fam17h"
series, submitted here:

https://lore.kernel.org/lkml/20200729105206.2991064-1-victording@google.com/

 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2e311f9c0d85..1bc0e67cd7a4 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1052,6 +1052,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
2.27.0

