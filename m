Return-Path: <linux-pm+bounces-25254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E298A85DD2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 14:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2834A3A32B0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3072367B5;
	Fri, 11 Apr 2025 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUTvS9GS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4012367A8;
	Fri, 11 Apr 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375832; cv=none; b=HCRTiQmcGR6w36rtxnUP+JJtAdmfqIr1CESg/LQGc998p0erE/Gf1ViEeFoTk3koYWkm/lDNxftYTfObbvrf8lqs11EwPzv76vuhQKjdLgXBl/bye+UPM5D6KHKGfDyG6DgT6tTEKdi9aplT+PL1E/0C+X8n/hAGfchbtFWngr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375832; c=relaxed/simple;
	bh=krUFr3VNZumQLFuazMnfIo6rVrd52OPbijqeDOl/TLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqMawMugXsoaWjZRdK9DnlnTprGiCHRLlOs/TXEXwG/WlIv6R8ClD257MdPhRnWOeg/1U7dgRSaeAmpO1soyaeV7tUUCBDKwX7hlGX4YhyPgnq96WMfkgI2OAa+5UfmWXUdmLESEQoatNk35eVTTuXNOSlJ07Tc9KgS121p3lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUTvS9GS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-730517040a9so2340019b3a.0;
        Fri, 11 Apr 2025 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744375830; x=1744980630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXx2FL46B7WkOgjg7fh0W46JD/pfi8vbcwWhjWRwOFo=;
        b=dUTvS9GSrLd6nsTJ5z49RdXRRusX2cu4HMFTdoJfhd3vE+2+mECN9QDQqbAIFMQVKY
         cp/k3HdRHqprtO9QltqxV+P6Q6ltlE+/VXochjuVYz24u8psHmxBRA9z+oV3M1QVEEj/
         sbTMrnw76LtlWQeXFuRXrxLENi1NNvLZmkgV6ULDmMiBqM3JNZu21+zfjz3VyYBiRJ0e
         9O99nTg1ASVM6X+3T4pUCQ8RR8/Q2fFP3ckfINk9GQ+/sBaBNtqk4fbcQWiigRJWACfm
         LP/SoLlirdC7oF+DhDWRGNsd3tbpH4jUYrYGCCvrlHaibLURXmrad8YkjrG523ERPkhC
         TCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744375830; x=1744980630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXx2FL46B7WkOgjg7fh0W46JD/pfi8vbcwWhjWRwOFo=;
        b=OLEO9VTwov+LbEKjV3GU0kGuMhCvuRdFD2VNcERDdQzahZlVx9ZIIePxPxjtC2X4/v
         ASYI7QTZq5qIxcjLAS8nkHxZl3C5aHdfr6NMPETU5FskALrqR8PX2f9FGDKtMy8qVEaQ
         7t9FKrsbwsEghNZKm3I3JbBHaPxAOpQp7d082j7yrF2Bb4Gxnirr+rtv1p+zLt3/AKtn
         MhwpYREGNx85nMVd5XJL1Ao/JscDdyd7iK+VB8BW1yE608UGpgaRRJ7eWZKY+VmQLiPc
         YIAL8Z//ywNeiJATgCi68kQcin0gO0UDP4GAHW4KJL9g2GKG4RyJxzZ6CI0PbCOQM61p
         JIXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLi0dp/xI1zcjsVsqc0PMHwpC6vmPcFfrDFmiyvelvgoidA+N9l1oyY5nk5d5I56rbsx3oJj/RRGJvS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5k6mQlx8WRwqkEfgZ+sEclmx0MI7/nLTNl7qcjN2BMtruo1x
	FiYK4u12l2Yd4agc7B//QYyiIfbzSdhOAPFsC734PUxIPm1y4w8BNVxxfYay
X-Gm-Gg: ASbGncu7PP8bJZsiRSkegPOzHUzQeQdu6FnjxMVEE1M2vAFG/mboS+rzF4x8F1GYe9T
	C+ZT+aSjH3ykNdnMLyZ9h9USwC4vytwYbXYM6YD5rLg5j67kLPDYY0UDy+JxnNaHst/fE7X6gJc
	Z3u49B1bFpL5Ljhq5vQL9JdVTysf7pNQhu8fGvCXFGPFU4aKAFL5M+9tnRz3whoAf6yaZlLyGKf
	KlxRd9I6tvSDepNLArGr5c6wJWlAKCLSLEZRgjgjT33MJqyXXWkLiEz0ek1Q8FraoeVYszYBgBt
	kkhfD1xANAYvlPOoQvBbL0nnfrXj10P4lvpleIA=
X-Google-Smtp-Source: AGHT+IHDBvV0qQ07NHfk55qvtex+sgwOy6tRhqXVO4CM20TuwI5QvWlbhrJx+JWvNB7ZbVYZ7Pqf4Q==
X-Received: by 2002:a05:6a00:4644:b0:736:5753:12fd with SMTP id d2e1a72fcca58-73bd1194273mr3931962b3a.4.1744375830033;
        Fri, 11 Apr 2025 05:50:30 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:9277:4e8:b712:66e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230dd71sm1374107b3a.128.2025.04.11.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:50:29 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:50:24 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Message-ID: <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>

On Fri, Apr 04, 2025 at 11:17:13AM -0300, Hiago De Franco wrote:
> #regzbot introduced: 4f6c983261
> 
> Hi Peng and all,
> 
> Commit 4f6c9832613b ("genpd: imx: scu-pd: initialize is_off according to
> HW state") introduced a regression where the Kernel reboots unexpectedly
> (without any warnings, crashes or errors) when the Cortex-M4 was loaded
> and running by U-Boot, using the bootaux command:
> 
> # load mmc 0:2 ${loadaddr} /home/root/hello_world.bin
> # bootaux ${loadaddr} 0
> # boot
> 
> This is a simple hello world binary that prints a message into the
> M40.UART0 pin (demo from NXP MCUXpresso).
> 
> Before this commit, everything worked as expected, Linux boots fine and
> the HMP core keeps running and printing messages to the UART. After the
> commit, the kernel reboots at the beggining of the boot process. The
> only relevant message is printed by U-Boot after reset:
> 
> "Reset cause: SCFW fault reset"
> 
> This commit was bisectabled, the same device tree, u-boot version, and
> SCFW versions were used. Reverting this commit fixes the issues.
> 
> For testing purposes, I created the following patch which also fixes the
> issue:
> 
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> index 38f3cdd21042..0477b3fb4991 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -539,6 +539,9 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>                 return NULL;
>         }
> 
> +       if (strstr("cm40", sc_pd->name) != NULL)
> +               is_off = true;
> +
>         ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
>         if (ret) {
>                 dev_warn(dev, "failed to init pd %s rsrc id %d",
> 
> 
> Test Environment:
> - Hardware: Colibri iMX8DX 1GB with Colbiri Evaluation Board.
> - U-Boot Version: 2024.04
> - U-Boot Build info:
> 	SCFW 83624b99, SECO-FW c9de51c0, IMX-MKIMAGE 4622115c, ATF 7c64d4e
> 
> The issue is not present on: v6.5
> 
> The real root cause is still unclear to me. Anybody has any ideas? I am
> happy to share more details if needed.

Hello everyone, as this introduced a regression, should I send a revert
for 4f6c983261? Or any ideas that might help fix this issue?

> 
> Cheers,
> Hiago.

Cheers,
Hiago.

