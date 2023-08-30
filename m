Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8778DA2D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjH3Sfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbjH3PH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:07:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E02B8
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 08:07:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1d03e124so737832066b.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693408069; x=1694012869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsv2vy0NbRUitL+DqdxFoOF89HcPlyA0hr/AZRAjcvs=;
        b=Beflx1uLMM8QWOA/AXulwxMsQBLj2h9RxVihZxZ3QTjSCmhtOscjQD4+pPafLuS46I
         Ll/ApEsVa39WaHdJlbrTu0Db03gmi5Zs2+INKQcGR6y8PVUrGS4LaFXUyeSGEMiPXq+c
         0Ml6DCCO9LWtS26HCsjRQM4vvqtEaylnXxfBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408069; x=1694012869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsv2vy0NbRUitL+DqdxFoOF89HcPlyA0hr/AZRAjcvs=;
        b=UqYfQzhNxbaps8CxGhNQLu7uxjM4c4gYm7Sypa4CjfO1CmYXr7fmXg+BFoqYoABFSW
         vYpYDAUzSBLA/xhFjdrlKUsy3C0j/WtejiO/ia88ps7yKi/Y9ZKoYLwV0UAX5VPc49uy
         S438/DKBS+/Rz1Hb7dTiD1utbHuAcM7+nkKSfpqXPMVAbeRTwX3kkTk1XySRF/Y0sYv+
         nTlXd+FPqA8rQFhdaw7B/kKgC4W9DVoDE6HHiYXpV74dnv3vQ0trcliY8ICoUul2Bq95
         aXZz+OC7tzvzC4XTcPcgZYE4tFCnbVtdLGmEem7S8h7qmBPSZwjJIbigjmjRF/dhuiQT
         QABw==
X-Gm-Message-State: AOJu0Yw4XV56/CerJLZ39w0GdWPN6Q7WwQfQMoh8TfKQnVZGb6UHPXyv
        j+xRGp0ZhVmfgKQjw8ZrCQ4PnaemX6V385nMyLgWTeLG
X-Google-Smtp-Source: AGHT+IFiI94TBMpL8NgY+Ra/ijPrgcnf8/XQohcE7uJ0yEKYYLGo0YxIDp82qW9QRG5DYTe3clMjWA==
X-Received: by 2002:a17:906:7951:b0:9a1:aa7b:482e with SMTP id l17-20020a170906795100b009a1aa7b482emr2325192ejo.26.1693408069528;
        Wed, 30 Aug 2023 08:07:49 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id f23-20020a1709067f9700b0098748422178sm7278420ejr.56.2023.08.30.08.07.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:07:48 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c0cb7285fso740249866b.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 08:07:48 -0700 (PDT)
X-Received: by 2002:a17:906:cb:b0:9a2:1ec1:625d with SMTP id
 11-20020a17090600cb00b009a21ec1625dmr2019888eji.64.1693408068433; Wed, 30 Aug
 2023 08:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
In-Reply-To: <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 08:07:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
Message-ID: <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Aug 2023 at 01:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> *) The new subsystem is solely intended for the generic PM domain
> providers. Other PM domains providers, like the ACPI PM domains for
> example (drivers/acpi/*), don't really belong here, at least in my
> opinion. So, maybe "domain" isn't specific enough? Although, if not
> using "genpd", I have no better suggestion.

I'm perfectly fine spelling out longer names. "drivers/power/generic"
would be fine to me too, for example.

We can even use names that are longer than 8.3 or - this is heretical
- the 14 characters of the original Unix filesystem. So it could be
something even more descriptive.

I personally always use tab-completion when doing filenames, so at
least to me, longer descriptive names that don't all start with the
same thing are perfectly fine. Others may have more of a typing issue,
so maybe 'generic' is better than 'generic-power-domain'.

(On that note, exactly *because* I use tab-completion, I hate things like this:

   drivers/scsi/scsi_{common,debug,error,ioctl,...}.c

which is entirely redundant in how it just repeats the "scsi" part
pointlessly, causes more typing, _and_ then also causes tab-completion
to not work well. But that's a separate issue).

> I get your point. I was indeed trying to obey the current naming
> strategy, but I think it's not entirely easy to understand what is
> prefered.

It's not like we have any hard rules. Most of our naming ends up being
pretty random, and everybody thinks that *their* TLA is so obvious,
because they've been using it for ages.

But the "please use common and industry-wide TLA's, write things out
otherwise" is a good rule both when it comes to docs and to filenames.

And that "industry-wide" is pretty important. Not some kind of "local
jargon TLA".

We as kernel people hopefully all know what "TLB" or "VM" means, but
every time somebody sends me something like "x86 SEV" patches, I have
to remind myself, and that's despite me being fairly intimate with
x86.

> Please advise me on how to move forward.

Just to not cause pain during the merge window, I think I'll take the
current trees (eventually - I still have other things pending first),
but I would like

 (a) a new pull request message that actually spells things out and
does *not* use 'genpd' as if it was meaningful so that I can at least
have documentation in the merge window

 (b) a plan to rename that directory to something saner and more descriptive

I don't care deeply about what the exact name in (b) is, but it should
be real words that make sense in context. Or a very standard
abbreviations (ie I consider "misc" to be a word, not an abbreviation,
because I'd rather not see everybody butcher the spelling of it).

                   Linus
