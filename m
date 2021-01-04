Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714452E934B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbhADK1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhADK1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 05:27:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4290C061794;
        Mon,  4 Jan 2021 02:26:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so63176893lfo.1;
        Mon, 04 Jan 2021 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Et4nxJuio4ZNTBtPlqRIFRZRUkaFWNJHBrb9tgeeeJc=;
        b=qfqpLaDd16YyzQqx2QvpDrp+6se71QDteD8pteZxfq7GPL9UDayKnrFSnACESCR3vY
         6NFiRNhr+9pa2+oqzHSdzyFV1wVgAireNDBuNjf5CRoyf8QqS7cd7KI+HLQOfAUdXOT6
         CcUJSDWSjbrsvIhjcbU6OBqe8o7O4lsqY5rkGb0XzF7i5i7dS+3BehPAPe9Ke+w2/slA
         nckodocSocGYhHsyF2TpLjAdcn0Mdvhoacl+f86Zg5JZthpl/z/UAcixm5IIHKWFIakG
         5E0dK8qUp88WJ6wmwIsSENrS4g7BOcXyo/vI+g5foXwfP4k01JYO9gkjfsw6xtgGOq1F
         AxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Et4nxJuio4ZNTBtPlqRIFRZRUkaFWNJHBrb9tgeeeJc=;
        b=PQkPgz3NtEo8r9E4vPpeO5vhDV1PtiZ++5mDAWpXzz6VYwBaWoz52t8swSPFYpwi0P
         aCB6x8hqp9fdIPXRsmxrBiylKQSqvC9XEFEbf6Fy6UBIIiG6zzOnylhgOjcQgHKrhnyy
         Z28n5O3EbGkOcnO1NWnbPD8EzsauRjfw4q4QD3z+z5EzZ6bYVcDUOZXBq4WQgKoN8GQ0
         0xjZFdJhpCC2NK0ahZoPaDKp23gOb1qOBSkIH5WdNiGQ2iH94tqfje5TsU1KWrR6isO3
         7QpII41o7OFIUWPQm+ri9klOXHglP18A9g2rW9iECKou5pY5e/y+CPsBahIb3sLzzQfE
         QJ6g==
X-Gm-Message-State: AOAM5300RbMkWogYvsoShBM1aRqQKWX1pe+JLukMsePpPvkx/4MwLVku
        USwkp8yy4QYJohWNQ+ofxdpcOroketbxOgreSbusCd9yP1Q=
X-Google-Smtp-Source: ABdhPJwrAY/Wb2Zq4TlZIihhl3On2eBpe9OQ90H5lTfXBVG3owYbx3F8E7q1iRtIY9G7ahLsLqBtDHkKFUg309Tr01k=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr37333079ljg.291.1609755998142;
 Mon, 04 Jan 2021 02:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
In-Reply-To: <20201230205139.1812366-1-timon.baetz@protonmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 4 Jan 2021 19:26:01 +0900
Message-ID: <CAGTfZH2WCamOtih1Gk5W8uJ2ewEfdFQegsPeWp0dSNYcUt7QLw@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] extcon: max8997: Add CHGINS and CHGRM interrupt handling
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 31, 2020 at 5:54 AM Timon Baetz <timon.baetz@protonmail.com> wrote:
>
> This allows the MAX8997 charger to set the current limit depending on
> the detected extcon charger type.
>
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
> v6: No change.
> v5: No change.
> v4: No change.
> v3: No change.
> v2: Remove empty line.
>
>  drivers/extcon/extcon-max8997.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 337b0eea4e62..e1408075ef7d 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -44,6 +44,8 @@ static struct max8997_muic_irq muic_irqs[] = {
>         { MAX8997_MUICIRQ_ChgDetRun,    "muic-CHGDETRUN" },
>         { MAX8997_MUICIRQ_ChgTyp,       "muic-CHGTYP" },
>         { MAX8997_MUICIRQ_OVP,          "muic-OVP" },
> +       { MAX8997_PMICIRQ_CHGINS,       "pmic-CHGINS" },
> +       { MAX8997_PMICIRQ_CHGRM,        "pmic-CHGRM" },
>  };
>
>  /* Define supported cable type */
> @@ -538,6 +540,8 @@ static void max8997_muic_irq_work(struct work_struct *work)
>         case MAX8997_MUICIRQ_DCDTmr:
>         case MAX8997_MUICIRQ_ChgDetRun:
>         case MAX8997_MUICIRQ_ChgTyp:
> +       case MAX8997_PMICIRQ_CHGINS:
> +       case MAX8997_PMICIRQ_CHGRM:
>                 /* Handle charger cable */
>                 ret = max8997_muic_chg_handler(info);
>                 break;
> --
> 2.25.1
>
>

Applied it. Thans.


-- 
Best Regards,
Chanwoo Choi
