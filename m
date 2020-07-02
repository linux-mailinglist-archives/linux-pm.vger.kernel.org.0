Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECED7212445
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGBNMb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 2 Jul 2020 09:12:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgGBNMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 09:12:31 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqz0u-0003pf-Mt
        for linux-pm@vger.kernel.org; Thu, 02 Jul 2020 13:12:28 +0000
Received: by mail-pf1-f200.google.com with SMTP id c2so737544pfj.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 06:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tYkFypTgKMUggS85YPA/c0ikRKX/SLMw/DNqlVEcQwQ=;
        b=la+XgujoeSLqiPQV5DYbX0/Dg97dpdhavVBmL/kIDry47ls0jUbLx/lZUIOV4TxDcM
         rK/hH9BA6D7jXgNIemlJTrNzMu5okotTUbdN2kPD3RPHTJYw32lvZVPfnd+Fo1HzSAMT
         OMOetwTbVSxtGeKa53qSMi33F8Aa17WjqfiI349ods1lgZMOQqYf30f5ffBgJjiVmc4f
         VMkzyqbBWBUfuSUJF52GAfZBls60ETebEP1v1NXM8Z4Bh+ADLv3dsxG92vjTSe1yU5NS
         RuzZ7OHzPK0y8Dcec7ZalG2SsfFE+1TXdd/a9GCqa6mFci3RgZTICv8zlGI/mlCjfNzi
         mpdQ==
X-Gm-Message-State: AOAM530qWmZG5PhYCQKk64GX0Z02Kc0byY1tPRXAt90xqokk/U4/OJeu
        ACERBneF/SOOCPquEtMa8rpiQOiZ/Kp4EN443qRjCZeAa0SHTPvJrYbo4slbu7Z5NkijuwX4lun
        zuCMYDFpQ2rczCO4AgJ+beKbyK+RsvoNkX9AB
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr32506204pjb.112.1593695546649;
        Thu, 02 Jul 2020 06:12:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/iQtsfDOvXTcpdplOvgcle+D3iKiDkd9WdJORrMVcHsMwwvtu7V0GHYOlzeGUCBFAPegYHA==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr32506176pjb.112.1593695546293;
        Thu, 02 Jul 2020 06:12:26 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id cv3sm7976528pjb.45.2020.07.02.06.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:12:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [e1000e] e86e383f28: suspend-stress.fail
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <489156ef4d028d210ec03b7b02413e000fec2eaf.camel@intel.com>
Date:   Thu, 2 Jul 2020 21:12:23 +0800
Cc:     "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        kernel test robot <rong.a.chen@intel.com>, lkp@lists.01.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <01DBC003-008F-470C-A228-029F34631305@canonical.com>
References: <20200521052753.GB12456@shao2-debian>
 <5A1631F8-259E-4897-BE52-0F5DB406E44F@canonical.com>
 <489156ef4d028d210ec03b7b02413e000fec2eaf.camel@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Jul 2, 2020, at 20:20, Zhang Rui <rui.zhang@intel.com> wrote:
> 
> Hi, all,
> 
> This patch has been shipped in 5.8-rc1 with its upstream commit id
> 0c80cdbf3320. And we observed big drop of suspend quality.
> 
> Previously, we have run into this "e1000e Hardware Error" issue,
> occasionally. But now, on a NUC I have, system suspend-to-mem fails within 10 suspend  cycles in most cases, but won't work again until a reboot.
> https://bugzilla.kernel.org/show_bug.cgi?id=205015
> 
> IMO, this is a regression, and we need to find a way to fix it.

Should be fixed by https://lore.kernel.org/lkml/20200618065453.12140-1-aaron.ma@canonical.com/

Kai-Heng

> 
> thanks,
> rui
> 
> 
> On Sat, 2020-05-23 at 20:20 +0800, Kai-Heng Feng wrote:
>> [+Cc intel-wired-lan]
>> 
>>> On May 21, 2020, at 13:27, kernel test robot <rong.a.chen@intel.com
>>>> wrote:
>>> 
>>> Greeting,
>>> 
>>> FYI, we noticed the following commit (built with gcc-7):
>>> 
>>> commit: e86e383f2854234129c66e90f84ac2c74b2b1828 ("e1000e: Warn if
>>> disabling ULP failed")
>>> 
> https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git
>>> dev-queue
>> 
>> kern  :warn  : [  240.884667] e1000e 0000:00:19.0 eth0: Failed to
>> disable ULP
>> kern  :info  : [  241.896122] asix 2-3:1.0 eth1: link up, 100Mbps,
>> full-duplex, lpa 0xC1E1
>> kern  :err   : [  242.269348] e1000e 0000:00:19.0 eth0: Hardware
>> Error
>> kern  :info  : [  242.772702] e1000e 0000:00:19.0:
>> pci_pm_resume+0x0/0x80 returned 0 after 2985422 usecs
>> 
>> So the patch does catch issues previously ignored.
>> 
>> I wonder what's the next move, maybe increase the ULP timeout again?
>> 
>> Kai-Heng
>> 
>>> in testcase: suspend-stress
>>> with following parameters:
>>> 
>>> 	mode: mem
>>> 	iterations: 10
>>> 
>>> 
>>> 
>>> on test machine: 4 threads Broadwell with 8G memory
>>> 
>>> caused below changes (please refer to attached dmesg/kmsg for
>>> entire log/backtrace):
>>> 
>>> 
>>> 
>>> 
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>> 
>>> SUSPEND RESUME TEST STARTED
>>> Suspend to mem 1/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-1/10
>>> -O /dev/null
>>> Done
>>> Sleep for 10 seconds
>>> Suspend to mem 2/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-2/10
>>> -O /dev/null
>>> Done
>>> Sleep for 10 seconds
>>> Suspend to mem 3/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-3/10
>>> -O /dev/null
>>> Done
>>> Sleep for 10 seconds
>>> Suspend to mem 4/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-4/10
>>> -O /dev/null
>>> Done
>>> Sleep for 10 seconds
>>> Suspend to mem 5/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-5/10
>>> -O /dev/null
>>> Done
>>> Sleep for 10 seconds
>>> Suspend to mem 6/10:
>>> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
>>> http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-6/10
>>> -O /dev/null
>>> Failed
>>> 
>>> 
>>> 
>>> To reproduce:
>>> 
>>>       git clone https://github.com/intel/lkp-tests.git
>>>       cd lkp-tests
>>>       bin/lkp install job.yaml  # job file is attached in this
>>> email
>>>       bin/lkp run     job.yaml
>>> 
>>> 
>>> 
>>> Thanks,
>>> Rong Chen
>>> 
>>> <config-5.7.0-rc4-01618-ge86e383f28542><job-
>>> script.txt><kmsg.xz><suspend-stress.txt><job.yaml>
>> 
>> 
> 

