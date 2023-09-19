Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059667A6647
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjISOPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjISOPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 10:15:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D0114
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 07:15:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so12467941a12.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695132922; x=1695737722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/FEvYyM2EeHOdSQPD/GJAyv/Ms6P3+0S37WW9XjZPo=;
        b=QbuUhioLqJZVSDd0vPnu4Iug5dPe74scweC1i2KIz5LTW3DH75VcZU3AjpIzp8JAVp
         7wgYfU16VvvwovMkySO5NQxvjwczbIhCloObfaGcQsiYDK9aXIAqcGAQSZGWhHvvINtz
         XcNOGbkEb0HRwInIYcHhvEgz4BBnbTlUNnVyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132922; x=1695737722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/FEvYyM2EeHOdSQPD/GJAyv/Ms6P3+0S37WW9XjZPo=;
        b=V6z+z7i5HOwuMGWHFzxworn62uMgtgJ1JgwFPr4u5QcTAg5FwWaP24z03Ng8dJ0TBj
         MjWT3r3tBohoa879JZs2lukUTf0mzvXSMWyfMMeSCtTUzU2ChzlTdtEQt4lawWnmDkkH
         Iy1MuWXrxIesBKvH8bRxGZTpyHGj4dS53osAMr+b9pDxGQ9HnbA0IrWuWHN9+pJSjCVB
         2rXMCmQz2cTGowGKtUXmDGunkmt04U4W7UO5hBOSael8YYu/09y3Q9xQ/Qe/XdcLmmX3
         ZAM78JXZB1XsoqbJgEOSZLDrZc0lH+x6Arl/OWVWs/dwDKUqOJyAm1Fse9aQXrKo1JS4
         MzTg==
X-Gm-Message-State: AOJu0YyZlL6zjZ1mOQ909GqApgNulviYjwkXSSkYLXapspwMDRUVYfDx
        8Zf6DMZzgrgKDo5Igj42qu0WNrptepQnPMRZiEZKT6ec
X-Google-Smtp-Source: AGHT+IGFL6z65ZDV1n9RuPjp+sBcadAZz4zjB9ZIfPalc0e3mrmSIHdn3S3hTLfcD6xGUf0xW8owHg==
X-Received: by 2002:a05:6402:f0a:b0:523:c36e:ec8b with SMTP id i10-20020a0564020f0a00b00523c36eec8bmr4112857eda.9.1695132921552;
        Tue, 19 Sep 2023 07:15:21 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q18-20020a056402519200b00530a0ceb4a0sm5719986edd.37.2023.09.19.07.15.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:15:20 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso68765e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 07:15:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0b:b0:3fe:f32f:c57f with SMTP id
 bh11-20020a05600c3d0b00b003fef32fc57fmr110023wmb.0.1695132919977; Tue, 19 Sep
 2023 07:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com> <20230919-fp5-initial-v2-2-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-2-14bb7cedadf5@fairphone.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Sep 2023 07:15:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmW8QwcT=YN8VSffuds2ib5zYPr6O2oQ=kUJkKa=5Bmw@mail.gmail.com>
Message-ID: <CAD=FV=UmW8QwcT=YN8VSffuds2ib5zYPr6O2oQ=kUJkKa=5Bmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] nvmem: qfprom: Mark core clk as optional
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Sep 19, 2023 at 5:46=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On some platforms like sc7280 on non-ChromeOS devices the core clock
> cannot be touched by Linux so we cannot provide it. Mark it as optional
> as accessing qfprom for reading works without it but we still prohibit
> writing if we cannot provide the clock.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/nvmem/qfprom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
