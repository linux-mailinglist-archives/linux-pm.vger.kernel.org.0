Return-Path: <linux-pm+bounces-10254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D105291D274
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE322812A3
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FECB156255;
	Sun, 30 Jun 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="X7aik6t4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75EA282F1;
	Sun, 30 Jun 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761875; cv=none; b=V+jN1CWhpDh3WYV3xPr/L5bLAmFKugDyq3dp4yDZiiN1Uuq7iLtBmmZhAvSIWEl5fOhOrjSsUQLY5/4fb5QnJfrC61HXx1/rdHkZow6yyqN/Dged8qzSxrccmXLasU76kKANq2QEzMkB4pdrc1lr7ObBbFVlxZ5y+u9gdp7RWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761875; c=relaxed/simple;
	bh=m6tWh5VFeUVuRWlJSVFGRTLpHvqDFP6glRqtCEMizSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlNb7rzYRRkl1A4esF2J7MibzLytDQTcPe4luC+rEN7IhpqgaIPcNA9w16XqAQOCuXZLr+FI6Ycm587YQj2SsFdyZrbdToDx2Fgz6a1oQydghuaxZi8DZkaIV8oEhXvDhJKH2dMXut/wsMR+gegvjInYaKYcUIN+ei4PJzkn+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=X7aik6t4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761841; x=1720366641; i=wahrenst@gmx.net;
	bh=4r6Hb3gvtnU8vTL9qCacD/NYc/kZfSz2IGu4cIiUycI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X7aik6t4uOtmi1FCRIFUupfyyTLgagoIq7hhRty+/4yPBBwYYNy6kibUV/P4dDvz
	 3DVT2dWV3Fhl14S5VlVhZQUif/I4o6x6S57hYdb0qt02WXNTjesd/uu/bHbMVLnoz
	 jjZ84GvzEi7gry6K4jLAVo5DRtrhMBtbI1JwGLYhsEGV5EqmK3Fumsoek082N/5QT
	 POtPk+3tLrYIRnSZpjRekiAF8bXqcNtljOYH4OEScH0zg1Ct2y6yA9msU7RVuN4dJ
	 YVrjYD4uboyoTthXotFaHDOrWOtwkjuTmcaHuUU/OvzyFXnruZ0cdj+mr8SZQRXYW
	 7dPtbj18gvi3vRpoCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1sAG1H2vzq-00t1Ll; Sun, 30
 Jun 2024 17:37:21 +0200
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
Subject: [PATCH 05/11] irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Date: Sun, 30 Jun 2024 17:36:46 +0200
Message-Id: <20240630153652.318882-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:gG2zMh+5jv70iXOh5vFMJHOoLe5umeeOapkAwXLaixUOKZ+w9QA
 jPqoLpaAOuyJxVXORl0vegF1SRPmg4dQxiGU8L7EH9QB/4Iz219fGjQXz8DwSGSKM66yRXr
 vnStIUjEtjuzJgL5OnFe2GRajHR2k6x/xHH4MarDtqWy6tVBMieMywmH14JIEdqGeNs3PgU
 XqknQyYVH7TRn7AyZjuHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kq6aJGVKb94=;BpeGVYzb1ZqeBqbopRubsnmH5ax
 bfoCiueu4CjcjLXZqr3WtEX2tERwkAFYxJP/aQQQ1ojQA3+bsxkQoAH/ojzLQIOHuLKP4XPAc
 PVgiBTqos9NLSBi+/Xv0YpPxTvJGupp//SFJjyqj4Q7FG2tkr1mG2Zlr0vJlUZSXQgZEK9vWW
 aEKsjAfBXct9DD+JcXevmysY/sO5N12Perafl3iY1mVumAySBHh0xOv1wrN4d5eavdYi8D0nq
 VdsG4kfE6nx3o3pkcOFo4REsD+nIXEW3kiMPyzof0uk6e+rA0xJVxe2AgPkmcCfzGIwXmmzow
 KgWcg+s29ZVRXJjDxEvxK3LPWrvWVfrRA98sq876H7KB2rkqEmfMsnWVQnCQFvN1uS+qooUzJ
 L8iiBIWRQ3KKNvIyX6yW+DcOrh+qz2oh1JuixG68LlNouCGAPPl5FlTdW6zbxqXicYhZvsJ7C
 q/n6LSVxb6bxweJlN2HLWEIEhBI57OEvPgQUBjIFslAP/2xVbBOqYsYTo7bXWS8mEeKyceJbh
 rmEWYJ8Yl7tEZZL4JlPyO22is1EbNRtKO1pcwLJ0X3Igb22rk9e4GbwUk3STI9Wj/6DLIQAmq
 WsqlUXHWR+1/rj0KTlQeLszN2nzIkuLQBdiUxkjqJiRw2DPsw9jl2HUn/es64EDRjVI+oL7Dh
 XzBhIbs7rYrrcC0zKHr1C67qXW71zhy6ZGGgYWq2kpIAhQa/lGQ0xAqeVD0dti8yme6Nxr4NF
 sEm1K1J3fThW8EXVaHpon1QQO+XAThqSD1IiUIslRPDG5I4OUmnWJqKR80tKncoNLLLqazLfW
 +F/fKvsXndGa6dgyAok+CecJ2A2ytKP4v/QEeRwH6wEaA=

The BCM2835 ARMCTRL interrupt controller doesn't provide any facility
to configure the wakeup sources. That's the reason why this
implementation lacks the irq_set_wake implementation. But this prevent
us from properly entering power management states like "suspend to
idle".

So enable the flags IRQCHIP_SKIP_SET_WAKE and
IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
the power management.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/irqchip/irq-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index e94e2882286c..6c20604c2242 100644
=2D-- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -102,7 +102,9 @@ static void armctrl_unmask_irq(struct irq_data *d)
 static struct irq_chip armctrl_chip =3D {
 	.name =3D "ARMCTRL-level",
 	.irq_mask =3D armctrl_mask_irq,
-	.irq_unmask =3D armctrl_unmask_irq
+	.irq_unmask =3D armctrl_unmask_irq,
+	.flags =3D IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };

 static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
=2D-
2.34.1


