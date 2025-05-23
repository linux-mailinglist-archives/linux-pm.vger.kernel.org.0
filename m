Return-Path: <linux-pm+bounces-27612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074EAC2A53
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A2B9E517D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D621D54D8;
	Fri, 23 May 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kskqep9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A21A23B7;
	Fri, 23 May 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748027843; cv=none; b=CX6ZevUOOoXL3hUnfvzkjBNmc3h8Htub069gwdO9LjB6mk0VRK+Oy6H9vEjlnM+Z98xrzsyrGdElp8mWW+7jzg4pvgAywMSfr0Uplcq8orFdBe1oqfWp+9+y2MwqzbCI47wsevOoZcJNBT8KKyNn/1jtDgLSJOIjv6uGK6hCk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748027843; c=relaxed/simple;
	bh=bFMZT6KPHyJo8o682Akz5XInGdRA7eFxGiUjifeK0QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofMdzHh1AUfOrCclGHsXGMvnYIsLNUdbN0SX/XJ4Oc6dVsuLSnnxJPLkIzFOEjVl/03M0N0GDmzlrcW0nrVON8CpuS3x3FVg3H2+VfiIaJ5LtaE4BXHMnxUGaOllNh1sfqmYScTdkZ8hpoXWw9pi0EmnPnYNyt3hIizQltvgSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kskqep9J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso277508b3a.2;
        Fri, 23 May 2025 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748027840; x=1748632640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhEtoDJFgqNSJbdEuU9qcTn/W9vRw2JPWBizPEbsfUA=;
        b=Kskqep9JHl6u603gUdRv+AXkcM5Odwpd/TafzuX7AqkHO62G9c5C5CtcV23FaP/K+Z
         xLzEHWGjOtI8kENaRD9HCbTuPTnZlYFR1BV9NUNYngXG9xahtFEn8+oWSyOdv+eRA/HU
         Brb+X/jjrr40gy3D3sJgmckplrWbpRcVlle4sC0/TedIitZkKMasw9ysna4dGJdylW3c
         O6wZZovCDM5yScAPos8USc24Rw9mkF9vvQoBpZYHPtwBDJrZzVGBc4PrjI7KWBV5lU3g
         O8YKwz3//kSFvNqKcazfkQ84si5eGoV+99HSoTOhNeP2g4dZBW0LhVwaW+eC8o9TlVWe
         rB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748027840; x=1748632640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhEtoDJFgqNSJbdEuU9qcTn/W9vRw2JPWBizPEbsfUA=;
        b=ByRVCAh8PhpUkNfvH5TLFIZbqiBxLNMm4tvfJtfNq1ssCiylwWxoOMRGsLWEtFn4UC
         PLs6hiRNuAVY5qtMPyQXwiVXtAI96NrRnRqgY48vGpusL8lD9QK520Ch2N4N+Y7Q8PC6
         cL/UjNoWk/VMg2smGmr9PFWoArdxK+PBHOtbVMcf5Z0VdZUyWt/A+eWCGfYlrT3vfnxL
         9xBY0yDRxbIraawe+S36746YOmsxuMI6RhJ9MzhfKej0V9mdSIQ5Nk5PKON1Nx33dUch
         WgsdQwa7AOtqRRwt/PN5IrVlyWxDGgD+btWf6WwBbcbDgMP1VZhXSa2nytSXiv7gT7bf
         Pu8A==
X-Forwarded-Encrypted: i=1; AJvYcCULHSLJD0q8ETflLBku7fW59xiguk4ZvXLAlt/WTWmJD0ydEDtNMNuDNrliG7qDrsL2oapPskssTriQBsDovNgNKA==@vger.kernel.org, AJvYcCVCPVqAaE/fbNrNMjYPmxCHrBJjof/AJPssgYLI0set/Y/xWIhARJfjsKKgJX4XRsY9Gc2hH2uwKjvx3wA=@vger.kernel.org, AJvYcCVcDKU+fLob/x1Hg6NxixoQKf/KjgMmWz1uEfjvazaVT11jSbyPV6HXH+tUENOQYmle/OrTu+c/wG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLstBS2dLGXpbtVftKuHe8T2kG8NbA63kgUNVQ2glcKYN253fU
	K0FRByet1F2am5cI4v5lN8IF/dMdsulbeRo7AAa0UJbsw7uEM3kAjGUE
X-Gm-Gg: ASbGncvTXj3u+uQWKiRnN/1TbMGPLoeOWrEnryq8qVs3yV0Fw9//gso5gva/jdW6s4n
	RQIX96Yed1JShWePmv6YKHuDKuGtGwF+3ECRpHace3Tpw3agNfThf4f9f2WAVGQ3QDgvjLEOEDh
	dKjY2RWviy7tNOyTGCAtDO6558cfG0Dbzuj7fcWDPZQjj9yphrWxw1K2dCCG6vf80BYP9nnl3J1
	3pdQ8VByhGfE/N683RX8G18gSNxtz7++K9Zf9fkMNiEqwbVXjqJCrroqzm41Z2Wdz9n9TxOlygG
	XkISBjrw2kbyTP0IKYbeWbczMM26GB1c9RMMcUe+pKRTzQrQAA==
X-Google-Smtp-Source: AGHT+IEy3i3+lFOy6NK8IpvlSKcpSA+dK81IKK+t2Fb56IqXUml/sv8htV/OjA+M+GMx2IQe7GLtuQ==
X-Received: by 2002:a05:6a21:7702:b0:218:bbb:c13d with SMTP id adf61e73a8af0-2188c2678b1mr659033637.13.1748027839737;
        Fri, 23 May 2025 12:17:19 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e5867sm13118261b3a.1.2025.05.23.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 12:17:18 -0700 (PDT)
Date: Fri, 23 May 2025 16:17:13 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
References: <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
 <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb>
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
 <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>

Hi Ulf,

On Wed, May 21, 2025 at 02:11:02PM +0200, Ulf Hansson wrote:
> You should not provide any flag (or attach_data to
> dev_pm_domain_attach_list()) at all. In other words just call
> dev_pm_domain_attach_list(dev, NULL, &priv->pd_list), similar to how
> drivers/remoteproc/imx_dsp_rproc.c does it.
> 
> In this way, the device_link is created by making the platform->dev
> the consumer and by keeping the supplier-devices (corresponding to the
> genpds) in RPM_SUSPENDED state.
> 
> The PM domains (genpds) are then left in their current state, which
> should allow us to call dev_pm_genpd_is_on() for the corresponding
> supplier-devices, to figure out whether the bootloader turned them on
> or not, I think.
> 
> Moreover, to make sure the genpds are turned on when needed, we also
> need to call pm_runtime_enable(platform->dev) and
> pm_runtime_get_sync(platform->dev). The easiest approach is probably
> to do that during ->probe() - and then as an improvement on top you
> may want to implement more fine-grained support for runtime PM.
> 
> [...]
> 
> Kind regards
> Uffe

I did some tests here and I might be missing something. I used the
dev_pm_genpd_is_on() inside imx_rproc.c with the following changes:

@@ -902,7 +902,12 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
        if (dev->pm_domain)
                return 0;

        ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
+       printk("hfranco: returned pd devs is %d", ret);
+       for (int i = 0; i < ret; i++) {
+               test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
+               printk("hfranco: returned value is %d", test);
+       }
        return ret < 0 ? ret : 0;
 }

This was a quick test to check the returned value, and it always return
1 for both pds, even if I did not boot the remote core.

So I was wondering if it was because of PD_FLAG_DEV_LINK_ON, I removed
it and passed NULL to dev_pm_domain_attach_list(). Booting the kernel
now it correctly reports 0 for both pds, however when I start the
remote core with a hello world firmware and boot the kernel, the CPU
resets with a fault reset ("Reset cause: SCFW fault reset").

I added both pm functions to probe, just to test:

@@ -1152,6 +1158,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
                goto err_put_clk;
        }

+       pm_runtime_enable(dev);
+       pm_runtime_get_sync(dev);
+
        return 0

Now the kernel boot with the remote core running, but it still returns
0 from dev_pm_genpd_is_on(). So basically now it always returns 0, with
or without the remote core running.

I tried to move pm_runtime_get_sync() to .prepare function but it make
the kernel not boot anymore (with the SCU fault reset).

Do you have any suggestions? Am I doing something wrong with these PDs?

Best regards,
Hiago.

