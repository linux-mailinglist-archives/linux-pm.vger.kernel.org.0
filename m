Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0978DA97
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbjH3Sgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245255AbjH3O6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 10:58:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE8A3
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:58:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so744035066b.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693407486; x=1694012286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/+k6PD4xwGQdkLa4KX0Kf1ry0F1EIye4pGxjvLn9W4=;
        b=ESRpPzXR49DlUXCPSg0RaftcvM9g5TpkM86KzzSerYQkkiVwBrV6LKpfJ0t99kJZoF
         JUZCn0u/Lz2qPGz0KD1/fVcpBxWRphRAkcMaeNbzZcViE7SLaPbAoMS8XS6b2edIaNYM
         eCS0lKopU80mYd9WZ4n6Z5ppt+UTtIKC4CZgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407486; x=1694012286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/+k6PD4xwGQdkLa4KX0Kf1ry0F1EIye4pGxjvLn9W4=;
        b=Jyvc4AEcf9Ml9KwyUDVLb2KMuFPIXZqj0CxWNW9y7PpnkSOpvWriNTem4aMVMjJSbD
         RzoVBg9yxlfKZKlthj3WJMHMvqUEKv5NitT+0KRf7U53DkuS0PGPz9L/N+pUj562OV2c
         Sx6NUMDeazFWwFVAdB05XK4/ToMW/tmOizvHI3RYU2X0oepZOpk7YjwGgqqB9M71i8PP
         a38+xud10XMBJV7Kp41tDAlXgo6YFTNfsy4sSd5UZ1UChmtapNo309GOWyNAoSk26oy/
         NZgZPgSdo3Ki6yT07JuXPmeVSN3/va1L4f5qeVjwtqKicZ6fOkbLgIksb1no1kckvR5V
         4CAA==
X-Gm-Message-State: AOJu0YyB+7mFfmwoRKof5tDJ7mAdpuhy4SjbzSUIS/W6nCNIXX4QIGDs
        8LlwiFaDa6lgTJtjHSonw17Vu10bu+24uDW9sQXhMvkD
X-Google-Smtp-Source: AGHT+IF+k3CbidqG/9wuB1VT2b/XuPpQTKOMOKtZk/79wcRlGm3XOfE36mie76gVeLY7hUlnWqcxDw==
X-Received: by 2002:a17:906:311a:b0:9a5:821e:1655 with SMTP id 26-20020a170906311a00b009a5821e1655mr1756695ejx.71.1693407486613;
        Wed, 30 Aug 2023 07:58:06 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b00992b8d56f3asm7270046ejb.105.2023.08.30.07.58.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:58:06 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso78835e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 07:58:06 -0700 (PDT)
X-Received: by 2002:a05:600c:520e:b0:3fe:eb42:7ec with SMTP id
 fb14-20020a05600c520e00b003feeb4207ecmr336994wmb.1.1693407486198; Wed, 30 Aug
 2023 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com> <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
In-Reply-To: <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 07:57:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
Message-ID: <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 7:43=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On Wed Aug 30, 2023 at 4:30 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphon=
e.com> wrote:
> > >
> > > On some platforms like sc7280 on non-ChromeOS devices the core clock
> > > cannot be touched by Linux so we cannot provide it. Mark it as option=
al
> > > as accessing qfprom works without it.
> > >
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  drivers/nvmem/qfprom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Are you actually testing burning fuses from the OS, or are you just
> > using the nvmem in "read-only" mode? From comments in the bindings, if
> > you're trying to burn the fuses then the clock is required. If things
> > are in read-only mode then the clock isn't required.
>
> Hi Doug,
>
> I definitely don't plan on burning any fuses on this phone. Not even
> sure that's allowed by the TZ / boot stack.
>
> >
> > When I compare to the driver, it seems like the driver assumes that if
> > more than one memory region is provided then you must be supporting
> > burning fuses. The bindings agree that having 4 memory regions
> > specified means that the nvmem supports burning and 1 memory region
> > specified means read-only. The extra 3 memory regions in the nvmem are
> > all about fuse burning, I believe.
> >
> > So maybe the right fix here is to just change your dts to specify one
> > memory region?
>
> I got feedback from Konrad that this here would be the preferred
> approach compared to having a different dts for ChromeOS vs non-ChromeOS
> devices. I don't feel strongly to either, for me it's also okay to
> remove the extra memory regions and only have the main one used on
> regular qcom devices.
>
> Let me know what you think.

I don't hate the idea of leaving the extra memory regions in the dts.
They do describe the hardware, after all, even if the main OS can't
actually access those memory regions. ...though the same could also be
said about the clock you've removed. Said another way: if you want to
fully describe the hardware then the dts should have the extra memory
regions and the clock. If you are OK w/ just describing the hardware
in the way that the OS has access to then the dts should not have the
extra memory regions and not have the clock. Does that sound right?

If somehow you do end up with something like your patch, though,
you're still missing a bit. Specifically, you don't want to "enable
writing" a few lines below if you didn't get the clock, right?

-Doug
