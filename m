Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952BA29EE73
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJ2Oig (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJ2Oig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 10:38:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E8C0613CF;
        Thu, 29 Oct 2020 07:38:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d24so3316897ljg.10;
        Thu, 29 Oct 2020 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d1DuLRj2t9CrdcFPAV+RDrnwxMQi4NyG9Fig4kzBo/A=;
        b=hucQM0uztlXYbkOG9ozcieEjMyVpqihbCyTybwx2ayktw13ry50aJrmXI4vZnEHYMy
         9XHMbpOQcFExEVr6brmkmbq/BdsPOpWlFr4KGjJXExoESXB3xhRYA/k/hrTY2B+By9XB
         0Sr54M5ihRsTOf9K7gS65Q/lrvWh5neZAlDdEWBTjzVKvZS/5OzJmQDES0NlJkBNFGv+
         KhkeqeP+m3czM0pg64RJb6MkNKWzCBxKTXrGCR4QUCflg5ea3UdLldrXL9/XOFkbYAYC
         n0CFQL3oaZlWAGCcnZ1pGYwnqRgQsH+HuW8/k0Dc9zuEk8D591LqHLsxrUVTuqJMgt0/
         aZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1DuLRj2t9CrdcFPAV+RDrnwxMQi4NyG9Fig4kzBo/A=;
        b=B+G8oTLRjIbSrN8MrpXti/iVepyFs0YCAGAIxfVaG457jRxqvkEFag5SaCZ1qDsMqI
         L75KT/+Oz+Su0tvx19cXyZUptQXPf++d4eiA93WLYlJyCNczISdWdf1o2+nhiMTp8p96
         6LrkPp6ShxCW8/9DCquJzwE8veb7egjSZv2gX8kTWQlQk3E+dGG5IbqwyLdPgtn5bMbD
         L4l6OceSeUHm/HSISSyLAZx4YKxFvuk+6zbH+RjPmWwc8J/g2UUAHBS83r0QwkOllC+H
         t506cqWFNP6lS6yE432wOZBStCxBiLr3syeUDr5Qp7aFf+0wgNAsKU7NnqEkIcP57wLO
         zYDw==
X-Gm-Message-State: AOAM531Ll1m5Cx28cbCCgDtVYa8iG2r1EVNEgX4OaR6lhxFaNOiGj+Ws
        rO7UA+QWjE3HWeFQv0TV98jtkVfVRu0=
X-Google-Smtp-Source: ABdhPJwLvKZRG273pl6geG/4MT2scAZlYVd2FaCiop8nrQBqM2oe1kFDKiB/ZYhbTjTnnz7HQ0dn+A==
X-Received: by 2002:a2e:9cc1:: with SMTP id g1mr1255760ljj.386.1603982312747;
        Thu, 29 Oct 2020 07:38:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id 80sm299382lff.61.2020.10.29.07.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:38:32 -0700 (PDT)
Subject: Re: [PATCH] opp: Reduce the size of critical section in
 _opp_table_kref_release()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <db13643d-9dbd-8e76-ed9d-01d8db6a0c37@gmail.com>
Date:   Thu, 29 Oct 2020 17:38:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 10:57, Viresh Kumar пишет:
> There is a lot of stuff here which can be done outside of the big
> opp_table_lock, do that. This helps avoiding few circular dependency
> lockdeps around debugfs and interconnects.
> 
> Reported-by: Rob Clark <robdclark@gmail.com>
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rob: I know this only fixes the issue partially for you and I am still
> looking into that. I just wanted to get this merged in early as this
> fixes lockdep for other users as well.
> 
>  drivers/opp/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 4ac4e7ce6b8b..0e0a5269dc82 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1181,6 +1181,10 @@ static void _opp_table_kref_release(struct kref *kref)
>  	struct opp_device *opp_dev, *temp;
>  	int i;
>  
> +	/* Drop the lock as soon as we can */
> +	list_del(&opp_table->node);
> +	mutex_unlock(&opp_table_lock);
> +
>  	_of_clear_opp_table(opp_table);
>  
>  	/* Release clk */
> @@ -1208,10 +1212,7 @@ static void _opp_table_kref_release(struct kref *kref)
>  
>  	mutex_destroy(&opp_table->genpd_virt_dev_lock);
>  	mutex_destroy(&opp_table->lock);
> -	list_del(&opp_table->node);
>  	kfree(opp_table);
> -
> -	mutex_unlock(&opp_table_lock);
>  }
>  
>  void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
> 

Fixes the NVIDIA Tegra devfreq driver lockup using WIP ICC patches, thanks.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
