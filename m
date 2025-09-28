Return-Path: <linux-pm+bounces-35522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D5BA6EA8
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5057A838C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD62DC337;
	Sun, 28 Sep 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnVW8d31"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004812DC321
	for <linux-pm@vger.kernel.org>; Sun, 28 Sep 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053923; cv=none; b=sNf4E39wSJAAP3Y06n/yoRqc2pJWlv63WVvq9B6D9P7V3Q6uYnf3RHHU9dd787zV/qrqXmYUNKsL4MiSh4pdTX2Z+qlVMxmOz5FWH20zioiLpQI/3YblQvUA3/1K62EmxgzSlAFoviWZ+W4b+pppGiDLPxMlDcBeVgA1FbA3/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053923; c=relaxed/simple;
	bh=FdQdV6EKcysKfdvysmJi8PmEz/o5IuIR05/jzdQQrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8Dsl32UDNKvpZ9HO2nGMN4S77vUPRTrbZCVE61mB2wyvfGGsZTOdVySP33tjDwgvSjY6kx+NTheO+3nPer9+46E3BXmFFZVgFl4sgeEO4WhaPb0Db5Guv/+Pv5JW4HzzB6W/ybpzrKj6nAGO+WwzkC2W4Pur64IZpcDOu4Oxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnVW8d31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84410C116C6
	for <linux-pm@vger.kernel.org>; Sun, 28 Sep 2025 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053922;
	bh=FdQdV6EKcysKfdvysmJi8PmEz/o5IuIR05/jzdQQrYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UnVW8d31HjkRA8NpSPucGqBJflkwvenhwazprUTtRZz6UagdjtADK7ywERNLPJS9B
	 lplUgfdGZ8TDBYro00L88gsdQGMOCwbsHdu1fBT4RRrXlx8+/SvHZqeu66RaiI7saN
	 h2sgzR38VANBXfU0Uma5QtMIwvgHs9K1maVkmugTeWxaqgoV2lDP3J/fv0WEVJImag
	 MTqAjBkNrzEys2T1s981tow7UkkSFkOCl1kHLNZToQ+NToqLqBAEIBKSvGOXHWX9BF
	 uosH8ZAnJiSrDeh3V/NovQ7bUZa5bbY/Vbu5FThsK0HAf+U2xFuk21qoxoLsooNsTU
	 tcnY5lq9W+ayg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7abc631ae5cso2046325a34.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Sep 2025 03:05:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKO1PD7J6S4zVA2I6rz9TTvQ/YeDPYkD5apfCc87mwuBNA9br6CljfhmPRaDiNnjGxhdQQ5SI2RA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnyi+V9oYC9ZvVmXLtCpXdCsYGttLJn/2RKpqPjXFToiRPDMa+
	kC9PHdS8ZIktMqCFI63A8QjTpUjv5pwZwHqIqIaaObTKfoMJ9y8KYgT1S34+HOKUWfYMGKYA7/M
	pVekrjeJ8ohvzyJLJHFVW7EwO2aE3qHs=
X-Google-Smtp-Source: AGHT+IFCzORk5att9vJ/4iiSnpvi70q5WkKijwIWLiGYgkpl9JJsmcMEMupMwwP8EFtqH6wt4Q5+dfEpOmfuTRpBZfc=
X-Received: by 2002:a05:6820:8391:b0:640:a3eb:333a with SMTP id
 006d021491bc7-640a3eb35d9mr3616610eaf.2.1759053921906; Sun, 28 Sep 2025
 03:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40c2a6fc-8dd9-4f6c-9ebb-2f74f7d0b795@linaro.org>
In-Reply-To: <40c2a6fc-8dd9-4f6c-9ebb-2f74f7d0b795@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 28 Sep 2025 12:05:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJe3Hy6mWB+chRbvsCM_xjPX+8XpSjGZ1G8eFr9-rFjA@mail.gmail.com>
X-Gm-Features: AS18NWD1Lpg7GlAiS-hzXaEsjBRNWMYg6zRF_35ecXG3ljPhW1zbNbtCrvT3VfE
Message-ID: <CAJZ5v0gJe3Hy6mWB+chRbvsCM_xjPX+8XpSjGZ1G8eFr9-rFjA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal driver for v6.18-rc1 #2
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, John Madieu <john.madieu.xa@bp.renesas.com>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sun, Sep 28, 2025 at 12:34=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> after an error reported by kbuild test, it appears a file missed when
> importing the RZ/G3E new driver which stayed locally after a conflict
> resolution. This change is on top of the previous tag. Alternatively, if
> you wish to drop the previous PR, I can emit a new PR with this
> offending change fixed, IOW this fix folded with initial patch (which
> sounds cleaner to me BTW).
>
> The following changes since commit 79428e60897916401c9ed326f6ada4d7c7c997=
a3:
>
>    dt-bindings: thermal: qcom-tsens: Document the Glymur temperature
> Sensor (2025-09-26 13:27:44 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.18-rc1-2
>
> for you to fetch changes up to dc67521c20b701b5237ff486ae078829dc1f8fea:
>
>    thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas
> RZ/G3E SoC (2025-09-28 00:19:53 +0200)
>
> ----------------------------------------------------------------
> - Add missing file when importing conflicting change for the Renesas
>    RZ/G3E thermal driver (Daniel Lezcano)
>
> ----------------------------------------------------------------
> John Madieu (1):
>        thermal/drivers/renesas/rzg3e: Fix add thermal driver for the
> Renesas RZ/G3E SoC
>
>   drivers/thermal/renesas/rzg3e_thermal.c | 547
> ++++++++++++++++++++++++++++++++
>   1 file changed, 547 insertions(+)
>   create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

