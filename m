Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA427430319
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhJPOxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 10:53:09 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:40959 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbhJPOxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 10:53:09 -0400
Date:   Sat, 16 Oct 2021 14:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634395859;
        bh=R3/CWC+oQyHLNJ8Mqz/kp0RXJtD7NTUkw0e4eKR5loA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=S/3JdJgGa1H1gmxU2faAPy6ZJdotBfNnj5Nh1hghcVZ78AWMsv7JuiW3e9tnnXc/s
         ZfNTQfXpOzzDdQXbLsVcgYOjIX6yan9IOdxu1L/ox9aGNAnjqnPrTWg03UusmkLj04
         k4N8pqcUAqD9fAiCN2+ub5BskSt4mmdUN8xIydrc=
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
Message-ID: <ZVR21R.X63CT137R99A3@protonmail.com>
In-Reply-To: <a8114098-f700-974b-e17e-54f5baebec46@somainline.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-8-y.oudjana@protonmail.com> <a8114098-f700-974b-e17e-54f5baebec46@somainline.org>
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


On Fri, Oct 15 2021 at 23:01:54 +0400, Konrad Dybcio=20
<konrad.dybcio@somainline.org> wrote:
>=20
> On 14.10.2021 10:32, Yassine Oudjana wrote:
>>  Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU=20
>> OPPs.
>>  CBF OPPs and CPR parameters will be added to it as well once=20
>> support for
>>  CBF scaling and CPR is introduced.
>>=20
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi    |  82 +++----
>>   arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281=20
>> +++++++++++++++++++++++
>>   2 files changed, 322 insertions(+), 41 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi
>>=20
>>  diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi=20
>> b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>  index 94a846c3f1ee..5b2600a4fb2a 100644
>>  --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>  +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>  @@ -142,82 +142,82 @@ cluster0_opp: opp_table0 {
>>   =09=09/* Nominal fmax for now */
>>   =09=09opp-307200000 {
>>   =09=09=09opp-hz =3D /bits/ 64 <307200000>;
>>  -=09=09=09opp-supported-hw =3D <0x77>;
>>  +=09=09=09opp-supported-hw =3D <0x7>;
>=20
> You didn't describe what's the reason for changing this everywhere.
>=20
> If it's been always broken, perhaps make it a separate commit=20
> describing
>=20
> the issue.
>=20
>=20
> Konrad
>=20

Before removing reading msm-id in qcom_cpufreq_nvmem, bits 0-2 (0x07)=20
were MSM8996 speed bins, while bits 4-6 (0x70) were MSM8996 Pro speed=20
bins. Now, only bits 0-2 are used for either one, so basically I moved=20
bits 4-6 into msm8996pro.dtsi after shifting them right to become bits=20
0-2.

I'll put this in a separate patch and describe the change.

=09Yassine



