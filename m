Return-Path: <linux-pm+bounces-38071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09DC5EACE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7418A364A7D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539F2C0274;
	Fri, 14 Nov 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YWhFOohS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89936285CB2;
	Fri, 14 Nov 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139746; cv=pass; b=CWLvTnKUD/uhql8VaXlZYQzgOCR+k5j59P354dwypdmGvGAiP0JXXeXjHi5HXUZRwplG0OXRo2F+LqYvlm0n4MCfqTl+z9l8oglnAUbqEsEtbx1TAWAyHca7KMcMSg73JYJYSqJGTJZJFmz3WPthvbTrIS5xUW5+gDxhcVWnrqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139746; c=relaxed/simple;
	bh=khMN5Ms1UyKeWOn8LdRhkIibQEsiI7EMdFu82kxmGFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tzBY9F2I7qp1+sjrRD9bcDAXpmpyirMwCX9tSMMtWihrw0ete9TPGqL3W/1GUqbj6w0mBOAEu84eQNbh8yy8VN7WVWQhmn2OwWsMB+NcRAI7mU0d0hxQTLQsip3rt21cyti8Kk+sMydDoO4FjxGutFv29/172ymaO05hcGFLNMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=YWhFOohS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P1zbySLBMoTuYWFzBJXE0e3U9S9ADb62KIYeWDu/hnFXM/rhr8nqeSPeVlb4n6oD0iydHND9ZBg6Qvcy7mBNwpNIppqyBXmiRpKxcyMq2mpHIkUFhZ/mob1UwQZBhE9VTYTkEzT7EO76CMqAS59cAjG1EEj7Z+xHZ8KqsC5yUDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139246; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/H7GHzQdEVJHWL6IxnBg2c0IP7Sxxl00BJqFqnDMZQs=; 
	b=n83DtCqhT9N/20fxJEKKf6WmBPorVU2gHXJBVnRLL1307/U0xu6Q6Kcpw7hzvbMXNGol2ZdtK8msFdmli9QPYTCqTDwBCbDMRlh7TOuhA25yREcmDeP98fl42xF+qJJwKNXHK8MkcVqUVtQlG1+Dhv3Wp0XZsv2ggh9aPV8UUpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139246;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=/H7GHzQdEVJHWL6IxnBg2c0IP7Sxxl00BJqFqnDMZQs=;
	b=YWhFOohSBAKRoxsUW21p5utSu/GZuw1B/PQeLZweWzonb8DZSyqcol1yKIoqASw8
	rq66EqlN00hohSvpAVQYg68kpoTsUYsh0CO95Xuz6o+Fg/cZ3hJsh49o0iOBlq5GzWu
	xqS+Ip85MTQdnd+iOfq2PjkcA9yERrHw9WL7XuI4=
Received: by mx.zohomail.com with SMTPS id 1763139243754487.4274112916788;
	Fri, 14 Nov 2025 08:54:03 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 00/13] MediaTek Interconnect Cleanup and MT8196 Enablement
Date: Fri, 14 Nov 2025 17:53:54 +0100
Message-Id: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJeF2kC/zXMQQqDMBCF4auEWXfAEa3GqxQXNk7aWSS2k1QE8
 e4NlS7/B+/bIbEKJxjMDsqrJFliCboYcM8pPhhlLg11VbdE1GDIPdkrzqtP6rC13vW2oq5rHJT
 PS9nL9vNu49nK709h8znCfUqMbglB8mAibxn/NIzH8QURFBY6kAAAAA==
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
base-commit: d8a3d478ec9200b852095cb96d166ca7909f57e0
change-id: 20251114-mt8196-dvfsrc-59fc8901774c

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


