Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676BB430347
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhJPPZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 11:25:13 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:39443 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhJPPZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 11:25:08 -0400
Date:   Sat, 16 Oct 2021 15:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634397776;
        bh=w0xqkPcv9nCVQOq8BMYP8ncaNLdCAAS0wKe2iu3Cfbs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=p/l0X2ockchTJ4qagQDhsRfJiEBOYmUAgW/GmT4RkW1zvRNuNi/GPAo4cneJzH9gV
         5xbIu4LabTzm829Rq3f8azPQQ4jvQ/SIXzcnv56r9JjCavWzJze8HsvzRYE5bc5ZVY
         8WIBj7+nGoYurch+biJw0Y+VH8+b6cAnmNyw48QA=
To:     Rob Herring <robh@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
Message-ID: <7BT21R.3Z6EF61Y47A32@protonmail.com>
In-Reply-To: <1634221864.197594.3295882.nullmailer@robh.at.kernel.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-3-y.oudjana@protonmail.com> <1634221864.197594.3295882.nullmailer@robh.at.kernel.org>
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
> On Thu, 14 Oct 2021 08:32:04 +0000, Yassine Oudjana wrote:
>>  Add a compatible string for msm8996pro-apcc.
>>=20
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1=20
>> +
>>   1 file changed, 1 insertion(+)
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
> Full log is available here: https://patchwork.ozlabs.org/patch/1540829
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

Similar to PATCH 1/8[1], these are old warnings.

=09Yassine

[1]=20
https://lore.kernel.org/linux-arm-msm/G3T21R.IC4JJ9W0GTB72@protonmail.com/T=
/#u



