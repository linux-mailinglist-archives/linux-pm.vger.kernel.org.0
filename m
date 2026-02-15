Return-Path: <linux-pm+bounces-42661-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F2lLPpykWlXiwEAu9opvQ
	(envelope-from <linux-pm+bounces-42661-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 08:17:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD313E33E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4875F30125EF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CD298CAB;
	Sun, 15 Feb 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcHS3NZa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A91FDE14
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139831; cv=pass; b=rh+POfnfh3CcnFVfMxaSDfbr9rhhJBORS5eEvd6tnlUcNcWgw0wTTAzpPzK7W0X3yPEZxYcNIh9FdjAzDbs1nzgTmJNLTyGqcJcfFdKwLRtS1E1Jx4KdroKwcJ+uI23i8A/7OIntupzqipNOeg0ltVLOJq7VvxM+Ke7zr/YFGHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139831; c=relaxed/simple;
	bh=JS0BhaI0M0T4OEwZE5zY7caL8Sh/25K/U2LDuisyfWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDFdv1tI0mYQJLbHFJK9vkQnyuZBn2aljXL/+USV6J/KqcPiyimOkJvAUQ2WEK+OQM+ywH7w2HyrKP3qhqFQUoDup8h4R6jSAd0nCtY+RMkyWhFmLuTJPu0UeCPWHXJ3YEDg+KUIUmJ1+oYlImv3pdUQeFilUQh2SbDIC617Uks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcHS3NZa; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483770e0b25so15783225e9.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 23:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771139828; cv=none;
        d=google.com; s=arc-20240605;
        b=dqSceluEK6+uIa0FsIH0kMIENT0tGK+cOZsqN0RWBIS4uhkkDxd4law2VQIAVg+4K/
         S5WVfQJAI5HQz3QsKWzsajug7TS404TF/dWcBgPKTsqDBGTaIhHN/s+NEolA7NWKKM3M
         sakJPjstRAd+3GUwSSX5Xe2+x7a/sL6kzN3F//XHPUO9f9jkB7qy/wUsZYMVxD45HzoW
         RY9dxt4ZywDHjn130WDANROdc0ZxzhbrCrGWKN7kcTWWeOYDhX8g/qgLIfVmW1ix0zdH
         54cl3Le1Oj9OkDTrjexGb2BRGNK/+1ziF01d+Fq/INtoPvTt7EsVjVejLAnAmWG+K4xT
         DCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeJsvif0Hv7LAaNzH9fCosrikSJya4xCU2x26mkmqJQ=;
        fh=DukkHcMKJW9zioC8044C5wHSPyD60pR5lWTMI9LMvkw=;
        b=EdopAAEp1JN8ZsjLwOYAuu09piFgPL+MwMIEnW05SYOep9juy2MvQBax6HorIkW0UA
         7DwaTFxNV8NhaA9JWSk2OV/5QE2wyi/VlS/LzS/T0eXGYQLnTUMX5/mSJklNGGbGHaJv
         goLQsWkOPJS20hf1znIi5n/jopouaJRA07jW58Azz1qR+tTx1TYMMFPT1/+55nqQXNX2
         DdHI15MSnAK2CC7MGWNODWZ4xhYGPvB1gKeldQZrpsWZnXgQfgHsdEifG6Ep3Pp8NkyA
         oXnhJWOT/49tLuQ+urvePeJKe+RF7KozEeGIYsibIx/EPD2x0vxj8tZBgb1sU/LsCCrW
         eFDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771139828; x=1771744628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeJsvif0Hv7LAaNzH9fCosrikSJya4xCU2x26mkmqJQ=;
        b=UcHS3NZaUFLXn2Pho7FkrZa/l1Sx/cjepb0MyVOzQTAQOPQkPdRlSLYn1/ymY5kOw3
         7wJivbKJZeSIyb7OzKryecZcklTFl7tSJclqf0aCNZX70WloZJb1hSHdfWKf6YRPpooB
         +BJf/Ky/5NrEFDCcEc7L75fEoEVMK1MprVSTEBjKbZ7LBXfOxk8v00iE90u8gRc9dDl7
         vnFhWuyDAYy5mgghkDsnIVn5JJH4AR95wyFeEUmKL7/P4DleOum3EtceTUXalc2cXIvQ
         TmuxAmNcA7xc9ncX+1pXsZkLDTYSKG56BL9rHDVyp02/xJtGjLqkQNYLJg9zrXdD2jBa
         Y6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771139828; x=1771744628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeJsvif0Hv7LAaNzH9fCosrikSJya4xCU2x26mkmqJQ=;
        b=HOEVzk1beAAHN1RFkVekUcXV/ti+8/cgx5HT+07UZQAxLOuYfd6oJ3iDIIUl4ps+5Y
         jvoEvs2j+0fP2vSNpzd631tgw1wRRURcIQ42yV13dF/xJjHFK2DKS/uqEZz4gl7JCVbT
         knabOmvuvvpQztarTqhqaUGXUOe82l6xO+YfzbrJqFm45SJ6Es2Tpz+UepW2pbWvnS2q
         AyVQqju0MpYYae7zFAMRs0tvJXSuK6oCR+byCZajUki0J4207p/E0WHddNws4eVTleIH
         ODS4I1WwpmoZhchftMtg7SB0Fl9rD7y90YzaDi2Jc1kFpG581Z8Wy291jpGYaXaFiDFN
         pkng==
X-Forwarded-Encrypted: i=1; AJvYcCW7xX9UJOoK2OLx2MG0UuxVC5KZPEzHe5Eui3BxFMDFhg6fllRacj49QPcAuELM2KxiNnRJD2HjTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/pRctz1z9RBpM5sxu1j0/vgkvrCalO/7zj8LjpXa+ScB1U6Q
	MegIxGgKGfeRy6n+Egn7miUQWsAYTBodiGCWVAzrUfXEt8LEOlpnJcOtuinPH3Qiqa9k5jUx4+t
	M2qeF6hEUwF6cWnbCSGVt66mXw7WK4AQ=
X-Gm-Gg: AZuq6aJNkyPitiXkGbjg9dR/xDDhBFDctIPdF4wWb3X/CfK3pGoiW7QvEdDnoRr7wsV
	cIObBStQBjA+075CAEfXRNRdTDC/z5kz5zvefC5yWTm7uLCaWwI9ahI98BuklOyRuYC9kfnvWPs
	097bMQW7ZAP4ZYDsOOr+d1ENJyLkQQgcTIHxwjxreWs92lOXPT8nkY7tyK+2DzWIJmDdfGEkmio
	qDxZ8oyR+dAwJNzJiVT0EooPZSx2OrLSsU7V0aj77A7eqgl7xfdmhS2TJjuaGsevNFWv9oW26T5
	2WHf31TE
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr95610675e9.32.1771139827996; Sat, 14 Feb 2026
 23:17:07 -0800 (PST)
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
Date: Sun, 15 Feb 2026 09:16:56 +0200
X-Gm-Features: AaiRm52Z85WpK7PRCO4DxAthTZnDrmXah2vXpcFwOt0kQol8-3vlcxVKAzvYBBg
Message-ID: <CAPVz0n23UwST=jy+B+QSg+6A6B7uw1j6hY_p_b6J=ZmRU3zJig@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-42661-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8AD313E33E
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

Thierry,

Patch 6 "ARM: tegra: Add SOCTHERM support on Tegra114" adding thermal
sensor nodes to tegra114 tree was not picked, should I resend this
patch?

> Thanks,
> Thierry

