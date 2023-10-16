Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC567C9E24
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPEWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPEWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 00:22:10 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F85DC
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 21:22:08 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7be88e9ccso51405697b3.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697430128; x=1698034928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXhdl4AwuQ5b9hQDSuOSRNecvIq4BMJtEIoefKWTOwk=;
        b=RG5GKHE4OyRue1e6h1RImnuIxlBzCRfoa4cno1BzHrBOCTZP2j28T3EfuzCd4zHrQM
         H/p03MxaeZZnEOSRIG/46EAYfaqXN9rX1YnzlyzajDfPPHNs2AFVVD7RygYATpSerlbm
         Xg+FhDQI5jrR5qubBp+1LuBikMqrx+CYvafhDPitoZ0jo4sIan/g8TVe6unDSNzX9VId
         Zxl+MqvDHfOmcDUcdjBLS9z5mI0zpOoxNfQtej1Uc/AlXVt6TKFawvgBT6qT+Earl4Xo
         afwQSb1R3YS+wJbjIJT3WrWYCDL68hpq1pzRshAOgEfzAW3VeSVl0OkQG/bnJOPv4JtR
         BmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697430128; x=1698034928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXhdl4AwuQ5b9hQDSuOSRNecvIq4BMJtEIoefKWTOwk=;
        b=UfIFI2U5EcnDrhmCh3UpqXj9wZgPczrMaB0fnLKwWCC2CIiVQl9GQ1w1wlz92zRDQv
         3JD9+GrjII04bxOvgLQPjIoGBMY2SH+5lrld9UZeouCbr4oZ07Ehh7gF3m3XxJAqojYo
         oEt6YezgRF6lknyCITxv5rOD2x8dGbbvstEM/duyWIVGgJBkL559VvojlSEdGRxtl5r6
         lCjctZ/EC+ri+B3zTonHpGy04X22hbkmkvoGd9EZevyTb8MY79fXn+JJZCXeVkNTaAS3
         YSnFriRvtPt9owsOl/A5XAzZJz+rlAoD7t0Ywe2W+BpjL0sLjWQyIyyhv23ZgB3xrGXy
         ksBw==
X-Gm-Message-State: AOJu0YyObeoH5uSIN5zO8nV1k7oRRRh2xRKRicIM5WAnIFNgR6PPrRae
        3e4IWNk3FZ3xDRnpCSzcHswB5bv055ra0ZGNy4WYtw==
X-Google-Smtp-Source: AGHT+IEWICUr8ouffrqathl0hNxRRfFYEJr8OtwREFGFT/mzl2TbvlM8qa/kD/+RuyTMrnZ45hQekK4YtAYQ2uCgO5Q=
X-Received: by 2002:a0d:cbd7:0:b0:5a7:d9e6:8fc6 with SMTP id
 n206-20020a0dcbd7000000b005a7d9e68fc6mr15564582ywd.39.1697430127742; Sun, 15
 Oct 2023 21:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
 <CAL_Jsq+HdceLczej4_q-wjg2870v3y-e_E+jEq0xbetDguaXAw@mail.gmail.com>
 <CAA8EJppCO-q=swYOH+O2fOdUDbNzd1yz9ZoTEBswV7RmvFJifA@mail.gmail.com> <20231016032353.xv3fm7dyuz52txy5@vireshk-i7>
In-Reply-To: <20231016032353.xv3fm7dyuz52txy5@vireshk-i7>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Oct 2023 07:21:56 +0300
Message-ID: <CAA8EJpqfxBMS9x9=kRFdZEduWVt6y4z0QMs0vFL9qvqKUoMjbQ@mail.gmail.com>
Subject: Re: [PATCH] of: export of_find_next_cache_node() for modules
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Oct 2023 at 06:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-10-23, 15:59, Dmitry Baryshkov wrote:
> > On Wed, 11 Oct 2023 at 15:52, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 6:27=E2=80=AFAM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > The qcom-cpufreq-nvmem module uses of_find_next_cache_node() functi=
on,
> > > > so export it to be available to the modules.
> > >
> > > You really should be using the cacheinfo API which has already parsed
> > > the cache nodes.
> > >
> > > Also, why do you need a platform_device? I don't see a driver.
> > > cacheinfo already creates a struct device, so kind of weird to have 2
> > > devices.
> >
> > The driver is pending as a part of the series at [1]. We need to scale
> > the L2 supplies and clock frequency following the core frequency
> > changes.
>
> Guys, can we please resolve this soon ? I had to revert the patches
> for the time being to avoid these failures.

Rob pointed out that I should rework my code to use the cacheinfo
device for the L2 cache. This means that L2 device population should
be dropped from cpufreq. I'll post newer series as soon as I finish
the implementation.

--=20
With best wishes
Dmitry
