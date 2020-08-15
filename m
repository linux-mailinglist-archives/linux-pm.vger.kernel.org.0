Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD624559E
	for <lists+linux-pm@lfdr.de>; Sun, 16 Aug 2020 06:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgHPECA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Aug 2020 00:02:00 -0400
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21746 "EHLO
        sender4-of-o57.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgHPEB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2020 00:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597479394; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cijLNEnmlZmYBW5vYB0BEPOW1YlnUtvVTyDhjfRKohNw4+j0i23usb8kbPOcU4c78N12wSRe8/3VpPKTmnnsFp60ZH1HD3ljwnjhTNnnVZlRRpV0z0K+T6QaVrH1oFAAuUhxh0oBIva689jkHTuOnzn9/rz7IbMVtRijMmFtRCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1597479394; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QS80eWMmZcyeHr6gCwPS53tfBBdlX67EjUomvXz9B5I=; 
        b=Jofg8RFPSZZoFPKGe3S4KC/0z5saAwUfCFHxulCm7MBUbrl6H7MwLKLpX+PhVSfSrV6hRkytS2deM2+6ht3Pvz4NEnu7RDrdV/vJS/OfDLjJVJAzJrCRwV40tH0UNk9dj1CBEal20zSgemFMYsDq3ffYRW/DTHamCZQGQVBoO4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597479394;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=QS80eWMmZcyeHr6gCwPS53tfBBdlX67EjUomvXz9B5I=;
        b=WXry5jUDpb/YKU2lySkV76JFjlgIT56DMYJoGApu9q8aKKATPyLAtmzGg1Y6DmKD
        JtEslGh5RnfGI3PmXsyb5a3wnze+eP3PvjLWFIvdNrhVQ+dh+w0ainIMlNwuUsnxsgE
        CFpkMdiUqCgACFIgO50To18SPVGLgM44bBZMVhbg=
Received: from localhost.localdomain (45.152.181.220 [45.152.181.220]) by mx.zohomail.com
        with SMTPS id 1597479391117323.5065240683739; Sat, 15 Aug 2020 01:16:31 -0700 (PDT)
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
To:     sre@kernel.org, linux-pm@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, axboe@kernel.dk, johannes.berg@intel.com,
        mkubecek@suse.cz
Cc:     =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <20200815081616.4986-2-frederic.pierret@qubes-os.org>
Subject: [PATCH 2/2] uapi/linux/power_supply.h: add power_supply_is_str_property func
Date:   Sat, 15 Aug 2020 10:16:16 +0200
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200815081616.4986-1-frederic.pierret@qubes-os.org>
References: <20200815081616.4986-1-frederic.pierret@qubes-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qubes=
-os.org>
---
 include/uapi/linux/power_supply.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/power_supply.h b/include/uapi/linux/power_s=
upply.h
index 4400a9e1f991..0efb2c8c9a41 100644
--- a/include/uapi/linux/power_supply.h
+++ b/include/uapi/linux/power_supply.h
@@ -244,4 +244,18 @@ static inline bool power_supply_is_watt_property(enum =
power_supply_property psp)
 =09return 0;
 }
=20
+static inline bool power_supply_is_str_property(enum power_supply_property=
 psp)
+{
+=09switch (psp) {
+=09case POWER_SUPPLY_PROP_MODEL_NAME:
+=09case POWER_SUPPLY_PROP_MANUFACTURER:
+=09case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+=09=09return 1;
+=09default:
+=09=09break;
+=09}
+
+=09return 0;
+}
+
 #endif /* __UAPI_LINUX_POWER_SUPPLY_H__ */
--=20
2.21.3


