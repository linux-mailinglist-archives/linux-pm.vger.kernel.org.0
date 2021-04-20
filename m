Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24997365B61
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhDTOmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTOms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 10:42:48 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A0C06138A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 07:42:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id h13so20848426qka.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JP+ANeZGsccJBmVoGo/R3MoTa5r6RLwf9o2mfl/oBZ8=;
        b=COOJenwoW6uh0/Vq0jN5GTwm1bTMt4rdcgNhpEGTAHhrcnFTGCWvI3UtNLIwTap5Oq
         3NJbypfQIG2Xm1C2yHEKa/jJl4EaBtWa3lgUbYkwroZRR0NaS43fRKwEvDVVXEESfQQz
         xTlubm552SfeYZ28MeqxsGbbuhz2R0UHKJHJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JP+ANeZGsccJBmVoGo/R3MoTa5r6RLwf9o2mfl/oBZ8=;
        b=QRZRode3+ru91Xp4apbi8v0e7d11UxUN7jjsN1/TAG1GMfrkb1LpGxsi1bd3+xd4uC
         lIxmtCtGiV3K4nDnOd8YP0Wgs/2p7gWT1xCWlnU4W0EwIYmmT1BGcSPt2FUuzODgEiea
         jBprXExlFKzALRGO2y//BGzjLIAEd58lsGu5WlaBCvn+w3YF7YE5zpQfasazYmHOD5Ba
         ND+Lth31P++gTYW6sYn566XZ5MmHdHZv6WkBqXqXuy/uwISNBQ6bx7LBPmywRswTvsJT
         vB2UhqPQtESpdgnt6kP8+8+VIQwTdbnOWElcPnVCtFRBplY/U6nXOW0vnjsbJRcq4pzw
         4/Gw==
X-Gm-Message-State: AOAM530Q8mXnkDKKuvGFlCwE1wcvTdkq2tIw2N31mSka2Pt3eghTLk+I
        CHdHeG447gkgbrwNYNyibVT/PxwCb2C/bbKgyLo=
X-Google-Smtp-Source: ABdhPJzH5l6jQWUBOv0JJzlNg3WbGpqgIqRjvadTeAryOnar6niI9K3UG0bw9u4jkyfRcWaq1bwobw==
X-Received: by 2002:a05:620a:e1a:: with SMTP id y26mr18058355qkm.280.1618929736067;
        Tue, 20 Apr 2021 07:42:16 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id p21sm10223024qkp.92.2021.04.20.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:42:12 -0700 (PDT)
Message-ID: <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Date:   Tue, 20 Apr 2021 10:42:09 -0400
In-Reply-To: <20210420143754.GA390118@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
         <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
         <20210420143754.GA390118@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-04-20 at 22:37 +0800, Chen Yu wrote:
> On Tue, Apr 20, 2021 at 09:28:06AM -0400, Calvin Walton wrote:
> > This patch has the same issue I noticed with the initial revision
> > of
> > Terry's patch - the idx_to_offset function returns type int (32-bit
> > signed), but MSR_PKG_ENERGY_STAT is greater than INT_MAX (or
> > rather,
> > would be interpreted as a negative number)
> > 
> > The end result is, as far as I can tell, that it hits the if
> > (offset <
> > 0) check in update_msr_sum() resulting in the timer callback for
> > updating the stat in the background when long durations are used to
> > not
> > happen.
> > 
> > For short durations it still works fine since the background update
> > isn't used.
> > 
> Ah, got it, nice catch. How about an incremental patch based on Bas'
> one
> to fix this 'overflow' issue? Would converting offset_to_idx(),
> idx_to_offset() and
> update_msr_sum() to use off_t instead of int be enough? Do you or
> Terry have interest
> to cook that patch? For Terry's version, I'm not sure if spliting
> the code into different CPU vendor would benefit in the future,
> except
> that we would have plenty of new MSRs to be introduced in the future.

Yes, I believe updating the offset_to_idx(), idx_to_offset(), and
update_msr_sum() functions is sufficient. I can do the incremental
patch for that this evening if nobody beats me to it :)

-- 
Calvin Walton <calvin.walton@kepstin.ca>

