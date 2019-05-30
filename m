Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525B72FAA0
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE3LEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 07:04:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46199 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfE3LEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 07:04:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so1796646pgr.13
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2019 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S/cb0m9xHhDHoKqKMiFimQZjtq/GGyzkBYH+5P+CN/0=;
        b=zs+87dXY2uJHWUUk2UltFW9vWu7zXdUEpIxMKXcJPx8VZByqt6q5b8MmoQqAiPBIs0
         rbhatuc4l5So1hpFoZOObOs+vi3UzRzxLYi8EZ98U+3THxPaAGcpEGyfNVZSJL4LPKHJ
         KusupP2XA6wpIcYHn2evj4cWgrFh2GDjPpQNPwNn2cjECO2MkLAMRWej5ICmCRiowIGh
         VrSlwUfeUy0Fi4/oBaS5iHv9Mt5jgI1duviHzObo/RhV8t/0U1OWEno2LskN1A3wWthg
         ZfL8/Ic/lST3aXrc4TJ0MEPLD/L6TtCmHJHEydra4VrBEeC9CpaPSkQfsxvUXv81Crme
         Dwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/cb0m9xHhDHoKqKMiFimQZjtq/GGyzkBYH+5P+CN/0=;
        b=KwX5Qb3AugR7MG053eWf7eeZ6ZIgo3Tn6YH3Tm/LGqqizQ1m8VtuRfHWg7v1S/bgCB
         CrmdeWMMCe3sGEXHId+DwP2p23fAkDZ3+LJnu8oAU6w19da8yYPUFMSxlylntaCQPImy
         oGjAJdpfMhxauPpFJLXD7H8vstQdYBL8GWlTkqjH7UmsdMCEWNASDKw0DXl8D+dhA7hw
         +8UA+Il3xR0ZP6SDyk2ZJ2LxmxevpWlczJl/SLaElHMZLFnwpTdXIZA0snqw+QJh6llD
         1QEin2JdYVHKH4t+twpT+Drfv4OB3pOlxhqjCnHwaumUijOzGnhqqpnk7sM0bU872SDu
         gSiA==
X-Gm-Message-State: APjAAAW+368SkjXe9WNcoJn15oEdNwRJlgbGP+vHmi2Zr2k6L0CuhsJM
        6ZoPEozp1Y7VqdgVMDUGYK/2JQ==
X-Google-Smtp-Source: APXvYqz+vXGWZcBEZJYVx+rFv5sqTUAoCg0qb5bq3U1UYR5WpxnO0dE7UdJWmxFtnX3tHhlwh568aA==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr3069680pfh.56.1559214241664;
        Thu, 30 May 2019 04:04:01 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id r44sm2250083pjb.13.2019.05.30.04.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:03:58 -0700 (PDT)
Date:   Thu, 30 May 2019 16:33:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] thermal: cpu_cooling: Make the power-related code
 depend on IPA
Message-ID: <20190530110356.vet2exwowdbm4umq@vireshk-i7>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092038.12020-3-quentin.perret@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-19, 10:20, Quentin Perret wrote:
> The core CPU cooling infrastructure has power-related functions
> that have only one client: IPA. Since there can be no user of those
> functions if IPA is not compiled in, make sure to guard them with
> checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
> unnecessarily.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 110 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
