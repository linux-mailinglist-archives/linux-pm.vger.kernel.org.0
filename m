Return-Path: <linux-pm+bounces-35197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E99B95128
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820BE1902DF7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD12F0C5C;
	Tue, 23 Sep 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C/OJcW2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C32701CF;
	Tue, 23 Sep 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617560; cv=none; b=djrBfqvG/TO2SJHpDx2A9txUQ49lfHXzZ31sUlU0+KIjuepnw4/lh6APhl8mUYrjfhgcHBzkb4lsXDb/C2I0lJWhpbU4hDRESPAj71ksjNYxv3fHtnZ/FiN+7f6rCPmQDJ03sN9KR3LN1xTDy9e1YmeMWeA8A38fRgVii0P72G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617560; c=relaxed/simple;
	bh=eQ3bgrFsPixYkoX5WF8vxszDEQywePDRPFRChX8eSyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M5nFO4jk8jk4qFnUnauNn8SvXmqBBTXN9IQp0WCkhwxpgfg1hcz83v3yYw9JZhVMyUxjjqsKMIJ9GrcPBcup8TnXO94M+ZiE8RP5tp0VkdjkZM8dEAua+oDOPe7h6MovQum42R5Hip2pH/d4t4cwpH6hoL86y/ctcBj/2rUKcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C/OJcW2w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758617550;
	bh=eQ3bgrFsPixYkoX5WF8vxszDEQywePDRPFRChX8eSyw=;
	h=From:Date:Subject:To:Cc:From;
	b=C/OJcW2wr0UlSy5iTPEpZ+d530Z8l5Wsiq0TXn6L8RJwC7pO4y0epp/5S2uleH32b
	 bTh98ZZqQ/MjqrpDjYrEMMTuyg2a0Pa7cTQLtBeoiUedwGxzshq6Jdn4dUrG7w/w59
	 7MTyHyHK0u0xvxjYzOoKpaUfKjxfB+XDQzo1aVFIW+T4CRSDqYS00Trb/HTxc8/Qj0
	 L6ZLyKZDg2h8/l5lrcITOa5cs+GfbWTbI8tp3OUL7eyil/OXsMdT184J4JqwizbiIG
	 g6fFxWcI74qHIjUMz88+PBU+GOdj7tkT2LbxvByV66mg+Ud8iY2m8u+nVNjUTLs8A4
	 gy3RQdZ9GqUtw==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CFC617E0299;
	Tue, 23 Sep 2025 10:52:30 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 23 Sep 2025 10:52:12 +0200
Subject: [PATCH] pmdomain: mediatek: set default off flag for MT8195 AUDIO
 power domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
X-B4-Tracking: v=1; b=H4sIALtf0mgC/zWNQQrDIBBFryKz7kAUpEmuUrLQOKazUFM1IRBy9
 0pDl+/B/++EQpmpwChOyLRz4RQbyIeA+W3iQsiuMahO6W5QCkPt5aBxDS4FwxHN5jih5wP9k6x
 XxlupPbT9mqnp3/drujnTZ2uJekuwphDOKQSuo4h0VPxnYLquL3bFntucAAAA
X-Change-ID: 20250922-mt8195-pmdomain-audio-fix-f7ebf2afb15f
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758617550; l=1485;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=eQ3bgrFsPixYkoX5WF8vxszDEQywePDRPFRChX8eSyw=;
 b=lG8MR+Jilqa9YvJI4g5WNbwG6A6UqK+1dxOy1mukQ6zReDxsF9ZSp8MjJSLdz7dYlCjb+gHTw
 Ei7/kDTc2ZOCZjuWhIC+g/nPNVHDq3IGkwIKz2djC75wH2f9j8PQ85I
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In MT8195 power domain data array, set the KEEP_DEFAULT_OFF and
ACTIVE_WAKEUP flags for the AUDIO power domain entry to avoid
having this domain being on during boot sequence when unneeded.

Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Patch tested on Mediatek Genio 1200-EVK board (based on MT8395 SoC)
with a kernel based on linux-next (tag: next-20250922).
---
 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
index 9405e8f62eaf07112d52a28e6545d26a4342c7c6..1d3ca195ac75806c458db71db4538940f37128a8 100644
--- a/drivers/pmdomain/mediatek/mt8195-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
@@ -126,6 +126,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
 		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT8195_POWER_DOMAIN_MFG0] = {
 		.name = "mfg0",

---
base-commit: fba389ea7aa6401d3539456123cbadfa1a87231e
change-id: 20250922-mt8195-pmdomain-audio-fix-f7ebf2afb15f

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


