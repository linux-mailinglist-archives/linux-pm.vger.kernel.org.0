Return-Path: <linux-pm+bounces-20656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6077A162A8
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 16:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13067164509
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5691DF97C;
	Sun, 19 Jan 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvH1/fz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9171DF973
	for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300590; cv=none; b=K6phSN8kn+3ibJUMlnLcH/9EmrYjleQRxYzoB6CSEvowPBmVE1hqRGx0Nm4FB6194/Lg89xuBNopaZ59xMrClWTXIywbqPAs9pAAi1Ej8jnm9eBeJIlPsqXI4WJuHE1T/aIixWF2lfzOQgAOXGGiLqjRYpzTKLHsYZUoSVKB1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300590; c=relaxed/simple;
	bh=swaz8J39JWbNjUdvDsHZIZnG7Dgw0RPv7HFdMhQYV/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AesiCiO24r7q36YvcBlqFqpx1zmbCDh6/6q5TsPrXu7Cs6rTSzD8RzypRT57oapKgezss4iGocFKRGfhGyu0XiZdUOEW8ubAiPTOo9cKTEwwda3RESt9QXhMpO7EDidZsZQFBp7al+psqpNWGpTsZFsv3L2fAwwEzt8loCa3bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvH1/fz6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so7395237a91.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737300588; x=1737905388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C/nzl3YeZxFKHcxSAxwA8cJyhGMSaJuP514szE3idkQ=;
        b=wvH1/fz6nksJTRWHjoTjNv+H3IxRiHTDkGHba7dNL3hyRYTxQ1qRpr2D08g2jMxko+
         qRU081iXRsXd6szqbCpqPj5wmE5QB1whuKnBN9zQYwMBskNngZ/wXIE+Lhu3jkxwT73v
         zRM2gnrGDnwsNS//L37IqLIsyRIudznwUaMMMLf91e6WwMSNHJrsNcOo1VROzobgX3Kp
         1GYRWfbla/dMTHCvysgLxwv1htPcoyqPmxmv+n87rgfvUUec5/jMIVJGD7nvi9AJ8giO
         JQDlWol4mAIZpzQQVPkjDauK7LuCSO1AIUYrWrmZ81bw/Pmn/dI3WewN0ybu/vFxgBpe
         Hnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737300588; x=1737905388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/nzl3YeZxFKHcxSAxwA8cJyhGMSaJuP514szE3idkQ=;
        b=KtY+ymHdmS1XCuuIZ6mWs6uNZmySts6N//thNFf4WKeUNDu+AvmLoetvGN0YN/Nu36
         JQ1PrmwZ7DMuZ6l1XSgELAKte/J6EFF0OO4zjK+MoEmEzY3BObt6LAkMfI3jOI7+0yh0
         fwsc6gIHLzwcu8sihVYfO7zWAgxjWClvLKe+ScfdaT6jBTto5e/I71yzUyPI2MFgR+/f
         4pGSZqvPtGU7EDziZRJqvM5cbtMIAokEHqFyf7sqRjJ05xCrU19ddycNwUZZege5dZkB
         RY2JUdZwskvmEB/8yiffRwLt5Th8Cz03gJsiTAIK3er8uAFGH5EyUa1B8FlhGeI4cGRm
         LuQA==
X-Forwarded-Encrypted: i=1; AJvYcCUkMl5gS1k+WCwMPhdO3ypXXOKeKJHlV6lbc36OwYcv0MT+dFNB4+x496kCbFY0/zq2+/UAtR9Jgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzni+qYmJq+HizVu4ihfJ3Elj7R7QXDJtarkDhCbzXOxN/0Bnc6
	Ln/Nq/us/34n/+O2xxUT1vnIM/WwHuV17oJ34GXkzqN9HCp7bUpYRXm2nR4xfg==
X-Gm-Gg: ASbGncu/c6hcqH7op3JgEXfz2UBzW12/mMHASFs4R22hrJu+pGR3Y6kteUD+oy73EdC
	2BmMPsEGtoFTGQ4oH5yBSRdOllFhXo2JFSW7TNSQmnERd666hhndWM/q94LkzpH35Gr0fc9eUd+
	hPJtCuoNCPxy6Cy3qaWxTagmivaBJY9IY/pN73G480wEG0OHwYUwdVE7J/W1xVTkziqAVctzn3S
	qsTpvMYUEXaYd8Mobpdy0OpBknpRALd850aDCI7P1YxfPCWsoyQ4ZXXM4+Ofnz9/buIjG130Zai
	PFZv7A==
X-Google-Smtp-Source: AGHT+IHH9RyAJaMDiBIUlzUSo3FIv4IGvtL2SuNMtfMDQuSucT5oNUrpDoMY714iHbFDGPzis+NQTg==
X-Received: by 2002:a05:6a00:8c0b:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-72d8c4ae2b5mr25269277b3a.5.1737300587656;
        Sun, 19 Jan 2025 07:29:47 -0800 (PST)
Received: from thinkpad ([120.56.195.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9b1esm5463049b3a.99.2025.01.19.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 07:29:47 -0800 (PST)
Date: Sun, 19 Jan 2025 20:59:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, rafael@kernel.org,
	ulf.hansson@linaro.org, Johan Hovold <johan@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250119152940.6yum3xnrvqx2xjme@thinkpad>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114211653.GA487608@bhelgaas>

On Tue, Jan 14, 2025 at 03:16:53PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 13, 2025 at 09:55:49PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wrote:
> > > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > > 
> > > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > > > >>   		pcie_bus_configure_settings(child);
> > > > >>   
> > > > >>   	pci_bus_add_devices(bus);
> > > > >> +
> > > > >> +	/*
> > > > >> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
> > > > >> +	 * before calling pci_host_probe() as pm frameworks expects if the
> > > > >> +	 * parent device supports runtime pm then it needs to enabled before
> > > > >> +	 * child runtime pm.
> > > > >> +	 */
> > > > >> +	pm_runtime_set_active(&bridge->dev);
> > > > >> +	pm_runtime_no_callbacks(&bridge->dev);
> > > > >> +	devm_pm_runtime_enable(&bridge->dev);
> > > > >> +
> > > > >>   	return 0;
> > > > >>   }
> > > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > 
> > > > > I just noticed that this change in 6.13-rc1 is causing the
> > > > > following warning on resume from suspend on machines like the
> > > > > Lenovo ThinkPad X13s:
> > > 
> > > > Can you confirm if you are seeing this issue is seen in the
> > > > boot-up case also. As this part of the code executes only at the
> > > > boot time and will not have effect in resume from suspend.
> > > 
> > > No, I only see it during resume. And enabling runtime PM can (and
> > > in this case, obviously does) impact system suspend as well. 
> > > 
> > > > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> > > 
> > > > I believe this is not causing any functional issues.
> > > 
> > > It still needs to be fixed.
> > > 
> > > > > which may have unpopulated ports (this laptop SKU does not
> > > > > have a modem).
> > > 
> > > > Can you confirm if this warning goes away if there is some
> > > > endpoint connected to it.
> > > 
> > > I don't have anything to connect to the slot in this machine, but
> > > this seems to be the case as I do not see this warning for the
> > > populated slots, nor on the CRD reference design which has a modem
> > > on PCIe4.
> > 
> > Yes, this is only happening for unpopulated slots and the warning
> > shows up only if runtime PM is enabled for both PCI bridge and host
> > bridge. This patch enables the runtime PM for host bridge and if the
> > PCI bridge runtime PM is also enabled (only happens now for
> > ACPI/BIOS based platforms), then the warning shows up only if the
> > PCI bridge was RPM suspended (mostly happens if there was no device
> > connected) during the system wide resume time.
> > 
> > For the sake of reference, PCI host bridge is the parent of PCI
> > bridge.
> > 
> > Looking at where the warning gets triggered (in
> > pm_runtime_enable()), we have the below checks:
> > 
> > dev->power.runtime_status == RPM_SUSPENDED
> > !dev->power.ignore_children
> > atomic_read(&dev->power.child_count) > 0
> > 
> > When pm_runtime_enable() gets called for PCI host bridge:
> > 
> > dev->power.runtime_status = RPM_SUSPENDED
> > dev->power.ignore_children = 0
> > dev->power.child_count = 1
> > 
> > First 2 passes seem legit, but the issue is with the 3rd one. Here,
> > the child_count of 1 means that the PCI host bridge has an 'active'
> > child (which is the PCI bridge). The PCI bridge was supposed to be
> > RPM_SUSPENDED as the resume process should first resume the parent
> > (PCI host bridge). But this is not the case here.
> > 
> > Then looking at where the child_count gets incremented, it leads to
> > pm_runtime_set_active() of device_resume_noirq().
> > pm_runtime_set_active() is only called for a device if
> > dev_pm_skip_suspend() succeeds, which requires
> > DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime
> > suspended.
> > 
> > This criteria matches for PCI bridge. So its status was set to
> > 'RPM_ACTIVE' even though the parent PCI host bridge was still in the
> > RPM_SUSPENDED state. I don't think this is a valid condition as seen
> > from the warning triggered for PCI host bridge when
> > pm_runtime_enable() is called from device_resume_early():
> > 
> > pci0004:00: pcie4: Enabling runtime PM for inactive device with
> > active children
> > 
> > I'm not sure of what the fix is in this case. But removing the
> > DPM_FLAG_SMART_SUSPEND flag from PCI bridge driver (portdrv) makes
> > the warning go away. This indicates that something is wrong with the
> > DPM_FLAG_SMART_SUSPEND flag handling in PM core.
> > 
> > Ulf/Rafael, thoughts?
> 
> What's the plan for this?  Does anybody have a proposal?
> 

TBH, I don't know how to fix this issue in a proper way. I need inputs from
Rafael/Ulf.

> IIUC there is no functional issue, but the new warning must be fixed,
> and it would sure be nice to do it before v6.13.  If there *is* a
> functional problem, we need to consider a revert ASAP.
> 

There is no functional problem that I'm aware of, so revert is not warranted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

