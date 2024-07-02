Return-Path: <linux-pm+bounces-10353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD6924140
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FC01F242D1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B01BA08B;
	Tue,  2 Jul 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grlDPDnN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF921B583F;
	Tue,  2 Jul 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931734; cv=none; b=JfcoQi2+Jip5UrCIldMTS9+Vbm35e27h/ojLThptW4VUSsh/DW8zJ2ph4LhGXd5Hm0i+5g42Oy7l5+SB62C6flENqMzWzlQ+/KLgpvaM74sP96UvYQFbrG5X5gvrC+L6XF7fo3MjzZETPbvQRnY3ScFkssQmGcPhIOJi6R4eujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931734; c=relaxed/simple;
	bh=6nM7P33MSykyTDjnm62rbDQplKtWiymkghofPsMaMPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dpcQxhLXUZ+xHm8VFSYeApTCXgeUnR5uNb7udtsnKCbCpLqCDTu3oCoumTUhh6yVNsn0bkyPY3Nqm3EOFaIptX7kbq6Sai1vxwpUZblzeiLMe4PPFEehrir/DkDAwmXt3dVUYJ42YeetU4kqxJtWXBVDqqxVz3y0YWzw7K0yZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grlDPDnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE7C116B1;
	Tue,  2 Jul 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719931733;
	bh=6nM7P33MSykyTDjnm62rbDQplKtWiymkghofPsMaMPA=;
	h=From:Date:Subject:To:Cc:From;
	b=grlDPDnNujQAEKfRF0P/1fSNQduOUujHvXT1bZDSV/dvZShvannniXiPSKpTgSbjJ
	 DEYv0GEF/+eiriFBUjwQ5d7YwjxCOoLyNTTamBFL3JCBLOmxhpF5kR4YnQI3hLxJ+a
	 752XPRKF2xSaQadJ/xN8GxOcWvztplosmWGBt6BT2EqNeVR1UewveC0G4Ykczn5qym
	 PnnYexgjtP0d7s1dQFgJEYzu/cmvINn8Ft7LsMZ1bAmq2ihB9aJTMJLDgVCEcSP7Ov
	 u1OXVJNcoTghUYo+Fciii+qwUbTrOLO+9wi6KX0WZCyAmWhfsrEDM57KSiAISRjazO
	 Lhv55qIKGXJng==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 02 Jul 2024 07:48:48 -0700
Subject: [PATCH] power: supply: cros_charge-control: Avoid accessing
 attributes out of bounds
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cros_charge-control-fix-clang-array-bounds-warning-v1-1-ae04d995cd1d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE8ThGYC/x2N2wrCMAyGX2Xk2kAtRcVXEZGuTTUwEkk9jbF3X
 /Dy+48LdDKmDudhAaMPd1Zx2O8GKI8sd0KuzhBDTOEYIhbTfnPL3CoqL9MJG/+wTJ7GbJZnHPU
 tteM3m7CL4ym1GtohxRzAh59G3vifXq7rugEPrgOThAAAAA==
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6nM7P33MSykyTDjnm62rbDQplKtWiymkghofPsMaMPA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGktwiH/eg+0M804/NP2ArtjWqR867/Gq+1Pl+6IXGc1z
 diJ+/bPjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARhVaGf2acfmnxi/M+ePeU
 ZWyvr2Sbuvyxi/r1mE/NL00yhDz+SzAyvOL3bJDUlYirufbaz2BT/8Rligl6UX8YIv9OkZuQ1by
 REwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/power/supply/cros_charge-control.c:319:2: error: array index 3 is past the end of the array (that has type 'struct attribute *[3]') [-Werror,-Warray-bounds]
    319 |         priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
        |         ^                ~~~~~~~~~~~~~~~~~~~~~~
  drivers/power/supply/cros_charge-control.c:49:2: note: array 'attributes' declared here
     49 |         struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
        |         ^
  1 error generated.

In earlier revisions of the driver, the attributes array in
cros_chctl_priv had four elements with four distinct assignments but
during review, the number of elements was changed to three through use
of an enum and the assignments became a for loop, except for this one,
which is now out of bounds. This assignment is no longer necessary
because the size of the attributes array no longer accounts for it, so
just remove it to clear up the warning.

Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/supply/cros_charge-control.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 73d7f2dc0fa3..2dd8ddbd56bc 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -316,7 +316,6 @@ static int cros_chctl_probe(struct platform_device *pdev)
 		sysfs_attr_init(&priv->device_attrs[i].attr);
 		priv->attributes[i] = &priv->device_attrs[i].attr;
 	}
-	priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
 	priv->group.is_visible = cros_chtl_attr_is_visible;
 	priv->group.attrs = priv->attributes;
 

---
base-commit: 3664706e875f84bd4e3fa25ed1c6e46934cb32cd
change-id: 20240702-cros_charge-control-fix-clang-array-bounds-warning-b84fd0f642a0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


