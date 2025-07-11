Return-Path: <linux-pm+bounces-30696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE67B01FF2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B301CC22A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4912EA162;
	Fri, 11 Jul 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NQrPo/RO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99322E9EC3;
	Fri, 11 Jul 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245888; cv=pass; b=u+fp5BfQn+olsRJL9OlAq0WyiLzhWLjouWc/KZjkfu/TeL6CwNArPzsUmRBRgfaajtp3MfxQNQ8QPp8vvrGdU5diiEFy1ZnSbsuSDpKV7Da4quTFlqHNv+uxrjPdT8tESi/uHlZLDnqEivYFhnwgQJ97lXVGWWR3bVkhrFqFVqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245888; c=relaxed/simple;
	bh=b3eBR1H4nBDi8jkofVxCLTt5N7YnGgYhoVIt7L4QLUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XI9uZp6oa5JHiSmd76tzAsB3fvBNkT9iOq60Pa/I194bMICV8W6U7kpm+p509n3eygKd7QmiRgmm5FNxQs07vnAu3n8mT9qS0M9jcZbnPDLUT+kLU9tWc04M1XbkR+O6M7QImYFZZrE8wRGZeftBnK6AUc880cxiC5fWqw3tLwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=NQrPo/RO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752245869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gUISBzJNp/J3+ipDHhCGxFk4104DqECAChH3INJYk5klQJgaqZnvTQZqQYRzhxmCFyi9ncNOinnt9z6fuUJNaBpBhChpUH0BuuggJD2Rzhb1YoZxmqIxYHrTHzcBYkD6t2MlhJghqJHiB9kYl90rnzXloduKPJDo1rzEvUFjeyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752245869; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9PEARQKKf/9p+jlcrAMfNzhevLXRjyodsZ6OZ49W5QA=; 
	b=evHJ8Cyt4Qe7MK595+5A40U0HWg91GOOuRU7UvGFDQzYQS+g+pyyetQ2GWgxfz5U7bN40GhgqP9rRTcg9XTIcfw6QP28voIZOJazGP/n8oy8F2GpO8wnUvDdBEN9K/4yGhvviEc3pex2ggfUrSO1/LJDLq/gY3BPrTQjNpsntqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752245869;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9PEARQKKf/9p+jlcrAMfNzhevLXRjyodsZ6OZ49W5QA=;
	b=NQrPo/RO3TTaNvHv8m6D3Tbwyn+2J28Xf4GAYryCvri/oUV3aDFalTqMywaaoWH1
	tgiw2SmmnMNEEdXCdVWCBAr0qJhYfTEP3U6DDCJdB8GUrUPYOGqo4JrdLjqN8ilYLa5
	vFRpaJxp/Vb7/9mgrf4tVTaXO6YvwyWBUl/wgnPQ=
Received: by mx.zohomail.com with SMTPS id 175224586740314.377934690162078;
	Fri, 11 Jul 2025 07:57:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 11 Jul 2025 16:57:33 +0200
Subject: [PATCH 1/5] dt-bindings: mfd: syscon: Add mt8196 fdvfs syscons
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mt8196-cpufreq-v1-1-e1b0a3b4ac61@collabora.com>
References: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
In-Reply-To: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The MT8196 SoC uses two syscon ranges for CPU DVFS that are separate
from each other. One, mt8196-fdvfs-config, is used to check for a magic
number at that memory address to verify that fdvfs should be used. The
other, mt8196-fdvfs, is used to configure the desired frequency for the
DVFS controller for each CPU core.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..5ee49d2ba0cdb72dd697a0fd71c8416ad4fd2c1e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,8 @@ select:
           - mediatek,mt8135-pctl-a-syscfg
           - mediatek,mt8135-pctl-b-syscfg
           - mediatek,mt8173-pctl-a-syscfg
+          - mediatek,mt8196-fdvfs
+          - mediatek,mt8196-fdvfs-config
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
           - microchip,mpfs-sysreg-scb
@@ -194,6 +196,8 @@ properties:
           - mediatek,mt8135-pctl-a-syscfg
           - mediatek,mt8135-pctl-b-syscfg
           - mediatek,mt8173-pctl-a-syscfg
+          - mediatek,mt8196-fdvfs
+          - mediatek,mt8196-fdvfs-config
           - mediatek,mt8365-infracfg-nao
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon

-- 
2.50.0


