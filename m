Return-Path: <linux-pm+bounces-41696-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBoXLnRwe2mMEgIAu9opvQ
	(envelope-from <linux-pm+bounces-41696-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 15:36:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F5B1076
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F170300C5AA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966C2FF661;
	Thu, 29 Jan 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaLnHngU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73502FE593
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697307; cv=none; b=j6EyIyeLfeAr35itXlBMnr5wKNrOO7RKtEp+C9MyANiZJoU7s5Z3FeG6eMI8VMznqgELApa8dRLmXcx4DPAMteyRKjETdYAp/mv10awGst5A0g/KUraHOUu2ibHFWIKgpSsELND+UCag3HOHgJWb/W4GNRnqRaT7x/0vUd72Uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697307; c=relaxed/simple;
	bh=PxQZS0lpogFjI95G9cD5LHetBfkJyp8goCiiruUkGew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/Oec5PW8eVntwIiLdHWBFSOu31+lhAe7G4T7iyQLRDbs92P7rw56NWW9hN2Vf3tgcQMLJDthHl6zm/Jb61vAk29icbBdAqoHH44apILocbgTbpM3wbrZ8+UMTcPpAO5hOc1beV9qPNLlCtxAW9n4ixRG7Y4vVdY0+RiaB1d1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaLnHngU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA82C4AF0C
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769697307;
	bh=PxQZS0lpogFjI95G9cD5LHetBfkJyp8goCiiruUkGew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NaLnHngUnk6jKOJLPwqqLL1aT4RNRrH3d9HQmKwoRze5+OG2KuVd8nrzSWRJtHc/M
	 /Ic5pXXU97ToGdZLtEJ40H/RGyaljbsUiwqFhuhc5e8N8Ook1ia5jZeRm+57mbHJFY
	 LcntRrUcqYwp9Ymlu8rzKam5bcoRlxT7mRMJhsUvhe1ZM0J/J4UiTTvAAXmBYlxJCW
	 JAWO0ciSaW2UY1BDqCGmAbtRLxDjBfkse0cGapZLcDe6lIPYjdGn9PaVO+/G7QA2Mp
	 fom0K1C0EEOSL9Unw1hqiO/y0SloBv8zk2eauPpWPtpZc/V4tIxBdnGu2Lfvhx+QQh
	 v8Zo3ZqIEwiFw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-66307e10d1dso446114eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 06:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWe3enuWVgVOrBuJ7IAjRGEA8BhRfx3v/zRpD5HM0gf4S4iC2z7fvUyOwhp05Dw/xyqVJNzS6smYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9qEH7Ah7HY5geJasLDYnkKOPpPWc3CVMlCi7gqI+JI1I/7V6
	iCaN/uUEwrnh4YVLc5q3qh3teEMgUjeQhYl/A8XFyNOwsFd8T7W5rHzS1iU+i4ZtNUTXJ8RZSyb
	f+lViI+rMr9AHixPODlfTyirimkKNd/Y=
X-Received: by 2002:a05:6820:4b85:b0:657:5f31:31b1 with SMTP id
 006d021491bc7-662f1f3fc63mr4586589eaf.0.1769697306372; Thu, 29 Jan 2026
 06:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ebd51a4-4b69-4179-9e23-ec1c38fdc803@linaro.org>
In-Reply-To: <2ebd51a4-4b69-4179-9e23-ec1c38fdc803@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jan 2026 15:34:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgAnBRk1Q_wKEZrS0tkBitjNLbQNneO2M=5sr=GPCHBw@mail.gmail.com>
X-Gm-Features: AZwV_QhwIhEBRhLEDdHbrT-eVf6WFpPx9D6Ax9hY-NeSPuCMN9C52liTbLhV7Sk
Message-ID: <CAJZ5v0jgAnBRk1Q_wKEZrS0tkBitjNLbQNneO2M=5sr=GPCHBw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers update for v7.0/v6.20
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, 
	Laura Nao <laura.nao@collabora.com>, Frank Wunderlich <frank-w@public-files.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[rjwysocki.net,arm.com,vger.kernel.org,bootlin.com,collabora.com,public-files.de,linux.intel.com,linux.dev,renesas.com];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41696-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 265F5B1076
X-Rspamd-Action: no action

Hi Daniel,

On Thu, Jan 29, 2026 at 1:05=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider the following changes since commit
> 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:
>
>    Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.0
>
> for you to fetch changes up to 0061030929e2d09398ade9fae320528bdcba2bed:
>
>    thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
> (2026-01-21 19:06:57 +0100)
>
> ----------------------------------------------------------------
> - Fix CFLAGS and LDFLAGS in the pkg-config template fir the libthermal
>    (Romain Gantois)
>
> - Support multiple temp to raw conversion functions for the Mediatek
>    LVTS thermal driver and add the MT8196 and MT6991 support (Laura
>    Nao)
>
> - Add support for the Mediatek LVTS driver for MT7987 (Frank
>    Wunderlich)
>
> - Use the existing HZ_PER_MHZ macro on STM32 (Andy Shevchenko)
>
> - Use the existing clamp() macro in BCM2835 (Thorsten Blum)
>
> - Make the reset line optional in order to support new Renesas Soc
>    where it is not available. Add the RZ/T2H and RZ/N2H suppport
>    (Cosmin Tanislav)
>
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>        thermal/drivers/stm32: Use predefined HZ_PER_MHZ instead of a
> custom one
>
> Cosmin Tanislav (5):
>        thermal: renesas: rzg3e: make reset optional
>        thermal: renesas: rzg3e: make min and max temperature per-chip
>        thermal: renesas: rzg3e: make calibration value retrieval per-chip
>        dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
>        thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
>
> Frank Wunderlich (2):
>        dt-bindings: thermal: mediatek: Add LVTS thermal controller
> definition for MT7987
>        thermal/drivers/mediatek/lvts_thermal: Add mt7987 support
>
> Laura Nao (8):
>        dt-bindings: thermal: mediatek: Add LVTS thermal controller
> support for MT8196
>        thermal/drivers/mediatek/lvts: Make number of calibration offsets
> configurable
>        thermal/drivers/mediatek/lvts: Add platform ops to support
> alternative conversion logic
>        thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
>        thermal/drivers/mediatek/lvts: Add support for ATP mode
>        thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
> calibration data
>        thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
>        dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
>
> Ovidiu Panait (1):
>        dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
>
> Romain Gantois (1):
>        tools: lib: thermal: Correct CFLAGS and LDFLAGS in pkg-config
> template
>
> Thorsten Blum (1):
>        thermal/drivers/broadcom: Use clamp to simplify
> bcm2835_thermal_temp2adc
>
>   .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
>   .../bindings/thermal/mediatek,lvts-thermal.yaml    |   3 +
>   .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  34 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
>   drivers/thermal/mediatek/lvts_thermal.c            | 362
> +++++++++++++++++++--
>   drivers/thermal/renesas/rzg3e_thermal.c            | 123 ++++---
>   drivers/thermal/st/stm_thermal.c                   |   4 +-
>   .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  29 ++
>   tools/lib/thermal/libthermal.pc.template           |   4 +-
>   9 files changed, 483 insertions(+), 85 deletions(-)
>
> --

Pulled and added to linux-pm.git/thermal, thanks!

