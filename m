Return-Path: <linux-pm+bounces-25491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CF4A8A6F4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700DD3B58DF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08424224243;
	Tue, 15 Apr 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO5CYnMf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C7222568;
	Tue, 15 Apr 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742417; cv=none; b=DafXSTGiilwL/r6pF/vQyPFojulK+8OJ2xGcyTlP9kIUzsxuYkzS2lkdKb4WMCSZYGwZTxG5Y32QLOsEoiFrMcFj+Z+AdxvoodDWGhkus17upy5gkp9LB+kyk1QupZU2p/e2sHx+O2KoT0lrKobWjM5SbV54hlJCgk2GExZuL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742417; c=relaxed/simple;
	bh=uJJWlYxC2n/XPAh2wuaGtIwzaSCPDPze4SI0d2I+hlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKYsGdOW4hOG0PXBzGz6dNu67ZNYWqWoMNQeATxhlkIymKQkATVlTSo1Dw96lHY9p40H8lYDAAwK1PSkqmS/pAEyqDEU6r+qdsPaDzD5dX6+0iVBfvWC0dSaMbZ050CNqf/haPZjhBQmRFSaG3tpaEY7q3nBmY/CofcvTZThh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO5CYnMf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af55b7d56a1so4516299a12.2;
        Tue, 15 Apr 2025 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744742415; x=1745347215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7LdJfX/NiQcyQWhxd6h6QFvrDjuTzax4bkOLSIcqCY=;
        b=KO5CYnMfua2nivxva9A7cDdsF/v8HBqb9s+62wvbk61lxCl+FvjDF/E+BM8LMyT0Ov
         ImTsMeUgDkrZ/aUIoKfzkUE/8WmOvemi3GCThIAgX0Vu6I1Prl6g5LahND7bwMFw+tCj
         wqN9wRkjEEw5q8qAD6FksM6KAgsHwuHAGrn+ZZ4gpLS+TKZ0QGY3vMn201ufThlTaGwh
         NZEqQGTEemqHTPRQ/BEsarCyKXckT+dXvciXpVDLPljjDlPjt94w6ANBqSF+ITqmc1W0
         7fWaonpp7NU+UvSyaYLjYR60gTNEhMhytpuNgcH51+nxvPKFBRYVhydmhiWpAHoYz8c8
         T5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742415; x=1745347215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7LdJfX/NiQcyQWhxd6h6QFvrDjuTzax4bkOLSIcqCY=;
        b=GojtPtfTfUeIBIsUrELUjZHBY3NBmi+AH25r4keA/GVB+QDRn0JVAfs7WmwsG5sFpN
         yf4I6YdRGcLVWq6mIWimm00przZkb9/IG6+EDWJ8gY6wofC2l++VqpRYDNT/KgwYCWp6
         2heveS1LS8/8GnWarTfYw5t0wGWViKZFmF3JjW/TXfxBhtksVfVQUj9qI2QNRMB/K34k
         PY8WpPmqjXlFIeRueyGriuK5BxwD1Y1pMRpDqz5dlUy4JPr//i+z5yFyx0jJBDR8AIsT
         8RlJOQRu+E+2qGuF1Y3WkXcCXtknAW/Juxy7tflY00rDxfkf66F55w3TCnMJZCMq1Pr0
         noHA==
X-Forwarded-Encrypted: i=1; AJvYcCVa9yseiVlhYSaOH76XiGdM92dKfbR12m0qhAd7anD/icLMvueVvrSjhgrRtCMiFv9vHutCeMpvpdLOeG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHUZEwSbuFSs2a+7hCT4hWkMEt+MdTLTibbEbtKHgNKXejrQd
	Iwxyo2tYR9179RYozaxskxqPXPp+PRG5SGzMhpeJpypUlrhwVcbO
X-Gm-Gg: ASbGncuGvNZsMdPQ14Z3FFNngJgvpFPwd66TiK0iAHmnvmxZt/qkWTlmq0lve5lYWw4
	qJ8tLmzGum//Eou32wLDpxdhjkq+H38FJQWpZsF87aWUXhAwTQlmKT7ZTnclHwNhngeKmlxgM8h
	3VvGfpLqRl02JnWc5LnQQRqVh6nbE4SVcglKC3uEHhSn3FFWX5EL6bzSNZB5Clgklh83Mo+PVrH
	xXpQjj2JOuFIxoq06VaWQunG1Ke3vr3Q9aatYJwK4wCHDYwrn+XUFDxkK3QaIOYkDCN2j/lK7TZ
	k0cN1TqsmiFQkFfjf1u40Pg6kNDLOAH8GL/t2u4=
X-Google-Smtp-Source: AGHT+IH0/rViGbAh62y8CYGqkS4uAeLP96QgGfU8Xo0+eLty4NFaaNFFothcrivWo5vjv19P3qVGDw==
X-Received: by 2002:a05:6a20:2d13:b0:1fe:9537:84a0 with SMTP id adf61e73a8af0-203adfc5f55mr67704637.15.1744742414609;
        Tue, 15 Apr 2025 11:40:14 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a321f921sm11325860a12.72.2025.04.15.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:40:14 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:40:09 -0300
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
Message-ID: <20250415184009.2fvtn7tbe6uzwiyg@hiago-nb>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250414224452.gk4ccniqtumfbjth@hiago-nb>
 <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Tue, Apr 15, 2025 at 12:11:33AM +0000, Peng Fan wrote:
> > Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> > when Cortex-M4 is running and it was started by U-Boot bootaux
> > 
> > Hi Peng,
> > 
> > On Mon, Apr 14, 2025 at 06:09:49AM +0000, Peng Fan wrote:
> > >
> > > In your case, m4 is in same scu partition as a53, so m4 power domain
> > > is manageable(owned) by Linux.
> > >
> > > However to m4 earlyboot(kicked by bootloader), if you not wanna
> > linux
> > > to handle m4, use scu_rm to create a separate partition in u-boot.
> > > If you wanna linux to handle m4, but not wanna linux to shutdown
> > the
> > > pd in kernel boot, imx_rproc.c needs to be built in, and need to add a
> > > clock entry or use clock optional api in imx_rproc.c .
> > >
> > > Current imx_rproc.c needs a clock entry to probe pass.
> > >
> > > I think in your case, this driver not probe pass, so the
> > > M4 pd still get powered off.
> > 
> > This was correct, indeed. I was not able to find exactly where the
> > cortex-m4 clock is defined, so I added a clk_dummy to the imx8x-cm4
> > remoteproc node and now it works, the code continues to run and I
> > can control the m4 with Linux. Thanks!
> > 
> > One thing that I noticed is I cannot make the RPMsg work with this
> > devicetree node, even tought I assigned the correct memory-regions
> > (vdev0buffer, vdev0ring0...). Also tested with the rpmsg-lite from the
> > linux-imx. Is this supposed to work with RPMsg as well?
> 
> To make rpmsg work, you need a m4 demo that could publish
> resource table, such as i.MX tty echo or pingpong demo.
> 
> There is downstream rpmsg driver under drivers/rpmsg/imx_*.c
> that could be used to talk with m4.
> 
> helloworld demo does not have any virtio devices, so no rpmsg.

Got it, I was able to make it work with the downstream pingpong driver
and the MCUXpresso demo. I can launch the firmware using the remoteproc
and exchange data between the two cores.

There is something I noticed, when I start the pingpong demo with
U-Boot, it does not work. I run the pingpong modprobe on Linux but the
name service is never annouced. It only works if I start with the
remoteproc on Linux, not U-Boot. Is this because of Linux not being able
to control the M4?

If I start the binary using U-Boot, the "state" always report as
"offline" by the remoteproc driver.

> 
> Regards,
> Peng.
> 
> > 
> > >
> > >
> > > Regards,
> > > Peng.
> > >
> > 
> > Hiago

Thanks,
Hiago.

