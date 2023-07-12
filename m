Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E822750841
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjGLM2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 08:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGLM2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 08:28:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75873A7
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 05:28:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5440e98616cso477831a12.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164889; x=1691756889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ss8TgyARGa8R7ybKRI+zpQEGya6RyvZhqG69g7/1a8o=;
        b=NnzMcvhNkva7W/6wMnD1NIt4d16zGTpmIwpmOCHrZ1AKi+58Iov+hYhrevzoxaG23M
         DKVaJDXt1r0D5uqk5/Cn9l4UIAphvkLp5P5t+hLcKPmaJavcvaKfRmB1cfKI+4JoJpkY
         iQ/JdPMOrCT1S1zJFwGY68TnLS6RhPY654cXCS29XMK2r3V4HxoYfNWMSq1/FjL23XTX
         VmXu28hNGsataMoEAO5RK3usYZUkxBY+X226SsecxgM7Sb1W4ZB1IhxLySlk4OIbYypT
         6V9xvckoZY9DPC8H2eqLrKtts5I2cztY0ZnjZE/6ua/BlQ23IG8wEuqgxihLs5TUR4cu
         1Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164889; x=1691756889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss8TgyARGa8R7ybKRI+zpQEGya6RyvZhqG69g7/1a8o=;
        b=A7q3ZrEqwfgYHuoQYrwSLn+LKaFLmsi8f7chwv97jdq22nrI+FdukjTx8T20uubUqa
         Qrs1AJbCQpPVLx2KuABdewPuP0R9eK4o0nzTh100+uV66aYYzn7IBsTYFupPvNu5hf0x
         sppcWweXhos/FpeJk9zsHy7t+XzGeBG9lGtlxleyvXgy96bLtNI9lTtCMLXqcgkEtmxM
         DHIeuENbFeIsp+ScTGDiRfQDWKH9yxHnC63V09sgNVzRP4Tjeqny2E+N4GV7lUxOJsaF
         ikv08EV6y6eCqfJ8sPA1pAR6imlxoedmaNZa7P+wUKQly8/20CJbhGLS+j7V/xC9Rm+H
         MpqQ==
X-Gm-Message-State: ABy/qLa7TSNG/jHbP6AjFBmuyua47KnXGGciCD1eoyWtmGFwCOyzDwiI
        2Iuyk46BiHgmItyUOF3xq+6q
X-Google-Smtp-Source: APBJJlG8ThheU5sQFDWNEBk5rKV899ROC1JFcrlLVU6uGeLmUaZENZV8342hP8okBYkTpASRWYL/FQ==
X-Received: by 2002:a17:90b:1d07:b0:25b:f105:8372 with SMTP id on7-20020a17090b1d0700b0025bf1058372mr2517491pjb.5.1689164888909;
        Wed, 12 Jul 2023 05:28:08 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a4f8400b00264c262a033sm10665538pjh.12.2023.07.12.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:28:08 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:57:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 00/14] UFS: Add OPP and interconnect support
Message-ID: <20230712122750.GE102757@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712104044.GA102214@thinkpad>
 <3523988f-fa51-ce44-ded7-9f3c7acbf65e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3523988f-fa51-ce44-ded7-9f3c7acbf65e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 12, 2023 at 03:18:38PM +0300, Dmitry Baryshkov wrote:
> On 12/07/2023 13:40, Manivannan Sadhasivam wrote:
> > On Wed, Jul 12, 2023 at 04:01:55PM +0530, Manivannan Sadhasivam wrote:
> > > Hi,
> > > 
> > > This series adds OPP (Operating Points) support to UFSHCD driver and
> > > interconnect support to Qcom UFS driver.
> > > 
> > 
> > Missed to cc SCSI folks. Will be resending this series. Sorry for the noise.
> 
> I'd say, there is a need for the resend anyway, the series got duplicate
> patch indices.
> 

Yeah, my script screwed up. Will wait for some time to get comments before
resending though.

- Mani

> > 
> > - Mani
> > 
> > > Motivation behind adding OPP support is to scale both clocks as well as
> > > regulators/performance state dynamically. Currently, UFSHCD just scales
> > > clock frequency during runtime with the help of "freq-table-hz" property
> > > defined in devicetree. With the addition of OPP tables in devicetree (as
> > > done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> > > both clocks and performance state of power domain which helps in power
> > > saving.
> > > 
> > > For the addition of OPP support to UFSHCD, there are changes required to
> > > the OPP framework and devfreq drivers which are also added in this series.
> > > 
> > > Finally, interconnect support is added to Qcom UFS driver for scaling the
> > > interconnect path dynamically. This is required to avoid boot crash in
> > > recent SoCs and also to save power during runtime. More information is
> > > available in patch 13/13.
> > > 
> > > Credits
> > > =======
> > > 
> > > This series is a continuation of previous work by Krzysztof Kozlowski [1]
> > > and Brian Masney [2]. Ideally, this could've split into two series (OPP
> > > and interconnect) but since there will be a dependency in the devicetree,
> > > I decided to keep them in a single series.
> > > 
> > > Testing
> > > =======
> > > 
> > > This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
> > > development boards.
> > > 
> > > Merging Strategy
> > > ================
> > > 
> > > An immutable branch might be required between OPP and SCSI trees because of
> > > the API dependency (devfreq too). And I leave it up to the maintainers to
> > > decide.
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > [1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/
> > > [2] https://lore.kernel.org/all/20221117104957.254648-1-bmasney@redhat.com/
> > > 
> > > Krzysztof Kozlowski (2):
> > >    dt-bindings: ufs: common: add OPP table
> > >    arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
> > > 
> > > Manivannan Sadhasivam (12):
> > >    dt-bindings: opp: Increase maxItems for opp-hz property
> > >    arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
> > >    arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
> > >    arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
> > >    OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
> > >    OPP: Introduce dev_pm_opp_get_freq_indexed() API
> > >    PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
> > >      APIs
> > >    scsi: ufs: core: Add OPP support for scaling clocks and regulators
> > >    scsi: ufs: host: Add support for parsing OPP
> > >    arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
> > >    arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
> > >    scsi: ufs: qcom: Add support for scaling interconnects
> > > 
> > >   .../devicetree/bindings/opp/opp-v2-base.yaml  |   2 +-
> > >   .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++++-
> > >   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  47 ++++--
> > >   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  43 ++++--
> > >   drivers/devfreq/devfreq.c                     |  14 +-
> > >   drivers/opp/core.c                            |  76 ++++++++++
> > >   drivers/ufs/core/ufshcd.c                     | 142 ++++++++++++++----
> > >   drivers/ufs/host/ufs-qcom.c                   | 131 +++++++++++++++-
> > >   drivers/ufs/host/ufs-qcom.h                   |   3 +
> > >   drivers/ufs/host/ufshcd-pltfrm.c              | 116 ++++++++++++++
> > >   include/linux/pm_opp.h                        |  26 ++++
> > >   include/ufs/ufshcd.h                          |   4 +
> > >   12 files changed, 574 insertions(+), 64 deletions(-)
> > > 
> > > -- 
> > > 2.25.1
> > > 
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
