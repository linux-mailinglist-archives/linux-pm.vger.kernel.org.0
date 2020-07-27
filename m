Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84322E76C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0IPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:15:21 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:39615 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgG0IPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:15:21 -0400
Received: by mail-ej1-f66.google.com with SMTP id gg18so12745100ejb.6;
        Mon, 27 Jul 2020 01:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKQiyF7wLr9Rnqu8Rf8+oL92y9RtB2jN0p/kFR1Ehks=;
        b=Od3Kqs2Rttdm5gcBa/hgTXqRovKI3jb8uCWm+DGSBqwGvFvCyy/p4O2JkzxYXMCBcc
         1fo7Flq48HL1SO3sCio2yjmx7C/rH5Scsr3QgnprY53vxz7lsGzO4RaO/lucW+a5Ee+o
         sdXVe3V015DGOcYL8xvM1BkfmVAiLavKWLzaL1M+Ve81PiPTcmTRBo0j4XWcSbrbSYI7
         XGuPmYfx/ewRJ/EZeldBagy6s99oF0O8t0IS67NbL0bjGhlmGNry0bydkozt3xSYHvoj
         RYejiDLVUl2Qo1y76aE8Hi1QjW0PeupjRzJZWRW+HYqzGMRwl6Qsq0whmxwWotCtAzCl
         7eNQ==
X-Gm-Message-State: AOAM531Hzp3lHWjcigf2b6P13P88z/RHb9vEU5iCPsk1hIXIbzlwkffZ
        hu8Ghj5UnOvXorJv+ugAF2A=
X-Google-Smtp-Source: ABdhPJx8D9Kesqr7JHVE4yKzTTMA8zdBjVGQ5SWM1D1U3CV6/UZk0ukM7JrpH/DuIChsJlASyCbpSw==
X-Received: by 2002:a17:906:d102:: with SMTP id b2mr7039452ejz.465.1595837717998;
        Mon, 27 Jul 2020 01:15:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id u2sm7061686edq.29.2020.07.27.01.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:15:17 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:15:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/16] memory: omap-gpmc: Fix language typo
Message-ID: <20200727081514.GB17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-10-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:21PM +0200, Krzysztof Kozlowski wrote:
> Fix arbitary -> arbitrary.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
