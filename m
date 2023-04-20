Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15746E9AC3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjDTRbk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Apr 2023 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDTRbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 13:31:39 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3FCE57
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 10:31:38 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94f161ee14fso29559266b.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 10:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011897; x=1684603897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thOYfF0eTamw5cXY8sfs6OvC02Me9zRVYEVC5nLneVM=;
        b=Hi7oiMYQSRtbhq5gphcQdrsQpqX7rIaNs3Ws+/CsNH9052UZQO/jAqO3al2u1zmI4u
         zJ2wVDkqeUjOv+Q0iW65uUjKqzf8BbkEZKOPWm6tSZIV9309crCU1BXGKfs2cJEdWntA
         DpI79hAmVIyLyaf0//9pDsbiw0QUiz9NXn7ZjmveJ9BJab4BCKdQKIEfHLmnDkP5EffQ
         uD5ngkmTHr/Ew9teF0mDm3HUNwnA4Sf3DwIDS+ToxWglUnFQoA7oRQ6P3RzaTGermlum
         3UP/79ohltiVouGY+gSPd9AUNoE57VurE96e3PazSmNI1BsvRH5h5WqVWFnl2sVq3ZK5
         kc2A==
X-Gm-Message-State: AAQBX9eonZ0y/3SEyb+DtBsh1ijgdHJsYdOb7XgDkOYIZ55bLQ1Nt3SC
        1ttzGbde5cgst0BDT8oEH+RWmYNQd5Fy42QbKdTZk5So
X-Google-Smtp-Source: AKy350ajaDkMV3iwrntYQ8BhxshMubV39ALS2+YTC72tbsXkxzxbaVLrTZPcO2KiKMFcCPtshv40WEXmuSiQw7AiREQ=
X-Received: by 2002:a17:906:1490:b0:94f:4ec3:f0e7 with SMTP id
 x16-20020a170906149000b0094f4ec3f0e7mr2370005ejc.2.1682011896960; Thu, 20 Apr
 2023 10:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230419035319.gtsmvcwh7ygua5fs@vireshk-i7>
In-Reply-To: <20230419035319.gtsmvcwh7ygua5fs@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Apr 2023 19:31:25 +0200
Message-ID: <CAJZ5v0gbPk-N03VL5bsrS9qfx9iP0OfoSrS-wcOQE5pvcat58g@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.4
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 19, 2023 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
>
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.4
>
> for you to fetch changes up to f41e1442ac5bd687389d6104d7b74766db821eb3:
>
>   cpufreq: tegra194: add OPP support and set bandwidth (2023-04-18 16:07:50 +0530)
>
> ----------------------------------------------------------------
> Updates for 6.4
>
> - Add opp and bandwidth support to tegra194 cpufreq driver (Sumit
>   Gupta).
>
> - Use of_property_present() for testing DT property presence (Rob
>   Herring).
>
> - Remove MODULE_LICENSE in non-modules (Nick Alcock).
>
> - Add SM7225 to cpufreq-dt-platdev blocklist (Luca Weiss).
>
> - Optimizations and fixes for qcom-cpufreq-hw driver (Krzysztof
>   Kozlowski, Konrad Dybcio, and Bjorn Andersson).
>
> - DT binding updates for qcom-cpufreq-hw driver (Konrad Dybcio and
>   Bartosz Golaszewski).
>
> - Updates and fixes for mediatek driver (Jia-Wei Chang and
>   AngeloGioacchino Del Regno).
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623
>
> Bartosz Golaszewski (1):
>       dt-bindings: cpufreq: qcom-hw: add a compatible for sa8775p
>
> Bjorn Andersson (1):
>       cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos
>
> Jia-Wei Chang (3):
>       cpufreq: mediatek: fix passing zero to 'PTR_ERR'
>       cpufreq: mediatek: fix KP caused by handler usage after regulator_put/clk_put
>       cpufreq: mediatek: raise proc/sram max voltage for MT8516
>
> Konrad Dybcio (4):
>       cpufreq: qcom-hw: Simplify counting frequency domains
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1 frequency domain
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290
>
> Krzysztof Kozlowski (1):
>       cpufreq: qcom-cpufreq-hw: fix double IO unmap and resource release on exit
>
> Luca Weiss (1):
>       cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist
>
> Nick Alcock (2):
>       kbuild, cpufreq: tegra124: remove MODULE_LICENSE in non-modules
>       kbuild, cpufreq: remove MODULE_LICENSE in non-modules
>
> Rob Herring (1):
>       cpufreq: Use of_property_present() for testing DT property presence
>
> Sumit Gupta (1):
>       cpufreq: tegra194: add OPP support and set bandwidth
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/cpufreq/cpufreq-dt-platdev.c                           |   3 ++-
>  drivers/cpufreq/freq_table.c                                   |   1 -
>  drivers/cpufreq/imx-cpufreq-dt.c                               |   2 +-
>  drivers/cpufreq/imx6q-cpufreq.c                                |   4 ++--
>  drivers/cpufreq/mediatek-cpufreq.c                             |  98 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
>  drivers/cpufreq/qcom-cpufreq-hw.c                              |  54 ++++++++-----------------------------------------
>  drivers/cpufreq/scmi-cpufreq.c                                 |   2 +-
>  drivers/cpufreq/tegra124-cpufreq.c                             |   1 -
>  drivers/cpufreq/tegra194-cpufreq.c                             | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
>  drivers/cpufreq/tegra20-cpufreq.c                              |   2 +-
>  11 files changed, 331 insertions(+), 111 deletions(-)
>
> --

Pulled, thanks!
