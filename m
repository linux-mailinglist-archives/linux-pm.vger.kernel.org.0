Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68F19FF7
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEJPRW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 10 May 2019 11:17:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfEJPRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 11:17:22 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hP7Gx-0006x3-Ug
        for linux-pm@vger.kernel.org; Fri, 10 May 2019 15:17:20 +0000
Received: by mail-pl1-f200.google.com with SMTP id s19so3865020plp.6
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 08:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ksYfkmpkpH6va/jl6WUWe9ADNC1rlHcm4W2AWAcxsI=;
        b=dwS4RJ39nVwaAvfPkGfROaHBH2XaI5jZ+0WaRhcece+J97Uih6DaViXUSC9DLikiyQ
         jW4FNsgMx3AIlZrjJizoc3pOB+bHMluTD/vIhMuaFX/4T7uMLni83p721tmAQJOeuh3V
         uWUu1L2LBZ3I7WbU/Qz77mzephy2qZ+0IMff2l1s8Aw9eCzUmsZdl0tbznPwMQHsrXZE
         2RzCrv3dglclkmrYOOOwkKtMMbCONEJo4/9P5CDdyjMH5DBdud54hcvcyM3bUy6fLhpB
         jYCXnWUW+fFkRr9XCZUsAZE7IVevba1DmbA505qQTWgfG2xwxelqKDE2Cq99mTpUmqBT
         14zw==
X-Gm-Message-State: APjAAAU4DTPt6mrSzgDxP8Yb9qOXcMWKr0Wvn7ymVa9XXqMBh8zw/VRV
        oUVEeRCcBceDIC6YV7iiVe60vz9o2p463wJMD3MU5Aoci3qXuK0Oz8a7wYRnHE6+5QdMnf8kxRL
        rFheqRZ1bMtwx/JXLNx4/QB2K1JgI50UMQc5t
X-Received: by 2002:a63:d408:: with SMTP id a8mr14221497pgh.184.1557501438678;
        Fri, 10 May 2019 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyh/Bshj4Iu4LZ0+PAJP0YH+FOpi9SNU4iCGkiuMtOOEWfwyyXrJlCA2wUcsW2TXEFDfy/FnA==
X-Received: by 2002:a63:d408:: with SMTP id a8mr14221469pgh.184.1557501438481;
        Fri, 10 May 2019 08:17:18 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id s79sm11301512pfa.31.2019.05.10.08.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:17:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190510140209.GG9675@localhost.localdomain>
Date:   Fri, 10 May 2019 23:18:52 +0800
Cc:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2D197AF-0072-42AC-A844-8D6BC9677949@canonical.com>
References: <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <20190510140209.GG9675@localhost.localdomain>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On May 10, 2019, at 10:02 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> On Thu, May 09, 2019 at 11:05:42PM -0700, Kai-Heng Feng wrote:
>> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a  
>> memory barrier.
>> If mb() shouldn’t be used here, what’s the correct variant to use in this  
>> context?
> 
> I'm afraid the requirement is still not clear to me. AFAIK, all our
> barriers routines ensure data is visible either between CPUs, or between
> CPU and devices. The CPU never accesses HMB memory, so there must be some
> other reasoning if this barrier is a real requirement for this device.

Sure, I’ll ask vendor what that MemRd is for.

Kai-Heng
