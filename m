Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476D9114774
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfLETIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 14:08:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44281 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLETIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 14:08:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so3548152oto.11;
        Thu, 05 Dec 2019 11:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GhI01COZ1PM4IuNCQYroNt43ak9q+ZJEl+5PK/vzrwc=;
        b=Cpxk46pnI8ZCtT+1E/uZ9TbR/h1P8SsJPaKYiye7X/GQYWLPdjqvaz+oMhdikno/iS
         FYrOI5mmb91YVoXZdVKnL55dVZVohuamF3PwGekZEuLfwbpQ2C4Up8C2Ggj+N4pat8rx
         5uRz/YjEjnxrJw5lLbFuy636O9pvWMbuVXeBACKUjzort/4Uaml0fbFwaj8tjlcNJa+/
         WhcfIFRGLgIO/tXMDp6f8FkRV+D5rJq1U4FFLyZOoLDFsvE3OJ5+xpzW9e+pxP/nMXms
         vKwKedlnpTE+7BU60076cBgCR2IVy7lmRaMZqQXLeo3dHNChCy3pHypV0c0U4jTSxxGF
         JTHQ==
X-Gm-Message-State: APjAAAUr830AiXyS3XHnFbyM+/j5hENZ/YJJyoJqr8sYPLZYyt52REHA
        lbNaU8VTe2dn7NTuiwHzKQ==
X-Google-Smtp-Source: APXvYqyrDf3SjBOgDwQzOa4/THONdCOmBohqUk4Y5DGydGiSs0Q8JEOerKtxomNcothMl7/fKTTrlA==
X-Received: by 2002:a9d:7357:: with SMTP id l23mr7568607otk.10.1575572903777;
        Thu, 05 Dec 2019 11:08:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w8sm2157401ote.80.2019.12.05.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 11:08:22 -0800 (PST)
Date:   Thu, 5 Dec 2019 13:08:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     freddy.hsin@mediatek.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, matthias.bgg@gmail.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Chang-An.Chen@mediatek.com,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 4/4] dt-binding: power: reset: Add documentation for
 MTK RGU (Reset Gernation Unit) reboot driver
Message-ID: <20191205190821.GA25233@bogus>
References: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
 <1574746490-625-5-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574746490-625-5-git-send-email-freddy.hsin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 26, 2019 at 01:34:50PM +0800, freddy.hsin@mediatek.com wrote:
> From: Freddy Hsin <freddy.hsin@mediatek.com>
> 
> Add documentation for MTK RGU (Reset Generation Unit) reboot driver.
> 
> Signed-off-by: Freddy Hsin <freddy.hsin@mediatek.com>
> ---
>  .../devicetree/bindings/power/reset/mtk-reboot.txt |   30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mtk-reboot.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/mtk-reboot.txt b/Documentation/devicetree/bindings/power/reset/mtk-reboot.txt
> new file mode 100644
> index 0000000..708d351
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/mtk-reboot.txt
> @@ -0,0 +1,30 @@
> +Generic MTK RGU mapped register reset driver
> +
> +This is a reset driver using toprgu to map its non-volatile register.
> +The reset is generally performed with a write to the non-volatile register
> +defined by the register map pointed by toprgu reference plus the offset
> +with the mask defined in the reboot-mode node.
> +
> +Required properties:
> +- compatible: should contain "toprgu-reboot-mode"

What's wrong with syscon-reboot-mode?

> +- regmap: this is phandle to the register map node

Make this node a child node of the phandle and get rid of this.

> +- offset: offset in the register map for the reboot-mode register (in bytes)
> +- mask: the reset value written to the reboot register (32 bit access)
> +
> +Examples:
> +	reboot-mode {
> +	   compatible = "toprgu-reboot-mode";
> +	   regmap = <&toprgu>;
> +	   offset = <0x24>;
> +	   mask = <0xF>;
> +	};
> +
> +Optional properties - reboot mode value that will keep in toprgu nonrst RG:
> +- mode-charger = <BOOT_CHARGER>;
> +- mode-recovery = <BOOT_RECOVERY>;
> +- mode-bootloader = <BOOT_BOOTLOADER>;
> +- mode-dm-verity-dev-corrupt = <BOOT_DM_VERITY>;
> +- mode-kpoc = <BOOT_KPOC>;
> +- mode-ddr-reserve = <BOOT_DDR_RSVD>;
> +- mode-meta = <BOOT_META>;
> +- mode-rpmbpk = <BOOT_RPMBPK>;
> -- 
> 1.7.9.5
