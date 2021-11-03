Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B6444434
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKCPGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhKCPGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Nov 2021 11:06:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202FC061714
        for <linux-pm@vger.kernel.org>; Wed,  3 Nov 2021 08:03:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id i26so4320661ljg.7
        for <linux-pm@vger.kernel.org>; Wed, 03 Nov 2021 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocVzS0OUcnB5+dQiLwWdw20NbFOBOR2SRavPv7B36iU=;
        b=CrtoyVXd9K74O/kUB1tmaOsi7EIm1pbBWLAHcq5gR28HFqzBbU1IIB1hh+djAvmfsU
         cnO0gWiTTMzstsAJuNwn9wesrjKyduBjZmINZ0sKhmdJqD2duOvAUd8C+2bG/cPbfN+i
         z86EfDpMtY9ckjx8tOOeM2Jjcq/XTeyLsOR58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocVzS0OUcnB5+dQiLwWdw20NbFOBOR2SRavPv7B36iU=;
        b=ZRP9+/39cW2W5hTyayYeYSeg/fZz+sDhCXRCshgHOvGf+ARiJ4bwg9T4m25RJVSmc/
         agDwwgq689gO4zZsoBdC1i9guIlLNNiZOHXlt3X9mi9eWLC+RqCsIhQQMj7U8ce6A1yO
         e/6xZLp+0W52O3ywhZyBwFca4Ps0S9l3QHBt79IgL148KWc2x9cBarWT8Tazz2ZD/oCV
         ZpzoXhGhLPlIslbTXxyG0s5fyHyWsALEXuuTPX2qvnMGkrEmUmXNRtGWXKIR1uPfVJ9f
         xj1aGoba/hMZP5O6W8P90HyG6ZUyE8Dn9evtX2nrUHYas0uN0UYMPQQoTrxSczZpA/k4
         Fr7A==
X-Gm-Message-State: AOAM531OW2ybBC2ogqbZ9yqnjMix2od2QFDSLffoRwbJ+8gbYPXDJjOG
        N+NRBinHTTZRY4gzgi41npJcyCWuCJGp0tf6
X-Google-Smtp-Source: ABdhPJxYhSL68/WRBDd5yYRLSdYi3aMuPbu/8i/lUlHAexkLv51G1XvN8Rurf2Fi2sXwGZWcZ4ra+g==
X-Received: by 2002:a2e:9601:: with SMTP id v1mr48024668ljh.478.1635951813559;
        Wed, 03 Nov 2021 08:03:33 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d18sm224762lji.115.2021.11.03.08.03.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:03:32 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d12so2239641lfv.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Nov 2021 08:03:32 -0700 (PDT)
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr39873997lfa.474.1635951811832;
 Wed, 03 Nov 2021 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
 <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com> <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
In-Reply-To: <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 08:03:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
Message-ID: <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 3, 2021 at 12:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Is the platform with 19 thermal zones and default thermal policy set to
> userspace governor ?

I think it has 11 thermal zones judging by
/sys/class/thermal/thermal_zone* going from 0 to 10.

And the kernel default seems to be

   CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y

but presumably this is F34 then setting it to 'userspace' (the kernel
config comes from the F34 one too, although it's been tweaked for the
machine).

I suspect I could just turn off THERMAL_GOV_USER_SPACE and get rid of
the message, that's not the issue.

The issue is "why is the kernel spewing pointlessly the same message
over and over again?"

                      Linus
