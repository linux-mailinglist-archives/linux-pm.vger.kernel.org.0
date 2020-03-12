Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3812C1827E9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 05:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgCLElP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 12 Mar 2020 00:41:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49934 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgCLElP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 00:41:15 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jCFej-00011H-Em
        for linux-pm@vger.kernel.org; Thu, 12 Mar 2020 04:41:13 +0000
Received: by mail-pl1-f198.google.com with SMTP id y4so2609987plk.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 21:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HB0cAE4oxL2E4BOZcXbK5oTAfOt5Od5iJ5nMJmPDGQU=;
        b=QWS2c+316TpM222SiMu0a4m5mQ1z1LkWXBSpgNeEvxYlyGHSZZUy6PlWwVqBcX1Pp3
         RhBlVn9Xv/Mi5oK/LQqK8tuq/K+oi1h8kh2qIRO227bIRKZ7k+eKuAeEV0QF9brF+7OT
         UKovWYCr7d6EJKNHIRQjuOfzKL04glV3UYTLvtGL3l3J/A0YyIRUpN8PJ4FLUTsPEA68
         O/5PVwJDpo5qEpe6MGOY7BTf5dCyBqSaGT6HWZ7ZBvUMH2+ckbKeGIx6j4v2jlJ2yhoF
         JJkkt5It56QkTlDhs6m+g3a21RJbicUMO9xPQHRoNkVa4BBiaMbNLFkUc2LGXYq5fLQL
         WL+A==
X-Gm-Message-State: ANhLgQ034nBpZIs4pHu7hNsQsPtEGSfALQG5FqPIycS+y4Ku0rYIGOwg
        GYttC1/MQyVWLNv6Fny+45F03l9lXWIkLfzO4T06rKKPnENsC20NBuOzedQ8e6LT2St5EBneRVv
        321vs300fpzBLtY7JdZIvHaJ0ErXxC3NxtiVf
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr2197055pjp.40.1583988071819;
        Wed, 11 Mar 2020 21:41:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstoaA6BePG06bC3hsSjV/viLf5I9daEAx7zXmau8SeMcp8CM/i4NX78y75f/5fk4LliXcOoA==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr2197033pjp.40.1583988071462;
        Wed, 11 Mar 2020 21:41:11 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q9sm50973886pgs.89.2020.03.11.21.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 21:41:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200311103840.GB2540@lahna.fi.intel.com>
Date:   Thu, 12 Mar 2020 12:41:08 +0800
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
 <20200311103840.GB2540@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Mar 11, 2020, at 18:38, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
>> Hi,
>> 
>> I am currently investigating long suspend and resume time of suspend-to-idle.
>> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
>> 
>> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
>> 
>> 	/* Avoid direct_complete to let wakeup_path propagate. */
>> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
>> 			dev->power.direct_complete = false;
> 
> You need to be careful here because otherwise you end up situation where
> the link is not properly trained and we tear down the whole tree of
> devices which is worse than waiting bit more for resume.

My idea is to direct-complete when there's no PCI or USB device plugged into the TBT, and use pm_reuqest_resume() in complete() so it won't block resume() or resume_noirq().

> 
>> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
>> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
>> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
>> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
>> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...
> 
> Which system this is? ICL?

CML-H + Titan Ridge.

> I think it is the TBT root ports only that do
> not support active link reporting. The PCIe spec is not entirely clear
> about root ports since it explictly mentions only downstream ports so
> one option would be to check for root port and that it supports gen 3
> speeds and based on that wait for max say 2 * 100ms or something like
> that.

So 200ms for rootport, but still 1100ms for downstream ports?

Kai-Heng
