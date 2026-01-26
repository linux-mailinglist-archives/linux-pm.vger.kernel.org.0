Return-Path: <linux-pm+bounces-41451-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdnDCoxd2lVdAEAu9opvQ
	(envelope-from <linux-pm+bounces-41451-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:17:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A966585EB3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F463009140
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4611306489;
	Mon, 26 Jan 2026 09:16:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275572C08D5
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418961; cv=none; b=XdZ0LqbNqESAEhwCJlwe/Ha0+qqijEr1eBDlazhN0mrKsRKwi+wtW+Ct9ghtWnix6brnVbD8Jd6vL0Bx2za4ISlKdtW9hPKNLnNLU41hDrhP5Ofy79DR63brSY+Mxm7I6Xz54TN7YbE06y1718NUFzLPH30+BksvdfDai+nYJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418961; c=relaxed/simple;
	bh=d2s5PoOQAVaSt+MyTbx7UGGwO6+rfXIRXeEKt/FKfyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND11QvJROnIrmCdn29ocBQP+MDfkBocEUUcWOYi18YfPTO5TdGBBPH2aIMM5fIqFs4v+x+omuJu8UWCg36RzcGJNBjQBVq5sI6wGysIWCU0ML1kSTxbba8n2NLYP4KPuXpp8hhOLST7C/SJEfneirwyO8RTNfCaohVy97miL4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f547823192so1164836137.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 01:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418959; x=1770023759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQaOzj2tKnU8ORNYpG6usL1AFHimKPjCyXKjxferGL0=;
        b=VoKPT1eoZXRZLhB+Z0fMEB2I9IjhT4La/Nf7AxajRJzbqRfYlb/V+zOoqdtJ+MDoJQ
         dgyxk9ZQwNWmvfIZAlD3Yhpt0EucHzE785LKIFDW5a4YxyYl27h2pzsdEQUVRe5UVzxy
         Xvvpi4lSspGT7ZH4C0aHrVyELe4KU91fwou81cpRh0W91lC0hXtOeO8Hucsis382FAkc
         jyrL7GELocvQktXk/7B6Wep/JNQDtiCKNbLYmcHiMqAxVM6RHe0Sen/fwyJxPnWlsfXa
         eEx0zCL//ZJu50PtXd51qu41nmSQY7zq3i5ufChkWo5Yu7TlWthn0ZemQEUuslUN9w5b
         Wzdw==
X-Forwarded-Encrypted: i=1; AJvYcCUNdkEZnsGJAXjdplOyMAdLXS0sda3K8Z9gU0Gdh8C5ymx8+g9VYuHRg0P8cpzgPfYSp4faB3Tbhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/33mFFT9bUH65sCNJjKq5R/gfypPLoczTF3lWP+zqMZT3FprZ
	Ucsu6gtVnI6BWemJCj6zFleL8ZBOL39KgyFsQ4Q4Ri4U9evTGJ/77yWmFom0rNGw
X-Gm-Gg: AZuq6aI1RU/w0BQvQKbo9YKHRpYJWfMcmt88lQI/yI3SNG8t7Ict3hDPo7DGeh2mP3l
	Dk3Y5q18mEXqmIuGF/P0JMEcoFM5Vw+NaP3ckEhxVzTWAq8loJiTitx5UE8OiaksDo88aFbHd0h
	XMozA8/wM2AK3m7eMbW6sAEK03hBGz48Dc5z3aUAvET1hGm5eVgvTkskTd3XV7UWG0kcplbX+hl
	98hyU2llq4hGhEyjXu/6fIl/dMdC15UujNz7CY0wHs5l6L80NtULOHKWj12XCMRzOT26uY8yqFJ
	nKeVIJg1a5Ib/5rEJQuxC6KlJtd3IArl+7m8M3Frt15lqryDESYnwBeuLJEZMUugptez7ltdZGp
	GnARJI2uZhha0WZYUqnfID9dDAoqH42s2mNDUFnwU4epfnYPHHf+LBOvu78Mdqh+uAFmJVF95cD
	wwmZjUt+n4vO19dqisse38bvaO2lty9qKqfiHzzOfpTJxXE6Oi
X-Received: by 2002:a05:6102:1562:b0:5f5:7718:72e9 with SMTP id ada2fe7eead31-5f577187855mr659096137.2.1769418959044;
        Mon, 26 Jan 2026 01:15:59 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9482e2aa79asm1860023241.2.2026.01.26.01.15.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 01:15:58 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f56a97064so843107241.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 01:15:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlwN3eh5RpfmrwxVPS+UvcpuKz57FqCjog0elgMsFiX8qD+ITL4Ic/QQe+Z7VVJCuu+e+cMNN7+Q==@vger.kernel.org
X-Received: by 2002:a05:6102:f0e:b0:5f5:33e4:12ea with SMTP id
 ada2fe7eead31-5f576493c1bmr1088062137.31.1769418957878; Mon, 26 Jan 2026
 01:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <0e9f963b-00e0-43d1-b567-cb10b8f66df1@mailbox.org> <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
 <9efa9daa-6584-44b3-8055-bc160e46d8a5@mailbox.org>
In-Reply-To: <9efa9daa-6584-44b3-8055-bc160e46d8a5@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jan 2026 10:15:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqqRJnY+ATZdzw1=XnmXUko3+wPhKtT+PVP+CRmdFAYg@mail.gmail.com>
X-Gm-Features: AZwV_Qj2iYTeK4T2fVq6WUyIHg21dwOYiE1pJSzFBFBrBjhDjig-MNpg9IvarOQ
Message-ID: <CAMuHMdWqqRJnY+ATZdzw1=XnmXUko3+wPhKtT+PVP+CRmdFAYg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41451-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A966585EB3
X-Rspamd-Action: no action

Hi Marek,

On Mon, 26 Jan 2026 at 00:18, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 1/22/26 4:35 PM, Geert Uytterhoeven wrote:
> >> Can you please test this change and see if it fixes the problem ?
> >>
> >> The barrier should guarantee that the domain is settled and no more
> >> callbacks are still running.
> >
> > Thank you, that indeed fixes the issue!
> >
> > However, I am not so sure this barrier belongs in the .detach_dev()
> > callback.  The documentation for almost all dev_pm_domain_{at,de}tach*()
> > functions states:
> >
> >       * Callers must ensure proper synchronization of this function with power
> >       * management callbacks.
>
> Isn't cpg_mssr_detach_dev() the caller in this case ?

No, cpg_mssr_detach_dev() is merely the generic_pm_domain.detach_dev()
callback, which is called eventually from dev_pm_domain_detach().

End users like pvr_power_domains_{fini,init}(), and the helpers
dev_pm_domain_{at,de}tach_list() call dev_pm_domain_{at,de}tach*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

