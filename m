Return-Path: <linux-pm+bounces-26982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73152AB2399
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 13:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EFA4C3C5E
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5C2517AC;
	Sat, 10 May 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkUMG1wZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04112747B;
	Sat, 10 May 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746876882; cv=none; b=aacNL5KMx4XJLknOxO6THrssqQBojKE7AP77VWwxpPhmbVnezo3JHMCi1xkV+jTCPOcL5j+hhcHj3d0jIDa/qnYA3Hk+/sinezuPlPr2H9UiJyOB9t+RFkkPI3Rd/KAUr0EIdnzT2i1uAfqKBudhtnoUbxuOR4qdQ1o9LQPhnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746876882; c=relaxed/simple;
	bh=3RnXBrsNa1A8cED8xc4043L3jgzABt/e43mY9r7DUKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duE9Q47ylZBSl2hYoOI8qg2KFsucGyc8CqAI46ojZDHdUViU2UP/GNc9rEET+52XbrsGHGkHtxWBZt2rDzr2LlyiR1Ie628aRAgMqOv+3uSpEHm6eDgTy1bSuTYcLobL3j2GrAi+8SG7S81WnlfWOIW0i50Dp5Dg2PIp4NkFOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkUMG1wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E274C4CEE2;
	Sat, 10 May 2025 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746876882;
	bh=3RnXBrsNa1A8cED8xc4043L3jgzABt/e43mY9r7DUKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fkUMG1wZpt/z+NcuG8Psrtf1nq84gjpk+eTNyfXBDHoxiUZF9fsazTVS2XUrzohne
	 WwcRwV2Fm3m/zXJigQLuGNHQTLNh8fPVOi8AE0yK1NpqywUpNzdufHNvsrncf3dM/0
	 TNgqBkaPeJEgyeCCkQKKO6A1Gg7eoydh3QVjOVgPorsC18SZmb4GkupviW+jt8dud4
	 6wo+mVGtU4L7vtndBE9AxazZZCq307WsdKxuseBsnJ7GDp7J1OO+6f/8XESd5hbxM4
	 X46gVRWgosho0d60/1p4EOjvlEQY3TBe8DSSog6LZ0e4lE3EC2ADnvwO28uwmYGZQg
	 9hWcx0V0Q0hBg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6049acb776bso1540626eaf.3;
        Sat, 10 May 2025 04:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxHBQdoMxwi1OW7/QRlmjZGqBSP6WL6d+7t8q9uUdiQeKFeVBkJzjOca+80kkMtPubC1wDCCfexEpruMY=@vger.kernel.org, AJvYcCXgo3HOCTI7a42wZDf7/q48bap2wU/JxfLl8HLauXJz1kau+kGzTjbVWTL/YMrub4fPkf0xbwzO6iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZvBFBggpAKyNXnmg3K9NkXVVIvisa5AWSn2Q+clrrgVctIOE
	cviABBkiG2WJpQs8AOclYMVldsWo2cLMFwwOcSPZ0ey7zywGoySBilMcAG5+8DiboMy+tTmf8kF
	fM++IKzu+7SwoXXzqNDDNX+xfhE4=
X-Google-Smtp-Source: AGHT+IHiaYaNxPEG5x9qS1TcCXVMrm1U4xcjiEMuwkrhgMm6V03aQcRi+llHNKS3Qj8kUNpQu9Wlbtrqb+dSRV7vNEc=
X-Received: by 2002:a05:6820:290d:b0:604:2ac:840a with SMTP id
 006d021491bc7-6084b65db60mr4405044eaf.6.1746876881530; Sat, 10 May 2025
 04:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507014728.6094-1-changwoo@igalia.com> <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
 <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com> <90834b07-9261-4be6-a10b-88d3f5308e1e@igalia.com>
In-Reply-To: <90834b07-9261-4be6-a10b-88d3f5308e1e@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 10 May 2025 13:34:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jiAHHLP2O_0ZkXPPCXq9tFTxqrap1mFXOJtKuBo-gJfw@mail.gmail.com>
X-Gm-Features: AX0GCFujpc9Jkq34AEJK1g44px5pYPpSUkjGLW55pVAtnZk598CfrHQxhPfFPAM
Message-ID: <CAJZ5v0jiAHHLP2O_0ZkXPPCXq9tFTxqrap1mFXOJtKuBo-gJfw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is updated.
To: Changwoo Min <changwoo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, christian.loehle@arm.com, 
	tj@kernel.org, pavel@kernel.org, kernel-dev@igalia.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 7:07=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Thank you, Rafael, for the pointer.
>
> On 5/10/25 01:41, Rafael J. Wysocki wrote:
> >>
> >> I have discussed that with Rafael and we have similar view.
> >> The EM debugfs is not the right interface for this purpose.
> >>
> >> A better design and mechanism for your purpose would be the netlink
> >> notification. It is present in the kernel in thermal framework
> >> and e.g. is used by Intel HFI
> >> - drivers/thermal/intel/intel_hfi.c
> >> - drivers/thermal/thermal_netlink.c
> >> It's able to send to the user space the information from FW about
> >> the CPUs' efficiency changes, which is similar to this EM modification=
.
> >
> > In addition, after this patch
> >
> > https://lore.kernel.org/linux-pm/3637203.iIbC2pHGDl@rjwysocki.net/
> >
> > which is about to get into linux-next, em_dev_update_perf_domain()
> > will not be the only place where the Energy Model can be updated.
>
> I am curious about whether the energy mode is likely to be updated more
> often with this change. How often the energy model is likely to be
> updated is the factor to be considered for the interface and the model
> to post-processing the eneergy model (in the BPF schedulers).

It really is hard to say precisely because eventually this will depend
on the platform firmware.  Hopefully, this is not going to happen too
often, but if the thermal envelope of the platform is tight, for
instance, it may not be the case.

