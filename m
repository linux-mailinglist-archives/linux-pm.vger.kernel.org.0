Return-Path: <linux-pm+bounces-34214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E3B4A37F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63420173D7B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 07:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E2305974;
	Tue,  9 Sep 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bvNh1g+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3F303A2A
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402950; cv=none; b=qPZtlZcKwbRsopxSYwGWED4x3HUgY7zORDFFZTJxDEA65ai4HP0BRnopztzgqH+RhvlIBh3Rm3eF9ElpVRDvpmTArzN/aPIaJOpdSqMSvVqzIZsoZYxGkzrtROt2qxDbGp/b2fQYrQzSZvkEY0Cj8NyH/gOjt2OxKIHWl7oyVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402950; c=relaxed/simple;
	bh=kERCxz1CPMxNIALKOs69C6lr9f4B92RMxE65sB0O02Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxFbFalhefyswBtteoK3IfNZNq0ihZGSm3QIG62e93RTxDjAK9bMe91r5VmCCldcKsIjooTAazyW8KKdPonSgELt/KqFVmBw35OWRvMi4kud6ChsJPve5Oj93LWWvIevzuTtJU09VnpYI38mfDUsZVEqMdTaKMdMtPI+59GREq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bvNh1g+7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6017004dso5520607e87.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757402947; x=1758007747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GW9/KDzfTAM0j8ChoxUoKCHzLYQFoY43LgESCksmw8=;
        b=bvNh1g+7wRBxASFmt26MTZ/8W5gHGv60cS7M+deO1Yt21U7Ixp5ooxQljxLr9uPV6+
         bILEDreqRwJtdoe2u8T0He8IMm9dMdWxUUjqyFNi0UPDKl7awOVvWKEXNPtldKF26V4y
         VOPPmOI1Tzeh0WvRPVCIIisadqxpDQ48Fj5GismRRO+FJbZ0Wx/gQcgqugqEY164ZH36
         PE5TxTDN52Z/K+lAjoYNQwgclCo/NoJUmykHsQ51CvUyLW17CLrqxtwTnpLjV6kelsho
         jq0R2qMm2ZkrBWUFEBf7kbvrnBb+8BrXhILk0t2PC0OK/upFS68yz2VEuuQK0AsI8MfF
         t/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402947; x=1758007747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GW9/KDzfTAM0j8ChoxUoKCHzLYQFoY43LgESCksmw8=;
        b=BfEf73Eq18QtUmCkC8gyJMJy92OISDnVznBTLkkxa2TeL6MCUvddOU7EPod2/DAFzr
         +lZTkbb8i8ASyHa0A5ypm69ORIxPuVeYzraNR9SD99Vc4Ig1iqD2hENbuYv8rTTD9Wiq
         cuZUgzC3Y7x6e4pN6nJ2Vtozgf1UoGMFK+6a/qggT4rYVOyDxuAi7PNmtk1pozHGFFsU
         sfBg9qDTtHYWt0+/dX3Cl1p5iJDEP42JZb2Zk3b4z6ExoWqmG2YaLsDt/wgieKUJeJ1A
         HCJkf5f8RN+WljUb5yulYvYUKKI+6mQgv5Q+3Ex+zO40HuFAdu1xfwEYvYbLeGUXW1Uq
         4Jnw==
X-Forwarded-Encrypted: i=1; AJvYcCVrjHdVvBay4WUhSCUhUSoBs/3/AscMG63IHoPFEOc/XprU/uhxbZlv/yjoIhwxKnVYkA3k6xXYRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5CRsrIOvpqxI6iBfg43exVnscERo40IPGyLgMjJF7ogVqpnN
	ij40h46T2f4pV9k6ZIpZCzXSVlzMYaPbSKznWg7AHLE6AoudSLxJvtdv1zJEKR6f5pOlKtzI1QY
	IQSsnopkuchkoXGzq2CQoduRu0LcMe54EyqSFCfEIqEsVaRfu/4HDF0I=
X-Gm-Gg: ASbGncsb+dMeKAstZHDOFC22ERbPU5X/QPqd9CaiT+G7nfM+/1A4jhI08WBKIiRbmpg
	lShBTpHnhAv8wlCZYzWgXep7ePuiP5Dkl/wUgHESVIGeDCL76S2I7Aucnjji/x+n3gmJlmrv0M6
	E6ls9ptzXjlXVEMkRU0ysvkFKqcQnyNoapoprOzwrp2uYJ7oJ67e6UMsZ8bhm8vCIaZGGRghWMT
	t0Z1L581SbSzEoY/WxW6A5FPRaTySkrl9+O6Xp/
X-Google-Smtp-Source: AGHT+IEqjgrmt+ZifJsC8dXxSIKNDWKgEEWLxttnQICiP6BTNthulURTjzWWJSjVEjQR2y08Mi3KbU5mWodqpjV6U2s=
X-Received: by 2002:a05:6512:1390:b0:55f:6eed:7805 with SMTP id
 2adb3069b0e04-56261313e4amr2985001e87.2.1757402946529; Tue, 09 Sep 2025
 00:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090641.106297-1-marco.crivellari@suse.com> <175737718425.13878.11571194583527518524.b4-ty@collabora.com>
In-Reply-To: <175737718425.13878.11571194583527518524.b4-ty@collabora.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 09:28:55 +0200
X-Gm-Features: Ac12FXxiOyfxaEVDT_NXlO0DudoWPhmQ3vX57NQ9bBPYwwNRA7GuGVoSn6-SHn0
Message-ID: <CAAofZF4GrebP07QZBMzyjCEyGeL-Z9snNWRs0=S0CwrtAJ6AwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:19=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Applied, thanks!
>
> [1/2] power: supply: replace use of system_wq with system_percpu_wq
>       commit: c4a7748b551e5a06fe9a3862001192b1b5cfe195
> [2/2] power: supply: WQ_PERCPU added to alloc_workqueue users
>       commit: cc2ec444e461b6ca2bc73cd7cbd06aaf15bdfa1a

Thank you!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

