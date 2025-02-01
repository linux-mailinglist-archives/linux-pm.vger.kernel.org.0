Return-Path: <linux-pm+bounces-21205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F6A24880
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA077A3106
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8776025;
	Sat,  1 Feb 2025 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="L5I5qo/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234B4A3E
	for <linux-pm@vger.kernel.org>; Sat,  1 Feb 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408788; cv=none; b=lvbSqm6Sy54XTsxuPLnh6AyNshbM8L/gHsj0fAY3w+mDiFz16+LpNZtgRT78glNz5SvkkPkrV9TXO0DSBG4lvKJmVIGBS/mLNfP2M//K0LyPedLDW1esIW5/X+oy0QrHY5+JgFKIc3PvYIz2kCdEbE4ao35sYNCI04e79i9bgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408788; c=relaxed/simple;
	bh=wB5I4RxD5M3GEMA2q059Dbq+xGu50e2eenkHQePRcCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpoTgh1UzhkUdnsYXt85xkkx0/S62+C2aAbcC+id4c/5RzAihZlmLhnD+9YGM+vHQICHw2cCaCC/xbs0zlB/076RhrPLknhJvGe838BqbzybdbSAePHPzGCOU8CjXD131T7XnSdiMucsRNxDaX1SGrl3a/OWalZ3X2p0DeCG9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=L5I5qo/W; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738408774; x=1739013574; i=wahrenst@gmx.net;
	bh=WL/TkWmYI9gtqcLq6PPlC4DiEjBnRh+Q5zQrz+U6qaY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L5I5qo/WAVuOdT8v436r/j2OI7L0yupboyc0iRdms9X2t8bs/OpEEThVp4MV8ICH
	 dg3q0lk+8GW/C51H4qHit9VXVCIlqeXsu8hNGTYEHem6Hx5ZnQRCW3QioL43J0smr
	 b+vmUrCNTimefHzkG2QIxJ73R8YCc2JLKJxgw10Cm0l39fPDnMC3DF4EmjYKT+y2j
	 fqjBaiwxk8smIklvy7SiZmf3i5tH7FF6J3eOLen3BBH+6lfzVfj/wdWErQsCoQ2bB
	 YJVHR8c3t+O5GkdHlCn2V7Gn2woX5ORPJf2JKSGsD53Ufqt702kRhMYbVa9okq7XI
	 YoRB30+NKfaD4Wqgjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1ttNnx0huF-00La56; Sat, 01
 Feb 2025 12:19:34 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] pmdomain: bcm2835-power: set flag GENPD_FLAG_ACTIVE_WAKEUP
Date: Sat,  1 Feb 2025 12:19:26 +0100
Message-Id: <20250201111926.31278-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eHSujGayAUVb5qsQ4zzAxxtzVidue2urGLApdidbuvcCD7Zolav
 VE0f6w/ohqfSkyFLFPrkGJ0oAQm/7TMiPJgguYBBEIrCYMWO0HJFljc5yS3pIhwaWAK1cHn
 oPtxhUiQUHFC1ofN6/5wpm86ZbtW4AfaaXKF5sggSo+hbM9mecwsCNR76BIuM9jprJZKJ7+
 n/0wE/wbp4tLtOGkvNfHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PyBjBBj9g3c=;0KkeeFHr9XmW6JZlFronhZf2nxA
 Dpw6Qm5Cu1++XqJ/vVtJcyXcon5fPTosEwdwbEu2qKRbp2dimMbGtQjinvqQH0bBZl6SaywVV
 vSQkN5u3JT7zTzup9Q0gATpoDwpHP8Y1WawTwaTozgrk2cHuCLglIv2Ru4XfEFF/LHWZFmBRz
 6LEvocpZNz6TgbpFu9YD4cPJui1LRwnM69VBaTf18jN5NpNKq6JkGtC71X5I7X08J1Mh0QZD6
 g9kDsxJxc9HzTRlWeOV2JQsD0c4CGfhKyufHVWFMVNZ9gL+ylzTApYytJck7ITLwlY4phFmw6
 qcJ9nuXy6lMjWuzCee0/FBu219GR3kQ37XtfExIX4YObiaMRUQoeUr6G9TyumaoDLNoPm9wg7
 ynwgblJ97Txft33qaFiSS68aYcAnzifBjP3ei2+QO64iQUwcQjPrFVF1cHpl9yyS+E8Rujaim
 5GmKdUbExQ5h/DeaO3eHejEnWKRStmIHag9zTgs9fJhOTEP4YBsysx5yQH3L+rBFJpjtqR8P9
 aWYY5AhB/IJk04zy2OiV4OkrkH5eNh4ul8edqPe6JkscEiutMO09PFUYj8Q88Drx86nyq+aw+
 ajespB//APZYfNDOZrPYztHv3vPzX6ix0Nnxpt9ktxrY3cmup6Yr/HT1JDPJm9uxwoQKH1xgC
 FvVX+TU0YJnTpD7f6K7LkdFkeTgMM0oyv/wc1TrI1/tuYG8M7OxOfWKtzEikujWlta7DHC3Ac
 0dEmim1U6t9rO+zCvOSosw/GGNl/7ABPMaqntMku+ymdE7j96Qs5AuyEBkG3LF2V/T+FQRuWH
 i5Lmy4up4bNbThD/6Z8bVeD0JPI2+nkfHKsSxjs0N/uxdH4oJO4S1SC3aKI7831TOLXTqavgv
 A9W/Osm1bigLWOPtLZ1aafEZdjBnPLTO4Fzusqys6gLaMksPVcodcifyI1QUSxgaTlV8Egr1O
 3SJgk981w9Um11gXlhW/3/fx195aWEq86dXN4QouIvbWQkAhonDPpE3a1GO6SsE5Jysxw3KHO
 w/8Fu06buEKhAe+0Z1GmEwBN+xdOAhh6Z8KiDfsRtpeCayn2XpbyHhwDIQOl+eu7Q0ttKL/i0
 va/lKKLEyxSs/0A8X/Gpu+xMvktw8zT36F+AyYhpu4oO7XRnauW7hwoZkIBE1/lL8YRg1QdEt
 rXCbEFPtKcLelCbrUPCe/WS4sw3CWbmQp0UGSu/URqk8GWD8XWOVUWEsYZTwzBlx9dzqYPrmO
 Yp4eEMb+y5RbKImUIfzJMC6Qixoj/kkzSqxKaZmnf1UtmWJM9DsQt2H+b0TY7jtzyz1OKa1ah
 CMt+02QHa8XRcqltkU5zGxxlkiOfVqcA0LXmyUECUe2Ujw=

Set flag GENPD_FLAG_ACTIVE_WAKEUP to bcm2835_power genpd, then when a
device is set as wakeup source using device_set_wakeup_enable, the power
domain could be kept on to make sure the device could wakeup the system.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pmdomain/bcm/bcm2835-power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/b=
cm2835-power.c
index d2f0233cb620..d3cd816979ac 100644
=2D-- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -520,6 +520,7 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
 	}

 	dom->base.name =3D name;
+	dom->base.flags =3D GENPD_FLAG_ACTIVE_WAKEUP;
 	dom->base.power_on =3D bcm2835_power_pd_power_on;
 	dom->base.power_off =3D bcm2835_power_pd_power_off;

=2D-
2.34.1


