Return-Path: <linux-pm+bounces-43899-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E7gCH4orGlSmAEAu9opvQ
	(envelope-from <linux-pm+bounces-43899-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 14:30:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B621022BF6D
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435093021B09
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3321CC5B;
	Sat,  7 Mar 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUFOnMi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA91C3BF7
	for <linux-pm@vger.kernel.org>; Sat,  7 Mar 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890235; cv=pass; b=e5212nxtgiLr3jHtb+zsI/i4tCHLcGekl6hFlEQ4a8dgmx8opShWZzsfXej+i4V7qPQwAjAdoMJ+xKDKXHfKMTdXlI5B7YAW+cPI0XcOc7gKGnNjvqaWnkaWJWxYtlwtfo70UkVlUNFKaCeCDshU/+DbJtRRUncSDzG0kDN5hSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890235; c=relaxed/simple;
	bh=G6kNegQKBFYwnygE7hIWLaa6frsBBELEiBKJ771TxG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9mPQBgc/ycV4otXoe/GlhMLYZ0l3oN87idvBLTJc93si+rcmfrVJPpcSs/qso93xY3cvqMRYxvDLKPL28EPU+2TvXmvxlk8uD7aPu9Ej84mrnJNvSqqH3VguFm4eRHh8RwmuCqyJq1VDVuxbXwrLEVUCEycuvEojp7Hx3bmJAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUFOnMi4; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso7358187f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 07 Mar 2026 05:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772890233; cv=none;
        d=google.com; s=arc-20240605;
        b=hDH+Pzu7NQcMI3ZmkamUybdD4RBmxp6V5Jt4TJNZ8n936dIJq0coUlITSmmMlk9r4v
         ZWlWphL/qNAP1YeOJHw8RT4FAAoufvqE8xNFytN86pITO8G2Diuld6rqmNmK4Qcw5vTA
         SY2d/NHvQays40Qh71sGY7ILBonfbA94cW3j73gxU9ae1bwQxDawOHKvlb8/W4ZmqFAp
         6ofciJaSidpwpEAAJLEwiYd9FVxvdSqwpO9gv1OfzDRVu/WQCmURsHHaDDiEDkme69wM
         WLa2pmK0Ti5iGzTZcHSlOuYvII50dPS5W9S/Sv27vNbm3hhOldUidLjwJEXIByjXu1u7
         aoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9vxg1zKKw5eRGATryRLQmdjvykX+/jqWfKws1Yp5Hqk=;
        fh=prYY11oVeEg1sds/VnwYzd635b4qvb13VRBms/Yrqdw=;
        b=fKo9W8cH+em1w7zwNg/TTgkRhrUJjah5zflWhQOhlk3TtCIdmZ4SUmk9U++A3XrdMz
         UTx4PSgWT5BmtVMbVtkt7pVJlJLUkWVSOA/kU0P+gtrnOYFZ9fBjqSWLqsGvlKLxFQug
         EUmvUyhasG9b5PqdSKk/WV7Xbp96ZhVaYlIrRnU6/nfSMeYviY+1ciJc+h0rfwHvt9y6
         A+rr93Od1HGzhWfX86+B5JghASi8nqAyYICCVDVte484woPgy7F8pVF1bhZq02s3UvB2
         PSimXXl4jGRDjkAetolj4Sj1vH7o3uYV+yKcciPHwTk9DEfmdP8egjsuvVd+M+2aumJZ
         UzWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772890233; x=1773495033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vxg1zKKw5eRGATryRLQmdjvykX+/jqWfKws1Yp5Hqk=;
        b=bUFOnMi4MPR0wHADjkPGTcwezfzOOsx+6SCp2Za8p3WQjIt5a4Oq+XyPyShsvwGpvX
         DbGdbetRlaLjmlOJotLVmgcG9P91aOyDc9hZ6Z/RwHDEYhnPIv4cf+O05uMMCaIZjPgj
         kbwIwzTNPexvfFvWSbO0U2xfjg/0x8m7/3KT1JofDa2oDCO3LmxSsyFZSnyAEigVijFK
         pvKiA8aUGTRTReF8+pLJ9A5wefMh22YNwtBB/ucjBZDyMbb9tUPnyNmb32qDbAwO8Pvi
         V/tHHd9VpG83ILVzeUg6Bf+CCC3jn/MIu2bWbZpl2qF7MzwiIaWukANBRUY/WhRldufQ
         68JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772890233; x=1773495033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vxg1zKKw5eRGATryRLQmdjvykX+/jqWfKws1Yp5Hqk=;
        b=FodZ0uLS1Msw67q2AaQ7DXCZsYaedyGleCvyh26qorhxw1n8787ucQFhUwAv1g46Oj
         GxhwLfVuX0Fh7kvvTOkG2hqoyD+gq8yMngNfunkrpoIb3z8L5tZRGjK6QeGPMcc9N5zY
         JoAHdlrnr3I99rUYZK1s6UUWUvlEM0shIYW1IOifGWXgzea3TEmeQmXGyi6Ax/UgMC5P
         Gzo0L6FLFMCtNJScf2k/d/Cj9DnFCu8su79dK93TFN6AIJgOnfQMqHZY0JIac7mrMhvd
         fr78ZLpbMqq7eMKEWgo+y58u4Tt0jiO8ONxNexD6DKsGOcEwM99ubmR2k/8ZkSeyHORZ
         +N5w==
X-Forwarded-Encrypted: i=1; AJvYcCVFmOHzSQIQ6qd9S+8ylr8DVfU9fa0SqxK3Bv3cz+iY3yZXMMO2SU4yqj6Pd3iGYoQekb+CAsRp3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvdy7FjpZ1/93Uufad/8JhCGtygWIXqEvx9iePw0JMtqLPWouz
	R8gf+5QFYql+EHbZ5ZLkvpNJn1N1K2pWPPQegwojhTm0Y6J3JLBVJgSXzQBO/JzKEU5MKSLDNL5
	9W99/SV74RJcqHRnb0QFR7TBvHQbrclc=
X-Gm-Gg: ATEYQzzpd1Al3WyKVTK7A26yRtNqHfFdXyHz0JzG3DQ6y1mUuemVswLRZGUjQ80cPBV
	aPOHMsL7XiMvb1eLHO4OlLQLYRJq661l28HGyUyqEz0Iysd6Zv8uzkqGtUTrk1VzOP1Vk+w82IN
	MExm4BgajuyA53m1B71SVflG93bVi71DqdUTOSzCwjDXKY6gDTQMwgYIoW89dLwq65kiV6jDuwq
	0wEu5ZUifIHM52878QSclV5HiT4KfySvWWEdB7EldYqJzpTceYuMBZXo65anxze4OPGGd+r7iud
	vOIJmJJ7
X-Received: by 2002:a5d:5c8a:0:b0:439:be82:1fd9 with SMTP id
 ffacd0b85a97d-439da555622mr9640492f8f.12.1772890232456; Sat, 07 Mar 2026
 05:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306133351.31589-1-clamor95@gmail.com> <20260306133351.31589-3-clamor95@gmail.com>
 <20260307-smiling-coyote-of-economy-317afe@quoll>
In-Reply-To: <20260307-smiling-coyote-of-economy-317afe@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Mar 2026 15:30:21 +0200
X-Gm-Features: AaiRm52hvDWp-hTuU970bgp3X7ZySQtnac9bE5SZT5ZlBfWPeg_o_bRZtEnvaRs
Message-ID: <CAPVz0n2QXSFnrkLPFVDbUjNAkp2_dTumeXh4EsB11ca0jHEC-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-binding: pinctrl: pinctrl-max77620: convert to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B621022BF6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43899-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

=D1=81=D0=B1, 7 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:48 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 06, 2026 at 03:33:47PM +0200, Svyatoslav Ryhel wrote:
> > Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC from
> > TXT to YAML format. This patch does not change any functionality; the
> > bindings remain the same.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
> >  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ------------------
> >  2 files changed, 97 insertions(+), 127 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,max=
77620-pinctrl.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-m=
ax77620.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/maxim,max77620-p=
inctrl.yaml b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinc=
trl.yaml
> > new file mode 100644
> > index 000000000000..7364a8bdd7d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.=
yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/maxim,max77620-pinctrl.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Pinmux controller function for Maxim MAX77620 Power management =
IC
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  Device has 8 GPIO pins which can be configured as GPIO as well as th=
e
> > +  special IO functions.
> > +
> > +allOf:
> > +  - $ref: /schemas/pinctrl/pincfg-node.yaml
> > +  - $ref: /schemas/pinctrl/pinmux-node.yaml
> > +
> > +patternProperties:
> > +  "^(pin_gpio|gpio)[0-7_]+$":
>
> Underscores are not allowed in general, so pattern needs fixes. Does
> anything actually rely on this name? Is this ABI? I don't see old
> binding and driver using the name, thus this should be just ^pin-[0-7]$
> (+ is also not correct if you have max 8 gpios)
>

Old txt schema uses pin_gpio[0-7] hence it is here, but greping trees
did not reveal use of pin_gpio so it may be dropped.

No this is not ABI, name may be any. Including gpio0-1-2-3, gpio2-4
etc which is why + is there. or maybe you know better way to cover
those names?

There are device trees which use gpio5_6 with the underscore
(tegra210-smaug.dts; tegra210-p2894.dtsi for example). Should the
schema account for those?

>
> Best regards,
> Krzysztof
>

