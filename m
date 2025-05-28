Return-Path: <linux-pm+bounces-27752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD593AC6F7F
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3801F9E3A16
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA328DB79;
	Wed, 28 May 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q79bKWgq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5528DF04;
	Wed, 28 May 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453902; cv=none; b=lBPssweMbjBGUJzUl54YToanv9zf2uWrXNqOJaA/kT3BtAjB+oc02AUU5IsHoCFfx/jnNgB5HmMYaZRPXGGJbg2RmTZitLFe/8QHY9WguR2wcpd2J3RqGB9Pzbmk0f3i5acb6XfuVQqLDogD0OlPKkLpRHulLy3a3BwvTr5aPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453902; c=relaxed/simple;
	bh=U++dy45I+onFjsonr1vngeU772ZgTI8qI+k6vKRdUN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDPnr+IbNXVjlJ1N1ZtqUH3YQkSYZAGO9zKVfIcTf0QLBwX/OnQ1F6az2WIDPNnU9yswKjCPBullUR42tGcFSB7mKveeLCeNIA+GOJcuLgeXTNj3+j7S3FW2YTueCBWOLmXDnvf/uuxuqGojrEBMFXSjBj2hQl8onrq6P/RwapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q79bKWgq; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87df8fa1c6aso7591241.0;
        Wed, 28 May 2025 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453899; x=1749058699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuU7vghs/Roa4fUMqe76N60+pRs9TTlZ7VpQ6fcHfmM=;
        b=Q79bKWgqa4il3gX8SS1S0AhAWXMViTYQJ3z990oIGERVmMGTC0U5+yUAALBlppv296
         NOXCULWXhlKAb5DnuM8NlRN6aeeb4XHqZAYyHuJtYNfSRT4pLq0PNBJ94WMs30dCRHJQ
         /ZygiUM1O4pAflqaK+QDhepz35VRUJpoV1/cGtpbhSXQDyE5MjHoJR7zdnA8GAMsULj1
         +aPtz+h1z+wdAiD/jDKHjJdZS+Q8P09Io3AnudU/YY/ZmqTwHjazR/Dft8uVUd9KQD0i
         cOPKrn+LAyZ+iLKk82WA7FBLv8wqru3LQYK/jYDFsKQRew4RlbXIOQdtkRyn5MWKcblK
         qHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453899; x=1749058699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuU7vghs/Roa4fUMqe76N60+pRs9TTlZ7VpQ6fcHfmM=;
        b=G1Ux4T8RcTpN0gJo3rtzH1M6xavg1xsRwg66ao9mJLsDB6sVJUgQgnzrpIyaiy/4/d
         r7urco7myPuXJIf/F3/ZsrJRpcBIA2ah1rwQoJKMe/LEqlca/umRnfQEWa/9mD6xHi07
         xyRLbDJ/H/dfZY4trpHtErM8c3+dEG3ZuE0UzYlHyU9f9jywYcJD6bJ566yzqdB3pgb0
         wwBAleC0jT14LvJkP3jy/a5vU1tYB70JKB2S73JCX5+mMnHMDwMmYbdikbY87+2+sUnV
         hQhxM4srvg2bak8nP0SJJYFkD31rfuZVol+NYKhI0chaF8CuwOveG9u6d+quKKfE5y2S
         itAw==
X-Forwarded-Encrypted: i=1; AJvYcCUD9aDr3OK83mU9awEPb1sSQOr0vnajVJaMQMQ6SDc+bA38lD9lX8ue7xvrrh5BWWdo2GorvIYWcWetX8c=@vger.kernel.org, AJvYcCW4cseKNtXmjMDGmgJxffCQ1qTXnmEKmAsXTI1SFEq9nDs6xm2yc3q75ZRtpxOzMekaoaMBiv03EZo=@vger.kernel.org, AJvYcCWyQind8k6GM57JlPInuVJrEccs8rvkO/O7bIK8S7IcirXtGAgqjwNbfH0LTsxqmzBhuMOnwiTGvjAAGg+vJn6Yxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwanM+o4ozClsPgsheztqNFnJyeFV+FZA6TUmWd0Inea/qHhA8O
	d2VTqX4HiNQxOGTL/THu/K2RqXo2o1Saoj3xbsgVPYZ9zXckA5Rq+Axj
X-Gm-Gg: ASbGncs4qgzJwg5Aw5eY1NEAhtXCBnC5mJ4ahYtf/ACwoRc/yp6G7tT7mCZuiWlBcU2
	xs/YwF5jW2nG0wmtzJhRfzWOZSSy6hmhgXD5bRSst2ZuKEogQp6PlUi6SaDvdlASK/8igOfHyfe
	wsoaFOTpdoRx/9DfowHZaaw61dfgCavuBpTzZ/M0pQdf09kR3rxFYQ0pok7HbCys/1IYZ4/xp2B
	ZGrCPOukPl9jJ3GTJEt0P802FZrjixebfe+uGfGec7eYvUwalid46yhwPNpc63x1Yrt98MSsydd
	ikErl4QwhKNJe6V70Z3oYFpPlK1YzPF/2pd0Mvo5lKClma68vKX3ckNTuxNz
X-Google-Smtp-Source: AGHT+IH0yWuJoUrC0OxGQWzTqljadyq7cuFUTOFbkQW4fn/ETHGhWue+swzwXlHVyYeAv2NimJNc6A==
X-Received: by 2002:a05:6122:4286:b0:523:dd87:fe95 with SMTP id 71dfb90a1353d-52f2c5919c0mr15157933e0c.9.1748453899161;
        Wed, 28 May 2025 10:38:19 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53066973c62sm1439097e0c.44.2025.05.28.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:38:18 -0700 (PDT)
Date: Wed, 28 May 2025 14:38:13 -0300
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
Message-ID: <20250528173813.rxqu6pzqgu4m5joo@hiago-nb>
References: <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
 <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
 <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
 <20250527000510.fofehmsdhifcwlys@hiago-nb>
 <20250527023921.GA14252@nxa18884-linux>
 <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>
 <20250527134525.f7yzs4ww64xxmjmr@hiago-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527134525.f7yzs4ww64xxmjmr@hiago-nb>

On Tue, May 27, 2025 at 10:45:25AM -0300, Hiago De Franco wrote:

[...]

> > 
> > Thanks for the detailed analysis!
> > 
> > This is a very similar issue as many other genpd providers are
> > suffering from - and something that I have been working on recently to
> > fix.
> > 
> > A few days ago I posted a new version of a series [1], which is based
> > upon using the fw_devlink and ->sync_state() support. In principle, we
> > need to prevent genpd from power-off a PM domain if it was powered-on
> > during boot , until all the consumer-drivers of a PM domain have been
> > probed.
> > 
> > I had a look at the DT description of how imx describes power-domain
> > providers/consumers, along with the corresponding genpd provider
> > implementation in drivers/pmdomain/imx/scu-pd.c. Unless I missed
> > something, I think [1] should do the trick for you, without any
> > further changes. Can you please give it a try and see if that solves
> > this problem?
> 
> Cool! I can give a try and provide an answer soon. Thanks!

We are making progress ;-)

With the patches you shared Ulf (I added them on top of the current
master branch), it works as expected, dev_pm_genpd_is_on() returns 0
when I boot the kernel without M4 running and it returns 1 when I boot
the kernel with M4 running with a hello-world demo.

However now I tried to, if dev_pm_genpd_is_on() returns 1, put the
DETACHED state, something as

if (dev_pm_genpd_is_on(priv->pd_list->pd_devs[0]))
	priv->rproc->state = RPROC_DETACHED;

In this case I used 0 because I understand this is the
IMX_SC_R_M4_0_PID0 defined in my device tree overlay:

		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
				<&pd IMX_SC_R_M4_0_MU_1A>;

But in this case, the kernel does not boot anymore, I see the "Starting
kernel..." and nothing else.

I am using the pm_runtime functions before rproc_add():

@@ -1146,6 +1154,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
                }
        }

+       pm_runtime_enable(dev);
+       pm_runtime_get_sync(dev);
+
        ret = rproc_add(rproc);
        if (ret) {
                dev_err(dev, "rproc_add failed\n");

and calling dev_pm_genpd_is_on() after dev_pm_domain_attach_list() has
been called.

With kernel not starting I cannot even debug it. Do you have any
suggestion on why this might be happening?

> 
> > 
> > [...]
> > 
> > Kind regards
> > Uffe
> > 
> > [1]
> > https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> 
> Best regards,
> Hiago
 
Best regards,
Hiago

