Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E278DA7E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbjH3Sg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbjH3ObB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 10:31:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14037194
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:30:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so7346539a12.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693405854; x=1694010654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z1Z9G4G/KVFZhr9R3sGbutXUCNsEgKocPQNRqGJxWY=;
        b=InT2PRboit3mGRgrtDDf1DpFH+SIx7SEgZLaB5iTnd6aK/mAnN4nP45NYyu8i5Oshq
         U6Gr93effQIrqRXwd7cf+mxvQDP8foxAflFjuPvsJwumXjmPJIrHBsknb4Q0lew+wMve
         gBA2EEGvBVb0Sr0XT3bzEBoGj5xpMHaQ0VhTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405854; x=1694010654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z1Z9G4G/KVFZhr9R3sGbutXUCNsEgKocPQNRqGJxWY=;
        b=SnQGMP55tnAAEgCCKxlzVcl49bpYU19fStrlQtQqwfHx10HcmO90ECMJ4zsshZIXbh
         hWwX6ibA3ODwnEkVY5KZqfquefu9QT2GmK4//Dou/+F2fUJZe5vH+XK/8BCfpq78pZm2
         TL7fFYuMrCdCqhn0VMWeE9tRET698Rtt3wWb0mJhzbtSdn8yv6QmW9cpG7jRZdV/5tCc
         PjoMWCtW9xhBYhVN7+0ac7QC3+XCTyOs6eyhXTalMWKtFI4WEwP3RS0iqBzE7qGJHb/O
         hLs5IfNgYmT2tYuR0JwrCzE/Fwl9xUxXykVDYMkxE1x/7GlZIWQW2Xiuum2uYKvINKF1
         hX1g==
X-Gm-Message-State: AOJu0Yyw01FNRDJxWKhxBY0DvRogib07K8zVkyLCnfmuhWybRK6cXjqr
        NmM5DR/Ap7LQUa1Uip961FUoZZwq8VM9g1S4v0xilAaJ
X-Google-Smtp-Source: AGHT+IEfI12+qTs5/z+GDGkfXxogSbvBwBvgRnVp9uKV7WKUR56BmMCJtngDhGjzfRHyKeraSxVsdw==
X-Received: by 2002:aa7:d80f:0:b0:52b:ce21:ad12 with SMTP id v15-20020aa7d80f000000b0052bce21ad12mr1745202edq.4.1693405854480;
        Wed, 30 Aug 2023 07:30:54 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7da09000000b005236b47116asm6862435eds.70.2023.08.30.07.30.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:30:53 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso74955e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:30:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4f93:b0:3f4:fb7:48d4 with SMTP id
 n19-20020a05600c4f9300b003f40fb748d4mr325936wmq.3.1693405853267; Wed, 30 Aug
 2023 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com> <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 07:30:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
Message-ID: <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On some platforms like sc7280 on non-ChromeOS devices the core clock
> cannot be touched by Linux so we cannot provide it. Mark it as optional
> as accessing qfprom works without it.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/nvmem/qfprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Are you actually testing burning fuses from the OS, or are you just
using the nvmem in "read-only" mode? From comments in the bindings, if
you're trying to burn the fuses then the clock is required. If things
are in read-only mode then the clock isn't required.

When I compare to the driver, it seems like the driver assumes that if
more than one memory region is provided then you must be supporting
burning fuses. The bindings agree that having 4 memory regions
specified means that the nvmem supports burning and 1 memory region
specified means read-only. The extra 3 memory regions in the nvmem are
all about fuse burning, I believe.

So maybe the right fix here is to just change your dts to specify one
memory region?

-Doug
