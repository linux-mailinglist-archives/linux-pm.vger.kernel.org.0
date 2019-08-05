Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2583A821A4
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfHEQZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 12:25:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41098 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEQZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 12:25:53 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hufnz-0007xi-2t
        for linux-pm@vger.kernel.org; Mon, 05 Aug 2019 16:25:51 +0000
Received: by mail-pl1-f199.google.com with SMTP id ci3so3998124plb.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 09:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ahDv1JQ0w2AsFEFKjWvYewqWbx39Q78We1s4PnzLIHE=;
        b=p8Apq0tYc+v9R2Co/hG5tx/x2VVBptj5rWh1dqMiODy11/3X7qzVRsD5MWleSTR6c3
         0RIx8KnQ7X5tMA7noYdXla4R8GIUgcpDVV9sR13zjZpHLhKdOXvTRa4B/q+18Eiw9rQ9
         U2ZJvGlkaMT+z66c8vP8Ptqc5QYJIPbDToq8/4tvRy0PG8hm+Eqq9cokldUvKqu1SxEh
         V1XFqdBiZ0qMWQKM9wTI+8UPve1EBT7nezTPiHIYtdFL45N75hKUmK1LTcOh/PyB569E
         DOWaUgm4+bdCPPK08zknt2HNj+x4BAyPHQdpt8F/bjdMn4XPrw15zza3V/WuwnOd4Qg9
         ftbA==
X-Gm-Message-State: APjAAAWzIFPHIb2uZlmd4i/MMAsx3ykraXVYaChbLxU3WCh9RxJIvBTh
        GMM8+ohmXwMBAhFMtTAMyamTjr2A7AfT2Lg3xxWanbID1QPz//noCYnIk8Grh2jIBuLgRrOAaUx
        hKvEy00knQL5zpi1vUOwlIXPxLiZLXSN6nkDH
X-Received: by 2002:a63:1c22:: with SMTP id c34mr30357128pgc.56.1565022349742;
        Mon, 05 Aug 2019 09:25:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGlZdsZ6bGXay0VR9+yR4cNcswW8S4n0UbagMs6pMa5uYImce0UHWrQvcHTxX+l+t8F0knuA==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr30357110pgc.56.1565022349363;
        Mon, 05 Aug 2019 09:25:49 -0700 (PDT)
Received: from 2001-b011-380f-37d3-6851-7bc4-3469-2fa7.dynamic-ip6.hinet.net (2001-b011-380f-37d3-6851-7bc4-3469-2fa7.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:6851:7bc4:3469:2fa7])
        by smtp.gmail.com with ESMTPSA id u134sm82343207pfc.19.2019.08.05.09.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:25:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to
 suspend-to-idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <5997740.FPbUVk04hV@kreacher>
Date:   Tue, 6 Aug 2019 00:25:41 +0800
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8bit
Message-Id: <63E89FFF-9471-4F65-B05D-E99EC5C9EFD6@canonical.com>
References: <5997740.FPbUVk04hV@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 18:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> Hi All,
>
>>> On top of the "Simplify the suspend-to-idle control flow" patch series
>>> posted previously:
>>>
>>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
>>>
>>> sanitize the suspend-to-idle flow even further.
>>>
>>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
>>>
>>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
>>> specification-compliant order with respect to suspending and resuming
>>> devices (patch 2).
>>>
>>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
>>> switch to prevent the LPS0 _DSM from being used.
>>
>> The v2 is because I found a (minor) bug in patch 1, decided to use a  
>> module
>> parameter instead of a kernel command line option in patch 4.  Also, there
>> are 4 new patches:
>>
>> Patch 5: Switch the EC over to polling during "noirq" suspend and back
>> during "noirq" resume.
>>
>> Patch 6: Eliminate acpi_sleep_no_ec_events().
>>
>> Patch 7: Consolidate some EC code depending on PM_SLEEP.
>>
>> Patch 8: Add EC GPE dispatching debug message.
>
> The v3 is just a rearranged v2 so as to move the post sensitive patch  
> (previous patch 2)
> to the end of the series.   [After applying the full series the code is  
> the same as before.]
>
> For easier testing, the series (along with some previous patches depended  
> on by it)
> is available in the pm-s2idle-testing branch of the linux-pm.git tree at  
> kernel.org:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing

I’ve just tested the full series on Latitude 5300, and the additional  
spurious wake up is gone.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> Please refer to the changelogs for details.
>
> Thanks,
> Rafael


