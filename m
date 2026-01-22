Return-Path: <linux-pm+bounces-41279-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L3YGqPjcWk+MgAAu9opvQ
	(envelope-from <linux-pm+bounces-41279-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:45:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B992635E9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B77C0DE7
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B03469F4;
	Thu, 22 Jan 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mp263iZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E0283FE5
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071092; cv=pass; b=lEstWKAxpy4L95ZBifubFmXuEXuqh0pdKc1ArwWNrV5Au12wXqDPJK+MxIvsdwtZsB/qjgj9qCUXOMSFhLz/eZ0fgGaDk4/AwZ3pelrvG7a2uo+WZLyMiPCvmgFvdj1j0RfrEhMtGLJ574HHrOpNHEcPqHtkhdQ3R6h3GCyZzKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071092; c=relaxed/simple;
	bh=a1MwlbGFRFpMyqtPGTxj66+tNiy+XN/jCaQ1eQjN4xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wq8DmhX5vKvt9px/6t+9TenoA5Nv7tNIk4drmMkZ3c8G9fEGDsbo+CRMFU0xPP3fA1D94cezmYCco4N81a0NVnauwYmQIhi/SF7gs9llpGDjlnz2x8yhOi/8JdQHlRf3k9V4hOIJASyMGjc4+7J3IyasLAP3Vk+oenYM7N8PjtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mp263iZY; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b710d46ceso573460e87.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 00:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769071087; cv=none;
        d=google.com; s=arc-20240605;
        b=QF8qvUIO9PiT28+05lxpZHsp6z3pWjsToIGbJrrNKnk8wqU6SR9J+aAcjeSWvesQkS
         8ioQCvTazMaMml0ptvsQDGfwzNmycPz6dppx7Ap3HGzF7tTPdn20sPAhSUEOoAs8EP21
         5aategkCaVGlZIjem3wjOXy6xAt0hvnGnC+dTtcB+bn/LtosPzrjH4YJ/+1aecG8k54D
         nINMCfuOOIRe957LBePt72KeeSjwNVaOueEGUEYj6pzsiukdV9tPMlxtUKQq5H0HG7tp
         j8qMjjmkCh7FBV8M7dmpqsvn5gBDNSsZlUFwPqCMzT6R6N+iwx2gwsx5rxa9ASPL4v0z
         /GUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YlaCsTUa7F4+bnXBKm75fmTPUHjK8kWJYjdBYurLfMU=;
        fh=KV2ZxaKTiDeUZRC5fF0A/ENFIc8wkeiVqZNBRSFHm+4=;
        b=Zmjnz9SPe7ZA6gaEqRvheor2Xtok1rpWECrjtBFga4IgN1XDF9nVerxb4jSCPfqvh8
         UqZsEvNIK4BZxc4pn9oie8jQjOAjUyaebemkMR0DSGs760gsVBUZcgqRazy2wkH6Y5Io
         d18ot3ABw2ujDl4k7YrVH7c/BfQWMH0KjFNDTByqvMisMyzWl2UH3xOWWrJGj/X0/XIL
         HUzDbjEcVQojn2pNJK+2Wk84Lq+BefxpLakkvcBWpTFhV3wGQYuaVhIK4NAzbDjeEhZk
         6G6rUH+S04fQNeb86NI2EFJyx8FExDkr6l7ofkhLBFe7hARC9uk3g2F94wv0MKzDPPXO
         kVUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769071087; x=1769675887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlaCsTUa7F4+bnXBKm75fmTPUHjK8kWJYjdBYurLfMU=;
        b=Mp263iZYNyyoCKrNhMODheu5J05U51p3NrbUAY1lbUOERqVgAKz/mBYa0OlEN//Y/H
         7zMBcHN8M0vhbvZqB+eN2IK0N6dPvFHykEXOjgAszyBBVdCzxQj1IydiAUSuOsIFeV36
         VacVwVcO1o8alJKfEMrXmmGEc/41IOg6TDObI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769071087; x=1769675887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YlaCsTUa7F4+bnXBKm75fmTPUHjK8kWJYjdBYurLfMU=;
        b=i63hZBPpykppkPW4tZ2tIC/53y8MCjV1PzSO3I5HOc560G0aIs1bTZIZDdN2ySkVFj
         thXvtHIACL6Z/FD1lCOUZryPMtFKWmo2HpgyjogRCHCPUDOaswZBQ0BYUkQbYla2NJKg
         bzFqjyTXe0bNsetoVPIiU2nVjyZRD68vatNoIvMtI/htweveu3shMRG4dAl6UuZVsyE+
         M9NpcrQzX8g5Bl9On339+C9GpRku6UEmWm1NCjT2s+MRczJRtYyt2kRPd4aTgUChHfzV
         iTLzXkHpRThoysWJ6Gtrs6rC7lMrlPge5HR0KmLOjbxEzJHz0K/g6bh9e0QwsN0FUXHL
         Cf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCueMvHuNJjuA5YJEX6AZQv8oHg7UT6w0GW/RtDYmENVpdeueTJ1tDJ3ToOJ0yPwfPyr6Za9IKtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEvyc7DQgNb0NZ4HCQTBv4cq4dTIorlqP28KguaosX0JGjUJ5
	6VCCz3elFZVxmoDVSYTWFtBLoYUJNvhEvescadP754gjLm/cYnvIiUG0iOJIzZ4HiyJKrMw+MPE
	vjIjhOiwUX6B1ZOh1EwatWJQzqAyy75+nWLvHUFXL2czA0YYjF1M=
X-Gm-Gg: AZuq6aLMlUi/JbStns/WvNioYz9gS+zyiPT3eewD/kySDaVuXr3ztA1/fVE91yE5zfa
	BjweOLxB6Uxxsk2/9desgzdb/tjdU+1KuZmOtNf3Bv7/wSPp5cl4m5tWDa5CnNRXpsRQyuqKnJi
	blZStTrC68ob7xLzeQCrVDRIox/hH1TAXNRgJnFKUneooPKlkyQBBVL5zRdAY2GhyPNDFv0Tjcc
	7KNnSMFGkJuxSzRiql4D8hixoIuZBYqcDjVSNen3uLHAAzczVP28YEA9cNCzp/FKEYbJsq5wZBS
	zWrYnxnPZeFTPrLKlgQS4FFU
X-Received: by 2002:a05:6512:3a89:b0:59d:df5e:bfdf with SMTP id
 2adb3069b0e04-59ddf5ec025mr395152e87.33.1769071087312; Thu, 22 Jan 2026
 00:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231035357.1147578-1-tzungbi@kernel.org>
In-Reply-To: <20251231035357.1147578-1-tzungbi@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 22 Jan 2026 16:37:55 +0800
X-Gm-Features: AZwV_QjeC9rZEZXIfjNiCuGnuqLpCfwJ2SqaV5XzQbAguloGd0OTwSGqZvreCjo
Message-ID: <CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Break lock dependency to `prepare_lock`
To: Tzung-Bi Shih <tzungbi@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41279-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenst@chromium.org,linux-pm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[chromium.org,none];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,intel.com:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B992635E9
X-Rspamd-Action: no action

On Wed, Dec 31, 2025 at 11:54=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> Break a circular locking dependency between the Generic Power Domain
> lock (`genpd->mlock`) and the clock framework's `prepare_lock`.  Move
> the prepare() to the domain initialization phase and the unprepare()
> to the cleanup phase.
>
> The possible deadlock occurs in the following scenario:
>
> 1. `genpd_power_on` acquires `genpd->mlock` and then calls the driver's
>    `scpsys_power_on`.  The driver calls `clk_bulk_prepare_enable`,
>    which attempts to acquire `prepare_lock`.
>
> > -> #0 (prepare_lock){+.+.}-{3:3}:
> >        __lock_acquire
> >        lock_acquire
> >        __mutex_lock_common
> >        mutex_lock_nested
> >        clk_prepare
> >        clk_bulk_prepare
> >        scpsys_power_on
> >        genpd_power_on
>
> 2. A clock provider (managed by a power domain) is resumed.
>    `clk_prepare` acquires `prepare_lock` and triggers a runtime resume of
>    its power domain, which attempts to acquire `genpd->mlock`.
>
> > -> #1 (&genpd->mlock){+.+.}-{3:3}:
> >        __mutex_lock_common
> >        mutex_lock_nested
> >        genpd_lock_mtx
> >        genpd_runtime_resume
> >        __rpm_callback
> >        rpm_callback
> >        rpm_resume
> >        __pm_runtime_resume
> >        clk_core_prepare
> >        clk_prepare
> >        clk_bulk_prepare
>
> This creates a cycle: `mlock` -> `prepare_lock` -> `mlock`.
>
> > Possible unsafe locking scenario:
> >
> >       CPU0                    CPU1
> >       ----                    ----
> >  lock(&genpd->mlock);
> >                               lock(prepare_lock);
> >                               lock(&genpd->mlock);
> >  lock(prepare_lock);
>
> This breaks the dependency chain in #0.
>
> This is a revert of f0fce06e345d ("soc: mtk-pm-domains: Fix the clock
> prepared issue").  However, addressing the issue by moving the
> unprepare()/prepare() to PM suspend()/resume() callbacks.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 & MT8188 no regressio=
ns

This is unfortunately a known problem of the interaction between pmdomains
and the clk subsystem. This *breaks* the circular lock dependency. AFAIU
this works because the clk prepare op is a no-op, because all the clocks
are MMIO based.

There is another question of whether this actually deadlocks or not, i.e.
if the involved &genpd->mlock is the same object or not. Perhaps the
accuracy of lockdep could be improved by setting a different lock class
key and name? See what regmap does.


> ---
> v2:
> - Fix build error reported by "kernel test robot <lkp@intel.com>".
>
> v1: https://lore.kernel.org/all/20251229043244.4103262-1-tzungbi@kernel.o=
rg/
>
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 101 +++++++++++++++++----
>  1 file changed, 81 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomai=
n/mediatek/mtk-pm-domains.c
> index 80561d27f2b2..c371b08c9170 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -318,12 +318,12 @@ static int scpsys_hwv_power_on(struct generic_pm_do=
main *genpd)
>         if (ret)
>                 goto err_infra;
>
> -       ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> +       ret =3D clk_bulk_enable(pd->num_clks, pd->clks);
>         if (ret)
>                 goto err_reg;
>
>         /* For HWV the subsys clocks refer to the HWV low power subsystem=
 */
> -       ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_c=
lks);
> +       ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
>         if (ret)
>                 goto err_disable_clks;
>
> @@ -365,7 +365,7 @@ static int scpsys_hwv_power_on(struct generic_pm_doma=
in *genpd)
>         }
>
>         /* It's done! Disable the HWV low power subsystem clocks */
> -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
>                 scpsys_sec_infra_power_on(false);
> @@ -373,9 +373,9 @@ static int scpsys_hwv_power_on(struct generic_pm_doma=
in *genpd)
>         return 0;
>
>  err_disable_subsys_clks:
> -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>  err_disable_clks:
> -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_disable(pd->num_clks, pd->clks);
>  err_reg:
>         scpsys_regulator_disable(pd->supply);
>  err_infra:
> @@ -398,7 +398,7 @@ static int scpsys_hwv_power_off(struct generic_pm_dom=
ain *genpd)
>                         return ret;
>         }
>
> -       ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_c=
lks);
> +       ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
>         if (ret)
>                 goto err_infra;
>
> @@ -437,8 +437,8 @@ static int scpsys_hwv_power_off(struct generic_pm_dom=
ain *genpd)
>         if (ret)
>                 goto err_disable_subsys_clks;
>
> -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable(pd->num_clks, pd->clks);
>
>         scpsys_regulator_disable(pd->supply);
>
> @@ -448,7 +448,7 @@ static int scpsys_hwv_power_off(struct generic_pm_dom=
ain *genpd)
>         return 0;
>
>  err_disable_subsys_clks:
> -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>  err_infra:
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
>                 scpsys_sec_infra_power_on(false);
> @@ -616,7 +616,7 @@ static int scpsys_power_on(struct generic_pm_domain *=
genpd)
>         if (ret)
>                 return ret;
>
> -       ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> +       ret =3D clk_bulk_enable(pd->num_clks, pd->clks);
>         if (ret)
>                 goto err_reg;
>
> @@ -638,8 +638,7 @@ static int scpsys_power_on(struct generic_pm_domain *=
genpd)
>          * access.
>          */
>         if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
> -               ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks,
> -                                             pd->subsys_clks);
> +               ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_c=
lks);
>                 if (ret)
>                         goto err_pwr_ack;
>         }
> @@ -653,8 +652,7 @@ static int scpsys_power_on(struct generic_pm_domain *=
genpd)
>                 goto err_disable_sram;
>
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
> -               ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks,
> -                                             pd->subsys_clks);
> +               ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_c=
lks);
>                 if (ret)
>                         goto err_enable_bus_protect;
>         }
> @@ -667,10 +665,9 @@ static int scpsys_power_on(struct generic_pm_domain =
*genpd)
>         scpsys_sram_disable(pd);
>  err_disable_subsys_clks:
>         if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
> -               clk_bulk_disable_unprepare(pd->num_subsys_clks,
> -                                          pd->subsys_clks);
> +               clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>  err_pwr_ack:
> -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_disable(pd->num_clks, pd->clks);
>  err_reg:
>         scpsys_regulator_disable(pd->supply);
>         return ret;
> @@ -695,7 +692,7 @@ static int scpsys_power_off(struct generic_pm_domain =
*genpd)
>                 regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs=
,
>                                 pd->data->ext_buck_iso_mask);
>
> -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
>                 scpsys_modem_pwrseq_off(pd);
> @@ -708,7 +705,7 @@ static int scpsys_power_off(struct generic_pm_domain =
*genpd)
>         if (ret < 0)
>                 return ret;
>
> -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_disable(pd->num_clks, pd->clks);
>
>         scpsys_regulator_disable(pd->supply);
>
> @@ -855,6 +852,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scps=
ys *scpsys, struct device_no
>                 pd->genpd.flags |=3D GENPD_FLAG_IRQ_SAFE;
>         }
>
> +       ret =3D clk_bulk_prepare(pd->num_clks, pd->clks);
> +       if (ret)
> +               goto err_put_subsys_clocks;
> +
> +       ret =3D clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
> +       if (ret)
> +               goto err_unprepare_clocks;
> +
>         /*
>          * Initially turn on all domains to make the domains usable
>          * with !CONFIG_PM and to get the hardware in sync with the
> @@ -869,7 +874,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsy=
s *scpsys, struct device_no
>                 ret =3D pd->genpd.power_on(&pd->genpd);
>                 if (ret < 0) {
>                         dev_err(scpsys->dev, "%pOF: failed to power on do=
main: %d\n", node, ret);
> -                       goto err_put_subsys_clocks;
> +                       goto err_unprepare_subsys_clocks;
>                 }
>
>                 if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
> @@ -888,6 +893,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scps=
ys *scpsys, struct device_no
>
>         return scpsys->pd_data.domains[id];
>
> +err_unprepare_subsys_clocks:
> +       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +err_unprepare_clocks:
> +       clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_subsys_clocks:
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  err_put_clocks:
> @@ -965,6 +974,8 @@ static void scpsys_remove_one_domain(struct scpsys_do=
main *pd)
>         if (scpsys_domain_is_on(pd))
>                 scpsys_power_off(&pd->genpd);
>
> +       clk_bulk_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>         clk_bulk_put(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  }
> @@ -1208,6 +1219,7 @@ static int scpsys_probe(struct platform_device *pde=
v)
>         if (!scpsys)
>                 return -ENOMEM;
>
> +       platform_set_drvdata(pdev, scpsys);
>         scpsys->dev =3D dev;
>         scpsys->soc_data =3D soc;
>
> @@ -1270,12 +1282,61 @@ static int scpsys_probe(struct platform_device *p=
dev)
>         return ret;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int scpsys_suspend(struct device *dev)
> +{
> +       struct scpsys *scpsys =3D dev_get_drvdata(dev);
> +       struct generic_pm_domain *genpd;
> +       struct scpsys_domain *pd;
> +       int i;
> +
> +       for (i =3D 0; i < scpsys->pd_data.num_domains; i++) {
> +               genpd =3D scpsys->pd_data.domains[i];
> +               if (!genpd)
> +                       continue;
> +
> +               pd =3D to_scpsys_domain(genpd);
> +               clk_bulk_unprepare(pd->num_clks, pd->clks);
> +               clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +       }
> +       return 0;
> +}
> +
> +static int scpsys_resume(struct device *dev)
> +{
> +       struct scpsys *scpsys =3D dev_get_drvdata(dev);
> +       struct generic_pm_domain *genpd;
> +       struct scpsys_domain *pd;
> +       int i, ret;
> +
> +       for (i =3D 0; i < scpsys->pd_data.num_domains; i++) {
> +               genpd =3D scpsys->pd_data.domains[i];
> +               if (!genpd)
> +                       continue;
> +
> +               pd =3D to_scpsys_domain(genpd);
> +               ret =3D clk_bulk_prepare(pd->num_clks, pd->clks);
> +               if (ret)
> +                       return ret;
> +               ret =3D clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_=
clks);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops scpsys_pm_ops =3D {
> +       SET_SYSTEM_SLEEP_PM_OPS(scpsys_suspend, scpsys_resume)
> +};
> +
>  static struct platform_driver scpsys_pm_domain_driver =3D {
>         .probe =3D scpsys_probe,
>         .driver =3D {
>                 .name =3D "mtk-power-controller",
>                 .suppress_bind_attrs =3D true,
>                 .of_match_table =3D scpsys_of_match,
> +               .pm =3D &scpsys_pm_ops,
>         },
>  };
>  builtin_platform_driver(scpsys_pm_domain_driver);
> --
> 2.52.0.351.gbe84eed79e-goog
>
>

