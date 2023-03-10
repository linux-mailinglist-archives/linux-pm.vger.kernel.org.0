Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB36B38B7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 09:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCJIcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 03:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCJIcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 03:32:07 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5763E8AA6
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:31:58 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536bf92b55cso83838167b3.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEnDDQC7GhZEI1kmJpTuNmo6i9voSvFWeItpPldUIYU=;
        b=cD7vD9Z1570thbPMT0MfQRnKjBSUb9CqZPM0xYCHqCuvP1TriRXZTLOaJQg3e0j0xv
         vF4UXxoWFEUhYG+S6iyTO/cS8Zk14IaLq7ewYCEX1hASo2mZFUmguU9VaPAQCB875cwn
         CyB9mXKtHUvw5UtoA0m/qoUAJpmelkAV865sn4UcYuqFYQEvX1W69b48IhZurvoINQ+7
         Jl1Tgz4+nJyiGVY32DVZ8n4lWyvH/+trpIXJ8pPS+2Fi4tNU+Y7zJsEV8Tbb2f860jte
         YaMWuNzBgBxa9SlIjIAxc3jCX29lk9eJsoS3YfRLlMzHClXKezdNcy6Nmw0MoKukiirW
         /w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEnDDQC7GhZEI1kmJpTuNmo6i9voSvFWeItpPldUIYU=;
        b=bMt60E2/efpoYdZv+GdNK4hu7h8wmxyVg1nPGbseCz7pWqP3jF2HGCk5N/ggoWdL9u
         EjjdyZQR08hHe7UhhwMNmVkq80YlIpNRWcTnvOndTS/EgvpgFqxKXR6l2eoWmYfa8RjK
         lqGTWIMJp5w1gocUtK4zNuMKnFHtLg3BSk31jxdAXjlxTmfgDWUdcwyVRBgrSIhQtTOB
         PjDGxhgSEMYW9tDya1unVDNl2XhmlXsdt7At7NI3zXPenKC+e44lM2+IzDNPWO3BzsYt
         po/Rt+bOqH3sg9KUISOHd07JBBqCqoHeCibqotgAEUx2jlDtjRdnkrfACmdGyC1cpzrl
         TAWw==
X-Gm-Message-State: AO0yUKVpgyWj04drxsg1ItSj10g1G69oqwQ3HtayLCl/fdO0Cf5OWZ2h
        /8ZZHmDElUgWqnVoBM4Dn+TV9LkSRSXwhP+Y+OOWKw==
X-Google-Smtp-Source: AK7set/dzMiqf5mSy0pANYi5bUztGCql2W6gCMXtz6HB1aFjDIVxaXeUN9JRSGvg7YJ9h8wxNHPwjjTrVbv03zrk03Y=
X-Received: by 2002:a81:b705:0:b0:535:fe26:acc with SMTP id
 v5-20020a81b705000000b00535fe260accmr16173406ywh.10.1678437118046; Fri, 10
 Mar 2023 00:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-10-sre@kernel.org>
In-Reply-To: <20230309225041.477440-10-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:31:46 +0100
Message-ID: <CACRpkdY5kzCm5fQgoXQBV_mAGYQP2rvjgc9cdLQwfFhO7LKdYw@mail.gmail.com>
Subject: Re: [PATCHv1 09/11] power: supply: generic-adc-battery: simplify
 read_channel logic
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Drop mostly useless gab_prop_to_chan() function by directly
> supplying the correct enum value to read_channel().
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Looks correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
