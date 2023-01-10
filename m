Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF84664CE3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjAJT7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 14:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjAJT7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 14:59:37 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A41001
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 11:59:36 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id u9so31602367ejo.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 11:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phqcFcktUOE8soESCOvTtIRnoJvazAqSN6K5QS4zHeQ=;
        b=yRPpJahVQuEM5LvB+LyRcXEnsDWHfXKiJ8z8N6a524fQc+BDXTjK1QugVozOakcYj7
         Qa0OgvAwWkDl/OLDPBh0d9Gb85WHkT3yzTmNmINGyAQ+qL/78KjHlO9HPIU4euYZnYAa
         1FC2EPa0WYMglS+5bQj3zF7R3KQQAC9iFIcJWkb7ZW4t5aozHMLczlddD6aQ/FTJF76M
         TUprccWun1n3WhxZaODHchJQvbeE0rL/Rk/6L17v01aTDQqCpSxSAq1FGAa7xCNMeTbz
         Y9oiPX4kd2vNYFnzhA6iVl02G/HI/CEwB8eImepF+GpvjeDkvppn2aExBdn200jRvOAh
         hfXw==
X-Gm-Message-State: AFqh2koSPI1ODsyigfl5HEQGNk9qA6ob2sQOB9U3IYdc4OdG17QuSUpp
        yb3saLcpQzOuK00oF0QhbDZ0zivfkZH3xgtYAoQlfj3p
X-Google-Smtp-Source: AMrXdXsby0RKfGUgvU6idlVTCi0i0VksJmlcHCJlf+S3mUyB+hxanHK8tBwzbODv23Pndv2rPLloYz5lb6kWbs1H5ek=
X-Received: by 2002:a17:907:6d2a:b0:7c0:efba:b39c with SMTP id
 sa42-20020a1709076d2a00b007c0efbab39cmr7599211ejc.209.1673380774744; Tue, 10
 Jan 2023 11:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20230110041125.tamqbqec5aqyck22@vireshk-i7>
In-Reply-To: <20230110041125.tamqbqec5aqyck22@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 20:59:23 +0100
Message-ID: <CAJZ5v0iSVYQ+FtMezeeB5w1h5JBYuhn=ugwzuLymSx9OU4KSWA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.2-rc
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 10, 2023 at 5:11 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq/arm/fixes-6.2-rc4
>
> for you to fetch changes up to 08f0adb193c008de640fde34a2e00a666c01d77c:
>
>   cpufreq: armada-37xx: stop using 0 as NULL pointer (2023-01-10 09:32:03 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm fixes for 6.2-rc4
>
> - Fix double initialization and set suspend-freq for Apple's cpufreq
>   driver (Arnd Bergmann and Hector Martin).
>
> - Fix reading of "reg" property, update cpufreq-dt's blocklist and
>   update DT documentation for Qualcomm's cpufreq driver (Konrad Dybcio
>   and Krzysztof Kozlowski).
>
> - Replace 0 with NULL for Armada driver (Miles Chen).
>
> - Fix potential overflows in CPPC driver (Pierre Gondois).
>
> - Update blocklist for Tegra234 Soc (Sumit Gupta).
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       cpufreq: apple: remove duplicate intializer
>
> Hector Martin (1):
>       cpufreq: apple-soc: Switch to the lowest frequency on suspend
>
> Konrad Dybcio (2):
>       cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2
>       cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist
>
> Krzysztof Kozlowski (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: document interrupts
>
> Miles Chen (1):
>       cpufreq: armada-37xx: stop using 0 as NULL pointer
>
> Pierre Gondois (1):
>       cpufreq: CPPC: Add u64 casts to avoid overflowing
>
> Sumit Gupta (1):
>       cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 11 +++++++++++
>  drivers/cpufreq/apple-soc-cpufreq.c                            |  3 ++-
>  drivers/cpufreq/armada-37xx-cpufreq.c                          |  2 +-
>  drivers/cpufreq/cppc_cpufreq.c                                 | 11 ++++++-----
>  drivers/cpufreq/cpufreq-dt-platdev.c                           |  2 ++
>  drivers/cpufreq/qcom-cpufreq-hw.c                              | 22 ++++++++++++++++++++--
>  6 files changed, 42 insertions(+), 9 deletions(-)
>
> --

Pulled, thanks!
