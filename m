Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01652DB84
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbiESRmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiESRmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 13:42:32 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D958674FD
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 10:42:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ff1ed64f82so64695197b3.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 10:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRR4NY7yDeJuzxAqLmOFT/mbzIbGElParQMZFi+rXRg=;
        b=kla6NheQrDwaFjffrh0veuwem6QUEH/9VkM59xyhl7btLGoU78nMrvjf8lJjdv1GPb
         0OIlZ8iK8YQL27Tb8mmshliUxDUQ2178IpR3e/GMZ0ynRSvyrwWTk+TQph7N52hWNd6w
         ETW8EPcl+w3euNnipiYYX8y/7y6WVLtIZ8Ek9cMcBBw+aCvrOT+f7ZElRfVqB5AJwBbe
         Jt9P3rnyzuo9oPAk3smUOWQGy5IqFgWJpHYqaYN+uwLIeKvJz3pCfoFawqjEMfuvcGbx
         4/CToa+KkfVcHVRQivvmgT00waWz6T0Qj87O0BSlrCW8sS0Z54Je3KBvTqM+zMEFfJHc
         ai5w==
X-Gm-Message-State: AOAM5323BYTEYl0vj6AwBw00dHutbG4avy8OsUfgfjC5uPg5MO+/3TYK
        5NWo42hPrdZmphxiE69PulSSEuGyKYnbyj/TbNEerbzNCYA=
X-Google-Smtp-Source: ABdhPJz6mSFBOZO9/V7CfgTB8a13RDAzmy359sA7up9BqV/pGQfhImE4fuNsy81dLjUUjCbtXSxpxXpcaTbqIN0lK7g=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr5739863ywb.326.1652982150527; Thu, 19
 May 2022 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143508.3803894-1-rui.zhang@intel.com>
In-Reply-To: <20220519143508.3803894-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:42:19 +0200
Message-ID: <CAJZ5v0gxkyC3JwUhQo7uiJGkBiGZYh_=EUE+nwC+AbJ+4ywn-A@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] PM/Thermal: Enhance PCH overheat handling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 19, 2022 at 4:35 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> PCH thermal sensor that monitors the PCH temperature and blocks the system
> from entering S0ix in case it overheats.
>
> Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> temperature above threshold") introduces a delay loop to cool the
> temperature down for this purpose.
>
> However, in practice, we found that the time it takes to cool the PCH down
> below threshold highly depends on the initial PCH temperature when the
> delay starts, as well as the ambient temperature.
>
> For example, on a Dell XPS 9360 laptop, the problem can be triggered
> 1. when it is suspended with heavy workload running.
> or
> 2. when it is moved from New Hampshire to Florida.
>
> In these cases, the 1 second delay is not sufficient. As a result, the
> system stays in a shallower power state like PCx instead of S0ix, and
> drains the battery power, without user' notice.
>
> In order to fix this, we
> 1. move the delay to .suspend_noirq phase instead, in order to
>    do the cooling when the system is in a more quiescent state
> 2. expand the default overall cooling delay timeout to 60 seconds.
> 3. make sure the temperature is below threshold rather than equal to it.
>
> Compared with V1, the last four patches are dropped from the series, and
> we focus on the PCH Overheat issue only. Plus, splitted one of the patch
> according to Rafael' suggestion.

All patches in the series applied as 5.19 material, thanks!
