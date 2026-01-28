Return-Path: <linux-pm+bounces-41638-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPx8KfVSemnk5AEAu9opvQ
	(envelope-from <linux-pm+bounces-41638-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:18:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E42BA7A9E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B85B3019584
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0734F468;
	Wed, 28 Jan 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OShfcWQB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE32BEC2E
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624014; cv=none; b=mKDlyPHjbfj3ccaI87AvWwwuxDZy+NZhx4BwxeN21fdnjt4nDs3e92V2ei1uSOC1dO8wDPzoD9FCbDHKNR1J1nEzFX4yJ/ztRvbzD5bQbQ5e8WylYLYVJBGym9tDHvLEO6CcOxB/XflvPcju+/PaM0QVqeSJuqIRhaq0m2xNSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624014; c=relaxed/simple;
	bh=tmWMavxyQNkkYeKcPZ214e6bXHmeA8jXlqhw11SDyUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGVeeuH9v8AD3DOoKlDZd1d+xEaBMhMfuGK2nIQqKoEVkDUnRMI7UMjT/rxey2ods2P8kib8p/7sS9bNDKnfeggYESc5qMnrqmIdzGVr0mz+/gjjRt2xq/NKeyqPHxSSfxs7exg1l80yVLRa9KIQfSjFgNbhvdk7ZEcQ0dYtMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OShfcWQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96854C4CEF1
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769624013;
	bh=tmWMavxyQNkkYeKcPZ214e6bXHmeA8jXlqhw11SDyUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OShfcWQBosyycErCSUkabvS0ClfPvdEGV15LrzlaeEl002HkwONcnQl3GPQlVw5iu
	 2LPHwUHRLC7T5ASuRZkYun3VpODAKUMHjxifsa08QKvO9vutCAG95ol9ZxoKejQ2IH
	 XNdnda6jDAfcjnepP1OBullUyr4Q1T6IJKywg8IfoufKD78O6UN4U9OAdkZg2xzQQC
	 9y6k0aCMki3gRMV4i9FHLlOLBygaVTEesYCctgkWS0aOZ408ChH7bgYCc9XW98Yum2
	 bECVh/8+6MI+yNO9RWFHOpzt1eSpryCj9IYrGlYp4lwg/noe9sWsCXHn/yBIfALJwo
	 uR5DdcVziuqYA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662feac8228so72326eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 10:13:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXco9pwGS44WWG5PxiZhXVtRIc+hNd0ombxP9R0E/uoio2QqZVmqGeyJ5QwPR0Z57Sq6OFGKjlXOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFtFdmuw7+fFuyK2Cgwifo7vLmqO17aX244CaJpEFm9FzVYH9
	FkazPU/81U2Hyt7WfVVJ7N4kwRiDHIYhAycbiuWqZQhqWVA11+X9kd9Kw9bI5IcZSXE8yxtzubl
	e6xT5mXWCCh6xIxCTvouv6CXxIoQL40c=
X-Received: by 2002:a05:6820:1c8b:b0:65e:f0f9:aa7c with SMTP id
 006d021491bc7-662f202098cmr3657269eaf.4.1769624012614; Wed, 28 Jan 2026
 10:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p>
 <CAJZ5v0gH-g5H4fqowtoNs1ZTDWR4xa4Wd9Db2uSJxjWW_KsZVg@mail.gmail.com> <fanefxv46yew7hgr3c43kv2mccrtwrtjbc7nfpqx3ykpnbpd2i@e5tauhoemi5t>
In-Reply-To: <fanefxv46yew7hgr3c43kv2mccrtwrtjbc7nfpqx3ykpnbpd2i@e5tauhoemi5t>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 19:13:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZv_0+swuwm__S57-TXzSSJgvhRznD8dePNPJAs9EJSw@mail.gmail.com>
X-Gm-Features: AZwV_Qhn7-ssk_rUAK6xftCavsZpcNgUNU_yHMKQxdx0Dvop6J_a-lflzF0zFJw
Message-ID: <CAJZ5v0hZv_0+swuwm__S57-TXzSSJgvhRznD8dePNPJAs9EJSw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-41638-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 6E42BA7A9E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:07=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 27-01-26, 14:52, Rafael J. Wysocki wrote:
> > Hi Viresh,
> >
> > On Tue, Jan 27, 2026 at 7:56=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > The following changes since commit 7e3debb4c72fe840d60014192cf9395087=
1fb3be:
> > >
> > >   cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_lis=
t (2026-01-27 11:21:22 +0530)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/c=
pufreq-arm-updates-7.0-rc1
> > >
> > > for you to fetch changes up to 0b7fbf9333fa4699a53145bad8ce74ea986caa=
13:
> > >
> > >   cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id=
() (2026-01-27 11:21:24 +0530)
> > >
> > > ----------------------------------------------------------------
> > > CPUFreq arm updates for 7.0
> >
> > Is the 7.0 thing official already?
>
> I looked at other pull requests and many of them were marked like
> this. Moreover I did hear some discussion happen around it at LPC or
> maintainers summit (not sure which one).

I've heard about it too, but I thought you might see a more direct
confirmation of it somewhere. ;-)

