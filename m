Return-Path: <linux-pm+bounces-40398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2A7CFFF38
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE8483024882
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEB329C60;
	Wed,  7 Jan 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duoBhplj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D668322A24
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816575; cv=none; b=H3t/K/1HoWoD55dPCnW+kRq+5czVPgUSWjsjzBWcxhIAlWkJ/c1HV8MQ7m06Qd/VsxkAuOIbTm7HwNPxla9UT0qDOkT7CHOVjfiFJ8p/TZUkjNX5xB1oSAGOzkjZmV8JKQSDaNXvBdKoHqqJEo99fNmjfnxaqFLXHj3R6vz0O8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816575; c=relaxed/simple;
	bh=7AipdsGTChHqifqf+Tag+GZrYvgQ3I6INwRaVW7rqGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+rDrAEzSSfFCp72y8UU7pikgWPnWZo6TiriEBh75qUQKQgiWAJwwi0Li6CwFPD1oBHzF5krPwBOKDc5IL0Pike+oCbvqa5LAOLs6f3Pb0EJ0mmq+3E14EpryDCBIvaXMcLdx+P27HtwBnuWC/w3AqQnfq+zUVev/C9FwoR6LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duoBhplj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D802DC4AF09
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767816574;
	bh=7AipdsGTChHqifqf+Tag+GZrYvgQ3I6INwRaVW7rqGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=duoBhpljsl02WcYdNJzZV/SdPsqEYgpqHz4K3PLDCGFTQ08Bz/plQgzjQSoBy6+cc
	 r+Vbp64Cz71IsWmkRdbEaf02Gm12YZcfVH9UllDtU2u+EnZE1dbb+x/3J4oj0HPpqR
	 Ck6bOP2i5uoCxCn1CpJ93LGAOhBZUj99CebF6oY5P2cMegDZFiDWJ/oE7u1ic8k6vk
	 CXN4/X9vl4tcmuZohGTtZptBDkHYsQMTb9J3HD49L00I9KJ/MowV+HyBBadi6qR6Ve
	 yNX6HIWtCv3usiuQCi+vio3iMNZGte+eCmQam0vd3AQNP5pG+sqNc5+hIEsYeaHZht
	 +kZUQgausAwvA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65e94e128beso694813eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9AFtE0WNCNIUTVyIT5gf0KG0fmsM72xCo3k66ctfngSRyex6j/iB/I54xU2U4OaPMTniSUKRKpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztMUloyqGxFUfaGcLThw/H8wy1T8ldLZQibInjBJMojmA/BE+g
	FZRlScIl1xubiqY04HDNqVWj/Q2uqZQ59IuSGxMBcIfGg4TjUnXsy8K7WKLZg0fyguBhHsIm0AH
	3K90SuFJ/AGzctKdtMtePqDzuMIa5DeE=
X-Google-Smtp-Source: AGHT+IGLF/44+oYDibcAHRBAtWyS1RwKCNHfj4yhtEaLLSEXGdjwWvvoubkxnnj7WvvRoetkgpmFIU2TTQr8H76ippU=
X-Received: by 2002:a05:6820:2284:b0:659:9a49:8ef3 with SMTP id
 006d021491bc7-65f546cf91emr1322339eaf.39.1767816573954; Wed, 07 Jan 2026
 12:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091352.1250531-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251215091352.1250531-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:09:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g9TEBQMsW-dSqvM9dkqQRX=-aGr1f-WrBZQXzmo_pDOg@mail.gmail.com>
X-Gm-Features: AQt7F2rDjk-dJU_6Ez1GV9SmYlPyFmzdFs4S3jHTVlyoWGNjUURv2mGg3LQUeoc
Message-ID: <CAJZ5v0g9TEBQMsW-dSqvM9dkqQRX=-aGr1f-WrBZQXzmo_pDOg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_pch: Drop explicit pci_set_drvdata(NULL)
 in remove
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:16=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> The driver uses devm_kzalloc() for device allocation, making the
> pci_set_drvdata(pdev, NULL) call in the remove path unnecessary.
> The driver core clears drvdata automatically during device removal.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/=
intel/intel_pch_thermal.c
> index fc326985796c..52e71af67dc6 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -269,7 +269,6 @@ static void intel_pch_thermal_remove(struct pci_dev *=
pdev)
>
>         thermal_zone_device_unregister(ptd->tzd);
>         iounmap(ptd->hw_base);
> -       pci_set_drvdata(pdev, NULL);
>         pci_release_regions(pdev);
>         pci_disable_device(pdev);
>  }
> --

Applied as 6.20 material, thanks!

