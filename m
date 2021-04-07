Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE1356E0C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbhDGOBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 10:01:32 -0400
Received: from foss.arm.com ([217.140.110.172]:57702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352734AbhDGOBc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Apr 2021 10:01:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C31D1FB
        for <linux-pm@vger.kernel.org>; Wed,  7 Apr 2021 07:01:22 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0D83F792
        for <linux-pm@vger.kernel.org>; Wed,  7 Apr 2021 07:01:21 -0700 (PDT)
Received: from AM0PR08MB5057.eurprd08.prod.outlook.com (2603:10a6:208:165::33)
 by DB8PR08MB5068.eurprd08.prod.outlook.com with HTTPS; Wed, 7 Apr 2021
 13:59:29 +0000
Received: from DU2PR04CA0329.eurprd04.prod.outlook.com (2603:10a6:10:2b5::34)
 by AM0PR08MB5057.eurprd08.prod.outlook.com (2603:10a6:208:165::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 13:59:27 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::14) by DU2PR04CA0329.outlook.office365.com
 (2603:10a6:10:2b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 13:59:27 +0000
Authentication-Results: spf=pass (sender IP is 217.140.110.172)
 smtp.mailfrom=arm.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none
 header.from=arm.com;compauth=pass reason=100
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 217.140.110.172 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.140.110.172; helo=foss.arm.com;
Received: from 64aa7808-inbound-1.mta.getcheckrecipient.com (34.249.187.16) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 13:59:27 +0000
Received: ("Tessian outbound ee4b51dcee79:v90"); Wed, 07 Apr 2021 13:59:27 +0000
Received: from foss.arm.com (217.140.110.172) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 13:59:21
 +0000
X-TS-Email-ID: 43bbdfb9-eb70-4349-b453-383bd675d1ec
Received: from 6c86eef88602.1
        by 64aa7808-inbound-1.mta.getcheckrecipient.com id A15F35E6-A0A0-45ED-8896-BC69C94D4E8E.1;
        Wed, 07 Apr 2021 13:59:23 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-inbound-1.mta.getcheckrecipient.com with ESMTPS id 6c86eef88602.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Apr 2021 13:59:23 +0000
Received: from AS8PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:20b:312::6)
 by AM5PR0801MB1793.eurprd08.prod.outlook.com (2603:10a6:203:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 13:59:22 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::fa) by AS8PR04CA0031.outlook.office365.com
 (2603:10a6:20b:312::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 13:59:22 +0000
Authentication-Results-Original: spf=pass (sender IP is 217.140.110.172)
 smtp.mailfrom=arm.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none
 header.from=arm.com;compauth=pass reason=100
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 217.140.110.172 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.140.110.172; helo=foss.arm.com;
Received: from foss.arm.com (217.140.110.172) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 13:59:21
 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F451FB;
        Wed,  7 Apr 2021 06:59:21 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E8143F792;
        Wed,  7 Apr 2021 06:59:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3] dt-bindings: dvfs: Add support for generic performance domains
Date:   Wed,  7 Apr 2021 14:59:13 +0100
Message-Id: <20210407135913.2067694-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
X-EOPAttributedMessage: 1
X-MS-PublicTrafficType: Email
Content-Type:   text/plain; charset=US-ASCII
X-MS-Office365-Filtering-Correlation-Id: 09f4bf22-294e-47e3-c274-08d8f9cd5bcb
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1793:|AM0PR08MB5057:
X-MS-Exchange-AtpMessageProperties: SA
x-checktessianinbound: true
MS-Exchange-Organization-PhishThresholdLevel: 2
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?F9tnMlVHhEdzBNh2tVlU0tB9HILMFaiH23LYZvs7AWNUuwg/rEBnt2e8Dbhp?=
 =?us-ascii?Q?9NcFvKByNNkS/efCGxccsElgce62mm41D4VhjNoz6/0qWsokc9nryUPUkh2t?=
 =?us-ascii?Q?V9AtOfOSp5Q6ZgDgUN5zFBUDvGa6TPpolRraTDTfjHn1GUF70TS5uD9c2r2l?=
 =?us-ascii?Q?I9dVFFkNjU70TUby7Ft8dGkXiI0Yfe4IgGnKDsG0BWJffZqGHDs4CmIn2nwq?=
 =?us-ascii?Q?PbJpxJyUu1Yqr6LZaNURVIO161qLVwzx2Qy5hT2on9kYtEQ24GJNjKyOGG4D?=
 =?us-ascii?Q?ymD7YvKY8oOrpwLwLWO8JSEGZ9q/ITl0bHSkL0HqtIoyLrW4HeFu7wb9Eiwc?=
 =?us-ascii?Q?pvqWmDWLPdP8TYtycuHomtO+pi4YRbbx0nrrOUdnJoCjJWHsk+MAco+Fhs7r?=
 =?us-ascii?Q?cS0bhNdiY+EkvO/f5OvxugPvsO4cxIXNulVwwg2vmojyjZkMZOQR6HJsSrNL?=
 =?us-ascii?Q?7aEEfyIkh6BYfS/4D8cUKWSEAgDgId49/3zR7qbcUi3GwWBi9GAQyFO4Oi5O?=
 =?us-ascii?Q?5o9SsRN4zCJYwBKz/u4mChmo3q8cHoQOfOKQe3wXPi7Jf7i+kGo6t86QFTTG?=
 =?us-ascii?Q?AL5siOMV8axANLpSKjc25N/qZoHRrGzC17TreZvXNYRImGBmN+wmCVnp4rYy?=
 =?us-ascii?Q?MsmdE1x4vqjZ4LjqqLcIZeFRYqk9dzolK8MkWbDYgQ7k5xLHNDFiPmIGIqpn?=
 =?us-ascii?Q?xX0FYtlJAHEf2bZhK53as+8XUlBDZh0fg12ncPsCVZ8SfOAWPK85s9vDGWRW?=
 =?us-ascii?Q?N7mZQRwpeGMMDe6DQ9QKQtQRZvi0n298AKlpRaVVUcU8UhOC8iWOffrkUVJt?=
 =?us-ascii?Q?AK8FlW3CbU5NiIXf1v/C6kR24yzs2gMY3Z+NhZ/IfetaOLL9K/KxzSNRKQkZ?=
 =?us-ascii?Q?PZQVeAixLw3oAaWyx2Js8aVWWHbgHtrcQB5P8rmuKBZ+KPirYlwCJruiSKQX?=
 =?us-ascii?Q?0cHmWLVzJsz5J3b8/SXmopibiBD8GZT9t0b+tJIHY4nMSJwQ62upoP1HKV6/?=
 =?us-ascii?Q?ohjR3s+SQgnqsPxRFIRGRYs1h1sRSc7XgeYkzqvunaGZlzvMoo1RmeHh+Wln?=
 =?us-ascii?Q?nCvVcnFj/T3HxkFQqfoL0lsx70ONgzydOPv9SwT+LnLN3wKKP7hpmwD6z6rr?=
 =?us-ascii?Q?oSnpJLKkj+qJ?=
X-Forefront-Antispam-Report-Untrusted: CIP:217.140.110.172;CTRY:US;LANG:en;SCL:-1;SRV:;IPV:NLI;SFV:SKN;H:foss.arm.com;PTR:foss.arm.com;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1793
X-OrganizationHeadersPreserved: AM5PR0801MB1793.eurprd08.prod.outlook.com
Original-Authentication-Results: spf=pass (sender IP is 217.140.110.172)
 smtp.mailfrom=arm.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none
 header.from=arm.com;compauth=pass reason=100
X-MS-Exchange-Organization-ExpirationStartTime: 07 Apr 2021 13:59:27.6617
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: 09f4bf22-294e-47e3-c274-08d8f9cd5bcb
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-SkipListedInternetSender: ip=[217.140.110.172];domain=foss.arm.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[217.140.110.172];domain=foss.arm.com
X-MS-Exchange-Organization-SCL: -1
X-CrossPremisesHeadersPromoted: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthSource: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: arm.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 72ae5e7a-7263-467d-83a2-08d8f9cd588d
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:34.249.187.16;CTRY:US;LANG:en;SCL:-1;SRV:;IPV:NLI;SFV:SKN;H:foss.arm.com;PTR:foss.arm.com;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:59:27.6537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f4bf22-294e-47e3-c274-08d8f9cd5bcb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[34.249.187.16];Helo=[64aa7808-inbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5057
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.7842942
X-MS-Exchange-Processed-By-BccFoldering: 15.20.3999.032
X-Microsoft-Antispam-Mailbox-Delivery: ucf:1;jmr:0;auth:0;dest:C;OFR:CustomRules;ENG:(750129)(520011016)(944506458)(944626604);
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zl60HDzEmq3mcz9F1V+6hVNdKk0uiMIR6lrSeIqMqBIvmue4ML1Sk9zrZh?=
 =?iso-8859-1?Q?Hptq8RXIzL2uVB9CUNd5PVuVYqotlJFYCfKcN2d3q6BcB0K2Oe2u+xydxq?=
 =?iso-8859-1?Q?pSKFHH/ePxBLyn6JwgiBNb/km7ySlkMFbGppTHydI8Ri50gAQyuB0U7IWy?=
 =?iso-8859-1?Q?r231JFnOwHfZGB36kUgHZnFfCVn3HiJbUz/4qn0s8LK/E0OOaEpdoUAjnF?=
 =?iso-8859-1?Q?rt4k3FUdnr92ipb0w/RKJf6oKWQ5kYSzLdAs3GGUnHg/IDVdFGy4EGXYYv?=
 =?iso-8859-1?Q?XeCm/LGenyfv+iRfwIgZq5MwnSS68INmYZ+KuAMyfl0e3r1Iv0S0yTyixV?=
 =?iso-8859-1?Q?MgoVy5FVSQltOZc1iU7UxivwGLV64cRuScMWtYd7Zm3pI5zeEKv3hPrsfR?=
 =?iso-8859-1?Q?fuj3qDDwTm0Q8vxhjItbVw173PQw6sqgX9TWOwstJZBzK10X0OOpqYtoD2?=
 =?iso-8859-1?Q?u7OaNjI5EgxzwK+pMYdWPgPCrZfDie8iVYg1/JocpbOFNResrM6SxzXJWY?=
 =?iso-8859-1?Q?FvQt/2A56L74n3nLTw6jIPu6NeTxySUd/nkWeWLCwHALr+LQ8sU3VQTsMQ?=
 =?iso-8859-1?Q?UewrMD8kY/qqrNTm+ENI0SyB4VZkXeZoXASGS4AV6VF7eJcmLdB1ewkjDA?=
 =?iso-8859-1?Q?66r+z8Nv+IjsaFLjnqMN0Lqgj1u9SQmpJpUY6pQEydGZS+CVLgfYGtWHtz?=
 =?iso-8859-1?Q?WUQelhFDfvZ9rB8NWkd5/HkWozj7f5vksviEr6enQZOaUQciB6/2jx6dmQ?=
 =?iso-8859-1?Q?7ylVxbNyeMmA3J92WHRnVoT7eN9I6nonxOzFEbptGx1vRhTGA3DCcajf/L?=
 =?iso-8859-1?Q?eoDOvp+vH5oyl+OP9yhzwLpNs/IofXQHmt9zXx/Fm7JP4FP3HiUEDMM24s?=
 =?iso-8859-1?Q?jQAThYUWs9ihYGv6b4/USjGC1yJ43Q1uGoT47jkv8FOUyGDk4bUtdvc3Ew?=
 =?iso-8859-1?Q?7FBnxtSYpLvUYTtYSmdjKS6/8FPZYqPY8vK71Y1kLYLRBr3VKh5TlMzHqX?=
 =?iso-8859-1?Q?6/FW5brANNurjglZGPMattwmg2zkFjXXP7e4IzYHD4Fv2YYm+d0BqI6ELf?=
 =?iso-8859-1?Q?Bumgr/QDqByDFh/TWuVfPMTDX2edpArHOWei0A4UNM9IBwZPv/5Ks0Xrbq?=
 =?iso-8859-1?Q?r46hwA3AUaY4VLNEs3sGlFmkm5WEp6nD45h6kg8S6o8FAPrhiQjB9aCDNe?=
 =?iso-8859-1?Q?Vg6hif+yPUswkg=3D=3D?=
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CLKSCREW attack [0] exposed security vulnerabilities in energy management
implementations where untrusted software had direct access to clock and
voltage hardware controls. In this attack, the malicious software was able to
place the platform into unsafe overclocked or undervolted configurations. Such
configurations then enabled the injection of predictable faults to reveal
secrets.

Many Arm-based systems used to or still use voltage regulator and clock
frameworks in the kernel. These frameworks allow callers to independently
manipulate frequency and voltage settings. Such implementations can render
systems susceptible to this form of attack.

Attacks such as CLKSCREW are now being mitigated by not having direct and
independent control of clock and voltage in the kernel and moving that
control to a trusted entity, such as the SCP firmware or secure world
firmware/software which are to perform sanity checking on the requested
performance levels, thereby preventing any attempted malicious programming.

With the advent of such an abstraction, there is a need to replace the
generic clock and regulator bindings used by such devices with a generic
performance domains bindings.

[0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang

Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
Cc: Rob Herring <robh+dt@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---

Hi All,

Sorry for the delay, I thought I had sent this out last week and it turns
out that I had dry-run in my git email command and never removed it. Just
noticed now looking for response for this patch on the list to find out
that I never sent it out :(.

v2[2]->v3:
	- Dropped required properties
	- Added non cpu device example
	- Updated cpu bindings too

v1[1]->v2[2]:
	- Changed to Dual License
	- Added select: true, enum for #performance-domain-cells and
	  $ref for performance-domain
	- Changed the example to use real existing compatibles instead
	  of made-up ones

[1] https://lore.kernel.org/lkml/20201105173539.1426301-1-sudeep.holla@arm.com
[2] https://lore.kernel.org/lkml/20201116181356.804590-1-sudeep.holla@arm.com

 .../devicetree/bindings/arm/cpus.yaml         |  7 ++
 .../bindings/dvfs/performance-domain.yaml     | 80 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 26b886b20b27..98590a2982d0 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -255,6 +255,13 @@ description: |+
 
       where voltage is in V, frequency is in MHz.
 
+  performance-domains:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description:
+      List of phandles and performance domain specifiers, as defined by
+      bindings of the performance domain provider. See also
+      dvfs/performance-domain.yaml.
+
   power-domains:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
     description:
diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
new file mode 100644
index 000000000000..640e676ed228
--- /dev/null
+++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dvfs/performance-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic performance domains
+
+maintainers:
+  - Sudeep Holla <sudeep.holla@arm.com>
+
+description: |+
+  This binding is intended for performance management of groups of devices or
+  CPUs that run in the same performance domain. Performance domains must not
+  be confused with power domains. A performance domain is defined by a set
+  of devices that always have to run at the same performance level. For a given
+  performance domain, there is a single point of control that affects all the
+  devices in the domain, making it impossible to set the performance level of
+  an individual device in the domain independently from other devices in
+  that domain. For example, a set of CPUs that share a voltage domain, and
+  have a common frequency control, is said to be in the same performance
+  domain.
+
+  This device tree binding can be used to bind performance domain consumer
+  devices with their performance domains provided by performance domain
+  providers. A performance domain provider can be represented by any node in
+  the device tree and can provide one or more performance domains. A consumer
+  node can refer to the provider by a phandle and a set of phandle arguments
+  (so called performance domain specifiers) of length specified by the
+  \#performance-domain-cells property in the performance domain provider node.
+
+select: true
+
+properties:
+  "#performance-domain-cells":
+    description:
+      Number of cells in a performance domain specifier. Typically 0 for nodes
+      representing a single performance domain and 1 for nodes providing
+      multiple performance domains (e.g. performance controllers), but can be
+      any value as specified by device tree binding documentation of particular
+      provider.
+    enum: [ 0, 1 ]
+
+  performance-domains:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description:
+      A phandle and performance domain specifier as defined by bindings of the
+      performance controller/provider specified by phandle.
+
+additionalProperties: true
+
+examples:
+  - |
+    performance: performance-controller@12340000 {
+        compatible = "qcom,cpufreq-hw";
+        reg = <0x12340000 0x1000>;
+        #performance-domain-cells = <1>;
+    };
+
+    // The node above defines a performance controller that is a performance
+    // domain provider and expects one cell as its phandle argument.
+    gpu@2d000000 {
+        compatible = "arm,mali-t624";
+        reg = <0x2d000000 0x10000>;
+        power-domains = <&power_devpd 2>;
+        performance-domains = <&performance 4>;
+    };
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu@0 {
+            device_type = "cpu";
+            compatible = "arm,cortex-a57";
+            reg = <0x0 0x0>;
+            performance-domains = <&performance 1>;
+        };
+    };
+
-- 
2.25.1

