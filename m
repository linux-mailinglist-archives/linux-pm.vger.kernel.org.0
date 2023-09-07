Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51585797667
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjIGQIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbjIGQI3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 12:08:29 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C152726
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 09:02:25 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c4b4c40281so1175827fac.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102478; x=1694707278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWjc9Tq24L0z9SehMarme94KIq1a0OWmKWnWsMLtL6w=;
        b=Z5EO5gg+zDXtEm9XTp8cBUxU/FmFQ1T37iZglFImUxYTF+j5At1dqW5FmwXhy3cD1r
         WQzEuEXbeVTONRRKAmnVANSA3efAawXfhkQuglr+KYkxI59GZt7BlrxvJw3DvJianuBd
         Jj/tez5Ne3vR0hV29ovi48zVCApFb4Re726lp/kkB5W2AiS7+rjgFbvv8BX5alyNMosG
         ssrnyaTm8j2oHezxHTumUdasgsf7Mj7OVfFOOCrzKHLd53vCEQdoQdSRummvDuobudrk
         XV08d1JhIoxtFpo2eAl0b30TF378PoExr7kcMQq41EqOhYG0KW7sE7nBqmA/ofspwJmW
         HjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102478; x=1694707278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWjc9Tq24L0z9SehMarme94KIq1a0OWmKWnWsMLtL6w=;
        b=Ji1/66PV4pHGbLucMwtR6x8b1QM2NPC6o6cD2clHqbf7kdZ4gso7gFyUZ79qiNTiRp
         SJjbkQw4RqkZ7Iydqgtx9cBZanvfe46F+u46TyvpIRhyiKS1gDlD6Wq6Z4fWvklvJmM/
         GR3LEY4PKBOyJDkk1WppkRA0CRDbiQOABRlbxn6iJSq4jYY/s6khsL6wHf/tRQmOMvdB
         OWWCNcddv/rkyFQ6CvM4aZpUDeJH/uqG7kfiAHdZBjwo68rZ39woSVB52ghuFZhzpRzl
         nomQNABciDh6v29xxodPMbT5FUOrgB4CX1TGxEP+G92a4Czt2W8G7E5QriFMMwhstNlc
         h82A==
X-Gm-Message-State: AOJu0YzybqFOK/pExu3/O9AMtuWyNUZZIbfydAsMPksRFleIRav440Sw
        8rfTCW8F4rELRFrkDwk8hvlN7/dG3Tkx/oWHq2sglul7yzIfA4Qj4sc=
X-Google-Smtp-Source: AGHT+IEfYqhUFJ1cVabsx1fK7bxKAay+z3MPpC0vnndLwwN0XFbr3Qb0Xl2nmJ3y7ZRnqy/9qAjqB1Ntotany1k2aKs=
X-Received: by 2002:a25:32cd:0:b0:d78:3b67:ef3 with SMTP id
 y196-20020a2532cd000000b00d783b670ef3mr3182735yby.12.1694095033559; Thu, 07
 Sep 2023 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <558c6b70090ea7220bfb0b6e7d81828025018376.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <558c6b70090ea7220bfb0b6e7d81828025018376.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:57:02 +0300
Message-ID: <CAA8EJprUgcmqFeNeuFgnRkk=XUr8NjNMMzd0y7sVhOnGUnn2qA@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] cpufreq: qti: Enable cpufreq for ipq53xx
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Sept 2023 at 08:23, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ53xx have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
>
> Added support for ipq53xx on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
>
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-dt-platdev.c
> index 02ec58a..f0c45d4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -178,6 +178,7 @@ static const struct of_device_id blocklist[] __initco=
nst =3D {
>         { .compatible =3D "ti,am625", },
>         { .compatible =3D "ti,am62a7", },
>
> +       { .compatible =3D "qcom,ipq5332", },
>         { .compatible =3D "qcom,ipq8064", },
>         { .compatible =3D "qcom,apq8064", },
>         { .compatible =3D "qcom,msm8974", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-=
cpufreq-nvmem.c
> index 84d7033..49d21b0 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -146,6 +146,20 @@ static int qcom_cpufreq_kryo_name_version(struct dev=
ice *cpu_dev,
>                 return PTR_ERR(speedbin);
>
>         switch (msm_id) {
> +       case QCOM_ID_IPQ5332:
> +       case QCOM_ID_IPQ5322:
> +       case QCOM_ID_IPQ5312:
> +       case QCOM_ID_IPQ5302:
> +       case QCOM_ID_IPQ5300:

msm8996 was bad enough. Can we use compat strings instead? Or make
this a default for qcom_cpufreq_kryo_name_version()?

> +               /* Fuse Value    Freq    BIT to set
> +                * ---------------------------------
> +                *   2=E2=80=99b00     No Limit     BIT(0)
> +                *   2=E2=80=99b01     1.5 GHz      BIT(1)
> +                *   2=E2=80=99b10     1.2 Ghz      BIT(2)
> +                *   2=E2=80=99b11     1.0 GHz      BIT(3)
> +                */
> +               drv->versions =3D 1 << (unsigned int)(*speedbin);
> +               break;
>         case QCOM_ID_MSM8996:
>         case QCOM_ID_APQ8096:
>                 drv->versions =3D 1 << (unsigned int)(*speedbin);
> @@ -359,6 +373,7 @@ static const struct of_device_id qcom_cpufreq_match_l=
ist[] __initconst =3D {
>         { .compatible =3D "qcom,apq8096", .data =3D &match_data_kryo },
>         { .compatible =3D "qcom,msm8996", .data =3D &match_data_kryo },
>         { .compatible =3D "qcom,qcs404", .data =3D &match_data_qcs404 },
> +       { .compatible =3D "qcom,ipq5332", .data =3D &match_data_kryo },
>         { .compatible =3D "qcom,ipq8064", .data =3D &match_data_krait },
>         { .compatible =3D "qcom,apq8064", .data =3D &match_data_krait },
>         { .compatible =3D "qcom,msm8974", .data =3D &match_data_krait },
> --
> 2.7.4
>


--=20
With best wishes
Dmitry
