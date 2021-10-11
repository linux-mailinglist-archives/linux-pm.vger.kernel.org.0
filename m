Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B38428E22
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhJKNid (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 09:38:33 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40923 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbhJKNi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 09:38:28 -0400
Received: by mail-ot1-f51.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so4959403otr.7;
        Mon, 11 Oct 2021 06:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1pi40TIcKotkV6rxOevddDOHbAMj+lS14ZHs3z6ayJg=;
        b=kiiPY7O38mybeHFGGcJ0uKsgVxFeXUMFEMPlDXV7SMc6PnLkDAurNK6DoNtspSZhnJ
         Wozllfwp9tm5RwYrh9pGVOD8rsJJ6zYKx9erAijfzj0xh/allqKSxbV9KDHQBqi6in0/
         0ZEK7x71C47NclOeZp5p2Kc1wfGqXAcTXs8Xnz7i4YF6rJEre2DkqvGaOZqnoBYFtvZP
         AR3bdoYz8lDRnBhT79T4JOaQ78Vu1/xJsFPy8D9rGS4v6Dj1743xEA4DVLHUwYtTE0o5
         WE12U07DmibX5BvYXO5Y1zaVVNJfRrl3k8an9Gm+EpM4HN6r/Q2GUyvgk1WZnTuIjOk6
         zRvQ==
X-Gm-Message-State: AOAM531aIzkZ/b0nYhR0ZECBmSCd2hRsHnjvN4m1VGXx8FrcijgvPAdK
        Rmy0MtWt7rgeG9Chx3QEDQ==
X-Google-Smtp-Source: ABdhPJwCnGSJxyh6fwYssOa8zYwCnn8BcBhPCI+XeOvGYCYE8QJxZ2s1XOnwdrLFg8s4OhTg7uI/aw==
X-Received: by 2002:a05:6830:3486:: with SMTP id c6mr20994134otu.101.1633959384440;
        Mon, 11 Oct 2021 06:36:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l9sm45795oie.15.2021.10.11.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:36:23 -0700 (PDT)
Received: (nullmailer pid 504942 invoked by uid 1000);
        Mon, 11 Oct 2021 13:36:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liush <liush@allwinnertech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
In-Reply-To: <20211011081820.1135261-8-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com> <20211011081820.1135261-8-anup.patel@wdc.com>
Subject: Re: [PATCH v8 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Mon, 11 Oct 2021 08:36:18 -0500
Message-Id: <1633959378.228904.504941.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Oct 2021 13:48:19 +0530, Anup Patel wrote:
> The RISC-V CPU idle states will be described in under the
> /cpus/idle-states DT node in the same way as ARM CPU idle
> states.
> 
> This patch adds common bindings documentation for both ARM
> and RISC-V idle states.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
>  .../devicetree/bindings/arm/psci.yaml         |   2 +-
>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  4 files changed, 219 insertions(+), 19 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpu/idle-states.yaml: patternProperties:^(cpu|cluster)-:properties:compatible:oneOf: [{'const': 'arm,idle-state'}, {'const': 'riscv,idle-state'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpu/idle-states.yaml: ignoring, error in schema: patternProperties: ^(cpu|cluster)-: properties: compatible: oneOf
warning: no schema found in file: ./Documentation/devicetree/bindings/cpu/idle-states.yaml
Documentation/devicetree/bindings/arm/psci.example.dt.yaml:0:0: /example-3/cpus/idle-states/cpu-power-down: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cpu-retention-0-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cluster-retention-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cpu-sleep-0-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cluster-sleep-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cpu-retention-1-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cluster-retention-1: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cpu-sleep-1-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-0/cpus/idle-states/cluster-sleep-1: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-1/cpus/idle-states/cpu-sleep-0-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-1/cpus/idle-states/cluster-sleep-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-1/cpus/idle-states/cpu-sleep-1-0: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-1/cpus/idle-states/cluster-sleep-1: failed to match any schema with compatible: ['arm,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cpu-retentive-0-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cpu-nonretentive-0-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cluster-retentive-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cluster-nonretentive-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cpu-retentive-1-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cpu-nonretentive-1-0: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cluster-retentive-1: failed to match any schema with compatible: ['riscv,idle-state']
Documentation/devicetree/bindings/cpu/idle-states.example.dt.yaml:0:0: /example-2/cpus/idle-states/cluster-nonretentive-1: failed to match any schema with compatible: ['riscv,idle-state']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1539173

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

