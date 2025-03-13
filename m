Return-Path: <linux-pm+bounces-23962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FBA5EDB8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4520C3B0C6D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578926037B;
	Thu, 13 Mar 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="LMp9udoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29E25F97C
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853525; cv=none; b=sEyVcqJNDAl1J012yjmYu3XfHGzLoghbtuQwe0KCOZnVn/aQY9J/z/TjH3XCGefT0G95TTS1AyKVEN1H1xNkjCa7tpsn/DQwVueDU33lm7EsOY6AgQDqqNHCQfHGOX6XySVKEirLvFftYAdz68akL/kc3i8uXa5q/ihoZi6l76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853525; c=relaxed/simple;
	bh=IzGp4fuI3IHDHrdTjmvckSBEPvHvy8pyQGOWfkKs5ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMsNYZTHuiJT1IMFY6E+W7mfZAo4pdEq5nIhkha/yBwD7V9QrRuGyQ/9ibazmR8HiE3nvJr4Zd02+FlPcEmQn63vfTc4heiGW7hGrctvt36VXJzpnahCgRrv/fSjphT65KCxxr5U2gwpmgNQwLeX+pMHj5DB5CHCMkCzLFPdpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=LMp9udoM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feae794508so1208444a91.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1741853523; x=1742458323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMyv34pTISRCo09Nm4ZPlxjDBtcm83XdK8rjSQH8Ng8=;
        b=LMp9udoMgjEHzE83rclQ/gN4vSwPVrmpqRceTjYFUlXHdI+5Klm2xFAlk59sSvepmy
         ZxSQ4PWggmDK4NeM4QaDA+6CvrKVrs9xtaOZAyNObO2+LsxVYMUKu4bJ5ES40kG1QFbI
         54S6a1ImmBbO4TdkYW/PTdxXtS1Sf8cXTFTljv9PGnMfs/M0FJ0iV9y4GIA/0awustbT
         qfEEAf5/uV6TS246ZNGtD9M81DGM8fSIto7fAVA7RFEo+7sK/+aEE4s02wAVvbAWSshV
         nnh1PSbUWVTiUJ4dBo/AiDIb7oamxLEgUvKQ3a/65CvYrwWp11wS2HIIns7N4k6B7g6c
         ANSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853523; x=1742458323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMyv34pTISRCo09Nm4ZPlxjDBtcm83XdK8rjSQH8Ng8=;
        b=VYj9uJcj01dE3zOM6tn5BnEAcP6ePdONuLEo9073wvrlWWV2JNpUOAtttxOvYkINCN
         +n2S3CPAS8O6QXtL14BUPY2rphLTnHOb/R9qhK4A/ZGSbl0UU2A61FiQiih2FQC/qChP
         TgEN+nnAqvrD0bytYUbX/IYr29/mZLQEWETGnIkPKDIgJ7rNkN3St8GB6O5cpei0odUX
         wJYie4nXVUa9+iQcg8i/V4IguF0JDt7TOdtnDTP/9c+TRqH7a6rda/KAeW6Zl6aH0TFC
         5Nc33LD/uCq5R9ZivJrMPBcCruuOetBl8W0eZD0Jufb1Km+suif/uO4yk4vmjwR2WmDD
         Fb3A==
X-Forwarded-Encrypted: i=1; AJvYcCXOwEIUwPV9Z4g8MN99v4uPczBZ5Hvk87Rew3JKamDsBYS8LtKwWZxzXjeLLJEXZBMugOhcCKTaAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzReNToFpJTqbM4teLg8y5HOQI3caNsDFKbw+NAgiJDUGgQ0xlI
	iapPrzOmLp7a21CzoLizlKuRBQbKBLd9AhY6kUsjYS2/W7e4xjdA0EUl4vpOqGE=
X-Gm-Gg: ASbGncv5wMBldLa9lg1lHGyGM9/bcM8Qcz9I1qolQDa4or/MUzGqbYvPD2NbDYlsUlw
	KrQa5ZtIqkcGtk5MtiC0pcngT4TKphLvEYuE2N46MNJ/6fokyGg7FpgfZDiyDQlrVX4WBrfPfVu
	5662jpH7VT9N4jbcfGHFBS2KjL98u7ssB4cA5/iShejk6IS2NPbX7+cVvIrxTESmTpEsGtwFwiS
	A+GvfHOs1Wi8l88FHNXUAgWEcgbADZt2WcfYViA/O4N6RVv7wFrcv2Amc6JfIit2qOl9tMuLv0t
	H6be5HPau0kRtMwK6gPgrPph4g==
X-Google-Smtp-Source: AGHT+IHfykXuKqP+IUtV7YBcmaO3errhm+D+UcJTQxE3sDBqJ8q7MdfshOawA55kfif74OzDGiSbMQ==
X-Received: by 2002:a17:90b:4c4a:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-2ff7ce4f260mr37122057a91.2.1741853523011;
        Thu, 13 Mar 2025 01:12:03 -0700 (PDT)
Received: from x1 ([97.115.231.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883fesm7885555ad.6.2025.03.13.01.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:12:02 -0700 (PDT)
Date: Thu, 13 Mar 2025 01:12:00 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, guoren@kernel.org,
	wefu@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
Message-ID: <Z9KTUIix4z7xb/e1@x1>
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
 <20250311171900.1549916-1-m.wilczynski@samsung.com>
 <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>
 <4b45236e-8252-4dd5-b3f7-3595b0924182@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b45236e-8252-4dd5-b3f7-3595b0924182@samsung.com>

On Wed, Mar 12, 2025 at 03:31:04PM +0100, Michal Wilczynski wrote:
> 
> 
> On 3/12/25 14:40, Ulf Hansson wrote:
> > On Tue, 11 Mar 2025 at 18:20, Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> >>
> >> This patch series introduces and documents power management (PM) support and
> >> the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> >> board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> >> upstream, these patches can merge independently.
> >>
> >> Bigger series cover letter:
> >> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> >>
> >> This series is versioned to maintain continuity with the bigger patchset it is
> >> a subseries of. Please find below a changelog for the AON & power-domain:
> > 
> > I can pick up patch1 -> patch4 via my pmdomain tree, assuming I can
> > get an ack from some of the thead-SoC maintainers.
> > 
> > Patch5 is probably better to be routed through the SoC maintainers
> > tree, but let me know if you prefer me to take this one too.
> 
> Thanks, I don't have a preference, I'll leave it up to SoC maintainers.
> I haven't included the device tree changes in this mini-series, as then
> the PM & firmware, clock, and reset mini-series might conflict with each
> other in th1520.dtsi file, but SoC maintainers might also find it useful
> to pick this commit [1], along with the patch5.
> 
> [1] - https://lore.kernel.org/all/20250219140239.1378758-20-m.wilczynski@samsung.com/

I applied this series on top of next along with the above dts patch.
The existing functionality of ethernet and emmc continues to work
correctly. I can apply the dts to my for-next tree once this series
lands in next.

root@lpi4amain:/sys/kernel/debug/pm_genpd# cat pm_genpd_summary
domain                          status          children        performance
    /device                         runtime status                  managed by
------------------------------------------------------------------------------
dsp1                            off-0                           0
dsp0                            off-0                           0
gpu                             off-0                           0
venc                            off-0                           0
npu                             off-0                           0
vdec                            off-0                           0


Thanks,
Drew

> 
> > 
> > Kind regards
> > Uffe
> > 
> > 
> >>
> >> v8:
> >> - add proper cleanup in the th1520_pd_probe()
> >> - add "suppress_bind_attrs = true", since there is no need to unbound the driver
> >>   during runtime. This simplifies the code by eliminating the remove function
> >>
> >> v7:
> >> - add '#include <linux/slab.h", due to kernel robot issue
> >>
> >> v6:
> >> - split the firmware & power-domain patches into a separate series
> >>
> >> v5:
> >> - changed the AON driver to be a set of library functions rather than a
> >>   standalone driver
> >>
> >> v4:
> >> - added workaround to disable AUDIO power domain to prevent firmware crashes
> >>
> >> v3:
> >>  - consolidated device tree representation by merging aon and power-domain nodes
> >>    while maintaining separate drivers internally
> >>  - power-domain driver is now instantiated from within the aon driver
> >>  - fixed optional module dependencies in Kconfig
> >>  - added kernel-doc comments for all exported functions
> >>  - implemented th1520_aon_remove() to properly clean up mailbox channel
> >>    resources
> >>
> >> v2:
> >>  - introduced a new firmware driver to manage power-related operations.
> >>  - rewrote the power-domain driver to function alongside the firmware driver.
> >>    These nodes in the device tree lack direct address spaces, despite
> >>    representing HW blocks. Control is achieved via firmware protocol messages
> >>    transmitted through a mailbox to the E902 core.
> >>  - added new dt-bindings for power and firmware nodes.
> >>  - ran dtbs_check and dt_binding_check to ensure compliance.
> >>
> >> Michal Wilczynski (5):
> >>   dt-bindings: firmware: thead,th1520: Add support for firmware node
> >>   firmware: thead: Add AON firmware protocol driver
> >>   dt-bindings: power: Add TH1520 SoC power domains
> >>   pmdomain: thead: Add power-domain driver for TH1520
> >>   riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
> >>
> >>  .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
> >>  MAINTAINERS                                   |   5 +
> >>  arch/riscv/Kconfig.socs                       |   1 +
> >>  drivers/firmware/Kconfig                      |   9 +
> >>  drivers/firmware/Makefile                     |   1 +
> >>  drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
> >>  drivers/pmdomain/Kconfig                      |   1 +
> >>  drivers/pmdomain/Makefile                     |   1 +
> >>  drivers/pmdomain/thead/Kconfig                |  12 +
> >>  drivers/pmdomain/thead/Makefile               |   2 +
> >>  drivers/pmdomain/thead/th1520-pm-domains.c    | 218 +++++++++++++++
> >>  .../dt-bindings/power/thead,th1520-power.h    |  19 ++
> >>  .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
> >>  13 files changed, 770 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> >>  create mode 100644 drivers/firmware/thead,th1520-aon.c
> >>  create mode 100644 drivers/pmdomain/thead/Kconfig
> >>  create mode 100644 drivers/pmdomain/thead/Makefile
> >>  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
> >>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
> >>  create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h
> >>
> >> --
> >> 2.34.1
> >>
> > 

