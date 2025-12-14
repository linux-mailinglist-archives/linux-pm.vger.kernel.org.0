Return-Path: <linux-pm+bounces-39492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70312CBBF66
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 20:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 600323008F80
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC9C2836A4;
	Sun, 14 Dec 2025 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="I5RUS/D5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345293128B6
	for <linux-pm@vger.kernel.org>; Sun, 14 Dec 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739791; cv=none; b=NTlw92fzV74FPoldQcdYak5qU4nmUa9z5BHk0uJRJApsCX2KBD9HSjJn3afrWk0plW46u3+JEvQLQtaNmMRrL2tbfqI2WPtxNhwaTkLsy2QTR3Hxr9ZdygUqVe0OpqIL1QcM6qkcbalnwLQyitBEO6TIto2kdy9kK1J9ZuZHs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739791; c=relaxed/simple;
	bh=SRjG1SLbCHXTM9MSvLvYXkDYr/JQi8GpBQyNV8yzFAs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jvjmnk0KxeH3smyNbPpT0857ygNmm5+GaMlc35TzTWHM/rVQTCwb7wbkaKAW9OeU8EhHSxT9+WHIr2VB7wwCDCnURYGN3mUfZ73RGnvil6xNWsUWGgWZ6fHjaQM5n6FMUhoLCl+N1HFtLCH0X9sNs31VvzVmeelQNOxzTKPAfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=I5RUS/D5; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1765739783; x=1765998983;
	bh=JiXfij5hcpLZ0UEB9sJ/hT6miBeb4p33U/1mP5QVbdU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=I5RUS/D5cPqJpVqQdvYK1fk5U8JFbVUKx/KDdbG53gYEAiyVyy3zU1TExs9786Lo6
	 gamQejrdnhAUi4Kkbpo9yViQAiwcWb/1nO0M3BiQusRSX2TwuViDNK+uV6qjtlRZ5I
	 4Pz1GhUOhDAECi/VJ9ufYjdtimtkc2JuLKsl1tYmhUB0NTvfi2z8K4GaAIS9rOfJd1
	 aNTIq/DnPiTSvu0WGXtN8xyoVasBiZ4bF0yA5xsqrnsatXPrUIPvTbxl4ftFREYBOY
	 ywuZ5UGJH0HmwyAn0Imnv6Wl15nL+zgoD+WidchBaKQHGbtTEWXrILVO7KVaX614Di
	 wCxSJOLk+SCyg==
Date: Sun, 14 Dec 2025 19:16:18 +0000
To: sre@kernel.org
From: Alexander Koskovich <AKoskovich@pm.me>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v2] power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write
Message-ID: <20251214191529.2470580-1-akoskovich@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 6ba3f6b22900e67dfffb2b6d9e4da86e0368d7c5
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
 drivers/power/reset/nvmem-reboot-mode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/=
nvmem-reboot-mode.c
index 41530b70cfc4..d260715fccf6 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -10,6 +10,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
=20
 struct nvmem_reboot_mode {
 =09struct reboot_mode_driver reboot;
@@ -19,12 +20,22 @@ struct nvmem_reboot_mode {
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



