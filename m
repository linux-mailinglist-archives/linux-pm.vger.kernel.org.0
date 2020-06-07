Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0C1F0D27
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFGQea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 12:34:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:58842 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgFGQe3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Jun 2020 12:34:29 -0400
IronPort-SDR: UFC7Ab1xN9mMIw+3cO9GT6fLGmIBJT4aLikBO+OucFtE6gIEWtvtT0tJ2/TxGqNdSbKIIK411G
 961vTGiXO+YQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 09:34:28 -0700
IronPort-SDR: Fyk1InqYMPYgh1T0kcnxxfilbZ5XgWp5wHXXAKKqigkdTzUJ4X4gN7NUquJyqONUiDLVB/kR+a
 Tw6xi5oUdIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; 
   d="scan'208";a="258486290"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2020 09:34:28 -0700
Date:   Sun, 7 Jun 2020 09:34:28 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kbuild-all@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: [PATCH] x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during
 wakeup
Message-ID: <20200607163428.GB24576@linux.intel.com>
References: <20200605200728.10145-1-sean.j.christopherson@intel.com>
 <202006060421.fTpTXYbe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006060421.fTpTXYbe%lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 05:08:38AM +0800, kernel test robot wrote:
 arch/x86/kernel/cpu/centaur.c: In function 'init_centaur':
> >> arch/x86/kernel/cpu/centaur.c:219:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
> 219 |  init_ia32_feat_ctl(c);
> |  ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> --
> arch/x86/kernel/cpu/zhaoxin.c: In function 'init_zhaoxin':
> >> arch/x86/kernel/cpu/zhaoxin.c:110:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
> 110 |  init_ia32_feat_ctl(c);
> |  ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors

Blech, zhaoxin.c an centaur.c don't include asm/cpu.h, and I (obviously)
don't have them enabled in my configs.  I'll wait a day or two more before
sending v2.

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 426792565d86..c5cf336e5077 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -3,6 +3,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>

+#include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
 #include <asm/mtrr.h>
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index df1358ba622b..05fa4ef63490 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -2,6 +2,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>

+#include <asm/cpu.h>
 #include <asm/cpufeature.h>

 #include "cpu.h"

