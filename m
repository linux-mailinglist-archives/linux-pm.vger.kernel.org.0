Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346C754DA9
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jul 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGPHiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Jul 2023 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGPHiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2023 03:38:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D11995
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2023 00:38:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ccc462deca6so1045071276.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2023 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493084; x=1692085084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZZtnrhK5IcktWMV0LXWsExsbNpvJz7HVoSErboxnqE=;
        b=fg8pvT++8sfktwji6DueuZTXHHoomuijR9Qi/cDAdShspvjf/Sa9B4fhOHxCl4PxSH
         +5rm78WNx+iSvjERFjYuv0zUtxzMe9whCNLCSWpSdQFPHn5IXqJn+dyL4mGkdrkxfqW4
         cOo67bhPfPX0Af3OWfNTdrGaDnVaMCTvVTlh9OgTi1n4XjMyKSPcavNwHRqt/L6L+ZxS
         10Hry4EiWYfS4PbQZdDDj+n1EoGavznaRa3Yq3xmuKzcMJDRNCC9HZ1bNs/HnDA0B7Ow
         Ar3AGKpNGtNDISrfCz3fZ44dIcp5mN7iUnDeUOmtwF0srJFOo70uwybdmizWQfuaUBf0
         bE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493084; x=1692085084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZZtnrhK5IcktWMV0LXWsExsbNpvJz7HVoSErboxnqE=;
        b=cekIGG5btOnGmgn8mRU5Aq650sGP0NtdpY/x0ABOofNDqXOy7so7VDLICAuA9rxNRC
         uBtmbdxvWwLwMYbya5xVQyWVSCYml1Pbb/b/hOZWyNmKrXWMfKM5WFwTCbe4TAIFk0Hx
         z40oOppFkMH2M0OUuOYifoC+FnWOkFvfslgAttnlP66891UFl/G86FHFfTRlEK8GPsNd
         dRG8DTNAnSdrc1Yc4f/vt+Q9wwK9Nk/S7NC1T69gxdWVLkfVG4yRaQcmGJloLdPle/o2
         QY79maL0l3wwoQ7ZsHZr3z6c1xsqaMO7/Z1EoH2rsrp9vBhk/0CjE6zeN4YGn/JFSjcm
         0NXw==
X-Gm-Message-State: ABy/qLZsr0bR1gGVRoij0ALBm7E5F7mq/3Hbp1etfTWyinj2o1PE/lrs
        1HQx/hvEhH+GCtNgH5DruFuk9dFaICvkM5fUOVmaQw==
X-Google-Smtp-Source: APBJJlGb5i+pBG2gTvRS0IwH689ZIYfyMJZ1vvYWUAAgWwRxkmV/eunY9C78J7OPPqzuPiEUw8MHDNNoLMB9CfcaMlA=
X-Received: by 2002:a0d:e306:0:b0:577:3666:bb4e with SMTP id
 m6-20020a0de306000000b005773666bb4emr13143755ywe.36.1689493084340; Sun, 16
 Jul 2023 00:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711142247.751857-1-ulf.hansson@linaro.org>
In-Reply-To: <20230711142247.751857-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:37:53 +0200
Message-ID: <CACRpkdZUpU0iM3F1FG+U=gtm-oQEZo7tzPrhnXa2KK=wDCKWNQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] ARM: ux500: Move power-domain driver to the
 genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 11, 2023 at 4:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> To simplify with maintenance let's move the ux500 power-domain driver to
> the new genpd directory. Going forward, patches are intended to be manage=
d
> through a separate git tree, according to MAINTAINERS.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
