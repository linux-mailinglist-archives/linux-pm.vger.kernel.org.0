Return-Path: <linux-pm+bounces-37099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7293C20322
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E493AA008
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C822FE0E;
	Thu, 30 Oct 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HC7j2p0A"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBB22B8CB;
	Thu, 30 Oct 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830264; cv=pass; b=j9MftS4U/j/8h/Q+zxs8seW7gUtZKz1L+duvAiLCfaHqSR1sdCEOmF7Qc4ftABJRcFGfZukHNEQeJ+R7Dlk3n8WFZ7hYcY4hT+7+JhxrfYytaY0HAtj0eIBqUkTjJdYJqzRv6J1jiL+NpmXYZkYPwCP/wlVVyjh9nqJei+9Txrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830264; c=relaxed/simple;
	bh=TpvipFPL4XszV9vrC4IN6hE59uSeRT6tFNh3013ZQNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GTP7E+aEcMAyObfjpY/XEF+c//bk/gTdzB/OwktK5UNPQ4szOY40DQ+5QFv04DPW9PGdUO3MvM3YI7WlQIy9TQQUaz+F9Bl44p+bHNbPuu5Q0XpnDz7O4tZprpuXUID180XpLzKVazd/iDLyggesF15yJT1iJR7kn2lP6qw/doc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HC7j2p0A; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761830243; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bykFlocPyOEv6VJ8hGJ+2SlM+xv5ccun8eDeb4CYDlJ4o5ga5Un/K8leZovV9noOiAjw5Uvj5SiLsrRDkQBi3iNgnn4eiiq+NzpPfPBHqfb21Z7TJmCFREStXPu87hZl0wfYt0K/xs8oeUG2So3YXKnoqyPVdnwf3Vle+uJZ74c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761830243; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X8vmjhEGyAb9Q+g3zprM6UMlHqaEvwlEm446UF+Fb5E=; 
	b=TWYhI7IamV4ShVe5DfQv8czH5tnOKVadQeBdwRkjabBS6oV7ddLysULY//VHCn9xurf7/xkOqB+7ABr42PROAjtZ5uLe9LUqvpD80fQFu1054K1+wk0yO61EaWIJBPDlKB8isOH8WQLOOAnVgYjqZ40qc8xoPpjSeAJBIV5QMvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761830243;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=X8vmjhEGyAb9Q+g3zprM6UMlHqaEvwlEm446UF+Fb5E=;
	b=HC7j2p0ATKIKWHZ46ymqF+vJrTlNWIOnCOOYqQO0MMDfr6lfyrD0Z80kqZhYZVSV
	lWO+hfdud/gLWlY2kAE83UVYj+aKhjGkSl0yKAtdO49d2EavR4alyJvyx6l1clowSsp
	A8gD2CwNk2qC14FSAv3NvKOgIVOHYmGIr1uEBE40=
Received: by mx.zohomail.com with SMTPS id 1761830240160609.6007241076173;
	Thu, 30 Oct 2025 06:17:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 30 Oct 2025 14:17:10 +0100
Subject: [PATCH] pmdomain: mediatek: mtk-mfg: select MAILBOX in Kconfig
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
X-B4-Tracking: v=1; b=H4sIAFVlA2kC/zWMQQrDIBRErxL+uh+MoV3kKiULY8b0Q9VUbRFC7
 l5p6PLN8N5OGUmQaex2SvhIlhga9JeO7MOEFSxLY9JKX3s1KPZuZW/kOcfKCzaGHTRc+3Az1Kw
 twUn9Fe/TyQmvdwuXc6TZZLCN3ksZu4Ba+B+n6Ti+3kVVl5IAAAA=
X-Change-ID: 20251030-mfg-mailbox-dep-ec32ef510e6a
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, kernel test robot <lkp@intel.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The mtk-mfg pmdomain driver calls common mailbox framework functions. If
the common mailbox framework is not selected in the kernel's
configuration, the build runs into a linker error, as the symbols are
absent.

The hardware mailbox Kconfig system, MAILBOX, has no dependencies of its
own. It's therefore safe to "select" it rather than use "depend on".

Declare this "select" dependency in the Kconfig for the driver.

Fixes: 1ff1f0db6aec ("pmdomain: mediatek: Add support for MFlexGraphics")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510301311.TcOCnZ1s-lkp@intel.com/
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
I assume this can be squashed into the mtk-mfg driver addition commit of
the maintainer that merged it.
---
 drivers/pmdomain/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
index b06aaa9690f0..8923e6516441 100644
--- a/drivers/pmdomain/mediatek/Kconfig
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -32,6 +32,7 @@ config MTK_MFG_PM_DOMAIN
 	depends on PM
 	depends on OF
 	depends on COMMON_CLK
+	select MAILBOX
 	select PM_GENERIC_DOMAINS
 	imply MTK_GPUEB_MBOX
 	help

---
base-commit: d78b0fee454c25d292fb6343253eca06d7634fd9
change-id: 20251030-mfg-mailbox-dep-ec32ef510e6a

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


