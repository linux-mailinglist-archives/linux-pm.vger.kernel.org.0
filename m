Return-Path: <linux-pm+bounces-18962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9739EBC46
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D97161225
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1723EBF9;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VDlq5BaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553623EA66;
	Tue, 10 Dec 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=LIxWdTHLW37XDIFmFd+jGSgN29KbEdZ8kWeGAtJM1E5ogG/kQHoeZEFVLW09fDb6jlNaRNh+vq2auNkvcjQAYil2lQsg076bqXvUJExZPO5VrWRvHFWZ5LuQm8RkYdn0PCLiZN4Y5hC2ev4ueaxWrXgYN1L+l8+YXM4X17z3b/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8NmmwuPomqugbIpZaL/jxnCujfcIN+ysoCdiY6Duy3Z33klSCUc5pgG6/c5ULhtzlTfBDRjz3d/SKDHQ8NqiPuca4UW3F1DcjpCt8O0rFxCpFAwjU8EUMiLoS1jqfX6WtN4n2+25RxD4jzEv5b4NYsYL/k9FJmO1dgT3OzVLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VDlq5BaF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VDlq5BaFajv91gOHXJHemtIUmGC+iRNpOM+dko6mhMUQXVJ/UDjsPeEjWZPafK4iB
	 a6SQilIUned5LzbFFVosdko1cRw8HOJIyMzeFeaCpJ2e55AwDKZoa2K3s94EBax5KA
	 W8Dpkiqwyuu9uZikOhXh8jSRspqioFQAYXLWRXlk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:56 +0100
Subject: [PATCH v2 09/14] power: supply: sysfs: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-9-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=2083;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
 b=t4mVL3xoebBvZ3szYMPvkuXjk6ytDDg93vSwP3Yt9G6uSINU2a1W6Piinuiclxg6QtKygHvPZ
 +2XMwJc0RxYBz3wEdXLEyI/eonuDxL0EL+Dx33jRZwuw+z9PRrJcLtD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 99bfe1f03eb8326d38c4e2831c9670313b42e425..85b5134b8552cc573724e4cd5794a598192d3137 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -274,7 +274,7 @@ static ssize_t power_supply_format_property(struct device *dev,
 					    char *buf)
 {
 	ssize_t ret;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
@@ -337,7 +337,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count) {
 	ssize_t ret;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
@@ -376,7 +376,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 					   int attrno)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 
 	if (!power_supply_attrs[attrno].prop_name)
@@ -462,7 +462,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 
 int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	const struct power_supply *psy = dev_to_psy(dev);
 	int ret = 0, j;
 	char *prop_buf;
 

-- 
2.47.1


