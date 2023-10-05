Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2DF7BAA4A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJETkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJETkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 15:40:10 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4068ADE
        for <linux-pm@vger.kernel.org>; Thu,  5 Oct 2023 12:40:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59b5484fbe6so16341987b3.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2023 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696534806; x=1697139606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q79nbusY6yMg4gDn1/PKHAl0Q1+I2dNo50xbdZnueF8=;
        b=EMlT6CvJsklF2WEqt6wm9epStnvXaFht8+bWiqX78LUHr+KdXu2AhXMZAZD9KXH1ys
         Mml3ay1Ju9ht5NDB1Bh3LbnjqgE+7FB6/6tt85tO3TYuPCyUhBkliQYd+M2cwbkhF9Xq
         mnX4db0kpUVj39MolXfyM76XqF7fMWBciqy/tgOGjUCduoSAgwpmQMk0zBk4jVFTXkV4
         UnAZmbsvcNB5sBG8IOmcsn3qWW0m9O4Vluuiy5G6cY4SuZVw7J4CpTlpD5ao6bMG0wuU
         vHW3QP/eNWooS27pZ2KYMC50R9bNmkWpa+4fRr5gr7VTXCmMlwKPZhZq9ELSNf5uHOQF
         ypwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534806; x=1697139606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q79nbusY6yMg4gDn1/PKHAl0Q1+I2dNo50xbdZnueF8=;
        b=vWTiRBMBuj5yQlHkV6oNf611DLLOyTD7SVn7+PuN66CFkW+DvYl3g1uCilVFdufosk
         neWTKjMGcaPxp5xkq9huz9A9cwaf/Vu8Q3mXj4n6DmQJsOx5KXNBjiarRZIFKpBB3eAk
         tlLrmeivoBcOYX4/xaCMQiXqsvPEPYAUKWDM0sbgsuC9WrdFwgKdH5UfkECcSA5iMJT7
         1Ng2SFFlFfLAOWu//0u0nTNCjQ+aEuTSUU66WVBzeWh2wgsCLpiGBfLoPsHnpqMFnaFB
         Xal0p/sFzWYRg275u51TMyDPRCt4FmvNU3bKUtrtq8Yx/w7OBoVeOIRCIuGAN6q3pO9i
         Aqww==
X-Gm-Message-State: AOJu0Yx9spbBUANG6y0xTL6QBzYGo0LPn8w1lIYilM4eHZkK6pED6XdI
        6Yc3fwcFVvexFfLVjvIGyDBZJlKqY+pI2cfWfw6MAg==
X-Google-Smtp-Source: AGHT+IFQShC1tZUtbtXYspI53MZzv01Vvxe437wz4HHjxC/g/pKFfZTjUpOAcpf9EJqb/h4w/1xXBZOUxuhbwDFl0zU=
X-Received: by 2002:a81:fd03:0:b0:59b:ce0b:7829 with SMTP id
 g3-20020a81fd03000000b0059bce0b7829mr5687917ywn.35.1696534806426; Thu, 05 Oct
 2023 12:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <a6d12e3b253d6a55d85f66979ba8b7d9c9ff6072.1693996662.git.quic_varada@quicinc.com>
 <CAA8EJppNsgUNgwadq9oM0_KyORNR5PBZGVZukN6MzAm2KPzC9g@mail.gmail.com>
 <20231005095744.GA29795@varda-linux.qualcomm.com> <CAA8EJpr124fymnbZ1bO=Dbbxavn3Z=1xOPmFRPnfSp-UB3p6OQ@mail.gmail.com>
 <20231005144205.GB29795@varda-linux.qualcomm.com>
In-Reply-To: <20231005144205.GB29795@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 5 Oct 2023 22:39:55 +0300
Message-ID: <CAA8EJppJVzjyKjggkmi8uHGSPaHJ2ChsUV4Bfd0yNNDu3R+Kow@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] arm64: dts: qcom: ipq5332: populate the opp
 table based on the eFuse
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 Oct 2023 at 17:42, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Thu, Oct 05, 2023 at 02:39:43PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 5 Oct 2023 at 12:58, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Thu, Sep 07, 2023 at 04:59:28PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, 7 Sept 2023 at 08:23, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > IPQ53xx have different OPPs available for the CPU based on
> > > > > SoC variant. This can be determined through use of an eFuse
> > > > > register present in the silicon.
> > > > >
> > > > > Add support to read the eFuse and populate the OPPs based on it.
> > > > >
> > > > > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 34 +++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 31 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > index 82761ae..3ca3f34 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > @@ -91,11 +91,34 @@
> > > > >         };
> > > > >
> > > > >         cpu_opp_table: opp-table-cpu {
> > > > > -               compatible = "operating-points-v2";
> > > > > +               compatible = "operating-points-v2-kryo-cpu";
> > > > >                 opp-shared;
> > > > > +               nvmem-cells = <&cpu_speed_bin>;
> > > > > +               nvmem-cell-names = "speed_bin";
> > > > > +
> > > > > +               /*
> > > > > +                * Listed all supported CPU frequencies and opp-supported-hw
> > > > > +                * values to select CPU frequencies based on the limits fused.
> > > > > +                * ------------------------------------------------------------
> > > > > +                * Frequency     BIT3   BIT2   BIT1    BIT0    opp-supported-hw
> > > > > +                *              1.0GHz 1.2GHz 1.5GHz No Limit
> > > > > +                * ------------------------------------------------------------
> > > > > +                * 1100000000     1      1      1       1            0xF
> > > > > +                * 1500000000     0      0      1       1            0x3
> > > > > +                * -----------------------------------------------------------
> > > > > +                */
> > > >
> > > > This can probably go to the commit message instead.
> > >
> > > Ok
> > >
> > > > > +
> > > > > +               opp-1100000000 {
> > > > > +                       opp-hz = /bits/ 64 <1100000000>;
> > > >
> > > > But your table shows 1.0 GHz and 1.2 GHz instead of 1.1 GHz
> > >
> > > Will update it.
> > >
> > > > > +                       opp-microvolt = <850000>;
> > > > > +                       opp-supported-hw = <0xF>;
> > > > > +                       clock-latency-ns = <200000>;
> > > > > +               };
> > > > >
> > > > > -               opp-1488000000 {
> > > > > -                       opp-hz = /bits/ 64 <1488000000>;
> > > > > +               opp-1500000000 {
> > > > > +                       opp-hz = /bits/ 64 <1500000000>;
> > > >
> > > > So, 1.488 GHz or 1.5 GHz?
> > >
> > > 1.5 GHz
> > >
> > > > > +                       opp-microvolt = <950000>;
> > > >
> > > > Which regulator is controlled by this microvolt?
> > >
> > > Based on the SKU, the XBL sets up the regulator to provide 950000uV
> > > on CPUs capable of running 1.5G and 850000uV on other SKUs. Linux
> > > doesn't control it.
> >
> > Then why do you need this property here in the first place?
>
> I get these errors without this property
>
> [    1.018065] cpu cpu0: opp_parse_microvolt: opp-microvolt missing although OPP managing regulators

But you have said that "Linux doesn't control it" [the regulator]!

> [    1.018074] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22

-- 
With best wishes
Dmitry
