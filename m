Return-Path: <linux-pm+bounces-30799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD656B04103
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B1916F3A2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7625487A;
	Mon, 14 Jul 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HIOJx1ie"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4F220F37;
	Mon, 14 Jul 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502135; cv=pass; b=lheG8HFMuppSH3YDe1VCeRJgrw8vU0rny0GK2FI7yxOwH/fZhwnzok6PoX6f+SMCHnzMofb0yh83vZ2kPHEdw2chKUe3BrEA3vP++pAB2D5GH9NF65OnPscIgKkrnRRcqWmCPVyFHDcpwESFZJDa2bbVnHqcr+/+m1i2j6cYt/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502135; c=relaxed/simple;
	bh=xLFbyTFCTxrCXZ95YPjgu/bL8oOLmSYGE/MNEiwAZds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kF3laAE/w234PRHGmCBGXeAPLP9TIGxqdaAeHTMIC/+vvD2sWjhCTHXgrDk0MqEp9r+hqsxsU37qusL8SPbD8Ri1g+KTq1LbT3Ds/5v39lObfDAAFGN/7Q8zbxwxo0Q9EEU8oa7b7wVj3ddbhJzG+FiadOD7xXM42M0Sc5VJERw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HIOJx1ie; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752502113; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=isFHrMBvNV2bj1Umer9yVPRNpy9byQsWJMwa1C+2rh98ZgJ+TOGyXF7chB4W7PyrBKSg52TOY3mOKm0ujaLe9Ctc7jL6VUifuuQa6K/oaZHB55ZY4YOTEBTY7+1VUCv+VGH8A8tuPX1SbZbJLNC6589xu64h6+CwcbeE2w0Z2Ik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752502113; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4enJ+FUcyrsek9i62JQgGkkGMLGdyoOHqn7yVutegJQ=; 
	b=gWSdNNNe5QyHlQJy7ENFYoAeH8fVaBG9Ru3taDUGh3Tt+VaTG/OwA7HRCiGJWZKQvYwsrZnoqVwqd5Dsxk2jMdMka/pDmmRix3LhT766Zvph7x5GMFq5YxVJWGNwlw+ao2PMsaluFVgt2HaYzaKzC/RFp7wFh7ty0Hoq81pDvuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752502113;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=4enJ+FUcyrsek9i62JQgGkkGMLGdyoOHqn7yVutegJQ=;
	b=HIOJx1ie34UXkUT/sJJDncuOWRfy8Jd+rEnzybLTRsOGiZfPIHJ25yBCdVMGu495
	kFnWcPxnkW8hgnqY6ES+1sEWMBS2agb9ECGQEbL07TME62CDPYBelSuEPqNYkN/846b
	6TSHllXEP3SrGjzDc4UHXegA/sMhTElfEeJZdsrM=
Received: by mx.zohomail.com with SMTPS id 1752502108974683.0687269745556;
	Mon, 14 Jul 2025 07:08:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/4] MT8196 CPUFreq Support
Date: Mon, 14 Jul 2025 16:08:13 +0200
Message-Id: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0PdWgC/3WOQQ6CMBBFr0JmbU2nKAIr72FYtGWQJkCxLQRDu
 LsV4tLl/5n3/qzgyRnyUCYrOJqNN3aIQZwS0K0cnsRMHTMILq78hsj6kGORMT1OjaMXy7O6yJB
 EyrmCCI2OGrPswkd15Hg2RW84SlDSE9O2700ok4GWwH5u+AKt8cG69/7QjDvxb3tGxhmh4jJVF
 6kzvGvbdVJZJ89xAKpt2z6xL5So4QAAAA==
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

 .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        |  86 +++++++++++++
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 139 +++++++++++++++++----
 2 files changed, 200 insertions(+), 25 deletions(-)
---
base-commit: 42f78243e0c6fe42f2710f98513a55c102347ff0
change-id: 20250711-mt8196-cpufreq-86d961e2300b

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


