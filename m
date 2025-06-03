Return-Path: <linux-pm+bounces-28035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE41ACCB52
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F3D188E4AD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C842AC2E0;
	Tue,  3 Jun 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L837ZvdM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEF2C3242;
	Tue,  3 Jun 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968324; cv=none; b=BvkxkRdrz34pLeNRIb+44dzSLy1/VLzYXbWXz47wxjeYaJ2eTRu+GPA8ES7YJ2f/9Vw6s2r0GevYhcs+vCEdwANWFCk4nLtq79fbhmvh3rIfOPjZ6VLdbbUhgeNMmrKrheSOaHkSccxaV9T77zpDs4FSL9hizDDgQrYYPQPfgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968324; c=relaxed/simple;
	bh=dCGhtmVvM/XGvCYNKFnYkZA07C0vcUG9iLEuRQO1qag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4h0THiQWlFiznh+2UYuTQTV7Y2ffIM2ONVSX2Qgm7ypmsQLJTarXu1XkpBH4WkztjKsEBBLFRRALqITJmcz567Bg29yRvUZLVZ4v15PiaphoutwMlZGvBEuFKnjiZPpXrHe2t1NP9mGr9XEeBZeZzl32X50EODCImO9IuT7Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L837ZvdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2006DC4CEF1;
	Tue,  3 Jun 2025 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748968324;
	bh=dCGhtmVvM/XGvCYNKFnYkZA07C0vcUG9iLEuRQO1qag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L837ZvdMIfXmjrkzeEnAa6cXG+FYBM2Zc/QNcRTICqHKZeaxVQvtEXfxpjLHcd1TW
	 CEbHRoD5U3x5WQmgcTrnVaxXTuOumWtNh5COczKPRuQT9lWvQmHN6KGpFnzhIy/gpO
	 7xPyyaKzTa1ZT+LQccMCWELYijrv18K4paAUBm+bL/jRT5QG1F3jUBSCVKt/jHMnqi
	 q0z+EeldS/igDBNVhKExNj51OvH0RYt8kdOW6CV42tRxBpmzpJumMe0HS5yqEyTs+Q
	 Z/u6yEozImn0bLq1qlAkeYa4bqiGL3lfvc5+zDJ/ZKJg1BJv3M/bgjFzzJr/aUccFZ
	 J4eXhxPYLDa6A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-606648c3f9eso1623182eaf.3;
        Tue, 03 Jun 2025 09:32:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeo+RrRY/7MC+HBE/s47pfdNfLrY5WfjaID240ixYemDU53Tb1Wul7sitTmQvMyv2mAA+QzdCYTaBe7DM=@vger.kernel.org, AJvYcCWv0Y2L5unBJ8xyQid0IzCl/NkdvTjHjnlYIM0zNK9YM7ndfPrLjeDjWELT1EsZMqJwsEDvdvUdTCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydWynB1MGZQ2XxGnSp7/SB/VteJbkgG83Zy02CIW/0cA/D6Gx
	gHpNA1LSxaXFtDYW/S6X4qxJe2PQMT+2cijqq7+274/T+U7a4UcL/4DfbafBa5vRi98KUw0zchw
	qY1xRV2f6xrLAaZoih7FRXPYWO8tKHBY=
X-Google-Smtp-Source: AGHT+IFxtxWRK1PfCg4KFwjfObqHs+j5eKqnOu/GrvQDuXc/YfVYBrhfMoTDhrthe6TXwrtVeLYO72tLrsIan25akbs=
X-Received: by 2002:a05:6820:2015:b0:60e:fd0f:cfe3 with SMTP id
 006d021491bc7-60efd0fd09amr2414845eaf.3.1748968323471; Tue, 03 Jun 2025
 09:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6166108.lOV4Wx5bFT@rjwysocki.net> <13779172.uLZWGnKmhe@rjwysocki.net>
 <5572ce41-fc9d-4c62-bb70-a8684f8ba989@amd.com>
In-Reply-To: <5572ce41-fc9d-4c62-bb70-a8684f8ba989@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 18:31:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXnLY8p8ZJKu57PwM8dsAYGmjhQc9tz5UbmL8worveyw@mail.gmail.com>
X-Gm-Features: AX0GCFtT1CXKeVq2C5lmsGWsgrmU35kkqblNc02xNCmjW9fX0sg1tUXindOFH3g
Message-ID: <CAJZ5v0hXnLY8p8ZJKu57PwM8dsAYGmjhQc9tz5UbmL8worveyw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Add locking to dpm_async_resume_children()
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Chris Bainbridge <chris.bainbridge@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:27=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> On 6/3/25 11:21 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 0cbef962ce1f ("PM: sleep: Resume children after resuming the
> > parent") introduced a subtle concurrency issue that may lead to a kerne=
l
> > crash if system suspend is aborted and may also slow down asynchronous
> > device resume otherwise.
> >
> > Namely, the initial list walks in dpm_noirq_resume_devices(),
> > dpm_resume_early(), and dpm_resume() call dpm_clear_async_state() for
> > every device and attepmt to asynchronously resume it if it has no
>
> s/attepmt/attempts/

It is plural, but yes, s/attepmt/attempt/

Will fix when applying, thanks!

