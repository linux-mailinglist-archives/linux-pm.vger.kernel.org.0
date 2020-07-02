Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C72125B8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgGBOKb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 10:10:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:65165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgGBOKb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 10:10:31 -0400
IronPort-SDR: 7XMFp6PHpU7Phu8Py6Lcl8ow393773ufqXDw7lH8fl8Q/R1yETx2syA/w+PKBBrSKSqJW25KQa
 MH9ss/BaxZZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="208423125"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="208423125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 07:10:30 -0700
IronPort-SDR: PS0KsH5L41nrssyTDEpNKlUIV1gAAel96oHllUcUzw66mwCeKO6m3kRv3IxcyyMPslzeLOnLiP
 53tG6VRL/7Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="321538341"
Received: from gxu8-mobl.amr.corp.intel.com ([10.249.168.57])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2020 07:10:28 -0700
Message-ID: <6d83291fc68d52ecf48a952ac49a98e798b7b8b7.camel@intel.com>
Subject: Re: [e1000e] e86e383f28: suspend-stress.fail
From:   Zhang Rui <rui.zhang@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        kernel test robot <rong.a.chen@intel.com>, lkp@lists.01.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Thu, 02 Jul 2020 22:10:27 +0800
In-Reply-To: <01DBC003-008F-470C-A228-029F34631305@canonical.com>
References: <20200521052753.GB12456@shao2-debian>
         <5A1631F8-259E-4897-BE52-0F5DB406E44F@canonical.com>
         <489156ef4d028d210ec03b7b02413e000fec2eaf.camel@intel.com>
         <01DBC003-008F-470C-A228-029F34631305@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-07-02 at 21:12 +0800, Kai-Heng Feng wrote:
> > On Jul 2, 2020, at 20:20, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > Hi, all,
> > 
> > This patch has been shipped in 5.8-rc1 with its upstream commit id
> > 0c80cdbf3320. And we observed big drop of suspend quality.
> > 
> > Previously, we have run into this "e1000e Hardware Error" issue,
> > occasionally. But now, on a NUC I have, system suspend-to-mem fails
> > within 10 suspend  cycles in most cases, but won't work again until
> > a reboot.
> > https://bugzilla.kernel.org/show_bug.cgi?id=205015
> > 
> > IMO, this is a regression, and we need to find a way to fix it.
> 
> Should be fixed by 
> https://lore.kernel.org/lkml/20200618065453.12140-1-aaron.ma@canonical.com/
> 

Great, I will give it a try and update later.

thanks,
rui

> Kai-Heng
> 
> > 
> > thanks,
> > rui
> > 
> > 
> > On Sat, 2020-05-23 at 20:20 +0800, Kai-Heng Feng wrote:
> > > [+Cc intel-wired-lan]
> > > 
> > > > On May 21, 2020, at 13:27, kernel test robot <
> > > > rong.a.chen@intel.com
> > > > > wrote:
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed the following commit (built with gcc-7):
> > > > 
> > > > commit: e86e383f2854234129c66e90f84ac2c74b2b1828 ("e1000e: Warn
> > > > if
> > > > disabling ULP failed")
> > > > 
> > 
> > 
https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git
> > > > dev-queue
> > > 
> > > kern  :warn  : [  240.884667] e1000e 0000:00:19.0 eth0: Failed to
> > > disable ULP
> > > kern  :info  : [  241.896122] asix 2-3:1.0 eth1: link up,
> > > 100Mbps,
> > > full-duplex, lpa 0xC1E1
> > > kern  :err   : [  242.269348] e1000e 0000:00:19.0 eth0: Hardware
> > > Error
> > > kern  :info  : [  242.772702] e1000e 0000:00:19.0:
> > > pci_pm_resume+0x0/0x80 returned 0 after 2985422 usecs
> > > 
> > > So the patch does catch issues previously ignored.
> > > 
> > > I wonder what's the next move, maybe increase the ULP timeout
> > > again?
> > > 
> > > Kai-Heng
> > > 
> > > > in testcase: suspend-stress
> > > > with following parameters:
> > > > 
> > > > 	mode: mem
> > > > 	iterations: 10
> > > > 
> > > > 
> > > > 
> > > > on test machine: 4 threads Broadwell with 8G memory
> > > > 
> > > > caused below changes (please refer to attached dmesg/kmsg for
> > > > entire log/backtrace):
> > > > 
> > > > 
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > 
> > > > SUSPEND RESUME TEST STARTED
> > > > Suspend to mem 1/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-1/10
> > > > -O /dev/null
> > > > Done
> > > > Sleep for 10 seconds
> > > > Suspend to mem 2/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-2/10
> > > > -O /dev/null
> > > > Done
> > > > Sleep for 10 seconds
> > > > Suspend to mem 3/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-3/10
> > > > -O /dev/null
> > > > Done
> > > > Sleep for 10 seconds
> > > > Suspend to mem 4/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-4/10
> > > > -O /dev/null
> > > > Done
> > > > Sleep for 10 seconds
> > > > Suspend to mem 5/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-5/10
> > > > -O /dev/null
> > > > Done
> > > > Sleep for 10 seconds
> > > > Suspend to mem 6/10:
> > > > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-
> > > > 8 
> > > > 
http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-6/10
> > > > -O /dev/null
> > > > Failed
> > > > 
> > > > 
> > > > 
> > > > To reproduce:
> > > > 
> > > >       git clone https://github.com/intel/lkp-tests.git
> > > >       cd lkp-tests
> > > >       bin/lkp install job.yaml  # job file is attached in this
> > > > email
> > > >       bin/lkp run     job.yaml
> > > > 
> > > > 
> > > > 
> > > > Thanks,
> > > > Rong Chen
> > > > 
> > > > <config-5.7.0-rc4-01618-ge86e383f28542><job-
> > > > script.txt><kmsg.xz><suspend-stress.txt><job.yaml>
> > > 
> > > 
> 
> 

