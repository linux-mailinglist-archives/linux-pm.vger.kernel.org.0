Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3939286376
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgJGQRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:17:14 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:18785
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbgJGQRO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 12:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlTaxag7gaxI+2Fjb/azuDNL2QfHoKLgDNWljslxbpzttlunG3SpkM0YOGuqNX38VZy/fVYd6+gjChiCoQ+4oNlJ9yLEU7WYlhnL2hgwGKsPeKvZPZpO+MeKdH2Aj5fr/cHgjnosw99b4eJ6pfezeIjK+CVhFpzdfP7dkQeAQjC5JXNmt9vTvF7/Pp3mT+AvoSL5hiFELsxmiUmZnt90z388AMRKxYtzVjSJejGYI/WQCVFsGkKWILrRvGUUI6Yix5pXDKmlnbWYaUuWL5bqs2PBLC8yjlcP70uF6HVnAWe5h/ireyq3kU2zsEpwrypw/1/J/ZWAIE8EVMlVnYF/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZwF1030X/pLsYnm95TrRmgyQ5l1UkZFdwNkE7SzkpE=;
 b=F2MHGgmZ8uD+c8UcVo/y006ijg/FOlfuC1TTKTYuUCbENvPSfdQdd1mS+SD2oEhqUauLmKOhBkDjn98zv1ngs5g1gsLATCIeCH+oZPTUpoVVWDJCSBreXIvHcyxnIl+zNiiGp2+B7DAxFhYwfni/9GBDhCgmY2XFLLc7ULmZryc4dxKP4kRYMK8TYztl+1DZvum8fTKqsBgpljXqIhG0QtrXEOyP+8JlpgAVll55R53wkPj/U4YWrBCGso3VK3PpkRDInlOtEa7N9hOleBUaZjV//jNQEHj1/rjjY/0r39cSmUrE07F6svmU3e0TPIjkHr5iuq/llvZuWsG5Nwjpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZwF1030X/pLsYnm95TrRmgyQ5l1UkZFdwNkE7SzkpE=;
 b=QXMB3pe79L4qLeew357h5tdt0Gjh4fJbbqaYAxjgHNYcxPxD69xjeSSw0MqtWPmXTMX9xwhiE3Iwm0ojp9bF0qtCpOCKAHbDLTBRb3z15uPBd7LdN78ocha/bjYPcsA4mLKqZJaHdt9wk3k/QHows1PUthr9+cI/+PrnNGQDG2E=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 16:17:12 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 16:17:12 +0000
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
Subject: [PATCH v2 4/4] powercap: Add AMD Fam19h RAPL support
Date:   Wed,  7 Oct 2020 11:14:39 -0500
Message-Id: <20201007161439.312534-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007161439.312534-1-kim.phillips@amd.com>
References: <20201007161439.312534-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [70.114.200.6]
X-ClientProxiedBy: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by SN6PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.10 via Frontend Transport; Wed, 7 Oct 2020 16:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51809740-7ed3-410f-da3e-08d86adc7226
X-MS-TrafficTypeDiagnostic: BN6PR12MB1315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13155ABBF1B596F5FB747FF5870A0@BN6PR12MB1315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GA3MoouEcc2kb0QXLjAmiLX0CvoLEW20xy3Z2retpaM2knBj9dMPM85VjnuRl9hSzkCBFOfRuq0yZ9uefW2x+/1eMwXBW7n8d5WcRo8OOl6uroIvWkk+2FcHPWdKc752CBc9vaRZhgFK47Kjn0ncbqpVVaKMxUZSxvUgdYLW3bhyu1z3sqHX2XPDog1w6K+lPLG2MmBIj2LST5UlIOK64xzel1rX0O03hR1wjRL+WiOCRbxlZQicWUb9b7L2bH8KvSzbx9j3A0w1EAFu3567uIAY00XuV0zuHEueIUsu9p12OE0OFZp9vYZIO2S39BjOyOlBU5TY/ibDI/kCYw4CTjePYHj7ORZtNSYWTFhSE/wq5km3+rw153iJ4XLazA1wHcTILTpbOSAevCQgBxzHvchQUmLV66aA6crU6XzRSUjDUEkHB1xDqtiNDYAwm2mmnoP5q19MAyuSAIxwS3GWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(8936002)(66556008)(66476007)(66946007)(44832011)(52116002)(110136005)(1076003)(6666004)(5660300002)(26005)(6506007)(54906003)(69590400008)(2616005)(36756003)(186003)(16526019)(956004)(316002)(6512007)(2906002)(7416002)(966005)(4326008)(83080400001)(8676002)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 50mH2Tww0DusURHv/8pWmsORxBUUa8HGxY4h9WhTTRlKsKR4f9x6JJprIrvTnFVY692Umq9l3SNdS1cCFjpvIjd3ddmEljiREFF40Vh+dydhaQetpMrgC7s8Xcw1JaXX6D4V171w9jjxlXkTzAArZdUSZX62tiexMm4nRRaHPprXz50TXyRh5KKO0LUi6FCruC3qsreHEmomUbjYqO8YsM1iroVME5Yv5yWiZUxk2IynCe1mvSMrw0GqXygcbj2rpmR+DLj9LwdbldNrtdGn7ZT2QfnYnHUwOdTaQnRA6Yge8ZhXYUIDuDg5mu+LGMZ0bJkqbGsjISLZEGoc1SipAF8mUDVkM5xm402p3um+TqkvK57WuKQNFyOpEBXIa93EC7zkWBPSH625gwTC8Vm5i2TmNl0ntIgjE6CU4543NXElpYIacUuG1ELXuTxEO+fcHBTW6/l+ywEMXnCwzNKQ1Z6Q/RKG4rBEcU1RmtuusLC9aaCnIOO673Wc4t6iwJ9PTFBL8fjeazlIrlPC8fxQxGKoo0/+UHo4hUtKydTfcOhcnZr9KPjyduD41vb655pXG/LZxKV71Wf9925e4qWH2GSo7U7AII3eiC3iQiWXDwsBeLDlRLrAPeuo49MT9uJAByTpL2ivmkZVI1EIugY8+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51809740-7ed3-410f-da3e-08d86adc7226
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:17:11.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+pAuGLCKETiYKMR95/bwRmVQ+5fNGJLM9XHmZ5sMnlaP3PS2pTSxRB/KtAvmn8cTU69RgMqr5L0/zeY/wOlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AMD Family 19h's RAPL MSRs are identical to Family 17h's.  Extend
Family 17h's support to Family 19h.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
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
Change from the original submission:

https://lore.kernel.org/patchwork/patch/1289843/

 - Added Daniel Lezcano to Cc.

 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6905ccffcec3..56894f4cd394 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1056,6 +1056,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
2.27.0

