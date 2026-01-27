Return-Path: <linux-pm+bounces-41538-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APQdJdnEeGmltAEAu9opvQ
	(envelope-from <linux-pm+bounces-41538-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:59:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B395407
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBFD930241B5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD235B655;
	Tue, 27 Jan 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQAgBqEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7C35B139
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522306; cv=pass; b=eaTc1P4AdJnLfdTAsSUNkwe1SKHZl0DLpaANu8T/wrlXZxkEwUodeDVDn5rOMHyu81peqRq8BI3zY8TrH8P9lpDaU+Qqxqivq2NV3HZaSgfgp2mP3o+OuIZzIt8+efuJ8O76jiq+foEN+IrD/I4mYTXiYDg5wXoTQ5sHOs0tE5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522306; c=relaxed/simple;
	bh=sePAErvMVTp+q4zgBvMJV3gxhTYfl4ciBeJNjyq2SPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uK0Y1t0KhdW75bWTmjKDHUjVcA/DmO5FXkrIE9EsZq3Bp7rp9UK1Z0l1I3ogD5AUhNNObXYLQMsNYw7n8840Pf+2e7MfYILPBuErZuuVuV1UlFEpDg2k4t+pPLwSI9mCsYlu4fME+D2AtRDG8OHH2rKD6jbEh5wSFi666rKTns8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQAgBqEB; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so5354926e87.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769522302; cv=none;
        d=google.com; s=arc-20240605;
        b=kqZjmpQLJQdGAsbyMqLeHgtH1ByVIalMN9Kkn5eVrypYsvCPk0vI3RnK1q11dak6L7
         7Dn6M4oDd19wG2iGSS/64xaa7RlnAQFVDQEu0D7ZkpDri/AWJiCP9qAT3N8bffiG2q8t
         OKDq1zLtFVUYKSyrfBuOJTRWpvFMyUVKa4+BnbLxayfSZM6oxIpmYoURRSfu82HcPTWI
         TFMIyxem3jSbwHH5iaiBzfFfib8tFzEZkvYl0pRJZaT041ibEJJI6jhO7Eh+yRoUKSNo
         i/OjKDHWjPcWRRmegxJdQWCLsoY6jZFSoChVvV1EC+05Ey1b61/Jnt6K8oEeFkP2PO2A
         5Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfk0u8jijXvQF1SoXyqvsVpMiit2Fv9RQS39R0lpECo=;
        fh=aW5TC1PKG77Lu+c4PRptNMXneDnzJ6Q3wjW/whsVtZo=;
        b=QEmo+s4LjK9lKPoE70UCZrc588jTODr/nTGVlCTHKAtmlP1wpoytpB6I6O/rIsbwOF
         yeqSoJtJ5Z6p3S/2GWJPvvrtZgdkynH/zlSLx1VkJdwqJ8v5vCK7x4OD+eJAwNVkMBAv
         ZHKtj7Z2IEEHRdJ6nJDbwwusEg/WVgluODrbddl/16Bq+63lPuK+tsTDVqrQEmWcW2ik
         oLN12+hSb3+zug7Yt0jYMDPhLGnNKdPq1O9VavsLVp0m2fCdTEN726wIrAJkLh8gMOiB
         +YgNA1i1O2moqXo4CWySO50Fszq9I2bPrxtxmijkWCXE8CCid7YrNYt4C+ZO/GWpaXUR
         CsoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769522302; x=1770127102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfk0u8jijXvQF1SoXyqvsVpMiit2Fv9RQS39R0lpECo=;
        b=YQAgBqEBzgIiZKvvHv9lkoB8jkr091s84Z/n4t7hZQinPZ+qVo7PuxNGSQzi1lQ+D/
         KbiPZROvH5g2gvS8jaFuRhKhYkgs3dDL7zdDQTQyspGv2jXFUH/C81qSC+zuy0Ldfh1u
         ma2z5iYm4Rugun8JSqZLf4QdYuGrpLY90RXHff9F8WG4WtAObzG9XMWCjZt9hpEVq+ss
         cAFsu5eKIX7MuW0PSRQa1TPbNu7ZtHwPD/G6/xYVBvVk+16Eo87IcBkg8PpAAz2eno6l
         K6QJzZrAP+nSExbGtO+egcLFrSqDslTAnPrbTUpBrmdhJlmyfpgs+I1kysSIDDYRzO3N
         QeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769522302; x=1770127102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfk0u8jijXvQF1SoXyqvsVpMiit2Fv9RQS39R0lpECo=;
        b=EP/c5cSZP1LPA75kU20R+okAZJC3dd4oq9RtlHBORZBppG5cSDSBc/VLx6P3yx2Xn4
         smyohiiU/o80BpqG6SsLLZGKn3j0ZLjBOIaL77mwpgtejrGvR6Bum3vnHMGt9HTK/j4e
         GrpVerQTYQall1x46JaZLHDram3+h3x4HnWbJvu6wSf7NpwR2VLFlDtMbaqUNPwsbVYY
         fOhrH0qIa4Ma4atQ93uDAtwtailrSQgIGkEl/+6eS3Ucuv0RP8VerQDNfFJ2H1t6Voxu
         jTHqNrHhpsvg/ngwaH8K6PgR/4MGACilMEdrZu40uwqLXlHfcKT9PMVK/UjTUMMCfVNC
         ajJA==
X-Forwarded-Encrypted: i=1; AJvYcCX0BiWu/0UE1dZ+Rpl5V0tL4rBfmornrmxwJcR15h12XvCMBIURtwrSoBs2JZUsmojfTk8xrXyIFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRxBOR/RdInO8oheKINh4B+lHIXNco/FroP8xNXIAItm/mJBN
	AyOOPR+bCi5CdhV9YjmrG+b0ct0RyWLon9f8sNGojAdsoakbUlKKJUMJc4U3nrp8LO9U303dN4N
	M4ZfTix2Uj6Wod15Jj/tb6DEz042U+rOoUfIJphayyg==
X-Gm-Gg: AZuq6aLnq8rxGPhMMB4VssVZA08v39iACCT2PLb3FJXpBJ/9pym0zkp3ab23DKzNE/E
	jdctSHR18Sua+6CsxFu4cgn4siIbPxZX5tmoleGcCGLhR36NAI38hOJ7KrPEchPb1oeBMLooGZT
	RU1+qMJVasew6qPqK3fuP7ceHWt14ms13thOumbQabk37YRbwZUB2D4LrXvRKAgSWPPLoRRyf2h
	IqwCHGXoofEz/Gi/qB6IyeN3hcqGK8/Y7IWbDGawx2qyoZGHHLW7y3xkGikfKPwGIzj64VeOwD4
	d6x3O3Y=
X-Received: by 2002:a05:6512:4005:b0:59d:f12c:9f05 with SMTP id
 2adb3069b0e04-59e0401a4eamr918529e87.23.1769522302270; Tue, 27 Jan 2026
 05:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231035357.1147578-1-tzungbi@kernel.org> <CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com>
In-Reply-To: <CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 14:57:46 +0100
X-Gm-Features: AZwV_QgVAr_2niJYiUonIGgapgyqBQwATPHJ_yDF_S4wCInP9xq5Hp1p8jkeJQA
Message-ID: <CAPDyKFrqqXYy_Y-7WA=5taBhE4rcYX+Uz_RnGpOtD-AF3eipVQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Break lock dependency to `prepare_lock`
To: Tzung-Bi Shih <tzungbi@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41538-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,linaro.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 1B6B395407
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 at 09:38, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Wed, Dec 31, 2025 at 11:54=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.or=
g> wrote:
> >
> > Break a circular locking dependency between the Generic Power Domain
> > lock (`genpd->mlock`) and the clock framework's `prepare_lock`.  Move
> > the prepare() to the domain initialization phase and the unprepare()
> > to the cleanup phase.
> >
> > The possible deadlock occurs in the following scenario:
> >
> > 1. `genpd_power_on` acquires `genpd->mlock` and then calls the driver's
> >    `scpsys_power_on`.  The driver calls `clk_bulk_prepare_enable`,
> >    which attempts to acquire `prepare_lock`.
> >
> > > -> #0 (prepare_lock){+.+.}-{3:3}:
> > >        __lock_acquire
> > >        lock_acquire
> > >        __mutex_lock_common
> > >        mutex_lock_nested
> > >        clk_prepare
> > >        clk_bulk_prepare
> > >        scpsys_power_on
> > >        genpd_power_on
> >
> > 2. A clock provider (managed by a power domain) is resumed.
> >    `clk_prepare` acquires `prepare_lock` and triggers a runtime resume =
of
> >    its power domain, which attempts to acquire `genpd->mlock`.
> >
> > > -> #1 (&genpd->mlock){+.+.}-{3:3}:
> > >        __mutex_lock_common
> > >        mutex_lock_nested
> > >        genpd_lock_mtx
> > >        genpd_runtime_resume
> > >        __rpm_callback
> > >        rpm_callback
> > >        rpm_resume
> > >        __pm_runtime_resume
> > >        clk_core_prepare
> > >        clk_prepare
> > >        clk_bulk_prepare
> >
> > This creates a cycle: `mlock` -> `prepare_lock` -> `mlock`.
> >
> > > Possible unsafe locking scenario:
> > >
> > >       CPU0                    CPU1
> > >       ----                    ----
> > >  lock(&genpd->mlock);
> > >                               lock(prepare_lock);
> > >                               lock(&genpd->mlock);
> > >  lock(prepare_lock);
> >
> > This breaks the dependency chain in #0.
> >
> > This is a revert of f0fce06e345d ("soc: mtk-pm-domains: Fix the clock
> > prepared issue").  However, addressing the issue by moving the
> > unprepare()/prepare() to PM suspend()/resume() callbacks.
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 & MT8188 no regress=
ions
>
> This is unfortunately a known problem of the interaction between pmdomain=
s
> and the clk subsystem. This *breaks* the circular lock dependency. AFAIU
> this works because the clk prepare op is a no-op, because all the clocks
> are MMIO based.

Yes, this is a known problem that we need to fix properly for the
clock/genpd subsystems.

As an intermediate step, we could consider platform specific patches
to fix the problem too, along with $subject patch. However, $subject
patch has issues too, see more comments below.

>
> There is another question of whether this actually deadlocks or not, i.e.
> if the involved &genpd->mlock is the same object or not. Perhaps the
> accuracy of lockdep could be improved by setting a different lock class
> key and name? See what regmap does.
>
>
> > ---
> > v2:
> > - Fix build error reported by "kernel test robot <lkp@intel.com>".
> >
> > v1: https://lore.kernel.org/all/20251229043244.4103262-1-tzungbi@kernel=
.org/
> >
> >  drivers/pmdomain/mediatek/mtk-pm-domains.c | 101 +++++++++++++++++----
> >  1 file changed, 81 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdom=
ain/mediatek/mtk-pm-domains.c
> > index 80561d27f2b2..c371b08c9170 100644
> > --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> > +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> > @@ -318,12 +318,12 @@ static int scpsys_hwv_power_on(struct generic_pm_=
domain *genpd)
> >         if (ret)
> >                 goto err_infra;
> >
> > -       ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> > +       ret =3D clk_bulk_enable(pd->num_clks, pd->clks);
> >         if (ret)
> >                 goto err_reg;
> >
> >         /* For HWV the subsys clocks refer to the HWV low power subsyst=
em */
> > -       ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys=
_clks);
> > +       ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
> >         if (ret)
> >                 goto err_disable_clks;
> >
> > @@ -365,7 +365,7 @@ static int scpsys_hwv_power_on(struct generic_pm_do=
main *genpd)
> >         }
> >
> >         /* It's done! Disable the HWV low power subsystem clocks */
> > -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> >
> >         if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
> >                 scpsys_sec_infra_power_on(false);
> > @@ -373,9 +373,9 @@ static int scpsys_hwv_power_on(struct generic_pm_do=
main *genpd)
> >         return 0;
> >
> >  err_disable_subsys_clks:
> > -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> >  err_disable_clks:
> > -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> > +       clk_bulk_disable(pd->num_clks, pd->clks);
> >  err_reg:
> >         scpsys_regulator_disable(pd->supply);
> >  err_infra:
> > @@ -398,7 +398,7 @@ static int scpsys_hwv_power_off(struct generic_pm_d=
omain *genpd)
> >                         return ret;
> >         }
> >
> > -       ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys=
_clks);
> > +       ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);

scpsys_hwv_power_off() is typically called by genpd in the suspend
noirq() phase, when all devices attached to the genpd in question have
been suspended too. See genpd_suspend_noirq().

This means that scpsys_suspend() (below) may be called to unprepare
the clock, before scpsys_hwv_power_off() may call clk_disable(). This
is a bug according to the clock framework.

Moving scpsys_suspend() to the noirq phase too could maybe work.
Although, perhaps an even simpler solution would be to do the
clk_prepare() during ->probe() and clk_unprepare() during ->remove()
(and error path in probe). Of course, this assumes that
clk_prepare/unprepare doesn't really do anything hardware wise, so we
don't start wasting power by keeping the clocks prepared.

> >         if (ret)
> >                 goto err_infra;
> >
> > @@ -437,8 +437,8 @@ static int scpsys_hwv_power_off(struct generic_pm_d=
omain *genpd)
> >         if (ret)
> >                 goto err_disable_subsys_clks;
> >
> > -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> > +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> > +       clk_bulk_disable(pd->num_clks, pd->clks);
> >
> >         scpsys_regulator_disable(pd->supply);
> >
> > @@ -448,7 +448,7 @@ static int scpsys_hwv_power_off(struct generic_pm_d=
omain *genpd)
> >         return 0;
> >
> >  err_disable_subsys_clks:
> > -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> >  err_infra:
> >         if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
> >                 scpsys_sec_infra_power_on(false);
> > @@ -616,7 +616,7 @@ static int scpsys_power_on(struct generic_pm_domain=
 *genpd)
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> > +       ret =3D clk_bulk_enable(pd->num_clks, pd->clks);
> >         if (ret)
> >                 goto err_reg;
> >
> > @@ -638,8 +638,7 @@ static int scpsys_power_on(struct generic_pm_domain=
 *genpd)
> >          * access.
> >          */
> >         if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
> > -               ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks,
> > -                                             pd->subsys_clks);
> > +               ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys=
_clks);
> >                 if (ret)
> >                         goto err_pwr_ack;
> >         }
> > @@ -653,8 +652,7 @@ static int scpsys_power_on(struct generic_pm_domain=
 *genpd)
> >                 goto err_disable_sram;
> >
> >         if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
> > -               ret =3D clk_bulk_prepare_enable(pd->num_subsys_clks,
> > -                                             pd->subsys_clks);
> > +               ret =3D clk_bulk_enable(pd->num_subsys_clks, pd->subsys=
_clks);
> >                 if (ret)
> >                         goto err_enable_bus_protect;
> >         }
> > @@ -667,10 +665,9 @@ static int scpsys_power_on(struct generic_pm_domai=
n *genpd)
> >         scpsys_sram_disable(pd);
> >  err_disable_subsys_clks:
> >         if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
> > -               clk_bulk_disable_unprepare(pd->num_subsys_clks,
> > -                                          pd->subsys_clks);
> > +               clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> >  err_pwr_ack:
> > -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> > +       clk_bulk_disable(pd->num_clks, pd->clks);
> >  err_reg:
> >         scpsys_regulator_disable(pd->supply);
> >         return ret;
> > @@ -695,7 +692,7 @@ static int scpsys_power_off(struct generic_pm_domai=
n *genpd)
> >                 regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_of=
fs,
> >                                 pd->data->ext_buck_iso_mask);
> >
> > -       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > +       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> >
> >         if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
> >                 scpsys_modem_pwrseq_off(pd);
> > @@ -708,7 +705,7 @@ static int scpsys_power_off(struct generic_pm_domai=
n *genpd)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> > +       clk_bulk_disable(pd->num_clks, pd->clks);
> >
> >         scpsys_regulator_disable(pd->supply);
> >
> > @@ -855,6 +852,14 @@ generic_pm_domain *scpsys_add_one_domain(struct sc=
psys *scpsys, struct device_no
> >                 pd->genpd.flags |=3D GENPD_FLAG_IRQ_SAFE;
> >         }
> >
> > +       ret =3D clk_bulk_prepare(pd->num_clks, pd->clks);
> > +       if (ret)
> > +               goto err_put_subsys_clocks;
> > +
> > +       ret =3D clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
> > +       if (ret)
> > +               goto err_unprepare_clocks;
> > +
> >         /*
> >          * Initially turn on all domains to make the domains usable
> >          * with !CONFIG_PM and to get the hardware in sync with the
> > @@ -869,7 +874,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scp=
sys *scpsys, struct device_no
> >                 ret =3D pd->genpd.power_on(&pd->genpd);
> >                 if (ret < 0) {
> >                         dev_err(scpsys->dev, "%pOF: failed to power on =
domain: %d\n", node, ret);
> > -                       goto err_put_subsys_clocks;
> > +                       goto err_unprepare_subsys_clocks;
> >                 }
> >
> >                 if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
> > @@ -888,6 +893,10 @@ generic_pm_domain *scpsys_add_one_domain(struct sc=
psys *scpsys, struct device_no
> >
> >         return scpsys->pd_data.domains[id];
> >
> > +err_unprepare_subsys_clocks:
> > +       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> > +err_unprepare_clocks:
> > +       clk_bulk_unprepare(pd->num_clks, pd->clks);
> >  err_put_subsys_clocks:
> >         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
> >  err_put_clocks:
> > @@ -965,6 +974,8 @@ static void scpsys_remove_one_domain(struct scpsys_=
domain *pd)
> >         if (scpsys_domain_is_on(pd))
> >                 scpsys_power_off(&pd->genpd);
> >
> > +       clk_bulk_unprepare(pd->num_clks, pd->clks);
> > +       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> >         clk_bulk_put(pd->num_clks, pd->clks);
> >         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
> >  }
> > @@ -1208,6 +1219,7 @@ static int scpsys_probe(struct platform_device *p=
dev)
> >         if (!scpsys)
> >                 return -ENOMEM;
> >
> > +       platform_set_drvdata(pdev, scpsys);
> >         scpsys->dev =3D dev;
> >         scpsys->soc_data =3D soc;
> >
> > @@ -1270,12 +1282,61 @@ static int scpsys_probe(struct platform_device =
*pdev)
> >         return ret;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int scpsys_suspend(struct device *dev)
> > +{
> > +       struct scpsys *scpsys =3D dev_get_drvdata(dev);
> > +       struct generic_pm_domain *genpd;
> > +       struct scpsys_domain *pd;
> > +       int i;
> > +
> > +       for (i =3D 0; i < scpsys->pd_data.num_domains; i++) {
> > +               genpd =3D scpsys->pd_data.domains[i];
> > +               if (!genpd)
> > +                       continue;
> > +
> > +               pd =3D to_scpsys_domain(genpd);
> > +               clk_bulk_unprepare(pd->num_clks, pd->clks);
> > +               clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks=
);
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int scpsys_resume(struct device *dev)
> > +{
> > +       struct scpsys *scpsys =3D dev_get_drvdata(dev);
> > +       struct generic_pm_domain *genpd;
> > +       struct scpsys_domain *pd;
> > +       int i, ret;
> > +
> > +       for (i =3D 0; i < scpsys->pd_data.num_domains; i++) {
> > +               genpd =3D scpsys->pd_data.domains[i];
> > +               if (!genpd)
> > +                       continue;
> > +
> > +               pd =3D to_scpsys_domain(genpd);
> > +               ret =3D clk_bulk_prepare(pd->num_clks, pd->clks);
> > +               if (ret)
> > +                       return ret;
> > +               ret =3D clk_bulk_prepare(pd->num_subsys_clks, pd->subsy=
s_clks);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +       return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops scpsys_pm_ops =3D {
> > +       SET_SYSTEM_SLEEP_PM_OPS(scpsys_suspend, scpsys_resume)
> > +};
> > +
> >  static struct platform_driver scpsys_pm_domain_driver =3D {
> >         .probe =3D scpsys_probe,
> >         .driver =3D {
> >                 .name =3D "mtk-power-controller",
> >                 .suppress_bind_attrs =3D true,
> >                 .of_match_table =3D scpsys_of_match,
> > +               .pm =3D &scpsys_pm_ops,
> >         },
> >  };
> >  builtin_platform_driver(scpsys_pm_domain_driver);
> > --
> > 2.52.0.351.gbe84eed79e-goog
> >
> >

Kind regards
Uffe

