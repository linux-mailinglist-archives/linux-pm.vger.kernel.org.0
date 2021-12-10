Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E73470E23
	for <lists+linux-pm@lfdr.de>; Fri, 10 Dec 2021 23:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbhLJWqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Dec 2021 17:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbhLJWql (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Dec 2021 17:46:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E32C061746
        for <linux-pm@vger.kernel.org>; Fri, 10 Dec 2021 14:43:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so33972020edd.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Dec 2021 14:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNvZHe6DHRkF+xFR2MjDNEoC+neS0KSxMQQUcva/BLo=;
        b=grQgQcg5MH+iX7Jw2TpSklrJNA/RSRHJETmDcYrXbXsk3YGdRDRXXoXauSP5q327/M
         xnSxXPjy36NvjVKp/+pXBFy44pq100Dyqgg4i1t+JBgHycd6Pm2Pscz/QIMcHcnjx4Tg
         1fVwhoeVi7wK76k1Y6Oypx+EYeaQ8bJnJMo3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNvZHe6DHRkF+xFR2MjDNEoC+neS0KSxMQQUcva/BLo=;
        b=yzcfx0fdUeWlxYIep89PMxBCxfe4KfzhhqjOQLgkZsUm9ROFai36vwpFsEH78YAna3
         i+1kFgRi0w+2hr+t/0F2B1Fanb0X5m1xeJcW6+BRwVJlylCpP7Bm9oaHtS/u3zE2NyOe
         2jmLCSnQw6N6CHpfyzCz0Wx9xHckrmWgJVB1tF++shtNfUU6E2Y1HgX8zHYe3/Y4aNdd
         iZSXoiLGrVNVYuokwOgNrY8SzuhlVoZrC1HK39DDq9SfSWH3BFfLhmQ8x4y+bCXNm7FJ
         Dhz5KE00+IH883ri8vgv/KFfuvmWKc3oTNRYfDUb4Jvjkymm0/GbY/rkv6NBdBObuihy
         JVig==
X-Gm-Message-State: AOAM531BxGN4MUSzIQwqEc9ilD9ElIKvafNmCyne1xPgE1sjTJYxlaBt
        Lt6JugUt9ckJIyVr8TuVTkXDAxKg1pma87TpWfk=
X-Google-Smtp-Source: ABdhPJyaTqWeKdvVJhbniS18gc/bl6guBGlD7Mstvq67VKNHNaEVRgxSsDz72qQfFDWrj20BoD1Hkw==
X-Received: by 2002:a50:becf:: with SMTP id e15mr42147627edk.114.1639176184260;
        Fri, 10 Dec 2021 14:43:04 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id gs17sm2088712ejc.28.2021.12.10.14.43.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 14:43:03 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id t18so17295958wrg.11
        for <linux-pm@vger.kernel.org>; Fri, 10 Dec 2021 14:43:02 -0800 (PST)
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr17138267wrj.274.1639176181996;
 Fri, 10 Dec 2021 14:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 14:42:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
Message-ID: <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control fix for v5.16-rc5
To:     =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 10, 2021 at 12:11 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> w=
rote:
>
> This fixes the definition of one of the Tiger Lake MMIO registers
> in the int340x thermal driver (Sumeet Pawnikar).

Funky.

You sent me three pull requests, and two of them came with your normal
address, and now the third from a new gmail one that I've never seen
before.

I also note that this one uses the proper utf-8 "Rafa=C5=82" rather than
"Rafael" - is that your preferred spelling?

I see the signed tag, and I notice that you do have this gmail address
in your key, so this is all fine, but now I'm not sure how to spell
your name any more ;)

              Linus
