Return-Path: <linux-pm+bounces-40349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB33CFC5A3
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA293086242
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7ED27991E;
	Wed,  7 Jan 2026 07:28:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A927A461
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770895; cv=none; b=gydOJ9y+E0wWes2nIF13avMUa9FPbLSdeUGWCSONXdpc9Xwt4rhVvL6v79iSEaZedSibCU52g6Hn9E9zDUCnq0d7iDBP2RunksnjSwWNSE7Ii89GZQ6D8HpGtgSaRO3C+pUvQAIXqjhIaRQK8GeZQ43I8Q4CuNkQnoeTuCjSuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770895; c=relaxed/simple;
	bh=RfgEuMNL4TUo/qvInpOgHkNAN7w3Ng98TrXjKaBgOIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA2SFM7+I/bj0J6dmNapwHXajYmQH2e9jsRBEN92VQnAwN5VgVNDbKhUz//l8/c09d1KQWXaDniKEPVGzYbbmZBxu5oKBxTL+yrsVtMjxEhnmJtO0VGMjCJRg4SAmCnjwmOh7a5WCPdfivleGqfX2PZ3wf1+T3SwzM7cP5xQH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so1270873a34.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 23:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770892; x=1768375692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eu/A0GfTdEUi+4McTsexKabuBI9bVphLbWuOqGe7DD0=;
        b=Ne0Rlza5AoKo7uiZRSmpauLSEZ92tgZws8L4MaapiO54SqTorkvN1iT+gaYiUsJW0E
         4y/RhFRlT8PUmFDtr4sP1FFMEEgFSAkMGp9SAtv3o7/SUDP6H0Rt3gsmP4PZk/AiBPQW
         bLb5gzpaV8omBHMkdBx9SssxiAHnAsy74L0+dfcFzXGQM/trjUB1MPqHpMefa+oA/Tz/
         P/yQRI9Wv15ZxsEoe7paAhDDasF8SrMkoITA0Of3/VJJsyiH1FXMbEhdkGiIY+rUAxz1
         gYvr/g8TVyOcyANMK2oTO1pnIhqGRrfgdo7n4N+VnmbMvd+E0YxI59YzvhR52nbg+3QJ
         NunQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2R2+38rX483FaFbvJHRRe2jRXN+0BXbU99uzUKUiSNr7N7OVG6v76FGp11vmIpc8TkbcHT9ohhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2PWk9zk9W17N7zmWRn6zA1tQOatZKxf9gXK52AcPItfLByDH
	WmbiDXE7/Q5Dbo6FY7OmUd6iaDLya4utGvkbbpQG1y85j3WRdOqAyidt8QKCog==
X-Gm-Gg: AY/fxX4mwgsqNTNE0dk+/CSUyFgf7aBhILX5Eo2ZM/Tyq78pGOsKZjeEt8gULEFHiqR
	egMFT7ztjCK2Xbk3LU/OX9oVo1sAd0MmGw/Aoy+lgF6Qn8GX2DWdVcUKBLNzGD9iqQAAyvaJlo4
	8QQ/iTbueMxQplf17vtjIA6IRmZxbwLqnXas1zHLybjcvLNxiHIz7AmaRNJg2WPT3hPoGZVCYgF
	Y8kt0K8M92sxGr0ToNsy/smIDxv/oYfmX+XJd0d39CZ3Enszx+PRRClno5tm2lXdhez040NKuWi
	q/DKVKE+2Y5jBdrj4i+rxzzKq652AgCy0qVE8Stdx2GhX7L/MQ/bfpSsPWAe4Ub3+yNcoLJic5P
	mCxOqjDUOKC0J2o1FccLy7UyeEZ8urgOCDBrmUAIo1+PrCkX7mEOfgZsvdxdyvcdQ6fAosEfCWc
	ug655e68uXqsycmU299eFZycS4joeV2Qvt4hLqkGylOtVpANZtJ0KhaLYoR0w33zvxzFZssQIhL
	upfvQpbWfc=
X-Google-Smtp-Source: AGHT+IGZIE5sCd+KsANJAIb+DkQhMIXyzirOZsDAk/0CZu79L+mBgT2JcVLikolQ05h9VLxpbOZcVg==
X-Received: by 2002:a05:6830:2696:b0:748:8b42:77ab with SMTP id 46e09a7af769-7ce506a4c2amr871479a34.0.1767770892155;
        Tue, 06 Jan 2026 23:28:12 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm2866205a34.26.2026.01.06.23.28.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 23:28:11 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c701097a75so946562a34.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 23:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ7cJbbZSmWz8qalEoSZyGcM96YXewAoVKND2TygNwLwQT9kdalHOgnyrddAQ6LGoXGsHR8PKcZg==@vger.kernel.org
X-Received: by 2002:a05:6830:2b07:b0:7c7:59a1:48d5 with SMTP id
 46e09a7af769-7ce5089afafmr879312a34.1.1767770891508; Tue, 06 Jan 2026
 23:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com>
In-Reply-To: <20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 7 Jan 2026 02:27:35 -0500
X-Gmail-Original-Message-ID: <CAEg-Je--qfftNtPgOOU5hsG=6roPeycgSWC+cZkW8EHmLwRx8Q@mail.gmail.com>
X-Gm-Features: AQt7F2qGyZ3wQ07Wyu2P5kUdwfWzPrrW5nKTTTElBM9nakAD7-jOVKbhW0CdPTQ
Message-ID: <CAEg-Je--qfftNtPgOOU5hsG=6roPeycgSWC+cZkW8EHmLwRx8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add Apple Silicon SMC power driver
To: michael.reeves077@gmail.com
Cc: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:56=E2=80=AFAM Michael Reeves via B4 Relay
<devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>
> This series adds a power supply driver for the Apple SMC found on
> Apple Silicon devices. This allows the kernel to report AC status,
> battery charging status, and power metrics, and modify the charging
> behaviour.
>
> The first patch adds the driver itself, and the second patch wires it
> up to the MFD core.
>
> The driver is based on an original out-of-tree implementation by
> Hector Martin. It has been refactored for upstream inclusion,
> including support for newer SMC firmwares, devices without batteries,
> dynamic property detection and improved state management.
>
> Tested on: Apple M3 (MacBook Air, J613)
>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
> Michael Reeves (2):
>       power: supply: Add macsmc-power driver for Apple Silicon
>       mfd: macsmc: Wire up Apple SMC power driver
>
>  MAINTAINERS                         |   1 +
>  drivers/mfd/macsmc.c                |   1 +
>  drivers/power/supply/Kconfig        |  11 +
>  drivers/power/supply/Makefile       |   1 +
>  drivers/power/supply/macsmc-power.c | 872 ++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 886 insertions(+)
> ---
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
> change-id: 20260105-b4-macsmc-power-d017cc7f53ac
>

LGTM, thanks for this work!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

