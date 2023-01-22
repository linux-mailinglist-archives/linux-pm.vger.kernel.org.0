Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E55677147
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jan 2023 18:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAVR75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 12:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAVR74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 12:59:56 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9516AF2
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 09:59:54 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c131bede4bso142801827b3.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9gcKLKcPFsmTqmqnzqvLNmDUAPYbRLWrG+hsw17aiGg=;
        b=yb3O28mc6yAg1MgxmbfLfCffCi3H1pib5+SQUTVI+qgE9mIjWBWLFzMPy0fMXwVfL9
         uuNlXxUIj2Kf40UwRT+z3XQgntVTbDlvuKHTDwkP0ILt45OGUSP5JkxiCuzwgkbtgIA9
         3X9t03eQ8kKh/Fz+fvoB66aPA++UcAS9HF57D2L1NoLBjjPVFPCdlQPw+inifp4XxVUM
         VV4rP0VzYQyhWFcqd5T2n56emkRf8H8ZCRJi8RqrOWBkW8EfJolV2iOR+N+3Ac85xuEh
         W7Wt5PywhVQ6vTauJngNVBwTKHEOdpiXwfHcfDaIBZFUQ9QHUNOqz6IH8D7Ae5DLWdWb
         HCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gcKLKcPFsmTqmqnzqvLNmDUAPYbRLWrG+hsw17aiGg=;
        b=JrHY0gROxLar2ys8iKgX2kPPv3tYuG9wRAvQcP7ABKWW40zmeSmRSzHpktzIzK/dns
         QeU/QQfM/wKyNyCfbes4K5owmuxPyzubUb2nv/vH8E17i0HqNuTzfVyAKxTMMg/fA+gx
         7VNq6RZGbxkIsf2odo3L1ucR6BjcTGOwCHyUaQhjK+PpAvAEcn79HBvumQISExHMWhmR
         htygz5vLWu8pxHym0K93bT2i8tHtj+iSKu8G8lrsCpTbnrZuBjEW/Dy8CCDjuCmvZ20c
         jNsaGIRIXxwrZ0i0tlFH859JqmEFzq34PglrWiWIUzKgBwdmjHsUTKwGw7Qj1XWBhWUF
         1DxA==
X-Gm-Message-State: AFqh2kp2KalHLz5y3b/QXHC0Gj0q41TOVVh0vUJ74YVvTscO4dLZX7FT
        NcfBccciXR/a2+VrlL6SEXn4uRuNzNw3WdYKQQEdkw==
X-Google-Smtp-Source: AMrXdXsiN92YylFQpXhOZo/HU3heQ9TSbnhWL0RkwTzI1zxn+6maFN6bMA8SXw7QfAeVYDwkjVSjV4KGOMw0Khvnxqw=
X-Received: by 2002:a0d:d5c6:0:b0:4ef:ce3a:a54 with SMTP id
 x189-20020a0dd5c6000000b004efce3a0a54mr2840966ywd.485.1674410393106; Sun, 22
 Jan 2023 09:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20230122174548.13758-1-ansuelsmth@gmail.com> <20230122174548.13758-2-ansuelsmth@gmail.com>
In-Reply-To: <20230122174548.13758-2-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 22 Jan 2023 19:59:42 +0200
Message-ID: <CAA8EJpp1c=sC0d_G1eSuOzJbjusW86zHezfwY3JRH=EBp7tNmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 22 Jan 2023 at 19:46, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Enlarge opp-supported-hw maximum value. In recent SoC we started
> matching more bit and we currently match mask of 112. The old maximum of
> 7 was good for old SoC that didn't had complex id, but now this is
> limiting and we need to enlarge it to support more variants.
>
> Document all the various mask that can be used and limit them to only
> reasonable values instead of using a generic maximum limit.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index b4947b326773..908cb0d7695a 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -50,12 +50,28 @@ patternProperties:
>        opp-supported-hw:
>          description: |
>            A single 32 bit bitmap value, representing compatible HW.
> -          Bitmap:
> +          Bitmap for MSM8996 format:
>            0:  MSM8996, speedbin 0
>            1:  MSM8996, speedbin 1
>            2:  MSM8996, speedbin 2
>            3-31:  unused
> -        maximum: 0x7
> +
> +          Bitmap for MSM8996 later revision format:
> +          0:  MSM8996, speedbin 0
> +          1:  MSM8996, speedbin 1
> +          2:  MSM8996, speedbin 2
> +          3:  always set

This is used for speedbin 3

> +          4-31:  unused
> +
> +          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
> +          0-3:  unused
> +          4:  MSM8996SG, speedbin 0
> +          5:  MSM8996SG, speedbin 1
> +          6:  MSM8996SG, speedbin 2
> +          7-31:  unused
> +        enum: [0x1, 0x2, 0x3, 0x4, 0x7,
> +               0x9, 0xd, 0xe, 0xf,
> +               0x10, 0x20, 0x30, 0x70]
>
>        clock-latency-ns: true
>
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
