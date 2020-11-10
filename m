Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEFA2ACB29
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 03:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJCfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 21:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJCfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:35:13 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18200C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 18:35:12 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so8861118pgk.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5abO58yRqbqsB7jwHnlBnAcfWXEJFz9EMg24No0yusc=;
        b=ep3gMR1NwZHr9tRuUVA5byL2TFdEqaNjvr5tD5RYeyBhjk4qldjh3u1UhCzQQp70pa
         kBWnd4+7G6HwCdfQElDSdcolyHTg3t8XTvYrsFQVWLl03Md+i1XxQsaW+FP8Z9Tvxwu9
         3b97WmvdFIPs2jYqPrensNXl0MhMjbySXAev60BRXJTfgRDVh++nkhS4fRwjE4o84PUs
         yv2/KjEwx4Be/hsMRNu1WfjPLZ8oRTENihFLHWOJgXYz5emP58bSncDCpePIGou3Sq0Q
         5tdH+EI68nrGdx0edcqeQqZF4wfjWjI+HGe100SJeu5SdSUSnCJ+TIi+82zjeIV4Idh1
         xHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5abO58yRqbqsB7jwHnlBnAcfWXEJFz9EMg24No0yusc=;
        b=ryxDQoYbphgMAbwd1abWnPRKd94L2i5a2ioO5EH8pBvkP61mtBRs9vRLdLc5ZQHJ75
         +5RvtmEZVjfa7aSeiOm3ijgHnCPHkwTA4Dg52IHZSQbY1uOgWmLxha/IrjeXn+EPruhy
         wrwTHG9P+CHhgyVANmhm6FEU+5zp6hLcCZ2P1B+kMLUcU+ps7hdWlyQr9Bsl+AeHTIwu
         M8E8WkoMR/WIaZ+SJhL7dd5VgYnWlvyZ6bcB9UnhxoKEAszbbLaWgYORtBWanWVO7eHB
         fjjFZEW7lv1cRjwD+YypikEWGqKrVLbsuCR6TBJdT1MyPeREVeR4TvX6ijZlFObJH4I/
         tbxA==
X-Gm-Message-State: AOAM532sW0Ws1DuRcn51PvEEP3mA5XkXf2+KZ6NVBYjUeT+F/JoqLxi6
        0YQc52OBNRcOD+7/XY6XDhTlOpnlDBBuNg==
X-Google-Smtp-Source: ABdhPJwt7dkc6E56qPT8Uuax50jb1oWRu0e00VjUZEKJYQ8mmUHookXCJP1K1kHgAb6F9Xy7jjJMEQ==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr2388759pjb.16.1604975711552;
        Mon, 09 Nov 2020 18:35:11 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id z7sm817952pjc.41.2020.11.09.18.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:35:09 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:05:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] cpufreq: Add missing modalias for tristate drivers
Message-ID: <20201110023507.ftw4slfp6zn7txe2@vireshk-i7>
References: <20201103151139.29690-1-pali@kernel.org>
 <CAJZ5v0gxRHUt7dij7zFomXxmCEPVxiTEv+qu8kZESbsE3A+bBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gxRHUt7dij7zFomXxmCEPVxiTEv+qu8kZESbsE3A+bBQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 15:18, Rafael J. Wysocki wrote:
> On Tue, Nov 3, 2020 at 4:14 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Some of cpufreq drivers are tristate, can be compiled as modules, but do
> > not have defined modalias for automatic loading. This patch series add
> > for all those cpufreq drivers missing MODULE_DEVICE_TABLE macro, based
> > on OF definitions, or MODULE_ALIAS for platform drivers.
> >
> > MODULE_DEVICE_TABLE is not explictily added only for speedstep-centrino,
> > speedstep-ich and speedstep-smi drivers as it was removed in commit
> > b11d77fa300d9 ("cpufreq: Convert to new X86 CPU match macros").
> >
> > Pali Rohár (9):
> >   cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: st: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
> >   cpufreq: loongson1: Add missing MODULE_ALIAS
> >   cpufreq: scpi: Add missing MODULE_ALIAS
> >   cpufreq: vexpress-spc: Add missing MODULE_ALIAS
> >
> >  drivers/cpufreq/armada-8k-cpufreq.c    | 6 ++++++
> >  drivers/cpufreq/highbank-cpufreq.c     | 7 +++++++
> >  drivers/cpufreq/loongson1-cpufreq.c    | 1 +
> >  drivers/cpufreq/mediatek-cpufreq.c     | 1 +
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 +
> >  drivers/cpufreq/scpi-cpufreq.c         | 1 +
> >  drivers/cpufreq/sti-cpufreq.c          | 7 +++++++
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
> >  9 files changed, 26 insertions(+)
> >
> > --
> 
> Viresh, any comments?

I found the patches to be fine and marked it to be applied soon in mutt. I was
waiting for the maintainers of the drivers to respond, after that I would have
applied it for 5.11.

-- 
viresh
