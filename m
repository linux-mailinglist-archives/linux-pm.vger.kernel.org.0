Return-Path: <linux-pm+bounces-26661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCCAA99A9
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E87A20D3
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093DB26AA88;
	Mon,  5 May 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUJEhyGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E825E476
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463708; cv=none; b=HuHrFT7m6pkBBc4GgR1V2+LKnT3PD2efCDgPcmXjGk/rvcq2yndxvqpbKitKFPFKTkuHN33hEdOgJ1j2efAaOHvEZ2J4prl7rpf4COq5tKpvLI2/j+zDWbjVxpCrzzIqT/UxOtTeK+C1Pf3Osj9moOsFXqdJ+KvPLwRC9R1e9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463708; c=relaxed/simple;
	bh=d/w1uLpQ2W4vbRq5UhqvNe4JuFB6ZDEyYHk1OIfpEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtjpaNjdeyMVc8JXw5Uzcdtc7GoVhhSF1E7CUqiJLPGVS3adPSGvP/O6TROfgeeOP1WYLBGrgWvzMgGJ81frzkhQ3Pj5SHhIEeQWp2zITc1CEdSdQcK0zSf4ppwX8oUSHiObwG1hKUt5rob+v0vZhg65589OQGnyXOSoXgtlxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUJEhyGQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6672072b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746463706; x=1747068506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=NUJEhyGQBBoePJ8nFckLgad904tYAh3yKDPsPTjUVd7f+2IG/RTgFLpWf01/Lu2sSk
         OvC5dDjpFceIvjDNgSA31UgRinUaTWl74wdX/Ig/KvvYnADX0jdruzMKVDSFvCjt0e90
         UNv4LGj4zzL+glt3gycV/6xZm8uckjhkNc/+jP1vDbzNnQpgwnH8VTXOfweT/RjFqxFq
         9iCy6IwDcRJbMOQOzRgySHr7GpseVsvcJWfQhB8wkbam3RNEVqQRX+CuYb1fZGdSDC2S
         ZMGraRdSW7WvX4AJfETAY1Q5E2vErRqZZnPILThE29oSZJ0bt1C1SLpnLI5e510qQkIx
         VYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463706; x=1747068506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=mDWrO4FX4F3umr4K9FaC23TG98PwxCOm5mmyPXznDUUw9XxiqIVkulUkxvMW2j4OGp
         YvGvlz8ksZJSfkZMleOBQpqEWADl0eHgnPC2gJqtpPlUd2kb0Y4A8RN4joieyZg0t3kT
         b89n+fdX6f9M3h479wIEP3T36VR8+JaQE1V529PAP4YuA86To7DwetdBxPHgjwaDezvX
         Vci55V5KW4ZGkSqIxMgyuHDB6yDrk1V0UD88dtENor9IE2d8OS8WiuRel9VXsbat2C7n
         83XCbBGKDXJcWZsl06fbEjSukXE9JtgAiLDJChP2u9DvE4r8ClX9ndYhLk+TEL1VZLuG
         baOg==
X-Forwarded-Encrypted: i=1; AJvYcCWjY9385bkvenWc+jC9HPe37jfvAfGS8ZE6e+0zRiuCporpJMwdhwqQ5t9jqjCkko4nxBryPcg7AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoanV2gcn7MmK5QWLBQ55670QcrAizsFTplkJfG4geHqj70Y2
	c0SVBh744T4eqX3EiUuxt9GmMpMYJsFMWIppoZ+HwaqPDPHAFn3Anjsj924t5A==
X-Gm-Gg: ASbGncuS0vedxow6blfKV5zHjYlGtuWV4/lX7OY/jZCRkcdiVt+9B80PFgsuSDivU+U
	4SZAh9bCRx+EiaQNeg2bhE/O5HeN32AF1wvSYpQdQyrkx1XnRRrazZDQr5uVYC6vmNYHJgU/G3h
	zpBwp0y3paQGfgpoQR1gY/cKJFFe0vYiKy/Q6l4ovdNUCAiwoQcb1e1qSMh4kwOL8bdj7Mg/NgK
	8mbcBkhKqyZf3pkApSrCozcQLrewrHQIX0TNqjI8+vOpG6omQmfmZfQ5QWNXlbaX2mDKwxuJKb+
	09+O1x/KtCCsZjUpFfEGZmIcPLAo8V/LovqA7Ag6VQyNiobapUM=
X-Google-Smtp-Source: AGHT+IF0IGm6fDHGPK66O6bg5JTvgXJJb1FD4//3SnxAo7KjM8JdSqs+9ux0Ap+T+I2E+83jN9O/IA==
X-Received: by 2002:a05:6a00:4408:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-7406f0d5d84mr11288854b3a.14.1746463706657;
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590616ffsm7268130b3a.140.2025.05.05.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Date: Mon, 5 May 2025 22:18:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Message-ID: <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
 <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
 <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>

On Mon, May 05, 2025 at 11:43:26AM -0500, Aaron Kling wrote:
> On Mon, May 5, 2025 at 11:32 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Debugfs cleanup is moved to a new shutdown callback to ensure the
> > > debugfs nodes are properly cleaned up on shutdown and reboot.
> > >
> >
> > Both are separate changes. You should remove the .remove() callback in the
> > previous patch itself and add .shutdown() callback in this patch.
> >
> > And the shutdown callback should quiesce the device by putting it in L2/L3 state
> > and turn off the supplies. It is not intended to perform resource cleanup.
> 
> Then where would resource cleanup go?
> 

.remove(), but it is not useful here since the driver is not getting removed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

