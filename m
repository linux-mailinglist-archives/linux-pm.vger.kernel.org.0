Return-Path: <linux-pm+bounces-8318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F038D27F3
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 00:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4042D28C042
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB813E02D;
	Tue, 28 May 2024 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LqSEIs2R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188627469;
	Tue, 28 May 2024 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934887; cv=none; b=G9ws6HvvMRB/TEjCz19yQ/TUu/0E3v0TrMZ0xC0d/pBGQhy3bR70yqlCbyupk/Ax8sjzIfp4H0Ar7KQC01R9wl4hV6MUMTyJ6LeJ8MkvdlS2hOgdSznmLEmAkvAgQwnfwsjorUXoha2SoCIQFOATMpbCRHPQkSD/sq80ZV2hGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934887; c=relaxed/simple;
	bh=9ABvswqm9FAVUHd9AZJLhRmlzApUYd45RCUg60b48fU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1oyrCV4NlqEEtGpVDofHEdzQw4Q7gzaeULJdq7qIxuqz/CDWxUxK6vLXckXZ6VRcUdv4GzlM7L7vY1D7qGU6ePJ5gh8yeaUmdU58oqB4B3UIyQqhv2pkD23+U4CMMQr6FLskUTaVe11V1pDuAO2LhcaRdwsZELMVkv88ZBh7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LqSEIs2R; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716934878; x=1717539678; i=w_armin@gmx.de;
	bh=ToPzc8UjXVCcaTha/DNLgmdKIEd80W2Fq2fuFm19kEs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LqSEIs2RaQffCUS4JahNNFBP4evIhWPhLkk8i3oJkhO/smDb/N2yduJgILboJRXR
	 cs8GVDzuivnga9egfQjjxzY6WnvmsNq6qc8KBbX14nMwVMWS+6nRkNcNzi6LwN/F1
	 S5kolC1EuJqUpCp4oAP+vyH0S0Z1e9TcXlJ/Xfhc5QDvRJmr8GQRlhr5IG2Ah9FJh
	 BgB74AieFR5xXabDCVQEcOUbFm8FvmUv7fXPPFpgrJnMDB6g83DVb/LhtI/7WBSkN
	 /qEZQdRqKnVdARow/ysYf2u6xc7h+0zhY52p7VodPoZSmi1+ig0Ue5sTZj6t/glnC
	 PlilwEEqJH2/GHH5gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mo6qv-1srknt0l8F-00pbIA; Wed, 29 May 2024 00:21:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: hwmon: Add support for power sensors
Date: Wed, 29 May 2024 00:21:15 +0200
Message-Id: <20240528222115.791511-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FEqlk1Wk9wPKKxQpRuKz+TUGv6lXZlVd8YsCE1zXFr84RvScPfM
 Lj/u5pm3WAaECWlLCziTZxTu+Nu0xnxcKPv2Cr8mMK9OOCZ1JAdsKOmiTGnHygbm+/vZUkb
 JuTaI8weA/AzpcK5cBMzW2n44oDOS+z96lm7oWmwZ+ao5Oe0KxtgTyoXNvPQHYvuFPVDlj3
 sdhl2aWjOu1vFyoIOh4dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZMIeB4k30RQ=;fiqhq/3tNLWw+fa8MG8kwNjzMfg
 UjE+n1q09VnC0rJEWEGJGSpDWwg1ClD93BdL+bdJT71exB6e+qimqNeiet/qG+k38HvOmO+4C
 3lGTgKIBGu09bbxpOyRHkvEhRx8DY1NAadXjwU20yWKPCQESo1Z25hos+e+6XWsArm1eXSr3f
 A+LlncM4Ec4vXSIdI6mPpnNwganEzgUxekm4NjaeSWk8Q+HKbj1gV86qS3nALBZFAxASSsvV7
 k14lRLc23Y9nP2Vf++TFNUHnp8XFKvli2WecuyXosVwyHs0CsIstjbnkuiOBIkODPEt0mAeC9
 JdbMNex8SQYMjgyeVvEn8UhlVvlgmdOKuf3UvXxY6wkCrJRZVpv3Sle3itMfBtk7JfjzkGrtE
 Za1cMJRlrT8tHk4J8L1GOW7oWgavyRAjEPThdvyxGFwoJ1mlOKlfanswXS15L+5djU/D4BlNy
 K27GwKIwjeUG9HTP6QgZ9Oa+ScpVWF2TFjNIdrd7YTjA85q+yKl8qjXqcQnJCIvaaIYhBxiyr
 48c05m3ZzcI8Z4V9zOouCVRMtWkHbN6PXDotAeXDEeqD5XzpVYjDpl8xRsfQks+O7H4mUEuJ5
 OWdPYuRJoKpNylY3xww4ezB2o/vjgMkOuGR6W5je5OdH35EAqH1tsWza0C3uimjASRInS4OBz
 H8rv/TRKlf4CYb5lemT/fNlDVf6iv6bgxqv9GtT6j9nmzG1BP7d3YAhnhw1+wrzM0wKK9XTy4
 PFKfbe7JwwItybQXIURphSy/nN3btmRkBerjZiZXtFMgNkZRkYm39xM8t4EikZkolMZPDW7jf
 f954HFwHleUNiCWx3ZMwm2QCYgC2CBHRLgXRUrbdKbkhQ=

Currently, more than seven power supply drivers are supporting
POWER_SUPPLY_PROP_POWER_NOW, but their power readings are not being
reported through the hwmon subsystem.

Fix this by adding support for power sensors to the power supply
hwmon integration.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/power/supply/power_supply_hwmon.c | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/sup=
ply/power_supply_hwmon.c
index c97893d4c25e..baacefbdf768 100644
=2D-- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -48,6 +48,18 @@ static int power_supply_hwmon_curr_to_property(u32 attr=
)
 	}
 }

+static int power_supply_hwmon_power_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_power_input:
+		return POWER_SUPPLY_PROP_POWER_NOW;
+	case hwmon_power_average:
+		return POWER_SUPPLY_PROP_POWER_AVG;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
 {
 	if (channel) {
@@ -90,6 +102,8 @@ power_supply_hwmon_to_property(enum hwmon_sensor_types =
type,
 		return power_supply_hwmon_in_to_property(attr);
 	case hwmon_curr:
 		return power_supply_hwmon_curr_to_property(attr);
+	case hwmon_power:
+		return power_supply_hwmon_power_to_property(attr);
 	case hwmon_temp:
 		return power_supply_hwmon_temp_to_property(attr, channel);
 	default:
@@ -229,6 +243,11 @@ power_supply_hwmon_read(struct device *dev, enum hwmo=
n_sensor_types type,
 	case hwmon_in:
 		pspval.intval =3D DIV_ROUND_CLOSEST(pspval.intval, 1000);
 		break;
+	case hwmon_power:
+		/*
+		 * Power properties are already in microwatts.
+		 */
+		break;
 	/*
 	 * Temp needs to be converted from 1/10 C to milli-C
 	 */
@@ -311,6 +330,10 @@ static const struct hwmon_channel_info * const power_=
supply_hwmon_info[] =3D {
 			   HWMON_C_MAX     |
 			   HWMON_C_INPUT),

+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT |
+			   HWMON_P_AVERAGE),
+
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_AVERAGE |
 			   HWMON_I_MIN     |
@@ -359,6 +382,8 @@ int power_supply_add_hwmon_sysfs(struct power_supply *=
psy)
 		case POWER_SUPPLY_PROP_CURRENT_AVG:
 		case POWER_SUPPLY_PROP_CURRENT_MAX:
 		case POWER_SUPPLY_PROP_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_POWER_AVG:
+		case POWER_SUPPLY_PROP_POWER_NOW:
 		case POWER_SUPPLY_PROP_TEMP:
 		case POWER_SUPPLY_PROP_TEMP_MAX:
 		case POWER_SUPPLY_PROP_TEMP_MIN:
=2D-
2.39.2


