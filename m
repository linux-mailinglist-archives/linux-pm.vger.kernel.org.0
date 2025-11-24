Return-Path: <linux-pm+bounces-38452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCFC80228
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231C03AC6E1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63822FD691;
	Mon, 24 Nov 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QBfhIGEz"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92C3002DE;
	Mon, 24 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982484; cv=pass; b=tmrc9h5NMd6JbSn82eBrPpd8W/xY80VlG1/ZXqLZmPCM5QvOOqUOXDebyBFO6+kIsxiJmf/LDp6LdaGQaisl3TUC1BsliU7Si+MPuulUybLB4T9O5Rigp7jHpp/VTv1vM8jKzyGAxh+q1fJ4TNmS8XHffBuWIjy3RptIY+K7ObA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982484; c=relaxed/simple;
	bh=lboeIQyFJsiIxyOxs1b6G3MZaP6IONXoWfuN9akxXyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ICWOqiC/s0LivoAn2rxbvokBFHl/dShbkYHsbrugQJEb8i4DqAagvKbJrqads9NfO9PvcRD9fx3LIuM3B9F3Bl1m0a09mlyz+9A/e1kW9ESoL50exm7OaR7ORaNNIxF7cr8KdxrNQZzybTJiEJzoXG7jwHYW6cXWLF+vqaUMJho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=QBfhIGEz; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982419; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nbDevhZXipgAYTYG3F2UDABCIZ+nOxdW/zlkaLgtplL1wZVsArQ34mLcPScPgiCAwttcVNasSU2fmuQL7cdRe0XfOhyeAniPRBHbt5rBeifVcFpUrJ1DX7G70A9b+uZYkC7PWmO3iXtqb1GAWtvJKIZpUiaW0cb2VktmaDQdG1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982419; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cLutaMhuDx5x+G8Hu0peOOGA7peMIDFit+69TXksySM=; 
	b=CZrzUP5E2dBkPEAm89UQ/cQTapze93y1KKN+Uv/HE3A9W7vE8sBNVQsLGtsHPWxDB3XL4pqrn9Bjf6kF7oudM7rT9YXpX6UfJGKrW0zqDCXAd6gJRDmRKj9pXsK18cH8WwxLmv5oG5u4C7VGCVs4uUPb1W4WvAdY7bj7zpAKPxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982419;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=cLutaMhuDx5x+G8Hu0peOOGA7peMIDFit+69TXksySM=;
	b=QBfhIGEzZO+KWlqnDgMHea9pkH6AtFFt9z8WYyj01TeYQsQJb7mYgxjdxCxdgICo
	La793j4LDvoZ/KHHHIWEM//QnOqPQeo3Tw7pgizCiEnx4++iB9Fr+MFND4z64SpxrHN
	rzOvPB2Z5t+bQn51KqNZ/RJhWA3QfiFljGzpN5Mk=
Received: by mx.zohomail.com with SMTPS id 1763982417218939.0906098160897;
	Mon, 24 Nov 2025 03:06:57 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 00/13] MediaTek Interconnect Cleanup and MT8196
 Enablement
Date: Mon, 24 Nov 2025 12:06:49 +0100
Message-Id: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEo8JGkC/3WOzQ6CMBAGX4Xs2TVsLeXn5HsYDqUUaSJU29pgC
 O9uhbPH2WTm2xW8dkZ7aLIVnI7GGzsnYKcM1Cjnu0bTJwaWs4KIOE6holpgHwfvFBb1oKo6p7L
 kCpLzdHowy967tQc7/XqnbDiO0EmvUdlpMqHJZr0EPNKM4CeMxgfrPvs/kXbjz3QkzLGrC9Fzc
 SEuqquyj4fsrJPn1Id227YvQscW2N8AAAA=
X-Change-ID: 20251114-mt8196-dvfsrc-59fc8901774c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

This series is a combination of binding changes, driver cleanups and new
driver code to enable the interconnect on the MediaTek MT8196 SoC.

This series currently does not add any users of it (i.e., no bandwidth
requests being made in affected device drivers), as the only one I
quickly whippd up is in the UFS driver, which is undergoing some major
refactoring upstream in a different series of mine.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Added missing submitter SoB (i.e. mine)
- Link to v1: https://lore.kernel.org/r/20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com

---
AngeloGioacchino Del Regno (8):
      dt-bindings: soc: mediatek: dvfsrc: Add support for MT8196
      dt-bindings: interconnect: mt8183-emi: Add support for MT8196 EMI
      soc: mediatek: mtk-dvfsrc: Change error check for DVFSRCv4 START cmd
      soc: mediatek: mtk-dvfsrc: Add and propagate DVFSRC bandwidth type
      soc: mediatek: mtk-dvfsrc: Add a new callback for calc_dram_bw
      soc: mediatek: mtk-dvfsrc: Write bandwidth to EMI DDR if present
      soc: mediatek: mtk-dvfsrc: Add support for DVFSRCv4 and MT8196
      interconnect: mediatek: Add support for MediaTek MT8196 EMI ICC

Nicolas Frattaroli (5):
      dt-bindings: soc: mediatek: dvfsrc: Document clock
      soc: mediatek: mtk-dvfsrc: Get and Enable DVFSRC clock
      soc: mediatek: mtk-dvfsrc: Rework bandwidth calculations
      interconnect: mediatek: Don't hijack parent device
      interconnect: mediatek: Aggregate bandwidth with saturating add

 .../bindings/interconnect/mediatek,mt8183-emi.yaml |   1 +
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml       |   7 +
 drivers/interconnect/mediatek/Kconfig              |   7 +
 drivers/interconnect/mediatek/Makefile             |   1 +
 drivers/interconnect/mediatek/icc-emi.c            |   9 +-
 drivers/interconnect/mediatek/mt8196.c             | 383 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 364 ++++++++++++++++++--
 include/dt-bindings/interconnect/mediatek,mt8196.h |  48 +++
 8 files changed, 785 insertions(+), 35 deletions(-)
---
base-commit: e93f8002e4d244f0642224635f457bc8b135c98b
change-id: 20251114-mt8196-dvfsrc-59fc8901774c

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


