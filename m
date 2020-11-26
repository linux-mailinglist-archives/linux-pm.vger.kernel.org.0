Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FC2C538E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgKZMFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 26 Nov 2020 07:05:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgKZMFO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 07:05:14 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kiG1Q-0002qP-1K
        for linux-pm@vger.kernel.org; Thu, 26 Nov 2020 12:05:12 +0000
Received: by mail-pl1-f199.google.com with SMTP id ba3so1406914plb.9
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 04:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2wQOqkLciXhZSa/eX0rv+nPfiTXpG5hQx1UgN703x9c=;
        b=VxPStz+BdhticIJmVkaADREu/rzJQEXy5YLUHylUibZU0BOYcTvNfR0Q9yjz2+rZe9
         n+iA4J8wibK3KgeSTGMkoqrQBqANwN6EGivcbEDxUhijET44Q6WyWuDv7OC0uJrrii/B
         6Y/XxaHh7rpQghWZUAmbHSmti82HGcsb2Im8mTzLCcYYsl9om43cjyhiv0sUNjkmcUaC
         WnCS3KZodSGUsJengO1X5A/ssfLukskrnF8ZTH+v45DrAnZQB20SIb1an6xmtDzVq5zo
         IwEup2ZZfbJ8GNP3BT8dqgT340tVW98VuJC0YtR3yHKTLpJbXW/mkZBqWgR3rw7ua19n
         eztg==
X-Gm-Message-State: AOAM533fBuTF/u8NYCkciuXCKzMIFlbCLsbSrDtetmgBSdMm3UUNAb3A
        u2QkzDzm3HFARyvJehkujfrx0BdnWi9fTDgH8AaoFSY+503VTmwt4cs+REtAI13NNzF/3ftqvJl
        3Fh322yCarifjmPPw8K2WDgRchjKaszZJzEvG
X-Received: by 2002:a17:902:778e:b029:d8:d024:a9a with SMTP id o14-20020a170902778eb02900d8d0240a9amr2482628pll.12.1606392309252;
        Thu, 26 Nov 2020 04:05:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZdbB/oS59J2hcjxdfEHQ3/vuVWVDPkfcJuDonwLSjoic73L1Oi3/WtkoHq0Q1nDSedirS0w==
X-Received: by 2002:a17:902:778e:b029:d8:d024:a9a with SMTP id o14-20020a170902778eb02900d8d0240a9amr2482519pll.12.1606392307554;
        Thu, 26 Nov 2020 04:05:07 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id oc13sm6089197pjb.5.2020.11.26.04.05.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2020 04:05:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201126111053.GA15841@chenyu-office.sh.intel.com>
Date:   Thu, 26 Nov 2020 20:05:02 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
 <20201126111053.GA15841@chenyu-office.sh.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Nov 26, 2020, at 19:10, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> On Thu, Nov 26, 2020 at 02:36:42PM +0800, Kai-Heng Feng wrote:
>>>> 
>>>> What about plugging ethernet cable and using WoL after system is suspended?
>>>> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
> [cut]
>> 
>> I don't think this is right.
>> Isn't E1000_WUFC_LNKC already set for runtime suspend?
>> What if WoL doesn't have it set?
>> 
> After re-taking a look at your description, please let me elaborate more about the scenario.
> With this patch applied, and with sysfs wake up disabled, the expected behavior is:
> 
> 1. If NIC is not runtime suspended:
> 1.1 s2ram suspend -> wufc will be set to 0(no WoL settings), suspend(), suspend_late(), suspend_noirq()
> 1.2 s2ram resume  -> NIC resumes normaly
> 
> 2. If NIC is runtime suspended:
> 2.1 s2ram suspend -> wufc set to E1000_WUFC_LNKC, skip the subsequent suspend callbacks.

Is it safe to keep E1000_WUFC_LNKC enabled here?

From commit 6bf6be1127f7 ("e1000e: Do not wake up the system via WOL if device wakeup is disabled"):

       /* Runtime suspend should only enable wakeup for link changes */
       if (runtime)
               wufc = E1000_WUFC_LNKC;
       else if (device_may_wakeup(&pdev->dev))
               wufc = adapter->wol;
       else
               wufc = 0;

So it has different wakeup settings for runtime suspend and system suspend, either device_may_wakeup() true or false.
Or maybe e1000e devs can confirm E1000_WUFC_LNKC is a safe for system suspend?

Kai-Heng

> 2.2 s2ram resume -> skip the subsequent resume callbacks.
> 
> If between 2.1 and 2.2, the cable is plugged, the user is unable to use WoL to wake up
> the system.
> 
> But if the sysfs wake up is enabled, the code logic falls into the old path, and
> the user can wake up the system via WoL by plugging the cable, and send packages to the
> system. Or do I miss something?
> 
> thanks,
> Chenyu
> 
> 

