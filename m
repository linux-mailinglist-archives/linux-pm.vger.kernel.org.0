Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0F365A12
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhDTN2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhDTN2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 09:28:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7008C06138A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 06:28:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d6so10341593qtx.13
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=J/YrRJCz3Qya2ecpGn1yqFyHTDzbSdU1ZISqo4g1zcw=;
        b=odK1x/sVcgFM3hT8erFQ0CAG+e72BD9kBGWC3wvpf6UFqxEs+Yk9JMdnqB0hvBpiAM
         BLz0QPw55dhcOOC9e62yroHiTaRC93zPa5S6wBegSxxSCe1X+qZnl+8eGhgezGEZ4JYv
         lrcWybIbiXN3qVr06x+nqIXCK38ZbdR8a6tCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J/YrRJCz3Qya2ecpGn1yqFyHTDzbSdU1ZISqo4g1zcw=;
        b=Q6Yuk8S2RDPgywdrG8onLXmHEPiALl6kqBoQ33UEiq3/FkztUYvcYiJdtOpZEArHqt
         pT2mJVapNIktD3Yh/Y5cuAYeGsGuXEFxWtZwB7usPjL0j4Zp03TdUpdI0ULM/68/qpJQ
         /cpufEt/6BIam2gtDoK8EgJ8V8QTj17BLXt9QjNNnpPJxjCyZ6aUZqpuscm3ha9uFXS6
         Q4s7tbswOT3Tg5RUx2pWeSDoUNfgyOcMpi/kf5q4HQNEmdHfOmmxoFpsErflSNtYQ2DR
         ZribSIojxaZphyOsDQyC99um4k3izyBGxjrrQY5KRwF0Gw4ni5pI5CyeWty9E11XksMk
         p6JQ==
X-Gm-Message-State: AOAM5307Fxetb2ttszBaMufwNJYfCqWkiYNv39zDJG30h73LBAntFf2X
        w7WaxilYigJuvIUhgYVp3D7MUg==
X-Google-Smtp-Source: ABdhPJyS3XfARXmvKciUsZZHgWGH5RsRTvV3oVCTl+QDfk5VPYoOFw8SZhCBAtAuKZZ8MarAMO9XLw==
X-Received: by 2002:ac8:57c6:: with SMTP id w6mr1211125qta.309.1618925289077;
        Tue, 20 Apr 2021 06:28:09 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id m124sm11028208qkc.70.2021.04.20.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:28:08 -0700 (PDT)
Message-ID: <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>, Borislav Petkov <bp@suse.de>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.huang2@amd.com, aros@gmx.com
Date:   Tue, 20 Apr 2021 09:28:06 -0400
In-Reply-To: <20210420131541.GA388877@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-04-20 at 21:15 +0800, Chen Yu wrote:
> 
> Okay. I would vote for the the patch from Bas as it was a combined
> work from two
> authors and tested by several AMD users. But let me paste it here too
> for Artem to
> see if this also works for him:
> 
> 
> From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00
> 2001
> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Date: Fri, 12 Mar 2021 21:27:40 +0800
> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen
> CPUs
> 
> 
> @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
>  
>         switch (idx) {
>         case IDX_PKG_ENERGY:
> -               offset = MSR_PKG_ENERGY_STATUS;
> +               if (do_rapl & RAPL_AMD_F17H)
> +                       offset = MSR_PKG_ENERGY_STAT;
> +               else
> +                       offset = MSR_PKG_ENERGY_STATUS;
>                 break;
>         case IDX_DRAM_ENERGY:
>                 offset = MSR_DRAM_ENERGY_STATUS;

This patch has the same issue I noticed with the initial revision of
Terry's patch - the idx_to_offset function returns type int (32-bit
signed), but MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather,
would be interpreted as a negative number)

The end result is, as far as I can tell, that it hits the if (offset <
0) check in update_msr_sum() resulting in the timer callback for
updating the stat in the background when long durations are used to not
happen.

For short durations it still works fine since the background update
isn't used.


-- 
Calvin Walton <calvin.walton@kepstin.ca>

