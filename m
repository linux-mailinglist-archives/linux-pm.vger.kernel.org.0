Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6856611F0F
	for <lists+linux-pm@lfdr.de>; Sat, 29 Oct 2022 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJ2B1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 21:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ2B1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 21:27:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585D1CC749
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 18:27:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sc25so16787972ejc.12
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 18:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SB8cXsJ6cSiGdyMloRjmKV5mlYek2j619QkGusLH93k=;
        b=OIignES46Kbt8O1G/D8CE5LCzf4liD+TVCHTDYlD1UbO7ZV00At2PgUGiLzRcjcRoP
         KDz7BunLbRO8b7QvzRLiyOYUoHvTfU9FCx65vWf3xgqvOJfA9iwsnxzTSjLjFF9sYFPW
         oYjD0DXfz6gTvYLzJGRJbZK+G+AXCUGpHlhghba5fZUJvAy/kS6ffd4YC9jxzDunFcSf
         vFV9nR1IVVFNTZQXpa+glCngHUChxUtAowEyJGhQRCTxA5BuzVj4ZMRpqk49kbNedsjN
         j+nCAT3fysljbaAoQW9f4RydBrH+FUr24DZEeAVV9w+0jE2sDNkP80yZyp1RAxuojKBH
         q1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB8cXsJ6cSiGdyMloRjmKV5mlYek2j619QkGusLH93k=;
        b=Ca1Jg90invA9Q/0lMXMpk4fFnxwU64BeT9D0DVeEnPKA4JnIpsq6HxLcI00dh6rFOC
         jSbRm+jBtM2MBquELlrWrNKGvDTfjPhUMe1iTUweHGFlewtp1D4ICjCXohZFYS7AILJd
         1yykHT+Agy/9turISTNbojMo8xRBbPaGAoBwyArP7rkLe5TFeFfYiG3iebRDTK5YcFnv
         fUUP8UpkRHFw0t9gxwXmgMYDo0bHhA3oYUGqRiaTS9Z8xmcjpz8ocW35zkz3jC/8Cw7C
         3v3iXa6wWE2fUGXuaDIWwD2ixX4vwNLWL8eg408Qm1DpHWNkf6Yq20jigaxUm/SAAIxr
         I9IQ==
X-Gm-Message-State: ACrzQf0GpDF2NB2aC4Rrn3ZQz3qxQ23NwhR2OS9fyFXlVDxWJusXJVhG
        tu0LF8INU5mjHUyRAINbx4gLkbDrsF1IXyLr4oOhDQ==
X-Google-Smtp-Source: AMsMyM6MGnF2TSbEaIjrBzL/n0tAG+PSMkH6yiE/pY/08UqBhcIIpMPKhMmviToeyNxz+zsaPbVSgur3Lfy83BExNZM=
X-Received: by 2002:a17:907:75c1:b0:79b:f804:c081 with SMTP id
 jl1-20020a17090775c100b0079bf804c081mr1857415ejc.381.1667006860118; Fri, 28
 Oct 2022 18:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
In-Reply-To: <20221028034155.5580-1-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Fri, 28 Oct 2022 20:27:27 -0500
Message-ID: <CAKXuJqhOH1Ts0Nde5WB0-bVHUv=_As23eJRsH=VnCxxjtkNB_A@mail.gmail.com>
Subject: Re: [PATCH 00/10] interconnect: osm-l3: SC8280XP L3 and DDR scaling
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 27, 2022 at 10:42 PM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> The SC8280XP currently shows depressing results in memory benchmarks.
> Fix this by introducing support for the platform in the OSM (and EPSS)
> L3 driver and support for the platform in the bwmon binding.
>
> Then add the necessary nodes and values throughout the sc8280xp and
> sa8540p dtsi files to make the various devices on these platforms scale
> both L3, memory bus and DDR.
>
> Bjorn Andersson (10):
>   interconnect: qcom: osm-l3: Use platform-independent node ids
>   interconnect: qcom: osm-l3: Squash common descriptors
>   interconnect: qcom: osm-l3: Add per-core EPSS L3 support
>   interconnect: qcom: osm-l3: Simplify osm_l3_set()
>   dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3
>     compatibles
>   arm64: dts: qcom: Align with generic osm-l3/epss-l3
>   arm64: dts: qcom: sc8280xp: Add epss_l3 node
>   arm64: dts: qcom: sc8280xp: Set up L3 scaling
>   dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon
>     instances
>   arm64: dts: qcom: sc8280xp: Add bwmon instances
>
>  .../interconnect/qcom,msm8998-bwmon.yaml      |   5 +
>  .../bindings/interconnect/qcom,osm-l3.yaml    |  22 ++-
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  39 +++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 152 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +-
>  drivers/interconnect/qcom/osm-l3.c            | 126 ++++-----------
>  10 files changed, 251 insertions(+), 103 deletions(-)
>
> --
> 2.37.3
>
Prior to this series being applied:

steev@cho:~/temp/mybw$ ./mybw
    64: 21043.42MB/s
   128: 22511.90MB/s
   256: 23190.96MB/s
   512: 23532.00MB/s
  1024: 23537.36MB/s
    2K: 23730.19MB/s
    4K: 23307.45MB/s
    8K: 23603.36MB/s
   16K: 23752.39MB/s
   32K: 23819.91MB/s
   64K: 23871.28MB/s
  128K: 23890.10MB/s
  256K: 23851.90MB/s
  512K: 23759.65MB/s
 1024K: 15956.73MB/s
    2M: 8418.88MB/s
    4M: 6385.06MB/s
    8M: 5959.11MB/s
   16M: 5892.18MB/s
   32M: 6109.78MB/s


With this series applied:
steev@cho:~/temp/mybw$ ./mybw
    64: 21193.63MB/s
   128: 22513.64MB/s
   256: 23196.15MB/s
   512: 23554.33MB/s
  1024: 23555.31MB/s
    2K: 23738.53MB/s
    4K: 23310.13MB/s
    8K: 23616.14MB/s
   16K: 23768.47MB/s
   32K: 23847.16MB/s
   64K: 23881.61MB/s
  128K: 23901.33MB/s
  256K: 23910.21MB/s
  512K: 23839.70MB/s
 1024K: 23577.47MB/s
    2M: 23836.08MB/s
    4M: 23798.35MB/s
    8M: 23759.23MB/s
   16M: 22887.62MB/s
   32M: 22491.87MB/s

Additionally, if anyone is curious, geekbench 5.4 comparison, with
this patchset applied on 6.0.5:

https://browser.geekbench.com/v5/cpu/compare/18284519?baseline=18076980

This change is very welcomed :)

Tested on the Lenovo Thinkpad X13s

Tested-by: Steev Klimaszewski <steev@kali.org>
