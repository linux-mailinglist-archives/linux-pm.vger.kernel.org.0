Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA56A3E3A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 10:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjB0JWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 04:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjB0JWQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 04:22:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F51FFD
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 01:21:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g17so7623087lfv.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677489686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4vKb9mEq8TjcumxIlTnCGVRdXGwvc52NzKU43XYqaQ=;
        b=LsuSnJZ1AgMn0+FwWdXrwe6b5ZDdHxdwLSLl3CwD910O0wBuUcrfKJoR7k+uvMvrVM
         ixA6DTs1/DSoacWt4jn3CX9AGnOZDoWURey/HHhSaDHzjC9OVxPLyC5hZJFuXSX1EUPd
         JHOmkShINZ24+kIIhp6flTOpPOR95PIQmXKqnJ12obbHjx0I/oMY+HgO8ax1eNylLjee
         WwP8Lz7aBnmU/NKW+hiCXQ9gLGUn3mxk/9caLhyiSjTlCz37VVS3Tuc9ND7rJhUErACj
         m3/OXHgfzXcYmovi78hidHAqRmKmCGRSkEnWCeH0psQcDyCJ58mlys1SlAa7qbfGXsMs
         8SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677489686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4vKb9mEq8TjcumxIlTnCGVRdXGwvc52NzKU43XYqaQ=;
        b=YnYyXuVQpinpbFlEyIjYSWL8DYtxaEZKcffoYz8WfPTu3TSIzKNgusS51nX1s/ictZ
         f4iQiOaeFfRtsCWx5XEJvHLaB77Lxce/OxOwlXff9k7oC+P3l35kmM4my45MaiHmr784
         7Qes8RWY2KDZpEVrd+AM6yNPQQue095/NWc/YnBHjEsVQJri6FS54mqZit+yWL+uGeZ6
         k6tSuI8cRga9qaRA3s6vKL2xbnu5Ap6SnRapHYv4KdMlHPcRCcOdK8KcwE7y2cj99ZxZ
         YddM4dH5Al7X4g2N/cRLIA0j1OnPZJudycPPDd6uwharFXo0E239scCtcCe+Qc3b5HuA
         K3oQ==
X-Gm-Message-State: AO0yUKX5I5HQb6ETX57jY2/A+pXxMToecormS2uzd4Xwbxg0QfJ/v2St
        SnoUx2JVlp76QcVe85Wo7BbYdlH3QronjXdksjcPpA==
X-Google-Smtp-Source: AK7set+LBfQK7pU11FnKg1wid2t8Zu/K6bDjzW7zfw+pgjz4Dx1NNfjKLH47iTIIWlShb2/cKW7LsKpwUgTfHCqovYg=
X-Received: by 2002:a05:6512:15c:b0:4d5:ca42:aee7 with SMTP id
 m28-20020a056512015c00b004d5ca42aee7mr7294032lfo.7.1677489685796; Mon, 27 Feb
 2023 01:21:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677063656.git.viresh.kumar@linaro.org> <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7> <Y/hyf+/EqEeTu436@niej-dt-7B47> <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
In-Reply-To: <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Mon, 27 Feb 2023 17:21:56 +0800
Message-ID: <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
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

Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=80 12:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On 24-02-23, 16:17, Jun Nie wrote:
> > For the opp lib, this is right direction. We still need to find a metho=
d to
> > pass devfreq device node to opp lib, just genpd_virt_devs for power dom=
ain.
>
> I am not really sure I understood it all. What is "device node" ? DT node=
 or
> struct device ? What exactly do you need ?

Sorry for not expressing it accurately. I should say devfreq devices
pointers, just
devfreq_virt_devs vs genpd_virt_devs. Then you know why I add devfreq-devs
dts nodes below.

>
> > But I am not clear below is the right way yet and this also involves wi=
der
> > changes. Or the opp's owner, devfreq device can be referred via opp lib=
?
> > If so, we do not need to add devfreq-devs to cpu node at all.
> >
> >               cpu1: cpu@101 {
> >                       compatible =3D "arm,cortex-a53";
> >                       device_type =3D "cpu";
> >                       power-domains =3D <&cpr>;
> >                       power-domain-names =3D "cpr";
> >                       devfreq-devs =3D <&cci>;
> >                       devfreq-names =3D "cci";
>
> Why do you need these ?
>
> >                       operating-points-v2 =3D <&cluster1_opp_table>;
> >               };
> >
> >               opp-200000000 {
> >                       opp-hz =3D /bits/ 64 <200000000>;
> >                       required-opps =3D <&cpr_opp3>, <&cci_opp1>;
>
> This looks fine though.
>
> >               };
>
> --
> viresh
