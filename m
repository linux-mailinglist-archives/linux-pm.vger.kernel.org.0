Return-Path: <linux-pm+bounces-25281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF6A86324
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE60F9A7261
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A121B9C4;
	Fri, 11 Apr 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df9jLXKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917F21B909;
	Fri, 11 Apr 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388616; cv=none; b=BURbv4U2UFEVoXvd3YrChDauzPn4cKqQAEcPBhZnnuZL2RmE88F827a08P7eaVfmBXETSwtJKTxIz1rBt80EPKFgh/9sgbJPIsJ+zZ8+mv2P1gvAnelMtTFKcAUsorU6A/tt2tYql9lICmbWJzg8ZG4hJ1v066d2YwWnbwvfZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388616; c=relaxed/simple;
	bh=vCMcEgHUigUOX4/6itupqbvmSxHNfPGr6uYveuFsH9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS1TUXNlDgWwpCDB1d5erliXGkbaLBWL7L1HGlvw0PVzYgTMAgvogDPqe3Cy7cDnz77jJ8/ftF2/dGGXb7BqB9uV8dfjubHt7gcPo3PUOnKn1qc62hyYMemcEazXQtiETcm8FGdx4d5qSznSuwofq2X440s1ew2NIlYFzHBJTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df9jLXKT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so2097636a91.3;
        Fri, 11 Apr 2025 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744388614; x=1744993414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5FckoYafwVaXPWK2PUB+GpDyPBlHFtc4ZPOsKk2Ipg=;
        b=Df9jLXKTciE34go8Ei8DIcysY65aJN8SNRWbWycT0J6vsmN6ggND4NHjDRUtEJlIxy
         Gwb1g6UCfAR0UfgOKpwai4HpJvzqT5I9VAsfvMOXOkGiBbITcm1l/rQcJ6agOfWTRWdv
         gKrwD+vdCYTtS1sFx26420/kU7JPY2iZxILKBoYTj0tSK9IzAMIJVsO7BWZ49ax5DvZ+
         RHdr2dyygJsLqeo8iUUsEk8rxdrgnvSG5Ky9oL5OUuZuVuAwG9okCngSysoKM4eBrvKi
         4REUomapfpPi6Xfez4txZc+H1Fy/2YFSVJHodZrMs6fzT4Et/icihp6DQHDygkSBJrjn
         n52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388614; x=1744993414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5FckoYafwVaXPWK2PUB+GpDyPBlHFtc4ZPOsKk2Ipg=;
        b=iPiCjzCUyJrNnZl6hHRU4ch9PkOZ83zmQJDA5KY3wGhIjqYL7g2sbU5gGlHaSvbbiM
         mfE7g6P1HW1xhgEToAH8QLXUFgUwYmNYfbY1+daGW0jKbNR2WzvAQoWVoGlFTpGjioyS
         oP1YIgo0DxrkX7BmBU4KyWnC1DmP/gNf0cKqdDUEdQT8TGwFF52HG9IHhN4FcaCgfDwa
         y9td4+ULGA43ekUPq0wLraTAKNP/3P/DIPI8BeZYzZzHuw6+VMVyM4pn1RpIn5K8WpS/
         ZiAVL/JKkdmDJiOwnnuLU26AmjRFoCaNbjF/dVmKuXc5ZPMRmSt/yjz5m6CMxxhc891s
         9ZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm0Q920fvtX8JKi7MzGzBby00/wI8BePBKTYtIhWU8tI+SVwfG49nfq9rj27mPtWILGHUGFFPh9jLTjJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9axuCQ0cN/FnqKj+4l52Sk8iVhnR3ihsWlNcXMNFXElfuM1eu
	hZGpMEN/8R+xv8YRhPkw9E/dsKp8brp3K7wNXX9MuxzB3NyaifCl
X-Gm-Gg: ASbGnctiY6D1zI39udA/DsuNmEtoV0buqAO8XzGr3udk7tlUaCNqxR7VZ+K7/hexa1j
	s8byGB/Q6tbT9r+fXpbV911L8xeINTKKN3IqTLjljNZkbwPXPfek3Rek0xnnccQm0ytlV4BBWZ+
	T+uwrqF9tRbKyiRTroN7+jxGOcWDc/eNEX40jDzCxLdHgv5sT2Zzp2XcRRhoZqiE/EOZtLdRFlZ
	/b1OWVKZsqI8RPBhuQ71aNDDdJNg2t17CYCXyzD6qQYwgpiOI7L6dTuwF8aU3SY5XMuzBGjGRnL
	BEtimDluz25Ep37EX0PyDYB56TND/UGL7LQ+Ktsxg9t3KM2exw==
X-Google-Smtp-Source: AGHT+IFCfUV6384bNBCr+vSp/DTf6SVjkwz2rSVIWqsuCTiK8sT2R3/nhh6FK0ZbTjida+uNgTjQKg==
X-Received: by 2002:a17:90b:2647:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-30823646ae2mr5751053a91.18.1744388613682;
        Fri, 11 Apr 2025 09:23:33 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:9277:4e8:b712:66e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a14bsm5814830a91.1.2025.04.11.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:23:33 -0700 (PDT)
Date: Fri, 11 Apr 2025 13:23:28 -0300
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
Message-ID: <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>

Hi Peng,

On Fri, Apr 11, 2025 at 01:23:32PM +0000, Peng Fan wrote:
> Hi,
> 
> Sorry for late.
> > Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> > when Cortex-M4 is running and it was started by U-Boot bootaux
> > 
> > On Fri, Apr 04, 2025 at 11:17:13AM -0300, Hiago De Franco wrote:
> > > #regzbot introduced: 4f6c983261
> > >
> > > Hi Peng and all,
> > >
> > > Commit 4f6c9832613b ("genpd: imx: scu-pd: initialize is_off
> > according
> > > to HW state") introduced a regression where the Kernel reboots
> > > unexpectedly (without any warnings, crashes or errors) when the
> > > Cortex-M4 was loaded and running by U-Boot, using the bootaux
> > command:
> > >
> > > # load mmc 0:2 ${loadaddr} /home/root/hello_world.bin # bootaux
> > > ${loadaddr} 0 # boot
> > >
> > > This is a simple hello world binary that prints a message into the
> > > M40.UART0 pin (demo from NXP MCUXpresso).
> 
> Which release is this image from?

This is MCUXpresso SDK 2.9.0.

> 
> > >
> > > Before this commit, everything worked as expected, Linux boots fine
> > > and the HMP core keeps running and printing messages to the UART.
> > > After the commit, the kernel reboots at the beggining of the boot
> > > process. The only relevant message is printed by U-Boot after reset:
> > >
> > > "Reset cause: SCFW fault reset"
> > >
> > > This commit was bisectabled, the same device tree, u-boot version,
> > and
> > > SCFW versions were used. Reverting this commit fixes the issues.
> > >
> > > For testing purposes, I created the following patch which also fixes
> > > the
> > > issue:
> > >
> > > diff --git a/drivers/pmdomain/imx/scu-pd.c
> > > b/drivers/pmdomain/imx/scu-pd.c index
> > 38f3cdd21042..0477b3fb4991
> > > 100644
> > > --- a/drivers/pmdomain/imx/scu-pd.c
> > > +++ b/drivers/pmdomain/imx/scu-pd.c
> > > @@ -539,6 +539,9 @@ imx_scu_add_pm_domain(struct device
> > *dev, int idx,
> > >                 return NULL;
> > >         }
> > >
> > > +       if (strstr("cm40", sc_pd->name) != NULL)
> > > +               is_off = true;
> > > +
> > >         ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
> > >         if (ret) {
> > >                 dev_warn(dev, "failed to init pd %s rsrc id %d",
> > >
> > >
> > > Test Environment:
> > > - Hardware: Colibri iMX8DX 1GB with Colbiri Evaluation Board.
> > > - U-Boot Version: 2024.04
> > > - U-Boot Build info:
> > > 	SCFW 83624b99, SECO-FW c9de51c0, IMX-MKIMAGE
> > 4622115c, ATF 7c64d4e
> > >
> > > The issue is not present on: v6.5
> > >
> > > The real root cause is still unclear to me. Anybody has any ideas? I
> > > am happy to share more details if needed.
> 
> Have you tried pd_ignore_unused? 
> 
> I think it is linux power down M4 which M4 is running, then SCFW
> reports error. So please give a try pd_ignore_unused.

For debugging purposes, I tried it and it works, kernel boots fine with
M4 running and pd_ignore_unused parameter.

> 
> If this is the case, may I know do you have m4 nodes in dts and
> with power domain included?

This is the device tree overlay I am testing:

/dts-v1/;
/plugin/;

#include <dt-bindings/clock/imx8mm-clock.h>
#include <dt-bindings/firmware/imx/rsrc.h>

/ {
	compatible = "toradex,colibri-imx8x";
};

&{/} {
	imx8x-cm4 {
		compatible = "fsl,imx8qxp-cm4";
		mbox-names = "tx", "rx", "rxdb";
		mboxes = <&lsio_mu5 0 1
			  &lsio_mu5 1 1
			  &lsio_mu5 3 1>;
		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
				<&pd IMX_SC_R_M4_0_MU_1A>;
		fsl,entry-address = <0x34fe0000>;
		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
	};

	reserved-memory {
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		vdev0vring0: memory@90000000 {
			reg = <0 0x90000000 0 0x8000>;
			no-map;
		};

		vdev0vring1: memory@90008000 {
			reg = <0 0x90008000 0 0x8000>;
			no-map;
		};

		vdev1vring0: memory@90010000 {
			reg = <0 0x90010000 0 0x8000>;
			no-map;
		};

		vdev1vring1: memory@90018000 {
			reg = <0 0x90018000 0 0x8000>;
			no-map;
		};

		rsc_table: memory@900ff000 {
			reg = <0 0x900ff000 0 0x1000>;
			no-map;
		};

		vdevbuffer: memory@90400000 {
			compatible = "shared-dma-pool";
			reg = <0 0x90400000 0 0x100000>;
			no-map;
		};
	};
};

&lsio_mu5 {
	status = "okay";
};

This was basically copied from
arch/arm64/boot/dts/freescale/imx8qxp-mek.dts. Do you see anything
wrong? Should I also add the "clocks" property to imx8x-cm4 node?

> 
> Anyway, I will give a try on i.MX8QM EVK.

Great, thanks.

> 
> > 
> > Hello everyone, as this introduced a regression, should I send a revert
> > for 4f6c983261? 
> 
> Please wait a while, I think we need find root cause.
> 
> Thanks,
> Peng.
> 
> Or any ideas that might help fix this issue?
> > 
> > >
> > > Cheers,
> > > Hiago.
> > 
> > Cheers,
> > Hiago.

Cheers,
Hiago.

