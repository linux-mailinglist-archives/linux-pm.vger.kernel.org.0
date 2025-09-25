Return-Path: <linux-pm+bounces-35395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB7BA08DE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731BF189E469
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528A302CC0;
	Thu, 25 Sep 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag02GAck"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F6301718
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816582; cv=none; b=jSjzFGdX4+kLv9yowSi1B0g2WCAhDB+JfcJbdYQoqohLixTg4UwbJs/NPjN1J++0w+60lDDRZ9bTVtnSlL/ZIqILfxkC2c1CTjRgMiakccDfv7UT+4OMxIKDD7tiOpcbl/Sxki+d8yYNdL67hq/MvhxV52sBzX1Nz3O3jgVET58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816582; c=relaxed/simple;
	bh=zCtcrsuBl16S6I31ougcBsnGSZmcAbLq4ZcusPx0Xeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTbh8IKn2noG+6Ar9sEQVdCTzzkyosVbXsF5RqJDlI+N1EalmLm21Njv7rLanPQgk7TGCG8+ge/iM1UlLFuLWBnNzZgPEIFblGi5l1oiYs0n88h1ppCGN/i0aUJkAyFMFBjigeKIUVASx3KFDbJe63mCSv9zyBLFLcjkurK9zvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag02GAck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D285C4CEF0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758816581;
	bh=zCtcrsuBl16S6I31ougcBsnGSZmcAbLq4ZcusPx0Xeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ag02GAck+0hOcNvSbDD3t98TIPEmB9zcemvUu3MF3Xn0hFSpxFqeXTaWJS8UaBVqC
	 GbLYqkcHmatNfqgQvJTGkTknq9o3a7lXgH7HSGM+mXijnkpCrB/KMjlzy7Rqhc6KmY
	 ojBw6Bto1166wxiDdSAJK9tfVS9aWeYq7Vs7fuQSeXHpOH+16P50qAort6cRDq6BE9
	 7jvQr72q3eRqm/JNVERMO9DtECwgDLuIiKUYrngBDqrog7As5IKXp0yMeSlUsK61ZR
	 a9aVYDthN+k9fa1GafgAsgxUnvjGfBf9JdnX23BHH2ZPcgKN0SoZgMy1tnH1wQwghp
	 0CTdMguB004xA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-35b7f8e07d5so886156fac.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 09:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXKnIfSM9Noqk+Xp1ceW3anfQXtQDFnH2Rvf5UjZZMYQGP8aTjiBKnf69L5SUzR1slkyoy8IukDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwemGPalnFERhI3Y9FTdTaU0MylG64O1UbtYrWpFbdP3AVFyHcZ
	bOGnyQJqiamgfmwD3KHb+/K1IYpO0dbI73oL2G1a7UfJiOf69R8nRXFiUK24neEWtTKg+3dUGOE
	XmmAcdbJvolJnbHRWqVHAz77zoxdyFoQ=
X-Google-Smtp-Source: AGHT+IHIN8UrnaqD8qr1Wudy2wO8Ok5pIJHISD78alYXmBu82HeHN3Q+K0AKGLyQGtDsrtLHErvIfF7DXVHzYb9k5JQ=
X-Received: by 2002:a05:6870:8088:b0:315:663f:4056 with SMTP id
 586e51a60fabf-35ebf3edacfmr2060905fac.4.1758816580840; Thu, 25 Sep 2025
 09:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org>
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 18:09:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6dhHRDABa1+c6=oseAsBU9-vqYybo2i0an=LmY4+yxA@mail.gmail.com>
X-Gm-Features: AS18NWBFNpMqasKWvkag2VlE14u7eP65RD0nD1B9kcV676YZr06x8yTnUy-cq8I
Message-ID: <CAJZ5v0j6dhHRDABa1+c6=oseAsBU9-vqYybo2i0an=LmY4+yxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Samuel Zhang <guoqing.zhang@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
>
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
>
> NOTE: I realize this is super late in the cycle, so sorry about that,

No worries.

> but I debugged it as fast as I could as soon as I heard about it.
> If it needs to push out to the next cycle it is what it is.

Well, it can go into 6.18.

Fortunately, hybrid sleep isn't too popular with Linux users.

> As it touches two subsystems it either needs to go through linux-pm
> or drm.  Patch 3 has an Ack from Alex, this should merge through
> linux-pm.

Sure.

Thanks!

