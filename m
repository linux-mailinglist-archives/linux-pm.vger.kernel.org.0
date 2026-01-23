Return-Path: <linux-pm+bounces-41375-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKA1ELp8c2lowwAAu9opvQ
	(envelope-from <linux-pm+bounces-41375-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 14:50:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946F676760
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0D5301BF61
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD100279DC8;
	Fri, 23 Jan 2026 13:50:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657191FDA61
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176246; cv=none; b=TwcANyI0ZwjYxMyi60OplEI8v0UC5+giz4P8Vw7HFUW7XNVLGeWk1E3C/1WW3mLyD0W1Utpk7UszteU2TG8B0JqIRlF9xoN9rUwe7swJY5/07STKT67Ki8i/+cMGPUjwTmemza3PEHNsiF81xbwgdN0PinfQOIeWUjsQ8hx8z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176246; c=relaxed/simple;
	bh=0hwjiTdtsGb7eXLzTyw9ox8EL8oh0a8Wy0BY9afeh8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru3NGf0QKAKqogV4mM8UDo3+fdvzzl9/OUqQferksdY0gOrLX0zBnqFhKZLavwb+FkXo8xgOqFYQC8ZEr4jR7cjJKaVkTJEqR8yyHwq3IfuUiNAnu0mvo8ptksnzXKrLURH/CHV/XefDUU9KXYj9BdjK7pP68H/0DuhYrbEUVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eeaae02888so648648137.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 05:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769176244; x=1769781044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erKWy/OEWmr/yg9KkMYnuhF8IxKQ1EzG0rrpKtHiTIM=;
        b=h/SQeLv48CSfmBCqhilXaes6wjVQqhqJOoHPSoVeGdKxouC41r5UiGQ+2sTd0hQ1Xp
         UKV4jZT0U5ZSS/oY7HgDTEdY+ZR/Qi60E9SAfXTnyfpzXeY4THv89QggdRZVfXKWA7da
         LDX0yBINSSBJwHiTtbTAJ9NNBLaFddqkdYwuaZk1EQ1X5aLIxcVOGd5VCYpNK+CuDin1
         HGtidMtyHeXMAoN73HCMb6h/UVUiVdM8Um+BBfJ25Z3O+Txa6e+j5cNDzsCVNMVqZYnX
         ps5XZknwyqI2tLX1kNqi9C4WSTWO4wT4aGebM+4AVrexKFrm3fTW/yiqBHpH2I3Zy1Sr
         AzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6R7CWBEQCgl/O2mQvzg1SrfHpRnRWpY0Of35s6GRe/D3Zz0HU1Sd09lkJpyECQM2Uu+xU2hsMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TsAxyBNzVP/wBm098rSGxhk0LblpOBPfq8ma0bZ/nwlAxC9x
	DCEgjoc0N8ELZ8xxvp98N/M/jTLGGXOhlIxo0fCLEcOYjUkBhGUBLPtDX7x3H/mL
X-Gm-Gg: AZuq6aJf3PIMqoyuErWfufvo85UT1ABrYxA4ZpcHlc3I6Pntk9O2pLOSia3iIkJ4okn
	LEOUJazkMwdmxtrl+xlNUJXsAhnr09rlF0iCsTNhwNxIA0tSf/R5z2nnRn1t/PwOnG1gDqJGWVP
	2jHQ264uD7ugj4Aalx+T5840OsnebZJ8DnL6JjC5hgQznlCLL9QrcIlSNp/CxYIXuD0bIcqS1VA
	gLRzia9nbvWUCnTs637y58du7fTDW3jKQWDHAFDwTWnmDpii6wSO9fqe8UBAinwogVU495nt8vh
	IAQp+mZQbjIeophp6wV/dPZvX04ikwvAMdGapwABXGW07w7jOiTcdDCFjXzXbq30gNi/0uzmIJZ
	DRu85vvPwjrXislSb7pQQ0sH1wF4/3oqCT8BgYV++VykcapUQRYqfewycH5OlS8irM76yqcy2Xz
	evfftwTDbkkgcCoOhlI0A8j1D+f3vG1gJCRevLZAV5gAYDU7T0
X-Received: by 2002:a05:6102:41a1:b0:5f5:37f6:2b33 with SMTP id ada2fe7eead31-5f54bb10cf8mr764011137.13.1769176244132;
        Fri, 23 Jan 2026 05:50:44 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9482e3728edsm498335241.9.2026.01.23.05.50.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 05:50:43 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ee9fa419f5so460214137.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 05:50:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNkZu6txk1KBRnuAP6/eQO9FiGSUoEOMVAz/8jc/otIdR8gbYfiqliE8IRQeglnjLUQFHJbo4oeg==@vger.kernel.org
X-Received: by 2002:a05:6102:e07:b0:5ef:b5fc:dd48 with SMTP id
 ada2fe7eead31-5f54b994197mr835389137.9.1769176242766; Fri, 23 Jan 2026
 05:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <194465eda54d1f852a9226cf691ddc5aa208e0a3.1769097977.git.geert+renesas@glider.be>
 <ffdf3982-e22c-4d01-afa6-5449ed381000@imgtec.com>
In-Reply-To: <ffdf3982-e22c-4d01-afa6-5449ed381000@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jan 2026 14:50:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMh_oJFg-KtapcTDGvYWZ-hg_ZEJ2=E5Tp1apOEc8tnQ@mail.gmail.com>
X-Gm-Features: AZwV_QggHEVwIqc1kEtstmdEvFabNWQsOAWxfVgLAyebxcJ0E8lsdThbjxeQnuI
Message-ID: <CAMuHMdWMh_oJFg-KtapcTDGvYWZ-hg_ZEJ2=E5Tp1apOEc8tnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: Convert to dev_pm_domain_{at,de}tach_list()
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Frank Binns <Frank.Binns@imgtec.com>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>, 
	Alessio Belle <Alessio.Belle@imgtec.com>, Alexandru Dadu <Alexandru.Dadu@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41375-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[imgtec.com,mailbox.org,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,imgtec.com:email]
X-Rspamd-Queue-Id: 946F676760
X-Rspamd-Action: no action

Hi Matt,

On Fri, 23 Jan 2026 at 14:36, Matt Coster <Matt.Coster@imgtec.com> wrote:
> On 22/01/2026 16:08, Geert Uytterhoeven wrote:
> > Call the dev_pm_domain_attach_list() and dev_pm_domain_detach_list()
> > helpers instead of open-coding multi PM Domain handling.
> >
> > This changes behavior slightly:
> >   - The new handling is also applied in case of a single PM Domain,
> >   - PM Domains are now referred to by index instead of by name, but
> >     "make dtbs_check" enforces the actual naming and ordering anyway,
> >   - There are no longer device links created between virtual domain
> >     devices, only between virtual devices and the parent device.
>
> We still need this guarantee, both at start and end of day. In the
> current implementation dev_pm_domain_attach_list() iterates forwards,
> but so does dev_pm_domain_detach_list(). Even if we changed that, I'd
> prefer not to rely on the implementation details when we can declare the
> dependencies explicitly.

Note that on R-Car, the PM Domains are nested (see e.g. r8a7795_areas[]),
so they are always (un)powered in the correct order.  But that may not
be the case in the integration on other SoCs.

> We had/have a patch (attached) kicking around internally to use the
> *_list() functions but keep the inter-domain links in place; it got held
> up by discussions as to whether we actually need those dependencies for
> the hardware to behave correctly. Your patch spurred me to run around
> the office and nag people a bit, and it seems we really do need to care
> about the ordering.

OK.

> Can you add the links back in for a V2 or I can properly send the
> attached patch instead, I don't mind either way.

Please move forward with your patch, you are the expert.
I prefer not to be blamed for any breakage ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

