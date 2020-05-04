Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1E1C34B0
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEDIlv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDIlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:41:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1ADC061A0F
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 01:41:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so9572265wrt.9
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VM7VC+aZxRIIjdCBOQHvIXwbqHzjf4bIXyafLz2UVVw=;
        b=RjPsBETLO2dNrY+Auu4dgqM9exSWQtO1FAqtcTqCzyYkoPRMr7xdWcL+GI9NST02AK
         cHSoATJXpm5e2y7/QNadZUhNWuhOInhSkxjieQ4bSX4Q4RxHtHA6/lNm2CkXcYDqkXLO
         RdP/Y0rQNGRM0dZdAGhIE6nw9MwzIH3+9Vx6gSZ81yiYIH+Yt/uJyqUBDMZlj6L8Wd6G
         zP1h5xerEBmVd69CDoZuYIpgmk5v4ydnGCJq6IyN/2nWBAqEWOooWzQZ+Vj4EnBK8LZN
         fN+KqzuMSVNh1hMxU7Gw5NMEJNE0Nm1vEE0dOIUN91boAbqODzPziN0ZvFsd1jARsv61
         3KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VM7VC+aZxRIIjdCBOQHvIXwbqHzjf4bIXyafLz2UVVw=;
        b=HapExgcprZHl6nk6s9yr040mHyHOrzNguhtVmZzreNg2vuX1HhUAgCAwz+pK4eY00d
         uL2blBkPn7X34NoDovt6Zgrd5JmxSbxdPBauH1jBDi98c8CtvIiTbbUezKNf7Aj3vuZf
         CVymu7hTEGlGdRD4ltGGZK81qdide/HuayCGqq/bG08U2uE341mDOIaQFr8vSOVQTQZr
         s74aKFTqNsvMuG5W/kYZR8X/ueXn9T5VeD9NEFEe8XarKVFBWXZ7MHMPlb00YCwidTZs
         p1li1B4V/fSOfC1P4jDDzEOYQMAxHTDeHtJScsngLHeWqKZd50BKJ0Y+pRVQ/jpayTQw
         n7Rw==
X-Gm-Message-State: AGi0PuaSguZs/UmQtMhCNlfzVqDQ0I8WR3Z/LMs9pfjDVbQ/PT6kVsy8
        ie7TixbsP5aoM89/T6fFdIQshg==
X-Google-Smtp-Source: APiQypI+t6WMQSWVXziEfHyZzUtFtpAZcKAwAAx++OmvHlF7x5SKQ4lqJsjgLXdlYVbLIoovy6n+dw==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr19482111wrq.342.1588581709480;
        Mon, 04 May 2020 01:41:49 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id q14sm6560533wrc.66.2020.05.04.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 01:41:48 -0700 (PDT)
Date:   Mon, 4 May 2020 09:41:47 +0100
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
Subject: Re: [PATCH v2 09/16] mfd: vexpress-sysreg: Drop unused syscon child
 devices
Message-ID: <20200504084147.GG298816@dell>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-10-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020, Rob Herring wrote:

> The "sys_id", "sys_misc" and "sys_procid" devices don't have a user
> anywhere in the tree and do nothing more than create a syscon regmap for
> a single register or 2. That's an overkill for creating child devices.
> Let's just remove them.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that the other GPIO child devices could probably be removed and
> added to the bgpio driver. Unfortunately, the model dts files were
> never updated 6 years ago. Not sure if the models really need LEDs...
> 
> v2:
>  - Add missing commmit message
> ---
>  drivers/mfd/vexpress-sysreg.c | 36 -----------------------------------
>  1 file changed, 36 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
