Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42043033C
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbhJPPTS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 11:19:18 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:64441 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbhJPPTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 11:19:17 -0400
Date:   Sat, 16 Oct 2021 15:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634397426;
        bh=eacSGFH4NZEHeF23GG6tUuURaKwWMyZu8ig2RqMX4cw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=x7jTuEniTzvC0i8hRmaU1va1/dblZ9Xnn4Lwg8IgJKtzLVXE3DxM/rMOVe/EtXwTi
         NW8GRTYojMpzKssQKAU92J8du9ba5InyONR1IlT0pZ0Dtokl0q8QNznI0jBKcxCVFq
         4CG+tfL1U1Gd8P5DtdltSMj6Wtfa2eob+DB9Xocw=
To:     Rob Herring <robh@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Nishanth Menon <nm@ti.com>, phone-devel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Message-ID: <G3T21R.IC4JJ9W0GTB72@protonmail.com>
In-Reply-To: <1634221864.186240.3295880.nullmailer@robh.at.kernel.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-2-y.oudjana@protonmail.com> <1634221864.186240.3295880.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, Oct 14 2021 at 18:31:04 +0400, Rob Herring <robh@kernel.org>=20
wrote:
> On Thu, 14 Oct 2021 08:31:32 +0000, Yassine Oudjana wrote:
>>  Add CBF clock and reg.
>>=20
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10=20
>> ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>=20
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for=20
> dtbs_check.
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/1540828
>=20
>=20
> clock-controller@6400000: clock-names:0: 'pwrcl_pll' was expected
> =09arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
> =09arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
>=20
> clock-controller@6400000: clock-names: ['xo'] is too short
> =09arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
> =09arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
>=20
> clock-controller@6400000: clocks: [[29]] is too short
> =09arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
>=20
> clock-controller@6400000: clocks: [[33]] is too short
> =09arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
>=20
> clock-controller@6400000: clocks: [[36]] is too short
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
>=20
> clock-controller@6400000: clocks: [[41]] is too short
> =09arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
>=20
> clock-controller@6400000: reg: [[104857600, 589824]] is too short
> =09arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
> =09arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.ya=
ml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
> =09arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
>=20

These are old warnings. I wasn't quite sure about those clocks, so I=20
didn't attempt to fix them.

=09Yassine




