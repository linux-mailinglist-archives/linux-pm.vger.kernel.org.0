Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFA79B646
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 02:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjIKVFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbjIKObI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 10:31:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA7E4D
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 07:31:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso3891714276.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694442662; x=1695047462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRMbduXBtm2u3hpR450ozQ9ET1j6hRdg7A226yfqXL4=;
        b=IV60T76h5W9/i/guaWR4U3emnwbgbSJJC3vrAhyqCyMzYnggSjL/CPbSdCMJE01WdY
         uXwFGBxMdGvBsx3Qxc5p1AGgTD+VIYFCt0T+dnQ6/8+0ey0RBp73QeaeMkxqrEl23eBL
         AxqVz2NLI9ojxbv6xIbQhLsGEEMykQBJglD6oVVv+NZggCYAw2wU4DJhk/EzpqqT4l4z
         9rA9e9vLg4P0PbhKbzFovKVUQ9A0iOimkPqXIiKdA3EtagA8a/MCo0DhuemZ0e+PZ8EA
         oj1s3O84DNyg+OxXCY3RgzFuP64at/H4/MeLsTq8PDfQooE1vYsXLwz/xjuNFujN/kmY
         e6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694442662; x=1695047462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRMbduXBtm2u3hpR450ozQ9ET1j6hRdg7A226yfqXL4=;
        b=kVrGFqXx2nbhHroNGbQr08p31l75/0JFfFU2q4oGmN9cYr99n6d1kHhhYRUTUDsrdV
         DduqG5AUv4hcECqugtXZXqZ9X6aWMiNrJn33TlVCaqG031IcFnU3wuU9qkFLpHKqUhOM
         EefZ1Q/qGoRkPyzjIAgNgEoSo2yZak4NnzC5qkzkFnYw3T4is8BMnXh856BiuSGuKa/t
         5S6WIPmfZo/Tdkv0i9wRplARkqx08ER4NheJUmfdllvBQEoP5TkzE6t1So/wdytfUjHr
         Z4YUruDCSsQFobhVgAVM351479PvLr8ZIlXh8DW4Dm+0Lu5kfQYlgIs9RaaQjUSg/do6
         z2JQ==
X-Gm-Message-State: AOJu0YzGkAkDjlL8AS5Fno3KM5/kRpGf30zFEgsY2Ksuo+ryr+LrXI9S
        6K+8yM/KTqKuE+/6Y6yttPVoWxdQxJV7xa+RfwrjiQ==
X-Google-Smtp-Source: AGHT+IHM9lDnQetC5LLtRbUDBIR/L+NWqkeueFcXF7OnhW3zZVv6Wnt9N3vGRRwv0ZYdb7tOzOpDbqjMCh4fQJ5M7tk=
X-Received: by 2002:a25:7392:0:b0:d7e:761d:cc83 with SMTP id
 o140-20020a257392000000b00d7e761dcc83mr7054140ybc.14.1694442661879; Mon, 11
 Sep 2023 07:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
In-Reply-To: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Sep 2023 16:30:25 +0200
Message-ID: <CAPDyKFqTs=mRnBRREbT+WFj_4qTLd8LTKigY_1TAZOqGGUKk3A@mail.gmail.com>
Subject: Re: [PATCH V3 RESEND 0/6] Power: T7: add power domain driver
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Sept 2023 at 04:52, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
> First patch is that remove C3 some power domain ALWAYS_ON property.
> Second patch is that add driver to support power parent node.
> Third patch is that turn on power if initial power domain with
> "AWAY_ON" property state is off.
>
> Other patchs adds power controller driver support for Amlogic T7 SoC.
>
> Changes Since v2:
>  -Modify subject.
>  -Define PWRC_NO_PARENT UINT_MAX
>  -Remove modification that transform is_off into 1 or 0 using !!
>
> Changes Since v1:
>  -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
>  -Modify T7_NIC flag  "ALWAYS_ON"
>
> xianwei.zhao (6):
>   genpd: amlogic: modify some power domains property
>   genpd: amlogic: add driver to support power parent node
>   genpd: amlogic: init power domain state
>   dt-bindings: power: add Amlogic T7 power domains
>   genpd: amlogic: Add support for T7 power domains controller
>   arm64: dts: amlogic: t7: add power domain controller node
>
>  .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
>  drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
>  include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
>  4 files changed, 185 insertions(+), 14 deletions(-)
>  create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
>
>
> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70
> --
> 2.37.1
>

Patch 1 to 5, applied for next!

The DT patch (patch4), is available on an immutable branch "genpd_dt" too.

From now on, I will continue to put changes for genpd DT bindings on
the above branch, to allow SoC maintainers to pull it in to manage
potential dependent updates to DTS files.

Kind regards
Uffe
