Return-Path: <linux-pm+bounces-39484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5CCBB58D
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 01:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62DB0300A1FF
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150129B239;
	Sun, 14 Dec 2025 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Mj7UgFaa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81BC8E6;
	Sun, 14 Dec 2025 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765673963; cv=none; b=bBMVCAuQTaR0PSqWb6KODPjuX79URvy9q51xkMhQs9UrVQVuC7iCeRVbLiXB28GQifaOIk+DrxDM8woBXcsBiCWiiZ4uH7D9WHNNCNFEWKaApz991MA0fhrq0zhRhvYEcUleYgimPCjzj9kU/l4w0/Lid9KHoveTjBZvZXu1mL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765673963; c=relaxed/simple;
	bh=MmMri789bHBL49KFY6CpsBl1jyMPK2s/bjCpLs47/RQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nKPoTdu00rvlaC49zudTmA6LSk23x3jzh3D3vZ32cAU1Hk55Q1JisU9KeWshbI+IVG15Yvc84+0ZySHrEBCxxCo33xGzaMqwPl8aZVvDgv5wmSafNtQN0rZt/+ql53t/1AjUHAgQ3fzrOrj1YoxrNjtP2MC1s4HjdH+vJ/2ybIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Mj7UgFaa; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1765673952; x=1765933152;
	bh=/53OQBAeaDRRKjQxg4r3Ebr8yM/t1YmMI2PruI58Bxc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mj7UgFaadtl8ySAwO2WcZ883Cuji1HsX5J3FDsF64yMnikFllHU7/gzGBsjg4QqQl
	 PHDEWfyBuMYhh+hgKukxH70SwRInKv5h/Dx6MT7FAsu9nX9kH5pXQT/qFSRS2EKURd
	 hq7qqS6V+dlWjew2Z8hUgiJhaUlIIGFqQoSdaavsD0VnCJgpRJPkPX1RPPenfxEpVW
	 xQ2yKPG5EiPAhtPCn7yTDl0jrLyFGPg1NhlDYpnXL8C13AkzAyfWWL/vxpR4RbwEp+
	 fs/uF3AR69EIpLyCn1ZmjsXBVPoDxIC9OQFIidnzMJSc9gDNDdjJitPBmujN5f+4gI
	 WdnEmAzuM5+tg==
Date: Sun, 14 Dec 2025 00:59:07 +0000
To: Sebastian Reichel <sre@kernel.org>
From: Alexander Koskovich <AKoskovich@pm.me>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH] power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write
Message-ID: <20251214005903.2802724-1-akoskovich@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 32db5809ab9257c4edda1efc620c82639249812d
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some platforms expose reboot mode cells that are smaller than an
unsigned int, in which cases lead to write failures. Read the cell
first to determine actual size and only write the number of bytes the
cell can hold.

Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot =
mode write interface")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/power/reset/nvmem-reboot-mode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/=
nvmem-reboot-mode.c
index 41530b70cfc4..9627c78e0e86 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -19,12 +19,22 @@ struct nvmem_reboot_mode {
 static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 =09=09=09=09    unsigned int magic)
 {
-=09int ret;
 =09struct nvmem_reboot_mode *nvmem_rbm;
+=09size_t buf_len;
+=09void *buf;
+=09int ret;
=20
 =09nvmem_rbm =3D container_of(reboot, struct nvmem_reboot_mode, reboot);
=20
-=09ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+=09buf =3D nvmem_cell_read(nvmem_rbm->cell, &buf_len);
+=09if (IS_ERR(buf))
+=09=09return PTR_ERR(buf);
+=09kfree(buf);
+
+=09if (buf_len > sizeof(magic))
+=09=09return -EINVAL;
+
+=09ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
 =09if (ret < 0)
 =09=09dev_err(reboot->dev, "update reboot mode bits failed\n");
=20
--=20
2.47.3



