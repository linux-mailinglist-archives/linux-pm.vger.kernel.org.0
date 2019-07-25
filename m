Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866B1756BF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfGYSU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 14:20:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52296 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 14:20:27 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hqiLo-0003O1-Pt
        for linux-pm@vger.kernel.org; Thu, 25 Jul 2019 18:20:24 +0000
Received: by mail-pf1-f200.google.com with SMTP id 191so31420689pfy.20
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 11:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yHwUWcK6j/+zNvZlc0CX0T3xuIfR8a85ZfPN65Yms3g=;
        b=b6zp++y/2ovLIET7rhOafOTk8Q67NG4pZ8eYAlBSehAhUQwBGpB05Gx6ZQwYyBKTeF
         lUTVZDKo/wpxdEjAy2c0pqY3BzqJiVn3U53n57g+4bDAO9It+H2E3XnmXL1KcI3Mw8cd
         xqe2g0Wdo8J8sH5iOT+by7tWMgCKan0pnt2YA+dPhzMpkaAX+bbRev1Eo2b8Fo/fjJQb
         xusF/ugZ/klfqaBPrVJ/jQFvBWszTNvu/vBKOST6Rz3vAPfttYEEm3R+k4cw7I9P61H6
         D61iPxY4bwmu+bhlC068geewDtQwlVq18O1GWRy9Pgl3CM4jn8rgZ5icJNUIx8xlyX6f
         o5rg==
X-Gm-Message-State: APjAAAWUResdkqdTtyKcMa+TGnHBmVSNS1keRkXlUwoEXkG0rpkdl0To
        dffnTin3lFWqA5KHvs0rVwSI4dYSZ0r3VcFdMKPrQXmM/HiheyBEVYCrMbXFBmGK23gkhjb/iF9
        r0zxMJjK13Z7GZIq3knWfxccc+igMsxg0FS9I
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr91872314plb.269.1564078823520;
        Thu, 25 Jul 2019 11:20:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxi37g49T7GHIfRwJpako8OJ/ChT4uQFaHZ0fVnv2FoR0sjZP8k3dyyCZUHaqCLhBSId7/zeg==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr91872285plb.269.1564078823186;
        Thu, 25 Jul 2019 11:20:23 -0700 (PDT)
Received: from 2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net (2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:160:ac1c:9209:b8ff])
        by smtp.gmail.com with ESMTPSA id j16sm38449307pjz.31.2019.07.25.11.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 11:20:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
Date:   Fri, 26 Jul 2019 02:20:19 +0800
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Transfer-Encoding: 8bit
Message-Id: <46857EDA-081E-4622-A8D7-D337127A38DE@canonical.com>
References: <2332799.izEFUvJP67@kreacher>
 <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 01:03, Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Thu, Jul 25, 2019 at 6:24 PM <Mario.Limonciello@dell.com> wrote:
>> +Rajat
>>
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Thursday, July 25, 2019 9:03 AM
>>> To: Rafael J. Wysocki
>>> Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-
>>> nvme@lists.infradead.org; Limonciello, Mario; Linux PM; LKML
>>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power  
>>> state for
>>> suspend" has problems
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>> Hi Rafael,
>>>
>>> at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>
>>>> Hi Keith,
>>>>
>>>> Unfortunately,
>>>>
>>>> commit d916b1be94b6dc8d293abed2451f3062f6af7551
>>>> Author: Keith Busch <keith.busch@intel.com>
>>>> Date:   Thu May 23 09:27:35 2019 -0600
>>>>
>>>>     nvme-pci: use host managed power state for suspend
>>>>
>>>> doesn't universally improve things.  In fact, in some cases it makes
>>>> things worse.
>>>>
>>>> For example, on the Dell XPS13 9380 I have here it prevents the  
>>>> processor
>>>> package
>>>> from reaching idle states deeper than PC2 in suspend-to-idle (which, of
>>>> course, also
>>>> prevents the SoC from reaching any kind of S0ix).
>>>>
>>>> That can be readily explained too.  Namely, with the commit above the
>>>> NVMe device
>>>> stays in D0 over suspend/resume, so the root port it is connected to  
>>>> also
>>>> has to stay in
>>>> D0 and that "blocks" package C-states deeper than PC2.
>>>>
>>>> In order for the root port to be able to go to D3, the device connected
>>>> to it also needs
>>>> to go into D3, so it looks like (at least on this particular machine,  
>>>> but
>>>> maybe in
>>>> general), both D3 and the NVMe-specific PM are needed.
>>
>> Well this is really unfortunate to hear.  I recall that with some disks  
>> we were
>> seeing problems where NVME specific PM wasn't working when the disk was  
>> in D3.
>>
>> On your specific disk, it would be good to know if just removing the  
>> pci_save_state(pdev)
>> call helps.
>
> Yes, it does help.
>
>> If so, :
>> * that might be a better option to add as a parameter.
>> * maybe we should double check all the disks one more time with that  
>> tweak.
>
> At this point it seems so.
>
>>>> I'm not sure what to do here, because evidently there are systems where
>>>> that commit
>>>> helps.  I was thinking about adding a module option allowing the user to
>>>> override the
>>>> default behavior which in turn should be compatible with 5.2 and earlier
>>>> kernels.
>>>
>>> I just briefly tested s2i on XPS 9370, and the power meter shows a  
>>> 0.8~0.9W
>>> power consumption so at least I don’t see the issue on XPS 9370.
>>
>> To me that confirms NVME is down, but it still seems higher than I would  
>> have
>> expected.  We should be more typically in the order of ~0.3W I think.

 From what I’ve observed, ~0.8W s2idle is already better than Windows (~1W).
0.3W is what I see during S5.

>
> It may go to PC10, but not reach S0ix.
>
> Anyway, I run the s2idle tests under turbostat which then tells me
> what has happened more precisely.

The XPS 9370 at my hand does reach to s0ix during s2idle:
# cat /sys/kernel/debug/pmc_core/slp_s0_residency_usec
15998400

So I think keep the root port in D0 is not the culprit here.
Maybe something is wrong on the ASPM settings?

Kai-Heng
