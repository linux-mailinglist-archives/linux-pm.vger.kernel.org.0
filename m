Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42745DB9D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfD2Fny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:43:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42602 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfD2Fnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:43:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so4745251pfi.9
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6olaaoMgCPdNo+TQ5dKNbZrzG8cHHnKkwnShCeOItA=;
        b=vVTNghG8+EXptSKKElI+90BdcTKrPVcDaawjQoAPtAHprgvxAwfsIyUlN7eSQpkMq1
         r8IlUWyXc8o0gAgfuWbxADSpvDVIUSyjnBq4M16wgQ612CLJltsgXClxENqiTIS/cEsN
         L5UHLr/4iGjBnsuvcMJLgn+QAiLZ7IZlDD+CiJJrEV/jsMY11Iev1b5+C6zFodkqFRHd
         lbq+wtTJU3MULv0Vm/iu9qCuwdk6ZA8j5gQcgnDIeN2uenMC4yme8YB9c0fLX0wdn6sC
         TpsDCeNjhGi3LN+JARS7HwqqJucAA1DVs0QqOkM+MY4Zorb6dZYwwbBYLJjj6Jyvyvh2
         pfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6olaaoMgCPdNo+TQ5dKNbZrzG8cHHnKkwnShCeOItA=;
        b=SChFXXUGvxG1Nzl5pmsyYvCSesW5N0Wtvku8EZ3XRajiYgkk/nYzuiD0WdxFLYSEy1
         gA4w7CikEO3hhVKS7dwyUtlmJhBzy51EP5JP4G+qhHp/MYF1Z033P3wrkNkikItNbSFG
         lusB0UJNmeBQDWrblwOl/E5NmCzKn2rkCk/tCKZihDUHGH40RyQRprA8ulcLOYh/iWmz
         DyYK8sO53Rhciv54REhldwFUvTExW+v/Zw3YIqPucdh8llTNl5kI4MRBf2uuMT+eFycl
         9hmA9NAhL/zpkQHdQSr9X2CU3cbjcUbyhQVbZE/4HTJ1fozp+Q+Qwd+MErfPvCCZAgqq
         np3w==
X-Gm-Message-State: APjAAAWVc715fTdHUYpF+qYJ+GiS4I42pVMKW4mRKzfwoAgdKuOsv33F
        DdYDeRzdvCKYALfECTv71HUQdQ==
X-Google-Smtp-Source: APXvYqyR0BedU0HRa9qIql/vNEnoOrMXmo165VyvbsnwOXe7QM4jxF/+e+MxiLue3le0JEShGbwICQ==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr59820324pfc.11.1556516632851;
        Sun, 28 Apr 2019 22:43:52 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h187sm55306813pfc.52.2019.04.28.22.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:43:52 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:13:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
Message-ID: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-04-19, 11:51, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
> 
> Fix it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Viresh Kumar <viresh.kumar@linaro.org>

What exactly have I done here ? :)

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ee8419a6390c..42aeb9087cab 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2012-2018 Linaro Limited.
> + *
> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *  This program is free software; you can redistribute it and/or modify
> -- 
> 2.17.1

-- 
viresh
