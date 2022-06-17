Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210AE54F2BC
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380589AbiFQIV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380869AbiFQIV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 04:21:28 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82C6833D
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 01:21:27 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31772f8495fso34726307b3.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sfn7GMrusVnaVZ3R59dUL5lKSrN5bZ+aPyDb3SYy6nM=;
        b=xpland5NonWvppS+w7gJFI9W7rP/TaaG4Z3EhQeHlMBk+FMpRtmvFnokQHJ3UApVUz
         7ZkfB4IpCrAd/WP059is0f47OQQ9d1YYzUspRU394cYx03b7VdIFPTcxEWxKe7XS4adm
         eQC43Lv9ukXbv/rZ+JcMawNS8OvHoJCHXnhd37wE9ram+1NaLXSQDg/zAF0pzIXyvyBh
         9M8YoCeNL2FY7Lx/OWtpz5+7AwX9uAuaMPUmETEjNv/NECTeSPHlvEHU+FTzSxR1WnG4
         OGvKYXPL4CM1HAatZR/6VtYap0t2Ae/UoSzS7iI12tdzmFxOYPW/UU7c+HtYBV5Q8aVA
         Y4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sfn7GMrusVnaVZ3R59dUL5lKSrN5bZ+aPyDb3SYy6nM=;
        b=PIQxqv9fiU8tZ2JW2FJqnrE5cC744FclTYlD+OS+AV1W5vgPvkrfaqMm//cOuXYoYn
         tu6BBE819AWhK5pSdDa5rtnqDPZ1PVq0TkRlwC0Veskfe8q+RWGFCLlu9qIzuF4Fyxo7
         aHBcQmg5UpqrvALPXtu7O5h3Apve8sUMP4/VEoruhSR3NYz4J+2ZZpJvIIjrJBI7DmnS
         krFT6rHnuzInQ/fYT8HqZDV7Mx0UFtOryZ9+vnNT5hIc3Po/7ks5/aP0b8MTsngfqQAY
         sEzYf/OlzroPuUatCFysf3pz/NYzCmlZqTsrWH2UoKlSk2NpWhBKdaERKIR+6nGcwHNR
         B4Xg==
X-Gm-Message-State: AJIora/pvzMNu3V/DoHCKg1N58DgsiBGvK9BJ1UxBxasbNh/Ys7wkRSj
        b47Qlp75h8kx+A1il3mEAzdD3iDwCc5AEM60XlB2hg==
X-Google-Smtp-Source: AGRyM1sLkV5vvPJkuODtT8b8Cam/CTWy9/tfaxzWQs1cuZEi1nu1f5CbgphfMcu2FEdvDvLEJDmwTwnEpMzHJLacvHI=
X-Received: by 2002:a0d:e246:0:b0:30c:5e77:7104 with SMTP id
 l67-20020a0de246000000b0030c5e777104mr10565981ywe.448.1655454086826; Fri, 17
 Jun 2022 01:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
In-Reply-To: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jun 2022 10:21:15 +0200
Message-ID: <CACRpkdaXJh_Qc-DuD7SFsZPM9GBMUgnoufcFKsy3BPUYFHMHWQ@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Saravana Kannan <saravanak@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 16, 2022 at 5:25 AM Saravana Kannan <saravanak@google.com> wrote:

> Since fw_devlink=on is the default behavior and fw_devlink understands
> approximately 24 DT bindings,

How can I see which these are, in the kernel tree?

Yours,
Linus Walleij
