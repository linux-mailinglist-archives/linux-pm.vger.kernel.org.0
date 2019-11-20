Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C47103517
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKTHVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 02:21:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37336 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKTHVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 02:21:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id y194so21625754oie.4;
        Tue, 19 Nov 2019 23:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUgtpgMFIMi5m1Pi4zAsjsLUlah126ujOsEuJfAwgk0=;
        b=FB1l/87VzDLArRC2T3YkiobmSAVqZGiVAnscbBPNU6nSm1UwHrsEj2zdWNxSZwrKim
         lzyFHC7f2zcEsPOYhFLoCm+L2yAuU+pF6nh8erxGE7nt+DINp9RWc7jkSM89B2iNScHt
         AHPdxHwvYfBu/+r7VwmGb8epG7TfNm28gTHQ92rJBEQaKSaYAt+noQRokZWiwu/k+biG
         A0F4HcCpECFOzo8PErJzRSJfJLYaK2gv+wVx79oEh+FLHILZzdXAnWROm8SOpEq+1/bP
         bxJfAZnHJTSuZPHkFi2awwHjJ9JJQyF3MDhhHXvp6+EMofbTZmUUH8qKZuqltjIUoZGA
         Ck/A==
X-Gm-Message-State: APjAAAWbMjZAwwdivT42fI3xwjR5CxqSp6jMvBBO90ZC8FeBe5Ac31xV
        aOh3c7JPOTMkOHEs0hrWVhEeqCWkuylwlStPaPo=
X-Google-Smtp-Source: APXvYqzbSynvSyZ5pcVM21HLbt5yJ3Ao/+LrANi8XI5dW5tHI2GDs4KMORHq0G6W3WWOTOgWEc7cRQtLRrqrmkaERws=
X-Received: by 2002:a05:6808:b17:: with SMTP id s23mr1586603oij.102.1574234475906;
 Tue, 19 Nov 2019 23:21:15 -0800 (PST)
MIME-Version: 1.0
References: <1574213719-20766-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1574213719-20766-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 08:21:04 +0100
Message-ID: <CAMuHMdWe3vBzO9Nw6PX+kn9RDO+3q4zYSiFDF=4rsqnSux-caw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On Wed, Nov 20, 2019 at 2:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> With split of power domain controller bindings to power-domain.yaml,
> the consumer part was renamed to power-domain.txt breaking the
> references.  Undo the renaming.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One suggestion below...

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6953,7 +6953,8 @@ L:        linux-pm@vger.kernel.org
>  S:     Supported
>  F:     drivers/base/power/domain*.c
>  F:     include/linux/pm_domain.h
> -F:     Documentation/devicetree/bindings/power/power-domain*
> +F:     Documentation/devicetree/bindings/power/power_domain.txt
> +F:     Documentation/devicetree/bindings/power/power-domain.yaml

Looks like scripts/get_maintainer.pl does handle the "?" wildcard, so

+F:     Documentation/devicetree/bindings/power/power?domain*

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
