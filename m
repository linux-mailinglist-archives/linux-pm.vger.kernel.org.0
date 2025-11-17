Return-Path: <linux-pm+bounces-38135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32331C655AB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 18:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B04E364681
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EC2FD685;
	Mon, 17 Nov 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG9k1vQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F98259CAF
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398759; cv=none; b=Yzfm0pqKzH7KoUojP5LRKQ3NxS58r8a+EVez01SoqOQHigw5rmIjSBJyQG9LhyMzxz2d/FYMKIS9kCUURLLh0RP/ZksYvIz3iMC0kyt4czMpOBO1QAp8THDM1HIx3rz6CilReluCMispi7CGG6P7WGotPuHTCkYEAuw+GbAqcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398759; c=relaxed/simple;
	bh=93mX6LyrU7FKGKCqSID9rnxmcqCKQzIrwXS58F3/iKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5YPsYfear2lyGyuzzwnva3Y2Cr99pEmEvlE4egK/8CLwtsVNYw+YRBNyRLxyDXLOmNPjoABoQNTTbIbILNRspPoGUpxZiLfHJfL81fzJXyvotNVaQSRLqF3er93HQt8a4kP0CFfn8/IvCmDPnoyxHhgsiN9as7DX+JqFcAkDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG9k1vQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C3FC2BC86
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398759;
	bh=93mX6LyrU7FKGKCqSID9rnxmcqCKQzIrwXS58F3/iKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uG9k1vQUIYIj8NkEmso89WrQBdqbgKNiCh5SeIJYlPX4hhznnX8Pzq3m3D4Aw4OYQ
	 CbFCtg1BcMPItsU/ZtaGXHoVhjPi0Oh7Kjvkc+XagoDRsA6gYd9khvcFssAXRCTnM5
	 CkrlGG63LU+JZz80F/d9mDSTRL/Lt/6/Uf4bEFR7HZZK8UVQpU0yxVu9sxE7S43JRU
	 YIrNob892VlQXT3N4+a7gc+ytC6Y/m0HaGKbS34AxsfVOmH1lDL5hp5hs2Y43SF4Zc
	 HgVac/MNBXU5ysA5stdJUj55M6+n2MDz5MQKqjsVzJsnXUpDm6RrpBEkro6gUIHPaJ
	 BqukkF6h1SsHA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-450b3f60c31so543214b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 08:59:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVS093u3Vn0t+gOdcNigAFeQ/O+M9+ammk7EahBcekQvFuR+r+ED9+86pszlE667aWMXBWhIGTKPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oPhcnR5GBwLgqJ5MEfZdj4o6V+7H1tIJrlk3m0c5vodUlh06
	cTLs3sk6a1BJQQFXCJ7jUPI4SANmBs1JNZwnMuIpU2xFgIRUFwsYiiK7waaiBjx80d74brtQMQ0
	d0RVlc4qaDDuhgDdcM69Ate91CCchZVo=
X-Google-Smtp-Source: AGHT+IFL1ZDv2aBeByiSLgu1dLbV/+NXA+IU5Odv2Kcv77dZO2WOhf8PlVCYvXe9ErsFtBmVhEY8IKFtMBzG6acJspc=
X-Received: by 2002:a05:6808:8911:20b0:450:ba5b:a471 with SMTP id
 5614622812f47-450ba5baa89mr2571306b6e.47.1763398758551; Mon, 17 Nov 2025
 08:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
In-Reply-To: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Nov 2025 17:59:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjQgoa8eRyQ-MVQW=FeOEVQP6YTsY7o49LV2wnO=xEDw@mail.gmail.com>
X-Gm-Features: AWmQ_bm0qe2w4NDBvcR9JB5pAEyOB0erZKyK2rHvLR2DAk7RlbIToMk8KF_iISk
Message-ID: <CAJZ5v0jjQgoa8eRyQ-MVQW=FeOEVQP6YTsY7o49LV2wnO=xEDw@mail.gmail.com>
Subject: Re: [REGRESSION] PM / sleep: Unbalanced suspend/resume on late abort
 causes data abort
To: Rose Wu <ya-jou.wu@mediatek.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev, saravanak@google.com, len.brown@intel.com, 
	pavel@kernel.org, linux-kernel@vger.kernel.org, 
	wsd_upstream <wsd_upstream@mediatek.com>, linux-mediatek@lists.infradead.org, 
	=?UTF-8?B?5aOr6aGPIOmCsQ==?= <artis.chiu@mediatek.com>, 
	=?UTF-8?B?6Z2W5pm6IOmrmA==?= <Johnny-cc.Kao@mediatek.com>
Content-Type: multipart/mixed; boundary="00000000000099f13d0643cd4473"

--00000000000099f13d0643cd4473
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 17, 2025 at 10:31=E2=80=AFAM Rose Wu <ya-jou.wu@mediatek.com> w=
rote:
>
> Hi Rafael and All,
>
> I am reporting a regression introduced by the commit
> 443046d1ad66607f324c604b9fbdf11266fa8aad (PM: sleep: Make suspend of
> devices more asynchronous), which can lead to a kernel panic (data
> abort) if a late suspend aborts.
> The commit modifies list handling during suspend. When a device suspend
> aborts at the "late" stage, `dpm_suspended_list` is spliced into
> `dpm_late_early_list`.
> This creates an imbalance. Devices on this list that had not yet
> executed `pm_runtime_disable()` in `device_suspend_late()` are now
> incorrectly subjected to `pm_runtime_enable()` during the subsequent
> `device_resume_early()` sequence.

Ah, obviously.

Does the attached patch (that should apply on top of 6.18-rc6) help?

If this patch doesn't apply to your kernel, making an analogous change
to it should be straightforward enough.

--00000000000099f13d0643cd4473
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-fix-early-resume.patch"
Content-Disposition: attachment; filename="pm-sleep-fix-early-resume.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mi3dy7800>
X-Attachment-Id: f_mi3dy7800

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIv
bWFpbi5jCisrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMKQEAgLTk0MSwxMSArOTQxLDEx
IEBAIFJ1bjoKIAogU2tpcDoKIAlkZXYtPnBvd2VyLmlzX2xhdGVfc3VzcGVuZGVkID0gZmFsc2U7
CisJcG1fcnVudGltZV9lbmFibGUoZGV2KTsKIAogT3V0OgogCVRSQUNFX1JFU1VNRShlcnJvcik7
CiAKLQlwbV9ydW50aW1lX2VuYWJsZShkZXYpOwogCWNvbXBsZXRlX2FsbCgmZGV2LT5wb3dlci5j
b21wbGV0aW9uKTsKIAogCWlmIChlcnJvcikgewo=
--00000000000099f13d0643cd4473--

