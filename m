Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE0637F1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIOb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 10:31:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40636 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 10:31:57 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so35368390iom.7;
        Tue, 09 Jul 2019 07:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u2Bhzhxh3FEszzLNG7jCV0i48QmfCa45j1OtQVUeCY4=;
        b=ieE2prkRzyJZeS/dogNfdIPKkzeMx3nD6lJCPAUovN1em7z0sN8hWUfy6CHrUxyx7t
         ZSFwfCwAwKe/QWtb+zzJKegLHadxsvW56/881y+6C+liw2463+nTY4AwNrcxIOEhh1Ic
         6xq8ovWob7oiyymTpotuvFYL2qaBihQuAWeo7pIIWul9CLNTowZwsYVxCWVNAKsEExo/
         l1QIgojy0dm3WI8HtDvlkSkYwzIgMl8Fro9KdziFBVwr12hsR4OD03UL1A8ctrP3WLbo
         qiSjZ0MTPtGB07bPqwlfsVXdmOCuM2fLZO27AE0Uc/xekDXW2/JYJfi+pA8+jcp833Iy
         2xyA==
X-Gm-Message-State: APjAAAVQrPChYQp+0rzLySyiGwsuMWveYvmEKskq0yniAfoZgHNMFgGp
        EE7jGOB7JXcgg3mlyOM6UA==
X-Google-Smtp-Source: APXvYqz6A9Rq1TzdM0KoNY1rhrBGz4Dyqy8mBPpR0tkcaRVUCsVwOskSgLSeBkQcP4skCS0dni35Cg==
X-Received: by 2002:a02:a595:: with SMTP id b21mr6298813jam.28.1562682716084;
        Tue, 09 Jul 2019 07:31:56 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z26sm22721257ioi.85.2019.07.09.07.31.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:31:55 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:31:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [RESEND, PATCH v4 2/2] dt-bindings: cpufreq: Document
 allwinner,sun50i-h6-operating-points
Message-ID: <20190709143153.GA30638@bogus>
References: <20190612162816.31713-1-tiny.windzz@gmail.com>
 <20190612162816.31713-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612162816.31713-3-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 12 Jun 2019 12:28:16 -0400, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "allwinner,sun50i-h6-operating-points" DT extends the
> "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
>                         HW:             <name>:
>                         sun50i-h6      speed0 speed1 speed2
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
