Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD7282FB3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 06:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJEEoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 00:44:32 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:56764 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEEoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 00:44:32 -0400
X-Greylist: delayed 11634 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 00:44:31 EDT
Date:   Mon, 05 Oct 2020 04:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601873068;
        bh=TrIA7YFOcNpa4uHdlUUc/yf24kQXAcWRwvqvatpCVhw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZHp+PqkMlTA8/bdHRkhv2BUn3YKEGuJhGgsUIHYQK60+BTvqcONCPK/JN0A3kIoIo
         eVq5aMscY6OYzwWy3hAWM6XXOrqBzmCc4kauyvlVLul/KJWZhWcfPL44AzkNgUy0Tb
         v7ipsR5kmZ6xGD6/Rl2HXJvrE6FK87tLB0zUshpA=
To:     Joe Perches <joe@perches.com>, Sebastian Reichel <sre@kernel.org>
From:   "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
Reply-To: "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Subject: Re: [PATCH] test_power: add missing newlines when printing parameters by sysfs
Message-ID: <XgtK3LuGSChMPtuO5vmpvUY6igXN3_gtLIOHsH7QSWimCXVDsM2j02qDOIrBK-rWMpwidDFxqF7MhOdfc7xfnRgOuDCVHW6XML9RXPujSak=@protonmail.com>
In-Reply-To: <f8fd76b81dab7dcb0e262a62e4d92bdf63ef2cfe.camel@perches.com>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com> <20201003212336.5et7erdf6fihqscu@earth.universe> <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com> <20201003215029.jsugcgpgrmcmydr3@earth.universe> <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com> <20201004221645.nyaf7jhur4jixo6n@earth.universe> <1g3ecQ7VLlrgKOSHr6teWgw9xcmVVQx1bFp2KpJD7y35lZpaC8ONb-jrPKapmFttEwVg2uhDwmv6mug9z5-GVZbqPbkOjcqjrSHtaW-k6ts=@protonmail.com> <f8fd76b81dab7dcb0e262a62e4d92bdf63ef2cfe.camel@perches.com>
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

On Monday, October 5, 2020 12:19 AM, Joe Perches <joe@perches.com> wrote:
> I did not suggest this.

My apologies. Revised patch (still diffing from Xiongfeng Wang) here.

[PATCH v2] test_power: revise parameter printing to use sprintf

Signed-off-by: Harley A.W. Lorenzo <hl1998@protonmail.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/power/supply/test_power.c | 32 +++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_=
power.c
index 4895ee5e63a9..5f510ddc946d 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -352,9 +352,8 @@ static int param_set_ac_online(const char *key, const s=
truct kernel_param *kp)

 static int param_get_ac_online(char *buffer, const struct kernel_param *kp=
)
 {
-=09strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, ac_online, "unknown"));
 }

 static int param_set_usb_online(const char *key, const struct kernel_param=
 *kp)
@@ -366,9 +365,8 @@ static int param_set_usb_online(const char *key, const =
struct kernel_param *kp)

 static int param_get_usb_online(char *buffer, const struct kernel_param *k=
p)
 {
-=09strcpy(buffer, map_get_key(map_ac_online, usb_online, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, usb_online, "unknown"));
 }

 static int param_set_battery_status(const char *key,
@@ -381,9 +379,8 @@ static int param_set_battery_status(const char *key,

 static int param_get_battery_status(char *buffer, const struct kernel_para=
m *kp)
 {
-=09strcpy(buffer, map_get_key(map_status, battery_status, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, battery_status, "unknown"));
 }

 static int param_set_battery_health(const char *key,
@@ -396,9 +393,8 @@ static int param_set_battery_health(const char *key,

 static int param_get_battery_health(char *buffer, const struct kernel_para=
m *kp)
 {
-=09strcpy(buffer, map_get_key(map_health, battery_health, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, battery_health, "unknown"));
 }

 static int param_set_battery_present(const char *key,
@@ -412,9 +408,8 @@ static int param_set_battery_present(const char *key,
 static int param_get_battery_present(char *buffer,
 =09=09=09=09=09const struct kernel_param *kp)
 {
-=09strcpy(buffer, map_get_key(map_present, battery_present, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, battery_present, "unknown"));
 }

 static int param_set_battery_technology(const char *key,
@@ -429,10 +424,9 @@ static int param_set_battery_technology(const char *ke=
y,
 static int param_get_battery_technology(char *buffer,
 =09=09=09=09=09const struct kernel_param *kp)
 {
-=09strcpy(buffer,
-=09=09map_get_key(map_technology, battery_technology, "unknown"));
-=09strcat(buffer, "\n");
-=09return strlen(buffer);
+=09return sprintf(buffer, "%s\n",
+=09=09=09map_get_key(map_ac_online, battery_technology,
+=09=09=09=09=09"unknown"));
 }

 static int param_set_battery_capacity(const char *key,
--
2.28.0
