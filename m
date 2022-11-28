Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58963A4E3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiK1J0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiK1J0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:26:53 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BAF5F43
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:26:51 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h17so4742567ila.6
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rSjenL36nx6dkpFfPvUHmLRtB3WtAx9+34Fs2KvTI98=;
        b=fHupL+kNUU1LXHaNAPqGC7s6qKRyRPCDbj2c4DTGlg6mKcXeZ8CxSpies/1a1MiyxC
         9R37c6cxx+9Gj9y2jpUJ7JrfUg72+3QkWD0oOtVoYFn1NtQPrK435X11qQ0dITnz8Muj
         naVVWUn+elbnLK9DPkHY6lwo+3xYSdr2hKNZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSjenL36nx6dkpFfPvUHmLRtB3WtAx9+34Fs2KvTI98=;
        b=U1KMXK8oBe3bUnW+fZYhj4flViRM+w1oWCHnuFkzWhaehXkwSSjYEFxH+pHiz1w1vy
         NJ41hlKkk4QOWJ5m6VZmVgBR7dsYvSkoaNjEwqU7w6ubYdSXYIklO2Y1H/cXg0TG2o6X
         TSG6gGRxam80r2UGifvcd3hVwsFo7Q6f9/jVf4BJC/lwuZz1k5JVgjLgaDDOjn5dV73o
         VmvQQ/J3pph5RAUJzQo8CEft/b52y+5g9JsBwsmYhlyJl1/8CJ2fgc6WGWEqeZdzDR7J
         9WdMyxANJ0wVpBwK0P74mvZhXkTgii6QmWqKcxsPX/pKR1pNMCshWDFHlrkLAmD9MAOa
         BFKQ==
X-Gm-Message-State: ANoB5pnyts3ybB6ZguXXzspFFenpd7STXXV8rwwkv4vGhoBzT60DqDNG
        yRoeAb3jxdcOZg80lb2QfRSrR+2wBNLWpw==
X-Google-Smtp-Source: AA0mqf6FwaOgis1EfIzEFI9K9pg5efLr0j2fePJsUlr8xwP5gSAGQvl4VaD2y0KkiODX24LwEwMnQA==
X-Received: by 2002:a05:6e02:106:b0:2fa:7d5e:b64d with SMTP id t6-20020a056e02010600b002fa7d5eb64dmr14979479ilm.245.1669627610511;
        Mon, 28 Nov 2022 01:26:50 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id u6-20020a056e02080600b00300b9b7d594sm3729400ilm.20.2022.11.28.01.26.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:26:48 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id r81so7159377iod.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:26:48 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr14573933jao.185.1669627607759; Mon, 28
 Nov 2022 01:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org> <87wn7fzb2g.wl-tiwai@suse.de>
In-Reply-To: <87wn7fzb2g.wl-tiwai@suse.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 10:26:36 +0100
X-Gmail-Original-Message-ID: <CANiDSCtSAM3seszVWfjJPaYFO3v223P-tYEtdpW4+pQQ3bcf0g@mail.gmail.com>
Message-ID: <CANiDSCtSAM3seszVWfjJPaYFO3v223P-tYEtdpW4+pQQ3bcf0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ALSA: core: Fix deadlock when shutdown a frozen userspace
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>, Len Brown <len.brown@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Takashi

Thanks for your prompt reply

On Mon, 28 Nov 2022 at 10:24, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Nov 2022 10:10:12 +0100,
> Ricardo Ribalda wrote:
> >
> > Since 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> > we wait for userspace to close its fds.
>
> IMO, the fix above brought more problem.  If you'd need to want to
> avoid later accesses during shutdown, the driver should rather just
> disconnect devices without waiting for the user-space completion.
> And, for that, a simple call of snd_card_disconnect() should suffice.
>
> > But that will never occur with a frozen userspace (like during kexec()).
> >
> > Lets detect the frozen userpace and act accordingly.
>
> ... and skipping the user-space sync at snd_card_disconnect_sync() as
> of this patch set is a dangerous move, I'm afraid.  The user-space
> gets frozen also at the normal suspend/resume, and it implies that the
> sync will be lost even for the normal PM, too (although it must be a
> very corner case).
>

And what about checking kexec_in_progress instead?

Thanks!

>
> thanks,
>
> Takashi
>
> >
> > To: Jaroslav Kysela <perex@perex.cz>
> > To: Takashi Iwai <tiwai@suse.com>
> > To: "Rafael J. Wysocki" <rafael@kernel.org>
> > To: Pavel Machek <pavel@ucw.cz>
> > To: Len Brown <len.brown@intel.com>
> > To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > To: Mark Brown <broonie@kernel.org>
> > Cc: alsa-devel@alsa-project.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Changes in v3:
> > - Wrap pm_freezing in a function
> > - Link to v2: https://lore.kernel.org/r/20221127-snd-freeze-v2-0-d8a425ea9663@chromium.org
> >
> > Changes in v2:
> > - Only use pm_freezing if CONFIG_FREEZER
> > - Link to v1: https://lore.kernel.org/r/20221127-snd-freeze-v1-0-57461a366ec2@chromium.org
> >
> > ---
> > Ricardo Ribalda (2):
> >       freezer: Add processes_frozen()
> >       ALSA: core: Fix deadlock when shutdown a frozen userspace
> >
> >  include/linux/freezer.h |  2 ++
> >  kernel/freezer.c        | 11 +++++++++++
> >  sound/core/init.c       | 13 +++++++++++++
> >  3 files changed, 26 insertions(+)
> > ---
> > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > change-id: 20221127-snd-freeze-1ee143228326
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >



-- 
Ricardo Ribalda
