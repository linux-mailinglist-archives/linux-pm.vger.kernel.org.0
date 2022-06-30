Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBD562472
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiF3Ulz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiF3Uly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 16:41:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97E6426
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 13:41:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i1so237097wrb.11
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sxgvUgX/lE05DRaRDrj2PDjJhleRoRRDvjJlfkAEzg=;
        b=GZYjjHKfVCa+9zANi+gEoiM5SSOKOGDkVkDe96gkOxIAHoB7CZIO/YgR4LY48B9PT6
         ZYIxvmRzX9/oZ9OVThsoJ3x6/jtWmvKCmj55r7O9XNary8Z+YA71JG1/7w2y1jswy8Fa
         DUNp5eCuf3t1wycrDiBa8yTy/Qluga4rZcDmiX8XJi/PepFFuBWfc0HRW1jeSfA7pTiy
         1fHCyUP398gvCkEE1aqi0roDUYpIMNQrTPjMwCLMvEvJU5WtHddYn0FmQwrd1coZiTCd
         843Vj2wDV01tIemZ6LaCV8aXVHynHFeU90CWZmsrm2zQTvIE8/lsZPr7gcUPBKWd6isB
         rdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sxgvUgX/lE05DRaRDrj2PDjJhleRoRRDvjJlfkAEzg=;
        b=zfOdkdBhFPAidQYzi5rQNgGBh2Lyr3WJrlWD3S8JAXwdF7+LiHkpOODTjZeGPRP1y0
         FFOvX8fQ0ziOZpK93J8sDckKqOMBcurCy9LVjngWaWxlMm341TrSkSHiBYsrVdOdFlhN
         HqGtalxQU2JF2UNVSk7kvgCkrGalyqRI9Ntl+7sy/r1Eh6g1KlnKejUQbXtH2K/TywfT
         7AgxhNkpc8ymqWjyyMyNnG/8CgiWta09mtR+gn7S3UGJuDsSWavPYY6nvGQAbvZuKydE
         vN4ZHw19o6/nqdg7xOVLhn6ai7MuYwyoawbNJTrfrxQoSVVdktgdTGB+Sh0guaUZr7Iw
         st7Q==
X-Gm-Message-State: AJIora/fILGsYT/aTvNcigASQq54eTr/dIicfJ9lyav3rCun2jh19Lpa
        ikki/1dWX9X9Sfsp3kBy3WKPhirhMJuiK0l7TMR1Hw==
X-Google-Smtp-Source: AGRyM1tPLbfsN2BJnOcFOWFvfQT8AJ8Pw9fqyeaUEOZa832kPW4lB+7bPTChF3jB0KOvv6fyB662Q1iQc2L8Imbuj7A=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr3367565wrf.699.1656621711704; Thu, 30
 Jun 2022 13:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220630191230.235306-1-kaleshsingh@google.com> <Yr3+RLhpp3g9A7vb@zx2c4.com>
In-Reply-To: <Yr3+RLhpp3g9A7vb@zx2c4.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 30 Jun 2022 13:41:40 -0700
Message-ID: <CAC_TJvdV9bU2xWpbgrQuyrr6ens9gzDnZT2UzAY6Q6ZN9p7aEw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 30, 2022 at 12:49 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Kalesh,
>
> On Thu, Jun 30, 2022 at 07:12:29PM +0000, Kalesh Singh wrote:
> > Systems that initiate frequent suspend/resume from userspace
> > can make the kernel aware by enabling PM_USERSPACE_AUTOSLEEP
> > config.
> >
> > This allows for certain sleep-sensitive code (wireguard/rng) to
> > decide on what preparatory work should be performed (or not) in
> > their pm_notification callbacks.
> >
> > This patch was prompted by the discussion at [1] which attempts
> > to remove CONFIG_ANDROID that currently guards these code paths.
> >
> > [1] https://lore.kernel.org/r/20220629150102.1582425-1-hch@lst.de/
> >
> > Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Thanks, looks good to me. Do you have a corresponding Gerrit link to the
> change adding this to the base Android kernel config? If so, have my
> Ack:
>
>     Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Hi Jason,

Our latest supported kernels in Android are based on 5.15 so the
config change isn't yet needed. Once there are newer versions with the
CONFIG_ANDROID removed I will add this to the defconfig.

Thanks,
Kalesh

>
> Jason
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
