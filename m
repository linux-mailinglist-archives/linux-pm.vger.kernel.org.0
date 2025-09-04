Return-Path: <linux-pm+bounces-33888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA305B446F7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 22:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B12188BA74
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8227A928;
	Thu,  4 Sep 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvOkBsqE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B47277030;
	Thu,  4 Sep 2025 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016393; cv=none; b=VoZuBtgI9G06s6xCR/2uoOmhfMKb4ulTLOVkdSCZHlQBpDDS6c9WTDILInL8T49jqkH08SKoIWvN1hy91vPLX/6X+F0x01BvUNjdd02t/ZAadz7DDl9PUHmA+9tIKwznT3m+xPT/lG7mWLQ0/bkWrTFf19pelzW7V7EsOE2PaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016393; c=relaxed/simple;
	bh=8sflmMM9VERUA+boqGi1GL6vzSZZVoB8dkgxOo5XWdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mabe0KdEIFeq+DiHJfKing5kFzpjK9u5BiXb6bN/VrDWnW36T/7hDXajZJmliEJ9rUXE6qMce6m1FL3xmp4LxS+QAAuj0CVD5tivUym3KZVLEMT+fHKz1Dd/qPkSCSdAOv6b/Oje7lULspOk2/R1dUWjiq9tiAOiTQ3W6LJKKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvOkBsqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61044C4CEF0;
	Thu,  4 Sep 2025 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757016392;
	bh=8sflmMM9VERUA+boqGi1GL6vzSZZVoB8dkgxOo5XWdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YvOkBsqEiJQMrYCg5s3O05y+7UzRW9N5WIqKeVib4Cj6zb0e9W0KVF4vhOlEcbnRu
	 3CUEsB16xTmbDkCaZpefKBt4PGkYkAF/Clgzg4/FXibqmrP/kbDqyQN4rEaDwTdNTB
	 Rf+hbYuBs8kz72P3Rn8E7EDNYAJ7kYm4FL0qKzaSxUdzc53jYoIRuI5p+3JsiFsOX/
	 SRiIxTfwGdu+4eYaslN1hA3hiObpdGF/bJuQ/69gsyPDMwSaPG9xwU+wFXOH1yMKOm
	 OJYt3cYmBcqB9aHKKMjHq48NX1aZiRVsw4zdepgcPLBjHKqOrNWeXCzPknZLuFSvf8
	 ykINLc6pMOHRA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7456b27fac1so1563672a34.2;
        Thu, 04 Sep 2025 13:06:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4VZ5bJweBRDzfxU9dZfIHcXGOPaJtKggcAlxG8n3txYlwEPW98jOz1Mc4C5vBEa3PgSopthcTdXI=@vger.kernel.org, AJvYcCXTOiUMUU70mXEdyg+LnJoBCynzrerpnXrBANKuauIImWdgO+XirRI3Nb4lwB0aK9qsmiog1Ehqzf83sdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35crRml58WrelNUsnlq+FX9K7pv8Px0W6re0jDQBEBXHsg3Hy
	cC8zkZwMOPnF4Qrospq9HyGH1lJ2UvXW9YXXtWlD9773Qd5ZAM+IxxYZrE/aqlFQfJX7T9KTY29
	FccdzgQZ8O1DxyWECA/wA6eZd5iKixzU=
X-Google-Smtp-Source: AGHT+IFmwswv9DnPxP2er9PFfSzw0atJNw24WOUl7SUel+Fn6ts15ddcSScUEhJejvARV/If4bjRsBN7UNW5wb65FpI=
X-Received: by 2002:a05:6830:82f2:b0:746:d22b:11f2 with SMTP id
 46e09a7af769-746d22b1b32mr1430823a34.4.1757016391707; Thu, 04 Sep 2025
 13:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828034646.10700-1-tuhaowen@uniontech.com>
In-Reply-To: <20250828034646.10700-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 22:06:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hekD1PyC4BrX7HCO2hTZhyTGSyjfQYXY5r5v3QMQfscw@mail.gmail.com>
X-Gm-Features: Ac12FXxsZKiEN2e_hCBDWZMIH7MjBykmdvz6PA47uOJM9tbif_moxUYZYtvTyjA
Message-ID: <CAJZ5v0hekD1PyC4BrX7HCO2hTZhyTGSyjfQYXY5r5v3QMQfscw@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: Add configurable sync timeout to prevent suspend hang
To: tuhaowen <tuhaowen@uniontech.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	huangbibo@uniontech.com, Saravana Kannan <saravanak@google.com>, 
	Samuel Wu <wusamuel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:47=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> w=
rote:
>
> When users initiate suspend while large file copy operations are in
> progress (especially to USB storage devices), the system can appear to
> hang with a black screen for an extended period. This occurs because
> ksys_sync_helper() in the suspend path blocks until all pending I/O
> operations complete, which can take several minutes for large file
> transfers.
>
> This creates a poor user experience where the system appears
> unresponsive, and users may force power off thinking the system has
> crashed.
>
> This RFC proposes adding an optional timeout mechanism for the sync
> operation during suspend. The implementation includes:
>
> - A configurable timeout (default: 60 seconds, disabled by default)
> - Module parameters for runtime configuration:
>   * sync_on_suspend_timeout_enable: Enable/disable the timeout feature
>   * sync_on_suspend_timeout_ms: Configure timeout duration
> - Uses a separate kernel thread to perform sync with timeout monitoring
> - On timeout, suspend is aborted with clear error messaging
> - Maintains backward compatibility (disabled by default)
>
> Questions for the community:
>
> 1. Is this approach acceptable for addressing the user experience issue?
> 2. Are there better alternatives to handle long-running sync operations
>    during suspend?

Yes, please see
https://lore.kernel.org/linux-pm/20250821004237.2712312-1-wusamuel@google.c=
om/

> 3. Should the default timeout value be different?
> 4. Any concerns with the implementation approach?
>
> The feature is disabled by default to ensure no regression in existing
> behavior. When enabled, it allows users to abort suspend if sync takes
> too long, providing immediate feedback rather than an apparent system
> hang.
>
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
>  kernel/power/suspend.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8eaec4ab1..feb1583c5 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -30,9 +30,25 @@
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +#include <linux/jiffies.h>
>
>  #include "power.h"
>
> +/* Sync timeout parameters */
> +static bool sync_on_suspend_timeout_enable;
> +module_param(sync_on_suspend_timeout_enable, bool, 0644);
> +MODULE_PARM_DESC(sync_on_suspend_timeout_enable, "Enable sync timeout du=
ring suspend (default: false)");
> +
> +static unsigned int sync_on_suspend_timeout_ms =3D 60000;
> +module_param(sync_on_suspend_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(sync_on_suspend_timeout_ms, "Sync timeout in millisecon=
ds during suspend (default: 60000)");
> +
> +/* Sync timeout implementation */
> +static struct completion sync_completion;
> +static struct task_struct *sync_task;
> +
>  const char * const pm_labels[] =3D {
>         [PM_SUSPEND_TO_IDLE] =3D "freeze",
>         [PM_SUSPEND_STANDBY] =3D "standby",
> @@ -61,6 +77,40 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>
> +static int sync_thread_func(void *data)
> +{
> +       ksys_sync_helper();
> +       complete(&sync_completion);
> +       return 0;
> +}
> +
> +static int suspend_sync_with_timeout(void)
> +{
> +       unsigned long timeout_jiffies;
> +
> +       if (!sync_on_suspend_timeout_enable) {
> +               ksys_sync_helper();
> +               return 0;
> +       }
> +
> +       init_completion(&sync_completion);
> +       sync_task =3D kthread_run(sync_thread_func, NULL, "suspend_sync")=
;
> +       if (IS_ERR(sync_task)) {
> +               pr_warn("PM: Failed to create sync thread, performing syn=
c directly\n");
> +               ksys_sync_helper();
> +               return 0;
> +       }
> +
> +       timeout_jiffies =3D msecs_to_jiffies(sync_on_suspend_timeout_ms);
> +       if (!wait_for_completion_timeout(&sync_completion, timeout_jiffie=
s)) {
> +               pr_warn("PM: Sync operation timed out after %u ms, aborti=
ng suspend\n",
> +                               sync_on_suspend_timeout_ms);
> +               kthread_stop(sync_task);
> +               return -ETIMEDOUT;
> +       }
> +       return 0;
> +}
> +
>  /**
>   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default s=
uspend.
>   *
> @@ -585,8 +635,12 @@ static int enter_state(suspend_state_t state)
>
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D suspend_sync_with_timeout();
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +               if (error) {
> +                       pr_err("PM: Sync timeout, aborting suspend\n");
> +                       goto Unlock;
> +               }
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> --
> 2.20.1
>

