Return-Path: <linux-pm+bounces-29025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F7ADFAF7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD393B8A3E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3E1A5B9E;
	Thu, 19 Jun 2025 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Aa8KVzM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CE12D758
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297419; cv=none; b=Q6EX7tWnsXyroy3CTOS5H8xRXw1QDzCwH1fTgTqlu1+EK96HOxEjPdmCFiOKIOlElTNPUSgSLMD+Bl2NoitVLsmvrZDGM2srkQ43juPDVpydxyeHUI4a2doZSrbwCf7ZuFYucmGcigC418LtxM57uQ5GeIpUwiPMrJO7xFNvprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297419; c=relaxed/simple;
	bh=dLjiGbT9JPWGVFlw+MuDObZxogfa330xuB5+6m+uoVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnuniPs9WgR/NOj92fkVO0Pz7tkRdri84301wz/0h75I/4eZWG8lJlSxPzDntu9QVTYa/EzwVFdmhI8zD3Oq/b6UKEvpfTWUEORdOMIdHz80GTzHg7HbQgwhb/g68pCnp4+9Kcm3vvo+DtloO0XHQ3B3wCnVeWOgyynCFH8Ayiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=Aa8KVzM6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748e63d4b05so123673b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1750297417; x=1750902217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RBzLiRa5kP007xKu/khAw6xLYgVFKSnX02dITEELMQ=;
        b=Aa8KVzM6GHceqv3r1o2xB6qGuOFlRsFM/KwnrmcjPvfeGVYy6f9BWEeS5GStj6Cx6q
         wcSz2x9+9KUsXwPr2TSIcQCOubBQiEUMbD4gQhMKldxfvZyU9601jQfi6FuKnCeBcrot
         Bvehey7MAOHyp5RXqHuPOdxveNobC6hHslUYTmADU1r2s1j+wJrPfHLlAfjjlBjJUQ6u
         rpuXcbGWAd+6o5MJKcvf0NDiFr/hxKgmFcWnbYO2ehktiLTX54p75HwXj65crUGdej77
         uvOyZIzLTPKp4DAsCa2Tj9LpkejskolFXcV+rbM/GJkuRcZjMpqtqof6c040HVbHZZ+P
         Padw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750297417; x=1750902217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RBzLiRa5kP007xKu/khAw6xLYgVFKSnX02dITEELMQ=;
        b=OqDrsRyFkhw3341mQIPwzKCPZR5b9MeLt/k9EgFS5Sg9X9bakSnhay1fyOeSznJtgk
         2f32mU6pUiXsAvVyQ60jTOo4RAzCAbVWSSrI+Ol/vAFJpp2Pmv+JZ166oIOrvmokeWM5
         LVPcJXVRb+ucJPo88GZkIlXBpiME4YwWIoydGogBqtHRb10dMsfPwMcIcuh6GUzhOyl9
         fIPB84vCp6jTWq263n7alFu0w/oxIo9TqNJSgFjfNnctv85mThHbSkTxlT6D6ln+CtOY
         VDnmAlU07du0sNU0S5MSFo2zoV16kbe7WEvpkxzlYoJx1u8fPjoiB7Qz5EBCxc0objzC
         I56A==
X-Forwarded-Encrypted: i=1; AJvYcCVVEK7axcK3dw/TQnDH+LKl3VvwngNZ8aNlWiomLk3aVdrAjui2Y8Mhe+acBAWVnJgq95CN4ojH5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAwy2I17w7vnATbaVjd83iGSihrPrLUkH1wxeqV7VLwtyf9OH
	qoTbvsJBAea6d8TthcghFV9achmiBkypz9fb3HnzvfoOw2CKrBnr5MqcsKNqDJZLoGM=
X-Gm-Gg: ASbGnctqOBoI70wgMcrY1MWNuHMC93I5XJb+1Sx7xMhPN3azWHxVZ19ISo9n2Hq/oBx
	tF9npoujIi2ymlBEMRxy5S7QmMYESfs+RDxlNukYSpz7vmabjvT4RC3XCgoKX5cSe/caJhwMpjE
	jPc3RFudG7hlXUTPUlHyLJuNitwpuBMVQGm7u0/NlhEBIUarYmMJSV5q9z+ao6jrNR8yz6Z/hZg
	PQmye3uMytOUGYkjanCS4UzuOZmi56zkPG4AdDrkU9XtYI+IrScwRNEILNOtAdHEIp4TePyi92V
	rRpBsAp1MQyCYokruXxSi03k9Tia8gpC5CjmG+aqKzH8VUQl0YADl/Ffj6PiDvcfO2KXaCk=
X-Google-Smtp-Source: AGHT+IER1GlKqenGCJq3qD2Xqlv8+ahed3DymdmXx7TwJgKJZxq18ZlqN5MmHKY9e5pztJs0I4bquQ==
X-Received: by 2002:a05:6a00:178e:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-7489ce45893mr32194637b3a.8.1750297417247;
        Wed, 18 Jun 2025 18:43:37 -0700 (PDT)
Received: from x1 (97-120-250-80.ptld.qwest.net. [97.120.250.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748fbce0f13sm291934b3a.37.2025.06.18.18.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:43:36 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:43:34 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 0/8] Add TH1520 GPU support with power sequencing
Message-ID: <aFNrRtbWzeRa7GmQ@x1>
References: <CGME20250618102225eucas1p129b1172bf54521c1eb0f718cb31af468@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>

On Wed, Jun 18, 2025 at 12:22:06PM +0200, Michal Wilczynski wrote:
> This patch series introduces support for the Imagination IMG BXM-4-64
> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
> managing the GPU's complex power-up and power-down sequence, which
> involves multiple clocks and resets.
> 
> The TH1520 GPU requires a specific sequence to be followed for its
> clocks and resets to ensure correct operation. Initial discussions and
> an earlier version of this series explored managing this via the generic
> power domain (genpd) framework. However, following further discussions
> with kernel maintainers [1], the approach has been reworked to utilize
> the dedicated power sequencing (pwrseq) framework.
> 
> This revised series now employs a new pwrseq provider driver
> (pwrseq-thead-gpu.c) specifically for the TH1520 GPU. This driver
> encapsulates the SoC specific power sequence details. The Imagination
> GPU driver (pvr_device.c) is updated to act as a consumer of this power
> sequencer, requesting the "gpu-power" target. The sequencer driver,
> during its match phase with the GPU device, acquires the necessary clock
> and reset handles from the GPU device node to perform the full sequence.
> 
> This approach aligns with the goal of abstracting SoC specific power
> management details away from generic device drivers and leverages the
> pwrseq framework as recommended.
> 
> The series is structured as follows:
> 
> Patch 1: Introduces the pwrseq-thead-gpu auxiliary driver to manage the
>          GPU's power-on/off sequence.
> Patch 2: Adds device tree bindings for the gpu-clkgen reset to the
>          existing thead,th1520-aon binding.
> Patch 3: Extends the pm-domains driver to detect the gpu-clkgen reset
>          and spawn the pwrseq-thead-gpu auxiliary driver.
> Patch 4: Updates the Imagination DRM driver to utilize the pwrseq
>          framework for TH1520 GPU power management.
> Patch 5: Adds the thead,th1520-gpu compatible string to the PowerVR GPU
>          device tree bindings.
> Patch 6: Adds the gpu-clkgen reset property to the aon node in the
>          TH1520 device tree source.
> Patch 7: Adds the device tree node for the IMG BXM-4-64 GPU and its
>          required fixed-clock.
> Patch 8: Enables compilation of the Imagination PowerVR driver on the
>          RISC-V architecture.
> 
> This patchset finishes the work started in bigger series [2] by adding
> all remaining GPU power sequencing piece. After this patchset the GPU
> probes correctly.

The powevr probe complains:

[    1.060383] powervr ffef400000.gpu: Direct firmware load for powervr/rogue_36.52.104.182_v1.fw failed with error -2

Where is the correct place to get the firmware?

Thanks,
Drew

