Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93E761AA8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfGHG3H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGHG3H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 02:29:07 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44CE2086C;
        Mon,  8 Jul 2019 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562567346;
        bh=EzqBarqXMG3p46ZjfY0jADqQdj2XPJC8JYCsA8yVVSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F5M+QCqKjFW9AflXQMP3q35X2uuPfpHRrPvJWVdmnidBDNtTKcFC55JoM39gMM1EC
         3XZ9NZ3ampyRu+4XoIHeDnV/AHXOpHEI8TC8c+Mbg5FotzV032G23wkJF8yjtri2dS
         TMhm8AA8i80B/2rlfOOlT/u589RqE+Q5KTnhME24=
Received: by mail-vk1-f176.google.com with SMTP id 9so2248530vkw.4;
        Sun, 07 Jul 2019 23:29:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUhTPRUW8VPgn4EDzd5dH3Dw5cCseP88mErX5lkz0B4pwfF00uz
        a+zbFRgL0F0xvd1WALDEvD7qYNgRMZyEdAIlJc8=
X-Google-Smtp-Source: APXvYqxWAG0+J5N0ThHvVieSBsPay2Xds7HBRZJ0+DH6Ad7PpioxeHLxZQ19X31Qax1cNtdIcRPUaQL3cKwqq5USrWE=
X-Received: by 2002:a1f:dec7:: with SMTP id v190mr979385vkg.39.1562567345067;
 Sun, 07 Jul 2019 23:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095726.21433-1-niklas.cassel@linaro.org> <20190705095726.21433-4-niklas.cassel@linaro.org>
In-Reply-To: <20190705095726.21433-4-niklas.cassel@linaro.org>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Mon, 8 Jul 2019 09:28:53 +0300
X-Gmail-Original-Message-ID: <CA+5LGR22k7cshDiiM=nv4BUtZko8JLoW3-ZjYgsdPkcedstDtQ@mail.gmail.com>
Message-ID: <CA+5LGR22k7cshDiiM=nv4BUtZko8JLoW3-ZjYgsdPkcedstDtQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] dt-bindings: cpufreq: qcom-nvmem: Make speedbin
 related properties optional
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Ilia Lin <ilia.lin@kernel.org>

On Fri, Jul 5, 2019 at 12:58 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> Not all Qualcomm platforms need to care about the speedbin efuse,
> nor the value blown into the speedbin efuse.
> Therefore, make the nvmem-cells and opp-supported-hw properties
> optional.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index 198441e80ba8..c5ea8b90e35d 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -20,6 +20,10 @@ In 'cpus' nodes:
>  In 'operating-points-v2' table:
>  - compatible: Should be
>         - 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +
> +Optional properties:
> +--------------------
> +In 'operating-points-v2' table:
>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>                 efuse registers that has information about the
>                 speedbin that is used to select the right frequency/voltage
> --
> 2.21.0
>
