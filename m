Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A76AC153
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 14:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCFNe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 08:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCFNe4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 08:34:56 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9D2821D
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 05:34:38 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id f20so6437427uam.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Mar 2023 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678109672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6pycp9wejfOSD6NpKbRsXjWRkgwi1tjorQysukPNaU=;
        b=tccZYS+Z0U+KQyB49J02mAnSgnbMcDA9pIkiOOz0RzGVC4hIRB+t0iNDQUhWGIGEop
         yf4IzQcWXceh/ypH1QUx+Z5R7KHWVXPohZ0wlm7TaoyAO82Nby6GeWxnXUNvh7zKhV1s
         c7Z3ZdluKTWaJYfT/7r+2YFI0rxNs8Bu00u0ZfTMw6nC3FyDuanNuwnYKiVguhyfnwZG
         Vc2hMiBklcK54Yyw3lDuJKxbwb+nx5Xn1U42/TkB0qb5tvA0zf65WITA2guYaaR6mo3D
         Q8Nm9+p/f8sID8G24s2xf1wn4ojuz1mckZrw9Y9cdztlKHNpjErME0+uw7yuMcu3FhOU
         9W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678109672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6pycp9wejfOSD6NpKbRsXjWRkgwi1tjorQysukPNaU=;
        b=r09E1chnblamhU4v2+E55X7hPYtBrHYJ35BbXmDfp9UHAhx3as6uiQCQ0IFXNZoIR+
         UQfEcMhOEUfQVmVsdpPX89MsXEjII8IF/pXqPEl1aa9B6QQm4TfPIwXpNb7O//1ET979
         iQ34B2ZwDzOtMoNFs+dEypXQh0bXlOcNWszYCYcMpvjKYxbybGpIcDfHIkIHVRtZHMIH
         uDFUOCVN51bu0tiocydMVY0Jd60hfCMOvWSr0B8tL3T+IJULvkNYfICAq2wuKzFgGuWx
         Uympj7ROrXvf1DkA3t2JL/QlEq/m57VsibCPSo/dHV5vHy+MZLY4BfhupnHPgpkYq1AJ
         UO/A==
X-Gm-Message-State: AO0yUKVYhx693wsisJWgJMjoum/nPCjapynbjN+wNXeDoBeee0VQaffC
        WXU5hk+oLSrP51PnIIg0kYpKfF+SQrlmJvDs1kEZ6g==
X-Google-Smtp-Source: AK7set8rlDbjRu4mirR9cg4IcTS7SYd05iHTrYKbKdKV2K8c/iT3Zadt213cga4eNeljgM1jjM/6lcNKE76AJmmvmiI=
X-Received: by 2002:a9f:3104:0:b0:687:afc8:ffb9 with SMTP id
 m4-20020a9f3104000000b00687afc8ffb9mr7118679uab.2.1678109672089; Mon, 06 Mar
 2023 05:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221150543.283487-1-brgl@bgdev.pl> <20230221150543.283487-3-brgl@bgdev.pl>
In-Reply-To: <20230221150543.283487-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 14:34:21 +0100
Message-ID: <CAMRc=Mfh=m_+_XpxnYuBPisWNZxyLmhEDO9KxtWTT-p4YHFT8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p: add cpufreq node
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 21, 2023 at 4:05=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add a node for the cpufreq engine and specify the frequency domains for
> all CPUs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Bjorn,

Viresh picked up the dt-bindings, so this is the only thing left to go
into the qcom tree.

Bartosz
