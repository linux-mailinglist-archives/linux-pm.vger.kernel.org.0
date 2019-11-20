Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8078C10377D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfKTK1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 05:27:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40886 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfKTK1f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 05:27:35 -0500
Received: by mail-ua1-f68.google.com with SMTP id p18so2786972uar.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPPl+dieWmwwl5vclo4eycxw3/3RIJ5/bVbsRxQY9fg=;
        b=cDYB8Bd/9XV0BpnQ5A/BVa8N7CSLhRXNha/+ozOLuZ0ti/xAJMxWBF/n+373T53553
         61ARehzgYwuxH8lCICdiBYJDRiCYlQYtg+hh6DIilDevFzomryjjIm+kXsuIvBGNgrgx
         N6VR3Ui0/jj6DcZzLxG87/9pdgN3Jo+3efXMmqaECPiEW8JY0jHOqosJen1A6JvVkSiS
         9JNQhOsBG9eCu5lFGgY1SxHNpVxqf6zaTc9rwPWEDaGaPUATNpWw74J88QL6aIy6jcNh
         tlGKDgD4Fr06GeoS9kWNvD9uv8PTeaMiRkYePDsuQPPPchtb6ufXZP0A9ZyOHLJfWh/M
         M63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPPl+dieWmwwl5vclo4eycxw3/3RIJ5/bVbsRxQY9fg=;
        b=r2+ci2ClYziSxRN3s7iizqH+AjLyAsaNP2/yyI0IdU6RMRG+z4VGY3L226Mg2CAKE8
         Gf9x7KTpUl2tscCA3TV4QdUtvXCM8Z9uuaY9O5eEa10sAgk+UVgdrtbJDvgMPiIatJ3g
         LT6RTqz6ITWg40pZuVhmQicv7j7uTu2fbIcsfp9PbOTWkW9j4CWSiqg21b6ZLDTk638N
         PgYqLT23zIIMQj5kzs0vadZQ7V68ROytnLJdyjUsjNtDekzBDOrbCjc/rAnYwEY7jeXM
         8ueho/5+Au55JMpCU06Bq5t/dk39Iyb6YA7utxWNp2BMaazA8Lw4qrcddvg1Tkc1xvwC
         ob6w==
X-Gm-Message-State: APjAAAXfj/aT/t4eSld8qDGDLlxc5hEap2HuAwvBkDRZ14KkIzT7CXdK
        uul25InFxp50igIgDUF/cH6rLsQ4ZMR+k+Rf/7jw62Ef
X-Google-Smtp-Source: APXvYqz54Zeg8KbbWUdNshHqcWaCOGq8jgGO9qGY0g5PgtU6Hs76XawRjWx7E0migoK0Q+phAd/zNlaNrZ7pNwlmXcE=
X-Received: by 2002:ab0:61cc:: with SMTP id m12mr1127845uan.129.1574245652878;
 Wed, 20 Nov 2019 02:27:32 -0800 (PST)
MIME-Version: 1.0
References: <1574236796-25016-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1574236796-25016-1-git-send-email-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 11:26:55 +0100
Message-ID: <CAPDyKFo-Y8zctjLw0F5RibO9gogQTkf1Xbc-ODLySAJ_9r_jAw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 at 09:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> With split of power domain controller bindings to power-domain.yaml,
> the consumer part was renamed to power-domain.txt breaking the
> references.  Undo the renaming.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> ---
>
> Changes since v2:
> 1. Simplify pattern in Maintainers as Geert suggested,
> 2. Add Reviewed-by.
>
> Changes since v1:
> 1. Undo the renaming.
> ---
>  .../devicetree/bindings/power/{power-domain.txt => power_domain.txt}    | 0
>  MAINTAINERS                                                             | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/power/{power-domain.txt => power_domain.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/power/power-domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/power/power-domain.txt
> rename to Documentation/devicetree/bindings/power/power_domain.txt
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7126d3e079a4..0aff4bebed78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6953,7 +6953,7 @@ L:        linux-pm@vger.kernel.org
>  S:     Supported
>  F:     drivers/base/power/domain*.c
>  F:     include/linux/pm_domain.h
> -F:     Documentation/devicetree/bindings/power/power-domain*
> +F:     Documentation/devicetree/bindings/power/power?domain*
>
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:     Eugen Hristev <eugen.hristev@microchip.com>
> --
> 2.7.4
>
