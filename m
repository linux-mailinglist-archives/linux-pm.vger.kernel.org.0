Return-Path: <linux-pm+bounces-28561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD8AD789E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A451892DA8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACCE298CA3;
	Thu, 12 Jun 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxUEcOI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498773596B;
	Thu, 12 Jun 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747805; cv=none; b=uxs4dDfTtDycGDEgFlargSsa5xsTyx4uXaqMSAnZArAinyLYL+R0IKCoc2Vzp95vOdaj3WwnUJiweYGMIHj8gI01yBtS0JxjvHlLfNd5OANBOlkMftcqyw0Q0oOT9sTs9mIqUas7IzfZaRcH/O54tu7wvC4xv2hQf7mUeOiB+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747805; c=relaxed/simple;
	bh=ifdQDvjlJvxreY4OA2GLiBZqAStcb/FFjKUWkBMQwXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih4bSiXxPLujmlZ1hSwh4ZVOyY6fH2w1JzN0NTU+yJhbuwkrsP7kb2rUOy5//OGL7WhAu4zK5wIC+hOyoZIBYlUip6O7ZN32g/Rg4nIEfz2Nt9rjEwTmhJIm7zuiK79a9/MB+eoVS1WXZkempfEsG9J89y+w7YD9v97shTDWndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxUEcOI1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so819297a12.3;
        Thu, 12 Jun 2025 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749747803; x=1750352603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObgREgS2LbREVTVWt2meuQSNcQMFkiPDU2dHRlXpVkM=;
        b=XxUEcOI19zGx2I5j3yr1Ob/0XX4Ss4r9Lc+mtYgwkdgikeKK1N0CEoFq1CRh9VsdQA
         XsPqWTaz8vJxVae3gJz1IMsfa6QBkaBjROkc/AswyPJ+uZVhgwL8eHCp6CUmsOxUVALL
         NX6sATToMIloxgwoZ3hj9UbGCGiR2yeDB1BjSU+Fu/pc2Evqa56Hxwfxkmr7YytzrhRp
         J4qEcLpuAxJ4bbFnobhMV88qO2U5a6gzi6sOuvUyVg3j6120iGs97SDfrxrMknjW0HG9
         6op6K3pn9UWen/aULBR+oW7ZI4WGt+LgdwGTu2jnouOWPmrhEZsI/hQ13uvWXh+BmckD
         fhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747803; x=1750352603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObgREgS2LbREVTVWt2meuQSNcQMFkiPDU2dHRlXpVkM=;
        b=EWoafWGG7fEPyDVjVmJTq/JyCt3io+ILvUvYqA4ZsaqvWNN3JNi80J/uFqV/eISN01
         Jvoo72Nt1sN1/mxDj5nRR+F/WqdDUT8Bk8+mX/wy8V5U4XRLhazUGjOe8uonaP5cNJfb
         tIosGfPm05rrLkZ3Elx2ZgzXyFp/vFoDM2elvXZAiX6Ga3vENGRRedhB1BvN0v2yGg1H
         yM8xTeHoWmzcTnlOmLg5gY/2R/sVeUyIooFM7//MlAKmvDX4vq1BT5gdtLnbby9t4uml
         9VJ/rs9A04kVdPGYUhUkVnOeniCychJFYXiZlm2pF4WSQ+6YDwuH0RsYYfCOtiKYWEvX
         6YwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBXpwDiCEWoWNnMvplFtRal3ac/awbVU04Gq8djOWvVwG0ys/z3HuU9ClJohy6v41pbtU8EfwIUPC7pAL2SRd5sQ==@vger.kernel.org, AJvYcCVHBcZzTpvin8nIhqa9iRfvNmCdFHhMWwAcx8TRZ4nal660Xovy+edMjid2wFpCBvLsBGSy6GtkspM=@vger.kernel.org, AJvYcCXgYy3TxOljtVeTi8i6qseoe/5cUMjcONfTubMCkdyolhi/4BSDdmCECsTJNK2ESw7TNETZLwfS4AG+rfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUbG7dkTInTW37FtiQDB0XqW/NWNs7p/Gn1z9+HPbmblhh0Ut
	PXo84AXofaJ1hg+Vtvh6stMiZyjCdRAPS9xrxdzH27LJpC9+nwhomtiY
X-Gm-Gg: ASbGncsLgwBSteh4MK/16A7alfcJ7y0nYNfq/vTsBwHaHyST1IQtCIX8ONeBN6a0Oh8
	VAhSzxKhA0v4ic2CAL1vZB5B33BocbgKuzwZweREpyXtHWUpauA7OZfSC9fCxsvlDjYu496muVz
	a0VdnY6aCZU8mPTVbPvtWuhuX4/Srb3z8zxLCtqWg8BhHgiSY+Fh9XilxQmbr9XqEAknvn2B7co
	v4B5BI4XANp0P7Q8V1bPgbrYqygWnGsiCN8bKHN8AD4QPkVjQdJUbM7/XVDybvwYWAGLjiZUjvq
	ORKD9hhRdxUK/fQmEvVW9FPe2NNNKbVDBJa7NmD6XFUFCq3oA3KjdyV/27CY
X-Google-Smtp-Source: AGHT+IF54y3q62NL+kS/gD45o5e+WyN4FsAe5RdZjZEeztChTbyzYm/Srld6U8FosLrer/YeMYeZ3w==
X-Received: by 2002:a05:6a21:998a:b0:1f5:5a0b:4768 with SMTP id adf61e73a8af0-21faa58c2c6mr352397637.21.1749747803298;
        Thu, 12 Jun 2025 10:03:23 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd613fee4sm1647097a12.26.2025.06.12.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:03:22 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:03:17 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <20250612170317.k3cok3utmiy5ptq3@hiago-nb>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250609173115.qecc2noswkcgr3hm@hiago-nb>
 <PAXPR04MB8459F651D1D0AC8C51F292A48875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459F651D1D0AC8C51F292A48875A@PAXPR04MB8459.eurprd04.prod.outlook.com>

Hi Peng,

On Wed, Jun 11, 2025 at 03:27:09AM +0000, Peng Fan wrote:
> > 
> > Sorry for the delay.
> > 
> > I tested it now and there must be something missing on my U-Boot:
> > 
> > Disable imx8x-cm4 rsrc 278 not owned
> > Disable imx8x-cm4 rsrc 297 not owned
> > 
> > It removes my nodes from the DT before starting the kernel, so I cannot
> > attach. Do you know what should I do in this case?
> 
> In separate partition case, UBoot will check the permission
> by checking the rsrc-id, saying power domain id.
> 
> You may need to remove the power-domains property
> from M4 node.

Without the power-domains property, rproc gives me a kernel panic:

[    1.253234] remoteproc remoteproc0: imx-rproc is available
[    1.258501] remoteproc remoteproc0: attaching to imx-rproc
[    1.263950] Unable to handle kernel paging request at virtual address ffff80005ae57d39
[    1.271812] Mem abort info:
[    1.274575]   ESR = 0x0000000096000005
[    1.278299]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.282581] mmc0: SDHCI controller on 5b010000.mmc [5b010000.mmc] using ADMA
[    1.283607]   SET = 0, FnV = 0
[    1.293701]   EA = 0, S1PTW = 0
[    1.296815]   FSC = 0x05: level 1 translation fault
[    1.301699] Data abort info:
[    1.304545]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    1.310079]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.315073]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.320367] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000096bf3000
[    1.327061] [ffff80005ae57d39] pgd=0000000000000000, p4d=1000000097085003, pud=0000000000000000
[    1.335750] Internal error: Oops: 0000000096000005 [#1]  SMP
[    1.341373] Modules linked in:
[    1.344414] CPU: 3 UID: 0 PID: 47 Comm: kworker/u16:3 Not tainted 6.16.0-rc1-00024-gfe5d6ab20714-dirty
 #857 PREEMPT
[    1.354932] Hardware name: Toradex Colibri iMX8QXP on Colibri Evaluation Board V3 (DT)
[    1.362837] Workqueue: events_unbound deferred_probe_work_func
[    1.368651] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.375601] pc : rproc_handle_resources.constprop.0+0x78/0x1d0
[    1.381421] lr : rproc_boot+0x368/0x578
[    1.385242] sp : ffff8000819f3990
[    1.388542] x29: ffff8000819f3990 x28: ffff80005ae57d3d x27: 0000000000000000
[    1.395671] x26: 0000000000000000 x25: ffff0000016ee038 x24: ffff800080f3c680
[    1.402793] x23: ffff8000813d6da8 x22: 00000000d999ad39 x21: ffff0000016ee000
[    1.409917] x20: 00000000266656c3 x19: ffff80005ae57d39 x18: 0000000000000006
[    1.417040] x17: ffff000002020600 x16: ffff000002020000 x15: 4addd15cca11c529
[    1.424164] x14: 73ebceed5d6cd787 x13: 4addd15cca11c529 x12: 73ebceed5d6cd787
[    1.431288] x11: 95a4e33b6b190664 x10: 9e3cdabdb09ca345 x9 : ab3734eafdd6fd1c
[    1.438412] x8 : d58a055de4cfb385 x7 : de97fab1791acbbe x6 : 9946d97107d0dcda
[    1.445535] x5 : ffff0000032b2c00 x4 : 00000000000003fc x3 : ffff0000032b2b80
[    1.452659] x2 : fffffffffffffff0 x1 : ffff8000814bd000 x0 : ffff8000814bd000
[    1.459786] Call trace:
[    1.462215]  rproc_handle_resources.constprop.0+0x78/0x1d0 (P)
[    1.468036]  rproc_boot+0x368/0x578
[    1.471510]  rproc_add+0x180/0x18c
[    1.474898]  imx_rproc_probe+0x3e4/0x540
[    1.475274] mmc0: new HS400 MMC card at address 0001
[    1.478799]  platform_probe+0x68/0xc0
[    1.484628] mmcblk0: mmc0:0001 Q2J55L 7.09 GiB
[    1.487400]  really_probe+0xc0/0x38c
[    1.487412]  __driver_probe_device+0x7c/0x15c
[    1.487424]  driver_probe_device+0x3c/0x10c
[    1.493941]  mmcblk0: p1 p2
[    1.495392]  __device_attach_driver+0xbc/0x158
[    1.495405]  bus_for_each_drv+0x84/0xe0
[    1.495417]  __device_attach+0x9c/0x1ac
[    1.500468] mmcblk0boot0: mmc0:0001 Q2J55L 16.0 MiB
[    1.503906]  device_initial_probe+0x14/0x20
[    1.503918]  bus_probe_device+0xac/0xb0
[    1.503929]  deferred_probe_work_func+0x9c/0xec
[    1.509863] mmcblk0boot1: mmc0:0001 Q2J55L 16.0 MiB
[    1.511117]  process_one_work+0x14c/0x28c
[    1.511132]  worker_thread+0x2cc/0x3d4
[    1.511142]  kthread+0x12c/0x208
[    1.511157]  ret_from_fork+0x10/0x20
[    1.517964] mmcblk0rpmb: mmc0:0001 Q2J55L 4.00 MiB, chardev (241:0)
[    1.518770] Code: 8b36c033 9100127c 54000924 d503201f (b9400261)
[    1.518777] ---[ end trace 0000000000000000 ]---

Currently I have the M4 partiton defined into the SCU code:

            /* Create partition */
            BRD_ERR(rm_partition_create(pt_boot, &pt_m4_0, SC_FALSE,
                SC_TRUE, SC_FALSE, SC_TRUE, SC_FALSE, SC_R_M4_0_PID0,
                rsrc_list, ARRAY_SIZE(rsrc_list),
                pad_list, ARRAY_SIZE(pad_list),
                NULL, 0));

            /* Name partition for debug */
            PARTITION_NAME(pt_m4_0, "MCU0");
            
            /* Allow AP to use SYSTEM (not production!) */
            BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_SYSTEM,
                pt_boot, SC_RM_PERM_SEC_RW));

            /* Move M4 0 TCM */
            BRD_ERR(rm_find_memreg(pt_boot, &mr, 0x034FE0000ULL,
                0x034FE0000ULL));
            BRD_ERR(rm_assign_memreg(pt_boot, pt_m4_0, mr));

            /* Move partition to be owned by SC */
            BRD_ERR(rm_set_parent(pt_boot, pt_m4_0, SC_PT));

            /* Check if booting with the no_ap flag set */
            if (no_ap != SC_FALSE)
            {
                /* Move boot to be owned by M4 0 for Android Automotive */
                BRD_ERR(rm_set_parent(SC_PT, pt_boot, pt_m4_0));
            }
        }

        /* Allow all to access the SEMA42s */
        BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_M4_0_SEMA42,
            SC_RM_PT_ALL, SC_RM_PERM_FULL));

I believe this SCU code is correct, at least this is more or less what
NXP provides as example, right?

Best Regards,
Hiago.

