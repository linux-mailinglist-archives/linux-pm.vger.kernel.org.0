Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76531130EB2
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 09:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAFIfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 03:35:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46304 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAFIfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 03:35:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so48606733wrl.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 00:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e0KhA/fnqWm6T6Fd1y/ycOP88g1CHs2BTbMCEvSy12Q=;
        b=RbQpLY0JPaeobLbCh36bLbDuItz1p7hIAmNT2oGDYKGS1mgu5Kj3oPlu4mgWSw9v3V
         RRnqMhQkSAZP8VJnl+HJQ2j/nICCe/2u6Jr9uMeBWnZHi0CKpHrVnJH3X1AieSxarvfY
         RMfKwTlVQBKqPcnTAAPuR32zi4ywOv2KxET3xVXJreV42QVohvmVFFev/y7javZBTZyT
         6e7rf8ctUiAhzrJjeFAycyuba+GTeIXAcc8poGc+sxGZq0JGpeHMzvjAD0UcAdgMsbvL
         dk/9SaRwbZjFAIoiFJKp/voDRjXhW2OCJlDenxb0AT1RW+hmZFk7a8vUi4GZNQubEfVq
         iCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e0KhA/fnqWm6T6Fd1y/ycOP88g1CHs2BTbMCEvSy12Q=;
        b=Pantl4S6MBbew/sgejLm0iAzsINIV4PnGBoLsyP8Cn927pYwSNanjph8LfZluog+Ep
         fvmPTWrJMxKZ3NDdRps/qEz+Yz96ZT3gciYtukR7BWSZvj25IGS2Hp4mcm4e0ZXB1fJA
         sqJ8IUh46A0Ui6XE2lcOHfYfABWTTgToBaQowj+qSon5iDHHeMeXZtexozDs2V572H1y
         cbHaPf7Wjr/55PrxOtLc1gP1xw31iwQrseceIGgqmeW/aEJBdEikDkEOzFvsIcCrv6L3
         xWCqoOxeZFOWlHIbqjogKJ0hTBSAP/642BIC/Vvx4XK+InGQp2m8ceUqZ7FAFDqwvUzI
         M4iw==
X-Gm-Message-State: APjAAAW4B1YhtXLentY5LlbvQCHL9BAiudzTl1TBqFb24v0hEy8hSpQL
        AtbETWoj2xgAC5eAUl1SI/x56A==
X-Google-Smtp-Source: APXvYqyIiOs7jWQLCFZMnVa3AtUvwaffIrFpTMgoZ+P25QYJI9FKcD+DBcRlTB3YcQs0DsS/7Kd9WQ==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr67762298wrs.303.1578299749170;
        Mon, 06 Jan 2020 00:35:49 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id m3sm70800908wrs.53.2020.01.06.00.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:35:48 -0800 (PST)
Date:   Mon, 6 Jan 2020 08:36:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as
 volatile
Message-ID: <20200106083603.GK22390@dell>
References: <20200105012416.23296-1-samuel@sholland.org>
 <20200105012416.23296-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200105012416.23296-2-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 04 Jan 2020, Samuel Holland wrote:

> On AXP288 and newer PMICs, bit 7 of AXP20X_VBUS_IPSOUT_MGMT can be set
> to prevent using the VBUS input. However, when the VBUS unplugged and
> plugged back in, the bit automatically resets to zero.
> 
> We need to set the register as volatile to prevent regmap from caching
> that bit. Otherwise, regcache will think the bit is already set and not
> write the register.
> 
> Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
