Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0AB8235
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392459AbfISUHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 16:07:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39170 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390722AbfISUHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 16:07:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so3859155oia.6;
        Thu, 19 Sep 2019 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SLgslheBeIIJex/gf/ZVhEBmirzOWHGUduUXl+JfS0=;
        b=f8nGhVnviG2KbGnxig/mqrpCztbeYB17qB2d4v8zgIMpIo21id++eyGrhRa7Hetlhu
         1uIaChRD0JXsIkhaEnLlOVilPn+4x4RCBwn4qftOj/Hn1jiDkcWSr9iSRfpGqYg8IPyg
         p6KZ5T0M5XXE7g4URtoFpVBwAr8qDD1kwXGZhmKQ5TN4D/ZBt9h1HabeDijheKoZ1Hq6
         Am7QREthxBCAoFRWZlZc9Dn8FvVmj/Ct4TgYQLr4ctdbmmcuJtv86n7ETES+bEZxL1mQ
         EVg7zzKRiWTN263W8ohXIHHzWdDRk8eIf0Lm/Lzn+chRgIy7X91h9B9AXapeP4UZEFK4
         1Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SLgslheBeIIJex/gf/ZVhEBmirzOWHGUduUXl+JfS0=;
        b=LRo5IFeo7bCrSGTPwzfrS3V9994tSJ6StNPbYplCww/oZi062QD+1Ceusj+wGxsKTc
         2S1ZWmHUWjuU7/+GG38QkQ8zFQlUUun4bmwcy73ioa/dbMnMFM5sby0WaCGgbA8EhpfW
         pUPte2TuX/Z/tWC3hHILfw4liAmCvP4JV75rm/kCPYK4YCFPpVwG0M69vl9ogyUAE1Fh
         Hj8ODuEtG3JLKpAyzS2mvqr84BBF+UQRbUGq3769TT0vm4LXPokdKWg06XHLkAElbyj7
         J+1oIHZG0l1QesIKgLM0CvON8ccbM/SQbWZ3uS66kyTD+sdc/XBzv5LhW9+K886WXoqk
         iYig==
X-Gm-Message-State: APjAAAUzfXZ6uql9XutpVXopOzfL846dSj/7bH8GtlgN/4KY23ZbsorT
        8MaLMGXdjmQzJ4AWbSABlQe2Yq0UrmSCuY5ZJPPiDOW5
X-Google-Smtp-Source: APXvYqxs8KaOnta4oS+qOBnum0sYdK4kwfRs3AjdmxE14hPdeI3PYvm+RSVJQcA/eiB1hLB6FfwDBOgY14u/8HhKXfM=
X-Received: by 2002:aca:3ad6:: with SMTP id h205mr3915280oia.129.1568923630403;
 Thu, 19 Sep 2019 13:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com> <1568895064-4116-2-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1568895064-4116-2-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 19 Sep 2019 22:06:59 +0200
Message-ID: <CAFBinCCxeYgso3WQWqNgWUwwCM835uo_6FftVv0YwYTFJV2Ovw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic secure power domains bindings
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jianxin,

On Thu, Sep 19, 2019 at 2:11 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
>
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Zhiqiang Liang <zhiqiang.liang@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 32 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> new file mode 100644
> index 00000000..327e0d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +# Copyright (c) 2019 Amlogic, Inc
> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Secure Power Domains
> +
> +maintainers:
> +  - Jianxin Pan <jianxin.pan@amlogic.com>
> +
> +description: |+
> +  A1/C1 series The Secure Power Domains node should be the child of a syscon
> +  node with the required property.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-pwrc
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    pwrc: power-controller {
> +          compatible = "amlogic,meson-a1-pwrc";
> +    };
not a comment about this binding but about the secure monitor in general:
there's a recent discussion about the secure monitor in the nvmem bindings: [0]


Martin


[0] https://www.spinics.net/lists/arm-kernel/msg750010.html
