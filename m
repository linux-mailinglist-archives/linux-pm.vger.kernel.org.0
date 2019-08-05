Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD382560
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHETOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 15:14:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44101 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 15:14:05 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1huiQk-0006XR-Ou
        for linux-pm@vger.kernel.org; Mon, 05 Aug 2019 19:14:03 +0000
Received: by mail-pg1-f200.google.com with SMTP id 30so53268943pgk.16
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 12:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4dWsHtjse4Kk9Git6Bu5ITVptOPxfe5QlK/iNi9AwCA=;
        b=cn5xGqJ//Mn238/0vXd7MLu2TkJMffFTQgqeCev0bDEnKFV+NiUjj4ans32CP4jG0q
         l2VlRyOupGYo0W5QD9RACL0NGkYxD1TVy3mpoHTXH7AQkLoNQRfJWlU3brTYyH0R7UNc
         GLhgAUtUsMH2gD4u7sphJis/3k6aH27XZ/kYuzeLLbmiJ4OPUOt4TgGX5Hh+fu/5KBfb
         0riT2XSMdSVcivavfJGiETpdvnCaUS5o6Dj7zL87WifpOKVrRJAAKM2IGZnIN8PyG3fC
         7OS4iqH/VHOgI+GTDhAac95QyheTDqp+g42Hw1W5ydjTEWpakIWZzkPkRBWPC2S87o33
         4Gjg==
X-Gm-Message-State: APjAAAUF42Nfr0Y4QeWgjOsCGxBqKFZvnMt5waOnst4q3HGW+PS+xQ+c
        sYOtHPpE/Fgu/8jUXY850UuVwhfiXfbAZen0iZ3O2uOixeo0I+fVmpFugRakdjy1K6D1mJNfbls
        QFZ7O1Wh9bg1QFimDORqBotsxcOZvgOv8snMQ
X-Received: by 2002:a62:1ccd:: with SMTP id c196mr75140048pfc.102.1565032441420;
        Mon, 05 Aug 2019 12:14:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzGckPxqY0vwW+zLWOZY31pM4wFsYRr748iKaZ96qdRFeNpy1KaPsLZQAVzoHYtt2hUH/LOmw==
X-Received: by 2002:a62:1ccd:: with SMTP id c196mr75140014pfc.102.1565032441028;
        Mon, 05 Aug 2019 12:14:01 -0700 (PDT)
Received: from 2001-b011-380f-37d3-6851-7bc4-3469-2fa7.dynamic-ip6.hinet.net (2001-b011-380f-37d3-6851-7bc4-3469-2fa7.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:6851:7bc4:3469:2fa7])
        by smtp.gmail.com with ESMTPSA id b14sm19802255pga.20.2019.08.05.12.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 12:14:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0ipG-MJjERBL9fjx29QktaYEKSmMCbWiEGPHsbF=Xfxtw@mail.gmail.com>
Date:   Tue, 6 Aug 2019 03:13:56 +0800
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Transfer-Encoding: 8bit
Message-Id: <1FA3D56B-80C6-496C-8772-2F773AA8043C@canonical.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
 <CAJZ5v0hFYEv_+vFkrxaCn_pNAbyqmO_cLb5GOLNn_xxRRwjh2g@mail.gmail.com>
 <38d4b4b107154454a932781acde0fa5a@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0jmO4FMOVYs62wkvPrUW81scD2H7cJyRc+tfoj+vODVbQ@mail.gmail.com>
 <43A8DF53-8463-4314-9E8E-47A7D3C5A709@canonical.com>
 <CAJZ5v0ipG-MJjERBL9fjx29QktaYEKSmMCbWiEGPHsbF=Xfxtw@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 19:04, Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Fri, Aug 2, 2019 at 12:55 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> at 06:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>>> On Thu, Aug 1, 2019 at 9:05 PM <Mario.Limonciello@dell.com> wrote:
>>>>> -----Original Message-----
>>>>> From: Rafael J. Wysocki <rafael@kernel.org>
>>>>> Sent: Thursday, August 1, 2019 12:30 PM
>>>>> To: Kai-Heng Feng; Keith Busch; Limonciello, Mario
>>>>> Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-nvme; Linux
>>>>> PM; Linux
>>>>> Kernel Mailing List; Rajat Jain
>>>>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power
>>>>> state for
>>>>> suspend" has problems
>>>>>
>>>>>
>>>>> [EXTERNAL EMAIL]
>>>>>
>>>>> On Thu, Aug 1, 2019 at 11:06 AM Kai-Heng Feng
>>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>> at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>
>>>>>>> On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org>  
>>>>>>> wrote:
>>>>>>>> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
>>>>>>>>> A couple of remarks if you will.
>>>>>>>>>
>>>>>>>>> First, we don't know which case is the majority at this point.  For
>>>>>>>>> now, there is one example of each, but it may very well turn out  
>>>>>>>>> that
>>>>>>>>> the SK Hynix BC501 above needs to be quirked.
>>>>>>>>>
>>>>>>>>> Second, the reference here really is 5.2, so if there are any  
>>>>>>>>> systems
>>>>>>>>> that are not better off with 5.3-rc than they were with 5.2,  
>>>>>>>>> well, we
>>>>>>>>> have not made progress.  However, if there are systems that are  
>>>>>>>>> worse
>>>>>>>>> off with 5.3, that's bad.  In the face of the latest findings the
>>>>>>>>> only
>>>>>>>>> way to avoid that is to be backwards compatible with 5.2 and that's
>>>>>>>>> where my patch is going.  That cannot be achieved by quirking all
>>>>>>>>> cases that are reported as "bad", because there still may be
>>>>>>>>> unreported ones.
>>>>>>>>
>>>>>>>> I have to agree. I think your proposal may allow PCI D3cold,
>>>>>>>
>>>>>>> Yes, it may.
>>>>>>
>>>>>> Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or without
>>>>>> Rafael’s patch.
>>>>>> But the “real” s2idle power consumption does improve with the patch.
>>>>>
>>>>> Do you mean this patch:
>>>>>
>>>>> https://lore.kernel.org/linux-pm/70D536BE-8DC7-4CA2-84A9-
>>>>> AFB067BA520E@canonical.com/T/#m456aa5c69973a3b68f2cdd4713a1ce83be5145
>>>>> 8f
>>>>>
>>>>> or the $subject one without the above?
>>>>>
>>>>>> Can we use a DMI based quirk for this platform? It seems like a  
>>>>>> platform
>>>>>> specific issue.
>>>>>
>>>>> We seem to see too many "platform-specific issues" here. :-)
>>>>>
>>>>> To me, the status quo (ie. what we have in 5.3-rc2) is not defensible.
>>>>> Something needs to be done to improve the situation.
>>>>
>>>> Rafael, would it be possible to try popping out PC401 from the 9380 and
>>>> into a 9360 to
>>>> confirm there actually being a platform impact or not?
>>>
>>> Not really, sorry.
>>>
>>>> I was hoping to have something useful from Hynix by now before
>>>> responding, but oh well.
>>>>
>>>> In terms of what is the majority, I do know that between folks at Dell,
>>>> Google, Compal,
>>>> Wistron, Canonical, Micron, Hynix, Toshiba, LiteOn, and Western Digital
>>>> we tested a wide
>>>> variety of SSDs with this patch series.  I would like to think that they
>>>> are representative of
>>>> what's being manufactured into machines now.
>>>
>>> Well, what about drives already in the field?  My concern is mostly
>>> about those ones.
>>>
>>>> Notably the LiteOn CL1 was tested with the HMB flushing support and
>>>> and Hynix PC401 was tested with older firmware though.
>>>>
>>>>>>>> In which case we do need to reintroduce the HMB handling.
>>>>>>>
>>>>>>> Right.
>>>>>>
>>>>>> The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think
>>>>>> it’s
>>>>>> still safer to do proper HMB handling.
>>>>>
>>>>> Well, so can anyone please propose something specific?  Like an
>>>>> alternative patch?
>>>>
>>>> This was proposed a few days ago:
>>>> http://lists.infradead.org/pipermail/linux-nvme/2019-July/026056.html
>>>>
>>>> However we're still not sure why it is needed, and it will take some
>>>> time to get
>>>> a proper failure analysis from LiteOn  regarding the CL1.
>>>
>>> Thanks for the update, but IMO we still need to do something before
>>> final 5.3 while the investigation continues.
>>>
>>> Honestly, at this point I would vote for going back to the 5.2
>>> behavior at least by default and only running the new code on the
>>> drives known to require it (because they will block PC10 otherwise).
>>>
>>> Possibly (ideally) with an option for users who can't get beyond PC3
>>> to test whether or not the new code helps them.
>>
>> I just found out that the XPS 9380 at my hand never reaches SLP_S0 but  
>> only
>> PC10.
>
> That's the case for me too.
>
>> This happens with or without putting the device to D3.
>
> On my system, though, it only can get to PC3 without putting the NVMe
> into D3 (as reported previously).

I forgot to ask, what BIOS version does the system have?
I don’t see this issue on BIOS v1.5.0.

Kai-Heng
