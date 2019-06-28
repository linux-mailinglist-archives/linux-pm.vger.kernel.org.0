Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA34593F6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfF1GBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 02:01:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1GBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 02:01:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so2606570pls.8
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPRaQJzmFQwYi8hosJXjNAPxaw+qeTsDk1d+L2uAT1Q=;
        b=vvNL9fbJcjLCGE94UWKp38ok8N+6iZufXNYCef+hRYEt93VhjGYVeKaRdM9GFD0kq5
         /fTAzVWftSGRxWLvIiQf0tEwg7U4Mg2PAXVQyVIBmnSB2eO0Mvl3jq1wg7cvLF844thv
         cwA/XYaRACYItx2RywEjMnWdNCJV8fMJSSIgsjnTiZWsICUaHkFztJsRNVxtTvyJn5fq
         EkQxIQ7yqinxpgFe9RfhZkChUKYaAQyXeCMDcPD0hZ0uSWkb2unPMoaeDDbKx33qhn4m
         3sitMlJ2o/JTlsEHUBVmNpqoNA6tt79R8WgiXArCix4nvxu+S9XZVtdQ6gxEJWAenFg8
         zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPRaQJzmFQwYi8hosJXjNAPxaw+qeTsDk1d+L2uAT1Q=;
        b=ddKA2uRXopmef1/IlJ8dJ7J+dlNKjDwnhJG5uwc9QT7gxgmTBF3Qgi2NFaJt2WueUz
         mdY/ZaL5QHRYdbU3y8OzkfWbTJF7E3Wj6JwDKO7cmEAKpiXZdCySJNI4bMK5H4/Pa789
         DUp3RpgsaPq6AQFuT9UFvtmO5ld7xFcrCzA/cUu4LfEgEdKrgOXBKGU4SR0fVI+aqg63
         DOcWuiK+Hy0u+E9ZtrdLFTOd7PkCYMi28LP1mzYZ2dtppshqUbN5JQuUhsisFUEHQAtF
         zI6Kh5n7lLVFVqCZhW3exRCN0z87V1UHLwDL234kizil5WFcAJZ1k+4YKO+RgoCWJv2i
         OeEA==
X-Gm-Message-State: APjAAAXmw21i06qlQYhldHJiwTYhte7KoS+kftBeZREjLgsN0PD4YmCa
        rPHz99lEevPgir+/YfhMVQ+3WQ==
X-Google-Smtp-Source: APXvYqzbAhcap8BbHfMDCoOkrOvthmGqMacGqdcSZfyzVyXrEL6joFCpneO3Qz+XBoTszEuWTC1xEA==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr9620055plo.1.1561701702042;
        Thu, 27 Jun 2019 23:01:42 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id c9sm975912pfn.3.2019.06.27.23.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 23:01:41 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:31:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH V4 3/3] thermal/drivers/cpu_cooling:
 cpufreq_cooling_register returns an int
Message-ID: <20190628060139.czridjqrblu2ufjj@vireshk-i7>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627210209.32600-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-06-19, 23:02, Daniel Lezcano wrote:
> It looks like after the changes in the patch the only reason for
> returning (struct thermal_cooling_device *) from
> cpufreq_cooling_register() is error checking, but it would be much
> more straightforward to return int for this purpose.
> 
> Moreover, that would prevent the callers of it from doing incorrect
> things with the returned pointers (like using it to unregister the
> cooling device).
> 
> Replace the returned value an integer instead of a pointer to a
> thermal cooling device structure.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c                 | 63 +++++++++----------
>  drivers/thermal/imx_thermal.c                 |  6 +-
>  .../ti-soc-thermal/ti-thermal-common.c        |  7 +--
>  include/linux/cpu_cooling.h                   | 16 ++---
>  4 files changed, 40 insertions(+), 52 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
