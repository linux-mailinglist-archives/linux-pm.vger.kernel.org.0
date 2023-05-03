Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F916F5891
	for <lists+linux-pm@lfdr.de>; Wed,  3 May 2023 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjECNIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 May 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECNIo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2023 09:08:44 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E244EDB;
        Wed,  3 May 2023 06:08:43 -0700 (PDT)
Date:   Wed, 03 May 2023 13:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1683119318; x=1683378518;
        bh=FE0AjAsHQ8V9qZOKZ90iRzNLwECyVj8k679NWIOxg5I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OFbBLE/u0ZxoAWymbH2Y0YQX1zoXWj4iqVzV4rzwVXeIw8MMsjesaDBozx9n6whF+
         RA5Q83IyBJNmxx7aAARj+WvJ1e4A0m01RFiXJLSB03k9Gj3rw4Er9W2cvj747zJEcI
         26C3qL9dMfUssdYaOeRJOkEoQR95zBQH2fw8E7ZT9j4HsIV7eVY3ALnBUXaJe8S1hk
         Vp5hNG799rTUNe51pgL86pMjoZ5fQZUA71OGElDrF3xAT+S/zjOst2JN3Nt6u/A0Dc
         EK61T0Z1v4d0s9u1mA6cQdOnb6K4IZlbR8LqsVyfLZUUu4Czyde3vihpl2fLz98y4D
         ciMsdVpMo8D6g==
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/4] clk: qcom: msm8996: add support for the CBF clock
Message-ID: <pAOeaOsWozBaJSKchKaW2ibS6QGT7rzlZR6TF0j9TKCqVACNLxPtGJdF2tsgqSrQF4G_IqQ9iMCdxSJsRRsOy4uCwKjRK4Gs_Z522NHVDMU=@protonmail.com>
In-Reply-To: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
References: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 10th, 2023 at 11:00 PM, Dmitry Baryshkov <dmitry.baryshkov=
@linaro.org> wrote:

> On MSM8996 two CPU clusters are interconnected using the Core Bus
> Fabric (CBF). In order for the CPU clusters to function properly, it
> should be clocked following the core's frequencies to provide adequate
> bandwidth.
>=20
> Register CBF as a clock (required for CPU to boot) and add a tiny
> interconnect layer on top of it to let cpufreq/opp scale the CBF clock.
>=20
> Changes since v4:
> - Fixed typos in commit messages
>=20
> Changes since v3:
> - Dropped merged patches
> - Moved interconnect shim to drivers/interconnect/icc-clk.c
>=20
> Changes since v2:
> - Added interconnect-related bindings
> - Switched CPU and CBF clocks to RPM_SMD_XO_A_CLK_SRC
>=20
> Changes since v1:
> - Relicensed schema to GPL-2.0 + BSD-2-Clause (Krzysztof)
> - Changed clock driver to use parent_hws (Konrad)
> - Fixed indentation in CBF clock driver (Konrad)
> - Changed MODULE_LICENSE of CBF clock driver to GPL from GPL-v2
> - Switched CBF to use RPM_SMD_XO_CLK_SRC as one of the parents
> - Enabled RPM_SMD_XO_CLK_SRC on msm8996 platform and switch to it from
> RPM_SMD_BB_CLK1 clock
>=20
>=20
> Dmitry Baryshkov (4):
> dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
> interconnect: add clk-based icc provider support
> clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
> arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
>=20
> arch/arm64/boot/dts/qcom/msm8996.dtsi | 51 ++++++
> drivers/clk/qcom/Kconfig | 1 +
> drivers/clk/qcom/clk-cbf-8996.c | 59 +++++-
> drivers/interconnect/Kconfig | 6 +
> drivers/interconnect/Makefile | 2 +
> drivers/interconnect/icc-clk.c | 168 ++++++++++++++++++
> .../interconnect/qcom,msm8996-cbf.h | 12 ++
> include/linux/interconnect-clk.h | 22 +++
> 8 files changed, 320 insertions(+), 1 deletion(-)
> create mode 100644 drivers/interconnect/icc-clk.c
> create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
> create mode 100644 include/linux/interconnect-clk.h
>=20
> --
> 2.30.2

After adding support for MSM8996 Pro [1],

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

[1] https://lore.kernel.org/linux-arm-msm/20230503130051.144708-1-y.oudjana=
@protonmail.com/

