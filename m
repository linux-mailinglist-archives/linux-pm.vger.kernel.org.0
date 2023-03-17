Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E566BE014
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 05:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCQEQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Mar 2023 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCQEQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 00:16:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101FB53D3
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 21:16:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so15606802edb.11
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 21:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1679026566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ev5OIriLd8TfqA5c4EtuME02ulo1DCJFDytsxJZBhk=;
        b=KVym4KsPs4lbipnClxHVlIDpvF0tz4OM52461JamvSARxqw4Qsd4Q1VhIogAigMF3P
         Zh1TNuTdXgoWtDExZPpqlsQDicuZu+tVLZQiglu7KWkCHyZGEOwAREoC67gtNvFU5hX0
         ed7KDbhUroQI/NLBZr2kwGwp0xBQmGQfS9eSK+a3QOIEPuLuQ5aLC9wOKPJmyp2Lk70M
         UosDdD9GJIYeAuYAho7SNTOa1YJSYOslH9t6ECfzQX0hcXvBmpyIXaqChCYA5tU9OJ5r
         rkAM8txuEzxv2nisB7MDMAHwr/hcgGqqUM54MVa0b41g0lDznS+AVy7aKBN0P3scAa2V
         09RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679026566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ev5OIriLd8TfqA5c4EtuME02ulo1DCJFDytsxJZBhk=;
        b=DNcuhvhhGG7yCUgK/Fj+TeRBhAqlVsz0/NzHWkQQdjFSU16NwHbcqYkMC/8zJQ4AZ4
         u9YUxhibNJBWwm9CcNbwLFOIwV3zD0RwS0wP6jwYdy7J33l0jSsnufrgGSwUOWI2OfQH
         w4R9ScCwTR25inzyu1v7hW9LBM3ynGkyLnyAthdJQkAsoNZVUuWP4CJ+WUDFw+SFNKk5
         0h6yoxxuEf9dzTyWicEqPg3EmH3twtZn9N8TUeLShplTjPdawCQKr0aCzmc5tzJfG5EO
         r/N05Kwew0WHgM9Xi6eKxUO/cMKA+j6Uh3GmJ6aa/Exd7V88RkFVvJ0Q63koEwKhRxjY
         Dmvg==
X-Gm-Message-State: AO0yUKUdlhxtzEPlYdxU7h4rpY4zBUyhgx1gSvaYCeklF6MFciFqZtBe
        LN5J+HgvVdliE5FUhoz2HajsQZsZ3GR/N6n0J+r2WA==
X-Google-Smtp-Source: AK7set/XeeEOd+FtzL3MTXXII1yiO1F3TxBHDttiukeaTtzGeJdZUgTY3kqMR9FqRfno5OlhXVB5YA7QTCM53ahqloc=
X-Received: by 2002:a17:907:36e:b0:8b1:3d0d:5333 with SMTP id
 rs14-20020a170907036e00b008b13d0d5333mr6533936ejb.13.1679026566443; Thu, 16
 Mar 2023 21:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144703.1541888-1-robh@kernel.org>
In-Reply-To: <20230310144703.1541888-1-robh@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Mar 2023 09:45:55 +0530
Message-ID: <CAAhSdy1vqiLE40ZoFaw48zyU0QGapafh=ytVFjETX_9wruqHmg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 10, 2023 at 8:17=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For cpuidle-riscv-sbi:

Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpui=
dle-psci-domain.c
> index 6ad2954948a5..e875ddadc51b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -165,7 +165,7 @@ static int psci_cpuidle_domain_probe(struct platform_=
device *pdev)
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
>         for_each_child_of_node(np, node) {
> -               if (!of_find_property(node, "#power-domain-cells", NULL))
> +               if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret =3D psci_pd_init(node, use_osi);
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index be383f4b6855..1fab1abc6eb6 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -497,7 +497,7 @@ static int sbi_genpd_probe(struct device_node *np)
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
>         for_each_child_of_node(np, node) {
> -               if (!of_find_property(node, "#power-domain-cells", NULL))
> +               if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret =3D sbi_pd_init(node);
> @@ -548,8 +548,8 @@ static int sbi_cpuidle_probe(struct platform_device *=
pdev)
>         for_each_possible_cpu(cpu) {
>                 np =3D of_cpu_device_node_get(cpu);
>                 if (np &&
> -                   of_find_property(np, "power-domains", NULL) &&
> -                   of_find_property(np, "power-domain-names", NULL)) {
> +                   of_property_present(np, "power-domains") &&
> +                   of_property_present(np, "power-domain-names")) {
>                         continue;
>                 } else {
>                         sbi_cpuidle_use_osi =3D false;
> --
> 2.39.2
>
