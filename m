Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9A3E8974
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhHKEhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 00:37:01 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:43306 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhHKEgz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 00:36:55 -0400
Date:   Wed, 11 Aug 2021 04:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628656559;
        bh=9j6empv2XRMFmRHvMFKKzDoh+j+Cz9yXvfVvcok3T7o=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=vm/GwqvtZ8/PRJyBxT3g9zmfRAjzj8dda43SpJRdQCOkfy3ToW9MR7uxzQZ6RwO4f
         R1Pq9wrTP0h3Hycoa4xtYX0HX1WVLCREfl4P/R4ptHzvmYlu0OgFRE3Vk1126qYt6j
         WeRneeJ0o178K+kUYvWdfkVmvqVCOkeu7Gb8czvE=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v3 1/6] interconnect: qcom: icc-rpmh: Rename qcom_icc_set
Message-ID: <20210811043451.189776-2-y.oudjana@protonmail.com>
In-Reply-To: <20210811043451.189776-1-y.oudjana@protonmail.com>
References: <20210811043451.189776-1-y.oudjana@protonmail.com>
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

Rename qcom_icc_set to qcom_icc_rpmh_set in preparation for commonizing
RPM-QoS, which also has a qcom_icc_set function.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v1:
 - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-r=
pmh, and another
   one for the actual commonization.

 drivers/interconnect/qcom/icc-rpmh.c | 6 +++---
 drivers/interconnect/qcom/icc-rpmh.h | 2 +-
 drivers/interconnect/qcom/sc7180.c   | 2 +-
 drivers/interconnect/qcom/sc7280.c   | 2 +-
 drivers/interconnect/qcom/sdm845.c   | 2 +-
 drivers/interconnect/qcom/sdx55.c    | 2 +-
 drivers/interconnect/qcom/sm8150.c   | 2 +-
 drivers/interconnect/qcom/sm8250.c   | 2 +-
 drivers/interconnect/qcom/sm8350.c   | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qc=
om/icc-rpmh.c
index 27cc5f03611c..a08059710f07 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -75,13 +75,13 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, =
u32 avg_bw,
 EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
=20
 /**
- * qcom_icc_set - set the constraints based on path
+ * qcom_icc_rpmh_set - set the constraints based on path
  * @src: source node for the path to set constraints on
  * @dst: destination node for the path to set constraints on
  *
  * Return: 0 on success, or an error code otherwise
  */
-int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst)
 {
 =09struct qcom_icc_provider *qp;
 =09struct icc_node *node;
@@ -97,7 +97,7 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *d=
st)
=20
 =09return 0;
 }
-EXPORT_SYMBOL_GPL(qcom_icc_set);
+EXPORT_SYMBOL_GPL(qcom_icc_rpmh_set);
=20
 struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec=
, void *data)
 {
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qc=
om/icc-rpmh.h
index e5f61ab989e7..5dc1049dc065 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -130,7 +130,7 @@ struct qcom_icc_desc {
=20
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 =09=09       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
-int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
+int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst);
 struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec=
, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom=
/sc7180.c
index 8d9044ed18ab..40232b41c080 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -532,7 +532,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate_extended =3D qcom_icc_xlate_extended;
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom=
/sc7280.c
index 8d1b55c3705c..b84742debc13 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1830,7 +1830,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate_extended =3D qcom_icc_xlate_extended;
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom=
/sdm845.c
index 366870150cbd..47b46601888a 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate_extended =3D qcom_icc_xlate_extended;
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/=
sdx55.c
index a5a122ee3d21..11b0c109c7ca 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -263,7 +263,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate =3D of_icc_xlate_onecell;
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom=
/sm8150.c
index c76b2c7f9b10..21410a20431b 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -530,7 +530,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate =3D of_icc_xlate_onecell;
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom=
/sm8250.c
index cc558fec74e3..8ec8504b48c6 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -546,7 +546,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate =3D of_icc_xlate_onecell;
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom=
/sm8350.c
index 579b6ce8e046..e3f54e07aca7 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -538,7 +538,7 @@ static int qnoc_probe(struct platform_device *pdev)
=20
 =09provider =3D &qp->provider;
 =09provider->dev =3D &pdev->dev;
-=09provider->set =3D qcom_icc_set;
+=09provider->set =3D qcom_icc_rpmh_set;
 =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
 =09provider->aggregate =3D qcom_icc_aggregate;
 =09provider->xlate =3D of_icc_xlate_onecell;
--=20
2.32.0


