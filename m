Return-Path: <linux-pm+bounces-25416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F7A88F35
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 00:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E057189BAE5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E11F4186;
	Mon, 14 Apr 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqPJcYic"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C92156236;
	Mon, 14 Apr 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670700; cv=none; b=CxRhLKy1soyJpD+LKH+Ff+JnPg9jaVCj7kFCKxGa5X00fv1/5GBCu4Djudd5WiFhL+icKST2FygTzN03iApozgReJ01E5DemZqLdRGkZonSywyKFoJ3sXBJUO5nmwCfon7o6ReS1+FiVvC3tfa5EKh0R+MSCUSbe8VEusejwNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670700; c=relaxed/simple;
	bh=1DPzF0IfyF98MjDzAq64CNgLAK8YEM3pXDiD8yr5QrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnDvGylFKFnPRfSWtKqWEG1oM9dmjZyXCFupKTdTaBOuXO9Q+B76PlvJrzDN+wC2oKB8HvheJapUjI422gtMSFPKoWdE61REqV2v7KcUbZ4UFU7J1Ur/JImF5953Y20rot86x7i6EoSxPFXJR8PqsPn7tjNLmbOFnm1HjWPfz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqPJcYic; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225477548e1so47228645ad.0;
        Mon, 14 Apr 2025 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744670698; x=1745275498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCbufsqovhRdxKI/Wo+sxDQep3MCh6y6M1Tif6pvFv0=;
        b=nqPJcYicDFAVA1Dmd00dCFF3LNqDCebfDOZK5xrG/sFBv5mgXjF0Ao5yqIrEcPJTss
         uny4tBzpkwQfzitKOo7Rd2I8lsOsIaRpS5A9rcG/fEaM/edBBGkYwBUEJGWYtCmPgXkd
         UrP24/d96cUHFCovcbWuVNvGESLPxG9sGa4KK1+5dM/6BmKwfF4YPyBwbFdHQs3f7dFk
         E24SMTWpltOpvxnXVl3ZuqLCV0RFax4bcdCaqOII728x1bGrf6D82W6KayU0vFYwRPBh
         +3cEV4/HfGPhv3Ofo4Y9+XzAz7nYY/VK1ooO+5itWXBASqXRBaCCQBKD/fp6NrFmhZze
         QGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744670698; x=1745275498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCbufsqovhRdxKI/Wo+sxDQep3MCh6y6M1Tif6pvFv0=;
        b=cX9DQWPTLcNCeqWA0MMDlWNwAPEJwES3xF/lkRkWQIcXu+Nmzkq9bIrfL2qF4fi1Vx
         3wUf1QTCXm7CgX63EC/2ICpcpxR4F43rvfF2XV7RL/BIWP3E5tvXmcUK9mpS9gac5vsh
         TPYtNHWrUaQMv7OyRXVUC1JJsDm8iB1k20V684PJzAxA8nHe8awZPIqfpOaqrHIRAWk1
         MJi/c9UWSID0eoqK/qJCh/C0hNWGM6HuOESPF1AmdNbCSMu6i0GcZCSVoY2PG7EEHANL
         K0AGjm215kiKM6bVQ/SbskIw7/K1SIabvtMBUwPjsqGN7N7oe7ZJeUEkgVQDkavElQdW
         0Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCUXEGDRXAANfOBen7NlVm+qCoptV23keqFB8PccRd6lp4Z5PJps1JY/Wp9ZcpA8FYZwx648TMQpkroBl2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYuDhK8ptW8R7fqbFEGSNMpRkeURIMNEH1ETGQQoF+3jljWCV
	lEAf/UnZaQGY3xROONOmyIsB1/ISevD4W+3TyQpj0JBtQzvGoaUM
X-Gm-Gg: ASbGncus5mGimM5LB5xOstZjPcVfLkx8UtAM6ch6WDoX68eEjWZxXQWkFE/oXSn9+k2
	XjVIVMP5Coi8ZVKHToraL1/4Z+L91YUpf1s6M5kK2ktonX95GupKaVmQPpeP4eC/VDef8qjdROu
	KeOwmLDI2scRbwUZGTAqYq7MV++X/HgMMJqmmsxfzwcosS0tidF/qiRWX8b5GWf3poSnxlTw26t
	5udSIpnuI3dBg6VYa05IGHjU9pDoX2pOAysRglnXbGS0+ikEJzZn0Xv4eYD5kkEYi17vR0tkhR/
	DA192oWdx4vyPVAUZ/C/PfKnMBaIy2G7l1H2HyYitZVn0essLF0=
X-Google-Smtp-Source: AGHT+IGWOQk/MY4RrJwds2DUYwvDvZppCoo869G7JJk+fcUnDOZsIWUfuBx0HTAue14NQURwioU/rA==
X-Received: by 2002:a17:902:ebc2:b0:220:e63c:5b13 with SMTP id d9443c01a7336-22bea4fd043mr193492195ad.46.1744670698007;
        Mon, 14 Apr 2025 15:44:58 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:131b:ff00:5ee5:94c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c62c3sm7400010b3a.52.2025.04.14.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 15:44:57 -0700 (PDT)
Date: Mon, 14 Apr 2025 19:44:52 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Message-ID: <20250414224452.gk4ccniqtumfbjth@hiago-nb>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>

Hi Peng,

On Mon, Apr 14, 2025 at 06:09:49AM +0000, Peng Fan wrote:
> 
> In your case, m4 is in same scu partition as a53, so m4
> power domain is manageable(owned) by Linux.
> 
> However to m4 earlyboot(kicked by bootloader),
> if you not wanna linux to handle m4, use scu_rm
> to create a separate partition in u-boot.
> If you wanna linux to handle m4, but not wanna linux
> to shutdown the pd in kernel boot, imx_rproc.c
> needs to be built in, and need to add a clock entry
> or use clock optional api in imx_rproc.c .
> 
> Current imx_rproc.c needs a clock entry to probe pass.
> 
> I think in your case, this driver not probe pass, so the
> M4 pd still get powered off.

This was correct, indeed. I was not able to find exactly where the
cortex-m4 clock is defined, so I added a clk_dummy to the imx8x-cm4
remoteproc node and now it works, the code continues to run and I can
control the m4 with Linux. Thanks!

One thing that I noticed is I cannot make the RPMsg work with this
devicetree node, even tought I assigned the correct memory-regions
(vdev0buffer, vdev0ring0...). Also tested with the rpmsg-lite from the
linux-imx. Is this supposed to work with RPMsg as well?

> 
> 
> Regards,
> Peng.
>

Hiago

