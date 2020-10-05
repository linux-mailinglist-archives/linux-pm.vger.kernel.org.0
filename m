Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B5282EA1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 03:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJEBak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 21:30:40 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:53136 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEBak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 21:30:40 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 502752002C81;
        Mon,  5 Oct 2020 01:30:37 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="a23fL7hQ"
Date:   Mon, 05 Oct 2020 01:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601861433;
        bh=p1eGoYp+QbT+Nt9C3JD2J1+KXTSZofDWbrbRfVRpfjA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=a23fL7hQLLXx6CSWaDwZCAYXNI6fY3Zw4d4hN2T1NNjiO7puZyBeqFNfgnkULkdIj
         jokhL4ZZGN06j3DYgR/QAm9tq8TAf0gei7d4qygoUivHnXy0wpYo6tChONfMC5locZ
         B40K+I+XajPhUkOh4szizIPxgCe4dVl3wf2/jhuw=
To:     Sebastian Reichel <sre@kernel.org>
From:   "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "joe@perches.com" <joe@perches.com>
Reply-To: "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Subject: Re: [PATCH] test_power: add missing newlines when printing parameters by sysfs
Message-ID: <1g3ecQ7VLlrgKOSHr6teWgw9xcmVVQx1bFp2KpJD7y35lZpaC8ONb-jrPKapmFttEwVg2uhDwmv6mug9z5-GVZbqPbkOjcqjrSHtaW-k6ts=@protonmail.com>
In-Reply-To: <20201004221645.nyaf7jhur4jixo6n@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com> <20201003212336.5et7erdf6fihqscu@earth.universe> <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com> <20201003215029.jsugcgpgrmcmydr3@earth.universe> <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com> <20201004221645.nyaf7jhur4jixo6n@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here is the updated patch using sprintf, diffing from the original patch by=
 Xiongfeng Wang.

[PATCH] test_power: revise parameter printing to use sprintf

Signed-off-by: Harley A.W. Lorenzo <hl1998@protonmail.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/power/supply/test_power.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_=
power.c
index 4895ee5e63a9..fbb179a1b615 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -352,8 +352,8 @@ static int param_set_ac_online(const char *key, const s=
truct kernel_param *kp)

 static int param_get_ac_online(char *buffer, const struct kernel_param *kp=
)
 {
-=09strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, ac_online, "unknown");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

@@ -366,8 +366,8 @@ static int param_set_usb_online(const char *key, const =
struct kernel_param *kp)

 static int param_get_usb_online(char *buffer, const struct kernel_param *k=
p)
 {
-=09strcpy(buffer, map_get_key(map_ac_online, usb_online, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, usb_online, "unknown");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

@@ -381,8 +381,8 @@ static int param_set_battery_status(const char *key,

 static int param_get_battery_status(char *buffer, const struct kernel_para=
m *kp)
 {
-=09strcpy(buffer, map_get_key(map_status, battery_status, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, battery_status, "unknown=
");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

@@ -396,8 +396,8 @@ static int param_set_battery_health(const char *key,

 static int param_get_battery_health(char *buffer, const struct kernel_para=
m *kp)
 {
-=09strcpy(buffer, map_get_key(map_health, battery_health, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, battery_health, "unknown=
");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

@@ -412,8 +412,9 @@ static int param_set_battery_present(const char *key,
 static int param_get_battery_present(char *buffer,
 =09=09=09=09=09const struct kernel_param *kp)
 {
-=09strcpy(buffer, map_get_key(map_present, battery_present, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, battery_present,
+=09=09=09=09=09"unknown");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

@@ -429,9 +430,9 @@ static int param_set_battery_technology(const char *key=
,
 static int param_get_battery_technology(char *buffer,
 =09=09=09=09=09const struct kernel_param *kp)
 {
-=09strcpy(buffer,
-=09=09map_get_key(map_technology, battery_technology, "unknown"));
-=09strcat(buffer, "\n");
+=09char const *out =3D map_get_key(map_ac_online, battery_technology,
+=09=09=09=09=09"unknown");
+=09sprintf(buffer, "%s\n", out);
 =09return strlen(buffer);
 }

--
2.28.0

