Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBBBBB94
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfIWS2x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:28:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfIWS2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 14:28:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so9637531pfr.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=osrTSn6KjMgzsQs20d8e8jW1Eld7CeaYVglhaLiaLFM=;
        b=Yh7pE8es+GVW4C8JR7aOYXG2O0qKNB6DC0vm4QpDXsa1xVGouuF8HLw6sJIaI1fdC5
         kN2rydapFx5DlHkCLwyPiPEaXhLX8PW4fM4+aMPvuP7hRrS3NjmJvVsAmN6cGSmMe2sC
         CaoJDzr+VPWJrywZdIYc5zH3+xiRqRadGHncE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=osrTSn6KjMgzsQs20d8e8jW1Eld7CeaYVglhaLiaLFM=;
        b=Emifm/9yXZsRe8SHfwJgdkv6bBzSwmH93QBYkfadJci9BJ3tY2Hm4nFn3qkBEWg9t7
         20C7JwzURuGJisTUndgYw2IsEIZOMBzPF4aFwJ1xBQ+JVJ+Wl6aAHhJL6maaxv0QT9eC
         Rvl1bC7TGUUidt56Fr5md77mKfCJMgFFrtilsFzRS/Ru541WXsmjny+viahNXr/5gdZt
         fRKvb/LYejhkgct/TcbiGB0fXaTVAXgHBIyAt6PUgz7iRQpcCxk7Blwym475rwFg5V3J
         FBi2BcTDhtPVTzmHSI7KeZ2HhDMaTMqhTIUSrC0o/hh7aC5NR1bE/0cWbuwgQ5B8KyAP
         TD2g==
X-Gm-Message-State: APjAAAUGwL83Fhbd4lJBCiwzjNxRwBCe7SARxyImAaLkMfzEQ/KB/kub
        1aaoXM55LBNIDpQl3ZoqTgLJAw==
X-Google-Smtp-Source: APXvYqxnWvwnP8W6mGj9+JL5YprZG5pP/WpUUgP7zfCNFpJEkySyt5F6Iu1FF86JYwkPO2XQ0Q9GHw==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr941118pjn.56.1569263332455;
        Mon, 23 Sep 2019 11:28:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w11sm19047961pfd.116.2019.09.23.11.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:28:51 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:28:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v6 5/6] PM / devfreq: Add PM QoS support
Message-ID: <20190923182849.GA133864@google.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <55807c847f072690f3ec904168023484767dc603.1569252537.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55807c847f072690f3ec904168023484767dc603.1569252537.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Please see my comments on v5: https://patchwork.kernel.org/patch/11149485/

an additional nit inline

On Mon, Sep 23, 2019 at 06:51:08PM +0300, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6acb827fee5..a4c7dde17a06 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,17 +22,20 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define HZ_PER_KHZ 1000
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> +#define HZ_PER_KHZ	1000
> +
>  static struct class *devfreq_class;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
>   * functions. Governors can use these or can implement their own
> @@ -123,10 +126,16 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* constraints from PM QoS: */

nit: remove colon
