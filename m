Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C14DC1E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfD2Gkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 02:40:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40216 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfD2Gkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 02:40:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so860840pfn.7
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6FM1rSzZ9h8rmrZcNulHQ/ckqkKSNY3YRkvtfMMR93c=;
        b=MgKgHzRTF1N7lUI2X3zxciEafWYMvUGE2goAiPsHjgYCdiMJDIL5yQaNzPmFwXljnS
         jZU0adA4Tbp++PjlbogzsZbTD+MUYKXbRJHXFhYLtH0f4AJwRC8X2XwuM5Q/fgamlfZK
         n83Hq555z4r5fz6icHwZrOkXUGVfRQ9PrnQF7dYpsGWBA8SyboQ3En1T3EiHRm/+Fenf
         aBO3O151YSP6/y23DCu/vnr7rrT8nQU26kz2OMnoFBNW39fokOz5OUl/6OinNYZfFsOe
         ZsCQ/hiQ6pcP9eMHQcSiS2+n+cmeoTDjzXDBfqTIfeqi5Di9tKUGhvtTvZknTwVWf1iW
         iBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6FM1rSzZ9h8rmrZcNulHQ/ckqkKSNY3YRkvtfMMR93c=;
        b=FqkwfxIAH3EeahF5jjKokdSJbzIW57hxgYvyiiZ+uVY/1TCOVVEtCz93tewfhAoUAh
         iiF9osuF5IqyNefLwJA4ZORbl4ITcNLaet5einM6lBfxJ+rMW46ruxAEFhAFft5c/OWh
         CFFRCmCuZPCCUmcmMHefqa+ooeFfNHtLIgnggLLsJDxZVDg1H8/ewq+x6AKoxaFx9ajA
         XXTJsygrQwxsf0zPgOL2s2qnAST4U1956HO/5FoN7CoxAIXMQPoIaT2zVAXzvvTQ5Jhn
         QtZQgLu8BBivzV2FVc6yQUx7AOXlT3Mqn1DSjU+4E/iOsoQ7jaylqFMddAiuQVSFNt5k
         z/gw==
X-Gm-Message-State: APjAAAXU7HGrXviHrHsCEPgUDZGrU7hiKBXlW/dR85QD9sDEP6acHxJQ
        TWJyH+Z4FMEMo6DwlyKWY2M7nTTXyMY=
X-Google-Smtp-Source: APXvYqzWZRXizSff2Al1BGfKMTzvI3ZeYVz0tnftih9X4kyvmaR0LSiXLejFoBCbNgxJUDXSiQpabw==
X-Received: by 2002:aa7:8383:: with SMTP id u3mr18198511pfm.245.1556520039773;
        Sun, 28 Apr 2019 23:40:39 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id s198sm21392963pfs.34.2019.04.28.23.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 23:40:38 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:10:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH v2] cpufreq: Don't find governor for setpolicy drivers in
 cpufreq_init_policy()
Message-ID: <20190429064036.rmhw3m2hqr7bkxbb@vireshk-i7>
References: <20190426063135.5200-1-zbestahu@gmail.com>
 <20190429051507.cabsr62rhc5evka5@vireshk-i7>
 <20190429143528.00002ae4.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429143528.00002ae4.zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-04-19, 14:35, Yue Hu wrote:
> So, also need update store_scaling_governor() as below if doing that above, right?
> 
>         if (cpufreq_driver->setpolicy) {
>                 if (cpufreq_parse_static_governor(str_governor, &new_policy))
>                         return -EINVAL;
>         } else {
>                 if (cpufreq_parse_governor(str_governor, &new_policy))
>                         return -EINVAL;
>         } 

right.

> Moreover, change cpufreq_parse_static_governor() to cpufreq_parse_generic_policy()
> should be better?

Maybe cpufreq_parse_policy().

-- 
viresh
