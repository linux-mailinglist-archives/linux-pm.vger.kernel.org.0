Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A60659B8B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 19:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiL3S7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Dec 2022 13:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3S7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2022 13:59:48 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DA1B9CC
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 10:59:47 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id e129so2990178iof.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 10:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MK4oifJwOcgMAJLU5hcuFQ8G7NNAj/OrFBTOLL1gi30=;
        b=Pvsot89YqQrYr+wRevxMXm3hx9BiT5GSkXrZKGn8ph2yIRQCPmL3az5xxMfsI2R+N5
         wbM3lbMDB5riOVVqlaZGOVNA+DRrKRlqPOffrmbAwx3TKQXhkPzoyqy4fvXZHp/6smuX
         bV9TqbzQo8D7tG/EQyyesM83+/ixEYoUhAoyrNoPlXx0ckwEQwms8Wxgv49eg4k6rcj0
         MUXvSedPIiWJGxSH85lTEWYEY3UOuE817RwcyRVoICN39wCmRFTYDDw9dCgmS/ALJn/q
         3FwVfJtPq7MvLZ3Itvhx5V8TbQgBwQjhdL5uftSmYp1RidSUqHEQfezm+JNyzDvJUeDm
         dEtw==
X-Gm-Message-State: AFqh2krtQU86Colg3CI1ZBdV25riNhIY5jF+m8VcMap89Gcqe7DokqdH
        uWF7S8XFfR78DzPSR84OEYfHwUnvue0sf9eepwQ=
X-Google-Smtp-Source: AMrXdXvsCFpb/9szGTVxsEz8rdSODgG8ai8X6ImlxNaSdOw3B0lKYxKtvWqudw/hIvjKqJ0NslbpSjxQ5gmJz/Wh+/8=
X-Received: by 2002:a02:3b4f:0:b0:39a:98b:480e with SMTP id
 i15-20020a023b4f000000b0039a098b480emr2498897jaf.125.1672426786633; Fri, 30
 Dec 2022 10:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20221219154620.3630-1-rui.zhang@intel.com>
In-Reply-To: <20221219154620.3630-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:59:34 +0100
Message-ID: <CAJZ5v0gXsvHi_iW06aWFfvmN2MUJ8mK0T6_jHjFhy3qOJWuytg@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] thermal/intel: Introduce intel-tcc lib and enhance
 tjmax handling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 19, 2022 at 4:39 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Currently, all the thermal drivers that access the Intel CPU TCC (thermal
> control circuitry) MSRs have two problems,
> 1. they have their own implementation for the same TCC functionalities,
>    including getting the tjmax/temperature, getting/setting the TCC offset.
>    This introduces a lot of duplicate code.
> 2. they get TjMax value once and always use the cached value later.
>    But Tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET can be changed
>    at runtime for cases like the Intel SST-PP (Intel Speed Select Technology-
>    Performance Profile) level change.
>
> The intel-tcc library is introduced in patch 1/6 for cleaning up the duplicate
> code among these drivers, and it also ensures the temperature is alway got
> based on the updated tjmax value.
>
> Patch 2 ~ 5 cleans up the drivers by using the new Intel TCC lib APIs.
>
> Patch 6/6 enhances the x86_pkg_temp driver to handle dynamic tjmax when
> progamming the thermal interrupt threshold.
> Actually, the thermal interrupt threshold programming can also be part of the
> TCC library, but I didn't do it in this version because x86_pkg_temp is the
> only user for now.

All patches applied as 6.3 material, thanks!
