Return-Path: <linux-pm+bounces-17325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2599C3F8F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EF91F233CD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8819D078;
	Mon, 11 Nov 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaZyU7dG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD619D067
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331697; cv=none; b=ZC4C4DsDCWQHlyF5fzxqnj6QKBEBOxJe4RaR566nEl3KiJBwEHfjzU0/c1ZrGImRbEHgsdJMsePiXS6r15uo4Zv7R6DSLe+GIzPjMI4HlRU8FOVHpp6CQnZzHnW6D+s1rKKB9XBZrX3nhMfYR+0J0Q5gZmhQuXUgpLvY4565xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331697; c=relaxed/simple;
	bh=QA+UdmVAeLa1VBvB6rchMMzqUMFVoJt4nfDCtXXBIlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzjxq0PHgUVET4w+ciqYfdgEprKnGKekKAR5HbeOpqMmWD5XmrrymIlL6/FwPx7yHT07KA/7ryEHb9AB8Vlcww6OODmSaybNsA8Lm93LGvP6oE7cqylTt8RP9xQZg840mnRQZNM7TSdzqtAf4wxpfSwbY43Zu3x+0EFaVW6P1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaZyU7dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE1C4CED5
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731331696;
	bh=QA+UdmVAeLa1VBvB6rchMMzqUMFVoJt4nfDCtXXBIlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JaZyU7dGwspmK5ez/G8RKBn1XeIVVdFC5QX8oQnpfq06ztusogipW1kufCofj+W3E
	 NdiD9M7IfZRTayw2HYe/qKCYl5q50MtpxECNMwrZ6DrGfOV/L3HvYFaohpwJplk6EM
	 VTSjNmOXJVXoM0bTp5VPdZgb47TiO2kEBtFM35XhWn2eRo7YoigBxYcAGT5jeZ8Y6U
	 z2/ND5V3WfQQLIZsAj31EwxK/ppHoLPoSVRu8C8MGwYq0la1k0+oYIhOz9UWqdeM/H
	 kPmmHFZDJavpb1D3HOTV1MxKYGrtYOeFa8GN4ghaOqTfpgpHU7PmgnPgO7dQVoqDxg
	 Uy/3e9kvtxDXg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2887326be3dso1977553fac.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 05:28:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqwOqFGBAKq6xdCPIY3InJ6UiYoSVbHQr9Z1QWuJbUG+lLzj/YCscROFH8XmDi86sm5v43UBJrwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YY/M4xXLM6pjMR7QzPQQazJjFNLbHRN06+5JDx3V/TJjjMDk
	DU0zCpoDyppQ4wFga6lyKU453KKenHC/wJX1WP6crUaBaxz8guwq1Z69f8PxA6husQXyWxCJ8e7
	WY0NHupqrUVtMgTRnmWIajBiBUCI=
X-Google-Smtp-Source: AGHT+IGYgR8ourgCdqtWaq9Sms7fV0VS34c6acRTtQ+CE85dZjybhdxjOKmldO/dg1mzLHFs7QlfdsGO+dQDeW5yPEo=
X-Received: by 2002:a05:6871:a987:b0:270:449:291e with SMTP id
 586e51a60fabf-295603213camr8598049fac.36.1731331696069; Mon, 11 Nov 2024
 05:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB6129EDBF22F8A90FC3A3EDC8B9582@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6129EDBF22F8A90FC3A3EDC8B9582@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Nov 2024 14:28:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gpg7sd3Qx25WFSbGxFN6-nptxK+QtkHZMMtXW-dnaozg@mail.gmail.com>
Message-ID: <CAJZ5v0gpg7sd3Qx25WFSbGxFN6-nptxK+QtkHZMMtXW-dnaozg@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20241106)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Nikula, Jani" <jani.nikula@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
	"ricardo.neri-calderon@linux.intel.com" <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chaitanya,

On Mon, Nov 11, 2024 at 6:41=E2=80=AFAM Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Rafael,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in I=
ntel.
>
> This mail is regarding a regression we are seeing in our CI runs[1] on li=
nux-next repository.
>
> Since the version next-20241106 [2], we are seeing the following regressi=
on
>
> `````````````````````````````````````````````````````````````````````````=
````````
> <4>[    7.246473] WARNING: possible circular locking dependency detected
> <4>[    7.246476] 6.12.0-rc6-next-20241106-next-20241106-g5b913f5d7d7f+ #=
1 Not tainted
> <4>[    7.246479] ------------------------------------------------------
> <4>[    7.246481] swapper/0/1 is trying to acquire lock:
> <4>[    7.246483] ffffffff8264aef0 (cpu_hotplug_lock){++++}-{0:0}, at: st=
atic_key_enable+0xd/0x20
> <4>[    7.246493]
>                   but task is already holding lock:
> <4>[    7.246495] ffffffff82832068 (hybrid_capacity_lock){+.+.}-{4:4}, at=
: intel_pstate_register_driver+0xd3/0x1c0
> `````````````````````````````````````````````````````````````````````````=
````````
> Details log can be found in [3].

Thanks for the report!

> After bisecting the tree, the following patch [4] seems to be the first "=
bad"
> commit
>
> `````````````````````````````````````````````````````````````````````````=
````````````````````````````````
> commit 92447aa5f6e7fbad9427a3fd1bb9e0679c403206
> Author: Rafael J. Wysocki mailto:rafael.j.wysocki@intel.com
> Date:   Mon Nov 4 19:53:53 2024 +0100
>
>     cpufreq: intel_pstate: Update asym capacity for CPUs that were offlin=
e initially
> `````````````````````````````````````````````````````````````````````````=
````````````````````````````````
>
> We also verified that if we revert the patch the issue is not seen.
>
> Could you please check why the patch causes this regression and provide a=
 fix if necessary?
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20241106
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241106/bat-arls-1/=
boot0.txt
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20241106&id=3D92447aa5f6e7fbad9427a3fd1bb9e0679c403206

The problem is that cpus_read_lock() should not be called under
hybrid_capacity_lock because the latter is acquired in CPU
online/offline paths and this is exposed by the above commit, but if
I'm not mistaken, the issue is there regardless of it.

A good news is that is should be addressed by a patch that has been
posted already:

https://lore.kernel.org/linux-pm/12554508.O9o76ZdvQC@rjwysocki.net/

so please let me know if it makes the splat go away.

Even if its changelog says that it has no functional impact, this is
not really the case.

Thanks!

