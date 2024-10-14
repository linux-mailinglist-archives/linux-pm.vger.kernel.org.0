Return-Path: <linux-pm+bounces-15633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D599D98A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E069B1C21395
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7111D3184;
	Mon, 14 Oct 2024 22:00:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E101ADFFD;
	Mon, 14 Oct 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943231; cv=none; b=clnhqH0+UMsrsMlr2ZM5mx5cnYc3IQFQ0rPm0n4uPCuGazrXON6eJw4vacXiPw3VT+5tMETviPxhlPEQf9/tj1AmCD7hku1TX3SDq98WXYbFK48iX7YoVVYj0U3+iKAQ0dmQtix3Aj58cZSmJxem7j94ZJzKWBaQDrl01+MGEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943231; c=relaxed/simple;
	bh=pYgGOj6FKnoBwOhBKDzGMGMj4olpmixvu1h54P2Wz4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaPrzwO2Di0ThC/sfmw8YVGj+pLHdxTzW4moBOJgOrRkFBK4RJkxpuhTE9cgBOKvGYUJvbHvY8wf6hwSBfGw8hXbTG9fVmCycRls5C4GTqY7D2zv0QNRfcJKcpl/eMoqKEyu8RdIpAgzUpnosFygDeyxuczVg6/emAdVl7QYots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5ae805.dynamic.kabel-deutschland.de [95.90.232.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE4D661E5FE05;
	Mon, 14 Oct 2024 23:59:44 +0200 (CEST)
Message-ID: <403e0c87-4619-4349-96fa-36f56f15b8aa@molgen.mpg.de>
Date: Mon, 14 Oct 2024 23:59:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Bluetooth mouse broken in 6.12-rc3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Kiran K <kiran.k@intel.com>,
 "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
References: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Rafael,


Thank you for reporting the regression.


Am 14.10.24 um 20:27 schrieb Rafael J. Wysocki:

> Unfortunately, commit 610712298b11 ("Bluetooth: btusb: Don't fail
> external suspend requests") from you that appeared in 6.12-rc3
> prevents my Logitech Bluetooth mouse from connecting to the host
> (btusb).  The LED activity on the mouse indicates that it tries to
> associate, but there is no response.  It looks like the host is
> suspended before the device can connect to it and it cannot be woken
> up for some reason.
> 
> It worked no problem in 6.12-rc2 and the above commit is the only BT
> one in 6.12-rc3.  Also reverting it makes things work again.
> 
> In the "good" case (for example, in 6.12-rc3 with the above commit
> reverted), the following messages are present in the kernel log:
> 
> [  251.748734] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [  251.748763] Bluetooth: HIDP socket layer initialized
> [  251.773010] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
> [  251.774432] input: Bluetooth Mouse M336/M337/M535 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> [  251.775733] input: Bluetooth Mouse M336/M337/M535 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> [  251.777163] input: Bluetooth Mouse M336/M337/M535 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> [  251.815905] hid-generic 0005:046D:B016.0001: input,hidraw0: BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on 9c:b6:d0:96:8e:c8
> 
> In the "bad" case (for example, in unmodified 6.12-rc3) they are not
> there at all.

This regression has been reported three times already [1][2][3].


Kind regards,

Paul



[1]: 
https://lore.kernel.org/linux-bluetooth/020c69d7-ad86-44d3-a508-22ff949ee7ec@gmail.com/T/#t
[2]: 
https://lore.kernel.org/linux-bluetooth/a34d2761-dad4-4ae7-8787-6bbf05538318@panix.com/T/#t
[3]: https://bugzilla.kernel.org/show_bug.cgi?id=219385

