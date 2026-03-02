Return-Path: <linux-pm+bounces-43387-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKpTDVBGpWkg7AUAu9opvQ
	(envelope-from <linux-pm+bounces-43387-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 09:12:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E91D4767
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA9A83058EF3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709731C567;
	Mon,  2 Mar 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9CNzJY7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717261F875A
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438564; cv=pass; b=bf2ypcFm7RhZNCrE/gjRZbSumFWN80vHxTgpeG0gA7tMbBVpmh5+7uBwkkxRwuOw0WbUnzWFgCi68tF7vTUhXtDtwHo/oDNUE1gj54V7wAe5m5MBj5HnKDf0aCHBQLiaHla/7Fh8Ex+tZ4HoGrmKV5GhEOBwr9ur7BYGMkUs7lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438564; c=relaxed/simple;
	bh=vjkn4ApR2SwjC9QQbFTj/Obyb525qHPBGoJ4zOPSnPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmRNa2ruXT/AepgxYMvcv4Co3zvWx7mWpbVBw9G5Pmyonm5ldXLIGnqY5FYX+TvWo5uyRytUeGmBCWy9Y8pejMmPqyb0ssTFKncJKp6cNoEhecb3UtrByIEtvMy6YYG9TKw0a40oR8HubW4QxPNasw8neJFC+DZ4Cimu9NbAqEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9CNzJY7; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43991064db8so4276420f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 00:02:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772438562; cv=none;
        d=google.com; s=arc-20240605;
        b=bn9nTTA5lR8FrrOCnvRoLcV5RFNbf2DSVJBZbaVjQKLiIpaj+LXpPvqduuElAvwCub
         ndqvZjhcpHpKcEq2fbKI/yMzTH7eowMHx9Nr3hXahMpH66EVV8bFG3TlWALYlnqtB1jB
         tXenf+vd/UAkbaQaSRGRZJPOdEfiYs5UWXQWsEfiaVybsoCkvNnc4/eOsYRpT7KQ2w/A
         VSeKgdQ/RcemgPEIMub/o+hUBh36iMawQp1AdEBtoyF9xVzBdUYl6tM/2fEUX2OQiDM8
         vQnSCOrkEQicoyPGPwcvWd8gHY9nxyBi325Hn2pgc4JqO/PfEOAii97xGAyGYPOOBUxu
         3eEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6APRDcRhUjIkR+M3BFPhhG/NfjMrz+PATN7/PzHvm8=;
        fh=1LW4diJ8iBr4waccKnaPxSoelFRprXVuit/lh4C5kQ8=;
        b=e4GWc99SL2mXEVWtkfAwLKQ4aJAhRFam/5I/OP7iHQl10g47d4qJx11pYQKkxhOcfh
         rWA+raJmU8kYkHzo6p2E/+J4pprBy3I0WmiGIzpVBBbTNObsG3O/Mzopx4NkzlouMN+z
         xRSHrFogQyo2e1byv44LrYngd/VMOhutk4ABSlJ4vTyfe8hOk54mHbKFnRUOsScAiMrV
         p6+Ax2vNTbFX9Dcs+hMmEES6jMFCv3Lhbh6eoGo1WKIkAfHWrDCkjVIK0RSZRKq8VjRM
         A8OpyRAifoF7rM8R34C6QXVb5UN9SJYYzNHTErmnFrMV7iV4k6CM1JPpw3BTVWV2YfuG
         EHcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772438562; x=1773043362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6APRDcRhUjIkR+M3BFPhhG/NfjMrz+PATN7/PzHvm8=;
        b=j9CNzJY7UuNEHg0M+XIAyq8fqv2gsARtv0EBXfE5pR6JiLkoMF797zSQoCM8fZUay2
         JbJh+9OVeBuMYBQHO4I4nDL4NQZaX8Mob833Cz4ggHEG206+q/rFieMBUO0w9nSKYYUN
         in5+cc1VU3oVoopVW45IcGgCOnH5PdEMSx83ESMkkYnVfH4U/RV9IKuGR8r/TblCf3/y
         EOrH5d/Z2z0cfGV2WQbi0M13QmT+kqNyhBeLxRyJoXRVbi/3SPzeWn5oleIRmKmY7Juo
         f89ywFr/lEBJLps4KRwBQAinHtFv9iWWQseh8GGVXXNqStgUe7tiIAwvjthGvBgGb5VZ
         1Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772438562; x=1773043362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6APRDcRhUjIkR+M3BFPhhG/NfjMrz+PATN7/PzHvm8=;
        b=DWRtKkLHvyfwuCjMnwGdQzO9PDoZW1kG4aBC7t9w8XD5XI2ECy1ZdzVrinecIxt5qJ
         X0E2oS2b0ACMZgmb1JO7qQbyyUCHFI0n8G9QKU3CA8AJA5SDsHmTo+I7Qkg8kh/FFWOM
         5aQbqYaUeAXbiBqbM34Igrv37f7eH4T6tDnCwJQ3j7jJAQwuK+NWioIp/kq8AmWPaM+B
         IHXZwIxs7K8E2BmPy/WYpWVNJNNNSZNg/DQA5Q/xWULsPQk2Jmzzc1hpeEwgqEslHgio
         SdpIwWk8Cy3FwrANQtmr4sI7pl7DqJubI3U+N34ts4OqeoqrCEhJp/EXvVHhbuRhmYId
         XAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKq+VgjtFg3N0fTGAYB51pBnF5mNjZ1qcHLOQu+sDOtoMC0zDeZ6BsCViRt5BSD35Hhf+9lOancQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCXECUVGYIetiM7UbY5PvayPAEmXWLKwFQMA5UcaL/LrtjRex
	U9/gqbkV3kigkRnSz8qA3DH+fGdf09ajcBXCHB+Fnxnli1H82oeTTm1CwgUDY5DEeRL+Ehiwx2G
	1GgXyssSJdU/3vIc0mcX0JRI9VfYORl4=
X-Gm-Gg: ATEYQzzEPoMgLPeQbv5PWxwfTfDszhPdUM0UaU6zCItWH3Hi9U6iBX/eaBwjGhRneIZ
	Umgt9H+Fs47KVeOPklD/ccHjUBMDlrcrsxVvAS1AmQHOYmr7Eyyl5CWGJY9r7rwrjCknoq35CBK
	w1/3N0jHQtpdJs4ax4dWazZ9fWo36UmY/bC8RCzwxPpvkZpTQqHm7fUymiFbiXpuZ7I1Fa+oq0R
	4a5uMrzTUjhOQ4B2c+WCAOmIzLDbJNJluUD6xBxpeAF6zeVpIN18HDF9CiPRxdlKd8EvKwNV62a
	VB+XQEQrvAoOdSYmZiU=
X-Received: by 2002:a5d:584d:0:b0:437:67fd:ef5c with SMTP id
 ffacd0b85a97d-4399dddc7efmr22120608f8f.8.1772438561482; Mon, 02 Mar 2026
 00:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828055104.8073-1-clamor95@gmail.com> <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
 <da8aa4c5-4aa0-42f6-acb6-55d37cc29774@linaro.org> <amc5e3sffmwqguivwch6b5vtmlgu5dlwxm7bsrn6nd3rllbvxg@koqmavn6uuy5>
In-Reply-To: <amc5e3sffmwqguivwch6b5vtmlgu5dlwxm7bsrn6nd3rllbvxg@koqmavn6uuy5>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 2 Mar 2026 10:02:29 +0200
X-Gm-Features: AaiRm53AlW0Vs5liTlfz2qko8M0ob5L9wn1q8gJB9M2tLSanbYjxsAX2ISoySnw
Message-ID: <CAPVz0n1XMpnetG6JKhTLMxW3WNSSAV0Sr52KrZc=Frt=fmSKYA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
To: Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43387-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9E2E91D4767
X-Rspamd-Action: no action

=D0=BF=D1=82, 12 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:27 Thie=
rry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Sep 11, 2025 at 08:56:12PM +0200, Daniel Lezcano wrote:
> > On 11/09/2025 18:27, Thierry Reding wrote:
> > > On Thu, Aug 28, 2025 at 08:50:58AM +0300, Svyatoslav Ryhel wrote:
> > > > SOCTHERM is thermal sensor and thermal throttling controller found =
in Tegra
> > > > SoC starting from Tegra114. Existing Tegra124 setup is mostly compa=
tible
> > > > with Tegra114 and needs only a few slight adjustmets of fuse calibr=
ation
> > > > process.
> > > >
> > > > ---
> > > > Changes in v2:
> > > > - no changes, resend.
> > > >
> > > > Changes in v3:
> > > > - expanded desciption of "thermal: tegra: soctherm-fuse: parametriz=
e
> > > >    configuration further" commit
> > > > - changes title of "thermal: tegra: soctherm-fuse: parametrize
> > > >    configuration further" to "thermal: tegra: soctherm-fuse: prepar=
e
> > > >    calibration for Tegra114 support"
> > > > - Tegra11x > Tegra114 and Tegra12x > Tegra124
> > > > - ft and cp shift bits dropped
> > > > - clarified tegra114 precision
> > > > - lower_precision > use_lower_precision
> > > > - nominal calibration ft and cp hardcoded into SoC specific structu=
res
> > > > - added tegra114-soctherm header into dt-bindings
> > > >
> > > > Changes in v4:
> > > > - fixed Tegra124/132/210 cp mask
> > > > - dropped TEGRA114_SOCTHERM_SENSOR_NUM from header
> > > > - TEGRA_SOCTHERM_THROT_LEVEL_ made SoC specific
> > > > - adjusted soctherm node and inclusions in tegra114.dtsi
> > > > - dropped use_lower_presision and nominal_calib_cp options
> > > >
> > > > Changes in v5:
> > > > - fixed CPU and GPU hotspot offset values
> > > > - added static_assert()s to assert the TEGRA114_* and TEGRA124_*
> > > >    counterparts are equal
> > > > ---
> > > >
> > > > Svyatoslav Ryhel (6):
> > > >    soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
> > > >    dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Managem=
ent
> > > >      System
> > > >    thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
> > > >      support
> > > >    dt-bindings: thermal: add Tegra114 soctherm header
> > > >    thermal: tegra: add Tegra114 specific SOCTHERM driver
> > > >    ARM: tegra: Add SOCTHERM support on Tegra114
> > >
> > > Hi Daniel,
> > >
> > > there's a build-time dependency on patch 4 in both patches 5 and 6. D=
o
> > > you want to pick up patches 2-5 from this series and I pick up patch =
1
> > > and hold off on applying patch 6 until after the merge window? We cou=
ld
> > > also do a shared branch, but it may not be worth the extra hassle.
> >
> > I can take the patches 2-5. Regarding a shared branch or wait for the n=
ext
> > version, I would prefer the latter
>
> Alright, let's do it that way. I've picked up patch 1. If you take
> patches 2-5 now I'll pick up patch 6 once v6.18-rc1 has released.
>

Hello Thierry!

Patch 6 "ARM: tegra: Add SOCTHERM support on Tegra114" adding thermal
sensor nodes to tegra114 tree was not picked, may you please pick it
or should I resend this
patch?

Best regards,
Svyatoslav R.

> Thanks,
> Thierry

