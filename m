Return-Path: <linux-pm+bounces-9204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F083E908FF6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0A4B299D2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3516D9D5;
	Fri, 14 Jun 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZbSbbwx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59316B751;
	Fri, 14 Jun 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381824; cv=none; b=B4D/80xnBci4q6qieBXF9/LcPKMwwUhk+ScPaaHn6JdUXbFUgdhHP2vE+fkc4rUP1j2vSf1o21zhTCs2zrW4SB2+ZSCCIlrjeygKzzjIS+1pNGuNRYYpnmwKp0NlRq96RX9F2dj8xRMZlwVbAb8vkiLI6r7M8v+cj4XlHdzKgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381824; c=relaxed/simple;
	bh=ny18+cFND10LAssQjkN6LB+Uls/v9RXAHugewOw77HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3ZHKA4oq1t+aYBzfUY4r5YTsmB+OoZ3xb65/xJds2RzqYk+jXtL5LbLBSNUlXfeNkQRV3dv63wWKlI/qJkpJawQtIybYReDe0umxp20+DngJzsCAioSgxpUPIQnK3OwqrdkluIlkD/ZtNUOs2IpGO2yRR1WECwZcDhBL/aGc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZbSbbwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747FDC4AF1A;
	Fri, 14 Jun 2024 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381822;
	bh=ny18+cFND10LAssQjkN6LB+Uls/v9RXAHugewOw77HQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cZbSbbwxrZBpXHm9L7dMbQuqdB09lqSMTFGTCY3N/m2E/218Q5uHmh+r+0zhvcxBt
	 92vbnEgXzyGNkJgIDkTPPVWn0XAZvfGpEPiWDhRtYO6JNF3RBbB/a/V2G5oJI8ywv9
	 erg5fKwRST9Qx/iQSEm75aOBEglZwvzTK6UUeX7G+JWMgWsulVVKXpXUFyLQbN0WPJ
	 VO2Ar3rZXfXLpC5wHmYg2la73ki870AhQhReC2bq1iob6RZyPFviakMQF9oFH6CGPc
	 kbT4C9TWT5sKlHDBUInpkSA3SFlOjksM+vaB0JWD/1y8nLxpr0YVdOvJIdIrVJLKtr
	 dvdNezLwauUVw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bb10cfe7daso195959eaf.2;
        Fri, 14 Jun 2024 09:17:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdVoQ2A3YUUreBdypjRnjyoODwVmEcnHvQGKcp/D3zcV39yIeQIYUec9N+5oopbjXsqou0wgc99jS1bu3FDLzyJyar3AbBhNmSFBp92w7BSUAOUq04SSdnNNwEl3U9E5XTtrcXqxlzxoCrlpfyHAQ2/tvI6JrrYOSRrUW2I/y6ekI25unw2qs=
X-Gm-Message-State: AOJu0Yy+llHJZQmjpIg/2DQ+Usk9XIIKz3Y58aT/O2Z9lIRdmH5YVHIR
	2QVhDImtu+LSpOefWJv4mEkMR7RbXeyDMoPNtuvIfj/3rHoAZuUKfjv5lRt24Cb5w1qIeh9qjSY
	aDlVDr0Na3IYIAIO2FKZ2mtmQRkU=
X-Google-Smtp-Source: AGHT+IFApnv1VjvRPVap5sbsncAXBf3AzMgr2psaWlYVdHE/t1gR+HY3GiOqmw98ipb2MoyyMX114Z7+ysX7sg3eYZo=
X-Received: by 2002:a4a:c482:0:b0:5bd:ad72:15d3 with SMTP id
 006d021491bc7-5bdadc0905fmr3345426eaf.1.1718381821764; Fri, 14 Jun 2024
 09:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-md-cpuidle-haltpoll-v1-1-8d649277ca23@quicinc.com>
In-Reply-To: <20240602-md-cpuidle-haltpoll-v1-1-8d649277ca23@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 18:16:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hy9=p6RkN9ywfdg_5ZMFJSC5Tc5ukjNhKGhWAnKjR5uw@mail.gmail.com>
Message-ID: <CAJZ5v0hy9=p6RkN9ywfdg_5ZMFJSC5Tc5ukjNhKGhWAnKjR5uw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: haltpoll: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 12:24=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpuidle/cpuidle=
-haltpoll.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/cpuidle/cpuidle-haltpoll.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle=
-haltpoll.c
> index d8515d5c0853..bcd03e893a0a 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -141,5 +141,6 @@ static void __exit haltpoll_exit(void)
>
>  module_init(haltpoll_init);
>  module_exit(haltpoll_exit);
> +MODULE_DESCRIPTION("cpuidle driver for haltpoll governor");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Marcelo Tosatti <mtosatti@redhat.com>");
>
> ---

Applied as 6.11 material, thanks!

