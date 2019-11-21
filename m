Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3102104AEA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 08:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKUHA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 02:00:59 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:45097 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUHA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 02:00:59 -0500
Received: by mail-il1-f169.google.com with SMTP id o18so2202627ils.12
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70XhVJoIf0CSjHrTRztFdyaZcM5N+1vNz44dhwcRPXw=;
        b=SLYBtyriQY7seuHEQlL2JSt3ilAFTLCs46gN0dKVPB6PjkBZRqNh7NltQlrIcE52WM
         NS1NEPu5eptOkKJvpE2HSpv/lFbdetda9B7b5w8JK7jknek+pKEqkv06FYxZ3lzN0R6J
         Cwg+Cbs8vlomam8/SjUZutICyodcTjUUrT+50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70XhVJoIf0CSjHrTRztFdyaZcM5N+1vNz44dhwcRPXw=;
        b=l/DTEQF2DJKz5I2N5kBnbDK8YqPOnDHEAv0o0rqcJLcrlX6q6n+pwnphKAvVQIAJ2S
         F4P9pewOWePagli7VF+rJ1PbFSo9wJocJgUU7hxOjjDerAuweI8VF2FmEl/xhmOX2qMj
         S72dWbCBPN+NDEoOjc9zXIbZ5c8AsZjL7Hqv+bahVV46Pt7jLUfpywaUbwMDJVx2wgmG
         vJ6MWQKLdGsK12Q5QadMWgdq9o0lyTlNmA8wuDy9B0ko0fb8+QSCOr3jpeROatCJjVUp
         kirZc+DqYTAG67F4Ds6fFxGqg9PbK2q4P2JZAc9MB+Px85LX90ediec0uQ1K11hYFc2j
         Mf4g==
X-Gm-Message-State: APjAAAUn7/HyJYodj0N6vZVDolRfh4+Bo33f3VKc5FOl7izT6366P0EP
        BQ6e6G0NY/dGwovf9toajGKlQhYEl3/BcvwdsvTsVw==
X-Google-Smtp-Source: APXvYqz3PHqe/dC8SrMLZ7oJb4SyckZc5EJzgX4VS4wAMnE4d3D2dWe3D5r10a6CIdA4f7qoQvzM2VsFlosI14iwemI=
X-Received: by 2002:a92:5d08:: with SMTP id r8mr8154845ilb.283.1574319657713;
 Wed, 20 Nov 2019 23:00:57 -0800 (PST)
MIME-Version: 1.0
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com> <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 21 Nov 2019 15:00:31 +0800
Message-ID: <CAJMQK-ivho3T1hnD9axV2EMKT3Srs_5zAXLqwts8nojY15fBGg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:

> -       tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -                                                    &mtk_thermal_ops);
> -       if (IS_ERR(tzdev)) {
> -               ret = PTR_ERR(tzdev);
> -               goto err_disable_clk_peri_therm;
> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +               tz = kmalloc(sizeof(*tz), GFP_KERNEL);
> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +                               tz, (i == 0) ?
> +                               &mtk_thermal_ops : &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (IS_ERR(tzdev) != -EACCES) {
                                PTR_ERR(tzdev)

> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }

This for loop adding thermal zone sensors will not work for mt8173. It
assumes that thermal-zones in dts have subnodes (eg. cpu_thermal,
tzts..) amount equal to num_sensors+1. Otherwise tzdev would be
-ENODEV and thermal failed to be probed.
In mt8183 this is fine, since each thermal zone only has one sensor,
but in mt8173, some sensor appears in multiple thermal zones.

In order to let the change also works for 8173, I think if the error
is -ENODEV, and the id is not 0 (0 is cpu_thermal), prompt a warning
instead of failing. Eg.

                if (IS_ERR(tzdev)) {
+                       if (i > 0 && PTR_ERR(tzdev) == -ENODEV) {
+                               dev_warn(&pdev->dev, "can't find
thermal sensor %d\n", i);
+                               continue;
+                       }
                        if (PTR_ERR(tzdev) != -EACCES) {
