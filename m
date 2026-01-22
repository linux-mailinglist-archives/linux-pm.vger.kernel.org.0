Return-Path: <linux-pm+bounces-41304-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DleJF9McmnpfAAAu9opvQ
	(envelope-from <linux-pm+bounces-41304-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:12:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AD69AF1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E068F3013B5C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09A423A90;
	Thu, 22 Jan 2026 15:35:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D038F936
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096149; cv=none; b=M9rvI9Ypl6eFMD/Y/AfZmu0qwLLTrywD6+H2CH0Im+/gIdiuEg9G/29hxy9eMaWx4/taS5wJ8OOtFG1nyo5uOLOA5zMGbzuEFusvG2Jdb9P1KeiB/mSIL8q7uESoU5j0Ol86t4PfEY5II/oNLSEriI+kWxVm+/Pgl1HWanoPC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096149; c=relaxed/simple;
	bh=YPE69ll2AbGtRwWchQWHGcc4LtU2Wr3G3FF3DkunjjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+dPBO8QyrhCTGp/T3JB4OVmg+KLPg4iEhMciiHZ2kafemSLfwIf0EqpMU8m47r0vymQe5QfVT9uHv8njRMA/6fDY6tJTtdcLCeJsD0dvuG1CmhMprMT5ROS17eEWg1DCGClZ8Fb2bi3IzgXVkKkjpIV4FYkjsVquo1tislZDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f530da3a07so935753137.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 07:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096145; x=1769700945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vofMq1n4Pgk5SZoZLvHR7ju3JLd7F3NzrDb2mQ9r5Ns=;
        b=fPgTJbKZy65wKf5aHIns/ENMk3+051ZhNevSMnD/zGCyxc5tKyOl/8QbZt4tMBlvLG
         9D0s18d/S2PVfzdVOvrDoE5uFvx/e1H4t2AWRjwUAJUK9Ncot3UMq0t3uEDry8C//MA+
         v3Z9MyV4fH1/J//4VrISgd63gvRpEPfFIbS1tKjMnKzYpkT8xdI+oxtwc/ziPN3pKRp5
         ew1kW/5Dm8+tEQlqskntn7GVy0ucJS7iSxLVMqhe1CAxKqD9zqwXzr3Mgp5ihrg66lgd
         9l55Y1fd2KK30PC50o0eOCfjqMXtxcX1OE1ihCY2c86CThh2aQA9QVdV0H1E1hAwE2Z0
         O7gg==
X-Forwarded-Encrypted: i=1; AJvYcCVz0gJbdMxTaIKn7856v6RcWUPzBwaoHWswCMpAuPxc/pbPQmnP3txwX76R7RGYerU91rB+wmAkug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UR8ahmmaFsACYKbd/LG0g1+DgOdRyr7agvHIUocsHag2na3g
	fU+b6225Se/dgQjRT9A8Vt9YtzyOhdpGHm4d3XBykO3Os/zG6PhaQ3s+LN8M2fA1
X-Gm-Gg: AZuq6aJK92G8WgZJyFGicNVLvr0Y+2x0Unip4Y25K9QTIutxZQpXN6j+voXIiIk6dXf
	H9yYkSV3OFJuYx8S+u3XloprUjjI77hdOI8hyp2TtSGYP4aCdOtj8ui6/ivARzphkGy7SGaZ9xV
	Kn9DMJZbVk4hzxlxmnlIip8SUcmT7IZIIdDxkmj9WRTOB5qrju4EswboOjuR2ufyI1eXAp/N/Pd
	flGgvVFh3nyXVBjBZNh7kxUCUGcGx1OWrJuwjBGgF3QgwmqTeCE81oSOTunhJX9i+nLMacjfQ5V
	fRKeyMnI8n7K2RUtPmT2Ry3Cdu9x5FDna/I1nF6Ju4IlCn6quCz/7N96bdyUDVUvcY1inN9tW8U
	UXvQuJVZVITRmTrtLN6H0DC8X5+U4VykqscKhUIPwllVHZcVpNOXooBAhliTAZmcvfonN6TgYYT
	No5opeHnj3p9DrgiRz7ceNYqA+xc0FhbNMbhrwx/BW61ZYrEM2X+hg
X-Received: by 2002:a05:6102:26c4:b0:5f1:c4a6:b0ec with SMTP id ada2fe7eead31-5f54bb469b3mr15116137.16.1769096145060;
        Thu, 22 Jan 2026 07:35:45 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d03eaf17sm5257377241.8.2026.01.22.07.35.44
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 07:35:44 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56637565faaso542793e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 07:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5St/SxxZMrej4zt7WEHqkNVArI4Jz/PDBZhdo4dA4x2H0i61AgVuDj1/h49PQb9nzM5ll9XBcNQ==@vger.kernel.org
X-Received: by 2002:a05:6122:e14b:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-5663eb76e24mr2012e0c.17.1769096143945; Thu, 22 Jan 2026
 07:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <0e9f963b-00e0-43d1-b567-cb10b8f66df1@mailbox.org>
In-Reply-To: <0e9f963b-00e0-43d1-b567-cb10b8f66df1@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2026 16:35:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
X-Gm-Features: AZwV_QhcJQLltP1BceqwN2KHR0oQK_LzttveVgO-i1rRJzUP3zQgj-PiPJBF22I
Message-ID: <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
Subject: Re: drm/imagination: genpd_runtime_suspend() crash
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	DRI Development <dri-devel@lists.freedesktop.org>, Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41304-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mailbox.org:email]
X-Rspamd-Queue-Id: 227AD69AF1
X-Rspamd-Action: no action

Hi Marek,

On Sat, 3 Jan 2026 at 19:25, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 10/29/25 3:08 PM, Geert Uytterhoeven wrote:
> >       default_suspend_ok+0xb4/0x20c (P)
> >       genpd_runtime_suspend+0x11c/0x4e0
> >       __rpm_callback+0x44/0x1cc
> >       rpm_callback+0x6c/0x78
> >       rpm_suspend+0x108/0x564
> >       pm_runtime_work+0xb8/0xbc
> >       process_one_work+0x144/0x280
> >       worker_thread+0x2c8/0x3d0
> >       kthread+0x128/0x1e0
> >       ret_from_fork+0x10/0x20
> >      Code: aa1303e0 52800863 b0005661 912dc021 (f9402095)
> >      ---[ end trace 0000000000000000 ]---
> >
> > This driver uses manual PM Domain handling for multiple PM Domains.  In
> > my case, pvr_power_domains_fini() calls dev_pm_domain_detach() (twice),
> > which calls dev_pm_put_subsys_data(), and sets dev->power.subsys_data to
> > NULL when psd->refcount reaches zero.
> >
> > Later/in parallel, default_suspend_ok() calls dev_gpd_data():
> >
> >      static inline struct generic_pm_domain_data *dev_gpd_data(struct
> > device *dev)
> >      {
> >              return to_gpd_data(dev->power.subsys_data->domain_data);
> >      }
> >
> > triggering the NULL pointer dereference.  Depending on timing, it may
> > crash earlier or later in genpd_runtime_suspend(), or not crash at all
> > (initially, I saw it only with extra debug prints in the genpd subsystem).
>
> I came to the same conclusion when revisiting it yesterday and today.
>
> The power 3dg-{a,b} domains are in RPM_SUSPENDING state, the
> __rpm_callback() is running and it unlocks dev->power.lock spinlock for
> just long enough, that the pvr_power_domains_fini() can issue
> dev_pm_domain_detach() and then dev_pm_put_subsys_data() , which unsets
> subsys_data, which are later still used by the __rpm_callback() (really
> the genpd_runtime_suspend() -> suspend_ok() it calls for this domain).
>
> But, I wonder if the problem is actually in the CPG MSSR clock domain
> driver. The pvr_power_domains_fini() dev_pm_domain_detach() really calls
> cpg_mssr_detach_dev() which calls pm_clk_destroy() and that invokes the
> dev_pm_domain_detach() which unsets the subsys_data . The
> pm_clk_destroy() documentation is explicit about it unsetting the
> subsys_data .
>
> I wonder if what we need to do instead, is patch the CPG MSSR clock
> domain driver such, that it would surely NOT call pm_clk_destroy()
> before the domain transitioned from RPM_SUSPENDING -> RPM_SUSPENDED
> state and surely is done with all its __rpm_callback() invocations ?
>
> Can you please test this change and see if it fixes the problem ?
>
> The barrier should guarantee that the domain is settled and no more
> callbacks are still running.

Thank you, that indeed fixes the issue!

However, I am not so sure this barrier belongs in the .detach_dev()
callback.  The documentation for almost all dev_pm_domain_{at,de}tach*()
functions states:

     * Callers must ensure proper synchronization of this function with power
     * management callbacks.

However, I couldn't find any user that calls pm_runtime_barrier() first.

In case of multiple PM domains, it is even more complicated, as
dev_pm_domain_attach_list() (and pvr_power_domains_init(), which is
basically an open-coded variant of the former) creates a list of virtual
devices, which all need synchronization.  For the devres-enabled version
(devm_pm_domain_attach_list()), the caller cannot take care of calling
pm_runtime_barrier() anyway, so it has to be handled by the PM core?

> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -24,6 +24,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_clock.h>
>   #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/psci.h>
>   #include <linux/reset-controller.h>
>   #include <linux/slab.h>
> @@ -656,8 +657,10 @@ int cpg_mssr_attach_dev(struct generic_pm_domain
> *unused, struct device *dev)
>
>   void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct
> device *dev)
>   {
> -       if (!pm_clk_no_clocks(dev))
> +       if (!pm_clk_no_clocks(dev)) {
> +               pm_runtime_barrier(dev);
>                 pm_clk_destroy(dev);
> +       }
>   }
>
>   static void cpg_mssr_genpd_remove(void *data)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

