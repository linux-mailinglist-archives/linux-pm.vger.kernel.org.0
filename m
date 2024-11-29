Return-Path: <linux-pm+bounces-18216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47289DBE5A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 02:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE665B21BDA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEB8BF8;
	Fri, 29 Nov 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UqlRpglx"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3222F11;
	Fri, 29 Nov 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843238; cv=fail; b=FbZ4E1E1xP/VIa1xZhTP76g/c2iktzIEnsCiZtR2NOidkq4QxbZS54+XsQ6nFgZbw12KQlfq+ff3sN14+J52Ib843YTLHJmAJDDcM+JteHYM1o/vjlnDe1FMZUck8ouZr2sdzRse9IJoGSlFClmxvS9q/nM6W1kCGjB35LbLbL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843238; c=relaxed/simple;
	bh=2h6/+doDSMCE0YKKFc9lVRvOIjj4Xscxpbbm+PdJgag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bBYz45tRpnmZwjPdogQB6jq7K5C1R7RNPtHDjtiKHrXFIINbVTsZDCik/FwD49XdUU3cskzbn8aSytnRjdIhQZYLWXMw/PP5B1839Nj3TiLt3jHaJ5pW8pyMrSLRXxK1hgBuuhyOhk2zWWBGfpwu1lVvlG0xl7W6INvAAYj2Dig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UqlRpglx; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llDmcvv0LzPAmm18veDozXrl51CHLe8wLn7TCq0M8uKHJhX0915ADT/36t2RH2CB22SoKXKEL/oDsUKgVaNHCcVpiaZKpTebd4Y0pYCFFt2za9I3uanAeqlGNgmu7DnszjlOr5hMARyKWQWgBrKPfJyspXCxK3harrcS26IiPFhPWil+KU8MQTDv5SK2R8l2mrPO+kdLA6jtB/y0DPsBNS5o0ZTHOE0ipZ5Md4qgQWfE48xdyrBCofAutD2q1XdSfA2JO3ZWod4sSdMoP+uQMU8YtoLVIvqE6jfJLE7QXIHAUpiO4yWfh429JYOGVpPZR2vlPOql4YKDMJes7iNvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRQ9Zx/kOm/fhA13yibaMpnxaKKzadnkOcIsL6IFun8=;
 b=n8PU4MLkqP4vhkF9CCdsbT7oxdQgcEYxpqVw5UITNSX8hlP6VZaUN/dYx65CBuabU3oEaCIXoQ3knTQ+hBd6KYoD6W9kuz57G+G/UaZMQrgWDauKh92DQ/SD/pZOFZnNmgMH5ZGwoKGugts1bQUOWSf69TosCORdtD7tBNL84Cn3+JELAKaBO+Ej2YQE/XAShuSan5E9sONvIduSlDHsU/JmmBV9cwCOBy30p+NNXzP7XZdyipKE3+Q5Q84DnID9Sc2+H0d2de1VhZjxoWa1Sf2zn22GfSnSwM1mXAN50onGYtBb3dp2fGIqLT2DKnQ/gQmrlv2VeybKDt//8sHRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRQ9Zx/kOm/fhA13yibaMpnxaKKzadnkOcIsL6IFun8=;
 b=UqlRpglxvQ4xYBOH23SUsyzwTlFB4wh8Q0VbknNZ059NUsxopiJ1L8bTAKka0u5R9TjOvU4TGnMv6GZeKPXxN3Ch7NjcjHqz/Ea6Xqs8cQfiDynO3H2Xzxn0iTpIy5lLUCqneoO2OpB9/mHwfyB0gCJoNPQS3ETYZqVCibvq/qNt9kNsU0Nbs9yDpRZrkdXzfPd9heUP7Nxct6IrHDH1Ur31qGm9mfw+TDiYD08hHPKKlCwX1QrR6zDeeOAg29X0DrbFIUcvBQRlr2k5niQsn2Dz8fvCTtM1iQfAkPFJ8mE4fFOxUBf3brtgKmecZavZWrO3W6/wh6pIMuNCneI09Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 01:20:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 01:20:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH] pm: cpupower: Makefile: Fix cross compilation
Date: Fri, 29 Nov 2024 09:20:05 +0800
Message-Id: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ec0caa-1154-4e48-d456-08dd10140478
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w+10AAVWivb6TdfDalZplfTh6yUqbyCkjMsOHfVqVZ5jZN31FknfzWje2J4e?=
 =?us-ascii?Q?Hcb5LeKNIDjxr1beNoAJjZfIeFTkyBMCRxWKPfW+GFUQRqTDk4t71gXUTf2T?=
 =?us-ascii?Q?0DXXLqy4xSiOvS7lmoVQc3Scw3qRHZuWAtY75yWuXm2OuvXUl6ZqHMgYNZwA?=
 =?us-ascii?Q?ZsMhK+PsLceKfWYLxe3U4PVSLY9BiTocpK1tnxIx0Lof5BZlb18VHTFLOS5F?=
 =?us-ascii?Q?68fOzzACTwcl83eiwg6NUIeoe4lsd3DPS14/OkNpxWObfcbJFBP3lLuB5uvL?=
 =?us-ascii?Q?0FuH1rRc2zvvEBv/0J3LvlsErTAILFzSUjrnAZi5HbI8y8j9zatGpEu5/GEu?=
 =?us-ascii?Q?+GjoXWnWS2U6DvuQy0I5CQWfFuvuMomwiUb47+wOmDmrjEmlqHQC1UToQDXw?=
 =?us-ascii?Q?MATBv4wM9DKg+fE/MI1N4Uxr569yyoLm1H9YEZrRCoRJNJB9gL/KMqUIdDln?=
 =?us-ascii?Q?V2d9jYQxumKcFy7h8q9sNmP+ExWn/02PY0bFkPUmHDGwlq45BPNRdgo5KnoZ?=
 =?us-ascii?Q?CV9bom/7rh/RbTEAJ2H68+264F2uGlqUZT5YXoJT54vLNOe57D6RfT6bPgMu?=
 =?us-ascii?Q?TXlz/ZX6WtUEsj9cxGCyut1D3i6Q5ZOViYlUbOuYHYNY9PEuUk6on/Pop1xX?=
 =?us-ascii?Q?yOdRBHm6zz7kbzRXPZS3CpG4oBSQyfC0w0Ki7J0XO8BVNEhUndyCHMmBON9l?=
 =?us-ascii?Q?4VQACo8MfXePrHYM2TTEeplEB+S7KscD7V6iHjXQ95pcauyFD/evoCasbu0F?=
 =?us-ascii?Q?Clml4OUaNDSz+diHF3A6uDNBR8eolJG+PUHNBwE4qMMg33GKm6wBZgC0zo6o?=
 =?us-ascii?Q?GFdJLroJpY21kKY25fmz/O0BOAM72g1JV3MeZZWhaF4FY9xmINAn+pdFJTUZ?=
 =?us-ascii?Q?d8nGGzAL2P2DvtqnD/NOWOq7T1QB5ed8N3jV3nZz/lVyrlqFNq5QHUKoew8V?=
 =?us-ascii?Q?rbgvzm3Ymt5jIfZ8ihMc38Nzsev9rHIOwht9uC2i4sesUmbBmneAboGfu1+u?=
 =?us-ascii?Q?yV8rV3pPHMEiEWq7vCTvrVVdUEZt4HWuOEJvf+Nw11CJ80UFd0xlJyUgmf7E?=
 =?us-ascii?Q?sQnGg4JiBdpguLjJVQmIfDrtDevpVqqYns3LP2rSQnu1kX7uw1VyFC70AL2A?=
 =?us-ascii?Q?XFclgD1KZ03dkNSh7cdwOI2RMAZelQmXndbCRlwDK/2aFZfp43Y5kXME9FdO?=
 =?us-ascii?Q?DZ23X6KT4zReAH7nuM6Fxnnk4KvFMkXAtknhfOSHJN0M4M2zySRdgN9/7asv?=
 =?us-ascii?Q?uEG/pM47XSzLRbmleBci351OR34CITp0BB+P44dHOvs1F99svUMwbwrOsM/Q?=
 =?us-ascii?Q?wFciaT3pLCSBhRal2KFBP4kteRnF9BiOrpdNHWFon/SDB39ZhGEY1bqtx9FK?=
 =?us-ascii?Q?D3XgUGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcGKNAe3SxKQRexRJaoyfpo6+wudPBfc4BODbpI27sIKggngZsE+GFD/m1ky?=
 =?us-ascii?Q?GpcnqE8ORGkzgKAGSL5lgpR4OvW2yPv0CdaaUTUZ59vEeloLlHFrSxI05Ret?=
 =?us-ascii?Q?QSV3+Zvp3A8pf/bdk+wlCOvk2nwR4NgegnnIRZvlJjQq2Xm5FqYoAJhpcWQW?=
 =?us-ascii?Q?hmJ8FzSwCuz3RcL0P1iswMsqOlhqP/oKaOyx2gx1nFfipf+b2ktKzV15OpvV?=
 =?us-ascii?Q?+lDKpKv2+k+PwhA00EI4dQ87pjgEqbJSfsRJ23d/1YbPwmeH7PsN4nPJmM9K?=
 =?us-ascii?Q?/1RpDAO0eqRN756yhTHhXZYyCjqNMi2r44TiZ9Y3TqSH9rnzlSRIN2A3Zc1g?=
 =?us-ascii?Q?/1V5Z1HF/QjX1vaqKqheO9BRzGx0qhIFqVAN/eIvgxVHaYQnCHfqvlHideZ0?=
 =?us-ascii?Q?aOFimNYTrj+o0d8d+Ibrii+jibGJEjSqKKcjfTb46xlsIyGH4wTHZCxHW5jm?=
 =?us-ascii?Q?gsWs0gwnPBkhLnEshA1xPj33Vs/QS0VA3RFyqyflOVbT6yusXIBPnVs+X6wu?=
 =?us-ascii?Q?uW2M5T7eCRwqyz3oZdF2GP66pMb5sy0G0mXKi0Vl2CoDZKb9MuTETAQwByrU?=
 =?us-ascii?Q?OEytuEkbQ00CXdpcSTtgT6J4WeAKlak4Qqr2zqFD3uvDeUqCa62WKUhBkn17?=
 =?us-ascii?Q?edNavvCr2tdUtoAlxzDEA5H03xRhld55D6R5ZadFUcOJQPJmBxt8JZ9W/r8s?=
 =?us-ascii?Q?yN8qY/Of/Kymzkrq7k6fVr5f8U4mNTMZFxk1qtZvoc530lppsuhlLpGoKOWH?=
 =?us-ascii?Q?pZ1LIgQ5bkz2nvoeNSYRDMwy7Cg71yRSq4B3GQrUkKGFHzdh/MVHFEaG4fCE?=
 =?us-ascii?Q?hOofKgQnrdbnLYojddf8OjEMHvduTuJMQS51y7K1dPB72rJszdjgF3DU0Gvp?=
 =?us-ascii?Q?CgBILplSI8NVZzJQ+HcXc0YQIBlB4gvrA2074iPnBW7kApjd0740TzF/5r1U?=
 =?us-ascii?Q?Wn9uHPHHsyu+b9j6+bIw31FezU343LrDPxWu5LqRAQpVq4YlmCfNYhoHJdtT?=
 =?us-ascii?Q?Iz/GF8NkR5LFCo5BSBngap2QHX9dLCZS7ZhtMYPSC0j7drrJN2f7y4/05pcT?=
 =?us-ascii?Q?Uq4fnTPM7f/mC6Lk3CfoloUnAMXH+qEjJ7ogjcNgXJYjY3kbjJb94W3Tj4Mj?=
 =?us-ascii?Q?eeSN/Kl76xTRVG11shviQkkhNeOq/1rtXOtbDeDIuJ2KOTgcHbpRsbTyMEVN?=
 =?us-ascii?Q?g6VRl8XFB/4VtIW7EaxkiKbzuGHFYVUPu5r2LwjIrbCr1cD1HrUuHpwQhkDt?=
 =?us-ascii?Q?r7K5ekraUT8XjVHG2jHCEY+3+aPC83JMvQOJmcZZjbqAGBhgxRr6q/N0jDGm?=
 =?us-ascii?Q?7nrFkWFcdDET9lLGEYpT11iWdxN2YCG1y35bJEZL8VIxPLvpF1PviFKSsmxe?=
 =?us-ascii?Q?GkqUDEaRRBnRw8xiL+vRGsR0r576MlaEKOK9I+MGWJtGFCpCyogVB7T1Q2i2?=
 =?us-ascii?Q?D+xPjS1M5B2VP8oEajsxoDMXlEDU6aaAowDAnjLK7jM9javB9QaKIcO9RqKa?=
 =?us-ascii?Q?8M/+96I8maVm98f7zJvWmIhIPA+f1+TXjiEQKnFjZllerPpx7sNdwuvETVTb?=
 =?us-ascii?Q?AXj9lshit7LpYqLcgR57KWG4yk9N7pt4FlevThAq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec0caa-1154-4e48-d456-08dd10140478
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 01:20:31.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVcJ0i3i+/uYZs3xhT8WXS9fOPslmNfmbuFnMDS3880bXK/wO22B7HxWjJYKiM4BbXre2hD9LacrFg6MGKgF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600

From: Peng Fan <peng.fan@nxp.com>

After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
cross-compiling env params") we would fail to cross compile cpupower in
buildroot which uses the recipe at [1] where only the CROSS variable is
being set.

The issue here is the use of the lazy evaluation for all variables: CC,
LD, AR, STRIP, RANLIB, rather than just CROSS.

[1]:
https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in

Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/power/cpupower/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 175004ce44b2..51a95239fe06 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -87,11 +87,19 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
 CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
+ifneq ($(CROSS), )
+CC = $(CROSS)gcc
+LD = $(CROSS)gcc
+AR = $(CROSS)ar
+STRIP = $(CROSS)strip
+RANLIB = $(CROSS)ranlib
+else
 CC ?= $(CROSS)gcc
 LD ?= $(CROSS)gcc
 AR ?= $(CROSS)ar
 STRIP ?= $(CROSS)strip
 RANLIB ?= $(CROSS)ranlib
+endif
 HOSTCC = gcc
 MKDIR = mkdir
 
-- 
2.34.1


