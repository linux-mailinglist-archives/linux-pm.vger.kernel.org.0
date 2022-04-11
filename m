Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED274FB21B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 05:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiDKDDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 23:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiDKDDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 23:03:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802D615A
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:01:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so17075369pjn.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bh1s9uxexwTw1ELDK3yJyYhpuulAoc9fKiuOEPmNgmk=;
        b=Qp89A0lArNGWfGInm/+ZtR5F/BeXJGZYtTEShodbwkPxzFGm+OxKgjW0mRLNzh0QAS
         A6mJ20EnwS/OB8/ONbs02zT9QjnGhHDFq/9hC2nt3DC5fDlGcyst7kZLw++u7SqxQD+Z
         ZI1OnsI9qds3pWd11R3Q3uyHkuopQ70uNk/jMwSDrGQxlJy+pfFyj/VJ6FobEs95REsA
         M6wtASkwj8gtSm5XbRKDhUlry/uc/j/802nE95AmDYjQvSCIet2FESG0P7ARjy9MTifE
         tQYu9CrZA0yf5pWxeWwgfu+WLSwKt6nDyjVM8cplHasYZBHcCasHewRTRVIkPBdtyTFx
         FOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bh1s9uxexwTw1ELDK3yJyYhpuulAoc9fKiuOEPmNgmk=;
        b=xvoc5J4cwzlHhJrFq4z7S9ca118KhIio3H9YwIcyMtrBS/QakpDQB5emnhN9SR+CAO
         i1AHKGLahv0NEMLoZR8MYb/HoSuuB830Od4D+dFxbrqolAuMhgM5i1zk5QCpFNq9EU3K
         /dfw0PDVOMtlPRzOO8bgLbplBu9fi4w+I9z9htowO555pLb+p2eeLl9qSQcMPl2L7TCA
         PebGwM54Srcs/0a8wTjeIIHU8kwwhkE6SvXKub6qmhbcVfdorZJEX3wUF17/dNxDbwH5
         cb8t353x1RWnWi4EJRZjMs4dMmemip4sWZRFImbEZ8F2q2vWmcFxGhAU0Xn6SbOBLXJt
         tP6w==
X-Gm-Message-State: AOAM5324hULWRCCAn/Ut0PM7gGhfd9LoNL3J0diDTl9a2LaABKiYgjcz
        O5RT4Wv/Ot3bwkcCTSjVGXJsKQ==
X-Google-Smtp-Source: ABdhPJzHJHUK2MZTnOitY76+0r2LRH2b4+OGdurRvqtMUvXulPu1TmCCKfbn9zMtoEplojrnUVceow==
X-Received: by 2002:a17:90b:38d1:b0:1c9:ba10:353b with SMTP id nn17-20020a17090b38d100b001c9ba10353bmr34159522pjb.9.1649646090350;
        Sun, 10 Apr 2022 20:01:30 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm18265124pjv.57.2022.04.10.20.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:01:29 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:31:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] opp: replace usage of found with dedicated list iterator
 variable
Message-ID: <20220411030128.4n4bsxhdzxdasmn6@vireshk-i7>
References: <20220324071815.61405-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324071815.61405-1-jakobkoschel@gmail.com>
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

On 24-03-22, 08:18, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/opp/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
