Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A251B7AE
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 07:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiEEGCm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 02:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiEEGCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 02:02:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D02A26D
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 22:59:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p6so3257554pjm.1
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DJlbRmp6+3Ku7mZOSBpo5voOk3dmYpbja2k2cr+R+hY=;
        b=tVLblT2IAPVjFE0z8Er5xu6f00OzfK348X08u09cUXVLZlbXnuyhz3xL2Z6jOjcKPM
         Kx32OSLPEZH04abZ1RiAOIKklKaLeJYttPXfWGOuOVo9J4MrGMO4kVya75eo3ghwsn/I
         bkbQZHiN+M0K54v0ORt3nktwhHBTas+82T4z3dt6eSljRpRuzLhjU3+PuaJ3QdUJB2rf
         L/RabagKv/hVve7Htn8i6KmbbQ1Vrj2/qYSYBtJpxqAniqfwbjXctylEoP8dlYT6A3gD
         90Dj6FgPGZUf1byXGr8Zx0csGmPf5wLZIfdRjRBATQLeGY6V6TuGc5NfsOvAju0NtWEP
         D/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJlbRmp6+3Ku7mZOSBpo5voOk3dmYpbja2k2cr+R+hY=;
        b=HHmz8/7yWWMGk7SSr7FhzZ4BjsEifK4OFQ1y907PxSXRPQgguJMoJmdq4h+BOwh23+
         F/eoEXoDu0UBC7pBk4gZZJGqs8MdtyxYPX+lr5jm/92VjeGoPm4KT1KKDsiTtzD1B9u6
         E6XwqoLxWcHKxppIS4B6j624oEDs/kPb4VH48if+2i0Q4W4FBcJ5anqzoOEjdFbanvuy
         YHC+IAVHVyq7S8OheH//J5L+brRiY2MvM6ffl9d1JZgKm8G+Ylbj1LXryAPaWrzg+h8F
         68/kTtUhrVglcVZNLWjXK/dHcKVhruBWwhpxHhsFMhoSeLfACTN8TmHAHSjK5vL9nbEp
         Z/Ew==
X-Gm-Message-State: AOAM530SW6yT7qsCgKFHt3607+PFZSArGTok3OpfOKprNXWDm5PF1cjk
        LzpzMKwzO333LWCekXUlrU6cSA==
X-Google-Smtp-Source: ABdhPJxb1nYrZgSZdrfyVf9Y3y11nFVIdrhWSc2+Xb/EcWZpTgHkBthrb4gT1LYE01+hvy8iNmyZlw==
X-Received: by 2002:a17:902:ab59:b0:15c:f4f3:7e3b with SMTP id ij25-20020a170902ab5900b0015cf4f37e3bmr26151107plb.24.1651730340773;
        Wed, 04 May 2022 22:59:00 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a000be200b005106b52a823sm86038pfu.145.2022.05.04.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 22:58:59 -0700 (PDT)
Date:   Thu, 5 May 2022 11:28:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-pm@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] opp: add config option for debug
Message-ID: <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
References: <20220504174823.156709-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504174823.156709-1-linux@fw-web.de>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-05-22, 19:48, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
> driver debug and opp floods serial console. This is annoying if opp is
> not needed so give it an additional config-key.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/base/Kconfig | 1 +
>  drivers/opp/Kconfig  | 7 +++++++
>  drivers/opp/Makefile | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)

Isn't something like Dynamic Debug helpful here ?

-- 
viresh
