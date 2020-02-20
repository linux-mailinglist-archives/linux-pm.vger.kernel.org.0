Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A854165CA4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBTLVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Feb 2020 06:21:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgBTLVZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 06:21:25 -0500
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4jtT-0006Wx-Br
        for linux-pm@vger.kernel.org; Thu, 20 Feb 2020 11:21:23 +0000
Received: by mail-pj1-f69.google.com with SMTP id c31so928149pje.9
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 03:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSsVKe5m/fI49zLSWZeeXgxmZuAkrbCjOSeJyTky1JM=;
        b=K5blUZ7o4AfQtI6pKvoRIZBlVu3W1viEe/Cl5iLiTT6fdklwpZOqgCP3KXjAgvZ5qN
         Z3Lw09F0k35pZl6q9HTC2mc1VRUNRKPAJ05fVMTdsyaBiYYjElyYWLRbtNXWj+RKTeVK
         bMLaXB1sP+HjgjrF1dpTQljlRrKRoqWKxlyIk0N7rZf/6JcK8qExr8xj1rSQNE7HMs0Z
         vNU4dR398SSgy6rQLcvfwctYD3fWLTnyOs2ePpI2TWaazafSy9jD9S5ilReiO8z4H1MK
         0tZH4S7dtTowDbpWHRK0IbqpzfYcVw/Y0qcGSXrapSfp3uVQRytR4m/k0eYmSIa47QI9
         hr9A==
X-Gm-Message-State: APjAAAUhN1Nl5e/hCu2Okz1g1mmfRBsqgjpxZ125A8vUTGZ4b1xXJRJk
        B7ozcA2HhsudtskbgxXafKRsAqbhmJuHMyNd/sddV3Qn3+UvPIqcv3BfnvhdClhRTT2BkDoK7Qz
        sOWEs0qJWvyHifBTz3KY2gdQk0empDms1E+el
X-Received: by 2002:a17:902:503:: with SMTP id 3mr31362172plf.78.1582197681512;
        Thu, 20 Feb 2020 03:21:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyOojlmbrBEfU+UtdeK3OKApDHQEphuC9Anq0405U24Th2wQQ/B3DkQ1V9+saRUPwRC1RdxA==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr31362145plf.78.1582197681120;
        Thu, 20 Feb 2020 03:21:21 -0800 (PST)
Received: from 2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net (2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net. [2001:b011:380f:3214:b828:48d4:ee3d:9937])
        by smtp.gmail.com with ESMTPSA id 84sm3445110pgg.90.2020.02.20.03.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 03:21:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0in-v9iu88Wj0gAg_th-E-QWDSHZ_XvgyoOuqE=CZPtqQ@mail.gmail.com>
Date:   Thu, 20 Feb 2020 19:21:18 +0800
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <73F7D94E-65B1-4069-AA97-5A34617308B9@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
 <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
 <CAJZ5v0jXvo0ceNMp=kstTi24Ne7F-ZGMcD0T0TSMpcZZWsJsUA@mail.gmail.com>
 <CA007B3C-C084-429E-B774-70264A9E609F@canonical.com>
 <CAJZ5v0in-v9iu88Wj0gAg_th-E-QWDSHZ_XvgyoOuqE=CZPtqQ@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Feb 20, 2020, at 18:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Thu, Feb 20, 2020 at 11:25 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Feb 20, 2020, at 18:12, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> 
>>> On Thu, Feb 20, 2020 at 9:08 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> Hi Srinivas,
>>>> 
>>>>> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>>>>> 
>>>>> Hi Kai,
>>>>> 
>>>>> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
>>>>>> Hi Srinivas,
>>>>>> 
>>>>>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
>>>>>> asking you the issue I am facing:
>>>>>> Once a laptop has a HDD installed, the power consumption during
>>>>>> S2Idle increases ~0.4W, which is quite a lot.
>>>>>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
>>>>>> to do proper power management for HDDs?
>>>>> What is the default here
>>>>> cat /sys/power/mem_sleep
>>>>> s2idle or deep?
>>>> 
>>>> It defaults to s2idle.
>>>> 
>>>>> 
>>>>> Please follow debug steps here:
>>>>> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
>>>>> 
>>>>> We need to check whether you get any PC10 residency or not.
>>>> 
>>>> Yes it reaches PC10. It doesn't reach SLP_S0 though.
>>>> The real number on S2Idle power consumption:
>>>> No HDD: ~1.4W
>>>> One HDD: ~1.8W
>>>> 
>>>> If the SoC doesn't hit PC10 the number should be significantly higher.
>>>> That's why I think the issue is the power management on HDD itself.
>>> 
>>> I'm assuming that you mean a non-SSD device here.
>> 
>> Yes, it's spinning rust here.
>> 
>>> 
>>> That would be handled via ata_port_suspend() I gather and whatever
>>> that does should do the right thing.
>>> 
>>> Do you think that the disk doesn't spin down or it spins down, but the
>>> logic stays on?
>> 
>> The spin sound is audible, so I am certain the HDD spins down during S2Idle.
> 
> OK
> 
>> How do I know if the logic is on or off?
> 
> Well, if it were off, it would not draw power. :-)
> 
> So IMO it is reasonable to assume that the logic on the drive stays
> on.  I'm not aware of anything that can be done to turn it off,
> however.

Okay, thanks for the info.
I'll ask vendors the possibility to handle it at system firmware level.

Kai-Heng
