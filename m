Return-Path: <linux-pm+bounces-42831-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP+kHw0Flmm4YQIAu9opvQ
	(envelope-from <linux-pm+bounces-42831-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:29:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFB158B57
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579B630053C3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F73451C6;
	Wed, 18 Feb 2026 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTnKods6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9582EB860
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439370; cv=none; b=PkwzlsrS877OHpBMNJGvRE5kRceOE2vIgGmLLAumWTB02r9b1f+wyKsXyqgYdalkpsRqda/jOnyb3hE6YkCf4iku0XYJFyABmPYcSKte9glO2AFUoYXMstM/CWq7ZT9WwRWbdq5KfKBTZ8Rpb7omT0hmcJkKLVcJLqRgFbqc5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439370; c=relaxed/simple;
	bh=eZnBqrWtQXg6JjfPWHTRiksi0baJe5tMKs5q38C8B/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gNaR9FAZMrztRYWInJSFPxmlRuMu55BIUOPAev0CIulc958xb2hfkV8Zn3RN3M1ROxluxqO9sZ1yYSY5yyvCBZlE9caAApnrDw5yYOMQCPT6bZhKfJ+jLX98BMuGNs1bKT0VvYkIx48dcIlTycZ1HTaOi0o5X1kw2rqiLv8+JIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTnKods6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48372efa020so1080815e9.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771439368; x=1772044168; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2HG7dMgFbjsQ2a9OaL1N2Qu53e+VsL6dqqrCn2unbo=;
        b=CTnKods68RFkYQ+DXwha5Qz1xJXqCTgoi53KBg6U+pJVI+PjOEHWwkDR5nprqpNob2
         +L8ReFYcSknBNYMswj0DfzKMCmjliOW6gW52EM/5/Ch4C2Q0UTG3mwn0hQPVi/AYeZ96
         sYTXzswQ2PNRtkYKpqBTG+9DP1o3clh5H8c0stxyBkQ6A3fxe+/h5FuC0CLOrDhxjFqy
         bxmvL9wUcTbUNkJYTMkgQ7pFnCLEa4OkqucF/kh5c2zpnuAZSfED83P5vQbup27KgV7A
         2h8dgyAQtMWYc0HtgrzLuO1a3sdEBNxVN0aUSp4mMMJc+WRSL2lv5bIutzybd/Juc7MH
         FFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439368; x=1772044168;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2HG7dMgFbjsQ2a9OaL1N2Qu53e+VsL6dqqrCn2unbo=;
        b=qlxCD2AwYHki6IrvD/PSDMks+Ijf37UBO+mY8yfnzBtTZgUbQC2xwI3E5bpvGuH5Un
         Aw8KuvB8Dcn5eA+eFZCyEhIfT9wN2iZ+DSlX/ac7e8SotP7NATHtg4G70KjMLKdFJ1Mg
         KJV2zFPJC9Y1QzJJtm7UZXegJk71mQ1/Fm0IdHGUquSEMhdhn/Lzu0DYVwnDjgK/wWjN
         1IeYk9r6NUySKsQrxJVQn9+sVS5dQwwrkQLscL0yqPlAGBDLzLWkvmaLvt/e7/hFom7i
         TmFGVfcCl6Dgpp3Ij864sqImcZ59kon8FWun4LV97i1G5dIG57khDpQU0lRbXTFJJu9K
         GaIA==
X-Gm-Message-State: AOJu0YzUFd1RebuLau83KUxUOaRRvE+DIPfcoXi/b77oExt2f+i0MQ/r
	sT1v2DkL5zyp1nxg0wrGnJpj5tRBb3/3OV+24ukOB2B9KZ0XoE3USHpg/2N36NWyTK4e6hbfNVb
	vZv2Qmas=
X-Gm-Gg: AZuq6aK1f9NcJ/LvxEr4rCcgm7lpZHzmtReS660TrziMjFgHoHLJpZfTF92JPhFb10X
	hulOlX6Zdvj3zlctzrbjqZZFFxWDmF65yliTkRlUx27n2JpXWPxDkWUSihelbcyQmELzmOmUe+1
	6pP4ALtygmrOZ5eUYKzutQ2B4M1anH8GKIO4ssbY1B6MslInLJUyma3cZThHQdT2RTO1syl7NOg
	8nrRoHjMHVFWHvTrWJFHaVNXhZ+4d5mtxio086NU4lQ4+5oPb7eAAZbesvvtbDChh/LDizIwiab
	goi5idKcBXa4pN/w5VoZpr+id1WoYFM2P2YYGQpS0wZ3XMA+gcCX0E5wl7oGvC+tz31MqoZpZ5d
	B0SrPMylm1ZZv/HWgoP/NYjRlhpWvpitD0uN37tQEv7SXoz2AwYBD3+GN/6dEOnZBbGi0PBRzOu
	mCwpCoalCn+v7FmSeAcVV1301VF5kUT9zEhfOZ3JEWId4fWjk9felbu74dLQstf3lQLV+ArWA7I
	FVl/8qrtr/NatWnog==
X-Received: by 2002:a05:600c:46c9:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-48379bfd71cmr230436375e9.19.1771439367849;
        Wed, 18 Feb 2026 10:29:27 -0800 (PST)
Received: from localhost ([2a02:c7c:5e34:8000:17bf:52bc:6ef0:a984])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm439288555e9.10.2026.02.18.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 10:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 18:29:26 +0000
Message-Id: <DGIAUIFPUHN8.35B5MNEUK1JW5@linaro.org>
Cc: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>,
 "Lukasz Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Anand Moon" <linux.amoon@gmail.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 0/7] Add initial Exynos850 support to the thermal
 driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mateusz Majewski" <m.majewski2@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <CGME20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183@eucas1p2.samsung.com> <20240911121136.1120026-1-m.majewski2@samsung.com>
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42831-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexey.klimov@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.153.167.240:email]
X-Rspamd-Queue-Id: D0AFB158B57
X-Rspamd-Action: no action

Hi Mateusz,

On Wed Sep 11, 2024 at 1:11 PM BST, Mateusz Majewski wrote:
> This series adds initial Exynos850 support to the thermal driver
> together with its requirements (sanitize_temp_error fix, adding the new
> string to dt-bindings), while also cleaning up a bit (improving power
> management support and removing some outdated information from
> dt-bindings).
>
> Changelog:
>  v4:
>    - Cleaned up sanitize_temp_error a bit more
>    - Modified exynos_tmu_update_temp to match sanitize_temp_error
>  v3:
>    - Reworded the commit message of the dt-binding information removal
>      change
>  v2:
>    - Reimplemented to use the Exynos850 TMU clock: removed the patch to
>      make the clock optional and changed dt-bindings change accordingly
>    - Improved the Exynos850 implementation itself (style and one correct
>      register offset)
>    - Removed conditional compilation in favor of pm_sleep_ptr
>    - Shortened dt-bindings description
>
>
> Mateusz Majewski (7):
>   drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
>   drivers/thermal/exynos: use pm_sleep_ptr instead of conditional
>     compilation
>   drivers/thermal/exynos: improve sanitize_temp_error
>   drivers/thermal/exynos: reuse data->temp_mask in
>     exynos_tmu_update_temp
>   dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
>   drivers/thermal/exynos: add initial Exynos850 support
>   dt-bindings: thermal: samsung,exynos: remove driver-specific
>     information
>
>  .../thermal/samsung,exynos-thermal.yaml       |   8 +-
>  drivers/thermal/samsung/exynos_tmu.c          | 237 +++++++++++++++---

I applied the whole series locally, it applies fine on 6.19 but I didn't
check linux-next; and tested it on Exynos850 E850-96 board with the
following DT node:

tmuctrl_0: tmu@10070000 {
	compatible =3D "samsung,exynos850-tmu";
	reg =3D <0x10070000 0x800>;
	interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
	clocks =3D <&cmu_peri CLK_GOUT_BUSIF_TMU_PCLK>;
	clock-names =3D "tmu_apbif";
	#thermal-sensor-cells =3D <0>;
};

and thermal zones as you mentioned way back. It works just fine.
Temp goes up to 48 C with a loaded CPUs and settles at 36-37C when idle.

So for the whole series:
Tested-by: Alexey Klimov <alexey.klimov@linaro.org>

However, do you have plans to update it or re-submit?
Or any other plans working on it?

Thank you!
Best regards,
Alexey

