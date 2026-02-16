Return-Path: <linux-pm+bounces-42686-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAX+GVHbkmn3zAEAu9opvQ
	(envelope-from <linux-pm+bounces-42686-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 09:54:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C4141B5E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F1D30097C7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5414E2798EA;
	Mon, 16 Feb 2026 08:54:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A72749D5
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232078; cv=none; b=uZ+hp1P+UhycjyPrfHACmLS3LJqDd9a0N29R4fkyBtvq4pUgnWVyVeivD+DfDse/Olfb+En087qn8Y+J/5ifz+L3K+3jytDoRLTyt3RHhGem5luTweDBJUp5DbI/yi5ZGpyQLxEvQqITgeLlrGYnayKCg1tbbvpyTNaJhaXx+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232078; c=relaxed/simple;
	bh=xe6iy91Dnkp2s7PGFf6JlSYAsMMbjCE4ZJ2vNs/NJvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og8ZdyhMbsRFReL5sOdxQV/IzAZPlELbYe8yclkH0n2kCI9jhJE67WilZsgD/628LUQdzmlbprNo6EBVSdtoxXPNsDZMcKtWKHxJYQ3wZuP3/TkglmkT2Y+R9c8KzQfE1JD1ewc3UTFVohdO80z9KESlwZupt6v9SuLqlBAPZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso1291360e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 00:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771232075; x=1771836875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amIuxySa6dDUHXa+BAvlMLYYKh0V6dJe17/ltsM6dbs=;
        b=k5SE7Of/52qt7VOI4PCqD2cqzqrXUd9ydwNX7xKUVzSyNFr2O4UNyHpb7hUnZzIstR
         7Eb759IqUIsvxe5Xn2meGRHu/ebJb44pBMXkOrmY/7NP0L4TcarDP9DP7XGJgILnJv7K
         rQ8S3+BF+xi8GoT165RW1Lk5hqmZ8it8iS51mlkcAfyCMAnQ1UNxLOC7icgdLMlWLLdj
         ScjAQVmu8r546oC7DpvoD+kbdjEGJeuIQlV41iC8m4SABTZoY3llm4/pNjxUlGmjq+v4
         XRcHBYWIh1oTd8KkuGNYRQEQP7uHDJw+PBL9EYeftbUzoknfoo+bPUBTs03NdVTJgcAu
         QtGg==
X-Forwarded-Encrypted: i=1; AJvYcCVA0HvIDvpCz9aGsXr46/BhT2N1kb04SGcylULqhAJLmUs8+C/nVV964iWRsYY6F0m+Aw16svtGqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUESWg6HlD+LCFVueeIP/iXInj5axL7dUmevgy1ldyPgRH5Y4
	SwYn1TwaGc/UxNfqIxuAIYpzizuytE9yZnBU7v4EOu7TeWEjBS4WRvSs2a4ayb82
X-Gm-Gg: AZuq6aJuUN5aAf3s+WzssIltDpxOuPyXY/TKdnkJJOyoe+nzPH2mO3lCQ8B8JC443Kh
	jAwZyjc0R18pALpBcAYz/64vvKfz6CCW2p3s8pkXdIwuVJlkbh1mAJnZDuUhdaAykoCBhMYoy2z
	nMdJSQ7SMRj+C+bCzI3N7yJw0XznV43BIpYh4K3MtY+boXucvja4XTxGPgYFDme3MPYPJ1HmBP7
	jxwh58XnJevA7TS52hbONsdLvxOpeUy6SKihvytjLBZSwmxKF5OXBrVoaGWkJj5QzzBIF3lPUr/
	vK3OUfNKN2ne0G21qADV4SZ5H3HLAdJnC6XhPTBOa6rK9WNZ8XucnFXDRvt5N52tS5jTXFTcbBD
	Gofz661ZsuE+Dq2rLOTqLUElJH5lQkdniumAWTEfhVWvRc6SkohKe7foPtAUAhtgnKhhja2MAFg
	bkbXDnvGHyDztt7QxDXspFIk1W6RqhluKR5R/2sSyNmkY8MmH9X3E2mcc+V++E
X-Received: by 2002:a05:6122:178e:b0:566:21af:5d78 with SMTP id 71dfb90a1353d-5676a923ad6mr2734083e0c.10.1771232075559;
        Mon, 16 Feb 2026 00:54:35 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd33f622sm7858462241.10.2026.02.16.00.54.35
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 00:54:35 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5fdb47d6131so498217137.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 00:54:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAiJvZRrmj6l4N0clw2XDO0z/9eTa8iCjF/pAm5LEneJ9dABYIIgANjSE5lIAp+M7O6xDuwtg1dA==@vger.kernel.org
X-Received: by 2002:a05:6102:5110:b0:5ef:bd3a:ab1f with SMTP id
 ada2fe7eead31-5fe1afbda79mr3606828137.34.1771232075129; Mon, 16 Feb 2026
 00:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <0e9f963b-00e0-43d1-b567-cb10b8f66df1@mailbox.org> <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
In-Reply-To: <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 09:54:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU-jRhW65cxeApFbCK+XgRazPOTABcbmBC3J38pwXfzJQ@mail.gmail.com>
X-Gm-Features: AaiRm53fj_d9e6w8NbwYy6InUSZHagi7WeBARKJlpME8J2ANfsii8ZwJtSbH60k
Message-ID: <CAMuHMdU-jRhW65cxeApFbCK+XgRazPOTABcbmBC3J38pwXfzJQ@mail.gmail.com>
Subject: Re: drm/imagination: genpd_runtime_suspend() crash
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	TAGGED_FROM(0.00)[bounces-42686-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: B72C4141B5E
X-Rspamd-Action: no action

Hi Ulf, Rafael,

On Thu, 22 Jan 2026 at 16:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, 3 Jan 2026 at 19:25, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > On 10/29/25 3:08 PM, Geert Uytterhoeven wrote:
> > >       default_suspend_ok+0xb4/0x20c (P)
> > >       genpd_runtime_suspend+0x11c/0x4e0
> > >       __rpm_callback+0x44/0x1cc
> > >       rpm_callback+0x6c/0x78
> > >       rpm_suspend+0x108/0x564
> > >       pm_runtime_work+0xb8/0xbc
> > >       process_one_work+0x144/0x280
> > >       worker_thread+0x2c8/0x3d0
> > >       kthread+0x128/0x1e0
> > >       ret_from_fork+0x10/0x20
> > >      Code: aa1303e0 52800863 b0005661 912dc021 (f9402095)
> > >      ---[ end trace 0000000000000000 ]---
> > >
> > > This driver uses manual PM Domain handling for multiple PM Domains.  In
> > > my case, pvr_power_domains_fini() calls dev_pm_domain_detach() (twice),
> > > which calls dev_pm_put_subsys_data(), and sets dev->power.subsys_data to
> > > NULL when psd->refcount reaches zero.
> > >
> > > Later/in parallel, default_suspend_ok() calls dev_gpd_data():
> > >
> > >      static inline struct generic_pm_domain_data *dev_gpd_data(struct
> > > device *dev)
> > >      {
> > >              return to_gpd_data(dev->power.subsys_data->domain_data);
> > >      }
> > >
> > > triggering the NULL pointer dereference.  Depending on timing, it may
> > > crash earlier or later in genpd_runtime_suspend(), or not crash at all
> > > (initially, I saw it only with extra debug prints in the genpd subsystem).
> >
> > I came to the same conclusion when revisiting it yesterday and today.
> >
> > The power 3dg-{a,b} domains are in RPM_SUSPENDING state, the
> > __rpm_callback() is running and it unlocks dev->power.lock spinlock for
> > just long enough, that the pvr_power_domains_fini() can issue
> > dev_pm_domain_detach() and then dev_pm_put_subsys_data() , which unsets
> > subsys_data, which are later still used by the __rpm_callback() (really
> > the genpd_runtime_suspend() -> suspend_ok() it calls for this domain).
> >
> > But, I wonder if the problem is actually in the CPG MSSR clock domain
> > driver. The pvr_power_domains_fini() dev_pm_domain_detach() really calls
> > cpg_mssr_detach_dev() which calls pm_clk_destroy() and that invokes the
> > dev_pm_domain_detach() which unsets the subsys_data . The
> > pm_clk_destroy() documentation is explicit about it unsetting the
> > subsys_data .
> >
> > I wonder if what we need to do instead, is patch the CPG MSSR clock
> > domain driver such, that it would surely NOT call pm_clk_destroy()
> > before the domain transitioned from RPM_SUSPENDING -> RPM_SUSPENDED
> > state and surely is done with all its __rpm_callback() invocations ?
> >
> > Can you please test this change and see if it fixes the problem ?
> >
> > The barrier should guarantee that the domain is settled and no more
> > callbacks are still running.
>
> Thank you, that indeed fixes the issue!
>
> However, I am not so sure this barrier belongs in the .detach_dev()
> callback.  The documentation for almost all dev_pm_domain_{at,de}tach*()
> functions states:
>
>      * Callers must ensure proper synchronization of this function with power
>      * management callbacks.
>
> However, I couldn't find any user that calls pm_runtime_barrier() first.
>
> In case of multiple PM domains, it is even more complicated, as
> dev_pm_domain_attach_list() (and pvr_power_domains_init(), which is
> basically an open-coded variant of the former) creates a list of virtual
> devices, which all need synchronization.  For the devres-enabled version
> (devm_pm_domain_attach_list()), the caller cannot take care of calling
> pm_runtime_barrier() anyway, so it has to be handled by the PM core?

Any guidance from the PM people?
Thanks!

> > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_clock.h>
> >   #include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/psci.h>
> >   #include <linux/reset-controller.h>
> >   #include <linux/slab.h>
> > @@ -656,8 +657,10 @@ int cpg_mssr_attach_dev(struct generic_pm_domain
> > *unused, struct device *dev)
> >
> >   void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct
> > device *dev)
> >   {
> > -       if (!pm_clk_no_clocks(dev))
> > +       if (!pm_clk_no_clocks(dev)) {
> > +               pm_runtime_barrier(dev);
> >                 pm_clk_destroy(dev);
> > +       }
> >   }
> >
> >   static void cpg_mssr_genpd_remove(void *data)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

