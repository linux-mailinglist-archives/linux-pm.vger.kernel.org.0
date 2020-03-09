Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8392917D99F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCIHMb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 03:12:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43782 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCIHMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 03:12:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so9592286wrf.10
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2020 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jx5Fj/KqKcbpxqyibs51BThSAgjts5OPNkpxf24XLEw=;
        b=tR8cA0V6wn3IXu7I5PIZbj2+RF0mwRgQrGHbYq2MPnA2DeBAeU3Vi0+83xqTsrIsTM
         n+V2qGUg6b2Rp3XceJES5C57ra7qrzdmlyIeTQG7Ud2SH6JUuiXb5Vg9twxkeRAMG5+4
         9e9zU3IEUWN3W26ywuTVjRnfUGLDPYmKQbaTQMiDFvoiXOegtNxGZh8zk3fbHJjg8vbB
         Oic0kHkQWmKs7iZ0KGG39oyV+z/9FYk4FPevarfIDonaVx/kIeihO79lV17w7Y3R7Kje
         vTa/yBL+iuR6landd8ZhZAcZqlngtHG2dKPBFfF3eZK2rCWIJdELf3iz4jtS8RTh5RV3
         gvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jx5Fj/KqKcbpxqyibs51BThSAgjts5OPNkpxf24XLEw=;
        b=fPDoZgKomSOlw9ZER6V45UGpAUvVDI3IChApPVaSDoXVgbM1/3GLptZRkmQla6a3w1
         oEUUEtP5G7JSozTc859xHX5Vbc/UsG/ySCn4WySTr6xy3ri3AIhVAwz7MqWgLc5BfYIr
         lo8Nt+OwqQ30gTEQPGfeW0w+ktGcxeufp4xY3d6AmNhsaTacdaYCVTG4cB3Mkn3dE10a
         XfjX2byHffKmE2RKpg070AiWh/X24SjDGm/8UGws/14PZTDyZOHR90qNupBxTyi9C+lt
         drGNjlFMtXR8iBYV39Xjy5cTepBoFbeicMDKAhKkEGc0jmiPCgLVQ5UcxBwmJfz8GcOv
         BaiA==
X-Gm-Message-State: ANhLgQ2KDTRdLgAtXJPTUB9iyLqJdHClEtjd24Ubo+bBcvQiihnV113g
        ZgB4yJWvY8vSIrYIAAm6DfcKdg==
X-Google-Smtp-Source: ADFU+vv1KN/TNTl8uwEObqOb9eEUvKbajXYeZlnfMBRzAHZjYnEsQAJAA/ali0fp45ZhYJTwLDz3/w==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr12156640wrr.396.1583737949449;
        Mon, 09 Mar 2020 00:12:29 -0700 (PDT)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id b6sm2157961wrv.43.2020.03.09.00.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:12:28 -0700 (PDT)
Date:   Mon, 9 Mar 2020 07:13:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] syscon: Alter syscon and reboot-mode drivers
Message-ID: <20200309071313.GA3200@dell>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:

> From: Serge Semin <fancer.lancer@gmail.com>
> 
> A lot of custom functionality can be tuned by means of a syscon-registers
> placed in Baikal-T1 CCU memory space (though in documentation they are
> called system devices registers). While in most of the case the syscon
> registers usage will be distributed between corresponding subsystem drivers
> (thanks to pretty much coherent design of the registers fields), there are
> some peculiarities we should reflect in the generic syscon code.
> 
> First of all seeing there is an map endiannes config acceptable by the syscon
> it would be justified to add the corresponding properties declared in the
> mfd/syscon.yaml bindings file. Don't really know why this hasn't been done
> before.
> 
> Then as it's going to be general in the framework of the Baikal-T1 SoC support
> integration into the kernel, we suggest to replace the legacy text-based
> syscon-reboot-mode dts-bindings file with yaml-based one.
> 
> Finally seeing the syscon-reboot-mode devices are mostly used in conjuction
> with just syscon-reboot device (in particular Baikal-T1 CCU WDT RCR register is
> preserved during any type of reboots) and for several other reasons (see the
> commit message for details), we suggest to add the 'regmap' property support
> to the syscon-reboot-mode driver. This would eliminate the requirement of
> placing the syscon-reboot-mode dts-node in the syscon sub-nodes area.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (4):
>   dt-bindings: syscon: Add syscon endian properties support
>   dt-bindings: power: reset: Replace SYSCON reboot-mode legacy bindings
>     with YAML-based one
>   dt-bindings: power: reset: Add regmap support to the SYSCON
>     reboot-mode bindings
>   power: reset: syscon-reboot-mode: Add regmap dts-property support
> 
>  .../devicetree/bindings/mfd/syscon.yaml       | 14 +++++
>  .../power/reset/syscon-reboot-mode.txt        | 35 -----------
>  .../power/reset/syscon-reboot-mode.yaml       | 58 +++++++++++++++++++
>  drivers/power/reset/syscon-reboot-mode.c      | 11 +++-
>  4 files changed, 80 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml

Please re-send this patch --threaded.

As it stands, it's been scattered to the 4 winds throughout my inbox.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
