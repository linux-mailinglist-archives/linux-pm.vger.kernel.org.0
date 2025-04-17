Return-Path: <linux-pm+bounces-25648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE50A921FF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C10188F65D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62A253B48;
	Thu, 17 Apr 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIJh2Ted"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D7152532;
	Thu, 17 Apr 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905201; cv=none; b=Z1Wv3VSEOivHcuVNP6UD1nLyQxvHE6+29ZYc8vaSWSUnF7/MnCNNya6Nj26w3BHmTO0LtxR2FPlnasJR0jNn1ctPYTNSjPRrAV3knUdtWBr3amOeXzcIPDA/PM3TMR0Aqh81pUaYXXYzwl1kTWiWp2V/ef/p/6oDKk5Rh0cB4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905201; c=relaxed/simple;
	bh=mCiSWa4FRS19JBgNJF3GKuG8V8c/xcFPotkD3KvA5gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjOjsvTjp4ZslbmFTyN+InVg9mMhEisH94yxeTu+DrR1EzKgTu4FaSNBx0eVUJp9esL/MwnCdqlzmxvciFGBbCzf0oFxvxNZwkS9itwyWejXH3uQ/1D/x3hXRW3ekwXOGbR5bY8nvuNQsMJJG9DYFRQJO49l5yLnn0V0n1Yf104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIJh2Ted; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CD4C4CEE4;
	Thu, 17 Apr 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744905200;
	bh=mCiSWa4FRS19JBgNJF3GKuG8V8c/xcFPotkD3KvA5gU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JIJh2Ted6W4qdWFMvRxkxO1U933kohBMq4R3WMk7PkaQlnUCGUXrxv8x4yBiWu7ps
	 gIJ77k3paIUfW9Sa0KOv14BlBL++xTEMu7CxNtQtRQ9dxwaFNfN0RsUej8lTgG2UPg
	 OBmYCqML3gL3gO+KVUPqfTr17Z/lTGHbvkgVwbL3B5uH+kI7q0dcjx1FTpvmkzbYI5
	 dvSYi470rVZ/O18Erz5TIUwyl+svmtQ9cBJhUL2XxUVrsnfY2MJHGHC99XMylueNAJ
	 mHJt8eLod3ozEO3m8QLVLyOJauNRLjGXlMMrE1I3p7QmU5WdEqEEc8sRnyh3xKBUt2
	 wrkeNFegU/U7g==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2d0364e9231so248460fac.1;
        Thu, 17 Apr 2025 08:53:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwheXB3YCjxygjI6cAbHwdfuEDXKos3m6XKfTkGQGTu1/LQ1zCeMXrcoSqcUAA9U7D84VN85fTfo4=@vger.kernel.org, AJvYcCWyvYMPnERL/ocXnmzPfolFlfDeC+CQkoKexZmNZghQKngv8baH/Tx+diOBmr1fMe7A5udfHAX7smzy39Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJCZqXp24fGEWmmqMCZjHoBQc40wcM3JrattPq9N1aqxTgpXk
	/uHHXlXq543ULcIbLi0i4JuobtAk1uXgAlVRgIeLwF3KvBodSZxAdbP0IieqS86ngdFmBd17eyo
	pY0StbT7xwk2qHwNl5xqZJ0Q6HPQ=
X-Google-Smtp-Source: AGHT+IHI7B79IyCLJc/Pg8dFEP7qR+d/i2ryOqeJmz0FMEyTprKkzKtPG1UMHs6wq+lw5an401TL1qEjDIcD8HCHmgA=
X-Received: by 2002:a05:6871:aa01:b0:2c2:542b:bce4 with SMTP id
 586e51a60fabf-2d4d29bc7b1mr3795936fac.8.1744905199222; Thu, 17 Apr 2025
 08:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7> <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 17:53:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
X-Gm-Features: ATxdqUGY2B9huaGl3h4ObPEISFW-6FK4ipa5m7uiPShxzhZOBfVsHf7FQfTeY0E
Message-ID: <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 2:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 17, 2025 at 7:09=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro=
.org> wrote:
> >
> > Copying more information from Bugzilla here (Nicholas, it would be
> > faster if you can put all your observations here first, more people
> > are looking at emails than bugzilla).
> >
> > > Nicholas Chin wrote:
> > > I did some more testing and debugging and it seems like when
> > > cpufreq_online() runs after waking the system, policy->boost_enabled
> > > and cpufreq_boost_enabled() are both 0, so the set_boost() at the end
> > > of that function is never run.
> >
> > Right, this is what I wanted to do with the $Subject patch. Don't
> > update boost anymore in suspend/resume
>
> This is going to work for suspend-to-idle, but not necessarily for S3.
>
> BTW, the patch is correct IMV, so I'm not going to drop it, but it
> looks like something more is needed on top of it.

But the changelog isn't because the patch really doesn't address the
issue at hand, which is most likely related to the platform firmware
clearing the "boost disable" bit.

Frankly, I'd rather get back to the state from before commit
2b16c631832d ("cpufreq: ACPI: Remove set_boost in
acpi_cpufreq_cpu_init()") and start over with the knowledge that the
platform firmware may scribble on the MSR before the kernel gets
control back.

On a way back from system suspend the MSR needs to be put back in sync
with the boost settings in the kernel.

