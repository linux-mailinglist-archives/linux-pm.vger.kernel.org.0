Return-Path: <linux-pm+bounces-22417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDEA3BDB8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13B51883F81
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30B1D8DFE;
	Wed, 19 Feb 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsbuVFy6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4D1C3C1D
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966495; cv=none; b=STqMudWvgL/MJ7UTHUzgoID+pSIqzFdgQ+GaZYxrWNbqnevJ/GOpZ7E1MAYHIB3P61of0tmW0x4xCyAzIB9EZd5RVbHGBlWQxH/UT4CNHpRwhx9jy8M0SJWYmsSeRN6Vif3peSuDa8iKV8TSlHMysHrTFlyb9IYGzsjQYapxFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966495; c=relaxed/simple;
	bh=vYTsDpF0WHouv71tUdRGcb6sg816+d86Mu3TaaGSsBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkzl7f2KZGHUm3hmWnWZF1YxbyhOl5yELiiFIJaR/CmEhrfJOHWuFyBSrkM6X+8usMe8wCmzigs8LXXfXCTduz5q1oviQaxkh0IiIoW+63lzQBHnFDrkGOcM3NX595P68D/9NCcT80EOGUBv7wVXSFzEbE7jMG8FWgULzfF0vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsbuVFy6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fbaf4cf2b5so2587107b3.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966493; x=1740571293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYTsDpF0WHouv71tUdRGcb6sg816+d86Mu3TaaGSsBI=;
        b=dsbuVFy6ANEuyhYCaCNh0Copr+ObjkP3BMbv7C/LT9peU1nMO/cML+x5ZYdW29n3cR
         g6LFhNav60noAsMTceRc277owoZXVgwwD4BuwppvAfWhdeQ73pAB+N3GILdCdlfN8nEh
         OPQs53aF003Xzc/s4gWaIkvgLtGzL3tQ1uC3uiFcNgiRoo12shUhUGFLmkYGGVbM2EeJ
         OpV2meWLM9QhzoD6mzNN2aL0j5DsVou0kgXQVGRdncbSS/su7DqAlfEAsT31UzcJtVfR
         sKEcrGi6OECVrrmi6GOu9Yfaodaf+oxVwnVfpwnLaHyB3QYvq0utwHJlZ8zkkU/6YPDY
         daDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966493; x=1740571293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYTsDpF0WHouv71tUdRGcb6sg816+d86Mu3TaaGSsBI=;
        b=SjRnjVnPQ80uCOQW3McyDVCln6+sDD8SPO1dw9S3JwbNbUgnwxvWJBAUEHuUDr2x2M
         S1nSKcHLGa6i2b87NZ9i656jb24QM3ZSG149IEcHLvvf4HQMEZTCGQhRZQ9/3thSrdpP
         I4GmqBRhKKTBFOjTakNYFvZyWrBijlRGo7usYHtLs2sK0Jdwp71qofKZYsAtYuuYypKQ
         lZsZRSD5QVvbRR/nxaMlKEMWFu9tqL/uhwpz2x43PdleLeHNjO7kkMroehzGp6ASLRTB
         I+Qtqh95Lkbji/XBefQ6pvwYCymH/jo5E24DbJtWnk9oKiZSrFG7cIW2O1mRKyVyQMRY
         3A3w==
X-Forwarded-Encrypted: i=1; AJvYcCUmnP8l4GmP4Cb+fb1PCmCDlwF1lV91ZgbZDyReya1EWiVDmfhajC59HRi5Ce5j8POMhaTHhqOLSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7hk/vR7BIrDQwxvASIv+ZkvGS60oBcmOk0zosxrnBa1azAop
	ZNtc5ikxJI42FZUyiESk4zAnIbEZUIo1xgdyIDP/p0rCL4pDJ7uXR+9RBeUFPvraFwSmb+9KNkw
	TCObLkNSYneRjQuBvvLX1CWTfgPO3xYJ9bxpjEoQNJpOxiZVHzQA=
X-Gm-Gg: ASbGnctAIIB6hln+gL2EIylcIm74J01bU2deva+Bv+bQQ5xwgT2WhrSqZtX4W3hgpfF
	3OjVLOxFYEjF+cC8trvB97lVo1FMMVINVC1IJsaTwSYvrDKfo7fl/MGvMMC6+QoM1M9Yi6h5LOQ
	==
X-Google-Smtp-Source: AGHT+IHwtF2lE+o2tf7V8rxyFVuVJraHT+N4by5azk0Xzf2f0imq0Hfnj6hm9T1/3s7AUPcxCy9jdh/GuEmHhudS/Fs=
X-Received: by 2002:a05:690c:6d10:b0:6fb:a4e6:7d52 with SMTP id
 00721157ae682-6fba4e682f4mr35370547b3.35.1739966493107; Wed, 19 Feb 2025
 04:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140145.117086-1-ulf.hansson@linaro.org> <Z7SRpEE0UFHdSEmR@bogus>
In-Reply-To: <Z7SRpEE0UFHdSEmR@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Feb 2025 13:00:56 +0100
X-Gm-Features: AWEUYZkRptIu8JuTeXLBSwgNPQUIMYEr8XMgdltcJUsEkVs_mX89-B_EamjzG64
Message-ID: <CAPDyKFrcBZCYjcrxPMuMrk+3yqa-2N4Q-qCPu-qmmQ-a6DfL_A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 14:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Feb 17, 2025 at 03:01:45PM +0100, Ulf Hansson wrote:
> > Add myself as a co-maintainer for the cpuidle-psci driver and the
> > corresponding git-tree, which I am already using for this.
> >
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks - and queued up for next!

Kind regards
Uffe

