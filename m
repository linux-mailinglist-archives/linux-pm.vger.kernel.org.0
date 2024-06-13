Return-Path: <linux-pm+bounces-9110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47DC907AFA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F91B23CA7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D114B06E;
	Thu, 13 Jun 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jd7I/ugl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EED14A0B9;
	Thu, 13 Jun 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302696; cv=fail; b=bGZYh4Dq1ZYrPWrcFyaHcgkiKbkVLJ6XRe2s5dow98Ty1o0MinK+Uzq+lMzSGqcyoBs65wH3oKSbvKo43b1tavHlfbNWcOHVEa8ZYkeY1v2bwQ9+K5C3nRM+zUMvf+LcofCPbqesstS/FeNyq0iUvuCC74CV92mSn8eCTxYSLNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302696; c=relaxed/simple;
	bh=KpfdWXnHeZxsIgJZ9+KAoccZ5YC3f2WkIT2+neeu/UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMcfRjxkjkluEaylgg0yhb1nTkH1o4KZQ/IVv+bvnU/C1lgGVw7yqqjoqI1U5nIJq2J/nIpbdK9BhOidK+AbfZuX8gYMXb9azXcaGnl8rUjUvxlVUNb46pOn55KK2CE7wdGRJTUMkXXnMYFqjm5rghnbNreSqr7g591ukDwoopY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jd7I/ugl; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPH+Sjp+xmOfApZ5ve/AMxPD0/W5Nn+itQ8SLqEjSyZZcQW53rTb+C/etkxqICquCpeD3W/sHt8SAnJuS13Pa6As9FQaaLX0Rx8Td9/elGJhV+zlnZoHHPi0oHU3AjAQAUq+ugJSSu1LWgMb90Cx0aJkAfCkSL+ImTzMoBHNoFpQGv9fwTfPWvOwb12j7egVfqoFjUfBRUstaNQnyjVEuVAdskmA7CE24oIjDYheoU9inUWWs8TrDoSIOZSdDkcMFC+aWSDarcwyj3IwORjbbfuJKt9m1IQHspQqoyPdb8RdMl78oc10Av36E+Y46okcOTorR24O/mgl0ec0nzEEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuUkCb+5GRVurK0poTyH+PXtw8jDpAelqX9rR/ev7Uc=;
 b=gk7Y/dhLDyb8ZFceebxvG/geg3RWRMNjnkkFJNp+487siZJrDK0YHl9FFBD/aJattdcLTl7H42QyAu0wAAriIKCQ2tqk+tntWWfPPBhncsFEzEKbumsEt3mbh7FVKR3f7968vbmBxqmnSxuafn7N/8/iJdATNurmaKz4FF8VQTwGwFMVTG/nAdWrxe5JWmYGFEicAJE3kRoMhvs45bx1w+Bh/VGzETtd0+kyNhRNgLdRgpxyeBfshWEY84pOLdFZXkZiKU1YYt8k/2z4kXDnItaEqxMUn3+NFrRVvCAScyRHp9UGAs6sxzoo88/XodEy5V5I7BL2IiOrFQO0FNFziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuUkCb+5GRVurK0poTyH+PXtw8jDpAelqX9rR/ev7Uc=;
 b=jd7I/uglRW1iAA9f8a0MO9wm/DqnQUWkbIhcxQHUqvm40K+FOWZKlIqJxyjkxZfm6I7tIX+RYFbeDbDnjbKXKR8YSOQckpicWWgBDWDSMW8dhfmTkb8r11uIYVh6RCnUjfkuJjEEVvyYjK6qopn4vpVH3EMWD9WNFff3XuhqK8s=
Received: from BN0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:408:ea::14)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 18:18:09 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::7f) by BN0PR04CA0069.outlook.office365.com
 (2603:10b6:408:ea::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:18:08 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:17:46 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, "Michal
 Simek" <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn
	<jonas@southpole.se>, Stefan Kristiansson
	<stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
	<deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen
 N. Rao" <naveen.n.rao@linux.ibm.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Andrew Donnellan <ajd@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>, Frederic Weisbecker
	<frederic@kernel.org>, Xin Li <xin3.li@intel.com>, Kees Cook
	<keescook@chromium.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Tony
 Battersby" <tonyb@cybernetics.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Brian Gerst" <brgerst@gmail.com>, Leonardo Bras <leobras@redhat.com>, Imran
 Khan <imran.f.khan@oracle.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Rik
 van Riel" <riel@surriel.com>, Tim Chen <tim.c.chen@linux.intel.com>, David
 Vernet <void@manifault.com>, Julia Lawall <julia.lawall@inria.fr>,
	<linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-csky@vger.kernel.org>, <linux-openrisc@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2 02/14] sched: Define a need_resched_or_ipi() helper and use it treewide
Date: Thu, 13 Jun 2024 18:16:01 +0000
Message-ID: <20240613181613.4329-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613181613.4329-1-kprateek.nayak@amd.com>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 5640cdb2-1321-49a4-a03e-08dc8bd52d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANnbjwEP9CPzsmHtVJeYQc0b/tt2IoGpFyXZK8e55+ceLrV0W62PAX8w3K82?=
 =?us-ascii?Q?0BIWZ7dNjubp8K/zQVrG5nYZx7ML5n8coeyl31bs4slka5+21EWAINEJ3anS?=
 =?us-ascii?Q?x6QoJhEOHug31+GbImsp3kQZQzC0QvovXqdb/oiG4cL3+JYkv/2UjK7U/MZk?=
 =?us-ascii?Q?objWWASpzzD9uJRs0hW3Wemk7jUeGsupM3bCF2WIK81n+wuf5MJpKrF0OiSm?=
 =?us-ascii?Q?dssb6pavAlNXoOppzZ68emKa3ueeYJ7VDJk+onqoD/7MJoFF48rlekBCCD7i?=
 =?us-ascii?Q?GugXyk0tL3X2lvq6c0MS6T7MB/FhpsHtIGRx1DH/sL6VcIrpsZbaeE84HAGi?=
 =?us-ascii?Q?HtFYl89foJgXWeZRolDIkjUtH52qhBGhRESd2Dhd5zMQx2FVSVk1Y3yau7fK?=
 =?us-ascii?Q?8gj0sNQv9PtEELd0+EaJAPT/8V0PrN1retXo2zgUQ0blOBnV6iOBmrYkenzN?=
 =?us-ascii?Q?9188vvO0ig61wN7TU84ONP6rR7XIfP8XpzdflKlNKAZjMVceDlueUcY30y+g?=
 =?us-ascii?Q?rHzWPSYaTZI6zyFaoEvnyfNrM+E3AksixSHYBDIKN3XW+fDKIhYhm/lDmB9R?=
 =?us-ascii?Q?SOj2eGjlc7Voda7IWlFp/YA1NELTQz0MHtKlS8G7gWP/iSJ68i5k56iKv2xs?=
 =?us-ascii?Q?JBz25ZLqXkE7LhoCPK7EIQh9NOkSz10OqxXzgFjW63GX0xeClw178FSf+/mA?=
 =?us-ascii?Q?Ge4SNN7rnLEQ3OVGhRer4eEe2bN7ELkhmlsOn7bg8XWdJmNfDVMlonGy+Q0K?=
 =?us-ascii?Q?sDHS67Q3f7xFnvwwWuIaVwf3aANZ4hTl0l4k7xiVNtEc55pN82wQegXVvBQs?=
 =?us-ascii?Q?rtbLh9rUUC5eJKNsWqoCchVQYlJoNe3NxJ6RSAL+Uv+jZ2UTyBzVGKmqwUc3?=
 =?us-ascii?Q?ocAnMD9oLADk10RdsrsROJ3ccjEp3PBG7Ip7dpF8nIy+orRHGzSUgf/LnBTG?=
 =?us-ascii?Q?OX2Mrq1/wcG9ENmcEYYt/opxiKY5gmAgfBPTImgaane3mdG2X+KZJsuZeRjV?=
 =?us-ascii?Q?bewEl/MzaOAc5xRRxOj9Fwdv3Di4ktDdRmho8Heq518ee0OlWYOZclAoMsRT?=
 =?us-ascii?Q?9RCktZfED3Had1Fcj1tRJzE7WrXAX1/M6QOCCT8LFlg5Ql43I45H5+jxH/8D?=
 =?us-ascii?Q?+SWjQPqiMPqgIO+4OzJpPbmW5i8P+LduNovpuyK80RlCRA6LMr0Xpzg//Myk?=
 =?us-ascii?Q?U1x4MMH1wCWK/IgobttBox2h95yS9zbuSWV1ntjwiLdV1ylNISAv4hlHphBf?=
 =?us-ascii?Q?stolr7hXptatHd01+q0JaAVJ6ppJLy+dT3iKQmKYn5eTlDdv6s8x29hSP/og?=
 =?us-ascii?Q?RXBe2s8xIi1BbeC/X1gVI/ki2+UhK08ok4koogLu0E8gRexF7jk8Oeu2ojEv?=
 =?us-ascii?Q?TM7e334LhI7CzhJd6RBsiNlVOUisX9sYIqdFz6fLeMPETPj5kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:18:08.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5640cdb2-1321-49a4-a03e-08dc8bd52d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Currently TIF_NEED_RESCHED is being overloaded, to wakeup an idle CPU in
TIF_POLLING mode to service an IPI even if there are no new tasks being
woken up on the said CPU.

In preparation of a proper fix, introduce a new helper
"need_resched_or_ipi()" which is intended to return true if either
the TIF_NEED_RESCHED flag or if TIF_NOTIFY_IPI flag is set. Use this
helper function in place of need_resched() in idle loops where
TIF_POLLING_NRFLAG is set.

To preserve bisectibility and avoid unbreakable idle loops, all the
need_resched() checks within TIF_POLLING_NRFLAGS sections, have been
replaced tree-wide with the need_resched_or_ipi() check.

[ prateek: Replaced some of the missed out occurrences of
  need_resched() within a TIF_POLLING sections with
  need_resched_or_ipi() ]

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Guo Ren <guoren@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Benjamin Gray <bgray@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Xin Li <xin3.li@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Tony Battersby <tonyb@cybernetics.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: David Vernet <void@manifault.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o Fixed a conflict with commit edc8fc01f608 ("x86: Fix
  CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram") that touched
  mwait_idle_with_hints() in arch/x86/include/asm/mwait.h
---
 arch/x86/include/asm/mwait.h      | 2 +-
 arch/x86/kernel/process.c         | 2 +-
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 drivers/cpuidle/cpuidle-pseries.c | 2 +-
 drivers/cpuidle/poll_state.c      | 2 +-
 include/linux/sched.h             | 5 +++++
 include/linux/sched/idle.h        | 4 ++--
 kernel/sched/idle.c               | 7 ++++---
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce..3fa6f0bbd74f 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -125,7 +125,7 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 
-		if (!need_resched()) {
+		if (!need_resched_or_ipi()) {
 			if (ecx & 1) {
 				__mwait(eax, ecx);
 			} else {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..dd73cd6f735c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -901,7 +901,7 @@ static __cpuidle void mwait_idle(void)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched()) {
+		if (!need_resched_or_ipi()) {
 			__sti_mwait(0, 0);
 			raw_local_irq_disable();
 		}
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..77c3bb371f56 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -79,7 +79,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	dev->poll_time_limit = false;
 	ppc64_runlatch_off();
 	HMT_very_low();
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
 			/*
 			 * Task has not woken up but we are exiting the polling
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 14db9b7d985d..4f2b490f8b73 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -46,7 +46,7 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	snooze_exit_time = get_tb() + snooze_timeout;
 	dev->poll_time_limit = false;
 
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		HMT_low();
 		HMT_very_low();
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..225f37897e45 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -26,7 +26,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
+		while (!need_resched_or_ipi()) {
 			cpu_relax();
 			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
 				continue;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e..e52cdd1298bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2069,6 +2069,11 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
+static __always_inline bool need_resched_or_ipi(void)
+{
+	return unlikely(tif_need_resched() || tif_notify_ipi());
+}
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index e670ac282333..497518b84e8d 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched_or_ipi());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched_or_ipi());
 }
 
 #else
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6e78d071beb5..7de94df5d477 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,7 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
+	while (!need_resched_or_ipi() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
@@ -174,7 +174,7 @@ static void cpuidle_idle_call(void)
 	 * Check if the idle task must be rescheduled. If it is the
 	 * case, exit the function after re-enabling the local IRQ.
 	 */
-	if (need_resched()) {
+	if (need_resched_or_ipi()) {
 		local_irq_enable();
 		return;
 	}
@@ -270,7 +270,7 @@ static void do_idle(void)
 	__current_set_polling();
 	tick_nohz_idle_enter();
 
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		rmb();
 
 		/*
@@ -350,6 +350,7 @@ static void do_idle(void)
 	 * RCU relies on this call to be done outside of an RCU read-side
 	 * critical section.
 	 */
+	current_clr_notify_ipi();
 	flush_smp_call_function_queue();
 	schedule_idle();
 
-- 
2.34.1


