Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA4BB5D6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407269AbfIWN5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 09:57:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405951AbfIWN5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 09:57:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so6947867pgv.8
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vh231WMV2ivWs55DEErMfh8G5ByHHFCoNJUSWzLVISU=;
        b=cn+X8r4N29tWYhUPaIF9sgpCyWWDn5rzKDhmPhMpd6+EovbrDiKU4kleehawYApRCY
         fCZijjEsZtcLK+chNOmk0QVamPsXX4shbo1HalDXbsFHMbaGBwYYSjkV/lMIsi+9db4Y
         EhVBWHBjDfy0Kh1IPA4zbFyitBp9jARKh+Kz5eQPSTsW+f/8c3AXscIc+HQju4X8XDpH
         +uusOt3917tb0v7Fi/Ia49dbzRcJ1ON2KyjoPFDEybGqNdbzbyyNYRkrAbnihbZd42ul
         eVHMZLPI3/Zq+V4vvDgt3hltjL9KRupNZOaBYoZN5dA4e0s2Rlimp/5v26DIS4hUsaN3
         dZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vh231WMV2ivWs55DEErMfh8G5ByHHFCoNJUSWzLVISU=;
        b=oGhp5i1yO4ks7V24pDjsAjREEPmc+8PafGTh9WZgimoeVOLvf3jk5GmKZzFzNzzn0v
         imUaoGmFgXGkGJX7Vls40ChKrA02+P/hFYmAvcirjyPP6+kki/OjgZ3cEcaUALWLGQOg
         eHCEbqNQviEjQKPLDz9Q9MNA+N/Hx6RNm4CZA4Knack3RQNiwRRatBW/PH5sfRPOwkqP
         zWyM9JCfNBGBr3YX8mBmPNHzsN2ohcsx+5OGTJHUE5OfFCiiiRJN8HhGUPKjHA6f7knp
         i8jjR/OvN75x45/T0oafg2hah5cNlxE3MaZPT3lUYRH6mUV5FolL8IDyIs+ZoIFaLdCE
         IdRw==
X-Gm-Message-State: APjAAAW5mgRT4c5za0ioP562eIcrJKGSNq/U1z+BCDluv0XktyWXL+nj
        x+YbEP6dcl+aABev956t4kbq+g==
X-Google-Smtp-Source: APXvYqy25l2lGHysPit/QeYW2D3xxOswz/kQvKmjC7grygQ6MEygsYLyqXGOeVrHJDihF8TAlwLLkQ==
X-Received: by 2002:a65:5546:: with SMTP id t6mr59005pgr.441.1569247019584;
        Mon, 23 Sep 2019 06:56:59 -0700 (PDT)
Received: from localhost ([12.206.46.61])
        by smtp.gmail.com with ESMTPSA id 1sm14156061pff.39.2019.09.23.06.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 06:56:55 -0700 (PDT)
Date:   Mon, 23 Sep 2019 19:26:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190923135654.wcsdl5jdzxqeht3l@vireshk-mac-ubuntu>
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-09-19, 23:12, Dmitry Osipenko wrote:
> This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.
> 
> 
> [   87.952369] ==================================================================
> [   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
> [   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243
> 
> [   87.954901] CPU: 1 PID: 243 Comm: modprobe Tainted: G        W
> 5.3.0-next-20190920-00185-gf61698eab956-dirty #2408
> [   87.956077] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   87.956807] [<c0110aad>] (unwind_backtrace) from [<c010bb71>] (show_stack+0x11/0x14)
> [   87.957709] [<c010bb71>] (show_stack) from [<c0d37b25>] (dump_stack+0x89/0x98)
> [   87.958616] [<c0d37b25>] (dump_stack) from [<c02937e1>]
> (print_address_description.constprop.0+0x3d/0x340)
> [   87.959785] [<c02937e1>] (print_address_description.constprop.0) from [<c0293c6b>]
> (__kasan_report+0xe3/0x12c)
> [   87.960907] [<c0293c6b>] (__kasan_report) from [<c014988f>] (notifier_chain_register+0x4f/0x9c)
> [   87.962001] [<c014988f>] (notifier_chain_register) from [<c01499b5>]
> (blocking_notifier_chain_register+0x29/0x3c)
> [   87.963180] [<c01499b5>] (blocking_notifier_chain_register) from [<c06f7ee9>]
> (dev_pm_qos_add_notifier+0x79/0xf8)
> [   87.964339] [<c06f7ee9>] (dev_pm_qos_add_notifier) from [<c092927d>] (cpufreq_online+0x5e1/0x8a4)

Hi Dmitry,

Unfortunately I am traveling right now and can't test this stuff, though I may
have found the root cause here. Can you please test the below diff for me ?

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 6c90fd7e2ff8..9ac244ee05fe 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -328,6 +328,8 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
        spin_unlock_irq(&dev->power.lock);
 
        kfree(qos->resume_latency.notifiers);
+       kfree(qos->min_frequency.notifiers);
+       kfree(qos->max_frequency.notifiers);
        kfree(qos);
 
  out:

-- 
viresh
