Return-Path: <linux-pm+bounces-32918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6527DB322EA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9254E0185
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9F2BD030;
	Fri, 22 Aug 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9QCK/iq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C714A1A;
	Fri, 22 Aug 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891330; cv=none; b=s5rozllDYCsCUDzi6EdcDiH5h733ZGEpJLvKmUTCnvPqJ/jPuv6fgX6EjRO0xq0qwsxUtURoUimYWiyZX9PQPeE68aJxxIG4qmckIHIo3Vike5CDIGXqrHB3xL+o6kAD0L651GsJY/nDvoC2XBC42sXGlUY2FCp9MYbyLlp1ubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891330; c=relaxed/simple;
	bh=NK4aDjEdoQofFBTnviCGY0YNYAajc015ADjdfnmAOWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMC7mZ6Wu4aXaLIEdjWWOSw40wHIVT8y4aCyWuRC/AdJk/ZeYwz0bs8BfkRUfDAELzgIADONzqxYTAooZnPcpc6GWGf4QGBIM89pjMcOjZRUjebMDIedfvRFZctWPprM9+K5ZYMIDnjyp6DWBYMpN47Je+uuvN6H8S2PitPw8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9QCK/iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE8C4CEED;
	Fri, 22 Aug 2025 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755891330;
	bh=NK4aDjEdoQofFBTnviCGY0YNYAajc015ADjdfnmAOWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i9QCK/iqJ5j6+WS25T22c0bO7+AUtvwC90C/ZEf1Drg5mQF8Uj/MjMlgXWy4B5oda
	 5DxkOeLiZJDsiH8Tww/xdmX2DnDVyEIg21MUvF141JX0lE/R4UDkx7M+ryMIceQtLC
	 dgionaSakExnsVq5Nx16X23Gcp4Yu+MEySzdkzrSWFe39tOb6eJgGt+sHrF2n3gQNc
	 iA3v2doZ7uPQn3EMLiP58oqieJyHqTnnYkAqLNrCBtpp2Xod3LML9DXCA+MJAbjTqc
	 eQGBIQG4bRLSZDgSkV0qhZfWUeFybhKKfxyZJL6ISjqzvOEG8LiJoZg5phx8KuueCz
	 +UsMX902QDD1A==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61d9c53be51so1161396eaf.3;
        Fri, 22 Aug 2025 12:35:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3Qh/hWU/OBoMG2v6QYTJmnrO/M+PCBrVoFUJIPxST4ay4H2Ek8pVxjJ99XPifEJ6u+e92Zs8yLlOA8Hc=@vger.kernel.org, AJvYcCWjeO7Rnla4RpHZ3pyIzXWXs+1M9MRa5gSvsGjGFsyHmQCXxfXTJdohzI4BVqZi7hxdHyWMiRG0Y3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwmanLRO5+b7nMrtOAGXX7a3opiEhF3j2nQoEtseqPqNjwGD5
	lTMhTmXdZf+EAHI2OCIY71kMCFGH4HcuX+crn57VQv+tlNf7YPPWy8xpXAXh2loaFuwu3FpTael
	rA9pMxr0bKAT8e6jEhbbLQUDwwTdBrfA=
X-Google-Smtp-Source: AGHT+IF4grwxxtqtbouV79GF1fyUVE/CH40ZE2fPAfqDepUAPy3JvFdapTEGH8s0sro+DUgIqRzGGt6toq1fwI6Ellg=
X-Received: by 2002:a05:6870:24a4:b0:2f4:da72:56a4 with SMTP id
 586e51a60fabf-314dcb9ff05mr1851926fac.1.1755891329445; Fri, 22 Aug 2025
 12:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 21:35:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0js9NekQTw+xNxw3CNSU-mbM4Jr4Ycsc++jbsYUHSggwQ@mail.gmail.com>
X-Gm-Features: Ac12FXwNJB4TtlPABTsaitPbduCo0Cn1fcZ2Gc9NzDrRNF_E9Dw2oAixgd8hkto
Message-ID: <CAJZ5v0js9NekQTw+xNxw3CNSU-mbM4Jr4Ycsc++jbsYUHSggwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpufreq: Cleanups and minor fixes
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 9:04=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> This series contains two small cpufreq cleanups:
>
>   1) Use strlen() as the length argument for strncasecmp() in
>      cpufreq_parse_policy(). This makes comparison more permissive
>      (prefix match), which is consistent with the intention in our
>      deployment and improves readability over using CPUFREQ_NAME_LEN.
>
>   2) The second patch is new in this version. It simplifies the validatio=
n
>      logic in cpufreq_register_driver().This makes the registration code
>      more straightforward without changing functionality.
>
> Changes since v2:
>     - Fix code suggested by Viresh Kumar
>
> Changes since v1:
>         - Dropped the second patch from v1, which was not needed.
>         - Kept the first patch as-is (already Acked).
>         - Added a new second patch to simplify driver registration checks
>
> Zihuan Zhang (2):
>   cpufreq: use strlen() for governor name comparison
>   cpufreq: simplify setpolicy/target check in driver verification
>
>  drivers/cpufreq/cpufreq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> --

Both patches applied as 6.18 material, thanks!

