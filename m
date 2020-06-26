Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85520B545
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgFZPvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgFZPvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:51:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8FC03E979
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 08:51:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so4803959pfn.10
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XAxlC1MAkBAl6Z9ZbNMiLt1VhH78ZvXLCa8bmENOOcs=;
        b=Hsi4QtrreOzY11ynHwkL0CMdjf/kIrwyxTM6xXX9TKIkZe5aas5YoAu9yDDGRTra83
         E4Qxo7UkvrawXS1edP2eBcCdP4v5vSKoVUitveMH5MTrmjyK51Vz0zJiMkBq0SxPpbSW
         9jfdfcgnHoKxZHlN6aa6EzaB3mNEsSO+vs7no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XAxlC1MAkBAl6Z9ZbNMiLt1VhH78ZvXLCa8bmENOOcs=;
        b=AyjA7YfXPsiYhXiOinzkiRIKr2xMkfTMJjjmCZDKR/j/qe280PUCCjK9V5fd7FuwfY
         PqMTLHQiKq1FwhrJEAhspN/v2U9/lmJwu8PmDAQD8/LOKhEavl10nhgIZ3pLfeo5+wsF
         I3Z59CZpOoiSMRkPm2E4ZKD3+13e/Va7BNawqMrmipZSY7WbL9RYf4gQeHorevtU6Jth
         cNx+vJHOsTITiH36X2twCNqI5VB4oAMYLLT1T5YY6KeyG8GjZk+Fkb3TaoVnlSjpacXV
         gb2XqVbTFwsdytIG5Pse8AnjugQKIuxvtiQdgBK2BBN0G23kmnMemnFdqSygTCDhisLC
         fAWg==
X-Gm-Message-State: AOAM531aSl4Um3aZz3zKdMsbhXuRCqEaP2ZVGthvRyHtzkxF+xsHR2gH
        q21pmUXLL78JLlgwoiRs1+n4mg==
X-Google-Smtp-Source: ABdhPJxxMrSdC93H7GSRthDs7Y7l+SXjp35zY5C7tsx6GG0Ns2ZijUO8dbB453QZ+m0OiNq12pTr9g==
X-Received: by 2002:a62:3041:: with SMTP id w62mr3279272pfw.205.1593186711847;
        Fri, 26 Jun 2020 08:51:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm7768157pfk.58.2020.06.26.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:51:51 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:51:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, jic23@cam.ac.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
Message-ID: <202006260845.B573D53@keescook>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
 <20200626084903.GA27151@zn.tnic>
 <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
 <20200626104442.GF117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626104442.GF117543@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 12:44:42PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 12:22:55PM +0200, Peter Zijlstra wrote:
> 
> > > This is too lax - it will be enabled for any !0 value. Please accept
> > > only 0 and 1.
> > 
> > kstrtobool() ftw
> 
> And looking at that, I find it really strange it does not in fact accept
> "true" / "false", so how about this?
> 
> ---
> Subject: lib: Extend kstrtobool() to accept "true"/"false"
> 
> Extend the strings recognised by kstrtobool() to cover:
> 
>   - 1/0
>   - y/n
>   - yes/no	(new)
>   - t/f		(new)
>   - true/false  (new)
>   - on/off
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There were some worries about dealing with unterminated strings when I
did the original conversion[1], but I think those all got fixed.

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://lore.kernel.org/lkml/CAGXu5jJrFv5Y8Q_i3yFYBDmT0+pO05dS3ijB0gOn-huasxZWmA@mail.gmail.com/

-- 
Kees Cook
