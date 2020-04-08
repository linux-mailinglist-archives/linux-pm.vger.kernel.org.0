Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3E1A1A3D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDHDPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 23:15:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37701 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgDHDPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 23:15:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so6032475ljd.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=az2sCBqHUEAw3ueI0a9zrJDzRaG8GZZBQbnmAG/MSZ4=;
        b=FglOBtsNuLq+9GUpr/NY/r5GUPdDlvwYlg/tbeOzEec4q0XyXYKwy52RCXUcXpPDaf
         uuZhdH9FQL3hZa384XMQhKS8IfoixmWL1SmoOyCkNNfdFHdekQDtOcGMtihZUM/E4b1+
         sa0pwFzO9ISDjuBzkEVhtwRBTppJfMRC8j2C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=az2sCBqHUEAw3ueI0a9zrJDzRaG8GZZBQbnmAG/MSZ4=;
        b=l35VEytMzzT1qswesPTYXgxvQd3phJjG/McRA/xnTCwu9njV3SiQ3GtDoQdJHq5Ior
         ZOff7iohs7+zJM3skxkAJv8zEnLM6TPzN/OGn20eNUvzAOjGnLOZ7volyD6V8KkB7f3J
         rFSloJHcFsE/oSusAHjgZQEdwJaIo6cBtAlh3MWpTP78VJ43HbVqQUZ02ADRjkoMlayI
         +WeR69Th90KD0Etr5KZDUQzkMlsA9xsnvptM8zk2TrqjZwKl0+uj/3mzwOIHKejU+px8
         nGuziB9qsX/wioRKWr/pD0wizHS19co9UtWErkN7rfPh5fC2vsKdQJBwLRUPlR/w3bvM
         gCEQ==
X-Gm-Message-State: AGi0PuZCbC9lPAnBPH1tf5iHDZqni2KVZ0Qykrze/AFbqPxSSQyiHrb5
        SLiP0ciYLI2sNsyIgS7qMIBrPiK7Ad4=
X-Google-Smtp-Source: APiQypIDLvIvG8Gdcrbr5NXd9EJXr66/kVjDuwUOwTtBx/tAs48vgJoovalTiLcCc8byIdiLncDZ5w==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr3473734lja.205.1586315700337;
        Tue, 07 Apr 2020 20:15:00 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w24sm12592109ljh.57.2020.04.07.20.14.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 20:14:58 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q19so5980219ljp.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 20:14:58 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr3602189ljm.201.1586315697874;
 Tue, 07 Apr 2020 20:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
In-Reply-To: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 20:14:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
Message-ID: <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.7-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 7, 2020 at 4:26 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.7-rc1

Ho humm.

This caused a conflict between commit

  f12e4f66ab6a ("thermal/cpu-cooling: Update thermal pressure in case
of a maximum frequency capping")

that came in through the scheduler updates from Ingo Molnar, and commit

  ff44f672d741 ("thermal/drivers/cpufreq_cooling: Fix return of
cpufreq_set_cur_state")

from the thermal tree.

The conflict wasn't complicated, but the reason I mention it is that I
resolved it in a way that neither of those commits had done.

In particular, the thermal tree did

  ret = freq_qos_update_request(..)
  return ret < 0 ? ret : 0;

where that whole "return negative or zero" logic is new (it used to
return positive values, the fix was to return zero instead).

The scheduler tree did

  ret = freq_qos_update_request(..)
  if (ret > 0) {.. do thermal pressure thing ..}
  return ret;

which obviously still returns that positive value.

My resolution to the conflict was to not take that return with a
conditional operation, but instead just add a

  ret = 0;

to inside that thermal pressure if-statement, and avoid returning a
non-zero positive value that way.

I just wanted both sides to be aware of my non-traditional merge
resolution, and take a look.

               Linus
