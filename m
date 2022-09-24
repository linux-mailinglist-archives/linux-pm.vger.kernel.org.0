Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938C5E893C
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiIXHkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiIXHkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 03:40:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61E56B8E
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 00:40:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y2so1362012qtv.5
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=LwRw4I7ys8LuierT/yOkLB8imLHYXeUA/oaMPxfDLwQ=;
        b=Sh5AR2Zm3S2Y0FZ38wwlF6Hh4AwwDQ7NSGkLuBD+8aFe9/tQN3JoXHMjbkDiaGysAQ
         y7uwEvpNHJ/7tH4YCwal9cQPc059Qz+sB9nQVQnhIvLsLN5aSh85pl7J9vMgYHYNl586
         vL2kEo/vi0jD0dgMxjyLpmolpPgtJwYsUFvSV29n67MbpC0AIZtOa+g4aCXsQRw7Rf6+
         yYSDGR0PVbSsy+I4W/cDCHxi2vIPy57CBWD6QjkgsOawfPA8F56RzrNjvClQkEs6hsRL
         Pz85faVqWZLs2/Z0jGy0l6yWmvzApdH0VJ8agMm2Jpt2jQDXylUDCilyANuoF5DfiKQH
         6SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=LwRw4I7ys8LuierT/yOkLB8imLHYXeUA/oaMPxfDLwQ=;
        b=Q0/lao+zbM4V4NWbKemsIg5/2B13RP6vvKUPBTJhxFqU+lu3WUGxN8VAHuUTMFIEfh
         +pANn3UO2+eIJNdhuGntP+x+EJK4vr0kIknnYY9+Vec2pTrV1XqKN1P8X2cqEoADKTyX
         htOvo2jaOz1xUm9p7LZJfVpRH5TfE9Qxh4B0kgTOEEbSQRA6rupGKspFJMeMEmioa1GW
         snCXcmgCWT3RVmmna0k97VIcp97N2pOJ1EZEqU+ZOlSTiBjeIP4YJoqvBX3ljATwIgXJ
         jrQ9uF6Z3ONUKWml0u3ZIlJUZxVL5/CjFkNiC9d/otWTJtcWJGeOckua7bRVyff7xAVi
         3emw==
X-Gm-Message-State: ACrzQf3BCBMsx/I7CRgEUM/Ep7EdqcGqfcOqjHhZKl2QKc2IzBW1Mic2
        mqh3OhDUHcTLaHhFFyqGKCg5Ig==
X-Google-Smtp-Source: AMsMyM5eH3KoXCCdC3I9tQ677imJ9vsalaonClnjV8QJ6jv0XBWsKRt7/OSSIQYaz/u1AQ9pT19UVA==
X-Received: by 2002:a05:622a:1991:b0:35b:a3d3:4b0f with SMTP id u17-20020a05622a199100b0035ba3d34b0fmr10179530qtc.358.1664005206574;
        Sat, 24 Sep 2022 00:40:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bp36-20020a05620a45a400b006bb78d095c5sm7583393qkb.79.2022.09.24.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 00:40:06 -0700 (PDT)
Date:   Sat, 24 Sep 2022 00:40:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Borislav Petkov <bp@alien8.de>
cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: INFO: task systemd-udevd:94 blocked for more than 120 seconds.
In-Reply-To: <Yy4MNp6yiRTJxeXa@zn.tnic>
Message-ID: <28d03f8d-ed70-cdc8-70d3-7b1723e5715@google.com>
References: <Yy4B+9yH8oT0F8nQ@zn.tnic> <Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X> <Yy4MNp6yiRTJxeXa@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Sep 2022, Borislav Petkov wrote:
> On Fri, Sep 23, 2022 at 12:18:56PM -0700, Nathan Chancellor wrote:
> > I have not seen a stacktrace like this on my machines (although I
> > suspect that is because I don't have CONFIG_DETECT_HUNG_TASK enabled in
> > my configs) but my Honeycomb LX2 hangs while booting after commit
> > 78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip()
> > function") according to my bisect, which certainly seems like it could
> > be related to the trace you are seeing.
> 
> Don't you just love how well our community works - one reports a bug and
> someone else has already bisected it and thus saves one the work?!
> 
> :-)))
> 
> Thanks Nathan, I can confirm your bisection. The commit above doesn't
> revert cleanly ontop of linux-next so I tried it and the patch before
> it:
> 
> 78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip() function")	<- BAD
> 62022c15f627 ("Merge branch 'pm-opp' into linux-next")				<- GOOD
> 
> so it looks like that one is somehow b0rked.

Yes, Nathan was alert, and saved me too from bisecting failure to boot
linux-next in another thread.

And I see from
https://lore.kernel.org/lkml/c85a77a3-409b-3e83-08a7-ac7e1888790d@samsung.com/
that Marek also found it: and tried to fix it, but found it goes too wide.

I made a patch of the offending series with
git diff 78ffa3e58d93^ 2b109cffe683
and then reverted that cleanly from next-20220923: works for me.

Hugh
