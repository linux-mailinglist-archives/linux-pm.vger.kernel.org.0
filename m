Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCA21F2F4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGNNqd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 09:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNNqc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 09:46:32 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFF722515;
        Tue, 14 Jul 2020 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594734391;
        bh=aE6m+220/YSfMYlMHN697thZzIYExXhOHsKVgiloIHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rqD/hZ68IomJYl8uX16+l7yW9YzX+Tq+FiQvbQV08s1jVIcwaX7x8lTDCe6rt+ZBa
         Gt7h2wIwfsxjIzzkzy66cc/pprauO4dBf9+GidwGQEdX0OQkPs6wUEX7e8DAFq394H
         UCN7Orhrvrip67ZKIteaDpLMLyWo7uSoHhd/Yj58=
Received: by mail-ot1-f42.google.com with SMTP id 18so13047670otv.6;
        Tue, 14 Jul 2020 06:46:31 -0700 (PDT)
X-Gm-Message-State: AOAM5331KhUSLOB8a+0caCit0UpUeMEBW6ClVUcb/1wCRCJ3rSFA3RI9
        Z2g9tgmZ9hY4DaPxFDUbLm9ZAFUbnQD0kuNnJw==
X-Google-Smtp-Source: ABdhPJxfSzrolS+34yv9srge0rhF3g9YW0NmHqghsJKkBRg71RVBlCQqSIjESPLKZ4tT8EhTiG7wO/yRMM6L+Rnx8yI=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr3888709otb.107.1594734390765;
 Tue, 14 Jul 2020 06:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-2-git-send-email-sumitg@nvidia.com> <20200713164214.GA341271@bogus>
 <70a0a8ee-b79a-2a05-5150-2ee0faaf2730@nvidia.com>
In-Reply-To: <70a0a8ee-b79a-2a05-5150-2ee0faaf2730@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 07:46:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
Message-ID: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 1/4] dt-bindings: arm: Add t194 ccplex
 compatible and bpmp property
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bbasu@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 5:44 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>
>
>
> > On Mon, Jul 13, 2020 at 07:36:46PM +0530, Sumit Gupta wrote:
> >> To do frequency scaling on all CPUs within T194 CPU Complex, we need
> >> to query BPMP for data on valid operating points. Document a compatible
> >> string under 'cpus' node to represent the CPU Complex for binding drivers
> >> like cpufreq which don't have their node or CPU Complex node to bind to.
> >> Also, document a property to point to the BPMP device that can be queried
> >> for all CPUs.
> >
> > The cpus.yaml binding documents what's in 'cpu' nodes, not 'cpus'
> > node. AIUI, the latter is what you want. You should do your own schema
> > file here.
> >
> Do you mean to change existing file name from 'cpus.yaml' to 'cpu.yaml'
> and create new 'cpus.yaml' file?
> I think it's better to incorporate the change in existing 'cpus.yaml'
> file to keep both cpu@X and cpus node details together. Please suggest.

No, I'm suggesting you create nvidia,tegra194-ccplex.yaml.


> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/cpus.yaml | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> >> index a018147..9b328e3 100644
> >> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> >> @@ -162,6 +162,7 @@ properties:
> >>         - nvidia,tegra132-denver
> >>         - nvidia,tegra186-denver
> >>         - nvidia,tegra194-carmel
> >> +      - nvidia,tegra194-ccplex
> >
> > Tegra194 has 2 different CPUs?
> >
> No, T194 SOC has homogeneous architecture with four clusters where each
> cluster has two symmetric cores. 'nvidia,tegra194-carmel' compatible
> string represents each cpu. 'nvidia,tegra194-ccplex' string represents
> the CPU Complex to bind cpufreq driver. The change was done as per
> discussion [1]

You are adding the compatible string to the cpu@N node compatible.

>
> >>         - qcom,krait
> >>         - qcom,kryo
> >>         - qcom,kryo260
> >> @@ -255,6 +256,15 @@ properties:
> >>
> >>         where voltage is in V, frequency is in MHz.
> >>
> >> +  nvidia,bpmp:
> >> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> >> +    description: |
> >> +      Specifies the bpmp node that needs to be queried to get
> >> +      operating point data for all CPUs.
> >> +
> >> +      Optional for systems that have a "compatible"
> >> +      property value of "nvidia,tegra194-ccplex".
> >> +
> >>     power-domains:
> >>       $ref: '/schemas/types.yaml#/definitions/phandle-array'
> >>       description:
> >> @@ -340,6 +350,7 @@ required:
> >>
> >>   dependencies:
> >>     rockchip,pmu: [enable-method]
> >> +  nvidia,bpmp: [compatible]
> >>
> >>   examples:
> >>     - |
> >> --
> >> 2.7.4
> >>
>
> [1] https://marc.info/?l=linux-arm-kernel&m=158999171528418&w=2
