Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3A3A145F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhFIM37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:29:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54359 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhFIM34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241683; x=1654777683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UeD+FgLO9aIjFzdKrHDcrkqDgbjr4ljOtP7t6+n6Irg=;
  b=iLE0r2r/X3zVTMBjudCkKhAn0B4liXzTHWycxbvCdMSqI3Y+yilf+8rU
   sCTJs70+k9xMsc3x6rkwhslKJ63/kedyn5WJevG2I685cXpUH0+EbCs7V
   YyF2yRce4bN7mE3PhWdyjFBCmNtL9oOr+hMY8UrAO6tqXh0Vf5gnee/GD
   JkvnMJfL1pF3yc2/yupsmFqhc4SM0AGkp5qJCO9ic2A9f96xC49UA3x3l
   EtyXZ4QL/mpVOcDsrDPUPu6e6kLVAFz3S4ahd9nN0LUrGjDCaNM9LFeAv
   9v4JQzI5KyXKGCxkuusERLGX4PRktZirPJY5W7oISEhhxymTTyhh4MwBv
   Q==;
IronPort-SDR: 7N2/xmiqv1OltcvYXSHRaV06Hv2/xgLUz4RWRtHWpPM3w9iqdwPIsf08EboG3Txh7hHKrp26ZY
 Vr4lxdL1yMUc2R3fsaV11ooBWpoprEKZglB9Y4CNwoA4lYa10UC3VwtcTtbTJB9s9qp+LFVAsG
 bFKx9YCXOSfIYcLZ7yHJaS8q32W6f6lasp+lMGmF0IbRnY+VZpiKf2i2KeGHFTmrSkWWYa5GGG
 yMuEPfs1Lk7LruSQhVtUknUh3KBVYzTyCoGvHUCRUioJsdeRXFe6W8GwJv6tvBUac82F1EDVVW
 1H8=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171847848"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:28:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqDZVGczoCo6sxZ87DnK2OOqi9Fo4jp/eluePAzYMATMtvfqMS134miJqvBlBxPDiq4Dpp4P8fmrSyNxtUScoGr9a6Kc5rUUy3bTGCUgKCV+1fJtSUtPQtW3VSSF1Y/CRTva/mzg0HXSCaWQ9DWMnq9liJj+B058J26zAY7WF50y2wprkK0YxdZ+gNQ/Jl46wfhXOfaADcM49DB0TpXbxnd+EIQ1AahT7j1BQMMyu6ZtPE9quuCcjnBRUwwjQrOAfb1t5fC9jrg64v9QbCCnEnTot5mp8iqbm+5NnbAQk6VGFehXSswraUoQgoZCvXQqv/TQOK3f/Q6BUrK6QVpbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=AwZfy/WMDBeMao7vnfMla1g6K1BJzlHgeCDbMMglE4e+aou/RSu1xrHRFWSyy06VEaM/XhQ+Zgp0t6az3RKbq/N2zQG09zSC4pDQkEAlYQmD96FVJMJJUzjduMwMFZASMfjBe6+pDCXAC0mMtq+H6z0ajSYKWMZGd8ZPUn2S3onFKDy0MpDLqfTMKmkkGdZmDpZVNgNxdDACqozuhyT1i4m1M2Q8ZZ3B8U4yOjP8F2H/ulju6u1J+HC5ZaNE1t4T5tEysR90CjS3GMyB88J6pSKHIszocWkoLWHb9iqCqN2u86WR5aY9VL1j7OvjJR0dB1SnC+5Y+bWoNratiUp3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=y7JMSQlJXVAfWbG8TVRB0cMXwdo1iYl/qkq5LXy1g0BH6OSWBxcC1IQuXLJ1rzxwaMEDZ8Uvsed7oMOMmhiIjpq3KV//UzsEEuZah5cIsJg3q1mNkJAurcl9BAXO5FDOW8osdbyF5iqLvC03USB/48sde+/aXFSCnAeVIoK2tSk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:28:00 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:28:00 +0000
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
Subject: [PATCH v6 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Wed,  9 Jun 2021 17:57:11 +0530
Message-Id: <20210609122715.3389-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609122715.3389-1-anup.patel@wdc.com>
References: <20210609122715.3389-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:27:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d8c93f-66e0-4de5-6763-08d92b4204b3
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB784393E31A600381F9ACE1858D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHJ/7Ofpo0L0w1LEtfTPBso3uGMEMwRVem0hFK7n69Y0yXBW97jEpPBNYAl5tuPB8VCHz4vJ/bTz+LeCWlDJdAOt+8CJMHiou/RkH8Pu6I+gEzK+8wZYKZdEZUpgFZYwNJ6Mk7Jm3QkjLDrjcS8IEF1VVtxgsoB+Tz63wN55aQP+6Zjp2SNubOLdz+8AOELtc/XCdFzeCrPHee+EQU1d6LitMjWAakCmjizqIkha6y0vo4s0yp2zJTCmdepaQdvxzL0ztuS7whjs4EUHR/qThdjfPcnNw2lVghTTyX1fHCn6NJBcvWPNqT6fpdaDE187Cw1v23V2M60T2eYlVpzrjgABRCrU2+7wVFR++tbdio0F29+38Ijzxixlp+cl3Sce9/gtveOyTd4MgPYJUBQa0+pfIPFJaOPLI+LqV8xb3etidcXx2JnVTzpSlRCKnbw1upUTFFHsIF/dRGKEXHo1dQ/bnYhSK6s9Grbto1QlFvvgFNWQR7e4kKkPbNbe9nbCO+xaSzQ1xERIdQXPz9sM2VLdey9Qfslhuxy+X3zf2fLfD/RfIYAL0LJu/HsIC57HsHuUCZamBgoeUB+MsKEbDfv9QYNFpdhQxqxNkNMcI/GGW+jU6BAS7MHmJlONu2bpDQVuA1qOn/uTJX4AC1RBKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(110136005)(956004)(316002)(86362001)(6666004)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(15650500001)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAjnGmjkcQmHtladAsrbGnudp63aR9G6a7e6IrnV9j71NtdVDhIxkaYyTkCC?=
 =?us-ascii?Q?VjSHa7QAN8yizWuCM8McW4HseVNqC0qR6zIW42tEmuJDe3WpGH1k35xKHH1n?=
 =?us-ascii?Q?t2wNbHw+kkGmZzg0hOnUAYFSn1rLq7Zk+fcwmBzVDnABIlB82SrNkDxBccaW?=
 =?us-ascii?Q?6jrPkA62LlekHl5yraMkP7OUhFHVh3XOrp3Bj0DN5S0+N0RlRYPI949z5AVW?=
 =?us-ascii?Q?Ot965wwQkkeYtgTpEqJ+wzhJMtO4LZyANfb/aj5XV3Pmstwo0li/Ib0fXl0v?=
 =?us-ascii?Q?eOGTTIKuYssQbNP0K7Hc0IFh4mp3rQxokzBPQTZY7pZ/JseIjiCGnF6P1560?=
 =?us-ascii?Q?3wlRbGvfuxS/N194kCozNMxJ7WyV7KC/QBaHNTtK/q+Xg14V2xVL1vugHl2u?=
 =?us-ascii?Q?34+AvhCMI9wh3ZGz3jt0G1+obc+aAmraqz+wUWJBboMY3XSoHstKsnhMRHSm?=
 =?us-ascii?Q?1fH3XRfu5+FSYFiT00t9zYnDfPeOMm/PmCLodQMlK1Ee0iqgVqLwVA+KAFH9?=
 =?us-ascii?Q?UhzgGa8orofnA6rHtRFUuHgtiWC7ogqepAgLnwjaTOr8Zc15QufwWMy9wc15?=
 =?us-ascii?Q?jMrWyQoPgSxv5EWWB4CPQ0Ju3U7Lm30vg1WfFyJ+W/zb9IAR2uJm5Ceqdl30?=
 =?us-ascii?Q?4bPRdeAlyqIERiXHGqbLtPIMNRHN8SUGyz4aEUsXvbiaYCqYka12h9zjgsDo?=
 =?us-ascii?Q?2s+17gGP+xFh1JuxWGFS2eXBkCK/h8z15/xHdRtANLMDlz9EeKzHxZVd7mVH?=
 =?us-ascii?Q?7ixNh818Sspjhunn6+RgOZjBSI/OujV0sv8bTUEpeQKDWx0XmoCfCoZmS94Q?=
 =?us-ascii?Q?1vorMheMS7fQGzMH3BNf6AV/0LKY2ijFfB8fp+dRJp7V+y8foBGhL2Mfu3DU?=
 =?us-ascii?Q?EOabpfgiJ8hgLJzQh4yiR7/AvhMtCDif+ji44hY5cpnWdnY+1imT7XsRDgss?=
 =?us-ascii?Q?wE2g6UJnRce+HfJPfzEskG6t91p4mjp189SsA3v9ZU3B9FfQhuE2KX40tX0S?=
 =?us-ascii?Q?z419K/ReXxgsRQwIZeb9+HmvX3LS/Pwz01vT6KFFYPDufZbRjkPIzUPfLI7F?=
 =?us-ascii?Q?YMpHiPBgGq3OoL7uizYoQGUwAZMFFckpPN2w06vSeZfs+M5xbC39JfJJNvZ1?=
 =?us-ascii?Q?O9AhgPbhNA9ft9iqrVKMif/BWlwmeEsQa/QumssGaDgM7q//1g8KG34xRSzG?=
 =?us-ascii?Q?0Ooqp88jb8q8u2wEn/UMVdkfjzDbBUvOBjYy9z64c2ZC58XjEkkzO9kAUJPe?=
 =?us-ascii?Q?arRcXFU/VA5GoPYnzysqk+wMZNlZywOijZuCYJmTfK2+Elxy9orQfQFxudth?=
 =?us-ascii?Q?PYAEQ6ECjFXkPBzhk+MnGw6S?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d8c93f-66e0-4de5-6763-08d92b4204b3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:27:59.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8Zw2rGZZVMeMSmgO9PczyMFGMijHObIDHDvbp/neIztsGH+sszsWhIaauvv7SF7jn03CMUSO0k/au/O0laCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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
index 289621da4a2a..ab9782f8da52 100644
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

