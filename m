Return-Path: <linux-pm+bounces-36964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0005C1477A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 12:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C32A35030E6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60530C373;
	Tue, 28 Oct 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8E2rnym"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16F30BB88
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652168; cv=none; b=nAUk6LTbrg9d/qvPdW+W4ZgYwROs6P5EQ56ng9r3YQchBavNEMDeQYTleqoSFsiAOjNTlO4FQUZr3yRfSrIZr9spWx8URry63yK9B1QWSwALvSgzunCKYiBIiHilbsALHzCHn2UxabN4BZmTdli6vw4BAo2ra76OCzf4n5e5eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652168; c=relaxed/simple;
	bh=yDVNj89esrCye148y3REuDD7mWVsIyFWVwThy4TG/hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puJORfX4xn69vAKUiFTDVWsO9NInsrNKB8S+Fp7h7lrTZgYU/Kn+kMf8VTECTQAVxA9/MrEkbG73L5p0s5+Si3puFPO0GFgDcCp6TgLtZAOeiXhxBm1bRBN6eDqui5SCU19Kcs7b+q6sjsvuFcJY3GjmrgSW9vGan3yO1wb9tTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8E2rnym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4FFC116C6
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652167;
	bh=yDVNj89esrCye148y3REuDD7mWVsIyFWVwThy4TG/hY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W8E2rnymF1yobuKYPcr+HKlY0Q11revo3cBzfe8csd7Vb2AhiRfVwTs7FeFbjhTP1
	 a5YNySFRYxVP3BxjhDMGUmWkm+sPQIgYwtJUdIsOPPNphzIIaa+CM2DrkR6S0LNJwe
	 ie/rqaPEKE7JSoPixjxdayPW3rnVM35ANJDuM2UGAB72E6MBkPE3iatJAskGX/uQ5W
	 9UrZ1TcdYwrbZgl8ZuT1uwidERd9rQTNDGOi7KU2VWAmasjGq9HAkTZHEsxEJaN2jQ
	 1IXg/SWE1P9HFc8h7r3haxA0nR4VF20QcBmGL+hkN0oRoIw2wAQyzBU1PxhQsLG4Zo
	 FknRvuNJMqdZw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65675435ca3so51336eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 04:49:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWshjFxpjeba4p1GiBHXLneqohxZY7x3pkExPUWRZkaiF/UE4dHNkOGrP3hfjbb1Jhp0f8XB7ClSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtI4S320Vtxi+0cvsWJ6+eGqBJpQ1exgqKtoq9wfesQ0pfpkq
	8ll5TvqPDveCIZxDk6nRu8PvE7GIUMf9CQ5uedah5GJMZzH3JVRB7/r7bMiKey53v0lpat7JgSS
	Jewke666JcPoy/2sywuIIj5/KxgFbYsU=
X-Google-Smtp-Source: AGHT+IFcfC28CqkuomWAoJi6nuf1h0zbD4+PngMUC+sEonuSzj6or+Llntw7DvjiJjZXfZ1e6P9eAva5e2hHzKEkGG8=
X-Received: by 2002:a05:6820:199a:b0:654:f6f1:dd07 with SMTP id
 006d021491bc7-6566f212fcamr1465807eaf.4.1761652166952; Tue, 28 Oct 2025
 04:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org> <20251028111730.2261404-1-safinaskar@gmail.com>
In-Reply-To: <20251028111730.2261404-1-safinaskar@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 12:49:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com>
X-Gm-Features: AWmQ_blUWlLQfv4YanZSIOGILp5fEcAmtoabeAfKnegnD857boU4WR3JnhUZKd8
Message-ID: <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: Askar Safin <safinaskar@gmail.com>
Cc: superm1@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, pavel@kernel.org, rafael.j.wysocki@intel.com, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:17=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> "Mario Limonciello (AMD)" <superm1@kernel.org>:
> > commit 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in
> > hibernation_snapshot()") added a restrict GFP mask call that leads to
> > mismatch when using the platform for hibernation.  As part of calling
> > hibernation_platform_enter() the mask will be restricted when calling
> > dpm_suspend_start().
>
> Are you sure this is proper solution?
>
> As well as I understand, pm_restore_gfp_mask will make pm_suspended_stora=
ge
> to return false. And this will enable swapping. Thus it is possible that
> we will write some pages to swap after this pm_restore_gfp_mask call, and=
 thus
> we will damage swap.

What kind of damage are you talking about, specifically?

> Note: I'm not sure that my explanation is correct. Anyway I think you
> should explain in commit message or comment why we will not damage swap
> here.

Well, if you have a specific failing scenario in mind, you need to say
what it is.  Otherwise you are effectively saying something like
"there is a bug in your code, but you need to find it yourself".

