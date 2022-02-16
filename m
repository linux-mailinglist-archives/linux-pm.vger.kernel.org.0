Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49414B84B3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiBPJqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 04:46:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiBPJqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 04:46:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA463AD
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 01:46:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j15so2717501lfe.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YahjJ76dlvc0fVxCPDjqbZ1zbyUMaL1zYbVs3q3Ldno=;
        b=CV40QRLasW6v5ghQgbIatjZKDlbh+mVaFRtvQbtVsjSZOp6fsQEsc4oklefz+mVzNf
         d47Qsp6bo8q5yNu9jRbGmdB7/7yyzi9q5hvaXEnq2BiNJ3ciwSaswxYZN3ZYTt/5N3JW
         QLy9voXY930FrYIosHMKN/9iespYO2xRde86MVMeU35Ua3fWfvliIfNCrfPCqYv2xWnp
         VLu49nHi9QH95nPbILxXrnBF59c0ovEnA39qnmwc1KeyL3GZ1KVqJEdXa6JWzuhtJyzH
         B74zZpWpX2wI722LhPIQ/nC3nwlR1NRM3SG+DXuNyDJe7VszmG8fI1z55RjlcQYnBFEB
         dKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YahjJ76dlvc0fVxCPDjqbZ1zbyUMaL1zYbVs3q3Ldno=;
        b=0x+tVoJRjsprkJuXN/MCTkhv0Bd+a9vcg6LopMMOvvAmrP8NtZ2pUXUONGd+5mQmK0
         qf60AoLet9Wci46NPdAHOgasFU0zwVsrOrKXFKYW60egYQPCjeGwfvFq0HBzJtKGj3mH
         tXuPmEB+jRSvOcKKpCCNI5JsyBVvP7dVz4wEsms7VqW4+6KA9jibSfRtL13x1qC2wCdS
         TioYFQHbizRzfpKRMfcR8lGth+zyoEkmAfkLBKTHtzB8uk6DZEhtbjuJ0CLj9G8bQZJL
         9bADCxisu1IWWOTCNVcuepoateuPDnN7afTdZfphMTHniDMrMx0a9Pa0/fX13zJjOdoB
         uU3A==
X-Gm-Message-State: AOAM531lgmcNPQ5zo1kXJSu+kOFxclUwr1cLOcQCHv4vxqY5U0fYNq5D
        Sh5SvPhAt0865esrP8fzHGQ2QH2J8DnTLWwIcQGz9Q==
X-Google-Smtp-Source: ABdhPJy/UUNWeVL5Vx4o7ih820QBL83abR2iCp0/U0sI910fEnhhCU1gbcQKTcrzA7b+pStqIJVCYdNxzNv/whVvgQw=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr1462531lfj.254.1645004792858; Wed, 16
 Feb 2022 01:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20220204101657.233723-1-ulf.hansson@linaro.org> <dd7d0ebd-7bd8-9f2e-e212-5b597ec729d5@gmail.com>
In-Reply-To: <dd7d0ebd-7bd8-9f2e-e212-5b597ec729d5@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 10:45:56 +0100
Message-ID: <CAPDyKFoDP-LT9nKwa0oKF0jW9DD3tZh4+v9zE0uS_KpJeFC-MQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
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

On Tue, 15 Feb 2022 at 22:49, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.02.2022 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > A PM domain managed by genpd may support multiple idlestates. During
> > genpd_power_off() a genpd governor may be asked to select one of the
> > idlestates based upon the dev PM QoS constraints, for example.
> >
> > However, there is a problem with the behaviour around this in genpd. Mo=
re
> > precisely, a parent-domain is allowed to be powered off, no matter of w=
hat
> > idlestate that has been selected for the child-domain.
> >
> > So far, we have not received any reports about errors from the current
> > behaviour. However, there is an STMicro platform that is being worked o=
n,
> > which can't cope with this.
>
> Could you please provide some technical info about why STMicro platform
> can't cope with that?

There is a parent domain with one power-off state. The parent domain
has a few devices attached to it, which means they need to be managed
to together. The parent domain is controlling a shared power rail.

The child domain, which has multiple idle states to choose from, also
has some devices attached to it. The child domain is controlling a
system clock, but also relies on the shared power rail that is managed
by the parent domain.

Obviously, these idle states are managed by firmware.

I hope that made it a bit more clear?

Kind regards
Uffe
