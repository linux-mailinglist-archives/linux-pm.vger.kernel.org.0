Return-Path: <linux-pm+bounces-19766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E119FCBD2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC601624A4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CDC84D3E;
	Thu, 26 Dec 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yb2va+Lm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CB23DE
	for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230145; cv=none; b=DHxCiKYTWE4pHeHjKLOo2py1BqlzsLGzVddeDfLkTKgwz9KHgD9qqh8oSD0/iDH9FRUxvjQ6WlDPLMec7qWdhDUC53+G3MdiXFqhdyXbvyrUKH8Y4DjEWqyRaGkxp577ggGyMeCwiNQJQgRWbD5Gp1OrNCBTRRq8YZ4woZ8UAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230145; c=relaxed/simple;
	bh=DEucWZKqke6YmICCHoXk1QBMjOFMLzmD29afDJ18eoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBtiI9d6Rk4ygoXfOOdK0NLkc9S8zldb+G8wvs/Hb8StXnv6nRysM6TClMfE6e7HpIqVjSMTClIHye/k847JZ53uWE5NA5DqKKteLx9s4fQKCFQYHx4a24kmBY8ucdaRqafLvp814QDs2SVfqL5vti0AI0lXINuhhfzLm2I0Anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yb2va+Lm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2167141dfa1so74298145ad.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735230143; x=1735834943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm1OGexTUahbG35IAioexR2EqAbbh3BE3Y6REOnezMM=;
        b=Yb2va+LmZObLBeP+T82RzjBQHw1xdMD9Ju4ALSof+UMVJbUHjHskBq8inhMpezdMst
         zy/L+YoT/ZCRH5oh//wsXArqlayoeGo5Dykcd8VY9EsZjAvSDJuc8qbQTEQP2Jp6xvdQ
         8sdxLgc5laUlfvCvTLGJZczwGruldb1SVwfyWR9Kv8guISo26kLSJmsUrQHhUFrK20eI
         LSIaaeMwWJ21hXhNTM3xP4OopZfBJbRwGaG6+lqGUg/Z5/p1EGF34l3JLBEjloxnUg81
         5JYu74TBVx7fa6yBk9u72llllUGofIJlAYuDea5IG29tfBC6T4WdG6SVbXuw27cldDce
         2Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735230143; x=1735834943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm1OGexTUahbG35IAioexR2EqAbbh3BE3Y6REOnezMM=;
        b=p0PWjPKM9uZWh+MiKqBhVHk408dqGDiGUPe28Q6uvOWvpal/NWhi0IzpV47cwjaGD6
         x1aSe8mf1eylajBiIfGcfDrWfKEFmVLPeIEYDDHCqxs+z9AdPoQCjXbII2IVrlp35gpX
         PP1wrFNOQPJGTqj1EYm3sO9DirCL2YamtgJNiYRE/gtMqQQQHb5PRaxNMnCbn7yr1k/7
         IubBG3M03X8SmaeX/uF5LbJcUijwAfHmY7OHXjFEIN5lO/VTD17fDe7m6VEhghIEznPt
         5v4dqgEBEgFPBwR3X7YOZr+h3n+d0FRbKlwKr+Euwh9BMQyWmN2YivvpV6C+hfNgHHOu
         tW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQIJkIHJLczSP7agJiUkrRFHFn3J8nSzP/+whQ1ZJxBSiKIK/3rdh6HxjQv7v0syK2unZBqBhBOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMLslhAuawozm1Z4o7s0tnIO7rqxAG7cZeDiz2C7ZJol6XhhK
	OKOSYxCwfSWQsuRLa/OzOtJT5aiuan53DA+DcDkBZSQLd4yajJl9V+Tmvi51ig==
X-Gm-Gg: ASbGnctLuqJlejRFgJeEaPWPKhU/cY7z+UTFQxIOTZ7e0dtYAnKQqWGE/qiCQHMpS+Z
	Id5dHF3wKLjZGSAJjxlfy0dwTyk+Hzb3K56VL6JmcELLA/aFUQGxG+zFs07cgDtOV8ONiacIS9N
	ZfMS2aTqK4vQquNUhnCaaUn1U1V5tBSjyubZk860LNJNYVahn18jo/uoHHr3Fmgh/rP+JC2NSXc
	3KNO0d02Cnj0WIM+oO+YUUylbBIPIc5Ws9QFasayEMDXPfBdWILE/fAsuCeH3sm9H8=
X-Google-Smtp-Source: AGHT+IHvoBuGe08qo2yEvL2GcLwase7T5VuaXPLzhbgmwOzxg/Nr7C9/tE4B78BHn6KoWJtSaarh9Q==
X-Received: by 2002:a17:902:f648:b0:216:84f0:e33c with SMTP id d9443c01a7336-219da7ef985mr427820475ad.20.1735230143189;
        Thu, 26 Dec 2024 08:22:23 -0800 (PST)
Received: from thinkpad ([120.56.206.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm118912905ad.124.2024.12.26.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 08:22:22 -0800 (PST)
Date: Thu, 26 Dec 2024 21:52:15 +0530
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
Message-ID: <20241226162215.vnhidukzkzfhuwt2@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
 <20241221033842.6nvmd4clkb3r4roh@thinkpad>
 <a514f047-d56e-40a1-ad36-b655cc8cddb7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a514f047-d56e-40a1-ad36-b655cc8cddb7@oss.qualcomm.com>

On Sat, Dec 21, 2024 at 12:17:02PM +0100, Konrad Dybcio wrote:
> On 21.12.2024 4:38 AM, Manivannan Sadhasivam wrote:
> > On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> >> On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> >>>>> We need a PM core API that tells the device drivers when it is safe to powerdown
> >>>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> >>>>> applicable to other devices as well.
> >>>>
> >>>> Maybe I'm misunderstanding things, but I think the important part is
> >>>> to indicate when a suspend actually MUST put the device into D3.  Because
> >>>> doing that should always be safe, but not always optimal.
> >>>
> >>> I'm not aware of any cases when a device must be put into D3cold
> >>> (which I think is what you mean) during system-wide suspend.
> >>>
> >>> Suspend-to-idle on x86 doesn't require this, at least not for
> >>> correctness.  I don't think any platforms using DT require it either.
> >>
> >> That would be correct.
> >>
> >> The Qualcomm platform (or class of platforms) we're looking at with this
> >> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> >>
> >> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> >> state by Linux as of today, and I'm trying really hard to convince some
> >> folks to let me describe it correctly, with little success so far..
> >>
> > 
> > Perhaps you should say 'S2RAM is misrepresented as S2Idle by the firmware as of
> > today'...
> > 
> > But I'll leave it up to the PSCI folks to decide whether it makes sense to
> > expose PSCI SYSTEM_SUSPEND through CPU_SUSPEND or not.
> 
> The firmware happily performs the actions required to put the platform
> in S2RAM, but the interface used to request entry (CPU_SUSPEND) is
> mostly used for entering CPU/cluster idle states on arm64.
> 
> (although the PSCI spec also clearly states that using CPU_SUSPEND for
> system-level low power states is allowed *plus* the reference
> implementation literally just calls CPU_SUSPEND internally whenever
> the """proper""" SYSTEM_SUSPEND call is used, anyway)
> 

Ok, sounds fair.

> > 
> > For the people in this thread, I'm leaving the link to the PSCI discussion here:
> > https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com/
> > 
> >> That is the real underlying issue and once/if it's solved, this patch
> >> will not be necessary.
> >>
> >>> In theory, ACPI S3 or hibernation may request that, but I've never
> >>> seen it happen in practice.
> >>>
> >>> Suspend-to-idle on x86 may want devices to end up in specific power
> >>> states in order to be able to switch the entire platform into a deep
> >>> energy-saving mode, but that's never been D3cold so far.
> >>
> >> In our case the plug is only pulled in S2RAM, otherwise the best we can
> >> do is just turn off the devices individually to decrease the overall
> >> power draw
> >>
> > 
> > I don't think this is accurate. Qcom FW (the one we are discussing in this
> > thread) doesn't pull the plug (except on platforms like x13s due to hw
> > limitation). On ACPI though, the FW *might* pull the plug, so that's why drivers
> > prepare the devices by powering down them (largely) if pm_suspend_via_firmware()
> > succeeds. On Qcom platforms, we are trying to allow the SoC to transition to low
> > power state and that requires relinquishing the resource votes by the drivers.
> 
> Look, I have a power measurement device before my eyes and I clearly see
> the main power rail being cut on successful S2RAM entry.
> 

You seem to have misunderstood what I said. I do *know* the power state of the
SoC when it enters the CX power collapse state. What I said was in the case of
ACPI, it powers down the peripherals in S3 without any SW dependency (except for
wakeup capable devices). But in Qcom case, each driver has to relinquish the
vote for the SoC to enter CX collapse state. But anyhow, the difference doesn't
matter much here as all drivers need to drop the vote except in wakeup path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

