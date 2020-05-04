Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988D51C34AC
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgEDIlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDIlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:41:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED441C061A0F
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 01:41:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so7475498wmb.4
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rdKfUixg+LFJTHTqa3PKVQKFg2zE6dmw0jAFtbyDiJs=;
        b=cuE/heKyV2d9ekz/X1fkSMMjTWPNktpggUVzdJv+nB7SMSBq72NvnZD3loKleyt3JG
         0P2mYHHN6zFmsP+QXGb5nqniv0ZXYdnqiwp8/K+Mug4RsxZDJL5DJVxfwFLJcOOSRWl/
         /srF7G0CCANdF1H93uVJUpcjCwddGNbEo5tcCnIbPzD1ikev6EpbmdS2mXp/wc6YWcln
         JoMUeoN3NeoONglJsk5jm52BtXYlBpy0kDEmhkLO92rKJ2PJX9QrGXBs7n6ZeHS+ZTtc
         EHmF6aE7wx0J9YIycTfP58cYXeIuprler0n2U5a22XpOJmpFszZdqLG3LOSUfgsQhRFN
         AN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rdKfUixg+LFJTHTqa3PKVQKFg2zE6dmw0jAFtbyDiJs=;
        b=dqD3htDZvSZ5ghWblA/YGE0eFrH1FBXTAiWeRrSFw+FitMe3xK+b7Wcsy4SYoYhjY1
         tsz7v1BGfHjna96i7atvGAhq25jGzefJ0zV184zaD4Kd6a0hss0KXHgrjMKT/AjozJtJ
         I4nepq6IVZs+7AahuuOTUbuSQ/sRaye3v2Ep5eK1iHOjId+zDrFV8/5TmMay/uvy6huF
         /x+q4aU3cpwdm05j3J6DVbLgn+3jStG2DIeJF4KuJBPeiJhs3Lr+0QxUumCfsizOIcjH
         F8xx4TwWVEMZhc+iizLk6QulTrre7aQpq4PAtlY0Q5wjWEPRnZyEZRlsWCj7MXepYXql
         8CPg==
X-Gm-Message-State: AGi0PubztlqfgEqoZvMvOl65TNxMclvRUKt+1L6IT+w6NEdItSZFZlhA
        2GywqD1US21NeDCSLPC0h+tfvg==
X-Google-Smtp-Source: APiQypKhwDFaWmJEH4+kHc2vkBxBnKCa5KZa7Nrb1CWhdshEHOGTiaGxzTmqYFf7L/kOuzvdDyADdw==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr14003209wmm.142.1588581680717;
        Mon, 04 May 2020 01:41:20 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id t2sm12400815wmt.15.2020.05.04.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 01:41:20 -0700 (PDT)
Date:   Mon, 4 May 2020 09:41:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 10/16] mfd: vexpress-sysreg: Use devres API variants
Message-ID: <20200504084118.GF298816@dell>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-11-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020, Rob Herring wrote:

> Use the managed devm_gpiochip_add_data() and devm_mfd_add_devices()
> instead of their unmanaged counterparts. With this, no .remove() hook is
> needed for driver unbind.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/vexpress-sysreg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
