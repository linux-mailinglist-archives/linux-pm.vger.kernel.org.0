Return-Path: <linux-pm+bounces-41245-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHsYHrQhcWl8eQAAu9opvQ
	(envelope-from <linux-pm+bounces-41245-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 19:57:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 198365BA7A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81AC2823390
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA664B8DF3;
	Wed, 21 Jan 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKz09Hgl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47D4ADDB1
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014665; cv=pass; b=YH41HZFW9VUmm7rPjFyMxXIglbUJMpo4MxZjQwZpv8GoOvOtLstU6T01I8lerhPWGcYAuG41WBzlXcSHR20Yks0Xy/a/lD6mwcoCgnWQo1NbEAk1zBuQjE+lqKKsNoeInkHtKZ5xsUOVrgt2cG86zTDPHQdbA0uKOVXUvtwfYiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014665; c=relaxed/simple;
	bh=n9LGtCCoNWJYT6s8g8s+u64o/APoDWxPMT01RQqJz/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gfzwb6w0jiIVnEoXcH+FYF4r06wUzIK8aKqebq2gT7m6bTLbbG7c1MjA7TPU0ViZS1/iBaX8xy+peuNuUJ6uLMqa6ccrKN7ybh2zwfwUAT0XY1bGWP4+otyPVtVaz4Mfx1xFUPhX43FCEX0kZI56nnaOlHQIGoZgqYUSRLAQUgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKz09Hgl; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43596062728so775368f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 08:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014660; cv=none;
        d=google.com; s=arc-20240605;
        b=NKzstmvUCZL47D54y578desB5O+xwE/n5kgQCaMvaNnL61XmYK9bF2rKxv67MmQYye
         vDEb0Xcws+IxFrcuE7D4aGTmguHPDY0OvwZqI0fXfFmfMXuiYl1VPwaHWI62I04REsXf
         K53oJNsbXsTr5UZgjhKt6FoVwiA3gQaNrMmucfSuBnikh+1W3k6XMhFHNUhQ79o+gdqI
         I7qqSihLu5nD8NiMhbeJe2V+gBxtKBCVi9YMrhYY6JKmJuuGqgP9pwuq8yEUoVvyk0tu
         B7lLp8uYAZhWSSWYJrThB44HQWzWodaDZroujHqRZ0d7S8cnM09H0mHhJ3gRlH6vEm7k
         okvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnUdOq88S5jzPpVoyj19K4zXbAbMVOiRE4Y/7ikog0w=;
        fh=3WcSY5slpefnVLnYZxFEO2XTt9v9vZNm/2d0R33+pAA=;
        b=eGWHBDvQW1SqcGfHzRoWpOSeu1cBnBwvdE7hGS8r28ZoglfiPc2cW6e2E4d415uoFb
         tEkA8KqbyjPN9ux9ey0qqDm/7RNLSYz1obisoiNRHnODVi0OX3mlZWuI34/jnscgiZmj
         Lhuc94ce8ygDE1wQzyXSo6gjVBRg0alNtoPOP+CZQXxJ/5HoGIjIxSNNXfDIXP3KNesX
         5O1iptD0cuNCWdanHngVZlopwlsoFiof73M7BqwOiXeM29akSnU6ufHQ3hLbWWOBpVfg
         uVQ0oYvHm31r+V+5AhC9S5AX/TrF5ChZEz2DDJnDyO4WMWyIDePTz7yeyqCK9r1avS2M
         wv5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769014660; x=1769619460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnUdOq88S5jzPpVoyj19K4zXbAbMVOiRE4Y/7ikog0w=;
        b=BKz09Hgl3lIelVXmMkIqX51HjoGjTyR2dhIE4AhhoglxZ5zn1Y4dJ2dkNgJw9DHpXc
         40UJVULiUxwCH5WMZqOlaaTf+OswEQUN7TDnLsay4Aqkcw6CFtLmKix+5lIzoHtk79kv
         qZggeVrVpC3hWqBlMM5K9hpgyut79Gv0uTDHyvEyh/idpZrBMDRaYsFDxolodney3tKA
         AzrHabBYwzjNEeEWJcw7KMhybgAx+OvE7ex3wTPfqgHiuBHjtx//INyhBmaTNJOATNr/
         5PzIGGAio2YjyEaRFSIMoZINuWMERWCxVO6tlMZnScnM0P/DTqhbJN3hWqYk+l/nLjUI
         BH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014660; x=1769619460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bnUdOq88S5jzPpVoyj19K4zXbAbMVOiRE4Y/7ikog0w=;
        b=G4sPnvGEbiTE+70wkyAR0HccZaIGXSTH2C6Kma+ydY4qcMbGwtTLTGRMFPs4k6fiDU
         m5UbT4SKDi5Ah8h29GlsqxWCU6syWS9Z3rNQDSGxSkkc/XGGXDhrzhNgfEJcSMGFjUeQ
         lZczox/eEZI12PPpxZuG+z7cZ67Hr82d7NzQZF54jfQ2HK+K38mdauWwirm3OwKfA4nI
         cy4Q5W1qDWQeIKc6TusUfIQ50bSK/qOVsSNYO09/CoZoo1quDE1Qh7cW1YKelvf6Y/GC
         2PsyfOgOPU2cVFm8pRh85ufzJu0qwrXFJPvhcK/xC0WhO5Yi0mz87OTWpTUIdQt5nFwU
         UK7A==
X-Forwarded-Encrypted: i=1; AJvYcCUzD4rugfcXWzVZLNYvD+Q0+vtlDG5n/mf35H2eaMo8iyGMwl8C4bnp+y3UlKMpzWCo+k1c0HA+yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwENiCWAC5FGq0BiWm2ffEshWy74grWkcDruim26TxJV0kAWXaP
	6U/zma0oMpr6q6i7Bw6WgXp11qJGO+wreSIcF4R0Tx0PuuxA/Fy16vMdaOA9Afh/nKF8BM6xwSE
	oJaZYeBdmbG4RrDynNmNMZ63Q61R6smI=
X-Gm-Gg: AZuq6aJmKTGIBma2ZQebb24Aql/fuzrffba3LAh1wNxQj926veyW2ByXm0wxX3L0+up
	7TAIWxKQmAwAM8GD5I+8PALMy5PJK7p5fPj+ppZ8dB3nOxfaWzejrwSj5WsigmWbBOifRQGLeX7
	nUxyGeyovp0jYOZVfOhqg8RQgROVoIbV7YVbohIFc38DVnzE6r4qWHLqTp2zJpc6AUkkwphc6+W
	7m9YLEWIdccc7MH3Tq/Bm/YwUQJ3/O5b25oBoP+sr2QQhRL0Hkb0GHxgXdK3/tT1ITWB5Rb
X-Received: by 2002:a5d:64c4:0:b0:435:9144:13fe with SMTP id
 ffacd0b85a97d-435a5ff8c0fmr101536f8f.26.1769014660302; Wed, 21 Jan 2026
 08:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125120559.158860-1-clamor95@gmail.com> <20251125120559.158860-12-clamor95@gmail.com>
 <4370037.mvXUDI8C0e@senjougahara>
In-Reply-To: <4370037.mvXUDI8C0e@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 21 Jan 2026 18:57:29 +0200
X-Gm-Features: AZwV_QgURCnhkWoxVxcJP63yhkPm-ScQ-p0XP69L3txSPXMFGvGuHj06hr84FTs
Message-ID: <CAPVz0n1zqo1TyaV=+fc6YzOKH9TqOBEatruZTAVGg9hFEWmXsQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] ARM: tegra: Add EMC OPP and ICC properties to
 Tegra114 EMC and ACTMON device-tree nodes
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,baylibre.com,samsung.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41245-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 198365BA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=D1=81=D1=80, 21 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 09:56 Mikk=
o Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Add EMC OPP tables and interconnect paths that will be used for
> > dynamic memory bandwidth scaling based on memory utilization statistics=
.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../dts/nvidia/tegra114-peripherals-opp.dtsi  | 151 ++++++++++++++++++
> >  arch/arm/boot/dts/nvidia/tegra114.dtsi        |   9 ++
> >  2 files changed, 160 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.d=
tsi
> >
> > diff --git a/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi b/a=
rch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > new file mode 100644
> > index 000000000000..1a0e68f22039
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/ {
> > +     emc_icc_dvfs_opp_table: opp-table-emc {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp-12750000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <12750000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
>
> What's the source of the opp data?
>

I have used tf701t (T40X) and tegratab (T40S) kernel sources, to be
more specific board-*-memory.c files. Timing struct for each clock
contains min voltage field which was used to compose these opps.
1390000 is the max core regulator voltage, taken from tegra11_dvfs.c

I have converted an entire core_dvfs_table table from tegra11_dvfs.c
and I am planning to submit those later on too along with
powergates/domains configuration for tegra114, but that is for another
time :)

> Cheers,
> Mikko
>
> > +
> > +             opp-20400000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <20400000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-40800000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <40800000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-68000000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <68000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-102000000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <102000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-204000000-900 {
> > +                     opp-microvolt =3D <900000 900000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <204000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-suspend;
> > +             };
> > +
> > +             opp-312000000-1000 {
> > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <312000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-408000000-1000 {
> > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-528000000-1050 {
> > +                     opp-microvolt =3D <1050000 1050000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <528000000>;
> > +                     opp-supported-hw =3D <0x000E>;
> > +             };
> > +
> > +             opp-528000000-1100 {
> > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <528000000>;
> > +                     opp-supported-hw =3D <0x0001>;
> > +             };
> > +
> > +             opp-624000000-1100 {
> > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +
> > +             opp-792000000-1100 {
> > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > +                     opp-hz =3D /bits/ 64 <792000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +             };
> > +     };
> > +
> > +     emc_bw_dfs_opp_table: opp-table-actmon {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp-12750000 {
> > +                     opp-hz =3D /bits/ 64 <12750000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <204000>;
> > +             };
> > +
> > +             opp-20400000 {
> > +                     opp-hz =3D /bits/ 64 <20400000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <326400>;
> > +             };
> > +
> > +             opp-40800000 {
> > +                     opp-hz =3D /bits/ 64 <40800000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <652800>;
> > +             };
> > +
> > +             opp-68000000 {
> > +                     opp-hz =3D /bits/ 64 <68000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <1088000>;
> > +             };
> > +
> > +             opp-102000000 {
> > +                     opp-hz =3D /bits/ 64 <102000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <1632000>;
> > +             };
> > +
> > +             opp-204000000 {
> > +                     opp-hz =3D /bits/ 64 <204000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <3264000>;
> > +                     opp-suspend;
> > +             };
> > +
> > +             opp-312000000 {
> > +                     opp-hz =3D /bits/ 64 <312000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <4992000>;
> > +             };
> > +
> > +             opp-408000000 {
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <6528000>;
> > +             };
> > +
> > +             opp-528000000 {
> > +                     opp-hz =3D /bits/ 64 <528000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <8448000>;
> > +             };
> > +
> > +             opp-624000000 {
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <9984000>;
> > +             };
> > +
> > +             opp-792000000 {
> > +                     opp-hz =3D /bits/ 64 <792000000>;
> > +                     opp-supported-hw =3D <0x000F>;
> > +                     opp-peak-kBps =3D <12672000>;
> > +             };
> > +     };
> > +};
> > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts=
/nvidia/tegra114.dtsi
> > index a920ad041c14..6221423b81d1 100644
> > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > @@ -8,6 +8,8 @@
> >  #include <dt-bindings/soc/tegra-pmc.h>
> >  #include <dt-bindings/thermal/tegra114-soctherm.h>
> >
> > +#include "tegra114-peripherals-opp.dtsi"
> > +
> >  / {
> >       compatible =3D "nvidia,tegra114";
> >       interrupt-parent =3D <&lic>;
> > @@ -323,6 +325,9 @@ actmon: actmon@6000c800 {
> >               clock-names =3D "actmon", "emc";
> >               resets =3D <&tegra_car TEGRA114_CLK_ACTMON>;
> >               reset-names =3D "actmon";
> > +             operating-points-v2 =3D <&emc_bw_dfs_opp_table>;
> > +             interconnects =3D <&mc TEGRA114_MC_MPCORER &emc>;
> > +             interconnect-names =3D "cpu-read";
> >               #cooling-cells =3D <2>;
> >       };
> >
> > @@ -655,6 +660,7 @@ mc: memory-controller@70019000 {
> >
> >               #reset-cells =3D <1>;
> >               #iommu-cells =3D <1>;
> > +             #interconnect-cells =3D <1>;
> >       };
> >
> >       emc: external-memory-controller@7001b000 {
> > @@ -665,6 +671,9 @@ emc: external-memory-controller@7001b000 {
> >               clock-names =3D "emc";
> >
> >               nvidia,memory-controller =3D <&mc>;
> > +             operating-points-v2 =3D <&emc_icc_dvfs_opp_table>;
> > +
> > +             #interconnect-cells =3D <0>;
> >       };
> >
> >       hda@70030000 {
> >
>
>
>
>

