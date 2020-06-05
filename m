Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA41F0152
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFEVJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 17:09:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:23117 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgFEVJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 17:09:42 -0400
IronPort-SDR: 9J2tvaG6Rla6wf9lKJvd8muskTh4GjXNiFz7VNQIXD4VwkFzPqK3RAAQ09noBmmU0AuVCVo9FV
 Sq1Rtjsw7pKg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 14:09:39 -0700
IronPort-SDR: e54a9bH0CQvT5TXsLyE8X2Upk0TzjgRvaQZh0cXs90gPmQug5Dd/79BnM8qr4CLWJeLOdQvt2k
 FJgkjR+FlVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="gz'50?scan'50,208,50";a="417397850"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2020 14:09:36 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhJap-0000P5-DD; Fri, 05 Jun 2020 21:09:35 +0000
Date:   Sat, 6 Jun 2020 05:08:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     kbuild-all@lists.01.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: [PATCH] x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during
 wakeup
Message-ID: <202006060421.fTpTXYbe%lkp@intel.com>
References: <20200605200728.10145-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20200605200728.10145-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sean,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/auto-latest v5.7 next-20200605]
[cannot apply to bp/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Sean-Christopherson/x86-cpu-Reinitialize-IA32_FEAT_CTL-MSR-on-BSP-during-wakeup/20200606-040921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 9cb1fd0efd195590b828b9b865421ad345a4a145
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

arch/x86/kernel/cpu/centaur.c: In function 'init_centaur':
>> arch/x86/kernel/cpu/centaur.c:219:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
219 |  init_ia32_feat_ctl(c);
|  ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
--
arch/x86/kernel/cpu/zhaoxin.c: In function 'init_zhaoxin':
>> arch/x86/kernel/cpu/zhaoxin.c:110:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
110 |  init_ia32_feat_ctl(c);
|  ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

vim +/init_ia32_feat_ctl +219 arch/x86/kernel/cpu/centaur.c

60882cc159e141 arch/x86/kernel/cpu/centaur.c  David Wang          2018-04-20  218  
501444905fcb41 arch/x86/kernel/cpu/centaur.c  Sean Christopherson 2019-12-20 @219  	init_ia32_feat_ctl(c);
^1da177e4c3f41 arch/i386/kernel/cpu/centaur.c Linus Torvalds      2005-04-16  220  }
^1da177e4c3f41 arch/i386/kernel/cpu/centaur.c Linus Torvalds      2005-04-16  221  

:::::: The code at line 219 was first introduced by commit
:::::: 501444905fcb4166589fda99497c273ac5efc65e x86/centaur: Use common IA32_FEAT_CTL MSR initialization

:::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
:::::: CC: Borislav Petkov <bp@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9jxsPFA5p3P2qPhR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Vg3I8DBoAAA=

--9jxsPFA5p3P2qPhR--
