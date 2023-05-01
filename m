Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A36F2FC6
	for <lists+linux-pm@lfdr.de>; Mon,  1 May 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjEAJNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 May 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEAJNS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2023 05:13:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C8192
        for <linux-pm@vger.kernel.org>; Mon,  1 May 2023 02:13:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9e27684b53so293672276.0
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2023 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682932396; x=1685524396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci5juCAKmoOiPK7llJZnE3ny5XB6ZMfE2wTbd4k0afg=;
        b=OUZpv6e7vtjQNEek+wmdyq4MMBuxT8zQRythV4VMNqIo0ajFBg10gwJ5BxlAdbMVws
         j305mkW/u3QI9xtqIpFveGd2nvC3zBzh1TPO/0NsmTQvaAJwbxjAn6G/ed/1rpFI9f/T
         bXSWzxwkCTNqmOLcu4HoGD0Dpa6QQlo5QzFfMXT3QaxbVwKD0TEBwPYTpWbMuSgk3j3F
         8O18Vbo1u0x8wjUI4bz90ocFwQamxynQOEvOW3TAoXTwi5SSDdTAjMwgOdkNDJ2s3xx7
         5OO3jjQySMfG1ajonDBklG8RFDAXStHkZX1RLGriCgRqI9ciY1zQRN8HwMG+4aJbFY6n
         CYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682932396; x=1685524396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci5juCAKmoOiPK7llJZnE3ny5XB6ZMfE2wTbd4k0afg=;
        b=U8jfKGuAX4uu+t7hi6DgjEbeFmcbfWs/C4b9qYetBQmUABedoLxyzjJBaDyxdk9Jhx
         fPSEG5W9nVWGNfbBzSTdT3DDUCTyW5RmSpZNR9/zCHkCFGgD2SldI+uUixmhoI4op6UE
         uvZyo8uBB/6KXLoMr2ULNfzZCqWI+eeQwTMZl7C5x2F7vADFxgW5jPpYa6pKi3tSqH8T
         QxNf5hYSjcfofWMRfqBfqf4ncknjLsjHBLC1iyleKNPXc232fDK3KvzRllTxsDZeOAc1
         Zpk4bs6us0LWcAD7EK3RgYyA96DMxMDLwVYM2C362CuoVlJAEE8bC3PIObAfPs//K1xX
         OBsg==
X-Gm-Message-State: AC+VfDwN+yQbw8LCK0953V6ODEonvoN2bBrv6pAZdB4lcMSB7PyZM5KW
        yGj70i+r+AWhfgkn92eQZyxMJMZH92Qktf3UbGjC1w==
X-Google-Smtp-Source: ACHHUZ42y69L2m4J/LD2yJJcDnPZsng01nLQztYNTwG9noy/WJEWmPggwgc7jbKyHcNRiBRR9Ke4G++WrqRE1QyS9vE=
X-Received: by 2002:a25:414a:0:b0:b92:6588:b07e with SMTP id
 o71-20020a25414a000000b00b926588b07emr12299667yba.19.1682932396399; Mon, 01
 May 2023 02:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682636929.git.jahau@rocketmail.com> <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
In-Reply-To: <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 May 2023 11:13:04 +0200
Message-ID: <CACRpkdYDe_cC8Nj8oXbeyqZ=7GpwnHKvgafBVdYbJwDs+gzwEg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 28, 2023 at 1:36=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> Add device tree binding documentation for rt5033 multifunction device, vo=
ltage
> regulator and battery charger.
>
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
(...)
> Changes in v3:

I'm happy with the changes requested by me in v3 so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I see other reviewers have more comments.

Yours,
Linus Walleij
