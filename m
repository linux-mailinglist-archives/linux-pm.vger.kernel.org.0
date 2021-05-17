Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D669B382CF6
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhEQNL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:11:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48887 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhEQNLn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621257043; x=1652793043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UeD+FgLO9aIjFzdKrHDcrkqDgbjr4ljOtP7t6+n6Irg=;
  b=KGfkhf68coXF4kratIzmDS87TMTnldCm9w2+CrtMmn29dVcUB894L3Ss
   M1JoO+RqO724nsJtI39ULLLbT/z2E2Z8dU8uwEk1vtcwnCaCT0kZ7VoOi
   2g8a+u5uaom15if95IevinFfPT/eCN2ooVzL2k5pMjbZH8jQWf2fxksZR
   1JcUISZCi/0BbuxoSIVfBoS1EODHWxab479xLppGFOQuxe3VKDbGyhNjn
   3/PVHZ97jzr9HXcC61D/VNVvvxmBsN8bsPT5j+IwMGOCI8Pi/GKLnWUXz
   xa/t45GlF1I1roXuB61Wfv2ZukiZy+Zt6Tb6s1wPZdWsnd4rhHRsRFw7B
   g==;
IronPort-SDR: ytVehe1d4/oFE8OOQKKrFzAxWvwXCBaYrJ4NVbct7Y+X/BbZ7YJJXdLHxiWsuNfGkgnF0nnBzx
 1i7iMFpHp/s/1oNOrIhXzlaRHXbwMm9NpcS17CwIGi8BJ3kC0jDfZzNeBBViJE0nDIzkhs4Yb7
 JPQVoWBJYmuo9fcPEtrz+tjal/7YOyPGQuMuGdSrwb4qqq6ePZQaP628RygUtZYsW1JTduNGeJ
 6GcZg5AV4qYPrbsYRoNcvxmTa/VROA/zKudd6gQd0VVCIYP6lMNld0RiXhsLblMN6KWeNpIjvc
 Bi4=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="272394640"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:10:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO3duxMRIXAvKINVN58UEUWGTopFoc90pyHWAVzPqRra29BBc6aZUnaGx+Lc1at+cWtqZFzOe7benq5yXw+jX/RoFqqy0Hzfei2m2Z7Mnz5T8A4+1/5hTMR9lsx5SAmE8E6SjEUqr8VlgUbFUIchmDb3tfkjdNI46EIL+LQV/1t9ojjgMDATao5zDmiza0cHFjvc5+AaY9jyZDE15j/bP+fCzlI2e3xZuVAyqMDqGq/cy96TbW4QytyCm1Q9lzo6znRvMbyaRUm8S6YlOujOan1ueWrZKumTlE0S119psB4kkUrZ1bpI5Dn6samWAXw6aCPig93sSJcBzu6rkI5GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=bbI2vMjqTfvNxkKODAnArt0RepgwbDRA7M1hubQqPsIXeKuckFh8C9CU1cRaub+ELDpmqpb7GlVoaikOSfRIKsD/ychOa8/2tE9FwMq3cFfkf0MurN8RW1deLBUCufiIULw57WJiFXjmO8dkOARSxKZitr512eDEamnPxSp1S+Wsu7ItyIGF+kddCxF25rUGAtLASN0cYSSHvCnFLQh4NSHEKuwjpaTQIG0vg65czrR6411pTODMTv/MExiqVgGz1cC0+mbKKCM9O08ZYXIYJB6ibAa4odFvy6B5SExPUnBaOExq/+n8e9hdeYtBNv3w8cxKj99OjIm8G+uAp8Cz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=NF/oqX7PiF50qAZGACG8i7aCPo1FMeX0GDeZ/yj/MI7bCQnKOl28JBqbfKblbyVMHAo86YZxhf8PQ0hC//YMDImK2b7oqiwo54nAdVqz8mMOe9Wqr/eQXknBpAk2ONOCC95HjWLkPOIy9H9CyHTxkvkMI8/yJOTwJMTGcc1ZQNE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:10:09 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:10:09 +0000
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
Subject: [RFC PATCH v4 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Mon, 17 May 2021 18:38:19 +0530
Message-Id: <20210517130823.796963-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517130823.796963-1-anup.patel@wdc.com>
References: <20210517130823.796963-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:09:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15823ea9-349b-4d6f-cfe4-08d919351912
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778016771A3F04A10F917D08D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYc76wK8qhpqGTrcKR9+vck86bB2eGOnEtx3lYN06bu9i3mQBzQvMza6zOk9iDGZQcpn9m+Zn6PdemKQduO7Y9Cr3YGg/Qtn+oK7s/H3YM85LXW1X8GZrVN0A3WM+DXYBQa8+goVahfuuCHU20VA92DGSUVm4d/9qKOU6f3Xqnm/4pQ2Ehfm+uSchcn4ezvQGCfdo2+MP4LG38IoGoQqJrPWn0KgiDIL9ucRmT9296JjSVXwTgIFG/9J+mO7n+qa7P9VDAt1XGFjW5PrKHjA94a7jmb8M1XBfUFqEnm/Rnt30XRRkaAXKRcafpCxlb16zS+MIuzdI2qKn3lj11ucSWipHvyLZS4I6h6qBH32+Ok7CaajtTOD1ZFqFliLyqLjK9+Z4eooKz/yxmQzV2Rlpa6QLEzULyH+xG40tWML4qqJqf7O0toZ/cpjHAsC1wQRSw270aDAm1M0ifly3ZSlCGKa79trO3MzVtlV78eJXySiqSo+B9SLugq1FzkEW7CSLJzA/H1rllNHShpsyJ4moa2WawbnccLtol2AcZtdkiybtRPDCYlThUcDnExh4RUQDS3I7dRXo50OQyTV1k64tavNRbSx8RyIIBbcVtzidYoWrgJczoomMSgNikveD94FBSLQsce6WYoSGX0kCKWg3gLV9MIgBLdSQjK+0UTfReI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(15650500001)(83380400001)(38100700002)(6666004)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(316002)(4326008)(55016002)(2616005)(956004)(52116002)(7696005)(110136005)(54906003)(478600001)(8936002)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vQi3HD2upGpq3QD46dNSvOAvJTdenCxKtH2IxtoWlbnPU2/tyZMGiu6e+sKM?=
 =?us-ascii?Q?ldsO2H5O2j5XQTNzRTo/qLCpDf7FZ8gCKEF2lxZguT5RUbLlOdH/6tddwIPU?=
 =?us-ascii?Q?YQh/w98dyrhUGuRp54RvkDpSH8UY8uN/neX4n9O2an5sMiLTELrgG+dqQ8w2?=
 =?us-ascii?Q?8leEqloBJGVp0JEl+5v7zn3BvjeGxoM54W65GvPDlE7LFmDCLM7nbu3GkEWu?=
 =?us-ascii?Q?Mnpd9rCP88ztUPPkMM+GipoxehnUISz3Rq7g+QQeCr/oDoYrNYWNHvajmeVx?=
 =?us-ascii?Q?JcP2I36Y25Ifr2lPzh0OYOsrApuMWU3z6utPhEPWxpN1xnPImLesQN93idgZ?=
 =?us-ascii?Q?A01ARES4UkIpzF+1yca+BwOXIOGIav+PKb/RVXdp7a9w1GDLJiKHrJB+cT8+?=
 =?us-ascii?Q?qnWA8cELDITlBb56aycX2fjaSorPXvaKWC4FY7ZK+PnG4LhPfSxRNZ2G3T4q?=
 =?us-ascii?Q?rYuwHtRBLbgdMNCpDuRseF/Ahqr6+5W0xy5XgSeQXLg4OZUdMhiwhygC7c7p?=
 =?us-ascii?Q?fcn3y95TUP1WRx3hfZ1ClDboCiJCBy66d2DkYuoqx7X1zj5CUMnbZLrlYSin?=
 =?us-ascii?Q?3dredBcAaESsaEwPjkJrjVRAW6hJPPYIO6ORZ3ntSibPIi3YhzGgJnqx76aw?=
 =?us-ascii?Q?mt4/39dlcp6gDl9GXOD/J+qILhbQqwWnY2zAkyEBfeBiRPczI7fcOejvEkAd?=
 =?us-ascii?Q?duis5jgud9W4YEVZIV0xzofPfWgzLH6sD8IuEmnM4pptye/8Toj1NQSQGrV7?=
 =?us-ascii?Q?rL/gK+5+dShb8gIMn9ofFp6EEr283ajZENPCqOoTx3T5XsmemBn7Y4RWOrp8?=
 =?us-ascii?Q?7t0luPSgl8RiALx4qUoSfLLJXZsK0NWTArBYVZeXw3TgKDe/2IhQfvC1UkSz?=
 =?us-ascii?Q?l2wNWM5QeTarQMtLs16UbFbI6bygIi9zKkmcbb+w4+ZbMe7c45ThOP1orUjJ?=
 =?us-ascii?Q?fOnQk8FTLkhvbjnGKqmeIjiai1lcsiv83GugmSUfGvMPmi+G3dwJul5P2qUD?=
 =?us-ascii?Q?El6BGwincNZh4V/47rFOdwUZq7JlfB0u+vsQrtWGrUwBhAcz0Cenp17vcDgb?=
 =?us-ascii?Q?eflFVUwYMMt+L9Hg/Wi3oWUmpQd2sUW4SiZLiUCyPaqKM5I1w5qzr0NaVF6d?=
 =?us-ascii?Q?4VCq6hGTW+EO5Qy6w+i5jVByxem4ALDcU4/NAXvTghR1tlM/YnmqqcY+DFrU?=
 =?us-ascii?Q?HT1pXYqfYxDwLH6l6jl83WJyg9fJOCYv/JgkmFC5756/VfKgG7L6l6fEfnaI?=
 =?us-ascii?Q?upWFbxcTdCydbeICUkZSB91P0qkujLborMttN9Yui3kz7SU+AtojrRjvwRks?=
 =?us-ascii?Q?X66WxuTSnEs8UCVS+4czBtAR?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15823ea9-349b-4d6f-cfe4-08d919351912
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:10:09.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZDKPJENpOkLrmtkzkJlbStDlIee4J19QwU320vSKemfqchtxBmQQbFtVmtOTpO/Gwq3LkQ/9USfHpoNN9XgBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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

