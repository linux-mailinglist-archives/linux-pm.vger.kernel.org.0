Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62BB302908
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbhAYRfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:35:51 -0500
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:22624
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731069AbhAYRfW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:35:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3qLPWoJBi3beINZjWLSWNYu6dCxqIG9C1l3BLoNCRyo014MPFkm9SrUe6bp/iHM7FmUl8wjzG1TE8yKffRUPcBkZlPsu6IbH2RnTax5WMD/32q6g7tiE0t9+tPyRdV4lpG1/K1zGtNUBEwOe8CjmT33dA5J4sATeNO3j3nA0uS1Mj5fP99q1O5mkIfxd9N+D333LOSQRPmP/Thig7i54J/56xjHcA0P8lJB+k1HvVOwkG37kmpJYOv6R4gLT91loC6BEKDQKPnTmamOiLhzAPFseY+V4GOwzb0SxNM6Ojoe3UHSC+tSe6lw43VaXnmMnUNtDL42XdfiMkMbeIywMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YSt70VLiIr6JyiUMTvCebZ3Pr7yHmJM0nBy5QIEej4=;
 b=WzEK6INpT/iVENso7tUKBOnGS640Ezc7kW7S0rHUM8K7KlrlJSFtJUlVO9y0e2wmgpz7+hUAZ3RGc2h4pDFrEEFIlxpfAtgMzwu7J4IXCBYKbhdLPx5RRFf2eufRzsuHS+Ot8hu0wgDrjQ0gDhegHVENsltaPi3OvXqzjJdQbpTPrT2tzeZcOKGFb64EqjvYbhRUjPR6JsyE2wjqHLIqoVlPPtrJsIL/uf1iZUlljm4M/EjMBLOSUQKOGO3EwY/lPX9B4nB8U1KGbj7gEXQUH/gXWow2H/pR9Zfl1+mykfAnk8iVCCv+7dT9IXD/y2bTdU2RigVRizmX/s4TnbncZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YSt70VLiIr6JyiUMTvCebZ3Pr7yHmJM0nBy5QIEej4=;
 b=tUrutywwPwWcIak+n3eYqKAkgbUJy3ePpEsduWIqZSLcMlR/5ZIHSvIZn+1glBB2hdYubCLM4+paVBHnB7UHVatyhIb4wXQgUIP6v8EZMs3iKdX84dnIuE97/0MA52l5Gpx7OK4RL0kVN3I673FF377KiqzujeAS4/8Lgrct4O4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 17:34:26 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:34:26 +0000
Subject: [PATCH v2 0/8] cpupower: Updates and cleanup to support AMD Family
 0x19
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:34:14 -0600
Message-ID: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 17:34:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52d37077-303b-409c-22da-08d8c157765c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2576FB000E52482B249630FAECBD9@SN1PR12MB2576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzQF8VIlFwx7F9xRLhDs/BUpW2RnbPKDPxczR9yWrm881bZiMUe5YK2cfeTPupW0VQ7HYbkVVHxHs43T1fiSmj8/4q6fmc0aq0fHgT7rLIOeGgqEURUdPG9Y4ts7iZX2qILjjzUFDui1pxjndKaUYFTHVW2cQfhluxcVS4NtgOZKBjsn1F/KmJj14N56fx939JAyLMHZZCuKyolSPGmlKYjsxbjVE5ls9uj0pxqoDXeI6gOTQHVvSXnqlfxedwHvmHH6bW1JKNMSWhcJ52sHroSrL+S5VAFw4PTmEOWotGdWk52j5yeAhJDDaLXmHrx2a38DXZM7qllX9daf578DI1GYcISRjWUvpMUeG9foN5Oscm4RiSryxEAin5DtV+8cIkZx6Mf05Y50BN1dnNF/tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66476007)(66946007)(66556008)(5660300002)(7696005)(52116002)(15650500001)(316002)(8676002)(956004)(4326008)(83380400001)(44832011)(2906002)(6666004)(86362001)(8936002)(478600001)(26005)(186003)(16526019)(55016002)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVdZY2lycWxScnBCSVNjdzdjVW9nNFA4MHE0TGdtbUdDWFd3K09LYWFoenps?=
 =?utf-8?B?K0VzV2c5ZXJ2Y2piSWtRVVJ4RUhtdFlPL0ZySWduc0NnZFFTODJneGZnYWtZ?=
 =?utf-8?B?cjVpUG9uTEwwaHJ1c3dJQ1NqbkZ3VUZuOEpPWTh6VndPOHhjdlhpV3NyclB1?=
 =?utf-8?B?eWJkNndkOFVuZWdTelhSNFNUbmh1dHlvanRQMVR1N0NBNnBwYWdCd1FwTEc2?=
 =?utf-8?B?bmxKYkRscXBmS2t1L25nWW1YdVZHd3VWZVEycjBHOGFLQ3cvTzQ2NUI3WDFv?=
 =?utf-8?B?ajBGeXkwRERDekM2cEJ3ZkFKdTdZRkVuY3RMTjV3b2VqdkxzQUFXY0lGNjZo?=
 =?utf-8?B?TndqamJWd01NY3VvbDJkWFNFTWJBVm95YlJ1azgzRGlLcWFZOUpMTUNWRHhT?=
 =?utf-8?B?N2VGN3MzZlloaHo4TjZ6MmFoVnE0RldoNHFBTzRmUVNycHN6OTRIVlAwZUhr?=
 =?utf-8?B?Ly9YU0V0L0Z5RmhFckVqaitkTGJjMk5Ec0hxaTRvUU1CMHMwMVdYTm84d2Zw?=
 =?utf-8?B?R2ttVVV4QUxSbXB3cSt1dGlKdzNGYXNSeXFhc0tseWUyci9UTTN3aE1rU3c1?=
 =?utf-8?B?MVhHa1kvbHZEaVRzNk1YbXRySmsrMlJ1ZmRvWDY3eVU4cjFjVWZDSUdKYW4r?=
 =?utf-8?B?V3RFTEpKYTNaSW5lN1IrMEdqamJJQ096V00rYXhqTWFra3lUK1A5Sk14cWFS?=
 =?utf-8?B?cnFTejc1RVVQQnVXQ1lweWJLL09hTCt0OWxKam4vNWgzcGFLZFEvRm5idTNw?=
 =?utf-8?B?QnA4eEJNTnZpcnRubmZJL1Y3Y3Q2SGJ4M3lUWFVKeGtLRDcvbWhibFkvb0Rw?=
 =?utf-8?B?bmpaOURLV0hsbThrWHJqWE93MmtZaWllMm1hS2p0Ympmb2xDRWkzMzV6REQ2?=
 =?utf-8?B?cE1naGNBdUxWRXlMeWpUTWJCTGxhZlFRb0NEbjBnd2xkZjkwbUFvTHYwaHAr?=
 =?utf-8?B?UHZPSmhYR2U3RDN4c0szUTg5R2RMSVk2VW01cGhScWd0MzJHRzlDYnQzeHZn?=
 =?utf-8?B?Z0pVbzU3bkFDTm4ydi9QY3N6c0FMcm1zOGErTnNhTktCd04yVjlhNHduQ3hD?=
 =?utf-8?B?c1FpZk50MUpVNGJUeHRhMFhZYUxldmc0eHkvVFZuV2tFdEtLQ0x4SmltMWg3?=
 =?utf-8?B?QWhiUmlyd1p1ZXNCcm5HMTB1b25nOURXWkFWUEFTZlZSUU5ndHhWREtDOEZ2?=
 =?utf-8?B?SUlrZlczbjNxOURTMlFQVkpTanVvbHMrMmIvbmt0U00zUG5KZVNhRHFTV0VL?=
 =?utf-8?B?eUNha0EyWXoyK1p3aGtHUlkzVlpMTnlRVGFJdlJ4T3RFQ1F4eFFSMUVEcWFI?=
 =?utf-8?B?Q041ZjNiSlN5SG9OZm03d3R6T21IdHJadlhCcytNTHlKejdVbmczWlk1Qmk2?=
 =?utf-8?B?SENkN1BXbXFmWSt1SjFjd3dCYU1nTUlzZXRScmxjaytqV1l4SUxGcEh1V04x?=
 =?utf-8?Q?DrLoNlOe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d37077-303b-409c-22da-08d8c157765c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:34:26.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMIuEf1oTqwjOuuhfJ8eyJf0uhS96F7CixRuvGNQwiqM1FSmGMxF+mXyrgdJ2iVhalsFbqXc5Q7ZykTlDezwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Updates to the cpupower command to add support for AMD family 0x19
and cleanup the code to remove many of the family checks to hopefully
make any future family updates easier.

The first couple of patches are simple updates to rename the structs
in the msr_pstate union to better reflect current support and correcting
the name of the CPUPOWER_CAP_AMD_CPB cpuid cap flag.

Patches 3, 5, and 8 update the family checks to either replace
them with a new cpuid cap flag based off of cpuid checks or check for
family >= 0x17 where removing the direct family check isn't possible.

The reamianing patches are cleanups to remove unneeded extra enabled bit
checking, remove passing no longer used variables, and remove unused
variables in decode_pstates().
---

Updates for v2:
- Patch 1/8: Add links to AMD PPR and BKDG to commit message.
- Patch 3/8: Update and add back removed comment.

---

Nathan Fontenot (7):
      cpupower: Update msr_pstate union struct naming
      cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
      cpupower: Remove unused pscur variable.
      cpupower: Update family checks when decoding HW pstates
      cpupower: Condense pstate enabled bit checks in decode_pstates()
      cpupower: Remove family arg to decode_pstates()
      cpupower: Add cpuid cap flag for MSR_AMD_HWCR support

Robert Richter (1):
      cpupower: Correct macro name for CPB caps flag


 tools/power/cpupower/utils/cpufreq-info.c    |    3 -
 tools/power/cpupower/utils/helpers/amd.c     |   65 ++++++++++++--------------
 tools/power/cpupower/utils/helpers/cpuid.c   |   20 +++++++-
 tools/power/cpupower/utils/helpers/helpers.h |   14 +++---
 tools/power/cpupower/utils/helpers/misc.c    |    9 +---
 5 files changed, 57 insertions(+), 54 deletions(-)

--
Nathan Fontenot
