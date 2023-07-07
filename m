Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04774AF44
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGGK7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 06:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGGK7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 06:59:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5311FEE
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 03:59:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1836727276.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688727569; x=1691319569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNa38uLhZwXSXeQR3Wi76tw9kKPxoD61t4HFzT7PJWQ=;
        b=gjItutFou6ZsZG3k3XeGp/GPEHXtYq9Dkd4W9qWWHIksev2IYZFIQvzlGTFQt33Gvr
         fwZFEIu6gYdkGca9lnnGs3rQjHt/Ef3esKw7LWa1RRBjv8DItmVS2F6Grn7fLpwceSug
         hw8i8+HLx3vGXC/plgkUwKzXbMTxQLyCGPLRFodTWNpSrqxPQsHD47p8wNwt2Zrjx+98
         1uVhnSxRA4qodYSHUY35MZXgaFqLzk2eGbutYTVPmYRRPYP9RG1MPm8w93Iq5X46k9SG
         Sn1iD7z7mgvdInqhznvfXTGnbgCbteQJW0v78ZwL/gGMYpVmokg3IbB9UJw0Agy9V/E+
         k93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688727569; x=1691319569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNa38uLhZwXSXeQR3Wi76tw9kKPxoD61t4HFzT7PJWQ=;
        b=BUaW0jum4h2BlI/cV1lnmjCeL2k5eqt1QeemjshKUB3FWZrhuf9DJCqq6FR+WVsp5A
         lpMuf2Q5KzXIXDBvoQTZcwCfvnehKq8s1oQ0zbrTwpyO7cwUWn2P6hGJvX/vFl4AfX6r
         MkeHSFvpsJcaohUEX+5quKZv5QMrrglf3UobLgE5hPtgvCtiLFgoJ8jBzxtVWOQ1xWm1
         +FV6unzzi1cpPeIuJ3qwRrYIPiOgfD+eJUPEa8Ez1r6Y1CxnXl9TzhYoIeggHV8epuo4
         aNIarAmvhPNwoqwGgS7i+BDfD3as+dEM/to24acSqqVVes8Yi2hHcjKCkDSfLYO1WtHb
         S8xg==
X-Gm-Message-State: ABy/qLbzN+E6Jj/VI3UfJqBOI5lwORRKhVTFjaYtUMy4IAbPvGiS2lOp
        Vc93eCIHJELlvUcZqMaTaYoIv9fsT2oO9XUJD0larQ==
X-Google-Smtp-Source: APBJJlFVY2c1x8f9yWxGFi7Gqjx6YiNx+1X2xzMvRwI2WDObKD6BPTw+1rw3u/qJggk4NmfAhZLLEMhGTHOiryp/hiI=
X-Received: by 2002:a25:f302:0:b0:bc8:9925:9c1f with SMTP id
 c2-20020a25f302000000b00bc899259c1fmr3867943ybs.1.1688727569479; Fri, 07 Jul
 2023 03:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org> <CACRpkdY0WKDAx1XP6fq2WZeoK6kH+t_weYJPJm1aMnMKb7ZayQ@mail.gmail.com>
In-Reply-To: <CACRpkdY0WKDAx1XP6fq2WZeoK6kH+t_weYJPJm1aMnMKb7ZayQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 7 Jul 2023 13:59:18 +0300
Message-ID: <CAA8EJpqsVH+pvngLGLXQ_=81hB16MiXnJu-7W4Bf+z0gkqdtTQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/28] ARM: qcom: apq8064: support CPU frequency scaling
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jul 2023 at 12:34, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Sun, Jul 2, 2023 at 7:43=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>
> > Implement CPUFreq support for one of the oldest supported Qualcomm
> > platforms, APQ8064. Each core has independent power and frequency
> > control. Additionally the L2 cache is scaled to follow the CPU
> > frequencies (failure to do so results in strange semi-random crashes).
> >
> > Core voltage is controlled through the SAW2 devices, one for each core.
> > The L2 has two regulators, vdd-mem and vdd-dig.
> >
> > Dependencies: [1].
> >
> > [1] https://lore.kernel.org/linux-arm-msm/20230702134320.98831-1-dmitry=
.baryshkov@linaro.org/
>
> Just because it looks so cool, I applied this patches and the prerequisit=
e
> to master and booted the result on the APQ8060 DragonBoard, and
> it still works.
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> (Mostly for the DTS refactoring, which is what affects APQ8060)
>
> I guess the APQ8064 cpufreq and APQ8060 isn't actually far
> apart, so it should be possible to fix APQ8060 as well, but we
> can take that another day. I always wanted to fix the SAW2
> regulators.

APQ8060 (as well as MSM8260 / MSM8660) were a previous generation of
the cores, Scorpion vs Krait. So far it requires two items to work:
SCPLL, the core pll driver, and the fixed AVS setting (which might
also be required for MSM8960). Let me take a glance in the next couple
of days.



--=20
With best wishes
Dmitry
