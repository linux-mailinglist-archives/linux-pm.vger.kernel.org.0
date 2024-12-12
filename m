Return-Path: <linux-pm+bounces-19130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98569EE712
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B699D18869B6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC32139C4;
	Thu, 12 Dec 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHjBuNso"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26271714D7
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007796; cv=none; b=D/YtgXzg/dbyPTjYX/BVQHd5TpJ54y4ObwSsjS2zVfpbePWQjpT8PCggaFTNBXCjDTfEwDQkyDcDBqNytYgK4omvjGrrTqVvEOzJxUH1jkeQRDoNfNUFO2QpUqS87g9pX0tM/UxCQiWVLlvFzOpXNfkQYrrhGyXirRHCOIVUBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007796; c=relaxed/simple;
	bh=eBy+40J9UtKTWOrc+kbmI3JcJKbDfZWyj0/5/yur1PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozmaoHGgkMuaVKXl5sehk2OobenBCtHybVsowtGp9jN7PBDrtNJmr4FQz6EER4S46246xw0uEPaMucSi8WlsubBf9pSGiURwdGF4AgAeeywn7RH0lKIeLBDv1xTFHf+H/hca8KyJ0Vde32mCZZmfSVT2uR7x+I8YGgpbCC0m5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHjBuNso; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67ac42819so88780466b.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734007793; x=1734612593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tg5VEq0yJ8noM0Og8YOsf3K6V8JDa3K56E8NocgrDRc=;
        b=OHjBuNsoCMTJciWH7PdiMQGUbBT5loUDJoDvFI1E6SCEAHauAKz8NmEADYLc1kbna0
         sbG/NA/4JLmwil6jFHy5c3ENGKb357CKWJjmNHFBCCNim+eTbZNG5zGYjud+Lf3iaioD
         xEIgCYTSDp3crdqMT7n1lGsxemQeUzLnQ5UvazPiQbL7R2Ah8eyIfsolUieEfyeaoW8R
         5uMzKCTHeb3ZEMWETsYU5KoRQM0ssL8sxmThZokeF2OjihLj7D+wrRqT8fqAH5IHzqMf
         mR2oSPYtJgIoNLqkBhMBP3D43GO5eorvFUbHopMJ6a9x1NEPZzg3NB5men4TMnV0xHuB
         vh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007793; x=1734612593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg5VEq0yJ8noM0Og8YOsf3K6V8JDa3K56E8NocgrDRc=;
        b=B8oSalAF8BVNVgBcDjxK1Xno3YZQZuP8NwnhvNpJ2tw4V8NPGj20ZT3Tlyy5zNqvov
         EJ7KHFL8SwiWAvW6P47E1EAaX9eZGeaieqWnGTP+f/I0+ZQ4q0D0Pbg1ziGL5zt+pM8H
         VN/D4areXUUukIqu10NSolpdtv7a7+3V2w54fFZFgAAuXatIk+ETPt7YwhuXh/PT0Czq
         6GmmoBeFGEb7XLtOIrwBJLlcPkS52fB2ZOBirVRxymQM9XfO1hgndZPQ1Do7Al1mso8A
         Hyu0XPXotrjJHdQ52Yvu0WoTbXY1ao60v89NPwJ9aChMwq9h0q2skDYnl5rSQl65aXez
         DUQA==
X-Forwarded-Encrypted: i=1; AJvYcCVPSSyGe9dSlYjsQDFU/Jce3GK8qZcrrBkjRvFBvxTd7GkKWOwPaSJjqcvKHqVdP1U5l9n0XpqFxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqbmRR95paUTcCf9xlySsmTJrhdq5Io75yxMZZt1Nuw2PSQXa
	hHIxuHBROhGW+W3HxOOkwhLpgCd9dqoYNnbBmaSh+s4OojFglPGlaYcZ3M+c4hF6HCr0fGc/krw
	i+ETrQaDnBirQgMABP5VsteBUGdJ+KlFi7XI7Ow==
X-Gm-Gg: ASbGnctXbBt+zRb2LPzZYX4ow9McwRGRMbpD2ync3Gqv6oDVjhhR5+JHoc+YeYn0hGc
	tyvgUCse0EujvCYj0AmHa4yOY0vXGPhToXRf8XxI=
X-Google-Smtp-Source: AGHT+IGwU3vguTJLME4CwvjxCfurx+pt+saRHptWT2f3PF1VRg0uuyI2iBZN4cjqfO6jUQFDXqhpb7d7eeduiQeZgU0=
X-Received: by 2002:a17:907:90d5:b0:aa6:8781:9909 with SMTP id
 a640c23a62f3a-aa6c1b1cdbbmr336950166b.29.1734007792898; Thu, 12 Dec 2024
 04:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13662231.uLZWGnKmhe@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Dec 2024 13:49:15 +0100
Message-ID: <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Christoph Hellwig <hch@lst.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, December 12, 2024 6:59:20 AM CET Christoph Hellwig wrote:
> > On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > > >
> > > > The istory here is the the NVMe internal power states are significantly
> > > > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > > > creates a lot of extra erase cycles and reduces life time.  It also
> > > > prevents the SSD from performing maintainance operations while the host
> > > > system is idle, which is the perfect time for them.  But the idea of
> > > > putting all periphals into D3 is gaining a lot of ground because it
> > > > makes the platform vendors life a lot simpler at the cost of others.
> > >
> > > No, I disagree with the last comment. When the system goes to low power mode
> > > (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> > > D3Cold to save power.
> >
> > Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
> > supposed to catch.
>
> pm_suspend_via_firmware() is to distinguish different flavors of system
> suspend.

Right. This seems to somewhat work for ACPI types of systems, because
ACPI is controlling the low power state for all the devices. Based on
the requested system wide low power state, ACPI can then decide to
call pm_set_suspend_via_firmware() or not.

Still there is a problem with this for ACPI too.

How does ACPI know whether it's actually a good idea to keep the NVMe
storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
only for S2R and S2disk!?)? Especially when my laptop only supports
s2idle and that's what I will use when I close the lid. In this way,
the NMVe storage will certainly contribute to draining the battery,
especially when I won't be using my laptop for a couple of days.

In my opinion, we need a better approach that is both flexible and
that dynamically adjusts based upon the use case.

[...]

Kind regards
Uffe

