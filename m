Return-Path: <linux-pm+bounces-21021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EBA20DCE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BE13A5253
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873F1D89F1;
	Tue, 28 Jan 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YF9kj04o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F01D63EF
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079920; cv=none; b=T2vQV6AQD8BqU4bbo0C7AHN4AH7V5D22BOEerA9Mrfj8XKVorFLAdH+JqL1A8/BygnhkRq7UzXjCqJ46gQdbq0A48GvNvTBPmi0KCN4X0v7eIixhZlBnBzdz62lcqGKhqI0U44q699G5KydCP6RFHmKOltgKlGq2rq0/ICG1xHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079920; c=relaxed/simple;
	bh=Srh8lUtLEkXdG4xPg2uhg4a8b05w3LmkkVRDJQRRgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWh1pLYRm08SLLCJqFDIYn/2E9NYVdAH2DMzTGrlRH6Z2cZseCuUdZ6AZbtddBXog9+5E7j5s3aO3P0NCoZsYayB990QkLlHUNxDDwT4jOqU8gvW+mF2OCdegjBg/AsGLifGDtJnvYEujlWoYUGk8m7lcWUQU2ldS8qTXDhgYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YF9kj04o; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efb17478adso9973008a91.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738079917; x=1738684717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xNLhGRnep7vLro+KChwCHCUm8fDcca9ttHOfugg3v8Q=;
        b=YF9kj04oPja48oNKvqI0mUPr9ESuPvV6JdLw2e7iAko6ipJtEv6OW3hpg7I5hOCmlI
         gHdiaiTkw/JQOy51ootsDwr3tY3HEbdizwx/xduBRytwvVUzVr19Xy4WokYSq4xWh/zg
         bQpL5Q7mzJ0IjxR0kyTmxftR5NulzPgJ+VJob8oZRqGyrizUds1yf7ZGCjzRpXb1iY6v
         RwDmzq70Ynmt6r1qHUUf9PAOY1v5XuDGvHyNeGjPKoK5rqn3gn5eiy50JMCNznF+lUNW
         lBgUFpcHMMckoWZmunTRclBl66TVEtxLohG1YVGFoRqm6yJQQlSJE+t0G/WXBHSrmRK8
         Auxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738079917; x=1738684717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNLhGRnep7vLro+KChwCHCUm8fDcca9ttHOfugg3v8Q=;
        b=Txw+lTd4MBkgijU5jVAYfKx6SiHV2nEymCCbKjW/uMMLHAR1uFwwSxgGT3/r99VImD
         toHvhnpvkZXxaxZUdrZHoCZtUZrLb59E6oqa3iO3PhDExJy/hKtWq8s6AbmA6v8SWHQF
         a2m69M+aJ3UFDOpaaNQQ7crAmQQEVg7QLo50wnGJnU/1CX9WU/3fFJOLklm8Ny7YiMat
         VlOnlObeNz7POZYmQ7HQMM1uqwfuv0X2DpankSV1fxlJ2rNwMwS2mm+aALp9BS5UE+7M
         WyL6X1HbtMiXpLleCpVJUn8uEuoLtjzFjcYSdePqJ48fTePmYpJyF0fXa42YEyzEgw5w
         sOyA==
X-Forwarded-Encrypted: i=1; AJvYcCXyMW0+a4I1M4e2pGqI6Fy+M+RaqUdBrfNaTVmn5/3U6gJJVulD9HAa2Lg8UyiZ8P0PCE06Nh1zZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypR8+A0875AUUbE5xwSi37vweZqO8qtSyOLZ9mdeXn9keXtI0c
	t8gkLxSv3k972vYFht0i5aDG59ppkKGSF6xbwJIuU2ZILB2buAf6pVarSbBHTQ==
X-Gm-Gg: ASbGncu3kTczB48itZcMx2kXSYzG029jAdbMfYSCR1md+FPuKpybEQAnW3ePutxddpS
	gGq5/8jpYgZOPZDW6OEhUDId0ZmOqvivWLyx6TA40gzW7YktXeAdsASYQ1eTZXw6oxYXoDdEkF+
	j/nvvNz0XJhencpdZlwbBuRpIntnu96d+nOD0TPRqtG0U7pZpgZsBqKSAwZYgqYFq6STMLxb4FZ
	6wn3L4x8nmZYTxRoyZCLW2YmOM/elEuY4aAoSfIiG0eItScWYCopT5Kt+Xw0grDZb6xx9A1+BYr
	nWsdmX2tvH5dflsj/u4LRldJRe4=
X-Google-Smtp-Source: AGHT+IHVW6oqWYPp2EYlm6ElqZSuiQIKXwfjjY4a7z7oVNzIrb0APf3zDh5PkJ5P0rlZLdb2Icjz/w==
X-Received: by 2002:a05:6a00:a883:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-72daf9beb73mr62691146b3a.2.1738079916861;
        Tue, 28 Jan 2025 07:58:36 -0800 (PST)
Received: from thinkpad ([120.60.131.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c75asm9649512b3a.136.2025.01.28.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:58:36 -0800 (PST)
Date: Tue, 28 Jan 2025 21:28:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250128155830.xc6y2swqqw5okt32@thinkpad>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
 <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
 <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com>
 <Z3057yuNjnn0NPqk@hovoldconsulting.com>
 <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <CAPDyKFr=iudHra-AESDW3xM4iNqOD-v8wseBEK0NAHYUH0kE7w@mail.gmail.com>
 <CAJZ5v0h-NrdoAdJ5ZTC1wZhh2BzonSW6ek1ux01-c7L5SLby8A@mail.gmail.com>
 <CAJZ5v0iAa8r9F8MMt7WhbfSRF5MeWnrDRUTeG5HrY5TBHtfZaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iAa8r9F8MMt7WhbfSRF5MeWnrDRUTeG5HrY5TBHtfZaw@mail.gmail.com>

On Tue, Jan 28, 2025 at 12:47:09PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 27, 2025 at 8:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 3:32 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Mon, 13 Jan 2025 at 17:25, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > + Ulf (for the runtime PM related question)
> > > >
> > > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > > > > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > > > >
> > > > > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > > > > > >>                  pcie_bus_configure_settings(child);
> > > > > > >>
> > > > > > >>          pci_bus_add_devices(bus);
> > > > > > >> +
> > > > > > >> +        /*
> > > > > > >> +         * Ensure pm_runtime_enable() is called for the controller drivers,
> > > > > > >> +         * before calling pci_host_probe() as pm frameworks expects if the
> > > > > > >> +         * parent device supports runtime pm then it needs to enabled before
> > > > > > >> +         * child runtime pm.
> > > > > > >> +         */
> > > > > > >> +        pm_runtime_set_active(&bridge->dev);
> > > > > > >> +        pm_runtime_no_callbacks(&bridge->dev);
> > > > > > >> +        devm_pm_runtime_enable(&bridge->dev);
> > > > > > >> +
> > > > > > >>          return 0;
> > > > > > >>   }
> > > > > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > > >
> > > > > > > I just noticed that this change in 6.13-rc1 is causing the following
> > > > > > > warning on resume from suspend on machines like the Lenovo ThinkPad
> > > > > > > X13s:
> > > > >
> > > > > > Can you confirm if you are seeing this issue is seen in the boot-up
> > > > > > case also. As this part of the code executes only at the boot time and
> > > > > > will not have effect in resume from suspend.
> > > > >
> > > > > No, I only see it during resume. And enabling runtime PM can (and in
> > > > > this case, obviously does) impact system suspend as well.
> > > > >
> > > > > > >   pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> > > > >
> > > > > > I believe this is not causing any functional issues.
> > > > >
> > > > > It still needs to be fixed.
> > > > >
> > > > > > > which may have unpopulated ports (this laptop SKU does not have a modem).
> > > > >
> > > > > > Can you confirm if this warning goes away if there is some endpoint
> > > > > > connected to it.
> > > > >
> > > > > I don't have anything to connect to the slot in this machine, but this
> > > > > seems to be the case as I do not see this warning for the populated
> > > > > slots, nor on the CRD reference design which has a modem on PCIe4.
> > > > >
> > > >
> > > > Yes, this is only happening for unpopulated slots and the warning shows up only
> > > > if runtime PM is enabled for both PCI bridge and host bridge. This patch enables
> > > > the runtime PM for host bridge and if the PCI bridge runtime PM is also enabled
> > > > (only happens now for ACPI/BIOS based platforms), then the warning shows up only
> > > > if the PCI bridge was RPM suspended (mostly happens if there was no device
> > > > connected) during the system wide resume time.
> > > >
> > > > For the sake of reference, PCI host bridge is the parent of PCI bridge.
> > > >
> > > > Looking at where the warning gets triggered (in pm_runtime_enable()), we have
> > > > the below checks:
> > > >
> > > > dev->power.runtime_status == RPM_SUSPENDED
> > > > !dev->power.ignore_children
> > > > atomic_read(&dev->power.child_count) > 0
> > > >
> > > > When pm_runtime_enable() gets called for PCI host bridge:
> > > >
> > > > dev->power.runtime_status = RPM_SUSPENDED
> > > > dev->power.ignore_children = 0
> > > > dev->power.child_count = 1
> > > >
> > > > First 2 passes seem legit, but the issue is with the 3rd one. Here, the
> > > > child_count of 1 means that the PCI host bridge has an 'active' child (which is
> > > > the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED as the resume
> > > > process should first resume the parent (PCI host bridge). But this is not the
> > > > case here.
> > > >
> > > > Then looking at where the child_count gets incremented, it leads to
> > > > pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_active() is
> > > > only called for a device if dev_pm_skip_suspend() succeeds, which requires
> > > > DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime suspended.
> > > >
> > > > This criteria matches for PCI bridge. So its status was set to 'RPM_ACTIVE' even
> > > > though the parent PCI host bridge was still in the RPM_SUSPENDED state. I don't
> > > > think this is a valid condition as seen from the warning triggered for PCI host
> > > > bridge when pm_runtime_enable() is called from device_resume_early():
> > > >
> > > > pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> > >
> > > Thanks for the detailed analysis, much appreciated.
> > >
> > > So this seems to boil down to the fact that the PM core calls
> > > pm_runtime_set_active() for a device, when it really should not. If
> > > there is a clever way to avoid that, I think we need Rafael's opinion
> > > on.
> >
> > Actually, not really.
> >
> > The status of the child and the child count of the parent have no
> > meaning until runtime PM is enabled for the parent.  They can be
> > manipulated freely before this happens with no consequences and all
> > will be fine as long as those settings are consistent when runtime PM
> > is enabled for the parent.
> >
> > Now, they aren't consistent at that point because
> > dev_pm_skip_suspend() returns false for the parent as it has
> > DPM_FLAG_SMART_SUSPEND clear.
> >
> > To me, this looks like a coding mistake because all devices that have
> > power.must_resume set should also be set to RPM_ACTIVE before
> > re-enabling runtime PM for them, so the attached patch should work.
> 
> Having reflected on it a bit I think that it's better to avoid
> changing the existing behavior too much, so attached is a new version
> of the patch.
> 
> It is along the same lines as before, but it doesn't go as far as the
> previous version.  Namely, in addition to what the existing code does,
> it will cause the runtime PM status to be set to RPM_ACTIVE for the
> devices whose dependents will have it set which should address the
> problem at hand if I'm not mistaken.
> 
> I'd appreciated giving it a go on a system where the warning is printed.
> 

This patch indeed makes the warning go away and I don't spot any other issues.
So you can add my Tested-by tag while submitting the fix.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks a lot!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

