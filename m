Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC861AA5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfGHG2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGHG2b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 02:28:31 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2F720665;
        Mon,  8 Jul 2019 06:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562567310;
        bh=rInPTPztr2BPtAN+aFI5s81wVhWXnvdfd1O17+t/5iE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/R/7OeSC2RJmVZ3ggKW/JS4R1yA6aqfCBTZHifbiUV4WayZf5KA2k4UMKcg6AAbK
         6JQOkE2YpAzq+/A+aL0ZKZWNZ7BrXP/orwrx5uUucDbmaB/2DH36oIUwxBdfU4rnta
         VVd17QVPqlAfMhn3mZbPQPgn6FRAi5JZ5g4ff+k0=
Received: by mail-vs1-f42.google.com with SMTP id v129so7472118vsb.11;
        Sun, 07 Jul 2019 23:28:30 -0700 (PDT)
X-Gm-Message-State: APjAAAUNtsRMTbjg/yL4jiaoNymgkIQRv74C7kMuUQYVyLPUhiF2w+Fe
        bh2tY/rna5TTw9Xa55xn6JfgEhrzUEChMoRGTis=
X-Google-Smtp-Source: APXvYqxvnoaXS13457JjbZkwe3cSzldejWEO5FGoKFTSmDPBAoQNix/FtzGFc/YEJQj0RLMchH47g/LG1NMbRHdwIPY=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9639834vsj.203.1562567309540;
 Sun, 07 Jul 2019 23:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095726.21433-1-niklas.cassel@linaro.org> <20190705095726.21433-2-niklas.cassel@linaro.org>
In-Reply-To: <20190705095726.21433-2-niklas.cassel@linaro.org>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Mon, 8 Jul 2019 09:28:18 +0300
X-Gmail-Original-Message-ID: <CA+5LGR1-WqtrjbL9VLATuuEyxSDEhh9VZ0cLDmZnFoHdXd43Nw@mail.gmail.com>
Message-ID: <CA+5LGR1-WqtrjbL9VLATuuEyxSDEhh9VZ0cLDmZnFoHdXd43Nw@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: cpufreq: Re-organise kryo cpufreq to
 use it for other nvmem based qcom socs
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Ilia Lin <ilia.lin@kernel.org>

On Fri, Jul 5, 2019 at 12:57 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> From: Sricharan R <sricharan@codeaurora.org>
>
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [niklas.cassel@linaro.org: split dt-binding into a separate patch and
> do not rename the compatible string.]
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Changes since RFC:
> -Made DT bindings a separate patch.
> -Keep the original compatible string, since renaming it breaks DT
> backwards compatibility.
>
>  .../opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (98%)
>
> diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> similarity index 98%
> rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index c2127b96805a..198441e80ba8 100644
> --- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -1,13 +1,13 @@
> -Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
> +Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
>  ===================================
>
> -In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> -that have KRYO processors, the CPU ferequencies subset and voltage value
> -of each OPP varies based on the silicon variant in use.
> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> +the CPU frequencies subset and voltage value of each OPP varies based on
> +the silicon variant in use.
>  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>  defines the voltage and frequency value based on the msm-id in SMEM
>  and speedbin blown in the efuse combination.
> -The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> +The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
>  to provide the OPP framework with required information (existing HW bitmap).
>  This is used to determine the voltage and frequency value for each OPP of
>  operating-points-v2 table when it is parsed by the OPP framework.
> --
> 2.21.0
>
