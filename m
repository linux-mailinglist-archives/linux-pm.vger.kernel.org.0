Return-Path: <linux-pm+bounces-33118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B76B3651A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916751C232DF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A6265CC0;
	Tue, 26 Aug 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGOZ+Is0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55C230BDF;
	Tue, 26 Aug 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215427; cv=none; b=YZiQraZcXoIwWlwH1B66AplVIWz0Zhh+x5kpHGAMMXO4B7jAfqJSkT7OqXF4N3STZjls3NoO/LZ8pQTydMLKqipGeLpKt8wMluP+PBpfTua3Lk2ugP1wpB9h+9g0CoIBLQI0OnA68My0Ea7NhG94EV/IGDQdQgOa+n3dZTW74FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215427; c=relaxed/simple;
	bh=8M7YAVuNf3+OnTHECQIBp5YKUd7sUHQXKzXvo+EqrvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp3HpTeqD5Qv/kNhVv22iwYOhfHlaS8TFhNANLTtPHB80Hgzc9yB1FJcjzC2xh5+wZ3oeOmfTlhPyfx9wIbYWOAuoFkcxJrv5/b10VV324A53IBeEtWzJC4g4fpYosdjsOH6J87m9W/mCyeK4R90jgLMgSzYkf9fh9hSTMZnfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGOZ+Is0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC4EC4CEF1;
	Tue, 26 Aug 2025 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215425;
	bh=8M7YAVuNf3+OnTHECQIBp5YKUd7sUHQXKzXvo+EqrvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGOZ+Is076lcj1ncK+PJQnHYxIzFgzLHPEnPdYqDIZ2zcs1tOamt5kNVOft6rHKnt
	 Rc494dqcJTQneTqpwq9oJV0iLAHY07nbEF8AlhYpgtY50czjuriAgG87qlDYyizUoE
	 WY47Bl2jnYXPnNLDq5g0y8JrQXtZmSlhCdXwK/ogU6yfkpeBwDGqWO7t24XBxoT9yU
	 fowGmOLhRT/YmXH6u2zqIjN4KL2Pk4g7QMqxVLOIK674dKvTqdPX5PdaRt6lmVM41t
	 TFNID3WOmMku5QTr6ctSMQvpt9OjEkxYuGlWLKutgYoH9DodE8xxKnDS3Zf5dWD6x/
	 YtWm//PGqzWSA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-314f332e064so1355352fac.2;
        Tue, 26 Aug 2025 06:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIzs27lDtt0EmM4OxY1u22voOSLX7nYGH0F23L/88O7hFnLeUZIrRSfFHuuSWs6QyHusVFd8jjZa4=@vger.kernel.org, AJvYcCUagT4xOtRF22a461fbBtYR1aW1bNI1JZsShu/1zUOEuCbRpj2hUbZWJpKXJlpYQctG0ddAHTctKcUda/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7skzma7g1eywVeO8fLiy7d8MqOOZQfuUwM7tOap/3E/adgKB
	6qiD/dvTcOPlHXSspp51mIracxtsOJXIMAcDFadAF0zavxnqS+321dV5jGfipBRRVS1MMC4Czmd
	fnXRkwtwZbqAf2ICaSJQWjHd9IaJqGC4=
X-Google-Smtp-Source: AGHT+IFF19mnpnPUaywKVuEOwma6buyrYvhpGayGryKq3CK9yEkqRJ3NQsAsf0p0TtmtfgXfp7srxai1RDC7GmJnc1Y=
X-Received: by 2002:a05:6870:95a0:b0:302:523a:1799 with SMTP id
 586e51a60fabf-314dcb53635mr7019608fac.11.1756215425177; Tue, 26 Aug 2025
 06:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826134348.aba79f6e6299.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
In-Reply-To: <20250826134348.aba79f6e6299.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Aug 2025 15:36:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOibiTMpzPGb27YtPRkKF0jdbE7TNOW_ceUk1Ov5abWg@mail.gmail.com>
X-Gm-Features: Ac12FXzhxech20T9_N2Y0w4NZJqtOYxrdbW6F3NJS8hQEKvzBiMWcbX2IciobFg
Message-ID: <CAJZ5v0iOibiTMpzPGb27YtPRkKF0jdbE7TNOW_ceUk1Ov5abWg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: annotate RCU list iterations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:43=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> These iterations require the read lock, otherwise RCU
> lockdep will splat:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: suspicious RCU usage
> 6.17.0-rc3-00014-g31419c045d64 #6 Tainted: G           O
> -----------------------------
> drivers/base/power/main.c:1333 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 5 locks held by rtcwake/547:
>  #0: 00000000643ab418 (sb_writers#6){.+.+}-{0:0}, at: file_start_write+0x=
2b/0x3a
>  #1: 0000000067a0ca88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_it=
er+0x181/0x24b
>  #2: 00000000631eac40 (kn->active#3){.+.+}-{0:0}, at: kernfs_fop_write_it=
er+0x191/0x24b
>  #3: 00000000609a1308 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspe=
nd+0xaf/0x30b
>  #4: 0000000060c0fdb0 (device_links_srcu){.+.+}-{0:0}, at: device_links_r=
ead_lock+0x75/0x98
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 547 Comm: rtcwake Tainted: G           O        6.17.0=
-rc3-00014-g31419c045d64 #6 VOLUNTARY
> Tainted: [O]=3DOOT_MODULE
> Stack:
>  223721b3a80 6089eac6 00000001 00000001
>  ffffff00 6089eac6 00000535 6086e528
>  721b3ac0 6003c294 00000000 60031fc0
> Call Trace:
>  [<600407ed>] show_stack+0x10e/0x127
>  [<6003c294>] dump_stack_lvl+0x77/0xc6
>  [<6003c2fd>] dump_stack+0x1a/0x20
>  [<600bc2f8>] lockdep_rcu_suspicious+0x116/0x13e
>  [<603d8ea1>] dpm_async_suspend_superior+0x117/0x17e
>  [<603d980f>] device_suspend+0x528/0x541
>  [<603da24b>] dpm_suspend+0x1a2/0x267
>  [<603da837>] dpm_suspend_start+0x5d/0x72
>  [<600ca0c9>] suspend_devices_and_enter+0xab/0x736
>  [...]
>
> Add the fourth argument to the iteration to annotate
> this and avoid the splat.
>
> Fixes: 06799631d522 ("PM: sleep: Make async suspend handle suppliers like=
 parents")
> Fixes: ed18738fff02 ("PM: sleep: Make async resume handle consumers like =
children")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: use list_for_each_entry_rcu_locked()
> ---
>  drivers/base/power/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..2ea6e05e6ec9 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -675,7 +675,7 @@ static void dpm_async_resume_subordinate(struct devic=
e *dev, async_func_t func)
>         idx =3D device_links_read_lock();
>
>         /* Start processing the device's "async" consumers. */
> -       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_nod=
e)
>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->consumer, func);
>
> @@ -1330,7 +1330,7 @@ static void dpm_async_suspend_superior(struct devic=
e *dev, async_func_t func)
>         idx =3D device_links_read_lock();
>
>         /* Start processing the device's "async" suppliers. */
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_nod=
e)
>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->supplier, func);
>
> --

Applied as 6.17-rc material, thanks!

