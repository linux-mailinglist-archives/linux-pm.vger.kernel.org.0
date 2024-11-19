Return-Path: <linux-pm+bounces-17794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6149D2FCA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 21:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD730B29F7E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDC1D2F76;
	Tue, 19 Nov 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb2nWuuF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0E1D07BB
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049505; cv=none; b=CfM+tqyhC39mde0nkpK1TjKqM80zVY0a+JlBS2ZpkMQ4G0lhFZK2zYMbPnCZ+Io4OkGanFZgP7JtpNZIOz7rwQTRB9sjI/2rz88wrmZRq76L/QZ3fBQBcCBJ0IL+HilgFJ9yvEMzW9mJhexJba240nYO1b/wNDPTghKaHT5/T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049505; c=relaxed/simple;
	bh=C6XsjefZdNL6JJVaSVGoEaTMXQEAzg1RvI4sNIKFS00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj+vp1Hh041ougAQmZenqw7h1f3jBO2RHgbaiRfLWuQLhGq03vwpcmm6c8s3EUuJVQUh0iuSRP2Y5dQ/e77OZBJzGYVhiUkaHANTJKDRs71cD4SdJUTQxtmnyivylJidUXEGmTqOZpTVWAxnEWC9LWksmCEKT7s2O2bvujo0TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb2nWuuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49358C4CECF
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732049505;
	bh=C6XsjefZdNL6JJVaSVGoEaTMXQEAzg1RvI4sNIKFS00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pb2nWuuFT7/rwo5oGd8qqH7KEGjfI61RhMnpZ3KPx8d3quIJ9R4MqteFG6jHmYSnm
	 4GvVTYvLoDKKYWRtLAY7kN+LolkGVFUGJX0eeR7wdCF7BL0k4dNmHDfn2RYKOCJ7sv
	 wWASeN5VF7iK86rOhNWyhamWe/PHMc7IpAIcydKa0yxp3wqUM1W6jfHFsrsGuhmffB
	 EcwYXO2ufGBS3PHZr+FKmIkw3lGXujwWCNbOMOZdNZ4EgxOaOBB1qQ4AyV3IsJrVhC
	 oNcDs9l0d+U+4w3hxyk61yNAe6M7CDQ8B+m/bwZ27XoU68+2TMGIfvIpT6fsQKr7E9
	 Rt200S1N+l7xw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29687cd1924so1392644fac.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 12:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW33IXT6GWgmRTcvuiJUMSW9Uq2c7WF7crWquIw9JRWo0SEdRi8vbnOz1yLqho2qatyQFmuA9jIGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlqNBn5efhYB6a7wi5c906x0EQeKgBlsI5Z+KRohtGCKv3+JW
	ecsiKo6k0g7ggiH3FZnCZ+udgaMp0Bp+JW4r7RDRbdPx/CC96ZeyYuhyZ1nrnaWJnl7+FxX4mgY
	usUL6/mhZECGvotCNNF19DDMmF/Q=
X-Google-Smtp-Source: AGHT+IGegsDElfmNAxS8EhKXyE2rVKMTYVllW8Wc1N2wBiyxdkCDQ46UPCiQKsM+MpnpsxrAC5nulwCCQjUfGndG08k=
X-Received: by 2002:a05:6871:5285:b0:296:8309:6a50 with SMTP id
 586e51a60fabf-296d9f144efmr319797fac.41.1732049504638; Tue, 19 Nov 2024
 12:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118043707.zxyo5wl765dxypkm@vireshk-i7>
In-Reply-To: <20241118043707.zxyo5wl765dxypkm@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 21:51:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hBMdTHcPBYqo0_ffQcy6Zkusu3g7WPoDNNgJBz1w0PHw@mail.gmail.com>
Message-ID: <CAJZ5v0hBMdTHcPBYqo0_ffQcy6Zkusu3g7WPoDNNgJBz1w0PHw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.13
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Nov 18, 2024 at 5:37=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.13
>
> for you to fetch changes up to 53205a7903666d35709954d9fb7370a8150d5e0e:
>
>   dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw=
 (2024-10-01 14:57:08 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.13
>
> - Describe opp-supported-hw property for ti-cpu (Dhruva Gole).
>
> - Remove unused declarations in header file (Zhang Zekun).
>
> ----------------------------------------------------------------
> Dhruva Gole (1):
>       dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supporte=
d-hw
>
> Zhang Zekun (1):
>       OPP: Remove unused declarations in header file
>
>  Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | =
20 +++++++++++++++++++-
>  drivers/opp/opp.h                                                     | =
 2 --
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

