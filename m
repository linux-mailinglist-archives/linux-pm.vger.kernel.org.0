Return-Path: <linux-pm+bounces-27819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF4AC8323
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF88A40663
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2622FE0D;
	Thu, 29 May 2025 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D12ZSjbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8B22D9E5;
	Thu, 29 May 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549754; cv=none; b=V8nVWZ8jUynIuCeh09yo4C7CQr93Gk4CWyoLUo3FPCe683hI9wQcAnQKYRGWOqaosS5qTUDTX28pCP/jKYQF7rCS+M2oEocowPOMs8ZnelUY4CeYMP9CM5FiI9kMtnaQql7/6wHX681/nGCgZrz6sTBM+yRGUB9Riso/AJZ0fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549754; c=relaxed/simple;
	bh=WxXg2OJ/R6QQZXtUX/npv0ZuHFj9HzFHD/6d2xxLGwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAOQhTKvSqoCFQyrnDNPC1jr0z9K6F/B7gP2Z51RBjFknKldQmqKjA4Yp1txZe8DpuyD1PVwIDMcDk/WLLWrQOtWpskaIjC2SecE6AMiRh5022PBJL0ISirbj2D07ayZQtuuOc5Uf1U8sMeHiefDpz9y2mWoq6pUW//EHZIHBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D12ZSjbx; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86feb84877aso345662241.3;
        Thu, 29 May 2025 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748549750; x=1749154550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=feoDuyj3wm8ANzQm10okhE/r2LfgWDr6a+GGqveBvZg=;
        b=D12ZSjbxtu+L9uynio7QTEVUvhNf2cteuHWBnNpC6VqNkVZV4Rrq/CynztGiY9cooz
         SlHeX+YanJcz8LeGks6Ss5cEmcHSuPqTMi7Z9AU7bMx1IjZzqfN/N0w/Q7cok/q1JAoC
         sp29xwPJ7W/mxtbE1v48JCYjR+IVwbbTYnl2Y5tDZYTRES5az+kIVISf5G3K11qASQfA
         p9bg6eEfuSD792KufQwC734IhVMplCBBh5l91ohNl5H07T1ccF68D0fcuOdFksf4E0Kr
         w3k29wXd3Z69Bgcf+UpQqurcP6IuKs7IDVPoLThffsNv/xK/P8rKDV+JSxqwyYaT1G6D
         Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549750; x=1749154550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feoDuyj3wm8ANzQm10okhE/r2LfgWDr6a+GGqveBvZg=;
        b=q9B0/BkCKL+VwMw8xfPlwTH/BbPBZQ+dtRCczB7oEU2i5N1CspffwFfecjcFJFZ52E
         tIKh5YxvGPKW8xNVVH4OOG5dTv0DyWkHwG0fhFnCUJ+bzujrmKc9E3DE1e6EZR2y+fPj
         QcaFnYDsRoSxnepmDruigWM/B+NiOOBc6ZCUXIA+k1vm5f66fqVpkzQjg8KwO0S+4Air
         uBsoMFKpoidiJyPxkVZQw80N/snjRk3q+RHIZOL6Hg2R5SHWv5dGZIlGhf0LLyFHc7xz
         wbtXmV4tSxU9BvlPV8eHkyIm8uJeP8fvr67DgQSCA+2SaWLdPBhypClzsOCU8fF2BQBM
         LHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGMwc0L1qDsoxxpd2zNDw4M+gMG9ZFGmPiJCyVx0B80vlQjd1G3xjnasXkgquSg74o+8Gs9/jXaqQ=@vger.kernel.org, AJvYcCUpKzyAvncvtnsOfn8ahvrQnZR1LPYLiY2ZKamu3AVABXFbD1LMCMnOGZCytI++BoiPfNSQlExJBaHoiQI=@vger.kernel.org, AJvYcCXnHGvURlTP4dUfQhTSxZGiRRk+3E15wGPXJmClQSm2zBuaCu9pI/3j6HmAOhQIqqxUXY0NJwXqVcPst1EJ2zinNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxycWUZszMama5JL9r3Bx9FHasxfEp0lQb/0SoLIE0NyoFJWt4F
	8oSsPo3NPPIsRIcqz4JqBtf/WgFKgrZneDF/X1YtzPQ5ES5PPQKRVpEv
X-Gm-Gg: ASbGnctz7cHxncgY8H+msJ1y2Kb6XKPjz1PctXBPnXdb4KBjD46Uij8Buiiv2/u20PV
	pvHUXg/AEzBnnNABeE56rbDMypzrPrRnHxOJ/dIxotDQs0A4LrDj3Awqw/atdv/1yLkmwzvgEAQ
	4itMr6lvzIdirVYmRHAhF7hzSMLYsB9le8QwrxcvqqeU8OBaYKg468X5bptznDbQ975lcuKAdYu
	fST+5fkrc4fLUwVvCM6rJnQ1vtveMvC5q1kQ9wGuHkrQqtA4NKzqv/bm3jF3uxMSMvJ+y+M5D3D
	lVPznBPowGUjwM1JDa/vwaRl+ZaHu8uxPOOjKcXNUv4KlziFjw==
X-Google-Smtp-Source: AGHT+IGwAq3hjktBz6xGfJGBPKp4OnbEDRwsJ/PGkc5U8ZAIJddZqt/FeICNOUoTO2GiAb/IluXZUA==
X-Received: by 2002:a05:6102:441a:b0:4e2:eb32:247c with SMTP id ada2fe7eead31-4e6e40f719dmr1420185137.8.1748549750224;
        Thu, 29 May 2025 13:15:50 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a3b63besm1655803241.30.2025.05.29.13.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 13:15:49 -0700 (PDT)
Date: Thu, 29 May 2025 17:15:44 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250529201544.azoqdrgnlqfxi6mb@hiago-nb>
References: <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
 <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
 <20250527000510.fofehmsdhifcwlys@hiago-nb>
 <20250527023921.GA14252@nxa18884-linux>
 <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>
 <20250527134525.f7yzs4ww64xxmjmr@hiago-nb>
 <20250528173813.rxqu6pzqgu4m5joo@hiago-nb>
 <PAXPR04MB845941FFF347274012A0ECA88866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845941FFF347274012A0ECA88866A@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, May 29, 2025 at 03:54:47AM +0000, Peng Fan wrote:

[...]

> > We are making progress ;-)
> > 
> > With the patches you shared Ulf (I added them on top of the current
> > master branch), it works as expected, dev_pm_genpd_is_on() returns 0
> > when I boot the kernel without M4 running and it returns 1 when I
> > boot the kernel with M4 running with a hello-world demo.
> > 
> > However now I tried to, if dev_pm_genpd_is_on() returns 1, put the
> > DETACHED state, something as
> > 
> > if (dev_pm_genpd_is_on(priv->pd_list->pd_devs[0]))
> > 	priv->rproc->state = RPROC_DETACHED;
> > 
> > In this case I used 0 because I understand this is the
> > IMX_SC_R_M4_0_PID0 defined in my device tree overlay:
> > 
> > 		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
> > 				<&pd IMX_SC_R_M4_0_MU_1A>;
> > 
> > But in this case, the kernel does not boot anymore, I see the "Starting
> > kernel..." and nothing else.
> 
> Please add "earlycon" in bootargs to see where it hangs.

Thanks Peng! I was able to catch the kernel panic yesterday, however I
must say that today I was doing the tests again and the issue is gone.
Sorry, I might have done something wrong yesterday with the tests.
Anyway, here is the log:

[    1.271163] remoteproc remoteproc0: imx-rproc is available
[    1.280296] remoteproc remoteproc0: attaching to imx-rproc
[    1.285756] Unable to handle kernel paging request at virtual address ffff80005ae3dd79
[    1.293624] Mem abort info:
[    1.294655] mmc0: SDHCI controller on 5b010000.mmc [5b010000.mmc] using ADMA
[    1.296386]   ESR = 0x0000000096000005
[    1.307194]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.312473]   SET = 0, FnV = 0
[    1.315566]   EA = 0, S1PTW = 0
[    1.318649]   FSC = 0x05: level 1 translation fault
[    1.323510] Data abort info:
[    1.326370]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    1.331846]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.336882]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.342182] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000096bc1000
[    1.348870] [ffff80005ae3dd79] pgd=0000000000000000, p4d=1000000097054003, pud=0000000000000000
[    1.357565] Internal error: Oops: 0000000096000005 [#1]  SMP
[    1.363198] Modules linked in:
[    1.366236] CPU: 2 UID: 0 PID: 47 Comm: kworker/u16:3 Not tainted 6.15.0-03667-g3f5f09105c40-dirty #826 PREEMPT
[    1.376405] Hardware name: Toradex Colibri iMX8QXP on Colibri Evaluation Board V3 (DT)
[    1.384313] Workqueue: events_unbound deferred_probe_work_func
[    1.390128] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.397076] pc : rproc_handle_resources.constprop.0+0x78/0x1d0
[    1.402896] lr : rproc_boot+0x368/0x56c
[    1.406717] sp : ffff8000819c3990
[    1.410017] x29: ffff8000819c3990 x28: ffff80005ae3dd7d x27: 0000000000000000
[    1.417145] x26: 0000000000000000 x25: ffff0000015ec038 x24: ffff800080f0c0a8
[    1.424268] x23: ffff8000813a6110 x22: 00000000d999ad79 x21: ffff0000015ec000
[    1.431392] x20: 0000000026665683 x19: ffff80005ae3dd79 x18: 0000000000000006
[    1.438516] x17: ffff000001799400 x16: ffff000001798e00 x15: 4addd15cca11c529
[    1.445639] x14: 53ebce6d5564d787 x13: 4addd15cca11c529 x12: 53ebce6d5564d787
[    1.452763] x11: 95a1e33b6b190674 x10: 9e3c9abdb41ca345 x9 : ab17b4eaffd6fd1c
[    1.459887] x8 : d5da055de4cfbb87 x7 : dfd7fa31596acbbc x6 : 9946d97107d0dcca
[    1.467011] x5 : ffff0000010c7800 x4 : 00000000000003fc x3 : ffff0000010c7780
[    1.474134] x2 : fffffffffffffff0 x1 : ffff8000814a3000 x0 : ffff8000814a3000
[    1.481261] Call trace:
[    1.483690]  rproc_handle_resources.constprop.0+0x78/0x1d0 (P)
[    1.487705] mmc0: new HS400 MMC card at address 0001
[    1.489502]  rproc_boot+0x368/0x56c
[    1.495349] mmcblk0: mmc0:0001 Q2J55L 7.09 GiB
[    1.497929]  rproc_add+0x184/0x190
[    1.504356]  mmcblk0: p1 p2
[    1.505747]  imx_rproc_probe+0x458/0x528
[    1.509238] mmcblk0boot0: mmc0:0001 Q2J55L 16.0 MiB
[    1.512437]  platform_probe+0x68/0xc0
[    1.512452]  really_probe+0xc0/0x38c
[    1.520584] mmcblk0boot1: mmc0:0001 Q2J55L 16.0 MiB
[    1.520951]  __driver_probe_device+0x7c/0x15c
[    1.527522] mmcblk0rpmb: mmc0:0001 Q2J55L 4.00 MiB, chardev (242:0)
[    1.529377]  driver_probe_device+0x3c/0x10c
[    1.544263]  __device_attach_driver+0xbc/0x158
[    1.548586]  bus_for_each_drv+0x84/0xe0
[    1.552407]  __device_attach+0x9c/0x1ac
[    1.556231]  device_initial_probe+0x14/0x20
[    1.560401]  bus_probe_device+0xac/0xb0
[    1.564221]  deferred_probe_work_func+0x9c/0xec
[    1.568741]  process_one_work+0x14c/0x28c
[    1.572735]  worker_thread+0x2cc/0x3d4
[    1.576473]  kthread+0x12c/0x208
[    1.579687]  ret_from_fork+0x10/0x20
[    1.583253] Code: 8b36c033 9100127c 54000924 d503201f (b9400261)
[    1.589337] ---[ end trace 0000000000000000 ]---

But again, the issue is not happening anymore ;-) I will keep testing to
see if the issue happens again, but for now is working fine, I can now
attach to the remote processor.

This is the git diff on top of Ulf patches I have been testing:

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6da25e2c81d2..661a6aad40a8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -599,6 +599,23 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
+bool dev_pm_genpd_is_on(struct device *dev)
+{
+        struct generic_pm_domain *genpd;
+        bool is_on;
+
+        genpd = dev_to_genpd_safe(dev);
+        if (!genpd)
+                return false;
+
+        genpd_lock(genpd);
+        is_on = genpd_status_on(genpd);
+        genpd_unlock(genpd);
+
+        return is_on;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_is_on);
+
 /**
  * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
  *
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..9688370f9bb5 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -18,6 +18,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
@@ -891,9 +892,7 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
 {
 	struct device *dev = priv->dev;
 	int ret;
-	struct dev_pm_domain_attach_data pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-	};
+	bool test;
 
 	/*
 	 * If there is only one power-domain entry, the platform driver framework
@@ -902,7 +901,16 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
 	if (dev->pm_domain)
 		return 0;
 
-	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
+	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
+	printk("hfranco: returned pd devs is %d", ret);
+	for (int i = 0; i < ret; i++) {
+		test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
+		printk("hfranco: returned value is %d", test);
+		if (test) {
+			priv->rproc->state = RPROC_DETACHED;
+			break;
+		}
+	}
 	return ret < 0 ? ret : 0;
 }
 
@@ -1146,6 +1154,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 756b842dcd30..16d1fca2a8c5 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -95,6 +95,7 @@ extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
+bool dev_pm_genpd_is_on(struct device *dev);

 int devm_pm_runtime_set_active_enabled(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);

This is the rproc output when bootaux is used:

root@colibri-imx8x-07308754:~# dmesg | grep hfranco
[    0.478475] hfranco: returned pd devs is 2
[    0.478496] hfranco: returned value is 1
root@colibri-imx8x-07308754:~# dmesg | grep rproc
[    0.478797] remoteproc remoteproc0: imx-rproc is available
[    0.478878] remoteproc remoteproc0: attaching to imx-rproc
[    0.478961] remoteproc remoteproc0: remote processor imx-rproc is now attached

I will cleanup everything and try to come up with a patch. Ulf, in this
case, as your patches have not yet been merged, should I wait for them?

Thanks for all the help guys.

> 
> > 
> > I am using the pm_runtime functions before rproc_add():
> > 
> > @@ -1146,6 +1154,9 @@ static int imx_rproc_probe(struct
> > platform_device *pdev)
> >                 }
> >         }
> > 
> > +       pm_runtime_enable(dev);
> > +       pm_runtime_get_sync(dev);
> 
> I think only make this apply for i.MX8QX/8QM/DX, then no
> impact to other patforms.

All right, I will check how to do this. Thanks.

> 
> Regards,
> Peng

Best regards,
Hiago.

