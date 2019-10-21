Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E9DE20F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJUC0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:26:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38447 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfJUC0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:26:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so7408603pfe.5
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pr/rGG/mLq+ux0BA0oJ5xhvPVmVJKmTBUD+kYnaEMFQ=;
        b=XO0Y/0vRrT7a9yj8g9FT7WxMhv05CQmhcrosoxKyj55Lbbc3uF96jpPLNSaujXBnTh
         ajuMLiCmzFzIWhcP5AMqAaGDsXxFAbbsXB5gu3WM6X1uVjfPpYS7tf2GNN1JliW3E+o0
         fgK0IKdGlEUGfqRfFZ43pQntnf2HvIV3A0Ju5n3izY6orU9MfRnzZcT8WUJRuRcGXwSE
         S5VkGTfvUKJtnkDwSwNB3cpQnanNtdn6MAJiYAttX/2aERLwpINJinISMcUnf1blTKpK
         dS0vOkiIJk1gmv9bjWHF7WhlWhR8o78h+2DMZt+P1c7+mNTfNJ4UNoPre3O2ZVVMpF+G
         9wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pr/rGG/mLq+ux0BA0oJ5xhvPVmVJKmTBUD+kYnaEMFQ=;
        b=SzCeiB7EWY8aapdAYFjEIcXKGXlFueUQzM88woFMBrQPHfboJatoA+ASV4JpKWOZNn
         VFKxjWCDCRspsyCBhnatxrUgQbT0s+LGO6hmE5g6/1YPPCvQuIDnSnfAFLJmyAgvJSan
         0KK2cUgUbG/g1CWsaGVtIC8aYzfAPF3iAqqucgDxmgCmA0Cc36nYwzNGL7vLSDi1BYn9
         0egCKnuju/d6+dGVADQZfO3hDDFWZP/ooX0UJa+27J18sGnWPaieez1RduRPzh1mo5PS
         SgwUI3jkC8feIWu2gL/s5dGQCEZDs0qZq36YWj/PiH60QH+sm5N0YFBVgDcKOa0T4osZ
         7LLA==
X-Gm-Message-State: APjAAAWBLX6gYTD7fK5K9wgC+ElDEB2IJ7LUwF1R3r9qHOoJYiPRgDm+
        PArne0YkOs2mG3fp1cL4Rxu2oA==
X-Google-Smtp-Source: APXvYqzds7k29oQ4eyX6PpIwq/UPWGsW2c53kCK0M4hNt/TssOTMKgAXPae6bLblBUYndtzyEcCYgg==
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr26640303pjr.56.1571624775229;
        Sun, 20 Oct 2019 19:26:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id v4sm13698783pff.181.2019.10.20.19.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:26:14 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:56:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 34/46] ARM: pxa: remove get_clk_frequency_khz()
Message-ID: <20191021022612.ckfqbhsulbuetomd@vireshk-i7>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-34-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-34-arnd@arndb.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 17:41, Arnd Bergmann wrote:
> get_clk_frequency_khz() is not a proper name for a global function,
> and there is only one caller.
> 
> Convert viper to use the properly namespaced
> pxa25x_get_clk_frequency_khz() and remove the other references.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/generic.c      | 15 ---------------
>  arch/arm/mach-pxa/generic.h      |  1 -
>  arch/arm/mach-pxa/viper.c        |  2 +-
>  drivers/cpufreq/pxa2xx-cpufreq.c |  2 --
>  4 files changed, 1 insertion(+), 19 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
