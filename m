Return-Path: <linux-pm+bounces-10256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDB91D27C
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62697280DA8
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1083156F33;
	Sun, 30 Jun 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Gpf1//3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A0156967;
	Sun, 30 Jun 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761877; cv=none; b=jpFKpnfGDrIab0QmUl411fAybccERJUpxBqBq+ysQxN/6k9GOtHG5VpJ4TDXHWwbqjPufL+BE3pTRRy62uOqMuKB0iUnBrVmqQnQgo12dKGcP0crCwNBy7hka+84P3miUwQuUC26XPdT+GcCRBY9F+Z+534pTzADVooBO/8Xrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761877; c=relaxed/simple;
	bh=Z/y0IFADfKfJvFiNwnyAj1kXb+3X4rxM/FOzZQk6XVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7dEhntk67cEfwC9n2ElcPFdgUU2EmG3o76169GviC6EgCjrdytLpAu0lSURN/D7iQQbHXIIWYLq7N13abx9GUf5uryRZrUQIwfaFn1BIF9NMYJC4oK7wjK42qKKoHYS3ImnG8afEBooniCB4xDUlKnN89o6iRL5/uTeAHpE9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Gpf1//3s; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761844; x=1720366644; i=wahrenst@gmx.net;
	bh=lCFQBeBlbmpUg9EyXUyqn5DC7Bbo3JN2mDc4pQ7TCIw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gpf1//3sptoh0BqAY9+K8DWuGeBmw+14AW5vGaMnqtdrUtrC60rP9HwuSjH1nEq2
	 tZjNmkjPkCQCVY/FwfeTawoESM8K2FlwLo2aszffrrayuQu7Rp6L8z3WrPMVEfscV
	 aI/SuHreY7rXStZY+T+VNyIgNIJvbJrVV5fo86kgPZfwHq5KVCN8xhTF4YQyAgruF
	 MNTtarpzEYfcKuThXAZ4QelWbD6n+1lbxJYkG51dKwPeK+ro7nEH+C9yM3P2fJXh8
	 FIcpAptoxrmAcTSDvQs+3GGUE4UrNB0vppZxNjumCGCLmkiYoQsY+vvAmiFLNRla1
	 9QYMcbfMC8rclpxwIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1seevT2qMh-00Fv84; Sun, 30
 Jun 2024 17:37:24 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 08/11] usb: dwc2: debugfs: Print parameter no_clock_gating
Date: Sun, 30 Jun 2024 17:36:49 +0200
Message-Id: <20240630153652.318882-9-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630153652.318882-1-wahrenst@gmx.net>
References: <20240630153652.318882-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2/ydqCyqYHWHavK5/XG4b46LsgTWvQ3AzoHTM5k/IIqoHGxAdu
 YmHJwmsQJKG3BiEcn/lVB63s5ODVPmRQCXvi1v/puqwcPbB9y/BglDKYBDHBcNlySv4Pux8
 Aiv2WHULsE2ioRoX6rVAL9MGN7wv0b+hY9DQIVE8t7jRYaaD3R4y47BjYJtZHz3kf9g40YU
 kCRuybOwyGdQwQf6CYwQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1mr6sDBPqAY=;ZVkIx5NNUR0ZJQM95skTQK9wG9G
 YQ//jV7KGMQwMhiLuozF7iwuXXsavmAxKDlwYcvpTnqcCoQ4cRO7JXS8WvjpeO0CGzkH8/CeZ
 KVwxEH49j4t+hhkiUBoSh0Udkzx8SNT1KQg2pu/qFHDnfYsRY1t5HRznGr3/GZ1ad6gI32WII
 mfDwlCe1hjdKj56Peofvihz41IHFncxcDsOt9SP1pBGjqR9EnDVUJe777Xrx5bEk9Nf+jNEB8
 NtQ5DAFBDZGx+31cDrhg06e59qTg7leiT67FUse0/SQWvvHBRGDSd/fniQSS3YwBs2KJxgUhT
 bH/YZp+tZZjUuMC5XdAXNBANuhFGAFE4YVA/eR81UBc10kVDFfH/cmBREY98OMGdbi58569/X
 lgsygz2Vq0ponplUSfg7M+o3YZG9zxjRhG7aUkJ3dCWPWpxREe00h2Qbd6oXLGmP0y0c3NVQO
 cK8eoYBXpmBm6qUhrpKYvvfQmmM5YEFCPgxNVOQydubkcppzK1MYa+bBSfvZrnODoMEvQ+GMB
 ArEDD2Za/Bsi5Xom854maKOkcXgySDsNHH2pPopgQJQH6jEZU/xwynvwjqFZCHdpk/uO1YM91
 hrdlK8rrbRVH5vs/tVA3e3lz5jlByvi/IQ7zat3EBsVHwzeQBFr1bc+biyxd+e0RPr/aPKcil
 Sy9u6YyxO/gY/or8MPDKihrxH/0N7bad414NbWboObpHEd2Yvb8VP2JbXBTs1xb5rOVxGP3tD
 xvItjcHC7chExI5cbgLJs98U5I4t3QtKlDfUVEt4s3uXrYoGfP6/p1UVQ5307NO1sbYcrCgmc
 /55cQvNWI6q+ZRrzkWJCoJojDh6UMUCt3bm0ZICYtxtpk=

The commit c4a0f7a6ab54 ("usb: dwc2: Skip clock gating on Samsung
SoCs") introduced a parameter to skip enabling clock gating mode
even the hardware platform should supports it.

In order to make this more visible also print this in show
parameters of debugfs.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 7c82ab590401..3116ac72747f 100644
=2D-- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -702,6 +702,7 @@ static int params_show(struct seq_file *seq, void *v)
 	print_param(seq, p, uframe_sched);
 	print_param(seq, p, external_id_pin_ctl);
 	print_param(seq, p, power_down);
+	print_param(seq, p, no_clock_gating);
 	print_param(seq, p, lpm);
 	print_param(seq, p, lpm_clock_gating);
 	print_param(seq, p, besl);
=2D-
2.34.1


