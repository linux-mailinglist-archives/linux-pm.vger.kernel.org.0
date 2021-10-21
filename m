Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7F4362B9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhJUNWS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:22:18 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:43317 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhJUNWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:22:17 -0400
Date:   Thu, 21 Oct 2021 13:19:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822397;
        bh=GpiB0I+KGCnyy1lCsiKsCapszoFphoofSjyFZ0nHIGs=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=E5qvC2u71WXT6csjZ0itrr0L8SovrB1cxWgv9Fc0Bs5HopIdb3/8pv+GKh6GMR4O3
         nD6mk+65KGPib1xgOXxJ7x+JVrrNQQvTHs+IrDUosvG4c+XcwyIy0R1EVhQ38bJy/f
         uCozGkhJivMtn8DRDBuFY546W4G1w3YDKSiXWpO0=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v5 2/5] interconnect: icc-rpm: Add support for bus power domain
Message-ID: <20211021131839.234662-3-y.oudjana@protonmail.com>
In-Reply-To: <20211021131839.234662-1-y.oudjana@protonmail.com>
References: <20211021131839.234662-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for attaching to a power domain. This is required
for Aggregate 0 NoC on MSM8996, which is powered by a GDSC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 +++++++
 drivers/interconnect/qcom/icc-rpm.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qco=
m/icc-rpm.c
index ef7999a08c8b..6b918d082ab6 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
=20
@@ -340,6 +341,12 @@ int qnoc_probe(struct platform_device *pdev)
 =09if (ret)
 =09=09return ret;
=20
+=09if (desc->has_bus_pd) {
+=09=09ret =3D dev_pm_domain_attach(dev, true);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
 =09provider =3D &qp->provider;
 =09INIT_LIST_HEAD(&provider->nodes);
 =09provider->dev =3D dev;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qco=
m/icc-rpm.h
index f5744de4da19..fd06a3b9e3f7 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -77,6 +77,7 @@ struct qcom_icc_desc {
 =09size_t num_nodes;
 =09const char * const *clocks;
 =09size_t num_clocks;
+=09bool has_bus_pd;
 =09bool is_bimc_node;
 =09const struct regmap_config *regmap_cfg;
 =09unsigned int qos_offset;
--=20
2.33.1


