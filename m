Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8A5625C8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiF3WDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiF3WDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 18:03:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3350734
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 15:02:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m184so169827wme.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmR9nWCJRvx1cVbS1nar4zM5LTb6LzpRfeA+XNWCvW8=;
        b=QSw7SI9wt9Ou0H5un+bB9AHgyuHX8JxAHbkNA1K26di0ntxBw6Xh4YdBBEwuPN+uOp
         4Q80EvkVM/QeoNHGstVX4oPFRbPcow/2G6Pu6ngi8xs01rlf7Gs+k2f8EJRDQdfNNbcK
         usp6CgCfeNS/6kwbmcwHdxxV1p3e6RfKXQC1fvidPTu7gY3Sq9bWFe42WNNPEzVULZUA
         wSYVms5JDpLU4vrP87qMeJu2neN6zTfyYoSQbYwnX2F58WJPIGY/Qc87chpZMQpBcbfm
         pb4qjQyaISQD/THWBzEUir9KzhWQSYqYYHMFyhKXE/fLlEX6IpeygbAj+w6s7sTKQ+1m
         dk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmR9nWCJRvx1cVbS1nar4zM5LTb6LzpRfeA+XNWCvW8=;
        b=ENWYcXGx/pNZuytDkIUImqtBbGKMcKPH4lqaB3RFN2K3welXZ2dXR6DNmJtBK3kQ+F
         2QmjtaAQA0g2Y0n5VBzaa+b8oXw3km0hH7geUumrFs8wY1rPGCG2NDaq975fZ7ZS5nK4
         g75DwV9IS0RG8JXXNbAuFiuIWkkkDwbaelXgZDoe1pcg7ZqWAMcMXOgga4yNQl6nbFki
         EKCJBo/dUvfZ+Ef4UewT9z0aTjOFswxLz3Fp9wPNKrOM40yl8fkyntIPuvatFnvBbZ8P
         C429DEqSSO8x8NDf4o0gpSUp8jL1LkjC2IRVzMN7xtYwf+5gh2If4QJnVyrTqaCGP/LF
         W6Ig==
X-Gm-Message-State: AJIora8EM03yKbFrAc+iUJMSQd9GskDMDp1WeOTJgrxbAU6ug8WHJCRc
        AxzMK8YkoGo4RhU9oKqtNyrmFQNOUVHqLp5iKdc4lw==
X-Google-Smtp-Source: AGRyM1u72PEELgjnPjS+eqrC3Qje60s8cQXcX86vetUYMQl4XRktkox5UWMrrrm/BS2ATFCsX7adbrMcoP2yK6u7RIg=
X-Received: by 2002:a05:600c:4081:b0:3a0:47c4:8dd0 with SMTP id
 k1-20020a05600c408100b003a047c48dd0mr11967073wmh.178.1656626577281; Thu, 30
 Jun 2022 15:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220630191230.235306-1-kaleshsingh@google.com>
 <Yr3+RLhpp3g9A7vb@zx2c4.com> <CAC_TJvdV9bU2xWpbgrQuyrr6ens9gzDnZT2UzAY6Q6ZN9p7aEw@mail.gmail.com>
 <Yr4SQVjBCilyV1na@zx2c4.com>
In-Reply-To: <Yr4SQVjBCilyV1na@zx2c4.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 30 Jun 2022 15:02:46 -0700
Message-ID: <CAC_TJvdZMr7KyUe7ro7jmFT1z5Gs3YbM9dhbL5Yp-weLvd0T3g@mail.gmail.com>
Subject: Re: [PATCH] pm/sleep: Add PM_USERSPACE_AUTOSLEEP Kconfig
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Stultz <jstultz@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 30, 2022 at 2:14 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Jun 30, 2022 at 01:41:40PM -0700, Kalesh Singh wrote:
> > Our latest supported kernels in Android are based on 5.15 so the
> > config change isn't yet needed. Once there are newer versions with the
> > CONFIG_ANDROID removed I will add this to the defconfig.
>
> Okay. It might be still worth getting something uploaded to gerrit so
> that it's easy to remember and submit whenever the time comes.
>
> Also, what about android running on mainline? Where does that base
> config live?

I've uploaded the changes on android-mainline [1]. We'll submit there
once the upstream changes are finalized.

[1] https://android-review.googlesource.com/c/kernel/common/+/2142693/1

Thanks,
Kalesh
>
> Jason
