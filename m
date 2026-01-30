Return-Path: <linux-pm+bounces-41763-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyONCFpfGk/MQIAu9opvQ
	(envelope-from <linux-pm+bounces-41763-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:17:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC52B83DB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62233006B47
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE82F693D;
	Fri, 30 Jan 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiK1xCBm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1DD284898
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761054; cv=none; b=hh26GvxWeYcmmIpWkg8SKfb5p4hNm8ns79xKdtOGjqsW1fxDPAwVkLdecnypHnipBe9VZptCiUI8w7Lh/j8WGKXg2dryeXUIYwoJM5KC5+486B3fPHfYohuSB9MDs+lqty/fEjFN7oGe4v6WQ+gJU1rMLN+Z6pMm8qdFEcR77Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761054; c=relaxed/simple;
	bh=SxLqE44zUUxs1dvaadGY9E3DpJnP/taoyxmSUjwcM00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnlqWO2DkKFvuo31URoNkrxESSHzPbznLo+8yJ+PX6vcBpzSfgSrZqPaZuvqn2mYOoj4Wp7QhUdHEbWKajWoTw8tmT63oSyzQuFf4Wjz8EWsWvvBFWt4yerSXiFjOxBWAFac1Onu8nmTRSLQZNXvpFTo2RrSz+9FOybK5WOPOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiK1xCBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CCAC4CEF7;
	Fri, 30 Jan 2026 08:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769761054;
	bh=SxLqE44zUUxs1dvaadGY9E3DpJnP/taoyxmSUjwcM00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiK1xCBmZRzZSTAGdSIV7V9uGeUjIdIa1736iKo1bi11W9OkKJhT9ttVn0pAEpDwT
	 rGtdYUWt4JbDaciao5Y6YdWMzZW+zCoP6Zjs3SLtE0xV+B9kZZs9X3KCNIgtvFUQw4
	 JJ14slv8bApSWz/a7RA07Bk0B7oCt7SJmdXFpHQWjgf7UV9EYxHPuwbWvnWOlb2ENA
	 LCWB8NU+/cXbgeurd+ocqQAsUCmH3pkD4zs4Wa6OS0n4wgdTcvl24eLybvQZMZdZ25
	 w+dHyoIPScNcPsJc18pYNc9PkRzdrK4OtYLL9Sm9s9q7+LTe9IVBeaYdILPWF2mlV8
	 httBgzWekJC5w==
Date: Fri, 30 Jan 2026 08:17:31 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pmdomain: mediatek: Break lock dependency to
 `prepare_lock`
Message-ID: <aXxpG3hEVVjuWInc@google.com>
References: <20251231035357.1147578-1-tzungbi@kernel.org>
 <CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com>
 <CAPDyKFrqqXYy_Y-7WA=5taBhE4rcYX+Uz_RnGpOtD-AF3eipVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFrqqXYy_Y-7WA=5taBhE4rcYX+Uz_RnGpOtD-AF3eipVQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41763-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 4BC52B83DB
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:57:46PM +0100, Ulf Hansson wrote:
> On Thu, 22 Jan 2026 at 09:38, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Wed, Dec 31, 2025 at 11:54 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > @@ -398,7 +398,7 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
> > >                         return ret;
> > >         }
> > >
> > > -       ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > > +       ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
> 
> scpsys_hwv_power_off() is typically called by genpd in the suspend
> noirq() phase, when all devices attached to the genpd in question have
> been suspended too. See genpd_suspend_noirq().
> 
> This means that scpsys_suspend() (below) may be called to unprepare
> the clock, before scpsys_hwv_power_off() may call clk_disable(). This
> is a bug according to the clock framework.

Ack, I observed a similar warning in a system suspend/resume cycle.

> 
> Moving scpsys_suspend() to the noirq phase too could maybe work.

No, I guess it doesn't work as .prepare() can sleep however noirq phase
shouldn't/can't.

> Although, perhaps an even simpler solution would be to do the
> clk_prepare() during ->probe() and clk_unprepare() during ->remove()
> (and error path in probe). Of course, this assumes that
> clk_prepare/unprepare doesn't really do anything hardware wise, so we
> don't start wasting power by keeping the clocks prepared.

It turns out a pure revert of f0fce06e345d ("soc: mtk-pm-domains: Fix
the clock prepared issue").  Per the commit message of f0fce06e345d,
the concern is some PLLs keep prepared even if the system is suspended.

Not sure should we take the compromise?

