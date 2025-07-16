Return-Path: <linux-pm+bounces-30935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFFCB07C50
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6363B03A9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A085285C8C;
	Wed, 16 Jul 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HhNaNUbB"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4427FB27;
	Wed, 16 Jul 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688310; cv=pass; b=BlTm4H+mXlljes3nlMqkD2L0FITBHxikUlhehpBdxIJl6f9yuoesZYXBl+RSz0IQLo/0HKeT9h/f7t1dkW0thjx7AAfTAVR/tMLq9GNgnzoQ9I8VWjxA1U+7GfTvTvdb+R7sYQIG7WKf1IbQp9uskzxIrnJC95nP5KJKIMkW3dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688310; c=relaxed/simple;
	bh=alaKDas8MDRMus9sH7e8520XXy6vOYLth97QDzDsgRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lv7IkgOVHm+pRsYseAulfr/fWKUh//PDM29zbg8ys/usdEc4uJUQfCvmQYOIkCaC6StS3uq/8btAviQ7vwvHBfMo3VnO5bEDVzDXbn0OqogSK8pXyIlV5qjRcbeHLGmxPoDEMq2hryvzAbJ4M+daV76LtGCOTGxxnWBw+9GKeSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HhNaNUbB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752688289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BzjyxfR2sL5YooFys1hSLwFgV5Sm9FoG0FemtBkXEAKG6I2OnnjyJfGstSzfW3ilq+as3aZXDL9k44vQxPoV14m2DIn9kGr5Jq1eL7eOA9JeBhKnUicozSkdGuCopXHDKdxa1F3R4RVbOQVAVuq1CRwjjETGHEAF+ZrI6uZsUyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752688289; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wscSEYkzCjiCD1rWTQtpVxiv5OUP/ktmu0maV3XJjck=; 
	b=e6akjULcjCqIES6Ari+sLBGklJ9vm2//Jno+j8er5Jr0x3Pd50LgG1OX1u8VjV67y0Z2Hy5iYUdDu3TZWWVwrybpNt0KGKftml6QDpd4X4f8z+xZs3DMwB9e4PVKbTzP2XWGo8yoGdC1lQblCVrICjOgA1U+KkQG/IdYR+PMwWg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752688289;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=wscSEYkzCjiCD1rWTQtpVxiv5OUP/ktmu0maV3XJjck=;
	b=HhNaNUbBnBFb8CuLSWUr+Vi1iuYcEv0KggRs39ilCf1KeXdIf88cnY6P9OA89O2p
	vu2jmeLf2GMjLjA1TkQEGDOcYmWa0LnwdWWgHueiTOStCV0xsngN4dqtsKCN6GPG5lz
	fMPkE3vJbNPXGSs6enLjmgkkDRDMDGj17yG6GRwg=
Received: by mx.zohomail.com with SMTPS id 1752688286814730.6421951900096;
	Wed, 16 Jul 2025 10:51:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/4] MT8196 CPUFreq Support
Date: Wed, 16 Jul 2025 19:51:21 +0200
Message-Id: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnmd2gC/3XOQQ6CMBAF0KuQrq1pC5TKynsYF20ZpAlQbAvBE
 O5uBRdG4/JP5r+ZBXlwBjwqkwU5mIw3to8hPSRIN7K/ATZVzIgRlpOCUtwFQU8c62GsHdyx4NW
 JU2ApIQrF0uCgNvMGXq57jmtjdMM+REp6wNp2nQll0sMc8Nvm6FVojA/WPbaHJro1/t2eKCYYq
 CIyVZnUnJ61bVuprJPHeGDjJvZJZD8Ei4TWIodCiDzXxTexrusTUdO5+CQBAAA=
X-Change-ID: 20250711-mt8196-cpufreq-86d961e2300b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series adds the necessary bindings and driver changes to integrate
MT8196 CPUFreq into the existing mediatek-cpufreq-hw driver. This
necessitated two preparatory cleanup patches to the driver.

The CPU frequency was verified to actually be changing by comparing
sysbench cpu numbers between fdvfs being enabled and it not being
enabled.

Enablement in the DT will be done once the MT8196 DT lands, so don't be
surprised that no node uses these new compatibles so far.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v3:
- bindings: changed title as per angelo's suggestions
- bindings: dropped the fdvfs magic register range
- bindings: dropped redundant description for #performance-domain-cells
- driver: made fdvfs frequency divisor a `#define` instead of part of
  the variant struct
- driver: dropped fdvfs magic check
- driver: reworked performance domain resource offset
- Link to v2: https://lore.kernel.org/r/20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com

Changes in v2:
- Split off mt8196-cpufreq-hw into a new binding.
- Made the fdvfs register regions part of the cpufreq "performance"
  node, instead of using syscons for this.
- Adjusted the driver to iomap those, and use the per-variant struct to
  add an offset for the domains index.
- Link to v1: https://lore.kernel.org/r/20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com

---
Nicolas Frattaroli (4):
      dt-bindings: cpufreq: Add mediatek,mt8196-cpufreq-hw binding
      cpufreq: mediatek-hw: Refactor match data into struct
      cpufreq: mediatek-hw: Separate per-domain and per-instance data
      cpufreq: mediatek-hw: Add support for MT8196

 .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        |  82 +++++++++++++
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 134 +++++++++++++++++----
 2 files changed, 192 insertions(+), 24 deletions(-)
---
base-commit: 4d088c49d1e49e0149aa66908c3e8722af68ed07
change-id: 20250711-mt8196-cpufreq-86d961e2300b

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


