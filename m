Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDF1D1083
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgEMLDy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgEMLDy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 07:03:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F83C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 04:03:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d184so7856925pfd.4
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlIWikT098vFFSA85jSYw2HqnT2EWGQ+JN0hGFauhi4=;
        b=GFuLTBUOJBpZdQ9wmW/LZeyQusHib18GNBACb2tTEXg8quP5GJ8vSZcsUEONrOUpl4
         UnkgxFS4x3QBH9apmKDpNutIEVREi7gPdd9qJvwCG6YbVUFu1uygq5SspKcnHhdFIjmK
         k5Su5r4OjkuznDdC9Ucq8XDIBx4xjPpIvI6SZ3tuX4kNDu3LQb0EWgAAwsEg/A/ZEMPV
         8KCbh2K0vvF5eW5x8MB/4oOFkNvA483oosSNVH1IUSWAmVTJcqzGs97IcHaqAb+wSUQd
         tVU5osHwCiVGlfdKWmabMhtI5tEZccpOata0TkurCGu+gDyLiMHdlNzHTYq8lH28wuIF
         ugsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlIWikT098vFFSA85jSYw2HqnT2EWGQ+JN0hGFauhi4=;
        b=rOFNJhbKEjUqUJb99ueGri2gvLSswzFyOAWQQtGGjSIP9Yk4jb/rxGvFAVma/2O68o
         2oqr2lJQYwhddRqpMkHPIS0s1N8x/kMZRpDmi8bKJzJmS9ZbOn6prxqhMGJJRj2nOhp7
         BjCMZLTozxnHwF0PFNlaqO3woidFXUQTVSTht9SqsMzANeEldfVQziUylymUirEKquZM
         mPxYu+0xI1ANxQRpKaOheuf7evdLNuAzwsC86PIBaVS6aNA3rA22uZ+el88GlDcgR5GR
         8jnCRDwigAE1qwroRVbG3lgvj+gkHxwRxSTBgqnMCyct/dN7glSkbZUx0vH3OHDuseao
         M1xg==
X-Gm-Message-State: AGi0Pub1YDgUM7fuHPtM1S0XFERDqjkXqg5AofufZizu/RYjMognNU1x
        KDtecGIoQ9KuCD0w1ctfBxxELg==
X-Google-Smtp-Source: APiQypI8HPSs6xiuK3e+2ILfdrpxWtiobB+9Jgg6w3R0NkhJQoO4DLir7vsN+myJk1m5HKZejXK68w==
X-Received: by 2002:aa7:85c4:: with SMTP id z4mr26905068pfn.199.1589367833478;
        Wed, 13 May 2020 04:03:53 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 25sm14650864pjk.50.2020.05.13.04.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 04:03:52 -0700 (PDT)
Date:   Wed, 13 May 2020 16:33:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513110350.uojo5jaufx7rj5v6@vireshk-i7>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
 <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
 <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
 <20200513101805.GA4803@sirena.org.uk>
 <20200513104015.oyiaimjpspablq5p@vireshk-i7>
 <20200513110039.GD4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513110039.GD4803@sirena.org.uk>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-05-20, 12:00, Mark Brown wrote:
> The OPP code can and should be calling regulator_enable().  If the OPP
> code needs some particular voltage configuration it can and should be
> calling regulator_set_voltage() to tell the core what it needs.  What
> I'm saying is that if when the OPP code enables the regulator it needs
> a particular voltage configuration it should tell the core about that
> prior to enabling.

I see. Thanks for that.

Clement: I will prepare a patch for you to test then.

-- 
viresh
