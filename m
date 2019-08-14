Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6520B8D473
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHNNSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 09:18:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41844 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfHNNSh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 09:18:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so1561622qtj.8
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZyX4UwZDsJESsdNRwXLEnQCo7FzdFf5azmNzUnTXxg=;
        b=Wgy62dbPdx7rCiqmyp1F49T8qs3J6lVEJgwcQH62RIwgLwqdbGx7KNXUjW5/kWsQDk
         yGC0KhMqSNWgC/tmPdPlnbvb3ym80kkykNcpPifVVr9DKiv1WHbDHAgXygSeBWrAG/FW
         n1Wc6JVD8ZdTi22GwhHKHleyTiPseVDez7n0RnkUD2O5qJyQzO6G3nzNqwuRwJdJRHbG
         4xG6E85OYqOG8AXdzA1AkajOnZTvNKpQtOrECEZQeC+IvBgYGBTQ+BzOt94satlnCDY5
         QcythA0jW+rO5bfJoVwJMBjyfSqpGbZYLq25aIgaW3awp0U+hSvDEUabB/o9hTlYQvkP
         SQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZyX4UwZDsJESsdNRwXLEnQCo7FzdFf5azmNzUnTXxg=;
        b=GqlcUK3bl41CbUwIY3iGLpcKAJcel51D4RtIjfe4dDS+SwM4L0QpOFMhifLJLQ7s28
         oPuRSrgYn1Ybx4SteRekptfTS+/XAFKz0jc2G+SnNgyh7ZjwclEiuBiheqBuY+16cpZH
         UCcQEGvnTHKmMUBVplcJcuRYpMYPOlLXQx0u9zWmtzkq4PHkEXWjG3L943uSMZHtYie0
         KFG4VYn1soxl/gTinI3/HEQ1wSO03QQdGpzpX/qSZGd0OXDYQpg6wn9eI3RsCVshEIAF
         YfNHUlZXPu8W9e7bjzDxr/kl73wlKddNW04G6ANzmAHQwUxN97L9Rq2Dj5IWTfSPiu20
         hxoQ==
X-Gm-Message-State: APjAAAVg+OIzW/je20OcSMfAxn3keN35hY4SqIuq+cJkdBb4mNyZ3vc2
        qCpMhW0eXn6khEb44HyXkruPfQ==
X-Google-Smtp-Source: APXvYqyxz925tyOR3tsQ12Wbv7lwGSVhZkjJkowYzlpOz0HeUZ3Nw2JrG2NF0+NlHWTQYMCDDRHDmg==
X-Received: by 2002:ac8:3315:: with SMTP id t21mr35692416qta.392.1565788716096;
        Wed, 14 Aug 2019 06:18:36 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 136sm9717849qkg.96.2019.08.14.06.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:18:35 -0700 (PDT)
Message-ID: <1565788713.8572.20.camel@lca.pw>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot
 warnings
From:   Qian Cai <cai@lca.pw>
To:     Stephen Boyd <swboyd@chromium.org>, Tri Vo <trong@android.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Aug 2019 09:18:33 -0400
In-Reply-To: <5d533b43.1c69fb81.5729.a6bc@mx.google.com>
References: <1565731976.8572.16.camel@lca.pw>
         <5d533b43.1c69fb81.5729.a6bc@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-08-13 at 15:35 -0700, Stephen Boyd wrote:
> Quoting Qian Cai (2019-08-13 14:32:56)
> > The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [1]
> > introduced some baddies during boot on several x86 servers. Reverted the
> > commit
> > fixed the issue.
> > 
> > [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.com/
> > 
> > [   39.195053][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [   39.197347][    T1] kobject_add_internal failed for wakeup (error: -2
> > parent:
> > serio0)
> > [   39.199845][    T1] INFO: trying to register non-static key.
> > [   39.201582][    T1] the code is fine but needs lockdep annotation.
> > [   39.203477][    T1] turning off the locking correctness validator.
> > [   39.205399][    T1] CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
> > next-20190813 #3
> > [   39.207938][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
> > Gen9, BIOS U19 12/27/2015
> > [   39.210606][    T1] Call Trace:
> > [   39.210606][    T1]  dump_stack+0x62/0x9a
> > [   39.210606][    T1]  register_lock_class+0x95a/0x960
> > [   39.210606][    T1]  ? __platform_driver_probe+0xcd/0x230
> > [   39.210606][    T1]  ? __platform_create_bundle+0xc0/0xe0
> > [   39.210606][    T1]  ? i8042_init+0x4ec/0x578
> > [   39.210606][    T1]  ? do_one_initcall+0xfe/0x45a
> > [   39.219571][    T1]  ? kernel_init_freeable+0x614/0x6a7
> > [   39.219571][    T1]  ? kernel_init+0x11/0x138
> > [   39.219571][    T1]  ? ret_from_fork+0x35/0x40
> > [   39.219571][    T1]  ? is_dynamic_key+0xf0/0xf0
> > [   39.219571][    T1]  ? rwlock_bug.part.0+0x60/0x60
> > [   39.219571][    T1]  ? __debug_check_no_obj_freed+0x8e/0x250
> > [   39.219571][    T1]  __lock_acquire.isra.13+0x5f/0x830
> > [   39.229491][    T1]  ? __debug_check_no_obj_freed+0x152/0x250
> > [   39.229491][    T1]  lock_acquire+0x107/0x220
> > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > [   39.229491][    T1]  _raw_spin_lock_irqsave+0x35/0x50
> > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > [   39.229491][    T1]  __pm_relax.part.2+0x21/0xa0
> > [   39.239588][    T1]  wakeup_source_destroy.part.3+0x18/0x190
> > [   39.239588][    T1]  wakeup_source_register+0x43/0x50
> 
> We shouldn't call wakeup_source_destroy() from the error path in
> wakeup_source_register() because that calls __pm_relax() and that takes
> a lock that isn't initialized until wakeup_source_add() is called. Can
> you try this patch?

It works fine which takes care of the lockdep issue.

> 
> ----8<----
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 3a7f5803aa81..f7925820b5ca 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -137,6 +137,13 @@ static void wakeup_source_record(struct wakeup_source
> *ws)
>  	spin_unlock_irqrestore(&deleted_ws.lock, flags);
>  }
>  
> +static void wakeup_source_free(struct wakeup_source *ws)
> +{
> +	ida_free(&wakeup_ida, ws->id);
> +	kfree_const(ws->name);
> +	kfree(ws);
> +}
> +
>  /**
>   * wakeup_source_destroy - Destroy a struct wakeup_source object.
>   * @ws: Wakeup source to destroy.
> @@ -150,9 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
>  
>  	__pm_relax(ws);
>  	wakeup_source_record(ws);
> -	ida_free(&wakeup_ida, ws->id);
> -	kfree_const(ws->name);
> -	kfree(ws);
> +	wakeup_source_free(ws);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_destroy);
>  
> @@ -217,7 +222,7 @@ struct wakeup_source *wakeup_source_register(struct device
> *dev,
>  	if (ws) {
>  		ret = wakeup_source_sysfs_add(dev, ws);
>  		if (ret) {
> -			wakeup_source_destroy(ws);
> +			wakeup_source_free(ws);
>  			return NULL;
>  		}
>  		wakeup_source_add(ws);
