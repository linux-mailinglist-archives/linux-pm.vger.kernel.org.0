Return-Path: <linux-pm+bounces-19359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC689F42BB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 06:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182CE7A3694
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 05:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF314D70E;
	Tue, 17 Dec 2024 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBmJULm1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24D146A9B
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413201; cv=none; b=mpFYexfWW/3+2XOSk+3LyaQxI2KqO+fkd9MhwIDa+PH+Vgy1uvEwE0EkHZsN1ix4/yM1r8Es9N0/OT9J45IrJmuYbUkYnapoDwtXps6U0jgvxXIrKc6NWpsY+3kNrhkIYstbbI5L2MNzf8WGnoJmVsBtahT2ZO6d7BqzW51C2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413201; c=relaxed/simple;
	bh=UDl+fCY918vruRgK91wANvLDJqtjsROJTFfCQAaLERc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFOzZZR+vAFVCafA0aLmdMcQzICDetnIfUBFbEcl1KtuDgEHdouNQx/fuvclVFD5DvCyBKzy1GnHYQCFU32l/MnnoasJyr/OqQaWLpOJ0M1ghXrWJg6ZIeYcO/7or6PBxzqIoRFwn3H9uH/K8xAVEwQj8auljNnvu/BmUa8R0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBmJULm1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216728b1836so34550775ad.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 21:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734413199; x=1735017999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=nBmJULm1tLzkG1uxbXbxutxajVbluRmU7iYIkFo/C5lg5BM+cvJR2no1IhNidiwMFy
         XKvXzQouEhclPuncns7+fuY+0s2PhXZ1R8Km7fBEAC3rUGi45XfdfOWk3V0dQGZEu/Uc
         9PPcBQxJqu45p6ipvFhW1TWXuXIKQOnnA6r6qTyMSuLFX1rgk5mlqlif7L/K+YcvcN7I
         Nn79gDl6PHAvNS/PCWC1HsulVEk3C7WKvMion3SEPBpGy187rimwF1itEhw5nSvklWNC
         X6XAhpML4AtEaQ4CTi1fTHyVZkvq1p8vN78kzDbnSqYvQJ761/DQ6LqzxXihOIsMde/k
         QYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734413199; x=1735017999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=FmOJ7zBK3CtQoKS9k0q7NpFs14i01NCQTAVwj+AR8ZukSUfgkiUox4IIZSU+AL29lT
         z6/6Wl8J2xoMw8OpRdSYXFlEJeuwWSMi1GMsCHoZYkgmL4f5MUak5Wxlx3ngBwarsgRj
         rhzqgHbS9zYsyQduBTych5KrLJuJp0XMPYZLEOQ+0H7RzeEgyFJaO7rQBSLsWtajIWMS
         zveyKmypiJG4EzuFkpIlfHqQl0xaTlCJ/Aotm145PNzY9jtrednslRE8gsV6/O9wu6Fd
         Ac/sT8BoQ6ZMu8Wdu4HQ1kd3Ss1XpCLEKugafH2oDK2UlM157ot88q1i8rXVMaTc0CWg
         Yx2A==
X-Forwarded-Encrypted: i=1; AJvYcCWGQj5MT+r7OT4rZVA/EiGmBKu8SspBSynwQI8ZBkelFIvZe5chX3zsE3HkrOKv3bceyyWJFQgTJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtR1r/pnCAkWakQpo7b9HyZAbwKbENIrgzjHSJaM1vY/pyANZ7
	0OPOwb4v5rOcp1ZseBJZR/ZWxpmjQgn3faqFBtY2q48xVvho38cGrUh3v5/HDg==
X-Gm-Gg: ASbGncuh5J/d5XVDQUxVKX+xhK0qe7W/DUAM3Jhkg2YHi6/TE2h9QJaBntd/MP3/nWT
	UpqRaq4wJiP5TLR7vHu7Hz0B2wbL1GAEh7SaOO7+tqloVLHZRpupb42wC3+iCxVnSHGuIQZC8fq
	yN+ywNhb57tWH7+9plRm1vGP88zw1kGXiBSjuuM7z5JkAUym4T+vGZVVeq1vmTLDIUmr7RSZm0d
	iGwi0fLA+MqXI9ZeiCNhYY0Y8tJTTs/vZwhjEig7wDMhcld3xy4lsknv5N8LrUckgOq
X-Google-Smtp-Source: AGHT+IFsS3IZ2kuJoYYT9J6yaDIHOOQEb5x9/0WrwBJTXWku1ZLygnZo3QdYaoEU12xrzijDxxrz1Q==
X-Received: by 2002:a17:902:c952:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-21892a785b7mr178520425ad.51.1734413199463;
        Mon, 16 Dec 2024 21:26:39 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm9094176a91.52.2024.12.16.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:26:38 -0800 (PST)
From: manivannan.sadhasivam@linaro.org
X-Google-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, `@thinkpad
Date: Tue, 17 Dec 2024 10:56:32 +0530
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241217052632.lbncjto5xibdkc4c@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>

On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:

[...]

> > There is also a case where some devices like
> > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
> > powered down in order for the SoC to reach its low power state (CX power
> > collapse in Qcom terms). If not, the SoC would continue to draw more power
> > leading to battery draining quickly. This platform is supported in upstream and
> > we keep the PCIe interconnect voted during suspend as the NVMe driver is
> > expecting the device to retain its state during resume. Because of this
> > requirement, this platform is not reaching SoC level low power state with
> > upstream kernel.
> 
> OK, now all of this makes sense and that's why you really want NVMe
> devices to end up in some form of PCI D3 in suspend-to-idle.
> 
> Would D3hot be sufficient for this platform or does it need to be
> D3cold?  If the latter, what exactly is the method by which they are
> put into D3cold?
> 

D3Cold is what preferred. Earlier the controller driver used to transition the
device into D3Cold by sending PME_Turn_Off, turning off refclk, regulators
etc... Now we have a new framework called 'pwrctrl' that handles the
clock/regulators supplied to the device. So both controller and pwrctrl drivers
need to work in a tandem to put the device into D3Cold.

Once the PCIe client driver (NVMe in this case) powers down the device, then
controller/pwrctrl drivers will check the PCIe device state and transition the
device into D3Cold. This is a TODO btw.

But right now there is no generic D3Cold handling available for DT platforms. I
am hoping to fix that too once this NVMe issue is handled.

> > > > > > If the platform is using DT, then there is no entity setting
> > > > > > pm_set_suspend_via_firmware().
> > > > >
> > > > > That's true and so the assumption is that in this case the handling of
> > > > > all devices will always be the same regardless of which flavor of
> > > > > system suspend is chosen by user space.
> > > > >
> > > >
> > > > Right and that's why the above concern is raised.
> > >
> > > And it is still unclear to me what the problem with it is.
> > >
> > > What exactly can go wrong?
> > >
> > > > > > So NVMe will be kept in low power state all the
> > > > > > time (still draining the battery).
> > > > >
> > > > > So what would be the problem with powering it down unconditionally?
> > > > >
> > > >
> > > > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > > > will wear out the NVMe devices if used in Android tablets etc...
> > >
> > > I understand the wear-out concern.
> > >
> > > Is there anything else?
> > >
> >
> > No, that's the only concern.
> 
> OK
> 
> I think we're getting to the bottom of the issue.
> 
> First off, there really is no requirement to avoid putting PCI devices
> into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> platforms, PCIe devices are put into D3(hot or cold) during
> suspend-to-idle and I don't see why this should be any different on
> platforms from any other vendors.
> 
> The NVMe driver is an exception and it avoids D3(hot or cold) during
> suspend-to-idle because of problems with some hardware or platforms.
> It might in principle allow devices to go into D3(hot or cold) during
> suspend-to-idle, so long as it knows that this is going to work.
> 

Slight correction here.

NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
state on its own, not all the time. It has some checks [1] in the suspend path
and if the platform/device passes one of the checks, it will power down the
device.

DT platforms doesn't pass any of the checks, so the NVMe driver always manages
the power state on its own. Unfortunately, the resultant power saving is not
enough, so the vendors (Laptop/Automotive) using DT want NVMe to be powered down
all the time. This is the first problem we are trying to solve.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c#n3448

> However, there is an additional concern that putting an NVMe device
> into D3cold every time during system suspend on Android might cause it
> to wear out more quickly.
> 

Right, this is the second problem.

> Is there anything else?

We also need to consider the fact that the firmware in some platforms doesn't
support S2R. So we cannot take a decision based on S2I/S2R alone.

I think there are atleast a couple of ways to solve above mentioned problems:

1. Go extra mile, take account of all issues/limitations mentioned above and
come up with an API. This API will provide a sane default suspend behavior to
drivers (fixing first problem) and will also allow changing the behavior
dynamically (to fix the second problem where kernel cannot distinguish Android
vs other OS).

2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use of the
existing behavior in the NVMe driver. This would only solve the first problem
though. But would be a good start.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

