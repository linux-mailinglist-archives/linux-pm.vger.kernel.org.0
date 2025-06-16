Return-Path: <linux-pm+bounces-28835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210FADB61B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F723B659A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D6286404;
	Mon, 16 Jun 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6Nv+BBe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8912283CBD;
	Mon, 16 Jun 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089919; cv=none; b=ML4t6HhyN+SVqK278djJNQ40Rv0ZjDDF+y77iC6SCdxYwbKzaqjKeAhf4hqN/P1ZhFjv5xVLRK1MQ8xy1qHkBbkw0ppbCfo0kq5jbshlYuQF6L2tUZ2ZUdd0NDvDHm98Up3uuzD1xfLKmrCaUl9Mev1SwMpakL8VEYkoWBerbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089919; c=relaxed/simple;
	bh=kmq3p5W505xyNx/+aDoYZ3uon9HLxrXo9zuNaMA9K0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbAahDN3FCzajitR3mF4iuuhez2TepbEd+v7VgUppUX+4/NQyCow18yD0QE1izIriv2l5IJFjXp36eTdk44iq6cV51J4YACSxo+Vqztwe2mNV/2r3L7Di+9i671XJGTew2zQalZ97ZPEsS7gbX4lXryVK/Wi8r2yNtZgdRyXgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6Nv+BBe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so3173559a12.3;
        Mon, 16 Jun 2025 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750089917; x=1750694717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCfgFr2kf9r7h7JVRAfol2Jm2SHhgBwkNBP3fBqtdVg=;
        b=i6Nv+BBe7fLty0JXaQgXb4h56xT+khZHyydMDtM4UTNeKSuZk2VufRSwWjlHsHSYik
         FOM8hxxldim6y4pIw/jFJh/BzKNQ0bZYATeLcHA+1Ya/jcp2Mw+aEB/WEAN4lsr9Voya
         WikqrQhmrn/UpoDoxtNBgBw4dhjHQZTCA/WS0O/vKU/kZJsYxPo5XA1W97nmWH2i+reC
         XvZ9gPVVsb4U9GBeTCDFSj09MNcvI8jryZja7eXDRTCeaT4xwV1iFCdxdlvOn5rhsPiy
         HJDT/53ih4IIMHUkjGbueaFDeCe9mmrKHBIKRorTi3Mot6PR5CEe7gkoI7wDX/+idx3A
         PLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089917; x=1750694717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCfgFr2kf9r7h7JVRAfol2Jm2SHhgBwkNBP3fBqtdVg=;
        b=wqTCF4ZE3wUGbAG7+8gRSRMtt9JhaqOEmESEojsF7IFkh6RMFGZXL/pGJvYF/5a42F
         +aCOoCFwdRISruNgooKIrDx0xLiLWx8CZNHwsp4VJVWLAftt+VtQWGO9f2wYv8MEifdz
         63LMcHp27E+pYMSRHEKaRCaCRWGzgGwKzvatM8IEq6kss3laWb9Nh2egFZKIf2xICHpq
         aBqvsb6FgAEPga72KmmX9SJjq40QdqUVTFc6XpCIiVJSwl8toksCxixb6k3m4xNj7XFh
         KnQPVd9G5mshtebl2rwOSr1cEaQuGSgnIR70bjDX0cCF2d8Y8ozM0SRQ5YZvXICOqJr5
         YaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX1R2132Tc6/TyEJb0IU3gim8NXl+3/82GAT/LBBQIu20oZv8Mbw8bqH62jM9LEpz/FFrm4d+iWwo=@vger.kernel.org, AJvYcCXr+d5z0grkqveLy+SKvFcy3ByTI9zy9tILj5wLj6FI6X2lt8MfgmiSTKVlCpntFdLlmXDyxatFy3DBLVc=@vger.kernel.org, AJvYcCXwld6xBs92JCCkQlcz0x6hIYL8wlm1VqgXAriefCYI/pk7QUvVeTZJoIfYn0MTekXrcwhbc1xl7+og/WoRavtfTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfmqj1jGW3Ob4rX83XRIPeZO1d79YTAYVvUn7RrZt8Jx1gXjh2
	F0xMa4aUvcVEZNyZvEzp/26QqpLg6pS5E6BM0lK4kvp/BXcDlqBUxvCfmSH6nD3Z
X-Gm-Gg: ASbGncvxyoZcK7r56GCElcZ2tLk+TsMcCJ30dDElnvQ4eEthqhrYpUcGeTaSydyufKI
	Gc2ZqjKVbozCa8edhOphK3cRe1RvyR+uYNgk5Jszhzsm4Ypd/5NWU6z3ZqXN5UcT55uBZaa/W7t
	f4mI1infEbYW2P1JENpUIHcS/oSEn2wXqn232JP4ufIgOhmFuRibeGmNASPoz+ldwNd3QY08xON
	uGWK9Sx29ZwyABH3y0bJIdOCo+0L4TRccQkeSAb6j5mh2e3wpnv4qxCe6MT4x6GBsMTxOjiV/HQ
	Gk39Z57fHPPZElG77UuhOwC607ySkVI1LtJILecI7tkXZbgoDuVzPOzNnoZ60AiO/6Qv5vY=
X-Google-Smtp-Source: AGHT+IEBQXhMNhksw0Q8L1zld8OfuDf7GjCQHVbQ8LvJ/iTuW6L+QxChXy/bkOqnwi7dV7sx8AN2eg==
X-Received: by 2002:a05:6a21:998a:b0:218:bbb:c13c with SMTP id adf61e73a8af0-21fbd5dc862mr3713885637.38.1750089916953;
        Mon, 16 Jun 2025 09:05:16 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168c8f7sm5906749a12.65.2025.06.16.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:05:16 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:05:11 -0300
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
Message-ID: <20250616160511.wynya4ezbj6nafkd@hiago-nb>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250609173115.qecc2noswkcgr3hm@hiago-nb>
 <PAXPR04MB8459F651D1D0AC8C51F292A48875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250612170317.k3cok3utmiy5ptq3@hiago-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612170317.k3cok3utmiy5ptq3@hiago-nb>

Hi Peng,

On Thu, Jun 12, 2025 at 02:03:17PM -0300, Hiago De Franco wrote:
> Hi Peng,
> 
> On Wed, Jun 11, 2025 at 03:27:09AM +0000, Peng Fan wrote:
> > > 
> > > Sorry for the delay.
> > > 
> > > I tested it now and there must be something missing on my U-Boot:
> > > 
> > > Disable imx8x-cm4 rsrc 278 not owned
> > > Disable imx8x-cm4 rsrc 297 not owned
> > > 
> > > It removes my nodes from the DT before starting the kernel, so I cannot
> > > attach. Do you know what should I do in this case?
> > 
> > In separate partition case, UBoot will check the permission
> > by checking the rsrc-id, saying power domain id.
> > 
> > You may need to remove the power-domains property
> > from M4 node.
> 
> Without the power-domains property, rproc gives me a kernel panic:
> 
> [    1.253234] remoteproc remoteproc0: imx-rproc is available
> [    1.258501] remoteproc remoteproc0: attaching to imx-rproc
> [    1.263950] Unable to handle kernel paging request at virtual address ffff80005ae57d39
> [    1.271812] Mem abort info:
> [    1.274575]   ESR = 0x0000000096000005
> [    1.278299]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.282581] mmc0: SDHCI controller on 5b010000.mmc [5b010000.mmc] using ADMA
> [    1.283607]   SET = 0, FnV = 0
> [    1.293701]   EA = 0, S1PTW = 0
> [    1.296815]   FSC = 0x05: level 1 translation fault
> [    1.301699] Data abort info:
> [    1.304545]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [    1.310079]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    1.315073]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    1.320367] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000096bf3000
> [    1.327061] [ffff80005ae57d39] pgd=0000000000000000, p4d=1000000097085003, pud=0000000000000000
> [    1.335750] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    1.341373] Modules linked in:
> [    1.344414] CPU: 3 UID: 0 PID: 47 Comm: kworker/u16:3 Not tainted 6.16.0-rc1-00024-gfe5d6ab20714-dirty
>  #857 PREEMPT
> [    1.354932] Hardware name: Toradex Colibri iMX8QXP on Colibri Evaluation Board V3 (DT)
> [    1.362837] Workqueue: events_unbound deferred_probe_work_func
> [    1.368651] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.375601] pc : rproc_handle_resources.constprop.0+0x78/0x1d0
> [    1.381421] lr : rproc_boot+0x368/0x578
> [    1.385242] sp : ffff8000819f3990
> [    1.388542] x29: ffff8000819f3990 x28: ffff80005ae57d3d x27: 0000000000000000
> [    1.395671] x26: 0000000000000000 x25: ffff0000016ee038 x24: ffff800080f3c680
> [    1.402793] x23: ffff8000813d6da8 x22: 00000000d999ad39 x21: ffff0000016ee000
> [    1.409917] x20: 00000000266656c3 x19: ffff80005ae57d39 x18: 0000000000000006
> [    1.417040] x17: ffff000002020600 x16: ffff000002020000 x15: 4addd15cca11c529
> [    1.424164] x14: 73ebceed5d6cd787 x13: 4addd15cca11c529 x12: 73ebceed5d6cd787
> [    1.431288] x11: 95a4e33b6b190664 x10: 9e3cdabdb09ca345 x9 : ab3734eafdd6fd1c
> [    1.438412] x8 : d58a055de4cfb385 x7 : de97fab1791acbbe x6 : 9946d97107d0dcda
> [    1.445535] x5 : ffff0000032b2c00 x4 : 00000000000003fc x3 : ffff0000032b2b80
> [    1.452659] x2 : fffffffffffffff0 x1 : ffff8000814bd000 x0 : ffff8000814bd000
> [    1.459786] Call trace:
> [    1.462215]  rproc_handle_resources.constprop.0+0x78/0x1d0 (P)
> [    1.468036]  rproc_boot+0x368/0x578
> [    1.471510]  rproc_add+0x180/0x18c
> [    1.474898]  imx_rproc_probe+0x3e4/0x540
> [    1.475274] mmc0: new HS400 MMC card at address 0001
> [    1.478799]  platform_probe+0x68/0xc0
> [    1.484628] mmcblk0: mmc0:0001 Q2J55L 7.09 GiB
> [    1.487400]  really_probe+0xc0/0x38c
> [    1.487412]  __driver_probe_device+0x7c/0x15c
> [    1.487424]  driver_probe_device+0x3c/0x10c
> [    1.493941]  mmcblk0: p1 p2
> [    1.495392]  __device_attach_driver+0xbc/0x158
> [    1.495405]  bus_for_each_drv+0x84/0xe0
> [    1.495417]  __device_attach+0x9c/0x1ac
> [    1.500468] mmcblk0boot0: mmc0:0001 Q2J55L 16.0 MiB
> [    1.503906]  device_initial_probe+0x14/0x20
> [    1.503918]  bus_probe_device+0xac/0xb0
> [    1.503929]  deferred_probe_work_func+0x9c/0xec
> [    1.509863] mmcblk0boot1: mmc0:0001 Q2J55L 16.0 MiB
> [    1.511117]  process_one_work+0x14c/0x28c
> [    1.511132]  worker_thread+0x2cc/0x3d4
> [    1.511142]  kthread+0x12c/0x208
> [    1.511157]  ret_from_fork+0x10/0x20
> [    1.517964] mmcblk0rpmb: mmc0:0001 Q2J55L 4.00 MiB, chardev (241:0)
> [    1.518770] Code: 8b36c033 9100127c 54000924 d503201f (b9400261)
> [    1.518777] ---[ end trace 0000000000000000 ]---
> 
> Currently I have the M4 partiton defined into the SCU code:
> 
>             /* Create partition */
>             BRD_ERR(rm_partition_create(pt_boot, &pt_m4_0, SC_FALSE,
>                 SC_TRUE, SC_FALSE, SC_TRUE, SC_FALSE, SC_R_M4_0_PID0,
>                 rsrc_list, ARRAY_SIZE(rsrc_list),
>                 pad_list, ARRAY_SIZE(pad_list),
>                 NULL, 0));
> 
>             /* Name partition for debug */
>             PARTITION_NAME(pt_m4_0, "MCU0");
>             
>             /* Allow AP to use SYSTEM (not production!) */
>             BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_SYSTEM,
>                 pt_boot, SC_RM_PERM_SEC_RW));
> 
>             /* Move M4 0 TCM */
>             BRD_ERR(rm_find_memreg(pt_boot, &mr, 0x034FE0000ULL,
>                 0x034FE0000ULL));
>             BRD_ERR(rm_assign_memreg(pt_boot, pt_m4_0, mr));
> 
>             /* Move partition to be owned by SC */
>             BRD_ERR(rm_set_parent(pt_boot, pt_m4_0, SC_PT));
> 
>             /* Check if booting with the no_ap flag set */
>             if (no_ap != SC_FALSE)
>             {
>                 /* Move boot to be owned by M4 0 for Android Automotive */
>                 BRD_ERR(rm_set_parent(SC_PT, pt_boot, pt_m4_0));
>             }
>         }
> 
>         /* Allow all to access the SEMA42s */
>         BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_M4_0_SEMA42,
>             SC_RM_PT_ALL, SC_RM_PERM_FULL));
> 
> I believe this SCU code is correct, at least this is more or less what
> NXP provides as example, right?

I tested the same SCU code and DTS overlay (removing the power-domains)
with the current master branch of Linux and I got the same kernel panic.
Maybe this part is already broken? Can you also test this on your side
to check if this is currently working?

> 
> Best Regards,
> Hiago.

Best Regards,
Hiago.

