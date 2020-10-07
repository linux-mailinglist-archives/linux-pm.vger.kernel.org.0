Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0064228636E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgJGQQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:16:38 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:58706
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729157AbgJGQQh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 12:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaPzv1XUWGg1/hm4Ep2/7GpUoa+Or1qGKjJGHc9xtPcQ6q+uiN/Gy0WhalK8s6q02Egv089DBCU+NvPaXnvBIcPcA9FjeT8ifJNTp4IN5Q3DiCBACdKpthJQd+7H5aokjuu6L+DkCR65V8h/HV7PHltwCqgSzzva6577JKd6N6RUJq1/U4mu+LA+z7R5p4mBgMdNDoaGnO/tdV2+qwueguFY55JkoE1OJh1CeSdCGw1vo+Wodk9qYucnkWiHPa/rbYJ1y6xPGdu97c35QpGUbQBh0bStQm0ojE488U0ptgKjdWg1RvcNax2Tbw5OCw2GciRNPFH+oAgoen2k02XHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btFMeEr/9Ss4NPCDB+i+z2zZ2GJmJwW9JL/gY//Y1BY=;
 b=O2F8VGhM6cZ8kRTCH9R4L6421MRKL0PW43pinegNjYVngMBW0ERx8p8kolUBhTJtBV3OpODo+2dEKi61vQlHJIl506Jo2pS6CbBXbMQUW1S7zguhBGBcmlcOl0coD8DxcQZtu7hIM7L5u7Zo4hFaCHmGDHSpCbr+9NzchGJgmUcKSmFj91O3ipAk4jvgV/4CPr7nvaW6ZV0LKnR04NowjAzVu1/hB9eIZXiBQGOZsLzXiqr2CyIFoqDKJVK9WtP/DYOBhCj2+oim6xmUChlEqO3KCaqrBAHgjiH9mFDK3dDqDXmh5qWpbpQSoy1SGN88W9Rbz8lpNzq9Q60XgPM2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btFMeEr/9Ss4NPCDB+i+z2zZ2GJmJwW9JL/gY//Y1BY=;
 b=4WqttiwPdmBwWEKBNhat2H8GXQA7xUgyX/KhEmuJe26eZ4uBrYARoNd1HyuK+3bxMlKv3LnNATghtSYKcCgmw6k6CGKngdIGVZLvPKFErWZ9qlw3bFwddYTyrDorOgT4MRzLF5YFxP9Kgy8F4zl9fRNbGUWxj9lo0WJSR6M97/U=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 16:16:32 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 16:16:32 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Victor Ding <victording@google.com>, linux-pm@vger.kernel.org
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [PATCH v2 1/4] x86/msr-index: sort AMD RAPL MSRs by address
Date:   Wed,  7 Oct 2020 11:14:36 -0500
Message-Id: <20201007161439.312534-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007161439.312534-1-kim.phillips@amd.com>
References: <20201007161439.312534-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [70.114.200.6]
X-ClientProxiedBy: SN6PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:805:66::22) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by SN6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:805:66::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Wed, 7 Oct 2020 16:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebff4f98-1e0b-4f99-eac1-08d86adc5b12
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB310659AE682D7B07F0977B26870A0@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2r6DJcS5c46QUCRDgI81zWoAJqctIukEgZQqpAP2HJiIfpUeqywjsQzjrny3CORLEoPJFAiZHTyOavyKV0urEt/bobWUAoLbhk+ndI0giYuWPB//uxocg01CQ0N5ZlH3rEiSLZ7JZY6JWWtVpXRgwjlxnXchYXwqLMXu8kztjOn2cGPCJ8U6D3UzHJ8ZRgJWFNPCBGlfjx18Qvytt1d1MLcrMz0GDGlW5o3uipLnw7TUxeJ/daubly2pE963H+2/q26vulU7D/duOaCv73gXchnHHEEGZY0oq8oKprpKI6Wv1mIPJZrwV7cD1DOaYa8lKNp3tsUJI1XtKoBUzSbGGXSgeGrMGxmnWnIR/UEhAHdgbjfmjE2lB+w2cOzoVhDVBVfah49FyOuFXfShRoJAGZ54wZH93kedQ5aSK4WLvj+Kr7KrUH0xG29vkTR9xLulL45azjpiNUgdavVxlk96w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(26005)(8936002)(83380400001)(16526019)(186003)(83080400001)(86362001)(316002)(8676002)(36756003)(2616005)(956004)(110136005)(54906003)(69590400008)(2906002)(1076003)(4326008)(44832011)(52116002)(5660300002)(6486002)(478600001)(966005)(66476007)(7416002)(66556008)(66946007)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DnUoYLMwNW3ADr4oUA7Q318ULiKW0JT3coCiO46OY4f5fbZmaeLuRx6OHamWNUccfJej0N3at0QemchMZ2FCuCBMYI2aae8mNrujHFdsUsMb24YWoZ0nqAjPLTAl/0IP7ihn+/6c6lHfXAG+Ty/TZCSXDcrIQJWTk8GvVVd/a4ilp5IM6Y02rvys67A58ZP4Cvjj3eEmcUbjcF/HOQoTFP5eivYsN6e1//pR7OI9Dht2gVBmZpYhaHnSvOMKId5VNDFaaptCCmGYUBhyi7tSLlxnzVAVthFTQcZnBJf9ljLtSHk6Qr/JwY1iFtbbJubHlYH5OFmzKYwDIT9PXAEdsDzPq/tIvSMjePeoLeQBsNoxjOAqzyBruIOqFKBUHXuEv8lYR5EA/TvuXYaTnM/dd/FoaDkbLSpI7X2J879ovCLOd8VqJoeVB19lXKznZYjspqXrZDSf5HOb/y3Goed136su6eYJMIovjeR9SPMWMPt45I/rRTlGxKo9ktnPFCFC7myzFgGGsQrkA8jf7REPd89aPdmgmTkubF8V1k396mtQoiHwCH9k5CbW0eOKN/j1cWd0hgYyH2W3+2TGct7XyWqi9jdu818RrWOOsvJJzwB9ZJXF2eMFzqs+lGD/Lw3tK4EKb84r5Fd0HMBTISimGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebff4f98-1e0b-4f99-eac1-08d86adc5b12
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:16:32.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yu5f0y9pE/gGDTv6yqBDDntOj5Wk+QDxZSatGLcw0MN/CDnRP/pnTHNfqHbysmsGMptI2zv34KiJUf9luaXrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Victor Ding <victording@google.com>

MSRs in the rest of this file are sorted by their addresses; fixing the
two outliers.

No functional changes.

Signed-off-by: Victor Ding <victording@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Victor Ding <victording@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: x86@kernel.org
---
Kim's changes from Victor's original submission:

https://lore.kernel.org/lkml/20200729205144.1.I8556c0b9b6f75bf3121989f5641c33e694fff8d9@changeid/

 - Added my Acked-by.
 - Added Daniel Lezcano to Cc.
 arch/x86/include/asm/msr-index.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4f39a8..f1b24f1b774d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -323,8 +323,8 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
-#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
-- 
2.27.0

