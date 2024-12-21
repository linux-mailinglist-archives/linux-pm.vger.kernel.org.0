Return-Path: <linux-pm+bounces-19619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B909F9E16
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 04:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6452E7A2DDB
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652271DA10A;
	Sat, 21 Dec 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3vyyt5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6001D9A60
	for <linux-pm@vger.kernel.org>; Sat, 21 Dec 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734752334; cv=none; b=dIip3//XZJ8H6ETe+9g3c77BFj1/m+gwPj1Ef/I135dFBQJLS/JXDVRQhVM8Lw2uSz/kLrug1+P69fSa+kc+hG+c9cR2DkwfRHl8xyHfN7Ihe90rdlRkhYJPxETTWex68ZAmfxtbN/iV5T962QMmM71GwJaMZ0itItqPs3fqTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734752334; c=relaxed/simple;
	bh=XWXSn7hqaC6pRzgibkxudf0GOGehvZFQDIqOefq7l8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2npm77ApgnPEE0YA7UWyI31JScWJlVa1sHk9kGyEgDzplP2WFQtG3s/jGRYTS1yBvUQ2nc+e42qfX+/0hr/sgaS83W23z/S3nI7tVb9GUd1Od0HKlghTYD4XDsz64f/hPSPmj2Momaf81226QAwjT+wsER6E5QpNNNZFsARDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3vyyt5q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-8568fff9b94so933427a12.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734752331; x=1735357131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eJZB6EuvZqCuMAexZlULTbfQVdCZzFPIunIzkh0xi0=;
        b=m3vyyt5qBnFlRBqscTtobxifa0NTmCKlFb5d53fixax1YT52PX5L0ooS27K2V6Wv10
         uvF64kKdv7AbmlqY6sSHEHkToW/cqL0+8FtsgR+284vzRfcb0lH8nWegO2pUFF8cT7yb
         rKrVxzXfYYPURypXO/pjyGhNkADjC3DQ6xioJUuD1UoVMvCWCmBzFeemaxz2QI5a+5QW
         1Hbpz6Hty+qXn1S302HhcPXu810GHxL4TjqsAXBjngkTbcd4tQXxgZ99cPfkjJQXmbiF
         sDIFAK07Zgjji0lgO3RSg2Ir/IHpcLeyA0YXHFNNp4LzryLNyNWaMmTev7Wi7PNeKA1B
         6j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734752331; x=1735357131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eJZB6EuvZqCuMAexZlULTbfQVdCZzFPIunIzkh0xi0=;
        b=oivvn57igJ1gaSYTIvB/6efup9ikhrpCJ08GjNYhVSwDfOR+W0zKl5Yr7piu2zcelf
         1qWz6S0yWT0vBdCaUdqdyQu5H4TpA1qFE2R5vk291boiKiK7z0VzLG23FffuexSJ8t45
         4eUr5A6Z7Wql3L6tFDVXde0b5u5xc0w+x+6115Cse7YHi8c+Oirf1tuYpOdE0ou1tXYk
         bhuzr6BKRIgoOIphZAXomtztASLaGwGGXU3/q7/5XVe42nd3PRmtcnFL+zMp3bNxonEE
         pceDqM31/+avuhT8izTKtPkzHS2W2dheNxlOUTsDiTywxhoIl1Xm0i7I31lilVNIvq4P
         +haQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXPUhRFl1873AOxUGU4voVyzCbLfh5uLG+KMs02MZwF5wJEXXpRH+dlT7Ga7CLMF1jE3HltuSJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7c132uH0c3OdnWvNfUdxgvom8JpFmYvv9MR1V3WHDH+Xh/vl
	q4SLgHx//Naoa/w4rendqct9/VrVWaZ6UgO+OUJca5hv+bqGfjzdsr6GDMGbsg==
X-Gm-Gg: ASbGncv4vnojLAZaijyE1LwfLhX1NHkDh0p2e7yt3WGMiwxaw5XWc7RKxL6jY+3tCFg
	s0sEuyi48WfO/QWnbbHqQ+6Kxn9C8n9KUVxAmtbWGCXBpkKoXe5FS0LsIT0EYYIV0aMqY/j9GWu
	cKdBnZl/uTavBALlJQZNj2gv4qPkKUE5h8ZDBttcylA23umVKKBmrWJw2+Roeo9/4W7b6/sa6MJ
	cU2Msl5mEnaqv69rCmhY6Ej3qAQWHi/ynIdVY+fASp4+sw9thWhBbhMOxqeg9xNKMtv2A==
X-Google-Smtp-Source: AGHT+IEWrzsnN5o2nCkQoIeMPbLZpzrdwvyS5pHYhSf/TqTSVhcon5Hfm88OsFR+tUvtiLTb876Vew==
X-Received: by 2002:a17:90b:534f:b0:2ee:e961:3052 with SMTP id 98e67ed59e1d1-2f452e2fe57mr8120881a91.14.1734752331370;
        Fri, 20 Dec 2024 19:38:51 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882af6sm4486110a91.36.2024.12.20.19.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 19:38:50 -0800 (PST)
Date: Sat, 21 Dec 2024 09:08:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241221033842.6nvmd4clkb3r4roh@thinkpad>
References: <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>

On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> >>> We need a PM core API that tells the device drivers when it is safe to powerdown
> >>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> >>> applicable to other devices as well.
> >>
> >> Maybe I'm misunderstanding things, but I think the important part is
> >> to indicate when a suspend actually MUST put the device into D3.  Because
> >> doing that should always be safe, but not always optimal.
> > 
> > I'm not aware of any cases when a device must be put into D3cold
> > (which I think is what you mean) during system-wide suspend.
> > 
> > Suspend-to-idle on x86 doesn't require this, at least not for
> > correctness.  I don't think any platforms using DT require it either.
> 
> That would be correct.
> 
> The Qualcomm platform (or class of platforms) we're looking at with this
> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> 
> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> state by Linux as of today, and I'm trying really hard to convince some
> folks to let me describe it correctly, with little success so far..
> 

Perhaps you should say 'S2RAM is misrepresented as S2Idle by the firmware as of
today'...

But I'll leave it up to the PSCI folks to decide whether it makes sense to
expose PSCI SYSTEM_SUSPEND through CPU_SUSPEND or not.

For the people in this thread, I'm leaving the link to the PSCI discussion here:
https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com/

> That is the real underlying issue and once/if it's solved, this patch
> will not be necessary.
> 
> > In theory, ACPI S3 or hibernation may request that, but I've never
> > seen it happen in practice.
> > 
> > Suspend-to-idle on x86 may want devices to end up in specific power
> > states in order to be able to switch the entire platform into a deep
> > energy-saving mode, but that's never been D3cold so far.
> 
> In our case the plug is only pulled in S2RAM, otherwise the best we can
> do is just turn off the devices individually to decrease the overall
> power draw
> 

I don't think this is accurate. Qcom FW (the one we are discussing in this
thread) doesn't pull the plug (except on platforms like x13s due to hw
limitation). On ACPI though, the FW *might* pull the plug, so that's why drivers
prepare the devices by powering down them (largely) if pm_suspend_via_firmware()
succeeds. On Qcom platforms, we are trying to allow the SoC to transition to low
power state and that requires relinquishing the resource votes by the drivers.

I still have doubt that pm_set_suspend_via_firmware() applies to Qcom FW or not.
Also the API description doesn't exactly match its usecase.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

