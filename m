Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD912D301
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 18:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfL3R4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 12:56:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42736 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL3R4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 12:56:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so33348544edv.9;
        Mon, 30 Dec 2019 09:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cygsGGkDeAamm3MSoLJvChT4FcSCrOxKMla51D5XTzY=;
        b=tVeuRdZrCIptfzw3WcX2rRdUxRAck68OTLCNCYLe3mbRlQh8PJUANubP7iepiyet7w
         rvvFoRnLOyM3To5Y/qYBNpU375UCslR36yaTQngLGOz8O8iXUIQiyglP8SEcOE5K5pXb
         41WK8U3+HD76HTjhuxA/L7XJ1+csRjkdn0M4DCxDnlrv5EOH/2vhoXUhwiafQtuud+M4
         ggTm2bkK5n3gYa7o3v7kQMw6pg2I8XPCmUDn1NTVhS5ZQ5KBs63zjuNUDWErsdzQwJuC
         r4nLaNAWANpNt8V5mmUPee1B8Mta2udrWG9DBC9N+fJ5HzPSAx52Rby6bQCqFBDT/KFs
         h1NQ==
X-Gm-Message-State: APjAAAV2E9oFtfhpZW9utsMVCH7A38UX7E/Form251TTJU2mWLAs7Bju
        M5KOYxOLj8glKDDOzZ3ZxT0=
X-Google-Smtp-Source: APXvYqzr5OU0/SLj/QhAWD0LTF1mLjy+UZqJa/pEeT9a7+Demos5yAW/kVgxn9NAx+dQPM1xMT5+uQ==
X-Received: by 2002:a17:906:a84a:: with SMTP id dx10mr70871987ejb.61.1577728603531;
        Mon, 30 Dec 2019 09:56:43 -0800 (PST)
Received: from kozik-lap ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id m5sm5423715ede.10.2019.12.30.09.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 09:56:42 -0800 (PST)
Date:   Mon, 30 Dec 2019 18:56:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com,
        rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com,
        kgene@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com,
        jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com,
        digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org,
        alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 7/9] memory: samsung: exynos5422-dmc: convert to
 devm_platform_ioremap_resource
Message-ID: <20191230175640.GA29380@kozik-lap>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
 <20191222185034.4665-7-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191222185034.4665-7-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 22, 2019 at 06:50:32PM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 7 ++-----

Thanks, applied.

Best regards,
Krzysztof

