Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1633DB8C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhCPRyu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 13:54:50 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:40269 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhCPRy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 13:54:27 -0400
Received: by mail-il1-f170.google.com with SMTP id e7so13504492ile.7;
        Tue, 16 Mar 2021 10:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NkQ5GgQFc/YoK/N0gznOcS3i3bnLKgQpSfAaOAQnpB4=;
        b=BZ031cnFeprxf0iLfTavP6bX/zzd2cWyDPxosdnWpvwwKV6EjdSTi03UNVWltwx0Zs
         WpVKkZoO4u8phQWDGdMvIwL6tmLeiJy8hEnRHmp9W2mWjfCx0WV0UuLFBHBXkjGvUb+W
         a4PVzp1ocOB6XS+ZIMN0N57fvoReDNeme0J+awvgTv25h07m5105rHJxBQVyoI4A2IrK
         ta1x0d3rfNH1JKYNag5wuPNwFruUkc2fKok2SmSamsgZW7JtJ4OnC6OjJhaRUoZvFAl5
         dkk/9eGq+yAhunhgBnxBlgVsA+9svyIQPlF3bj7JPLlNn+TZ3IO1Ene47nDnTf/dYAPB
         tHWA==
X-Gm-Message-State: AOAM532syBMiHnRDVOpQkw2j91G3ikAoP33pXRayhsAgXNK+WCoolM2z
        czYUNR7ni2MzWhUrI5rVRA==
X-Google-Smtp-Source: ABdhPJxS4LuvnNP7YIuCN0rhDra5QwrIwy0id/fLjLEHv7cot0FBcyYEg1H97tD9x5837opgVLDrPw==
X-Received: by 2002:a05:6e02:1d98:: with SMTP id h24mr5059134ila.88.1615917265039;
        Tue, 16 Mar 2021 10:54:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k12sm9424772ilo.8.2021.03.16.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:54:24 -0700 (PDT)
Received: (nullmailer pid 3326125 invoked by uid 1000);
        Tue, 16 Mar 2021 17:54:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     linux-pm@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liush <liush@allwinnertech.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210316104140.878019-8-anup.patel@wdc.com>
References: <20210316104140.878019-1-anup.patel@wdc.com> <20210316104140.878019-8-anup.patel@wdc.com>
Subject: Re: [RFC PATCH v2 7/8] dt-bindings: Add bindings documentation for RISC-V idle states
Date:   Tue, 16 Mar 2021 11:54:09 -0600
Message-Id: <1615917249.246376.3326124.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 16 Mar 2021 16:11:39 +0530, Anup Patel wrote:
> The RISC-V CPU idle states will be described in DT under the
> /cpus/idle-states DT node. This patch adds the bindings documentation
> for riscv-idle-states DT nodes and idle state DT nodes under it.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  .../bindings/riscv/idle-states.yaml           | 256 ++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cpu-retentive-0-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cpu-nonretentive-0-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cluster-retentive-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cluster-nonretentive-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cpu-retentive-1-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cpu-nonretentive-1-0:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cluster-retentive-1:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.example.dt.yaml: idle-states: cluster-nonretentive-1:compatible:0: 'arm,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-retention-0-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-retention-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-sleep-0-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-sleep-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-retention-1-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-retention-1:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-sleep-1-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-sleep-1:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: 'entry-method' does not match any of the regexes: '^(cpu|cluster)-', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-sleep-0-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-sleep-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cpu-sleep-1-0:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/idle-states.example.dt.yaml: idle-states: cluster-sleep-1:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/psci.example.dt.yaml: idle-states: cpu-power-down:compatible:0: 'riscv,idle-state' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/idle-states.yaml

See https://patchwork.ozlabs.org/patch/1453810

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

