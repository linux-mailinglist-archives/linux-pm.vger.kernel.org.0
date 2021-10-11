Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A39428880
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhJKIVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:21:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35584 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhJKIVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940354; x=1665476354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1YRQygTL0UmurMsJ0N1IRa5vcWU2SqJYeY6U57nO90U=;
  b=hbkuLhkRVULxLaACMTHifHiG79uH6QVN+X74OQAvFLPPzE/oSCjdzttl
   /NRwZez3URz0dSYqH0zY8/POnH9sJ2H+HK7WtRJTy2bal3W6IwAkjh4EU
   ey+4u18FRm2L0D1fSfAqP/s78+9purC0pd3uE35T9yCkZWpm1Hj8ceapc
   oGgq5sIjWkur2NrLyvmULY3DyVDXcaRAsVq4AiFQKjukNjugtd3rVR5x1
   Bi2qCQ9ETOlufzxjI66fRqQ+dcZqecS5BlTaRzwn9zEzYJwbazJ+6ffAe
   qH6XS6999ctV4r6Wjxvr+fEUEzS+LllXC5ob7FFoGrcNtXS+ZMFWBqSuS
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="181500700"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmVCKnwjk/xFHALMEtMFwJSUi1GHqVMyooJhzwDvOjiYwTCnJP205aT4rSzpFD21cH6f9oSRYxkadBmT9SrHOaHd1P+ykBpzEuRZoNL6tQpxhBhGB9+Lla4EEbMhXiy1jfV2KybBFSroiHh16c+ITbUVHGB+kif2h3RsJibjIh6mUn/dASqMtsAR95a4gnt56nuyu8Bq0fe2ezONhYyx5qNMguDMNCHhKbHsqoCprZm8olIXeibPA0RZ0DLWMeGRiEzwNikyuPDMuv3CzMQ+6sMYUPrh0YmPnbk2aOjkVSGIS1FDo6ZR6u95Ao35rCFuuz4kmfBTCjh9yMS6txt6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7x90qCtmA7ZrtgxRi6zCOgsrcystegf08vOcwCKzmA=;
 b=a1pycOjIRT5slqHSeDZCNhp2nUtI1GPYNpo08zK9VqwdSnIL/XFosS79xvwFRjRTRAH4yhofoyulmfc4lW+CjN0cFmASY39m/L9/YjBIHqq5bk78YXhgxKcaJEa+gH0oUo9k0K4Xfm+FuceEGgLzH9LGCAs/TS6rBCl4/BmjJfvDYGpFkhXXoVUFDxKI/wBpJQpeD4ErhQpmH9tocG3fq2ItS33gnPMeVkETAgB77w5VP/3wABIovvXhAj3vLwTvUVZ2Gv45mqLtxxqSOkY9EwtnAPsAbVoW2ammOVdoYyZ6t7xCHtUVYv2yvZdlHovQ+by8M0L07NBtJ1iqcbmPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7x90qCtmA7ZrtgxRi6zCOgsrcystegf08vOcwCKzmA=;
 b=E/vMbY5DsF+y/cdBQUkM8A/dm4FO4+lSMPu3ojgsuWW6DSuHq+ZTUp7nTzKr/HUfmSN3NTkDFFA3mLwYpQLgRg4YQ/vLCfrVLMS/53mZ5E5BKOXcenfHjAsgbriK3p37DOcJp0XNuuuRGoF+fhw78Dx4m22HvwogYOW7+pSlhYA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7874.namprd04.prod.outlook.com (2603:10b6:5:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:19:09 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:19:09 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v8 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Mon, 11 Oct 2021 13:48:16 +0530
Message-Id: <20211011081820.1135261-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:19:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d3e582-d97e-48d3-09ab-08d98c8fcc7c
X-MS-TrafficTypeDiagnostic: CO6PR04MB7874:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78740DCD8A03E4EBA8FB309A8DB59@CO6PR04MB7874.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TORyZgBYYEiEGwwMwzkYxyDDEFRFAL9BNLAex8GSS97Cv00H6v/nFaHDYW+FuvQax6+P4mnc9s2QgHWtHStsUG08mIevqjP5PkxukiCGW6yezCy+HGqxQlx/lgBxHicNPYrJCj62XZ1T8vO5UNzh1CHlEOK8HdSDaIFkVQeiybX6Zj8ljih/GJoBgg2XmjCay2pQ03RvtdeNDkg5Y0TNSzO7nE4cGByLcpo/KUPqlStB45XXo62o03cgKAnUnQeMtJpqg2krT3QJngdJ0IdgWCCTQ68rbNsjXC76wPOKDqvAdQsXeJEfKDH1S7VIQOXFOk/Kc1vtXiZdjP5nkpVnmZ6JwLOg9FQu0dyZMiTjzUlcFFRBgxpKJHrYaBoRExz+1VmjqpaaM9EGldh3jR31JWknqoXD89/oL7aK3+uRA2w/O2AE6lJxhzuWngVj9x/4f5grWl2+6+RFBnRyj4y7XuHWkTHDtnKJPsH2ACchUourdEh5ouIzdV/UOWzcvNlh6TVPWNp0BqvnullvJ+9YJMzfxvTVXDeYSay/3WXh6FCxDDjE2MJk9ju3tf6zLDzaB3iTrKZXUGa80INSsQGnVMfNhBwWOEJ9OZBImnLIGHk/VctDGjjyY61UwnKI6olA7e41ZhhgjsmMf8p7dgb08IlOgZ5jR4vLdzorZW8Rej1XSVV0dO5Q2cX4s9YFvjbxkEEiGdyvNYDAVU2+It0YIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8886007)(26005)(83380400001)(186003)(86362001)(15650500001)(44832011)(508600001)(2906002)(956004)(4326008)(7416002)(2616005)(52116002)(38350700002)(66946007)(66556008)(316002)(54906003)(110136005)(6666004)(8676002)(5660300002)(1076003)(66476007)(38100700002)(7696005)(8936002)(36756003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lBAshW2gxms3Th0VvYlcQ9Hub3z1toMOeb/y6Ot6EGoliEwrFQtfLlvtdLdK?=
 =?us-ascii?Q?Wcgsr7D0TQox8bY1YDI6RvAC3fxocA+1sK7iFXks5/bErJK7V6on6oKDc/Wu?=
 =?us-ascii?Q?NO8ak2JUIo+ptzEUaSrQamXQ0PCNocJFx9U0VDAUCoFUjvy3HBwD679ORWds?=
 =?us-ascii?Q?QGuhW0LJoyvQ7qfycdtRsCltutK/nHvkmtm5YNyMxHWhHnhn3qM956n1pHSc?=
 =?us-ascii?Q?rqyXI0IaWwxM+8VCaZWYYk5In+/Fjid5vKVTdL9gDn0VESPoBKfhRnDg/hJV?=
 =?us-ascii?Q?ugX9l5b1hnVwLn7ZZPcjFm/WrzdlRua7XrLYRb8ayo8EAW3+H7EmLv7ioxm8?=
 =?us-ascii?Q?QLe9nZ/G9p+Dv8Ju6CeuTVkVEkwnadED6dmBVdxOPW+dwlDPiFql7JFwN3CA?=
 =?us-ascii?Q?7N5e3kyTaXuoao5mhmm1AeNoeRekH8z42f6c6zcipZVACtK1mv4D66Dx8W79?=
 =?us-ascii?Q?DZrUApNB6ymv9KeG9jBNwp/rkDAzsv3dMfxhTYJ5d33uVB5I+XK4VRbT1bgs?=
 =?us-ascii?Q?lYZczTds6U9kte7/NWkWvIQvsmaMwC0klQy4GKiqZ1ZMgfI4NLJtAVSxdjkE?=
 =?us-ascii?Q?OARLQpGOVL009NWBYiX3fHqD6xf1l/2uy7nRtedGwXxEg+1aa46lv+pTuTPY?=
 =?us-ascii?Q?4a5/ekhXJAhd0OaVqNbBn5JlmoMqMaeJ1AvA8Cp/inXj3fNuX0rVgeQYwzvk?=
 =?us-ascii?Q?meUH3SmufknlDLExDsO6ZW1vRAaV+GF1fa0lJZCyRvwHIdnCGxCjd9maKbF7?=
 =?us-ascii?Q?fjcv+z6YVepLvePBwSI9ApR6iVwHwCFDav2Sl+BWkSfJulkKix1EW3rjg7G7?=
 =?us-ascii?Q?H+VzDgdzV+genq6BK0xOKLFY7hUgKL1o1+reJE5Iquvfh5CJeGvtj+PJZ4Sa?=
 =?us-ascii?Q?ylKPSFtO+GkY8Ii1nUMKF4XtIYr+4/6bz/BIFhK4Uz3/vHxvhW/xZS67nlhf?=
 =?us-ascii?Q?7Q0EbNwcmNyh9oNA9lJFvhscOFmVwNpy9dhDkN0aBSamyR1HC6wAq7D+qC08?=
 =?us-ascii?Q?XMTelKU25Pw7iEHoONYKWqfivQrymse3LtUWV+1wpUmkts0bequulmHiERT2?=
 =?us-ascii?Q?hSGIqI1VXf2aCitQUsdC4vxvHlwwyzTF8TkbDLnld3rRwm8+/ETYg2AvYZf5?=
 =?us-ascii?Q?0X/l0hJdMA5qLBATkH56rknM3yGYwFjexMvA8h5NuJ7kLuVLpYfK1wlQzl/b?=
 =?us-ascii?Q?v/XruwcUo/l4obG57/DEE/B4yrtGlrZjJQXy/4yl7EKHczi1R9tRkjF3hFzi?=
 =?us-ascii?Q?DLtDT3AmYIQhdKBZz01C6x5k6qTaQl+3j/HJ+EX+bKgvzYmaBqi1gTyJmLQW?=
 =?us-ascii?Q?Fj/JcGmLw8+KX8uP5cDvNdzw?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d3e582-d97e-48d3-09ab-08d98c8fcc7c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:19:08.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrwWmC4oGvEbE7BV+R8yYz/G3FNNUS7Bjnq5oMxtv5wSuL1duhuxzu8saPqyINEXZQGGMdKu8Uzb7lqKq2O8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7874
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We add defines related to SBI HSM suspend call and also
update HSM states naming as-per latest SBI specification.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
 arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index a992faeded7e..ff5cecd13bda 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -62,15 +62,32 @@ enum sbi_ext_hsm_fid {
 	SBI_EXT_HSM_HART_START = 0,
 	SBI_EXT_HSM_HART_STOP,
 	SBI_EXT_HSM_HART_STATUS,
+	SBI_EXT_HSM_HART_SUSPEND,
 };
 
-enum sbi_hsm_hart_status {
-	SBI_HSM_HART_STATUS_STARTED = 0,
-	SBI_HSM_HART_STATUS_STOPPED,
-	SBI_HSM_HART_STATUS_START_PENDING,
-	SBI_HSM_HART_STATUS_STOP_PENDING,
+enum sbi_hsm_hart_state {
+	SBI_HSM_STATE_STARTED = 0,
+	SBI_HSM_STATE_STOPPED,
+	SBI_HSM_STATE_START_PENDING,
+	SBI_HSM_STATE_STOP_PENDING,
+	SBI_HSM_STATE_SUSPENDED,
+	SBI_HSM_STATE_SUSPEND_PENDING,
+	SBI_HSM_STATE_RESUME_PENDING,
 };
 
+#define SBI_HSM_SUSP_BASE_MASK			0x7fffffff
+#define SBI_HSM_SUSP_NON_RET_BIT		0x80000000
+#define SBI_HSM_SUSP_PLAT_BASE			0x10000000
+
+#define SBI_HSM_SUSPEND_RET_DEFAULT		0x00000000
+#define SBI_HSM_SUSPEND_RET_PLATFORM		SBI_HSM_SUSP_PLAT_BASE
+#define SBI_HSM_SUSPEND_RET_LAST		SBI_HSM_SUSP_BASE_MASK
+#define SBI_HSM_SUSPEND_NON_RET_DEFAULT		SBI_HSM_SUSP_NON_RET_BIT
+#define SBI_HSM_SUSPEND_NON_RET_PLATFORM	(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_PLAT_BASE)
+#define SBI_HSM_SUSPEND_NON_RET_LAST		(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_BASE_MASK)
+
 enum sbi_ext_srst_fid {
 	SBI_EXT_SRST_RESET = 0,
 };
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 685fae72b7f5..5fd90f03a3e9 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -97,7 +97,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-	if (rc == SBI_HSM_HART_STATUS_STOPPED)
+	if (rc == SBI_HSM_STATE_STOPPED)
 		return 0;
 	return rc;
 }
-- 
2.25.1

