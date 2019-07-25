Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18EA7507F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfGYOCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:02:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388101AbfGYOCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:02:46 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hqeKR-0002td-88
        for linux-pm@vger.kernel.org; Thu, 25 Jul 2019 14:02:43 +0000
Received: by mail-pl1-f200.google.com with SMTP id n1so26306092plk.11
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 07:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dRGqqRdc8tkI0wtRj4b9pGjBs0cS4r9SniesDI0dk5k=;
        b=J63WGIxkES0I6ERrwE/gV+eA5PmSmpPzIsR/bzZRoycA2p6Neact9J4Ae7OTJ5vvYq
         mHSgpYZFKR1ILTkhpht8moGnRSvopCK++PE5Nta7jASLdjt17GSxcL1pShagcPLgApO8
         inye2pB0KgEpvmttoqjtK80otbq+16MntCuTpU+1O4AzssIGzS0R6sKB7TKEp2XvGeu7
         KMBYv8VEu+Kzvo26gMtjQHw677+Gme7aHiq8ZYxWBKsnzcRLIZhyy1x3kqxURsl560l1
         vxILzJC7kS6pZJFdO3/I3bTEOiXaYCbO38P029jBHkPs0d8wTHPT1HlW+T5t3F0VZkAT
         3OAg==
X-Gm-Message-State: APjAAAUTzO7uGe4kmqT/a+lob1slj0XuQ6mw10PgZcLr1o18zrODsZwu
        rYtVmt+Dau4sshnEUCRTaR75vANxXClm2FdH5o0qGcVKvkMmXbeTrFTnb8lahOtAYIS58KhyQVb
        knoECKzOUzN0MqCqU+iYo1LLFzIWsHmszOdyn
X-Received: by 2002:a63:9e54:: with SMTP id r20mr52056709pgo.64.1564063361877;
        Thu, 25 Jul 2019 07:02:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzqyGieoMSzMW+cs+usTVtQ0tbDQ4xtlJACIElsyAMlDRT8SdSAUIjRG0amm82rcIJMkeA+5A==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr52056676pgo.64.1564063361539;
        Thu, 25 Jul 2019 07:02:41 -0700 (PDT)
Received: from 2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net (2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:160:ac1c:9209:b8ff])
        by smtp.gmail.com with ESMTPSA id e124sm80839839pfh.181.2019.07.25.07.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:02:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2332799.izEFUvJP67@kreacher>
Date:   Thu, 25 Jul 2019 22:02:37 +0800
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
References: <2332799.izEFUvJP67@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> Hi Keith,
>
> Unfortunately,
>
> commit d916b1be94b6dc8d293abed2451f3062f6af7551
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Thu May 23 09:27:35 2019 -0600
>
>     nvme-pci: use host managed power state for suspend
>
> doesn't universally improve things.  In fact, in some cases it makes  
> things worse.
>
> For example, on the Dell XPS13 9380 I have here it prevents the processor  
> package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of  
> course, also
> prevents the SoC from reaching any kind of S0ix).
>
> That can be readily explained too.  Namely, with the commit above the  
> NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also  
> has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
>
> In order for the root port to be able to go to D3, the device connected  
> to it also needs
> to go into D3, so it looks like (at least on this particular machine, but  
> maybe in
> general), both D3 and the NVMe-specific PM are needed.
>
> I'm not sure what to do here, because evidently there are systems where  
> that commit
> helps.  I was thinking about adding a module option allowing the user to  
> override the
> default behavior which in turn should be compatible with 5.2 and earlier  
> kernels.

I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W  
power consumption so at least I don’t see the issue on XPS 9370.

Can you please provide the output of `nvme id-ctrl /dev/nvme*` and I’ll  
test the NVMe controller on XPS 9380.

Kai-Heng

>
> Cheers,
> Rafael


