Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB8281522
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBOba (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBOba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 10:31:30 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E602C0613D0
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 07:31:30 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x1so746204vsf.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnU95a4B/lopWn7PJb9EKa9/N6eV+gD0Xs8KJ/fY4rM=;
        b=A5cXXjzFewYmWbzazwRS0/VaBU2zMwnx+gFsMz74IU9GsLD3USy5XdWUJzxT39eCc7
         lnBzqESdtLpD0XCCYhvmegsVhtPZJmgxrgt5ttIqBvgDpGo/QdTT6fGyWy8toyId5OSE
         FWLvaBXHHL3dljVDcvJ7tOLPA1Na5BenHsg6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnU95a4B/lopWn7PJb9EKa9/N6eV+gD0Xs8KJ/fY4rM=;
        b=nPN0m3O/JIuQMz/WpHf062QsXAqbOwqRvefIYwjLK4Ix6R+olSU+hmQ86k+Lwh2O2G
         jfjE8c0+AQ62FkQIIEZZLb/WingYJgptspQnmCqWdYos+In1Yq4ib8GRymlfKLTJSZLf
         Ym8J1ABoVp36qkszbcHfjQudGio+GK/nUhW4QGMradxdJm5d821ttzOzOYoNyYenIEv4
         JMLDuT44q+37fb8zQRVdUx0c+hg2h/icOQjtN3LVBKHjrBoHJFW4HqxGqY2bgQotrUTF
         Qg9eTcnNuXHUEFodFzn+53oFqCwlsiGUGYX6SCVJGGi2qL0fzTsHpIuOc6LIcb4WAV3v
         5HMQ==
X-Gm-Message-State: AOAM530GIwMCMjyCmXn0NO7lD9dtunSt96RTm2wXTfe4cFo0oWoyMn/o
        wwkYb2tSf9upSbpJ4TKmR/41WBOQmRAwBA==
X-Google-Smtp-Source: ABdhPJwYKyGFPYhh6T0lp1jHQbIu8XdKf03RBrSGpJMavMk/CsJTUC+i/KWkhOwoQhjRG4o5tygbbA==
X-Received: by 2002:a67:cb02:: with SMTP id b2mr1203047vsl.41.1601649089635;
        Fri, 02 Oct 2020 07:31:29 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 61sm233637uak.17.2020.10.02.07.31.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 07:31:29 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id e2so735882vsr.7
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 07:31:29 -0700 (PDT)
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr1288376vsn.4.1601649088871;
 Fri, 02 Oct 2020 07:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <20201002114426.31277-4-lukasz.luba@arm.com>
In-Reply-To: <20201002114426.31277-4-lukasz.luba@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 07:31:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
Message-ID: <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        amitk@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Update the documentation for the binding 'sustainable-power' and allow
> to provide values in an abstract scale. It is required when the cooling
> devices use an abstract scale for their power values.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 3ec9cc87ec50..4d8f2e37d1e6 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -99,10 +99,15 @@ patternProperties:
>        sustainable-power:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description:
> -          An estimate of the sustainable power (in mW) that this thermal zone
> -          can dissipate at the desired control temperature. For reference, the
> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
> -          10-inch tablet is around 4500mW.
> +          An estimate of the sustainable power (in mW or in an abstract scale)
> +         that this thermal zone can dissipate at the desired control
> +         temperature. For reference, the sustainable power of a 4-inch phone
> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
> +
> +         It is possible to express the sustainable power in an abstract
> +         scale. This is the case when the related cooling devices use also
> +         abstract scale to express their power usage. The scale must be
> +         consistent.

Two thoughts:

1. If we're going to allow "sustainable-power" to be in abstract
scale, why not allow "dynamic-power-coefficient" to be in abstract
scale too?  I assume that the whole reason against that originally was
the idea of device tree purity, but if we're allowing the abstract
scale here then there seems no reason not to allow it for
"dynamic-power-coefficient".

2. Is it worth adding some type of indication of what type of units
"sustainable-power" is represented in?  Maybe even a made up unit so
that you could tell the difference between made up units in the same
system?  I'd envision something like:

sustainable-power-units = "qualcomm,sc7180-bogoWatts"

...and on the dynamic-power-coefficient side, the same:

dynamic-power-coefficient-units = "qualcomm,sc7180-bogoWatts"

One could imagine someone even later (after devices are widely
distributed) figuring out translations between these bogoWatts numbers
and real Watts if someone could come up with a case where it matters.


-Doug
