Return-Path: <linux-pm+bounces-37873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC179C54594
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBCC24FDD59
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414DD293C44;
	Wed, 12 Nov 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JezSlwvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6F1C695
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977252; cv=none; b=MoM+uSa4yoZwJTGgA7AniT14tvqs9YZDniAOZTpvE7Ni67fSYEF2z66bfuOBB1s1dD8gx5kiv4sBgiBKrkIwBh//wJcpp0xMAEcqXGTJFnHC/QEcIA9tuscjjQ07RxwIcgYhajI81O9ruz5jw7s1a+5jEDZI8PZUV9zPiHS0T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977252; c=relaxed/simple;
	bh=5bofe8ZOb4VvTUy3rgqITPh6PxHOQe2EO8GL4iOm3z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8lmtD+Qja5e7Rm1+mj5ItiDirrXkFd1DuupF/j3qnHzaubQyytWCLjvklzFvUF6p4y0oto62h1k48vbK2pSIRha8A5AQe28movmZzSxpquNXABjBpbpYuxEEYjEEr5Xu0JNdtT8xH9U9zsOM89nM1/jcENX677qiqCq7Am8XM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JezSlwvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E5BC116B1
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762977251;
	bh=5bofe8ZOb4VvTUy3rgqITPh6PxHOQe2EO8GL4iOm3z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JezSlwvxLqltWXUdAhI7P7JOveemAl9vw5flfzosUg9jH761Wm3tQSZSlrvO6+BAn
	 QRz3695gJIq+eyvyyXTtpBBlGBpxknnM1JSJsvaLZNRKp+8pQdec7mwT4nCgGmGPkY
	 OImTMyfyL1A+NqJPMMEmm2KhQGxNckHuEPClQvoES0NL7UAupyWE9HbDdsX69i91Uv
	 qouBrH6NeYXPQTU21iIqGSyg9p6oMRK1eNrJiVom2rqLPMn6VO4CAsar8HBgy1i+tW
	 4EpXMQ5g4RLIzE9LfTNiQrrN8WBTao4mdd6IxcY9aS60+Sg3+UzekgwYyVIR61M/vL
	 k5hneN5GJiCPg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-656b1f906e4so49379eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:54:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0cviydbEqWp1wU9ZNp6ekpU+JwVkDQTyZiOEXZfkD3mBzXGA3neysK07iY3MXEbex5IyvDIV9dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0qKoIEyKrm5Z99FZxBgtH2jVPC29WWDhL3EESttZ1pTr5u/A
	VA/pFrQRliH7xxjsdT3cZzMc2pwdxLYJQkjLpMwGUYAgZwFx43Ht2PuxgK3UAJy2XlbhQ0bZPy+
	GFMvhuJtY6gOumksHfSVeNY9VfXYSXSc=
X-Google-Smtp-Source: AGHT+IEVJSROAFckCy8D41FmqFJJW5EYYy0PCDk6s51ryKib/uPfn5q9gya0sOFEA/O4rvAbR6ADyqOGzZfH00T+ZKM=
X-Received: by 2002:a05:6808:181e:b0:450:4e08:a210 with SMTP id
 5614622812f47-45074656cacmr1672093b6e.53.1762977250896; Wed, 12 Nov 2025
 11:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f175ca74-78f9-4210-8185-ada8091e95a5@kernel.org>
In-Reply-To: <f175ca74-78f9-4210-8185-ada8091e95a5@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 20:53:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hrHPV1FADc6Usy=oETJDFTUWo0Xxi48mbiUjFHCRDvMQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk8ePmWrLIyZ2HMPRmSUpeRHsV7R-e7y-vmswAqfJO6zBnlhRKIhUQo6_w
Message-ID: <CAJZ5v0hrHPV1FADc6Usy=oETJDFTUWo0Xxi48mbiUjFHCRDvMQ@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.19 (11/10/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 11, 2025 at 6:40=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> Hello,
>
> The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a=
7c:
>
>    Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.19-2025-11-10
>
> for you to fetch changes up to bb31fef0d03ed17d587b40e3458786be408fb9df:
>
>    cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs
> (2025-11-10 23:35:20 -0600)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.19 (11/10/25)
>
> * optimizations for parameter array handling
> * fix for mode changes with offline CPUs
>
> ----------------------------------------------------------------
> Gautham R. Shenoy (1):
>        cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs
>
> Mario Limonciello (AMD) (6):
>        cpufreq/amd-pstate: Use sysfs_match_string() for epp
>        cpufreq/amd-pstate: Drop NULL value from amd_pstate_mode_string
>        cpufreq/amd-pstate: Make amd_pstate_get_mode_string() never
> return NULL
>        cpufreq/amd-pstate: Adjust return values in
> amd_pstate_update_status()
>        cpufreq/amd-pstate: Fix some whitespace issues
>        cpufreq/amd-pstate: Add static asserts for EPP indices
>
>   drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!

