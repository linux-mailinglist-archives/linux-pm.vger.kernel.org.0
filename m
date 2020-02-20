Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B231658E8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBTIIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Feb 2020 03:08:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35764 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBTIIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 03:08:16 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4gsX-0001GW-UA
        for linux-pm@vger.kernel.org; Thu, 20 Feb 2020 08:08:14 +0000
Received: by mail-pf1-f198.google.com with SMTP id r127so1965663pfc.11
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 00:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ap9U+phFzhqWDo4fgbwK0bHCPUbHZGx2Chn9f/utSqE=;
        b=WCa0erULXWdqU5RrNOtXiA8ksQtHeAP1m2H9BWAFMyaH54yt9VvHp429pYcLMoIElF
         cpMw/3hRYrFHV+g2nHYHJgouii/JxnYZ3nCk4dJri9NF+TOq8wum9lcrcBVQjR8H/7X8
         W/2HpZZi4xtmlZMrO9ifkygghYb0XEszLXyQJtL7pQ2Ge9255AnZoYaGDHl2XON3ha7W
         HimgbEP/lso7ZfKVcAcl9+e+7/yOzuHxnOlVfdq+R0JxPGGmtDsPp3GApvqgnLsJ0grN
         ki8S0koQzKPx9fW2JdsuGpakm630BBMqReSbNOkPndMLSlMSsHy8V9e2VILng3fBrJvi
         tLSA==
X-Gm-Message-State: APjAAAVtETiGGkpEY85Fsa/mUxstinxZcCdwMZCC0RkKZh8+PEnevTIB
        MQwTe8KCJ2tptQAVNZhRurX7uExX6oF4oXcjIQXFBVndYbpXn+sYkvZ67qNUB/B573ZdkHGLZbX
        0yinI+slKhwyNUNjR06RMBHZM3ZD5MO0eUA8l
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163672pga.15.1582186092305;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5CB2MYi46pbLazZTtP3PKhLmyTFeQsVGMXYGM8GaSr/DT/ckFZWcNpfje4HaQNdbg8P3+gw==
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163647pga.15.1582186092011;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
Received: from 2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net (2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net. [2001:b011:380f:3214:b828:48d4:ee3d:9937])
        by smtp.gmail.com with ESMTPSA id w11sm2415060pgh.5.2020.02.20.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 00:08:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
Date:   Thu, 20 Feb 2020 16:08:06 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> Hi Kai,
> 
> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
>> Hi Srinivas,
>> 
>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
>> asking you the issue I am facing:
>> Once a laptop has a HDD installed, the power consumption during
>> S2Idle increases ~0.4W, which is quite a lot.
>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
>> to do proper power management for HDDs?
> What is the default here
> cat /sys/power/mem_sleep
> s2idle or deep?

It defaults to s2idle.

> 
> Please follow debug steps here:
> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> 
> We need to check whether you get any PC10 residency or not.

Yes it reaches PC10. It doesn't reach SLP_S0 though.
The real number on S2Idle power consumption:
No HDD: ~1.4W
One HDD: ~1.8W

If the SoC doesn't hit PC10 the number should be significantly higher.
That's why I think the issue is the power management on HDD itself.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
> 
>> 
>> Kai-Heng
> 

