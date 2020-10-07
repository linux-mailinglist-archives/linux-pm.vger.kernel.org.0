Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7F286952
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJGUoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 16:44:32 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:29856
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbgJGUob (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 16:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8djkwKsRo9jB1r85muZCKyv55RiWZRAAjLm3X5X4YSlZ2Gdvhlt8jBeFq3mXAGdb46tSXpYFtORkTQGoqKloUhWBscPhnkb255z7DSstCMt5VsyN0WlJ6vvdEOFjLw92OnN57TYKXB/mvQP141UzuwENn2wWp52abeKKKtL5Vo/f84Za25nBH7CxtxTnT/0YzjkDnMEmzeJFJJhZXMwlf58jwOAgO8SVyiAuy9rc0m3R7gn/oUoY980GioJHaUpyVn3qRG32a0311aw3E/rMxl4uKxiBoCtuukb5SDdSEupLlhh8v/qLDOi3bAAnD7bMBfWmcOpEi+ZufKLU46klQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVq6dDkJSgOws3iXidiJkaNFQipv6Gu9G2wD4qkgC2s=;
 b=O4QqCNNnFdtMP+qjST7O3IXMSb4leOyBnEEc37tRGYJX2kkf0KBrfEoauqYbd0fU9vjFAzZjrhoYWu20uQYYaaoMcbwTOJCP4apuFpBYNU45FBcfRPjddYrJ6kPquHtcVFOQHGorUgsvJTKA/nE0m6ir+og+ysOx2JZt9PH4bzQtB/v4VTU/eNXjK9ZGEqF33Y0cMmtDWAAiPgaRfrNg2JocMLlRdE7SPfIftZU1tbkeH3oPXYTnL4U/NY63qaif4k0M4dV/sju1UzkilI8+zAuGneN1zzy18wxtQEA4/C11nyBePDjxFLbPNwpaVILr2HpY9K4sDP2qUsOmNsJfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVq6dDkJSgOws3iXidiJkaNFQipv6Gu9G2wD4qkgC2s=;
 b=0j91gKfvmEJ/Yhpg+vPdxC8n6Ffbb4/t0rSj98LAWi87NKSXqn94oyqT2uvzm89GYK9rwPtd7lWsdtoW6ybu//YRwQ0Ntx7ycDGCLhimusdVDCzyFxoqUIqmrY80Cn3V4MttsVzYTFy87Oj8LgLhtUyVB2p4FRJilYvgZdNcubI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1351.namprd12.prod.outlook.com (2603:10b6:903:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 20:44:21 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 20:44:20 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, wei.huang2@amd.com
Subject: [PATCH 1/1] acpi-cpufreq: Honor _PSD table setting in CPU frequency control
Date:   Wed,  7 Oct 2020 15:44:12 -0500
Message-Id: <20201007204412.565881-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [24.55.15.93]
X-ClientProxiedBy: SN4PR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:803:2b::22) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.55.15.93) by SN4PR0201CA0012.namprd02.prod.outlook.com (2603:10b6:803:2b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 20:44:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05d21643-a154-4bb3-ecc7-08d86b01c453
X-MS-TrafficTypeDiagnostic: CY4PR12MB1351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB135153B6BABFD32340538510CF0A0@CY4PR12MB1351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TCJSlsmPPjIPganJwgAzzcNAY2ZNPC0TlVPlZa0BKpimlFLhfAJMeg3Gvkb2JkKhsh3KzVUhU7mjYgx/ad4/LCsf8zkJPQR90yhEdqiQnR17tXmgzUakNesFJ8mV+zSRtq/lJg1OEEv2KsK+oMp++hck4pOzgurKfN8GhpToVnsZ84qdxRMGbVqusxpGm4wzPwmHGrZoeHb1ia+n5GYM6XyCmBX3ITAPFypD9RXM2Y1Cu1aKSafOJ4tIrpZqTdyF5hdz5R7N+8/xlv+8g5DxzNILb6Cv+HbkTOXI3YN5kG1dMQiCtRfjrtTvRk8JlKluC0p1nw553fnJo6lwKO+aS7iPrud00wVSnB3xJVnYqDew0fRUIdNhywZO3kxIDOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(16526019)(6512007)(956004)(478600001)(26005)(2616005)(186003)(8676002)(8936002)(69590400008)(36756003)(5660300002)(6506007)(52116002)(1076003)(66476007)(316002)(6916009)(66946007)(2906002)(6486002)(6666004)(4326008)(83380400001)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AoGP8l5OuLKpQeXIIzTMlK9X1jxWgT5r8RanroCTbzVXXIkMyQgEhA4ZPp7jixM0ltVKk8W9vBy5BilMM9lzJFe6Kub+lGGoL+8Yjo/PMVsu4SqBql1T96gg++ugRRMBIqn7i2lbYan87y9bmbO6ZHbx5fx//PyV4NsBL7JUD4uGR6bytymeWnEmrb2W22+YBqFPF2Fz6yG4DL6VXIIwZVLt6+3nK+h+3/gM3vV15IkwLtyV7GWyZT2o+FGB2S6Ua7hzLAlVUMf2eBbdUCXTMWWKzY+0VwtEoTmbTrLAbJe5GS5Bs2MF/hvANyGpiUR9OwqLLspC4HZ0nBG/jCQyWpbCG1XaA5OQf8py3zwYEjv2UGJrBmHuFXrOn5+Mh3ypEkLPhxQ569Ixuy0hfZK5fm/lLg7DvhsNdZQ/5qSCZxagoidvM6HRYmd3pdQCoX7s93ukQKDkTssJ3KKRhYaKveSW+02t9jyaA0TnY1JREwrf46rKLWTnbXjL20z40x32+WXJqod0nN5DPEzzUNVvKbJZNFOg3kPOqACDqTiDSh4IN371g87vLwD1G+nurVIWyLfJnMd2WUfd3eWXSv/07+32wthiVH2bMsVrT3Fgkrwesq+B8tstrH8JhBBEPFsahH11rkY/PBVhHEuXLEYlCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d21643-a154-4bb3-ecc7-08d86b01c453
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 20:44:20.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfA1ZmJYWGQlbmt/jdxVe0mbXZymznlr/BzGUJvODWXfZpcNIgmCl8Y4DtTmwwHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1351
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

acpi-cpufreq has a old quirk that overrides the _PSD table supplied by
BIOS on AMD CPUs. However the _PSD table of new AMD CPUs (Family 19h+)
now accurately reports the P-state dependency of CPU cores. Hence this
quirk needs to be fixed in order to support new CPUs' frequency control.

Fixes: acd316248205 ("acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs")
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e4ff681faaaa..1e6e2abde428 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -691,7 +691,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
 	}
 
-	if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
+	if (check_amd_hwpstate_cpu(cpu) && (c->x86 < 0x19) &&
+	    !acpi_pstate_strict) {
 		cpumask_clear(policy->cpus);
 		cpumask_set_cpu(cpu, policy->cpus);
 		cpumask_copy(data->freqdomain_cpus,
-- 
2.26.2

