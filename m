Return-Path: <linux-pm+bounces-25579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0FA90E16
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 23:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD91893C1D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56FA23534A;
	Wed, 16 Apr 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQP0PR3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD691DA634;
	Wed, 16 Apr 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840671; cv=none; b=DR8kfhUxVDBHJUMs5xgvfgPuZdRazN8OYqfSkfqSg9wNa7QdZKPtaeMptYH6l7QdE67rLfDB87fuLqCBx/GacKgKV+tnWyKW0kgJY5zTZvxmHrDkZt7KVHNZzmxJ0F4wtVH7EArNMzSu69jKxXrm7JHpWgVs2HGbUja6YFyuAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840671; c=relaxed/simple;
	bh=k/KjdMxDIosGCWP+mkbra1QY06uhnandvQrkpwhlWAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4qtGutAB7HrIx+Xswao2L/xbsev8XazsdD+RzvHvQcCnuQLl8QSHgSMIr/6n+BmkWLzHABEes1RyIItivowt54y1X93y5q0Mmot/5b0KyrD5pbvux4YF/L5kZg+yzYYw0MOL7FiBCluNXZDSbnAatfNBUsLcS32um1YrGbgI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQP0PR3v; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso64059a91.1;
        Wed, 16 Apr 2025 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744840669; x=1745445469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TYUCN/1UNTxn2CDVHf8q4W13nzMO2FOJwS1tEoC09w=;
        b=UQP0PR3v+Q8g5RKPCLcAxZ7mBFMwRdvKsV4UL15tQpjIQ+TfnPVnF1jlfBU6R0udus
         riSY/EfgyNSA8pjpYjTVTH9U89f3Tzj5DWyBQfzwyDFQAjecvtkbhHmv/spsCSyRfrXW
         tBfy5Ux8IisH7TEZBXTU/UX5N3c36b+1RwjgeCyH6ZdVreBVqzxW/IVdp7AKocaoRivn
         uWhYHUh69Kkuf2vQWmB/pNjLDMtUcultkf7L/KgZjH2qDJ4veAXwGkagsRkiyQIDT0lS
         3w2KyDzUqddgTtFQZ1G3P8n19PkQPNye8W+QgBD2kdOX5SYcxUq4eZMuvI691tKxbeFq
         Wzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840669; x=1745445469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TYUCN/1UNTxn2CDVHf8q4W13nzMO2FOJwS1tEoC09w=;
        b=mqaLmv+5GKEj9GUsRRStpk4MDSAXUGB3H5IVodBkW81D0963WGGrcc6aTU7+BgR21k
         6RPbi7sMbyZJDIc9WwcQl7qh/dPrsyB18gggNT/fQp9isILmYSdhCaZtxQiAWP8WIMLK
         lTUdIePeT7yizsVdDKGz3ZmN0GdPuJlkTqTnjmPJIAwZvPrnhJkAVcAy18eQSeaWmBgb
         ulpStmeZD1jXlpUnSozhyJEDk1SExcQ4UYE+aW9MO7gMDuhtOh75+y+22LWpb5Ywp1m+
         OgJmaYL1xdAei97SGAmq5512CQkq3vvDrwBrQC4owEx6l/Oemh7XIfRbIgnwfPOJWYel
         j3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCURIm0bKLwhTJH4voAnvh6WslF8BnYN8FpG7q8BMNehvqSsvbphhPxLVDgKqZ8EHjITXLejeqcFlDg+w2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPob7NQ1bq1up/WeFjGe2V+Q5f1DeK0i0z75Pdk4BXXPfx2jCB
	FhJ4725GPn0qk6QzD3oubVwKu6wOBYlizTiKznmDi45lbo/z7OiH
X-Gm-Gg: ASbGncvC2TyXk+ELAMGumfXbsMsJOuXCJsaOHqUVg1uE7ha5tDRQvlEf1PVAqQoOwiT
	JBEoHWDjTxPdJzxctkIrHD/CGF2zg3iu//jZaoSfs/GvP8ws+4N+zsy6+nIzbraQ/I9Iqv9xJMB
	Yy1q2U7CXUSL/uRmffzopq/TXzu6+MDe8srx4hX4rMthWrpZw6J2HKPkydRXoA23T8Y3rw0l0bM
	POz0S4BZbVOWK24fPnttOogrEsHBswGU84GfdGEjTW+a9NG99xmpgZyqyYbusfblyuL52i774kj
	Cidml2Pum6BLvc2c/O0Glg/VUHzwTwX+NdiU0F3B
X-Google-Smtp-Source: AGHT+IHeFrgYzvolcRtmLtJYy34iMTe1Y9dhFNFAshuXgx77OGVRADxm1VTMFgvhCLlij4fo6kuyHw==
X-Received: by 2002:a17:90b:520a:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-30864178e74mr4413005a91.34.1744840669544;
        Wed, 16 Apr 2025 14:57:49 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:41c8:a4c9:4211:d618])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3085458154esm2640914a91.1.2025.04.16.14.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:57:48 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:44 -0300
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
Message-ID: <20250416215744.6c57a3oqgt6zkeew@hiago-nb>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250414224452.gk4ccniqtumfbjth@hiago-nb>
 <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250415184009.2fvtn7tbe6uzwiyg@hiago-nb>
 <PAXPR04MB84596E1E47CDE57ADCE9B40F88BD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84596E1E47CDE57ADCE9B40F88BD2@PAXPR04MB8459.eurprd04.prod.outlook.com>

Hi Peng,

On Wed, Apr 16, 2025 at 08:19:27AM +0000, Peng Fan wrote:
> > Got it, I was able to make it work with the downstream pingpong
> > driver and the MCUXpresso demo. I can launch the firmware using the
> > remoteproc and exchange data between the two cores.
> >
> > There is something I noticed, when I start the pingpong demo with U-
> > Boot, it does not work. I run the pingpong modprobe on Linux but the
> > name service is never annouced. It only works if I start with the
> > remoteproc on Linux, not U-Boot. Is this because of Linux not being
> > able to control the M4?
>
> No. In you case, you could start using remoteproc, that means
> Linux could control M4.
>
> >
> > If I start the binary using U-Boot, the "state" always report as "offline"
> > by the remoteproc driver.
>
> In drivers/remoteproc/imx_rproc.c,  imx_rproc_detect_mode
> case IMX_RPROC_SCU_API is used for detect mode of M4 for i.MX8Q/X
> platform. Please give a look where it returns.
>
> For U-Boot start m4, linux should remote state: "attached"

Ok, in this case looks its does not work. I start the firmware with
U-Boot and state is always "offline". Inside the IMX_RPROC_SCU_API case,
the function returns at this point:

		...
		/*
		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
		 * and Linux could only do IPC with Mcore and nothing else.
		 */
		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
				return -EINVAL;

			return imx_rproc_attach_pd(priv); // <-- Returns here
		...

And this function, imx_rproc_attach_pd, returns 0 at the end:

	...
	return 0; // <-- Returns here at the end

detach_pd:
	while (--i >= 0) {
	...

So looks like in this case the partition is *not* owned by the A core,
it is still being owned by the Mcore and I can not attach.

For debugging purposes, I did the following patch, inverting the logic:

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 592a34cfa75e..2fcc9086e916 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1072,7 +1072,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
                 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
                 * and Linux could only do IPC with Mcore and nothing else.
                 */
-               if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
+               if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
                        if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
                                return -EINVAL;

And now the remoteproc driver attaches to the MCore succesfully, which
is exactly what I want. However less than one second later the kernel
reboot with the "SCFW fault reset" again.

Do you know what could be the issue in this case? Maybe the partitions are
not yet correct?

>
> Regards,
> Peng.

Cheers,
Hiago.

