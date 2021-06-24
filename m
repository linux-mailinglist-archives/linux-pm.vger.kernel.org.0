Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D393B24C8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFXCQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 22:16:21 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:47958 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXCQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 22:16:21 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 22:16:20 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id B2E208E9;
        Thu, 24 Jun 2021 10:06:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [10.4.23.202] (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P12363T139710624155392S1624500379526366_;
        Thu, 24 Jun 2021 10:06:19 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f5da0c6db39b3ea47ff3dce015b91dc9>
X-RL-SENDER: pingshuo@uniontech.com
X-SENDER: pingshuo@uniontech.com
X-LOGIN-NAME: pingshuo@uniontech.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] hibernation:stop resume screen during hibernation
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210622124547.28317-1-pingshuo@uniontech.com>
 <CAJZ5v0gnYHmbWANVkoG+6XrUNzBB4__uM0Ladrpn5=L0KEiefA@mail.gmail.com>
 <20210622134703.GA12358@duo.ucw.cz>
From:   pingshuo <pingshuo@uniontech.com>
Message-ID: <f1ac4975-775e-93c4-c3a7-8b3438b6373d@uniontech.com>
Date:   Thu, 24 Jun 2021 10:06:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210622134703.GA12358@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



>> The display will be woken up during hibernation.
>
> That actually depends on its driver.
>
>> if the computer equipment is poor, it will cause the screen to flicker.
>> Skip to resume the display devices in "thaw".

> But this patch looks like a proof of concept rather than a proper solution.

>This needs to be done more carefully.

When entering hibernation, the display screen will be off first, then 
will be on (the image data is written to the disk at this time), and 
finally the display screen will be off again.

> If you want to deal with PCI devices, that needs to happen at the PCI
bus type level in the first place

what is the "PCI bus type level" mean ? Do you mean to modify it in 
dev->bus or dev-> bus -> pm?


  We tested different graphics cards,like amdgpu, radeon,i915,nvidia, 
this issue occurs during entering hibernation.
Based on the above test, several graphics cards will be resumed and the 
screen is on, so we add code here.
Did you have any idea  if these code is added in here ?




Please answer a question for me.

Resuming device is to write the image to the disk. Is it necessary to 
wake up all devices? Why not just wake up the devices related to writing 
image?

Anticipate your response.

thanks,
                                                               pingshuo


