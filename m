Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C404220917
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgGOJqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgGOJqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 05:46:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EAC08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:46:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f16so2720580pjt.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWnhM4Btcn3KfukFrZhTbpY1jJowoLtpnNYgibe0Pxs=;
        b=z1cupcai6HHUX//qj/D4T1z0bqa+rnb8fjTtufSVinJuRHpi/N41f5hA2qY4tthIto
         Yf9o+zwKieu/jQxj4hPFUp3nn3Iagk6vS0YcWV0DjFzXyg6UOwxrH6dVWIK8PaDH4A4I
         pSSeTCk3O27Gp6HYNvH9GennQjh5iz9vbHSmSmP7wH6XQSrDlNW8i/NMgDdGfK5bqUFt
         82HrkqRQvCnSoIlFGdC05B2GeBnTK4cxtAmfBUItbjBFxx/WCEzbPUaFpR7ToXuYmoZX
         MjSfh6oYYVzgAj24toqUyKYxEA7cOaTydj81Un4gsCHQbZrgR7D0x032z5wRj7aM4xnp
         vJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWnhM4Btcn3KfukFrZhTbpY1jJowoLtpnNYgibe0Pxs=;
        b=nVsgz9o0f2K1TRbE1yt619w2FgpbJ3MDF8o197pdAtL+o7xEwZa+Mt0iePjs0Fzgfg
         FbcAw+JzTCEe4aoYuRQBm26rESu1Ssovfq9rqcUy2XITfjKRnbGZTWOU88uuCiWNTQ9S
         mcGYf1SjVO6fDt7KNv3iL44kafLzbRhKMmkajA/NGlDdLKP2V9h1oDLRDhpJElMHxNV5
         trrnh17ANvMdeInPQ/+sa5K2opdV2KslSzjhhAYjnATAaOSZON0lWjL+6fyMKxNKNOyq
         k0T5fgJe6EHZV3ZMjOskSdWOm357EAYfgaoUTSqgkrhftXIAxqkTLqzsNQVeUL7XqvjM
         +sCA==
X-Gm-Message-State: AOAM532HN0bs9ChxE+umtvWbv5FNOd5H8vk5AiUBRJgP2vqbBPS+hWrL
        P9Pf/VmnmWhXamo2ro7FYO1GTcCN6q0=
X-Google-Smtp-Source: ABdhPJyvmICM19LIRTnE4F/GGqLFbGi1ZydK84ycWBO8vErTCcVb4+nGPrhOrY44n3iA0Sn1KjiLWA==
X-Received: by 2002:a17:90b:3750:: with SMTP id ne16mr9222121pjb.6.1594806395785;
        Wed, 15 Jul 2020 02:46:35 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id f14sm1543484pjq.36.2020.07.15.02.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:46:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:16:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715094633.s2xyn4wetafphpdt@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 09:26, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> 
> Hurrah!
> 
> Changelog
> 
> v1 => v2:
>  - Collect *-bys
>  - Use __maybe_unused instead of removing device IDs
>  - Use __always_unused instead of using unused variables
>  - Include architecture header instead of creating new include file

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
