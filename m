Return-Path: <linux-pm+bounces-11531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C593F284
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496B628364F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173414388B;
	Mon, 29 Jul 2024 10:22:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C191143752;
	Mon, 29 Jul 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248541; cv=none; b=ZZulKeVLUxeKrzI58xdZvjcvRfr5C2HrtXcb5F20UirsKsWKmlWtQvppqoEtPBkBFbbMra3zfC9zEbmWrb5eW8h8ILvw8ryuqiltrF+1n9kcrniRxL7PoCZ/mltAbcB9Wh3c5kTT/FuX0VB55yYnzxvbC+oEzXUxP/ZxGQbVAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248541; c=relaxed/simple;
	bh=ggPiKzMFxwpeO1xIvCR8I2M+CpPVZDjRP8p/t87aFqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIE122Y5piwKI67YgtQM7SGKB9a7VXcsr14VjQ1906uoQhyFC8Xad3P1xGbJJuUbtvEcZOrAALL5+/XOdfHe3AtEZOF8ugXUh3J7VjF/ScJ+faVYMiAep75pdjmI2cY6MjOBqhiToovYdU2lY7WOSguHHOUuIkgNIXb+ZtCMmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5ae9dc.dynamic.kabel-deutschland.de [95.90.233.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2268261E5FE35;
	Mon, 29 Jul 2024 12:21:35 +0200 (CEST)
Message-ID: <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de>
Date: Mon, 29 Jul 2024 12:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btqca: crash with linux-next on bt power down
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#regzbot: ^introduced: 6.10..

Dear Dmitry,


Thank you for the report.


Am 29.07.24 um 04:11 schrieb Dmitry Baryshkov:

> On Qualcomm Dragonboard 820c (APQ8096, QCA6174) soon after the boot I
> observe the following crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
> Mem abort info:
>    ESR = 0x0000000096000006
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010da63000
> [0000000000000018] pgd=080000010da62003, p4d=080000010da62003, pud=080000010da61003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in: hci_uart btqca
> CPU: 2 UID: 0 PID: 66 Comm: kworker/u19:0 Not tainted 6.10.0-next-20240726-13923-gd3ce7ebd61f9-dirty #2722

I am unable to find the commit. Your tree also seems dirty. What is the 
last working commit?

> Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
> Workqueue: hci0 hci_power_off
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : qca_power_shutdown+0x8c/0x210 [hci_uart]
> lr : qca_power_shutdown+0x7c/0x210 [hci_uart]
> sp : ffff8000836f3c50
> x29: ffff8000836f3c50 x28: ffff00008337b900 x27: ffff000084085000
> x26: 0000000000000000 x25: 0000000000000000 x24: ffff00009276f800
> x23: ffff00009276f918 x22: ffff000081e1fc80 x21: 0000000000000001
> x20: ffff000081e1fc80 x19: ffff00009276f800 x18: ffff0000de422170
> x17: 0000000000061d88 x16: 0000000000000000 x15: 0000000000000001
> x14: ffff0000813b3580 x13: 0000000000000000 x12: 00000000000001a0
> x11: 0000000000000001 x10: 00000000000013f0 x9 : 0000000000000000
> x8 : ffff8000836f3b40 x7 : 0000000000000000 x6 : ffff800080d52e88
> x5 : 0000000000000000 x4 : ffff8000836f0000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff00008f56d000 x0 : 0000000000000000
> Call trace:
>   qca_power_shutdown+0x8c/0x210 [hci_uart]
>   qca_power_off+0x70/0xfb8 [hci_uart]
>   hci_dev_close_sync+0x4b0/0x6d8
>   hci_power_off+0x2c/0x44
>   process_one_work+0x20c/0x62c
>   worker_thread+0x1bc/0x36c
>   kthread+0x120/0x124
>   ret_from_fork+0x10/0x20
> Code: f9400681 b4000441 f9403c36 f94102c0 (f9400c00)
> ---[ end trace 0000000000000000 ]---
If you can reproduce this, bisecting this would be great.


Kind regards,

Paul

