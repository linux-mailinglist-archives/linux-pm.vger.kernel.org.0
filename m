Return-Path: <linux-pm+bounces-43630-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EPnDau1qGmJwgAAu9opvQ
	(envelope-from <linux-pm+bounces-43630-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 23:43:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8D208BD6
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFF01300C36B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1539A062;
	Wed,  4 Mar 2026 22:43:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7E38F654
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664229; cv=none; b=ec0DNGShQ18HPszJ7TfWM2Eok7VC1wLx1Tlf856HROX0GkUlb0UeZ1QhiZUT/vY8pTuUQgmFtO7wbgzDS6vOUzWTeTfSWmJmrj7H5zytcpaij7Um8KUvOi5hWyFOwzlPjkJl66QI3OPlwG8ryUOEl2rx/jDpMjxKuijjCOOpsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664229; c=relaxed/simple;
	bh=HpFjgJqjXvrWPtsCwNxzcY/RDjTdvqu3hgXzsPJTUsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1WrK3ijPDcqnI8yzmP5KEVLjxQGm7klNYzWwCaCf/UiqCdaCagI2m3b/6ZQmmHLGoRF+el2CZ87GbqS0BIaAMAdSbxNYfvXD6trpNpI8xXWWNKY7bScTes6kuyp0qACjx1239L6l14jkefXgNZJQhhegRYJNVQjzIDHiWGYR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxuw5-0005U1-JJ; Wed, 04 Mar 2026 23:43:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxuw3-003mmA-1A;
	Wed, 04 Mar 2026 23:43:20 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxuw4-00000000XUD-2P6S;
	Wed, 04 Mar 2026 23:43:20 +0100
Date: Wed, 4 Mar 2026 23:43:20 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, ulf.hansson@linaro.org, 
	benjamin.gaignard@collabora.com, kernel@pengutronix.de, sebastian.fricke@collabora.com, 
	linux-pm@vger.kernel.org, festevam@gmail.com, s.hauer@pengutronix.de, Frank.li@nxp.com, 
	peng.fan@nxp.com, nicolas@ndufresne.ca, regressions@lists.linux.dev, 
	eagle.zhou@nxp.com, linux-imx@nxp.com, p.zabel@pengutronix.de, 
	hverkuil-cisco@xs4all.nl, mchehab@kernel.org, shawnguo@kernel.org, 
	linux-kernel@vger.kernel.org, l.stach@pengutronix.de
Subject: Re: [REGRESSION] boot failure on imx8mp due to e0203ddf9af7
Message-ID: <fcsge66ba6toath5g3t2yw6vxqqldn7utxq3ekrfecfuwgzjrg@ftbzb6xvarcr>
References: <n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Rspamd-Queue-Id: 34F8D208BD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43630-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.nxp.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linaro.org,collabora.com,pengutronix.de,gmail.com,nxp.com,ndufresne.ca,xs4all.nl,kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.399];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Franz,

On 26-03-04, Franz Schnyder wrote:
> Hello,
> 
> Our iMX8MP SoMs (Verdin and Toradex SMARC) fail to boot after 
> commit e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC").
> On rare occasions, it's still able to boot.
> It fails after having registered g1 VPU, probably when it tries to
> register g2 VPU.
> 
> Ming: Any ideas on how to proceed here?
> 
> Success::
> [    9.040517] hantro-vpu 38300000.video-codec: registered nxp,imx8mm-vpu-g1-dec as /dev/video0
> [    9.052133] hantro-vpu 38310000.video-codec: registered nxp,imx8mq-vpu-g2-dec as /dev/video1
> 
> 
> Failure with decoded stacktrace::
> 
> [    9.004477] hantro-vpu 38300000.video-codec: registered nxp,imx8mm-vpu-g1-dec as /dev/video0
> [    9.027097] Unable to handle kernel paging request at virtual address ffffd9c18eb05000

This is quite a nasty bug you triggered here! I think the issue is that
the newly added imx8mq_vpu_shared_resources[] is of type __initconst
where as it should be __initconst_or_module. You can test this
assumption if you switch from a module [M] build for the hantro_vpu
driver to a builtin [x] build.

Regards,
  Marco


> [    9.027132] Mem abort info:
> [    9.027139]   ESR = 0x0000000096000007
> [    9.027147]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    9.027156]   SET = 0, FnV = 0
> [    9.027164]   EA = 0, S1PTW = 0
> [    9.027171]   FSC = 0x07: level 3 translation fault
> [    9.027180] Data abort info:
> [    9.027187]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [    9.027196]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    9.027205]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    9.027215] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000004924f000
> [    9.027226] [ffffd9c18eb05000] pgd=0000000000000000, p4d=10000000496dd003, pud=1000000102e42403, pmd=100000010c33d403, pte=0000000000000000
> [    9.027258] Internal error: Oops: 0000000096000007 [#1]  SMP
> [    9.101669] Modules linked in: snd_soc_fsl_sai crypto_engine rng_core imx_pcm_dma authenc snd_soc_fsl_aud2htx snd_soc_fsl_utils imx8mp_interconnect libdes i
> mx8mp_hdmi_pai evdev imx8mp_hdmi_tx aes_ce_blk dw_hdmi ghash_ce drm_display_helper snd_soc_simple_card hantro_vpu phy_fsl_imx8mq_usb libaes phy_fsl_samsung_hdm
> i snd_soc_simple_card_utils cec phy_fsl_imx8m_pcie v4l2_vp9 imx8mp_hdmi_pvi typec fsl_imx8_ddr_perf snd_soc_imx_hdmi gf128mul samsung_dsim v4l2_h264 etnaviv ti
> _ads1015 industrialio_triggered_buffer snd_soc_nau8822 ina2xx lm75 gpu_sched i3c lontium_lt8912b kfifo_buf governor_userspace imx_sdma flexcan imx_aipstz dwc3_
> imx8mp imx_bus can_dev spi_nxp_fspi caam spi_imx error pwm_imx27 imx8mm_thermal nvmem_snvs_lpgpr snvs_pwrkey usb_conn_gpio gpio_keys display_connector roles lo
> op fuse ipv6 libsha1 autofs4
> [    9.173690] CPU: 3 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.19.0+ #47 PREEMPT
> [    9.181623] Hardware name: Toradex Verdin iMX8M Plus on Verdin Development Board (DT)
> [    9.189462] Workqueue: events_unbound deferred_probe_work_func
> [    9.195314] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.202284] pc : of_find_matching_node_and_match (drivers/of/base.c:1129 drivers/of/base.c:1120 drivers/of/base.c:1187)
> [    9.207869] lr : of_find_matching_node_and_match (drivers/of/base.c:1185)
> [    9.213452] sp : ffff8000805dbad0
> [    9.216771] x29: ffff8000805dbad0 x28: 0000000000000000 x27: 0000000000000000
> [    9.223927] x26: 0000000000000000 x25: 0000000000000000 x24: ffffd9c2060d48e0
> [    9.231078] x23: 0000000000000000 x22: ffffd9c18eb05000 x21: ffff0000ff79d7f8
> [    9.238231] x20: 0000000000000000 x19: ffffd9c18eb05000 x18: 00000000ffffffff
> [    9.245385] x17: ffff263ef9a67000 x16: ffffd9c2055d3d54 x15: ffff8000805db870
> [    9.252536] x14: 0000000000000000 x13: 006365646f632d6f x12: 0000000000000001
> [    9.259689] x11: 0000000000000003 x10: 0000000000000020 x9 : 0000000000000000
> [    9.266842] x8 : 0000000000000020 x7 : 00000000ffffffff x6 : ffff0000c4a9d8c8
> [    9.273995] x5 : 0000000000000014 x4 : 0000000000000000 x3 : 0000000000000001
> [    9.281145] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    9.288301] Call trace:
> [    9.290753]  of_find_matching_node_and_match (drivers/of/base.c:1129 drivers/of/base.c:1120 drivers/of/base.c:1187) (P)
> [    9.296336] hantro_probe (./include/linux/of.h:983 drivers/media/platform/verisilicon/hantro_drv.c:1047 drivers/media/platform/verisilicon/hantro_drv.c:1225) hantro_vpu
> [    9.301144]  platform_probe (drivers/base/platform.c:1449)
> [    9.304815]  really_probe (drivers/base/dd.c:583 drivers/base/dd.c:661)
> [    9.308399]  __driver_probe_device (drivers/base/dd.c:803)
> [    9.312765]  driver_probe_device (drivers/base/dd.c:833)
> [    9.316956]  __device_attach_driver (drivers/base/dd.c:962)
> [    9.321415]  bus_for_each_drv (drivers/base/bus.c:500)
> [    9.325262]  __device_attach (drivers/base/dd.c:1035)
> [    9.329109]  device_initial_probe (drivers/base/dd.c:1088)
> [    9.333303]  bus_probe_device (drivers/base/bus.c:576)
> [    9.337152]  deferred_probe_work_func (drivers/base/dd.c:125 (discriminator 14))
> [    9.341697]  process_one_work (kernel/workqueue.c:3268)
> [    9.345719]  worker_thread (kernel/workqueue.c:3334 kernel/workqueue.c:3421)
> [    9.349477]  kthread (kernel/kthread.c:467)
> [    9.352716]  ret_from_fork (arch/arm64/kernel/entry.S:861)
> [    9.356303] Code: 6b14001f 9a93d35a 1a80d294 91032273 (39400264)
> All code
> ========
>    0:   6b14001f        cmp     w0, w20
>    4:   9a93d35a        csel    x26, x26, x19, le
>    8:   1a80d294        csel    w20, w20, w0, le
>    c:   91032273        add     x19, x19, #0xc8
>   10:*  39400264        ldrb    w4, [x19]               <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   39400264        ldrb    w4, [x19]
> [    9.362413] ---[ end trace 0000000000000000 ]---
> [    9.367037] note: kworker/u16:2[45] exited with irqs disabled
> [    9.367134] note: kworker/u16:2[45] exited with preempt_count 1
> 
> 
> Thanks,
> Franz
> 
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

