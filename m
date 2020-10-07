Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C628636A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgJGQQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:16:29 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:31169
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729141AbgJGQQ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 12:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eApryz9y+Tmis29kKV2bRkVAa78YXikJVASBFWN2iVQbAXuWYeamT+PvbNTIJYklJoGTdZleqGfUf9dFzejOUCevT4nvr+94E6y+raa5Dj4WX2iVahfKdSoAqIplEpvt+XYxh9RAE1tICqX/Zvl2IHqdK98pWzGMx3RVw//nroFCWVluzntc1zGgbMwKbzbtERpz+H6sFRaMO22JMhiZ3x+95DING6ReNWd84Nk8SaGdnyQftfeAeUQLZYpa1kIBaNZIwkpInx1ODVbtA9N7qFYg+inG3G+sfzfmlxl+xm3mYgVUrncZ79KqdM3+tXZlK2C1MPY9Yhz+H1h5Ap45iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB8GFOBx6rTSSLJ7f3iySoWHmU/ilgynIcbv8Y5v0rU=;
 b=UxPJsj3O5KPtKaj+bApf3lViR0uM2YlQouh+JmlL0oxn4HCqeNeHlehDkNXDsBV0y6eJAnEtEjcyJUSPCrg9+LFe/hwxAhtDVKt4uZkfc1qsrL3IQ/4K98poXOc/FjrjcSo/IG/nB+QLemy43lgIP8OTeYlYtCDDmaeKEQWzlXNf5Uatz68gzZJ502vbv06HZdY993fmvNWZ9OkP+nAbz7bUdxQojqj/OH0WmWT5tPirsYDb4PbXt+Ls5TYy4QulV8K3fG4C7yULYarRVFklsYITMbW82A7qow7SQit/d+LkKcyDp+G3vAhcAt7XPs0dTQWzkvMgu+XTRCZ0vjMVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB8GFOBx6rTSSLJ7f3iySoWHmU/ilgynIcbv8Y5v0rU=;
 b=ILEg1Qrwqf7EnxprzVpeg1MsXkDkG6yIER2Pg3GtPNo4wKF4SI9ygTHgX6KJRG9SBLqXbLR9K+9jjuEXmxdhNBbj9a8ZN33o/sSAWsvzgciT+NOZsrjq4lgWoWjToh+/nyg72mEWjdna6U1TbSoln/ThSDe3g7r7UFLFe32gzJQ=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB3444.namprd12.prod.outlook.com (2603:10b6:408:47::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 16:16:19 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 16:16:19 +0000
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
Subject: [PATCH v2 0/4] powercap: Enable RAPL for AMD Fam17h and Fam19h 
Date:   Wed,  7 Oct 2020 11:14:35 -0500
Message-Id: <20201007161439.312534-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [70.114.200.6]
X-ClientProxiedBy: DM6PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::39) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by DM6PR02CA0137.namprd02.prod.outlook.com (2603:10b6:5:1b4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Wed, 7 Oct 2020 16:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eba61e9-5a06-484a-8386-08d86adc5334
X-MS-TrafficTypeDiagnostic: BN8PR12MB3444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3444108E7EE302D5097E8107870A0@BN8PR12MB3444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV0G1z0sV5HwmVfdTT9pRjuryZ5PLdoLgzXBbWgKo6Pkv4pbQZwf71NzCr60Xg12+jr4ZeZnBybzjbE84f0ivmY3Rfwj4328a/CsfNDzLsRAgmTsLQ9236A52PiWBgsKICD79MkeFAXQtXj3/sGfW33iuRRJqZsxZbvtuAvBIXSUWnIL4TZGWBkhITbcl0Tn07DGPWFDyUFjgtiLl/Aw0YLKgiAlWDupcI0QChfo/DtRda2WpTS8oMofq/qn4Vqm7hm6G8Z1Qx4YPYzMrnT1QMcBq5B29fmLGcN+Fn7RLGIU/juV7k84uihhstIkfThuIXrVg7kctB1mUOP1r2ZUNYA5+Mya1xQrjjQbBMLxAuPobVqHeTn/a/e4Xj0DeYOp9rkKJo1rIC7RLfMWrhQG7S5I2nEa/l15NtGCYMuIB9IYLVUrLjlpT7HA3HLG2CDcgxNnFX4GcBcW/YXvQO/dQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(6486002)(110136005)(478600001)(36756003)(316002)(44832011)(6506007)(4743002)(966005)(5660300002)(7416002)(86362001)(2906002)(66556008)(66476007)(66946007)(956004)(26005)(2616005)(6666004)(83380400001)(69590400008)(54906003)(4326008)(52116002)(6512007)(16526019)(186003)(1076003)(8676002)(83080400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 17E4GLc1pZ0fr6ibTLCOxwa3mvgUa44j8sJg3e6S+ZdMjyIi1bTkNNCUif+re/Eq2ZBLLkblxJRbvd5yGw7A36ft9nu3zVxgdY/AV8vgv5ZociLeU0v6b0Yr2BQW8DZ+hG6f9XzjRjUVIYabkz1XIEEoLOEVLtBWRs4Zuw2Imdrbgkq2pIBTvRYa5iLqw+MaofNxSy8gUJuazjS0tJzr1IVcLTt1Yw+e/YGHK8LZGphgB35k1swAUJTZyfILridQ6GgB0U5d2jCCK9e8/HRhjhBi/JgFb7mxvNdOoSkwcZkxfXnDSFVkpP/IWLQIIldozKfI4g6z/VL/0r9EEerxuUZy9frrDEzHsCE5zV3LeNtYFaxDXnWSZsP7a9wXF3XelP2JpftqOfROJTkyuIZChW5PYq+n8mbX0HWvX5XkLm8fgKBT4zq8+tEHXoYEdoBMnwqi+Knj5UKTHb4WkXcIcOO5T/sU0HuzBuN0cnDHDHV0IRrj9kLedjDw/EAUrjgOiPzk0z7h8/EmV4mNAuyc1wx1B0i5BqXGwGlN6RnyZ+SQaZw3AM5OnFUy0Voi7G/5YAbE7WCTg+1whrTsG88MG09qsDWoqBDrEukQcFnouSBvzR44ZhvYDvZbzfsjrerBk0rYQ8wPfP4mWbTsN906Hw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba61e9-5a06-484a-8386-08d86adc5334
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:16:19.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rpGfbiUViNIzccWjr8aZOtZjRLutdfYgv8Etg/dTcGw0D0btxoK1TkFd/bpgxB0eQcClN9pcEsE2i9zAAqlbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3444
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Victor Ding <victording@google.com>

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h support RAPL counters to monitor power usage. The RAPL
counter operates as with Intel RAPL. Therefore, it is beneficial to
re-use existing framework for Intel, especially to allow existing tools
to seamlessly run on AMD.

From the user's point view, this series enables the following two sysfs
entry on AMD Fam17h:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj

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

Kim Phillips (1):
  powercap: Add AMD Fam19h RAPL support

Victor Ding (3):
  x86/msr-index: sort AMD RAPL MSRs by address
  powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
  powercap: Add AMD Fam17h RAPL support

 arch/x86/include/asm/msr-index.h     |  3 +-
 drivers/powercap/intel_rapl_common.c |  3 ++
 drivers/powercap/intel_rapl_msr.c    | 62 ++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 18 deletions(-)

v2: Kim's changes from Victor's original submission:

https://lore.kernel.org/lkml/20200729105206.2991064-1-victording@google.com/

- Added the Fam19h patch to the end of the series
- Added my Acked-by
- Added Daniel Lezcano to Cc 
- (linux-pm was already on Cc)
- (No code changes)
-- 
2.27.0

