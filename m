Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE251B892C
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDYTyc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYTyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 15:54:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A643C09B04D;
        Sat, 25 Apr 2020 12:54:30 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w4so14377163ioc.6;
        Sat, 25 Apr 2020 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfnbKcCpJbWCQA0NeNDV+FBZxx+MPYQOlwXCT1OUxm4=;
        b=oEnWezvbQ0wLmJ3qpYZUMG6fbo/KEIDRrkdrDctwvp4YFJ9YXWnIq/LA+w0I00Cw0B
         aad4R8G5mNnojDY8/cxBsmY/RSiVeIVuJ5o8q4hp614Bs8LNlsLso3VMks3z+KGINn0v
         ctGRZSO0HmO6lzjhR8Gi9m3nEUICojaY0OfFGtG4LyA3aJrh/CBsBzqrMcymk3lN8ukc
         5sHaRvEBwI7t0MF0KipcbccT2AIcBCkyRGzfrLXsVsT2bdol5TR8M0tZLUW/LarkmKR0
         1CCsknhX4Ymmh9i50cZ7XyfS9zGOS6cnRslBa7hfeMcmb94Pmer7ul2fRfIok0/859Uk
         cosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfnbKcCpJbWCQA0NeNDV+FBZxx+MPYQOlwXCT1OUxm4=;
        b=qc76CmFIfRxePKPZDDvd7Cs3qsOCxqbc3TfukgjEYUl+/mYY+PYePmZ7FcMGMGCE5a
         ft6pNDIfziXDfRdOPW3XwsIVoQrFoLeXDFPUbcVfXXMx4k6bLHj/DfyK8bOFHql/P+np
         oDi/Uh0x9P9RFDtZ7uKzGBdFqWsX+MAh6I0cYSUWfVs3KXEPoZECjS9u3i6CdlsMeBQD
         drkoeXp1X1KXH+4UE0hX76FjebEQCSobMjO9vs6yf2rF2Ieej1pjDmWkZDisk5iKDbLe
         o3DP0kju5YMCViWPXzZyTLuhNbIYtq/yGsUR9U3PQA+FikLYWpSwkDqGYSWum4T89nC7
         kn4Q==
X-Gm-Message-State: AGi0PuYW27zBgi/Pi2isCl6eWu02nToWEEe8avOqnB4te1Q3kHhKxHfS
        MF2uDbVdgsB+SFN7BlI9n75yYF95S2hyQcsM0Zo=
X-Google-Smtp-Source: APiQypJ9fBT7OSqx8QDi4cFo8f9HY1o/iD3UGfefjuzCIkvL6m2Qz8zpz+Fc5LCLfaghvnfs1hSk6OGANzTFANVcYK0=
X-Received: by 2002:a02:cbac:: with SMTP id v12mr13485718jap.103.1587844469555;
 Sat, 25 Apr 2020 12:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587840667.git.syednwaris@gmail.com> <66296904e2ffce670c14576dfc7ea56417c670ab.1587840668.git.syednwaris@gmail.com>
 <20200425192607.qa2jr7ef2g726txr@wunner.de>
In-Reply-To: <20200425192607.qa2jr7ef2g726txr@wunner.de>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 26 Apr 2020 01:24:18 +0530
Message-ID: <CACG_h5pVEQ8+LGogWo4Ea+8OcRz1edudJPWL8SytGdaAc8xabw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] gpio: thermal: Utilize for_each_set_clump macro
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, yamada.masahiro@socionext.com,
        rui.zhang@intel.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@verdurent.com, linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 12:56 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Apr 26, 2020 at 12:35:02AM +0530, Syed Nayyar Waris wrote:
> > This patch replaces all the existing for_each_set_clump8 and related
> > function calls in the drivers (gpio and thermal) with the equivalent
> > new generic for_each_set_clump macro.
>
> Why are patches [3/6] and [4/6] included in v2 even though William
> said they should be ignored?
>
> Again, replacing for_each_set_clump8() with for_each_set_clump()
> does not provide any benefit but may impact performance and makes
> the code more difficult to follow.  So once more, please do not
> change drivers which are known to work fine with 8 bit clumps,
> specifically gpio-max3191x.c and gpio-74x164.c.
>
> Please in the future include a list of the changes you've made
> in the cover letter, not just in each individual patch.
>
> Thanks,
>
> Lukas

Hi Lukas,
Your concerns are noted. [3/6] and [4/6] won't be included in the next
version v3 of the patchset.

Regards
Syed Nayyar Waris
