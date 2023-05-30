Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE5715A98
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjE3JsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjE3JsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 05:48:07 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169F1F0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:48:06 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-439719278f9so1288347137.2
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685440085; x=1688032085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNCPRvu2yLlGHo6meKHLipAdZ4rrGhE2sVUwNXPPFu4=;
        b=a6zcQbrFD8+qf+hoWyNL9n2ONcbGCHLkYl2bzIb/H84PHBHogYJMnEUog9h7HjrI+L
         wzL24SRVObZk2/Pu5iTlP7pR70y1DrQesSqpirD5YlPu1C3Q8XB0810NjJY0s/3Q+BfC
         xfahAj/BV2CKryHWZ+Ubvzeb+mrxbtFhyIdpoSj18M/ojAxacEC2tBsbhZF7xDq6fNdi
         LE7tjEy8nAG+0QZ7a7sIuh3p9g9i4+3jcv1tUUXpiL7+dPV8o5izMySz629/8vItyTa6
         887TYiTceaNHmwPCQ9i+U7rJW70Nh+BrxtDwSvNqf6FROksTuWUdZx1RpbGgLt0fe/Dm
         nZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440085; x=1688032085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNCPRvu2yLlGHo6meKHLipAdZ4rrGhE2sVUwNXPPFu4=;
        b=T/+jY69ktJr8z1gUrVRV0x9z4/Zr8FPXHqKe/RwdNB/Fwsud/tq4GqsXywQZlFmhwG
         BwH8m8NccJRrLLu7BETnxppOs2MNfwpXQrn4++XESX35FQ3Db1ZG9gnGX+F2fIdr6NKT
         LgSoXvXZdgQnEt3kqa4ra+hlsbjPkhT8h4zCCB+RVt8u9Z1RKDSFVQV1FKLdQSqeGRYg
         Lm3VDD91YmK168aWfx16sXTaW31vW+/LQQNImPrhgi41UiiR4ttnVN/fDh5UotIlCV09
         4Wi+B31DNBTSZaN3lV8fuz3tzhJpVW2nqLgtXs4JAovj+T3i9+wRo/4vUF90PcP+rz0p
         8NgQ==
X-Gm-Message-State: AC+VfDw1MUlowgEVeVwrudEpPso3WCzzW2tjMj8aYSTvVf3hTRD5X9h6
        /cPP3eByycjSbsWhH4xhca8+pfvF8zrdWlcVknm//Q==
X-Google-Smtp-Source: ACHHUZ7snwJOZf0A5jQ3P+F3pg0Hx1A+hG7tdd6w8gctDSH0sVxaUDNXHsxJ6EdCZWCyOR/8jq8DciTGDK68NSsgI6Y=
X-Received: by 2002:a67:fa48:0:b0:42f:e9be:5921 with SMTP id
 j8-20020a67fa48000000b0042fe9be5921mr461948vsq.12.1685440085129; Tue, 30 May
 2023 02:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230417125844.400782-1-brgl@bgdev.pl> <20230417125844.400782-5-brgl@bgdev.pl>
 <9f2c0b2d-b11e-512f-1566-5097547c60d1@linaro.org>
In-Reply-To: <9f2c0b2d-b11e-512f-1566-5097547c60d1@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 30 May 2023 11:47:54 +0200
Message-ID: <CAMRc=Mey2mjNppokxcNBTyaZPTjBkiuQX-DHTvMXJkiLKq7UoA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 16, 2023 at 1:42=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/04/2023 14:58, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The GPU SMMU will require the clocks property to be set so put the
> > relevant compatible into the adreno if-then block.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

Hey IOMMU maintainers, could you please pick this one up for the next
merge window?

Thanks in advance
Bartosz
