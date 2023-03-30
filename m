Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAE6D0492
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjC3MWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjC3MWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 08:22:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C967AB5
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 05:22:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id cf7so23201821ybb.5
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680178943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkgvBexVN7YQyw/6jRR4bXfTXLAK3o3NkknPbbqBnUc=;
        b=FgLWSz9t3sWQkJWIb04amO3ju/Zy/bu1b0klnduPHyBdLRrKnsim8cN2Ap0lh+NJ7v
         rOQTpRMNLMakHR8lZ4nNZJonc8b50PrHynV4j1bFMhbzJqZgdTKIpwDnXqfnt9i+ZcWv
         9Of0Fh2TMpywg3h8wZGGu1bj+/R2RQffoS8mFz9WNJgtPkSKN5BgWY9cP4WF3HxAFKIu
         0tx+1PUXygjYRH07aU38QCzOc1zL2TzxICadf5FnKVrFDVZ8K8O9qbwuoUixmvne8SBq
         jDwfbNfNKa9Xa2WOpisjstOfQ4wT2jOTgZ++rT/wcEUMIxEE6JBv4hKhgXCpg6t/p110
         K6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkgvBexVN7YQyw/6jRR4bXfTXLAK3o3NkknPbbqBnUc=;
        b=H7I9uKZRQQG5JuYa6oKCjPnwe/IQ+siihnU3emUXbwSjdCdpgfxGyToDHhWWFZ8y+A
         iRXxX0/khmsrVrPXHZ4aoGR3QJmsZ/Q7F0k4bcijMxeA5HUuskWkClAlkIPNgFUbqFUS
         Z+DIQJq5qT14wmMQR16YLXqsVo3hN9o+wsdGB7Avx+8uE6YrpTTuUl/eOH7wVHP4wWSS
         wOLIH+juvNN4kJmPospl7D+b/j1q+k+0BudnTxEK+WVIMwUAX37sQrNqAOJTb6juA6gD
         BuYhyu72zZkPbgVkDOswN7vAwUdjqlZO66bNulI1co8ctPJx5egI9FSKMSqSqI0/+/DK
         BpPw==
X-Gm-Message-State: AAQBX9dSfagqqGHQFC9hNWiHxWcJ1yfcTez4VAcTtSNsLb9Earj2EaJr
        ghgvQefSNTr7A4uyqqxL2cQQDcpsW/ywn1RID9CDjg==
X-Google-Smtp-Source: AKy350ajq/TmUBLRPZjm2/sWAgQNJKdsLd/pLSNZPUTH6/oDAeLSyRGusPDM5yEZFtErnt+S0DtkjLRkSDFn6ORxK4E=
X-Received: by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr12602065ybt.3.1680178943525; Thu, 30
 Mar 2023 05:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230330084250.32600-1-quic_mkshah@quicinc.com> <20230330084250.32600-3-quic_mkshah@quicinc.com>
In-Reply-To: <20230330084250.32600-3-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Mar 2023 14:21:47 +0200
Message-ID: <CAPDyKFoBi_TotpFF-OX2kyL=4zFSHK46nQsWFRqcX5YXTj-gLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     andersson@kernel.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Mar 2023 at 10:43, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Add power-domains for cpuidle states to use psci os-initiated idle states.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 5e6f9f441f1a..1a232eb4dde6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -170,9 +170,8 @@
>                         reg = <0x0 0x0>;
>                         clocks = <&cpufreq_hw 0>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -                                          &LITTLE_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD0>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_0>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -196,9 +195,8 @@
>                         reg = <0x0 0x100>;
>                         clocks = <&cpufreq_hw 0>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -                                          &LITTLE_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD1>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_100>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -218,9 +216,8 @@
>                         reg = <0x0 0x200>;
>                         clocks = <&cpufreq_hw 0>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -                                          &LITTLE_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD2>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_200>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -240,9 +237,8 @@
>                         reg = <0x0 0x300>;
>                         clocks = <&cpufreq_hw 0>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -                                          &LITTLE_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD3>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_300>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -262,9 +258,8 @@
>                         reg = <0x0 0x400>;
>                         clocks = <&cpufreq_hw 1>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&BIG_CPU_SLEEP_0
> -                                          &BIG_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD4>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_400>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -284,9 +279,8 @@
>                         reg = <0x0 0x500>;
>                         clocks = <&cpufreq_hw 1>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&BIG_CPU_SLEEP_0
> -                                          &BIG_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD5>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_500>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -306,9 +300,8 @@
>                         reg = <0x0 0x600>;
>                         clocks = <&cpufreq_hw 1>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&BIG_CPU_SLEEP_0
> -                                          &BIG_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD6>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_600>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -328,9 +321,8 @@
>                         reg = <0x0 0x700>;
>                         clocks = <&cpufreq_hw 2>;
>                         enable-method = "psci";
> -                       cpu-idle-states = <&BIG_CPU_SLEEP_0
> -                                          &BIG_CPU_SLEEP_1
> -                                          &CLUSTER_SLEEP_0>;
> +                       power-domains = <&CPU_PD7>;
> +                       power-domain-names = "psci";
>                         next-level-cache = <&L2_700>;
>                         operating-points-v2 = <&cpu7_opp_table>;
>                         interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> @@ -422,9 +414,11 @@
>                                 min-residency-us = <5555>;
>                                 local-timer-stop;
>                         };
> +               };
>
> +               domain-idle-states {
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
> -                               compatible = "arm,idle-state";
> +                               compatible = "domain-idle-state";
>                                 idle-state-name = "cluster-power-down";
>                                 arm,psci-suspend-param = <0x40003444>;
>                                 entry-latency-us = <3263>;
> @@ -790,6 +784,59 @@
>         psci {
>                 compatible = "arm,psci-1.0";
>                 method = "smc";
> +
> +               CPU_PD0: cpu0 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD1: cpu1 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD2: cpu2 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD3: cpu3 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD4: cpu4 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD5: cpu5 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD6: cpu6 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> +               };
> +
> +               CPU_PD7: cpu7 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> +               };
> +
> +               CLUSTER_PD: cpu-cluster0 {
> +                       #power-domain-cells = <0>;
> +                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> +               };
>         };
>
>         qspi_opp_table: opp-table-qspi {
> @@ -5280,6 +5327,7 @@
>                                           <SLEEP_TCS   3>,
>                                           <WAKE_TCS    3>,
>                                           <CONTROL_TCS 1>;
> +                       power-domains = <&CLUSTER_PD>;
>
>                         apps_bcm_voter: bcm-voter {
>                                 compatible = "qcom,bcm-voter";
> --
> 2.17.1
>
