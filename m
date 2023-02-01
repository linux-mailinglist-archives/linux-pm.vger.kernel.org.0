Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB37686724
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 14:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjBANlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjBANlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 08:41:45 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164247403
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 05:41:42 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-510476ee20aso139014197b3.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdaA3pQP8MkF/AGzoRUIUmInqo1H05L3juON6STJfUY=;
        b=TJvX8Ji1HHNMzV9hzhskBOY1N43PNCMGAYu+yTAliFhO05TDK4Wp9E7bzISf8qIGr/
         zKCX8l6fiLdV1RyGyHtWBlpXvimtXfXgJkTfi4KjxeKVGQIWgeXkTM5Hw1OtDWRieZcy
         cwCWTfppKpzPHG2R3UYihGHmfFtOjhuid9xG47KBr3MYB7bU5lOUfJ+2gwwodGqe7l7z
         KE9Y6Cw92oA4M8I5u1EGmA30YoWdsiRAgViSQhpXKo4NplAoBmTKF2p70VQEQYh2L8cr
         IoLPG7B3zwKGeATzGLkGDTMrbwyuICe3Rwj5yK4lODJCzwjq07gWK5hJM3fYqOamVXKn
         Tn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdaA3pQP8MkF/AGzoRUIUmInqo1H05L3juON6STJfUY=;
        b=gdSk50v2Sp17rumQoaZWJKAIdbYxMAWPtOgjrc/zwx9pmjzf57RflTzx49leS4znM0
         N9YlLd0GXb35kOqalaf3nnQVB3kyTmBmD2LfuSh9FClTYN9tqB4KHSRof6RkKpJq5ofD
         LrNay9Yk7RfvBcX/jeT65ecbIhIFp8c2fSTSw5/EU5S1Q4s6gMKyTHoJWo60GJ0sS6LL
         N1O/ddmSoqFgnvY+C+EPMkFZrsPdvycR7dZvXj0FRYkW40BNMBhF2G5D8Sqd04955wsb
         mn2obHRPvZh8/qQ5INLh6A0dzoJCdewG16gB+Trd0z4Eah20owso2OG+sAkMzMw2DmVG
         rPgA==
X-Gm-Message-State: AO0yUKXm+ABfnMuwfxga89/d4bfsWb8KFYs85zTbplx86Rbn49g9xbW3
        3/UDQbzYYy9A1hU2384EGO2Y8yQ6WacxIRJbq23YNeLQ3HPidw==
X-Google-Smtp-Source: AK7set871+eaOjbi5jQpld9tkgnKYJS4StZCFqOtMRFkMLQglElI05Abd1BnT4pRMwhgQA7Aamkaq8b+O2c7LmnwWmg=
X-Received: by 2002:a05:690c:23c5:b0:4fe:1d13:5980 with SMTP id
 do5-20020a05690c23c500b004fe1d135980mr366234ywb.378.1675258901833; Wed, 01
 Feb 2023 05:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org> <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
In-Reply-To: <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Feb 2023 15:41:30 +0200
Message-ID: <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Feb 2023 at 13:46, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 01/02/2023 11:32, Dmitry Baryshkov wrote:
> > On 01/02/2023 10:02, Jun Nie wrote:
> >> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
> >> driver is introduced so that its freqency can be adjusted. And regulator
> >> associated with opp table can be also adjusted accordingly which is
> >> shared with cpu cluster.
> >>
> >> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> >> ---
> >>   drivers/devfreq/Kconfig    |   9 +++
> >>   drivers/devfreq/Makefile   |   1 +
> >>   drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 172 insertions(+)
> >>   create mode 100644 drivers/devfreq/qcom-cci.c
> >
> > Could you please describe in some additional details what are you trying
> > to achieve? Should the CCI frequency be scaled manually or does it
> > follow the cluster frequency? Do clusters vote on the CCI frequency?
> >
> > I'm inclined to ask if it is possible to shift this to the cpufreq OPP
> > tables?
> >
>
> Might not be so easy to just append CCI opps to the cluster frequency opps
>
>                  cci_cache: qcom,cci {
>                          compatible = "qcom,msm8939-cci";
>                          clock-names = "devfreq_clk";
>                          clocks = <&apcs2>;
>                          governor = "cpufreq";
>                          operating-points-v2 = <&cci_opp_table>;
>                          power-domains = <&cpr>;
>                          power-domain-names = "cpr";
>                          nvmem-cells = <&cpr_efuse_speedbin_pvs>;
>                          nvmem-cell-names = "cpr_efuse_speedbin_pvs";
>                  };
>
>                  devfreq-cpufreq {
>                          cci-cpufreq {
>                                  target-dev = <&cci_cache>;
>                                  cpu-to-dev-map-0 =
>                                          <  200000  200000000 >,
>                                          <  345600  200000000 >,
>                                          <  400000  200000000 >,
>                                          <  533330  297600000 >,
>                                          <  800000  297600000 >,
>                                          <  960000  297600000 >,
>                                          < 1113600  297000000 >,
>                                          < 1344000  595200000 >,
>                                          < 1459200  595200000 >,
>                                          < 1497600  595200000 >,
>                                          < 1651200  595200000 >;
>                                  cpu-to-dev-map-4 =
>                                          <  200000 200000000 >,
>                                          <  249600 200000000 >,
>                                          <  499200 297600000 >,
>                                          <  800000 297600000 >,
>                                          <  998400 595200000 >,
>                                          < 1113600 595200000 >;

These should map to existing opp entries.

I ended up doing the interconnect driver that maps a clock to the
interconnect. Then I can use it in the cpu opp tables.

>                          };
>                  };
>
>          cci_opp_table: cci-opp-table {
>                  compatible = "operating-points-v2";
>
>                  opp-200000000 {
>                          opp-hz = /bits/ 64 <200000000>;
>                          opp-supported-hw = <0x3f>;
>                          required-opps = <&cpr_opp3>;

And these should probably map to max(cpu's CPR opp, CCI's CPR opp).

>                  };
>
>                  opp-297600000 {
>                          opp-hz = /bits/ 64 <297600000>;
>                          opp-supported-hw = <0x3f>;
>                          required-opps = <&cpr_opp12>;
>                  };
>
>                  opp-400000000-cpr14 {
>                          opp-hz = /bits/ 64 <400000000>;
>                          opp-supported-hw = <0x1>;
>                          required-opps = <&cpr_opp14>;
>                  };
>
>                  opp-400000000-cpr15 {
>                          opp-hz = /bits/ 64 <400000000>;
>                          opp-supported-hw = <0x3e>;
>                          required-opps = <&cpr_opp15>;
>                  };
>
>                  opp-595200000 {
>                          opp-hz = /bits/ 64 <595200000>;
>                          opp-supported-hw = <0x3f>;
>                          required-opps = <&cpr_opp17>;
>                  };
>          };
>
>
>          cpr_opp_table: cpr-opp-table {
>                  compatible = "operating-points-v2-qcom-level";
>
>                  cpr_opp1: opp1 {
>                          opp-hz = /bits/ 64 <200000000>;
>                          opp-level = <1>;
>                          qcom,opp-fuse-level = <1>;
>                  };
>                  cpr_opp2: opp2 {
>                          opp-hz = /bits/ 64 <345600000>;
>                          opp-level = <2>;
>                          qcom,opp-fuse-level = <1>;
>                  };
>                  cpr_opp3: opp3 {
>                          opp-hz = /bits/ 64 <400000000>;
>                          opp-level = <3>;
>                          qcom,opp-fuse-level = <1>;
>                  };
>                  cpr_opp4: opp4 {
>                          opp-hz = /bits/ 64 <422400000>;
>                          opp-level = <4>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp5: opp5 {
>                          opp-hz = /bits/ 64 <499200000>;
>                          opp-level = <5>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp6: opp6 {
>                          opp-hz = /bits/ 64 <533330000>;
>                          opp-level = <6>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp7: opp7 {
>                          opp-hz = /bits/ 64 <652800000>;
>                          opp-level = <7>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp8: opp8 {
>                          opp-hz = /bits/ 64 <729600000>;
>                          opp-level = <8>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp9: opp9 {
>                          opp-hz = /bits/ 64 <800000000>;
>                          opp-level = <9>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp10: opp10 {
>                          opp-hz = /bits/ 64 <806400000>;
>                          opp-level = <10>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp11: opp11 {
>                          opp-hz = /bits/ 64 <883200000>;
>                          opp-level = <11>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>                  cpr_opp12: opp12 {
>                          opp-hz = /bits/ 64 <960000000>;
>                          opp-level = <12>;
>                          qcom,opp-fuse-level = <2>;
>                  };
>          };
>
> ---
> bod



-- 
With best wishes
Dmitry
