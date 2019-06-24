Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA65501C8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 08:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFXGDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 02:03:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33773 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFXGDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 02:03:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so5903810pgk.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2019 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNs4bFTn0f/H2512covQPvgW7xHEQrBSIemzlMYE1WU=;
        b=F6gYtTDouoTcZyvItCkzcdGIm2GiI5ij2KNmjl/uLGOHVF2Mgm3DYbvhBuN+5OjeHL
         gp6gGnmh2wXuboNfODnOsROpHwsUB9Ah54gRqCRbwzS+v36jwN8cRN7coJoZm1T8h5m9
         Lc/SvxQO+ojDltrR1frfHPAqHVEaQ4rZzvi2puGHraCUF6e74PXvr3xPErsg6EpQr4yj
         hLAjMEOKC+z12zOExSiI2StSVfgVkC8OuGmJS5f3b0R6Gbjp6VKG5Z39CCOrbIkpccjh
         mSAPWAu7IbIkiDA0ajpEjHQorirY8MFMy+N2aZyiyn/PgVaFliemA83jUL/+xt4Y6rB7
         zeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNs4bFTn0f/H2512covQPvgW7xHEQrBSIemzlMYE1WU=;
        b=pnmFz8uOAcHKBhqegySeWFClhQvMzZVpm1kJC0MCtFNjUqa16D2ee8KFRNC1nyTIsJ
         8HCBp3I2dv3B7EZbiwaaMRbgYzvazFpN40bpl55ybk7DAu2+EtAHg8eqhN+66JOT+aGD
         /0nukMsgxRtyGh5TEowZ2tU9y+oEGJLPc/GwtqECuPB+FpymIq2u0kbmokeUSaWnznRh
         htE8fpFfqBeC1HDcusevN8biCt3XEwBCHBtikB4ErsuFnQsYzR/DKLZKRrl5S5+BotCr
         v0YoJQbMZqr+HicHBuvZ3Kwsie05klRD98UDg9y9OQ+k6T1YOdMWpJlyH53e+mdMvsFc
         Uuww==
X-Gm-Message-State: APjAAAX9SJ/Bs2HS69K/qcXegv7QMT+xM0I2zi54u70RW6bzwi8DuFEe
        l9SMF2L3C2gJUve0uNjtUBJaoA==
X-Google-Smtp-Source: APXvYqy9bO/usfvdFvRCWkxVVdZwwaK8oMRu4R8n9ullXNpcFe0FPzC2a9IPf+ONlr+KOyOJ5GZlLw==
X-Received: by 2002:a63:dd53:: with SMTP id g19mr30047290pgj.3.1561356218023;
        Sun, 23 Jun 2019 23:03:38 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id bo20sm10925850pjb.23.2019.06.23.23.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 23:03:36 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:33:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Message-ID: <20190624060334.kak2mjuou4napi4x@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-19, 15:22, Daniel Lezcano wrote:
> Currently the function cpufreq_cooling_register() returns a cooling
> device pointer which is used back as a pointer to call the function
> cpufreq_cooling_unregister(). Even if it is correct, it would make
> sense to not leak the structure inside a cpufreq driver and keep the
> code thermal code self-encapsulate. Moreover, that forces to add an
> extra variable in each driver using this function.
> 
> Instead of passing the cooling device to unregister, pass the policy.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c               |  2 +-
>  drivers/cpufreq/cpufreq.c                      |  2 +-
>  drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
>  drivers/thermal/imx_thermal.c                  |  4 ++--
>  .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
>  include/linux/cpu_cooling.h                    |  6 +++---
>  6 files changed, 18 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
