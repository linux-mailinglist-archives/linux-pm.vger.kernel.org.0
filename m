Return-Path: <linux-pm+bounces-25375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FDFA885BA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5151661D1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790127A10E;
	Mon, 14 Apr 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSqHFpWK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA91F37D4;
	Mon, 14 Apr 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641384; cv=none; b=Acse0Ht5SO5z8Iv4mh8tLE6UT8hrv0K5drbc0pOjrXNjk6txhjS6WrNIUDfQs3ENWQFxkwsh50S9ii62kA4+cI+JfCBub5mjm8I65HwaLQ3wOAIRNleLoghisuHuzpX3aqk3F1RLw0NbaSBw0v27GfzTPM6h/eMWMZXsN7fP4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641384; c=relaxed/simple;
	bh=nrV+ff/4Zsqe1OiHEbQ5jdzzs0yyxDXwPLLfpWEaJAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0L2y7z5TZS7QwSYWQxKYfFp1aOgCPKKf5oTcmCVTh6Kjw80vgzsXPWeG/7FEmMPKQ9otx+srVpIwod4ZEuFoC5ATFyL8iWGuo0XF8wjO/bbpKHgG6PrxJG1aZ5IdIKYTbrXUlpmusi+fU833+PhTCaG0/2IVMC8YWgxaGGvc7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSqHFpWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BF5C4AF09;
	Mon, 14 Apr 2025 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641383;
	bh=nrV+ff/4Zsqe1OiHEbQ5jdzzs0yyxDXwPLLfpWEaJAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSqHFpWKzBydsplsyAqinwBzPLm2vgWTxyyALEKOYxEcM8uWqc/APILhlwCzbvpY/
	 psR6rEpJOp5fQhm2Ji1OuBg5Tq8EWSTpDvClQBAAraDHHWMKbjDe3DFI7ytVz+G3de
	 pKtODgMFbeIEbfXbGPidmvMbTtlU1k3EDAozKu7om+0Qj2jhmunRmd8gS1R0FnNPSz
	 INPN/R5dCLXKN6dZDLFIbWYfZBFZ40TNiiupP1glgKrNa8BVUK2cbF+7pqJvLG7oj9
	 jJq1AAnKqw1jZ3g2uqp+eKY9PAHQUZFt24wRQowaBSQAeggDtvWYyYUtNyQgao4NVN
	 LM5LHsYwu0YNQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1240422fac.2;
        Mon, 14 Apr 2025 07:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4yShzIm2KOFncek9VjBaqToNp8uQQAoSiFzov+P1mvAI56nhv36U0boieg9pW3NkdCL2h9gdXlSDTZYo=@vger.kernel.org, AJvYcCUSH5YNKfZAH31wxz1EG7jS7tSVKtc2kAtEkbkhlMzryrKVO4xdkH3SVFewCbFslMHt5XJ17azOJxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbF8L0UA2QKjq2FB+5OawXTa/9MprU2pMjQIJkimvkzmlkOvS
	4lHiyzCfCbnes3kwZ/CGnlbzq9slouuuEZnboAbJJlXXvq2B/XRXrCzbq/N6X+tfcLsbXvl/6my
	axfNrwNvCs+B9T2ipBDTvNjbpAbQ=
X-Google-Smtp-Source: AGHT+IGeQv/o7d858SFeO3JgZi2SoPNZpw0OxiXEP96Rygs1PrjM1v10F5qspypCcZrIDSbx9sRpYoP1ux+cPab1IX4=
X-Received: by 2002:a05:6871:6308:b0:2c1:5b95:5f1b with SMTP id
 586e51a60fabf-2d0d5d9e30bmr6566202fac.23.1744641382715; Mon, 14 Apr 2025
 07:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411152632.2806038-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250411152632.2806038-1-kernel.org@pileofstuff.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Apr 2025 16:36:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6ifYTZyPMTzMhM4r-2VkJJ=OeXo+x3aE_zu-Q-a=Paw@mail.gmail.com>
X-Gm-Features: ATxdqUHC_JfSRY9vYjZK486brpB9NL9DVemjS4l3qn5PQJu6hM624usS1sJpHhw
Message-ID: <CAJZ5v0g6ifYTZyPMTzMhM4r-2VkJJ=OeXo+x3aE_zu-Q-a=Paw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Use two lines for "Restarting..." / "done" messages
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Todd E Brandt <todd.e.brandt@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 5:27=E2=80=AFPM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> Other messages are occasionally printed between these two, for example:
>
>     [203104.106534] Restarting tasks ...
>     [203104.106559] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b6=
27f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>     [203104.112354] done.
>
> This seems to be a timing issue, seen in two of the eleven
> hibernation exits in my current `dmesg` output.
>
> When printed on its own, the "done" message has the default log level.
> This makes the output of `dmesg --level=3Dwarn` quite misleading.
>
> Add enough context for the "done" messages to make sense on their own,
> and use the same log level for all messages.
>
> Change the messages to "<event>..." / "Done <event>.", unlike a449dfbfc08=
9
> which uses "<event>..." / "<event> completed.".  Front-loading the unique
> part of the message makes it easier to scan the log, and reduces ambiguit=
y
> for users who aren't confident in their English comprehension.
>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
> v1 -> v2: mentioned a449dfbfc089 in commit message (thanks Lucas De March=
i)
>
>  kernel/power/process.c             | 8 ++++----
>  tools/power/pm-graph/sleepgraph.py | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 66ac067d9ae6..4c674282df03 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -189,7 +189,7 @@ void thaw_processes(void)
>
>         oom_killer_enable();
>
> -       pr_info("Restarting tasks ... ");
> +       pr_info("Restarting tasks ...\n");
>
>         __usermodehelper_set_disable_depth(UMH_FREEZING);
>         thaw_workqueues();
> @@ -208,7 +208,7 @@ void thaw_processes(void)
>         usermodehelper_enable();
>
>         schedule();
> -       pr_cont("done.\n");
> +       pr_info("Done restarting tasks.\n");
>         trace_suspend_resume(TPS("thaw_processes"), 0, false);
>  }
>
> @@ -217,7 +217,7 @@ void thaw_kernel_threads(void)
>         struct task_struct *g, *p;
>
>         pm_nosig_freezing =3D false;
> -       pr_info("Restarting kernel threads ... ");
> +       pr_info("Restarting kernel threads ...\n");
>
>         thaw_workqueues();
>
> @@ -229,5 +229,5 @@ void thaw_kernel_threads(void)
>         read_unlock(&tasklist_lock);
>
>         schedule();
> -       pr_cont("done.\n");
> +       pr_info("Done restarting kernel threads.\n");
>  }
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sl=
eepgraph.py
> index e2261f33a082..1555b51a7d55 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -4017,7 +4017,8 @@ def parseKernelLog(data):
>                                                         'PM: early restor=
e of devices complete after.*'],
>                 'resume_complete': ['PM: resume of devices complete after=
.*',
>                                                         'PM: restore of d=
evices complete after.*'],
> -                   'post_resume': [r'.*Restarting tasks \.\.\..*'],
> +                   'post_resume': [r'.*Restarting tasks \.\.\..*',
> +                                                       'Done restarting =
tasks.*'],
>         }
>
>         # action table (expected events that occur and show up in dmesg)
> --

Applied as 6.16 material, thanks!

