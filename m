Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5823695ED
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhDWPSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhDWPSh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 11:18:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1AAC06174A
        for <linux-pm@vger.kernel.org>; Fri, 23 Apr 2021 08:18:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t17so21454356qkg.4
        for <linux-pm@vger.kernel.org>; Fri, 23 Apr 2021 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TT/GtDW+dzXPPtJ2iwcN+nceLp9c+oAutwWNCDukYyg=;
        b=azsqOrerHPonKjkL3KRPNV07IBqcBLt/gw8Z9MYXp6y3fdmyWbrZfDfSM0TxTHXmev
         +ljyZUyTJ8OZGNp7zEjgCLXMMmZqOgd8mhN7W5Sem7lrhYK7Xj+3t4kHK+B/92CpPDGK
         pAhpHDr3LYXBCLkS41kDFrPEvLBsoYHNkXJ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TT/GtDW+dzXPPtJ2iwcN+nceLp9c+oAutwWNCDukYyg=;
        b=sHpdTDx22jidpUdL2iWE5aJc7+uzFl11P2jrr/mPo8lYKm4iBgp9ykbmlRWaQrGJVU
         3mbMlST15uilkE2P7amDMBFDfNUN74w6vYYAZ4a4aCoM5y9D/sHfVxYQ+Jxug6w5ZQU1
         bVTaYNHJULIuasyiaY4vwr5iI8MqMuAMqzaV/lFFtYMp7qm39OfhYnRMplq2oFk5KiKC
         2nvDru0WYRdrMDImqmaXFUOMg6RxQimpktHXQYo4nOMxG+74iMvexsFopWEG48KyleqH
         I5H6l0CqgNvqa+69wf2Xxcz+6iJGFdUA4JafjhtXElUkv34NA4ZSF6eer4jOxOwQ53N5
         JI8Q==
X-Gm-Message-State: AOAM532UpJ4CoM6E/lJ94G16h3S2eqkkgA2VTkz4gzthFIdf5M+cYOi0
        c9vIkAS8UiSAhvHKNSvnFrXILA==
X-Google-Smtp-Source: ABdhPJxyIpQYgKWWsTPkumpoKvftQ+cl9Dw4/xEq46VfygDPTc5cJQm1OUxc9HVQZn6OQYRBD2TLnA==
X-Received: by 2002:a37:8905:: with SMTP id l5mr4732784qkd.321.1619191080526;
        Fri, 23 Apr 2021 08:18:00 -0700 (PDT)
Received: from sasami.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id o189sm4372567qkd.60.2021.04.23.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:17:59 -0700 (PDT)
Message-ID: <8fb9a5d2a46216c1ce3f63b621ff9d35c1f863a9.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Date:   Fri, 23 Apr 2021 11:17:56 -0400
In-Reply-To: <20210423142749.GA428460@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
         <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
         <20210420143754.GA390118@chenyu-desktop>
         <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
         <20210423121607.GA426003@chenyu-desktop>
         <4080ac25f6c8ca4088a950eb9d63da641c020941.camel@kepstin.ca>
         <20210423142749.GA428460@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-04-23 at 22:27 +0800, Chen Yu wrote:
> 
> This patch fixes this issue by converting the 'int' to 'unsigned int'
> accordingly.

NAK on this version of the patch. It needs to be off_t; see my
conversation with Boris elsewhere in this thread.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

