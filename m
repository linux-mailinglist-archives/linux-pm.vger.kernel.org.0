Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE92B174F77
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 21:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCAUNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 15:13:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36937 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAUNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 15:13:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id 5so2697774oiy.4;
        Sun, 01 Mar 2020 12:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFSBXCeJ1jB8KcQMkp6NN1TRtUlXUbslxnRcWQMIR6I=;
        b=he73iD3UgVGkFxGZI4jh1kZswVamv7f8BTzZWf6eR5iF5ZeVryLEv2aO4JbY+XxXRD
         Gyp5kV+Z2y9k5J3njjuj8MwG4T6lWegl5/Z6ChA2gzzd6vuBp5sCo+vs742QGioyjogj
         VOaGWryoS+4bj11YQgBOb1EnPUmcFLJQuPyOuyMLd3Dz8SUCOSPSKruJW+BeJQIbjtVo
         DEFld/Mt9ylGQpVVWj8IYZk8hvyCO3sncioLddSbVTg5Budz7Qo9TPP1HhG1AdKmzhEZ
         1Ak0MxbmjAP+/mWR8t9Ls3DdmOyMLLS+3JXgCTD3P3G2jz/cun8idJQOuPUUEBx3Hv61
         Ku2A==
X-Gm-Message-State: APjAAAXSj4NJ4oqBkR877QzqEis5Mki9oBkSKsCIswnYc2RJFGoUpBbc
        ezT3aZoVhJKJJUjQLjdWq31zbffZs0QZxY7Mt88=
X-Google-Smtp-Source: APXvYqxbxPHmtfRGPpPP1hveHtyD20S1Jgyu5yQkA7cDSv5uULtoifR1CJMcxL/u/2XdY7RWZkl38PW9OoOvYdgqVlM=
X-Received: by 2002:aca:c044:: with SMTP id q65mr4390997oif.68.1583093583908;
 Sun, 01 Mar 2020 12:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Mar 2020 21:12:53 +0100
Message-ID: <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
To:     madhuparnabhowmik10@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> This patch passes the cond argument to list_for_each_entry_rcu()
> to fix the following false-positive lockdep warnings:
>
> [  330.302784] =============================
> [  330.302789] WARNING: suspicious RCU usage
> [  330.302796] 5.6.0-rc1+ #5 Not tainted
> [  330.302801] -----------------------------
> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in non-reader section!!
>
> [  330.303303] =============================
> [  330.303307] WARNING: suspicious RCU usage
> [  330.303311] 5.6.0-rc1+ #5 Not tainted
> [  330.303315] -----------------------------
> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in non-reader section!!
>
> [  331.934969] =============================
> [  331.934971] WARNING: suspicious RCU usage
> [  331.934973] 5.6.0-rc1+ #5 Not tainted
> [  331.934975] -----------------------------
> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in non-reader section!!
>
> [  332.467772] WARNING: suspicious RCU usage
> [  332.467775] 5.6.0-rc1+ #5 Not tainted
> [  332.467775] -----------------------------
> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in non-reader section!!

I don't see these warnings in the kernels run locally here.

What do you do to get them?

Joel, any comments here?

>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/base/power/main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0e99a760aebd..742c05f3c1e7 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -266,7 +266,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
>          * callbacks freeing the link objects for the links in the list we're
>          * walking.
>          */
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +                               device_links_read_lock_held())
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->supplier, async);
>
> @@ -323,7 +324,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
>          * continue instead of trying to continue in parallel with its
>          * unregistration).
>          */
> -       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
> +                                device_links_read_lock_held())
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->consumer, async);
>
> @@ -1235,7 +1237,8 @@ static void dpm_superior_set_must_resume(struct device *dev)
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +                                device_links_read_lock_held())
>                 link->supplier->power.must_resume = true;
>
>         device_links_read_unlock(idx);
> @@ -1695,7 +1698,8 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +                                device_links_read_lock_held()) {
>                 spin_lock_irq(&link->supplier->power.lock);
>                 link->supplier->power.direct_complete = false;
>                 spin_unlock_irq(&link->supplier->power.lock);
> --
> 2.17.1
>
