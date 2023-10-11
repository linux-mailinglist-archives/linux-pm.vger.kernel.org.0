Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE07C5B7F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjJKSoo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJKSoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 14:44:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772B90;
        Wed, 11 Oct 2023 11:44:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B94C433C7;
        Wed, 11 Oct 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697049882;
        bh=ylZaV++7ZjN3KRW2Z9BOD+W2D0KBhJmDzQo5TNXOUz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JW9UJMdnJP6H8H/q8Dj1f5eVyX+Y+4ZQfxQbAe0rcC8eVXFG84HbGc9UF6eOB0JO6
         DxwHkAqyYPf1GCL2P3UCIwfwUVxBOt1Zvpawrjc2Bn1EZB79gNUunOYNO3tQX/9eCE
         4Nae+4bymCM1AVhRPs1zFZ8qKs7JvoT7pwmb2Sm/TP1HTCo4DrUALjfLL9/VS3a3gy
         XQS3qg76/K5QV93d8anhBnA7fQCbsJSlbKkyAhN2yZmoVo+MCH8LmkYEJ1wOmyYoMn
         mbKPUPWKEAPs6e08lgsJXvrP1VpM65JzaYajRbzvHKrEJrhAjKHhs5rqQpzrCWLKi9
         N6Y0RraE2U9tg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c16757987fso1592841fa.3;
        Wed, 11 Oct 2023 11:44:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YypKuPdXxLyCxRL4HGUlbWj+7ZplFRNKn1kCHTPEERQy+7XwkNU
        YjEhlZ+ldOQrttdlcnLrBbgPtHviFFH3leYPtg==
X-Google-Smtp-Source: AGHT+IHfqb7aFDsjOrYahLvU3eH/O1zPin1Cajj+w1qOGsVcidBGVG/Uikeb8o7GgWW95EG5nLlMEsWEH3Q6ghDENck=
X-Received: by 2002:a05:6512:e99:b0:500:86b4:5282 with SMTP id
 bi25-20020a0565120e9900b0050086b45282mr21166230lfb.34.1697049880370; Wed, 11
 Oct 2023 11:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-9-dmitry.baryshkov@linaro.org> <20231011154935.GA785564-robh@kernel.org>
 <CAA8EJpqf4Q7wh657==C45Ka8YmmyopkCQnyEFcXkaoRwnCRZLQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqf4Q7wh657==C45Ka8YmmyopkCQnyEFcXkaoRwnCRZLQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Oct 2023 13:44:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKwWyoPdt3C0FdsgN087xK0jGyp3PVgiCaETZK9FX2JdQ@mail.gmail.com>
Message-ID: <CAL_JsqKwWyoPdt3C0FdsgN087xK0jGyp3PVgiCaETZK9FX2JdQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/23] soc: qcom: Add driver for Qualcomm Krait L2
 cache scaling
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
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

On Wed, Oct 11, 2023 at 1:20=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 11 Oct 2023 at 18:49, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Aug 27, 2023 at 02:50:18PM +0300, Dmitry Baryshkov wrote:
> > > Add a simple driver that handles scaling of L2 frequency and voltages=
.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> >
> > [...]
> >
> > > +static const struct of_device_id krait_l2_match_table[] =3D {
> > > +     { .compatible =3D "qcom,krait-l2-cache" },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, krait_l2_match_table);
> > > +
> > > +static struct platform_driver krait_l2_driver =3D {
> > > +     .probe =3D krait_l2_probe,
> > > +     .remove =3D krait_l2_remove,
> > > +     .driver =3D {
> > > +             .name =3D "qcom-krait-l2",
> > > +             .of_match_table =3D krait_l2_match_table,
> > > +             .sync_state =3D icc_sync_state,
> > > +     },
> > > +};
> >
> > As I mentioned in the other thread, cache devices already have a struct
> > device. Specifically, they have a struct device (no subclass) on the
> > cpu_subsys bus type. So there should be no need for a platform device
> > and second struct device.
> >
> > See drivers/acpi/processor_driver.c for an example. Or grep any use of
> > "cpu_subsys".
>
> Most likely you mean drivers/base/cacheinfo.c. I saw this code, I
> don't think it makes a good fit here. The cacheinfo devices provide
> information only, they are not tied to DT nodes in any way.

They are completely tied to DT nodes beyond L1.

>  cpu_subsys
> doesn't provide a way to match drivers with subsys devices in the
> non-ACPI case, etc.

That's a 2 line addition to add DT support.

> Moreover, the whole cacheinfo subsys is
> non-existing on arm32, there is no cacheinfo implementation there,
> thanks to the overall variety of architectures.

Humm, well I don't think it would be too hard to add, but I won't ask
you to do that. All the info comes from DT or can come from DT, so it
should be just a matter of arm32 calling the cacheinfo init.

> Thus said, I don't think cacheinfo makes a good fit for the case of
> scaling L2 cache.

I still disagree. It's not really cacheinfo. That is what creates the
devices, but it's the cpu_subsys bus type. Why do you care that it is
platform bus vs. cpu_subsys?

On a separate issue, I'd propose you move this to drivers/cache/
instead of the dumping ground that is drivers/soc/. It's nothing more
than a location to collect cache related drivers ATM because we seem
to be accumulating more of them.

Rob
