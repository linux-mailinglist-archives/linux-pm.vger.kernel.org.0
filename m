Return-Path: <linux-pm+bounces-23961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2EBA5ED6B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4317A6715
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607625FA37;
	Thu, 13 Mar 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="SV5JAfNU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFC25F996
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852612; cv=none; b=NgD2iOxQXR7E06uKEXFPRublozA9QdKQ84i9YSXjaCqVYSQNUU5siT0UBQhB43QcZH+C6c1BzEICVYgiAhWuNOnc00QtV+FyFtXQFYZy1VruOChSiE3khEr8TZDR0JXprXJufsxRNrdT6Okw6wuZr/ZVv/okllJeDigxV/JNgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852612; c=relaxed/simple;
	bh=csSoVqhz5tUPJ7KgffmWDeAVmThuBZdB/krQumO/yU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2esIQvQB33VYKFJE/c6tumpaTbYtNGoOXD9IR8+uoWkr7DrSj+uBucNTaKwItKYhqYBLwQPuD85UsWefhtMygPB3Nc6y5tKkpwkI+7vbNa14GMaURp/4wukLU+fuUsx4hqkiAmBXGT88Lt7Yy5WQVTNz7MdwcIXidjX/PQVUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=SV5JAfNU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so1166470a91.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1741852609; x=1742457409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38L2hz1chNfviXDy2tP0Lz340mHS97KT0hvfgoNEhj0=;
        b=SV5JAfNU+Q4S6QpLU0AE6qVgWm7ZzU52+F0R1HG61LM2U2Gdg4U5+S/a8qLWGWBIjG
         gRZ33vf5EXcrv8qz14hggCHavda+zo8TZL7yrncnQBxjaFiWOFYSllCu/0mGw903C0wZ
         SScvXeEXzcRE5qjwVGG6UPeg3rHqYTAv5midv1Den0SoG/pV6cA4pHEXPtfBnUzja7fb
         jTAqEl6J/NfOlDAKozcudab24QS4sR5Mw7e+Cyg73dufxRTyYB2NsA+JG/SNoEloQOsk
         HczfjB/dtPuTB+OjEYvii9keiZaooxL6aJfLyE6Tk1pgMTa890qn0EC602/XfbUqkTqy
         O1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741852609; x=1742457409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38L2hz1chNfviXDy2tP0Lz340mHS97KT0hvfgoNEhj0=;
        b=hRxJv44dbkLTmw6tAqRZwrTivoyvcNRSExoCLV7sXmKRSCMMNbkAgkd3rBAuSgILgq
         fmiM+J1Pps72xHs4NAABX/53L/zszwRWJa9jO0kAcYMsjP6v9M3Xy9YRMw5sJeofwJTy
         To0PrK2AHzX9uWbfjOkvv/8yHL5ulDr6lPrAW/UpPOtHnVT4rASG8RtfCd6KpQsT7d2o
         PiFjJ04FN94fUR+mIv9r/FqPd+8etdKd9FvgIyFX59yDaLffA2E7EGr/FcHHAtU4/oxh
         /IVrB4pDVYCvPH8paQYAuMUWBXj4AMXMLFmBX5E/6VpC1uMu20daWTb/NFArRblzvLbn
         1J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX76A2vrI5ozhMsYYs0X6j/swORWIvLCUl0bUrnHs/3t1Uo6O704Bj4SNDCs1f1Z/BTr0wMeHfFBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsqKC7flFlpXfyR7YZRZg6RuMAfncXLIM/w0GHPq3zOntV8fh
	1/ZM7/pXiMMpA/4oponeWCuyKY95ir+PDoXicxqbzESfu/b5Z7fdym6PinmnZuc=
X-Gm-Gg: ASbGnctTMciP9Uc7b2h12jVUVvXRasPun6UCxTdpshMuGDzmnNOr0TeTGzICK4VYvCB
	PNDaFtlla20sl0xr+ulubQKjyrMrovNiLNw9FjEjbGxfb1BTeXPTlsrtLmCJyB537AupOq3Prvv
	jZ5LYBNsr/YXEXUicE2IE2OxnMYKnob3gPjRd7iH8QJfnKVsb4nfB9tAgxamOllFRO48lno6qUP
	twO0yvO7GSFOO64nkfBxISMU1nV4vq4W+zGOXQw5WgyLBqRJH1k2sZNl8j34GFfe2lPudxnP5Hr
	pYqMyMkVWFz003vw8t8JHJc1Zg==
X-Google-Smtp-Source: AGHT+IExdVBJ3/gcWBXodBlgc0t0CtGEm8NtDZGsZZGRgntPtjMcoKU8fMdl0fX1ZXY61aguSYRxkA==
X-Received: by 2002:a17:90b:4f8d:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-2ff7ce8a02fmr39178985a91.14.1741852608708;
        Thu, 13 Mar 2025 00:56:48 -0700 (PDT)
Received: from x1 ([97.115.231.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30138f89db9sm796672a91.34.2025.03.13.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:56:48 -0700 (PDT)
Date: Thu, 13 Mar 2025 00:56:46 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
Message-ID: <Z9KPvig0dPRO0cX1@x1>
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
 <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>

On Tue, Mar 11, 2025 at 06:18:55PM +0100, Michal Wilczynski wrote:
> This patch series introduces and documents power management (PM) support and
> the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> upstream, these patches can merge independently.
> 
> Bigger series cover letter:
> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> 
> This series is versioned to maintain continuity with the bigger patchset it is
> a subseries of. Please find below a changelog for the AON & power-domain:
> 
> v8:
> - add proper cleanup in the th1520_pd_probe()
> - add "suppress_bind_attrs = true", since there is no need to unbound the driver
>   during runtime. This simplifies the code by eliminating the remove function
> 
> v7:
> - add '#include <linux/slab.h", due to kernel robot issue
> 
> v6:
> - split the firmware & power-domain patches into a separate series
> 
> v5:
> - changed the AON driver to be a set of library functions rather than a
>   standalone driver
> 
> v4:
> - added workaround to disable AUDIO power domain to prevent firmware crashes
> 
> v3:
>  - consolidated device tree representation by merging aon and power-domain nodes
>    while maintaining separate drivers internally
>  - power-domain driver is now instantiated from within the aon driver
>  - fixed optional module dependencies in Kconfig
>  - added kernel-doc comments for all exported functions
>  - implemented th1520_aon_remove() to properly clean up mailbox channel
>    resources
> 
> v2:
>  - introduced a new firmware driver to manage power-related operations.
>  - rewrote the power-domain driver to function alongside the firmware driver.
>    These nodes in the device tree lack direct address spaces, despite
>    representing HW blocks. Control is achieved via firmware protocol messages
>    transmitted through a mailbox to the E902 core.
>  - added new dt-bindings for power and firmware nodes.
>  - ran dtbs_check and dt_binding_check to ensure compliance.
> 
> Michal Wilczynski (5):
>   dt-bindings: firmware: thead,th1520: Add support for firmware node
>   firmware: thead: Add AON firmware protocol driver
>   dt-bindings: power: Add TH1520 SoC power domains
>   pmdomain: thead: Add power-domain driver for TH1520
>   riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
> 
>  .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
>  MAINTAINERS                                   |   5 +
>  arch/riscv/Kconfig.socs                       |   1 +
>  drivers/firmware/Kconfig                      |   9 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
>  drivers/pmdomain/Kconfig                      |   1 +
>  drivers/pmdomain/Makefile                     |   1 +
>  drivers/pmdomain/thead/Kconfig                |  12 +
>  drivers/pmdomain/thead/Makefile               |   2 +
>  drivers/pmdomain/thead/th1520-pm-domains.c    | 218 +++++++++++++++
>  .../dt-bindings/power/thead,th1520-power.h    |  19 ++
>  .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
>  13 files changed, 770 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>  create mode 100644 drivers/firmware/thead,th1520-aon.c
>  create mode 100644 drivers/pmdomain/thead/Kconfig
>  create mode 100644 drivers/pmdomain/thead/Makefile
>  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
>  create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h
> 
> -- 
> 2.34.1

For the series:

Acked-by: Drew Fustini <drew@pdp7.com>

