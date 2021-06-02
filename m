Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91988398810
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFBLZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:25:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27602 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhFBLZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633053; x=1654169053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UeD+FgLO9aIjFzdKrHDcrkqDgbjr4ljOtP7t6+n6Irg=;
  b=KncaxD2uVqPBCWQz38nTJZPAgwqjlNe4IpXG4zXHOCQqYHsTxP0tudeA
   b9dXszD158hE+4TWmcBUIOpMRj4aQWsSIwm11KNasisqL42kkLSUEMraK
   8trJPg3e6fuHxji+gAHlg45qXQ/bQ3mttGusA3BJ3vjCr2YZpcP+urPw4
   aVdq3ULLjq1yNblY5moBd0Rjs21UJwoPqmsjhjkKF6TXJZluWgWQfQmDJ
   I9r5nEnHs94to0Jv0H+g79UypCzv14cGPbEv/6yLzyr25ZrjEVTlMncRY
   eqPLtURVCa0s3/ZUTkConmBqHix9LnVgvR654nIivn0IN5A0FTl4HqtUk
   Q==;
IronPort-SDR: G+CJHrmZB5vJf7zPcqoGAwWpSO7qpZr//jiBHZoZP0bQw79ljtnGcZQn7Smh/gZpeVejqffv46
 AIWnBzM08kn886T+S7gCoqGQYJdrWk2NxMwa1cGxICB0lyyPyf8BeBjM1pWiu3nbUcR208NsR4
 cPipyGquUNbCuqeofMF+QVzO+cyQzr0KRXUKuXD2ARC7hLaoTMU9oF6emztOI7jPn778ulR1GX
 7Tw0qUJu14tnYAX7WY3s9Eobp8a5C65cB9YKftT/gSi0FCeEx2M829QNktMgOXFomjMqulCghZ
 vWU=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803668"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY2kMPvQOJGK/vEjulqgxYhioWAEgvdAWzWb55HKhrSlBuuchyOQOY9BUXq+GydSOWCeBb7xKQCR8k+wVAwgxofW5YguWhGvoSysNM4WJFIc0hr0q0XMDpRpcLbyhrQ2Odez+hvMsJmd+iH/kMa+/4X7OrV/hAxLWYNokJwjIIa+Gc5zcacZ7H6TAcQcdSZEwHyk8ekTr+vv7Ym6aK2BWcJ510lR/tp3sFZQ3BdOu0ETZUA76e2sZK+UFDRaNHnEeS2qdCQGVjBLtRJdHcpbifAhyZeZNNVyzDEcpYvXQjERFlPUAWWJ0m67cUtSvy+5SgwqLRnNGZrb89UCyqkveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=YDaA5oVrcAZZLkOsfLwqOrT7iotgEL8VFistD0jUkFefhIDl4sQQqIAsIVa8w63xMjJeiptDvTSZzHil7m/2J4oHNpIItlC+EWlycPJqjFG4y8JIMYENdUnv338xkr+eYMvCWEYX/ZlhSkYApKLwatdNGb1SZoj7XSkDGFTsHWibCg+d0VADaedOKuTGDQbQpa1hwLpKEJ3BzFt2+PujapHjNxqJYi85UiH62kngqITMlK4wR1+/zrl1lDSSm7OGiJUer7LTSgshgHzbFaJ5s52cQaDHrfNBbNBj5kwgsUVlYZZ7OK3g3N0bRRx9HUjWJH3/rQ8YiAO/0w+qaTO+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=mSKSvLX/zBndIfX7M6aEH/Vp3qJTFn2s0SxT5zImZGnxQiBewZA8quO0tF6bK4eLM9roYGdza4YJ13PXe7kk+oxz7Xski7JTMP0W94sTQz58segKWQvM/ecgj+gFO6poU92BegD/92m0paN2MGAE9kyJmxZPvuSntmHGaeCCmKE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 11:24:11 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:11 +0000
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
Subject: [PATCH v5 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Wed,  2 Jun 2021 16:53:17 +0530
Message-Id: <20210602112321.2241566-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602112321.2241566-1-anup.patel@wdc.com>
References: <20210602112321.2241566-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.70.115]
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc11eafd-2c6c-4af4-0e49-08d925b8f187
X-MS-TrafficTypeDiagnostic: CO6PR04MB7810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB781034A6F017E612B86CB2AA8D3D9@CO6PR04MB7810.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogWrtfxecAqvTYKcVyfOWma9+ZR5JwVuQPVfioUBxVds99Q4m7i3Bma8pXGyPsDmmH7PQdQ9nocLKriQOIDLDKkZN/RKEzXqucPNobCZ/zwpkCdHre9J9Ghyds7NHo+EiA0i5ZJcx+/2ttQ0m6gmLbFi3HZb2DLUXwMZbgj5i/6I0HWPVkJXy/kHkakCEkyYKo7AZdOfM0TGCuBo2+9H4SyDH0eujcfFMYPedSZ/h8/TyAFfJDLpCnrEJ9knHU89gFm3ok4pMouGKyjld5MAOZxUMPBjLbB9T9Tup72H979iJCNrVZ2JO9fDDd/tVRKOvU0qrjfwAAm6fOI8k1htKYYbzVLDvQYQbEWd+tVDVYq9Y5BN4myCNlMaxbEjPmpiRfSKKn/szZobnEFNc1acJYWXfgpr3xZ+DCj3epgazisdgKqJdZ2Bgp/86+DMmCV6u7xqJvFdrHOeNoKAXaRtEFGgnB/St+ypXoOFONnGqqkqxLHS5nfgQqct92VcZoUSOcnfdZKuDkUMVZ9F1Xn0BOH7PfwOgzuGkcFMLXlnJWtlEtbOpF4Cbj9HaCEDYISL18SzAP5owqAEkUnmcyLsczC8AUZPnbnbPEpAGOqI+bO0gFEhmQm/uZXE5frXNQTIepp5n0+e10vuy8KVnmTzEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(186003)(16526019)(15650500001)(7416002)(8676002)(6666004)(86362001)(44832011)(4326008)(8886007)(2616005)(478600001)(956004)(38350700002)(38100700002)(8936002)(26005)(110136005)(316002)(1076003)(5660300002)(36756003)(2906002)(54906003)(83380400001)(7696005)(52116002)(66946007)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0zJk6mhigDG0Z+Be+jjEmJ3Yuj/b90/v/CS3zkAQnvI5DERVsqLmv9NnE2Sq?=
 =?us-ascii?Q?kyKJlXojuS6+oDxOPlJudWKjrWOflhi+BNmp+WBhxDfnCBbeARenGQnk5iT6?=
 =?us-ascii?Q?fbFXkfsDRqzsG6mzpKdds1Ca0ROQJO31hjBm06SKFWHNWJASZd0rA5ZjNUcz?=
 =?us-ascii?Q?lWTbhvIsXB7iWr1cheYZ6R8UPNxTyz1vou1pbp8RtWjvsvkzoTFYxh3YtHAI?=
 =?us-ascii?Q?GM4frTVTNNXdx/GeFxsk5jjDnF+aUDCDk1ybWq6iWA3Y04uiQfhpUCYlwH0O?=
 =?us-ascii?Q?59Dzcegd89wgvsK7OwWa7T6I6SDfjROigZAuXJ4P9f9q1f2MsP9Y33Xpx9AJ?=
 =?us-ascii?Q?CU88BWSIPLlyf6O+HELyuv4w0b8Tu6OZkMmSzNkar3Foxt2B5v4m3Htf5l4m?=
 =?us-ascii?Q?rYP19fOuffEucp6cJJIiGimqerKy1/9GMpJdQbgqw66etpNsWO+HPmx4HYlr?=
 =?us-ascii?Q?Zun8rfxQyxL0HE8agmb75m/2APkLAge14WiAAkk6TOCmjaMp71x3gzjJyCop?=
 =?us-ascii?Q?W5zdcSC7LYhG+wqn9VJln+WWMfKbcNOjHHgCZLjgIb+k68Gdy67UT7pHj2du?=
 =?us-ascii?Q?0P2dIYit7mopFa6Sg8esVzRadRNuqQFI8l22um2WAzBJuDcOQzYdPSTpYhm7?=
 =?us-ascii?Q?3u6M1dWuPrft9GMWrukxFqpfKlnjQjl4DelFev7pL2SgDL+YVcuiRGO6vvVJ?=
 =?us-ascii?Q?IzDtBVNcWrIqvg/zXptlSjeA+6cXVAXcTBWvgEVf1HVnsR9MQB7g98LwqR+B?=
 =?us-ascii?Q?JKmw3dk7gWoHSJCxi1jZOaV/g7uaLCAD+ZMNxK7bxGIdfSNpxv6msmaR2JC1?=
 =?us-ascii?Q?VpvTrndya+YDrLD/25dC37d8QjImUpZ9Q8Kh5xkqvNDXWeKwOlVZ7UoIdA3i?=
 =?us-ascii?Q?m7Gx+2w/nysOuZDaKixNrK4biqtjHWSjBrVjskweZhwqd1RZu2TQ68gBL5iV?=
 =?us-ascii?Q?hu/4htp6sKwQMkZ1pgzwQC7gMEDIuo9zAq5axt9Fsn/3maY65x6iCJjG2AzS?=
 =?us-ascii?Q?tMJHgsOOHzhTJmw7oAKLyGAlh2FYex3yZgQp3zMTx2KAV+IMR5kX8K8VjiS0?=
 =?us-ascii?Q?UJWQTEimnViDrxiDQUEehfYb14UMDAhAmdKY0FMZCN8Yab/u0j/O58XjToLS?=
 =?us-ascii?Q?tME3j7/HfSe2euAJAIMM4QyoEB2oYTqL0PPeeB65gFl2wcI0aC3ObjaL8sh/?=
 =?us-ascii?Q?I0bHLjph0dYWbEDdbxqrf0bm/OjR7fxODahpPWUHzV6e8445pTw2sLdc0CrR?=
 =?us-ascii?Q?36wQdVPW7p6ZqYb7EPeEcopTAYqDrCL8XjWtm2rQSLWxi0U3lu+c9rLZ9IE2?=
 =?us-ascii?Q?k/R75aOok7295jdXiuTV5DPa?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc11eafd-2c6c-4af4-0e49-08d925b8f187
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:10.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fZf8rg1C2oP1YFWCydLe5WO0VpDM9iu+p4iwS3IPJ56qeL3XI7qlmpI2GXGSgPyQ5OTDAJ1L2y1x4MJgeSaTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810
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

