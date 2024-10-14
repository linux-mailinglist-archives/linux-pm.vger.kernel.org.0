Return-Path: <linux-pm+bounces-15629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C799D671
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 20:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5F51C22DD6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9411C876B;
	Mon, 14 Oct 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+FjAwvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D051B85C2;
	Mon, 14 Oct 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930448; cv=none; b=OxnpDfENP52Wo9CkYoA7H6TS0+CxGD2VAwbU+AqWoPneVAAnLLBocejx9L2PVICiESbSF+kZ/DXEvQpsDd21j2aYKrn6ZdwPNReSyHri/+DwFWOMhJqnSoxoSj4RjL7Pnd3H7ZnqIA1EtujqGPkaOvlZN8rgdCLLdHEryH/pswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930448; c=relaxed/simple;
	bh=fXfCE7WI7+mHKeiyEDfExAmGaPiTf3I45abPqUtrN40=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=okXJ0IDRIpmlwoHrk4EPpJ1GdfZhnESZvXOpMJQizKre1vsh7qQcyFpLjzKO+crXFiIri3+n3mkHegWs4VwVMe1N85idSfb6EbKC5L7EzWpMHRYaJY/+nDPxv7hwJx9w1GiHNbspp6lUKplgA0dGOjIuPssiK8WIQaEPLwRlt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+FjAwvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCC7C4CECF;
	Mon, 14 Oct 2024 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930445;
	bh=fXfCE7WI7+mHKeiyEDfExAmGaPiTf3I45abPqUtrN40=;
	h=From:Date:Subject:To:Cc:From;
	b=P+FjAwvNw9vBEQw82WMJPEHQkhawda96SXMUhomniuz37B3a0Mhz+358nkZoWqC7Z
	 9BC1z8VnaHLqGMLvk2UBwbNv0JBfye3YTI/gNa91cashFJhAWMAFB1QCM/H8BEaqrC
	 1gcHqMJk+Sdl+HPJpocxH+ygQWYPhSEw69qoFK3mAxE74GQYoQjfYFYm3KKYGbAMnc
	 TAz9prGIxoisU3kY4SKvoG0cMHJ7Hg42yqnveNHOhSow3fxLUBSONYUf13OJBZJjWR
	 aGoMyyMmZMlHHEZO5IpIkEEUiLWJfBqdnn6goZRaFUQEDx+L2LeWJ+wajcbKSAkvLK
	 jJugqocR2aeqg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28862804c9dso1878728fac.0;
        Mon, 14 Oct 2024 11:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+fp7k/3veSos6oP9AbYmJesVNNBdtp/9KaEBC6/Qe2AFmD+iVJ7zUGw8FefVk7uIHdJdcu8U9kWrr7i75@vger.kernel.org, AJvYcCV1t8XTj+Py1uHFIee1OzIrvAM++/np752CvN1b6QqNos9dtPONhfgoWm/xDR3eq/lPCcIcZ7y8uciMLbCTgag=@vger.kernel.org, AJvYcCXW6aD4NWiDTgLy+RVbspBOMqKakpTTY1/BVSQotbeLsm2ExILerDpJ4wgwKBjto4ZNoETkxcRfiAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CO3V28qrMqCbFppnBko8++iz7++MVLSZcuewLwZO8w/Dqx+C
	znpPd9ezYFnU27aBPt9yAtJ/zOb/pt08iMMBIVy1r7/vmPUYKhPl30IZSBPjaJJVEWfMJIYJ3eO
	zgee4hGz+lo7qpvAf9we17a7fswg=
X-Google-Smtp-Source: AGHT+IFTWWgl+GBmolpvS4W4rvEi5ORqA0DGptCX3RMlU9+wEN8cGeiMojpsi//3rfxBRyuRG30ThN54PNZ/9WZzjTo=
X-Received: by 2002:a05:6870:7d18:b0:27b:a693:fa11 with SMTP id
 586e51a60fabf-2884d52d010mr10928051fac.19.1728930444636; Mon, 14 Oct 2024
 11:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Oct 2024 20:27:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
Message-ID: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
Subject: [Regression] Bluetooth mouse broken in 6.12-rc3
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Kiran K <kiran.k@intel.com>, 
	"Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Unfortunately, commit 610712298b11 ("Bluetooth: btusb: Don't fail
external suspend requests") from you that appeared in 6.12-rc3
prevents my Logitech Bluetooth mouse from connecting to the host
(btusb).  The LED activity on the mouse indicates that it tries to
associate, but there is no response.  It looks like the host is
suspended before the device can connect to it and it cannot be woken
up for some reason.

It worked no problem in 6.12-rc2 and the above commit is the only BT
one in 6.12-rc3.  Also reverting it makes things work again.

In the "good" case (for example, in 6.12-rc3 with the above commit
reverted), the following messages are present in the kernel log:

[  251.748734] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[  251.748763] Bluetooth: HIDP socket layer initialized
[  251.773010] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
[  251.774432] input: Bluetooth Mouse M336/M337/M535 Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
[  251.775733] input: Bluetooth Mouse M336/M337/M535 Consumer Control
as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
[  251.777163] input: Bluetooth Mouse M336/M337/M535 Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
[  251.815905] hid-generic 0005:046D:B016.0001: input,hidraw0:
BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
9c:b6:d0:96:8e:c8

In the "bad" case (for example, in unmodified 6.12-rc3) they are not
there at all.

Thanks!

