Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C3220537
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgGOGiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgGOGiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:38:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C7C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:38:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2599330pgf.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2A3+9mh7yY4DJ4BNChsPgiBj6NoPHiNP3Ku5vhAEZsI=;
        b=fHTiNevZHDxEboHxqvUWoy3orjXk5gSBI46aF/9Y4GQlLCOTFoppVfPG7rZK4m/ZK8
         PgaXGu+LY7MGwnGI3qt3tyRT24g7k9jBerVoRojW0jzwCL4bIbRPRH/w/9ePABonlfCX
         ZxfLOO/7BXPNev3nPT42007h0O8o7oBuJDJpGD7udd+a4nGteEPuCfTacEemz6Pl74ym
         Es472qxqt0y/qXxDM2IvUh/oCHlzBnYoTR8nmSZvB/9q76kbmpglBVPqz4pQRf6ddVC6
         1MaNsVeD4zz25LfnmnAmJ8r+yNaKNwPhR01Xf2qhG5PKP5FTSKnHWttmJBg1mMNkKDH7
         mRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2A3+9mh7yY4DJ4BNChsPgiBj6NoPHiNP3Ku5vhAEZsI=;
        b=blKHC9jUQ89JswKJANMak2sDwkWX/+bcOlCN7knPCYAx0jl1nIKhjEHcCeLYO9VWGr
         QeUJdVI6iLrMmjb6p1gqCVtjuve0IT5tG2uYiGEq8EBcK/qPElOw9ZcZVaAqC2kmXz2T
         fIjB6TeqSyaCaF2YGQYZ268onBW/pegj4Mv722VLbDHXvnOHvtSYbceVyIrYdhT8Fyp6
         jZHe63X394jlkdXhQ5PGjsM79SW04Pai95jrFoinfTrnMvCJ3g/T71VgpnGFMJjkyt1D
         TWLNYtzTrHTZJwtzg9kMAGuLYgysAKGiEtcfpP+t8sBpQgBkG+8j8JxPprQsJ19t1se0
         O8jg==
X-Gm-Message-State: AOAM532CINra0ErVlcOK3k/UNIelGf02PnAk43FC+366afiVuNyOiSyB
        MFTZ2xMJx70Wlh016lDI3DzRWg==
X-Google-Smtp-Source: ABdhPJwiES3Dzi7xr3uSng0QWol6Q63ReF9HR9TiEoQfZiYF2zVKPRtW4D1KZgZKAe+SQhn3apRuSg==
X-Received: by 2002:a65:5b05:: with SMTP id y5mr6690468pgq.90.1594795082971;
        Tue, 14 Jul 2020 23:38:02 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id gv16sm934295pjb.5.2020.07.14.23.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 23:38:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:08:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715063800.4vfxie2wrmaqdnra@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
 <20200715063214.GO1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715063214.GO1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 07:32, Lee Jones wrote:
> On Wed, 15 Jul 2020, Viresh Kumar wrote:
> 
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > > 
> > > After these patches are applied, the build system no longer
> > > complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> > 
> > And you need to rebase this stuff of pm/linux-next, as there are some
> > changes in cpufreq.c there.
> 
> It's based on the latest -next.  Is pm/linux-next in -next?

Yes it is. Actually my bad, I based it on my next which didn't had
pm/linux-next :)

-- 
viresh
