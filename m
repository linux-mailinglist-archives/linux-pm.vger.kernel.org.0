Return-Path: <linux-pm+bounces-11533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3693F377
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6979B22B6D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35465145334;
	Mon, 29 Jul 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSwST0MB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597B1448FF
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250897; cv=none; b=SSCrVi1eF9MXj/xlYkueXsmbpurcy14bekuinobXamLbL449FEpE0BxUwaCXBAWbu2xs1DfM/pPflccUEI8gBhNBEntBaOVCA6EL4M3fYanLHQDOqhpmkTmCz3EZYLraaYDjTOcK5J2KHsaBKIICkmYYtQ3EhejX9aAEeSybFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250897; c=relaxed/simple;
	bh=lduqLSkWyJhKYjonatWIdfC2fjHw1mpU9LAVB9RFSNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brf51yylRba3gzF8qQGmbePTcvZ2iTZ2Khobx106yWehwGzXN2P2zHk700rFgvn5p2666RBEfYfmB/BEpMy8047W68cd/7NvF8YyipHSM9aqBroh0ATedXpWjJjtGmscSC6g87gK/YXTnLhNa3D6fd9yN/41WGnFMn9MyqwX8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RSwST0MB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6634f0afe05so21270237b3.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722250894; x=1722855694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qS74thyXlKVfCHirad4RXHuJPQsnIZHpLWb7ffO4dsY=;
        b=RSwST0MBcfy2ofcxx/T4Yg9NhttQLBFmZB69eqATNFnB9V2TTL921sV+JYh38tE/01
         hwuFFfurRgFo9LtpJK/gro6s46cB1ZMlAY01X/dzuI6FLSqMVT+xg1Z28J2R3I/LLzUE
         0diRlt4QwY2GW4WZVvfMpGpRTdn1YOIMvKP+sMx24ULV6rBct6u5ajQQcY+Xg82Nv2j4
         yGgewXb3fhVydFK7F7gJ9t6oWToH+tKAmI3NMJnzZ9pWljP4fT55Ft14YUQW+RaRTilK
         8/6JKlwqocwAVyhHHSvZ4xhUxClp3D0mQrdxV6NIQUZbalSB+H/o6AA9A7/1gg141Vge
         /mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250894; x=1722855694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS74thyXlKVfCHirad4RXHuJPQsnIZHpLWb7ffO4dsY=;
        b=BN9S2H3iNOGSt4Iu+HQxt68eGrmqrVDLld3/Pl6O42ZYwDf8bzfPntg063CGsmp5Kz
         wIEPIZAkl1eFKHqVbBEWJp/jMrl3bdw4Bv0DwfoqECC1CaGs0d5WZU5Xui0huUsxegHd
         rttvg58QFOC4UkDPo9aN2AgeUSEMsQVWYX3zIazYQAlAJbXJ04tsf0Mc9EaHCMAz5yU/
         JkotZi9Zw37m6+fD43tddcmGiAixpef37AVaQ7wk/zs+rG3qzixhh70bjOknrfmOpen+
         XsiaRq8R/yI8rqPFmDxjFZE4rp9JnnzviBvWsdNbQKAjZjH7iYyV89hoEg6BKtrIQjPP
         1HNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5xzN3DA38a0nUfrASc+RSz85rfGg+DjIAuNne1hhPpoyhiNeItyRRM8PtQWkiyt/aqBY6AzwaC3Zu/dqE/3hhhQgqef2wUj0=
X-Gm-Message-State: AOJu0YyeuaGj05r2GeWvyYXcebymzVVBHE4r2tmkH9+3/kUYR+SMgani
	FwWyQdKLW0CNS0dMCuGNCvMKO1EIiw4s8kgraAJfkwFeMqR6LDE2ZO+i9zRseHfjzJ0l7xrfkpd
	2H9+zh9hKa48g98QHvu0bP2b5b4O9rm5oqeXSGg==
X-Google-Smtp-Source: AGHT+IG3EA/0IxeNAJtBbqjvCrC/pwaKq0AyGdVeJ+5pV3M8HdGLRf4CJd0exHD7znc1SNb7/XMwKGZypKi+qJlQgw8=
X-Received: by 2002:a0d:d007:0:b0:673:1ac6:4be0 with SMTP id
 00721157ae682-67a0a3231d1mr80378567b3.44.1722250894530; Mon, 29 Jul 2024
 04:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j> <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de>
In-Reply-To: <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jul 2024 14:01:23 +0300
Message-ID: <CAA8EJpqGXe0A0yDpEP==60k-bPEbDORpLUtsiPvGSi+b_XphAg@mail.gmail.com>
Subject: Re: btqca: crash with linux-next on bt power down
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

#regzbot: introduced:
973dd9c4db4746200f88fe46e30eada7054fdbea..84f9288208dfcd955446060a53add15b9e01af4e

On Mon, 29 Jul 2024 at 13:21, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Am 29.07.24 um 04:11 schrieb Dmitry Baryshkov:
>
> > On Qualcomm Dragonboard 820c (APQ8096, QCA6174) soon after the boot I
> > observe the following crash:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
> > Mem abort info:
> >    ESR = 0x0000000096000006
> >    EC = 0x25: DABT (current EL), IL = 32 bits
> >    SET = 0, FnV = 0
> >    EA = 0, S1PTW = 0
> >    FSC = 0x06: level 2 translation fault
> > Data abort info:
> >    ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> >    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=000000010da63000
> > [0000000000000018] pgd=080000010da62003, p4d=080000010da62003, pud=080000010da61003, pmd=0000000000000000
> > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > Modules linked in: hci_uart btqca
> > CPU: 2 UID: 0 PID: 66 Comm: kworker/u19:0 Not tainted 6.10.0-next-20240726-13923-gd3ce7ebd61f9-dirty #2722
>
> I am unable to find the commit. Your tree also seems dirty. What is the
> last working commit?

Checked the commit range on the linux-bluetooth branch, hope this helps.

>
> > Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
> > Workqueue: hci0 hci_power_off
> > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : qca_power_shutdown+0x8c/0x210 [hci_uart]
> > lr : qca_power_shutdown+0x7c/0x210 [hci_uart]
> > sp : ffff8000836f3c50
> > x29: ffff8000836f3c50 x28: ffff00008337b900 x27: ffff000084085000
> > x26: 0000000000000000 x25: 0000000000000000 x24: ffff00009276f800
> > x23: ffff00009276f918 x22: ffff000081e1fc80 x21: 0000000000000001
> > x20: ffff000081e1fc80 x19: ffff00009276f800 x18: ffff0000de422170
> > x17: 0000000000061d88 x16: 0000000000000000 x15: 0000000000000001
> > x14: ffff0000813b3580 x13: 0000000000000000 x12: 00000000000001a0
> > x11: 0000000000000001 x10: 00000000000013f0 x9 : 0000000000000000
> > x8 : ffff8000836f3b40 x7 : 0000000000000000 x6 : ffff800080d52e88
> > x5 : 0000000000000000 x4 : ffff8000836f0000 x3 : 0000000000000000
> > x2 : 0000000000000000 x1 : ffff00008f56d000 x0 : 0000000000000000
> > Call trace:
> >   qca_power_shutdown+0x8c/0x210 [hci_uart]
> >   qca_power_off+0x70/0xfb8 [hci_uart]
> >   hci_dev_close_sync+0x4b0/0x6d8
> >   hci_power_off+0x2c/0x44
> >   process_one_work+0x20c/0x62c
> >   worker_thread+0x1bc/0x36c
> >   kthread+0x120/0x124
> >   ret_from_fork+0x10/0x20
> > Code: f9400681 b4000441 f9403c36 f94102c0 (f9400c00)
> > ---[ end trace 0000000000000000 ]---
> If you can reproduce this, bisecting this would be great.
>
>
> Kind regards,
>
> Paul



-- 
With best wishes
Dmitry

