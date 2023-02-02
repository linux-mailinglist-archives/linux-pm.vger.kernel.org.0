Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C3687DF8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBBMz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBBMzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 07:55:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCE457ED
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 04:55:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id br9so2836914lfb.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 04:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0OggBaEVM084sMCW8HBWOrUa7UEjlo8LtE+1sylal4=;
        b=wMflCs4LRrR6rx0v5FUohA45XpEpxNpUO82rPsPLRH/jXDhlIwsosRKYSnnLSjfisK
         fI/DEgEyzseoBqcbf32s22RhlWE8jJAnWYL7dAXc7BvCrm3PouFpS1sS9TQsHE23wpBI
         BFrG3dVV0Iyo2S1xUHRj6rrjfIVSNHfiQhvYHJURC102lItPydI+18WNfObcViw6zGIr
         dCcl0osS0YaevOaR/UsGDBbfP5ZWN1ClX3oS7raXmTATGdHvomOR9P+LktGumcknhvvd
         H33l5FmbJWokijfLdjLWu/B2hXZ3fneak/KwX0OmqgM0OC736TEucbKOESx6S326gHXe
         6KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0OggBaEVM084sMCW8HBWOrUa7UEjlo8LtE+1sylal4=;
        b=uPdBbSK91gj+E6fKfR3LwZNbYzmVkp6JnxvF224E52YHdpzZNxfIvnTs9UodrW4Kd7
         ZJpnS9TwiBsRiCe4kCzYZpZelu4B1f3smAw/kCG2UotytvfQj7ZZxA0nCz9n1EmPC0qs
         dLcHxLjJvXF6eCjeMyjvO6tMY5/JgAchv+Ir14Pdpe0QKWRgjt9V7U2qI67SeCdSEaxk
         nAIUAZq8HByq6s/BKoUrvX/bDZkG3vK75MQv17y5tEsLDlku4sB6zaZz4QjgyHnqNHUd
         +bWFbkgqDEpcWhpIymkj3M1Jvb4qBIbCiXcKYSF8zQvsOIUM7BkEGHQWZtF5uBC8aWXi
         eHZw==
X-Gm-Message-State: AO0yUKXcOtbWSkEtV+mWmsOK/CiyXjDxMXvD5ketvG9zvwlFyq5xPou3
        MtcVw9iBtIbLAWKrNWiepUYXi8X7rv7LIFKosxK9PXDvgJx/RA==
X-Google-Smtp-Source: AK7set/mWmeaWd2wkMNBFXbA51O652xW98OUEb1CzsuGrHbl8sBzDY3nLrJoIabdvmMj4YTWwXKt7B5+qymwtAEVesA=
X-Received: by 2002:a05:6512:3d28:b0:4d8:8ad1:a05c with SMTP id
 d40-20020a0565123d2800b004d88ad1a05cmr836274lfv.140.1675342508144; Thu, 02
 Feb 2023 04:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org> <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
 <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
In-Reply-To: <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Thu, 2 Feb 2023 20:55:04 +0800
Message-ID: <CABymUCMJdRXG3AcLeS18JFuYmCv1kw=rJNkCv8sL7AjPD4ZR+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2023=E5=B9=B42=E6=
=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 21:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 1 Feb 2023 at 13:46, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
> >
> > On 01/02/2023 11:32, Dmitry Baryshkov wrote:
> > > On 01/02/2023 10:02, Jun Nie wrote:
> > >> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. Thi=
s
> > >> driver is introduced so that its freqency can be adjusted. And regul=
ator
> > >> associated with opp table can be also adjusted accordingly which is
> > >> shared with cpu cluster.
> > >>
> > >> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > >> ---
> > >>   drivers/devfreq/Kconfig    |   9 +++
> > >>   drivers/devfreq/Makefile   |   1 +
> > >>   drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++=
++++
> > >>   3 files changed, 172 insertions(+)
> > >>   create mode 100644 drivers/devfreq/qcom-cci.c
> > >
> > > Could you please describe in some additional details what are you try=
ing
> > > to achieve? Should the CCI frequency be scaled manually or does it
> > > follow the cluster frequency? Do clusters vote on the CCI frequency?
> > >
> > > I'm inclined to ask if it is possible to shift this to the cpufreq OP=
P
> > > tables?
> > >
> >
> > Might not be so easy to just append CCI opps to the cluster frequency o=
pps
> >
> >                  cci_cache: qcom,cci {
> >                          compatible =3D "qcom,msm8939-cci";
> >                          clock-names =3D "devfreq_clk";
> >                          clocks =3D <&apcs2>;
> >                          governor =3D "cpufreq";
> >                          operating-points-v2 =3D <&cci_opp_table>;
> >                          power-domains =3D <&cpr>;
> >                          power-domain-names =3D "cpr";
> >                          nvmem-cells =3D <&cpr_efuse_speedbin_pvs>;
> >                          nvmem-cell-names =3D "cpr_efuse_speedbin_pvs";
> >                  };
> >
> >                  devfreq-cpufreq {
> >                          cci-cpufreq {
> >                                  target-dev =3D <&cci_cache>;
> >                                  cpu-to-dev-map-0 =3D
> >                                          <  200000  200000000 >,
> >                                          <  345600  200000000 >,
> >                                          <  400000  200000000 >,
> >                                          <  533330  297600000 >,
> >                                          <  800000  297600000 >,
> >                                          <  960000  297600000 >,
> >                                          < 1113600  297000000 >,
> >                                          < 1344000  595200000 >,
> >                                          < 1459200  595200000 >,
> >                                          < 1497600  595200000 >,
> >                                          < 1651200  595200000 >;
> >                                  cpu-to-dev-map-4 =3D
> >                                          <  200000 200000000 >,
> >                                          <  249600 200000000 >,
> >                                          <  499200 297600000 >,
> >                                          <  800000 297600000 >,
> >                                          <  998400 595200000 >,
> >                                          < 1113600 595200000 >;
>
> These should map to existing opp entries.
>
> I ended up doing the interconnect driver that maps a clock to the
> interconnect. Then I can use it in the cpu opp tables.
>
> >                          };
> >                  };
> >
> >          cci_opp_table: cci-opp-table {
> >                  compatible =3D "operating-points-v2";
> >
> >                  opp-200000000 {
> >                          opp-hz =3D /bits/ 64 <200000000>;
> >                          opp-supported-hw =3D <0x3f>;
> >                          required-opps =3D <&cpr_opp3>;
>
> And these should probably map to max(cpu's CPR opp, CCI's CPR opp).

The plan is opp framework to handle it when CPU opp requires both cpr
power domain
opp and CCI opp. While CCI opp will also requires specific cpr opp. Because=
 CPU
have a opp match table per pvs/speed, while CCI has another match
table, it seems
 impossible to write the cpr opp requirements in the code statically.

>
> >                  };
> >
> >                  opp-297600000 {
> >                          opp-hz =3D /bits/ 64 <297600000>;
> >                          opp-supported-hw =3D <0x3f>;
> >                          required-opps =3D <&cpr_opp12>;
> >                  };
> >
> >                  opp-400000000-cpr14 {
> >                          opp-hz =3D /bits/ 64 <400000000>;
> >                          opp-supported-hw =3D <0x1>;
> >                          required-opps =3D <&cpr_opp14>;
> >                  };
> >
> >                  opp-400000000-cpr15 {
> >                          opp-hz =3D /bits/ 64 <400000000>;
> >                          opp-supported-hw =3D <0x3e>;
> >                          required-opps =3D <&cpr_opp15>;
> >                  };
> >
> >                  opp-595200000 {
> >                          opp-hz =3D /bits/ 64 <595200000>;
> >                          opp-supported-hw =3D <0x3f>;
> >                          required-opps =3D <&cpr_opp17>;
> >                  };
> >          };
> >
> >
> >          cpr_opp_table: cpr-opp-table {
> >                  compatible =3D "operating-points-v2-qcom-level";
> >
> >                  cpr_opp1: opp1 {
> >                          opp-hz =3D /bits/ 64 <200000000>;
> >                          opp-level =3D <1>;
> >                          qcom,opp-fuse-level =3D <1>;
> >                  };
> >                  cpr_opp2: opp2 {
> >                          opp-hz =3D /bits/ 64 <345600000>;
> >                          opp-level =3D <2>;
> >                          qcom,opp-fuse-level =3D <1>;
> >                  };
> >                  cpr_opp3: opp3 {
> >                          opp-hz =3D /bits/ 64 <400000000>;
> >                          opp-level =3D <3>;
> >                          qcom,opp-fuse-level =3D <1>;
> >                  };
> >                  cpr_opp4: opp4 {
> >                          opp-hz =3D /bits/ 64 <422400000>;
> >                          opp-level =3D <4>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp5: opp5 {
> >                          opp-hz =3D /bits/ 64 <499200000>;
> >                          opp-level =3D <5>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp6: opp6 {
> >                          opp-hz =3D /bits/ 64 <533330000>;
> >                          opp-level =3D <6>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp7: opp7 {
> >                          opp-hz =3D /bits/ 64 <652800000>;
> >                          opp-level =3D <7>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp8: opp8 {
> >                          opp-hz =3D /bits/ 64 <729600000>;
> >                          opp-level =3D <8>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp9: opp9 {
> >                          opp-hz =3D /bits/ 64 <800000000>;
> >                          opp-level =3D <9>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp10: opp10 {
> >                          opp-hz =3D /bits/ 64 <806400000>;
> >                          opp-level =3D <10>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp11: opp11 {
> >                          opp-hz =3D /bits/ 64 <883200000>;
> >                          opp-level =3D <11>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >                  cpr_opp12: opp12 {
> >                          opp-hz =3D /bits/ 64 <960000000>;
> >                          opp-level =3D <12>;
> >                          qcom,opp-fuse-level =3D <2>;
> >                  };
> >          };
> >
> > ---
> > bod
>
>
>
> --
> With best wishes
> Dmitry
