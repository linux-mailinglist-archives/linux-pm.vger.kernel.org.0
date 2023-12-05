Return-Path: <linux-pm+bounces-713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD2805852
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B38B20EC7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7D67E9E;
	Tue,  5 Dec 2023 15:13:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E616A9;
	Tue,  5 Dec 2023 07:13:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id DC2D9186C6E6;
	Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9eDwiS4dHQIg; Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 8F803186C626;
	Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DwjuzGuN3um3; Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.79])
	by mail.astralinux.ru (Postfix) with ESMTPSA id B6151186C6DF;
	Tue,  5 Dec 2023 18:13:09 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()
Date: Tue,  5 Dec 2023 18:12:20 +0300
Message-Id: <20231205151220.18463-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2e919694-e124-4864-aa02-01d47495032b@wanadoo.fr>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

devm_of_clk_add_hw_provider() may return an errno, so
add a return value check

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dumm=
y clock provider")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: replace dev_err() with dev_err_probe() as=20
Christophe JAILLET <christophe.jaillet@wanadoo.fr> suggested
 drivers/cpufreq/scmi-cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufre=
q.c
index c8a7ccc42c16..4ee23f4ebf4a 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -334,8 +334,11 @@ static int scmi_cpufreq_probe(struct scmi_device *sd=
ev)
=20
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
-	if (of_property_present(dev->of_node, "#clock-cells"))
-		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+	if (of_property_present(dev->of_node, "#clock-cells")) {
+		ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: registering clock provider failed=
\n", __func__);
+	}
 #endif
=20
 	ret =3D cpufreq_register_driver(&scmi_cpufreq_driver);
--=20
2.30.2


