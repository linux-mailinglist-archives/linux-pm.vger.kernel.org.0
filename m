Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4DB2716
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 23:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfIMVOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 17:14:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37048 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfIMVOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 17:14:01 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so5678876iob.4;
        Fri, 13 Sep 2019 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UskOfSgg386hDT+uq0TXDMPpn1NNITv5aTMpt8d4CVY=;
        b=KTZO+mFW2Oh+QziZmA+IzJU3e+94+mnT6T1racQjGHE2uMDNbYjP5fICTd+PTf1T0O
         89ZtvAqy7spGERQr6pyWt0bInhVfaqM7cYr9nEcDxs3vFv4hlpWsGBeuOdg+GguUZYSJ
         bbqeOPT7mYQmJu90r9JJUzc1qNfip9Z8r+W2ttzMSo7na/G4+Nmk1bdIF3VPj/Dc6od/
         Ek0kziyGcUuD347XXLB1M9Pc2IIUGHy8R/LJydks5GoSHDhsTv/5ZiThLpcI2YBPuZUh
         UHoU+R1bnjMYHIKQ0+3Kz3Ptw8xP0a7M4AvTuG8tuwis8beY1LHrKv/cDSyHY1Qaf/+w
         nShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UskOfSgg386hDT+uq0TXDMPpn1NNITv5aTMpt8d4CVY=;
        b=RKVuVXXU3/NLX2iVuLsBvOwOapsq5erry0n/7LW7iOcIHXqfSEmJ34jZDYgfkhV0WF
         vpP53HNAeswIz5oHKe/c82wiES5NIgMnecFHroDPWzWEsuc+w/i7v7tPGLv5Wo8HXQMN
         57enVDJuuHBJPy3162Sn6/DkZF/WFkfFKV7KBdMx+kqvdSxJzUjFSqEDrRN41o1t1ZBO
         loyqZh5yRnxF/iby7mQnxDFzm2gUxzO0wWCHdU52CHOSQwLRPHiCet6DLCKGjMyeIbll
         8DRv6AkYLjwhE3EJm16BvkLxpAIXONSbOUOoXy3XNTCqcFZtFOCY2ErWlrzsxhoXZ6kw
         0kGA==
X-Gm-Message-State: APjAAAX0JW/v84Z4WHaT/SG4oxuynbdxe1XUeCLHDEUUpsCyai8YblG2
        9hc5AdmKpsyjJKnnzsDJfccaxdWSf5gqKNmY1bw=
X-Google-Smtp-Source: APXvYqxRa4Jg1JIT0wxzuiyNm4qA+JzsRMv754ROCdVMD/vIvOO+svXgd/mShdE0/aAd0y6Ox+BfcYHRmgO1HdAv8ek=
X-Received: by 2002:a6b:b78b:: with SMTP id h133mr2158869iof.276.1568409240130;
 Fri, 13 Sep 2019 14:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568224032.git.hns@goldelico.com> <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
In-Reply-To: <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 13 Sep 2019 16:13:49 -0500
Message-ID: <CAHCN7x+RTSHg7jKys=Jv6Urz0PsHNTM8EnFT1dwAZOtsjxpEAw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ARM: dts: omap36xx: using OPP1G needs to control
 the abb_ldo
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 11, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> See DM3730,DM275 data sheet (SPRS685B) footnote (6) in Table 4-19
> which says that ABB must be switched to FBB mode when using the
> OPP1G.
>
> The LOD definition abb_mpu_iva already exists so that we need
> to add plumbing for vbb-supply = <&abb_mpu_iva>
> and define two voltage vectors for each OPP so that the abb LDO
> is also updated by the ti-cpufreq driver.
>
> We also must switch the ti_cpufreq_soc_data to multi_regulator.
>
> Note: reading out the abb reglator voltage to verify that
> it does do transitions can be done by
>
> cat /sys/devices/platform/68000000.ocp/483072f0.regulator-abb-mpu/regulator/regulator.*/microvolts
>
> Likewise, read the twl4030 provided VDD voltage by
>
> cat /sys/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:regulator-vdd1/regulator/regulator.*/microvolts
>
> Note: to check if the ABB FBB is enabled/disabled, check
> registers
>
> PRM_LDO_ABB_CTRL 0x483072F4 bit 3:0 1=bypass 5=FBB
> PRM_LDO_ABB_SETUP 0x483072F0 0x00=bypass 0x11=FBB
>
> e.g.
>
> /dev/mem opened.
> Memory mapped at address 0xb6fe4000.
> Value at address 0x483072F4 (0xb6fe42f4): 0x3205
> /dev/mem opened.
> Memory mapped at address 0xb6f89000.
> Value at address 0x483072F4 (0xb6f892f4): 0x3201
>
> Note: omap34xx and am3517 have/need no comparable LDO
> or mechanism.
>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap36xx.dtsi | 21 ++++++++++++++++-----
>  drivers/cpufreq/ti-cpufreq.c    |  2 +-
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index cb5bd0969124..4bb4f534afe2 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -23,6 +23,7 @@
>                 cpu: cpu@0 {
>                         operating-points-v2 = <&cpu0_opp_table>;
>
> +                       vbb-supply = <&abb_mpu_iva>;
>                         clock-latency = <300000>; /* From omap-cpufreq driver */
>                 };
>         };
> @@ -37,9 +38,11 @@
>                         /*
>                          * we currently only select the max voltage from table
>                          * Table 4-19 of the DM3730 Data sheet (SPRS685B)
> -                        * Format is: <target min max>
> +                        * Format is:   cpu0-supply:    <target min max>
> +                        *              vbb-supply:     <target min max>
>                          */
> -                       opp-microvolt = <1012500 1012500 1012500>;
> +                       opp-microvolt = <1012500 1012500 1012500>,
> +                                        <1012500 1012500 1012500>;
>                         /*
>                          * first value is silicon revision bit mask
>                          * second one is "speed binned" bit mask
> @@ -50,25 +53,33 @@
>
>                 opp100-600000000 {
>                         opp-hz = /bits/ 64 <600000000>;
> -                       opp-microvolt = <1200000 1200000 1200000>;
> +                       opp-microvolt = <1200000 1200000 1200000>,
> +                                        <1200000 1200000 1200000>;
>                         opp-supported-hw = <0xffffffff 3>;
>                 };
>
>                 opp130-800000000 {
>                         opp-hz = /bits/ 64 <800000000>;
> -                       opp-microvolt = <1325000 1325000 1325000>;
> +                       opp-microvolt = <1325000 1325000 1325000>,
> +                                        <1325000 1325000 1325000>;
>                         opp-supported-hw = <0xffffffff 3>;
>                 };
>
>                 opp1g-1000000000 {
>                         opp-hz = /bits/ 64 <1000000000>;
> -                       opp-microvolt = <1375000 1375000 1375000>;
> +                       opp-microvolt = <1375000 1375000 1375000>,
> +                                        <1375000 1375000 1375000>;
>                         /* only on am/dm37x with speed-binned bit set */
>                         opp-supported-hw = <0xffffffff 2>;
>                         turbo-mode;

If / when the thermal changes I submitted get approved, would you
entertain dropping this turbo-mode flag so it's enabled by default?

adam
>                 };
>         };
>
> +       opp_supply_mpu_iva: opp_supply {
> +               compatible = "ti,omap-opp-supply";
> +               ti,absolute-max-voltage-uv = <1375000>;
> +       };
> +
>         ocp@68000000 {
>                 uart4: serial@49042000 {
>                         compatible = "ti,omap3-uart";
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 1a3073a3093e..f4704f9033e0 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -174,7 +174,7 @@ static struct ti_cpufreq_soc_data omap36xx_soc_data = {
>         .efuse_shift = 9,
>         .efuse_mask = BIT(9),
>         .rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
> -       .multi_regulator = false,
> +       .multi_regulator = true,
>  };
>
>  /**
> --
> 2.19.1
>
