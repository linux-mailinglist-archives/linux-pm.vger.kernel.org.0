Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996F696733
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNOn7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Feb 2023 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBNOn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:43:59 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECAEA271
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:43:58 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id rp23so40646307ejb.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XWKsMAMHm9nwcB8DjIvRNSxdBTihQ3x6QCKjjISyso=;
        b=4WboDN5yTHWs/zGyWBZgKfAH3o6oyinJfRNXL9axNeu513r3hgr6rO62d30AfPKUG7
         mieOLAX6v/athhXUX1LFOrcNU/SpzoAKNRlKRWHMuGgiDsM2eepCe7llY+mnVeai8L8d
         QCn3pmjBtqDYRaZ+niuwoMsnlwsO6/hL2XyrB/muW0quCnFk4g1Vq8Uj4UtC9gfa2jeP
         zcmEaNPCDQgIY0oKGvsHcSI4q07R6KsF0kPt4Ofjf/oSciA8a93i/dPq7mgvR/YvGq/d
         vzVt7Ncisnjq3B2oWUAY6LQfKYaT2Z03x+w/YenMtkrx5Pj1dxMiOWZHqNNQqL8gQhmJ
         eFZg==
X-Gm-Message-State: AO0yUKXPjM05uYGSR+p8M8fHdZvxXyBIrMtOUtbqFgkkPDDlAKfXx8A3
        75kqhhqy/X3CkuloehV5nottJhMWrIWnDlgPBpLCLd3E
X-Google-Smtp-Source: AK7set/08ymOiEaoPnprA2XKlk+Zhx5jOEmBXu38SIyw/CxaviJIXGSFkM0zsHju4CK7WKeb/nAKOxUtcFRBbkGV+/I=
X-Received: by 2002:a17:906:f154:b0:8af:38c9:d52d with SMTP id
 gw20-20020a170906f15400b008af38c9d52dmr1475277ejb.2.1676385836571; Tue, 14
 Feb 2023 06:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20230214053500.ziqfmb3temvetssk@vireshk-i7>
In-Reply-To: <20230214053500.ziqfmb3temvetssk@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:43:45 +0100
Message-ID: <CAJZ5v0juEfSpYALddGvKawd4sYZQKay=3ga2-OaNRib2ju5fEA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 14, 2023 at 6:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 51be2fffd65d9f9cb427030ab0ee85d791b4437d:
>
>   cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems (2023-02-06 09:31:38 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.3
>
> for you to fetch changes up to ba38f3cbe7db2cec802c6d60e2bef57a3ff095a4:
>
>   dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum (2023-02-14 10:51:58 +0530)
>
> ----------------------------------------------------------------
> Cpufreq arm updates for 6.3
>
> - Enable thermal cooling for Tegra194 (Yi-Wei Wang).
>
> - Register module device table and add missing compatibles for
>   cpufreq-qcom-hw (Nícolas F. R. A. Prado, Abel Vesa and Luca Weiss).
>
> - Various dt binding updates for qcom-cpufreq-nvmem and opp-v2-kryo-cpu
>   (Christian Marangi).
>
> ----------------------------------------------------------------
> Abel Vesa (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible
>
> Christian Marangi (3):
>       dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
>       dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
>       dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
>
> Luca Weiss (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing compatibles
>
> Nícolas F. R. A. Prado (1):
>       cpufreq: mediatek-hw: Register to module device table
>
> Yi-Wei Wang (1):
>       cpufreq: tegra194: Enable CPUFREQ thermal cooling
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml    |  5 +++++
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml        | 16 +++++++++++++---
>  drivers/cpufreq/mediatek-cpufreq-hw.c                             |  1 +
>  drivers/cpufreq/tegra194-cpufreq.c                                |  3 ++-
>  5 files changed, 77 insertions(+), 29 deletions(-)
>
> --

Pulled and pushed into the linux-next branch in linux-pm.git.

Thanks!
