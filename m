Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CF686E4B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 19:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBASmE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 13:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjBASmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 13:42:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007D7EC5
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 10:41:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q19so8725275edd.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ehnntGKDa7eVQQXOOpPUsFKwUBTB8JqaOLp9/2yOYY=;
        b=DTd+/4e/1SnRBgPOnGHgrZt3/SmKSOx9lc9nMYZG2Fy3mp9d+TU+hhjX1wchEwAUzs
         b8hdk/wLEYHNSHU+DOvR0QoHimi9RTBefYQKs1Ee/1ZphQ++2Ek7w+LvPM1qaZo0tvQT
         EdtNGvlOUYPlLem7f0ZBLVHMuejFHNJRC5nQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ehnntGKDa7eVQQXOOpPUsFKwUBTB8JqaOLp9/2yOYY=;
        b=WZlOyNWMi7UQOzwhepjzKwFjI4XKFEqWUJZ+8QG6DVR5tsSqE/G4w7BZndnXbBnh7Y
         IO+pbDg78UWTKdn6pnFNjB2frdOhLCE0i1bK40DetQRnjwq4uw4mA7fhP2gvpd+bYYjD
         guw3wRS/XYsrC7MlfjLk/ZGV0Mze24fdR/E7LV15Nnm1sIqOwB4hA2zZ/njgVUrpCMwl
         I44F51HXuHTXupJw3mIZl0COZl4w0knSnxAiECHnJTKNCWSQv6NfNygioMq5DDPnbOBe
         JwdMGYjlOYVDSq2JML6DV0B6THgzMKFt4H6hCkppW+7V4k4r7RDHxR4Q9i0Fl/s/2PAU
         0mDg==
X-Gm-Message-State: AO0yUKX2iLD648FQBBGgE18YQ+5M+j9sQUJPEvGDUvD88kVPOcgGJp6f
        azHZKzNh6qIETvOs2PQbuPdaUu+zh41+ucSqCVQ=
X-Google-Smtp-Source: AK7set/UUVMk7SeOV3LsR7BQqWuJoFeDdoRplx4OSD7Oln1RanpZCuUHqvxd/TTViv78y2pNYDdvAg==
X-Received: by 2002:a50:8ac8:0:b0:49e:ca5:244a with SMTP id k8-20020a508ac8000000b0049e0ca5244amr3043016edk.1.1675276915359;
        Wed, 01 Feb 2023 10:41:55 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm10486304ejg.221.2023.02.01.10.41.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:41:54 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso2095448wmp.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 10:41:54 -0800 (PST)
X-Received: by 2002:a05:600c:a03:b0:3dc:42e7:8d38 with SMTP id
 z3-20020a05600c0a0300b003dc42e78d38mr157425wmp.93.1675276914417; Wed, 01 Feb
 2023 10:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20230201101112.1.Ia7bc164622c8bb2dd7720ecd456672ccfd70fc5b@changeid>
In-Reply-To: <20230201101112.1.Ia7bc164622c8bb2dd7720ecd456672ccfd70fc5b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Feb 2023 10:41:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKDbnw7b_sVWBS2aS4dXqDeDCcQdgKHfU4zvGWa0+S8A@mail.gmail.com>
Message-ID: <CAD=FV=UKDbnw7b_sVWBS2aS4dXqDeDCcQdgKHfU4zvGWa0+S8A@mail.gmail.com>
Subject: Re: [PATCH] docs: cpufreq: Frequencies are in Hz, not kHz
To:     rafael@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Feb 1, 2023 at 10:11 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Though the documentation for the cpufreq files has always specified
> that the frequencies are in kHz, they simply aren't. For as long as I
> can remember looking at these files they've always been in straight
> Hz. Fix the docs.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: git blame shows that this has been wrong since before the kernel
> switched to git. I've tagged the first git commit as Fixes, but we
> could easily just drop the Fixes tag if that's a better way to go.
>
>  Documentation/admin-guide/pm/cpufreq.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Ugh. Please ignore this patch. Somehow I read these numbers many times
and convinced myself that it was Hz enough to actually post a patch.
...but then someone corrected me and pointed out that I'm utterly and
completely wrong. Sorry for the noise.

-Doug
