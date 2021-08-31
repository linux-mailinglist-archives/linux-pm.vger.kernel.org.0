Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5D3FC6E8
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhHaMCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 08:02:36 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40767 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhHaMCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 08:02:35 -0400
Received: by mail-oi1-f180.google.com with SMTP id h133so23988782oib.7
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 05:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUmPAbve0cJQfghC65Y6ltr4m051prws+XbxIo3U5nA=;
        b=Ntbi8CCgqtjM5iq4VzzIsiFU8zdFgejclGOjfeKH7pNswfArP1b1FENzGOFBp430wM
         yaxG6vmaQKfP2ttlb65aFnYNST/SpBEY761u3A5y6ptDxcalhQLfUoN8eZ3/pigM6Ylv
         seZTLZ0bpnyGkoI3svvQ2ghhouk9FwSPxRfdXRyH6KOrgqFsiawua9YvXvV3PQn466tK
         DJqcnXtFktNudY2l6l8YcKJhHAzEMFO8d9aXMsb4nwgTqmfS4bYhJl/P1KVn+lrPqHyi
         fury+aKnOo7amV/Tm57tgj8ln/p23UdMuB4yLhnvdchx2ieEUjKVW+2Jf/+oH810plyl
         BCeQ==
X-Gm-Message-State: AOAM532/Sc2126qHgkoYVwcZyqi5bT0mRUbdjL6Frxg+KDoGAhQ0k7vq
        cPSTyn/gnlWqPWQ3WkxjJhR7vzlmeqq1myeq88U=
X-Google-Smtp-Source: ABdhPJzcLe0IuMfU7rEU1vM0ey0LXodija5qdDpoGWHf2O+4D0fCwGwibtlqaZnwNgaf4dQ4mRkCFJzcigvb3n2Z2hg=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr2749191ois.69.1630411300330;
 Tue, 31 Aug 2021 05:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831054400.voq3pxldkxezqldn@vireshk-i7>
In-Reply-To: <20210831054400.voq3pxldkxezqldn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Aug 2021 14:01:28 +0200
Message-ID: <CAJZ5v0irJux7ojhn7xHS07dXg78vbN4_Dnf8k6OfQyRzpsoQxg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.15-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 31, 2021 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request moves the OPP bindings to DT schema (Rob Herring).
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit 19526d092ceb32d619fce73fe0bdca4370890124:
>
>   opp: core: Check for pending links before reading required_opp pointers (2021-08-23 12:44:55 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 94274f20f6bf5eb0099bbf7e133aac1f5cd087e8:
>
>   dt-bindings: opp: Convert to DT schema (2021-08-23 12:44:55 +0530)

Pulled, thanks!


> ----------------------------------------------------------------
> Rob Herring (3):
>       ARM: dts: omap: Drop references to opp.txt
>       dt-bindings: Clean-up OPP binding node names in examples
>       dt-bindings: opp: Convert to DT schema
>
>  .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt          |   2 +-
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     |   6 +-
>  .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   2 +-
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +-
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   2 +-
>  .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   2 +-
>  .../bindings/interconnect/fsl,imx8m-noc.yaml       |   4 +-
>  .../opp/allwinner,sun50i-h6-operating-points.yaml  |   4 +
>  Documentation/devicetree/bindings/opp/opp-v1.yaml  |  51 ++
>  .../devicetree/bindings/opp/opp-v2-base.yaml       | 214 +++++++
>  Documentation/devicetree/bindings/opp/opp-v2.yaml  | 475 ++++++++++++++++
>  Documentation/devicetree/bindings/opp/opp.txt      | 622 ---------------------
>  Documentation/devicetree/bindings/opp/qcom-opp.txt |   2 +-
>  .../bindings/opp/ti-omap5-opp-supply.txt           |   2 +-
>  .../devicetree/bindings/power/power-domain.yaml    |   2 +-
>  arch/arm/boot/dts/omap34xx.dtsi                    |   1 -
>  arch/arm/boot/dts/omap36xx.dtsi                    |   1 -
>  18 files changed, 757 insertions(+), 639 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v1.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/opp.txt
>
