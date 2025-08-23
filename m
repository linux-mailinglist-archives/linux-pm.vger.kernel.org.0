Return-Path: <linux-pm+bounces-32932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF9B32848
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CF1BC8117
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB2245032;
	Sat, 23 Aug 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="e6F29MP1";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="W+dq7pBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E875227EAA;
	Sat, 23 Aug 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755946752; cv=pass; b=mOO8xlLUXFXDqlNiSI1l6skTsFJlMmcp3bjeZ7sWkT31I12RpvzweEmGaoTh/LT8F0/qbTanu9uQlsNFyTJSq8+tymrzGPjFKFasWPDn8mYhTKCb1hpBTSQCMVUbJzU0JU+BWsVFavIx69NzVD1iqCRB40I2pPOhEGntsXawE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755946752; c=relaxed/simple;
	bh=ilyjwIlsa1wkcuXNoECN6cv2xrnaYLKIcOmPyqDGwhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGGV7T37jI0KcQweN3GyvYXAEZbtNFvnPH4p7UIa81xY5XqUZ9RaSDVlq8fT9EW4xKjxqzDAD2gEHUed/5Rg3TpeNjiSpehpAJIbBYetwQuhrJfbs6VTTWKQaneX0CL3DaRvCje8AxkYl+OVn9+K/SONxqulCy8QBJlBUuH2Tc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=e6F29MP1; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=W+dq7pBX; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755945306; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nnMv1BCDn+jePxMchhXy2j25W3dpYBYkiWlLk2Sde4VGSHYPrQeblpRHe8eyBeh5WD
    EX8jiS0ImU3L/C2aP4o8B4T/iw9SuCA/EKu4SJguksRrIJHb1plO0R3HK5w0+52lrldy
    AoAHoV+GplMJCjNERZNofyuRGmXG8DhGFUnNyTNifo0LDEoiFBGDU8Ci7mERbeLq5P9n
    237yGC4Ita1aCPlsdlycLZll30owgyxaq7XtNa0qat+SFTRR+Dij2LPUR28IJ3nf9Bja
    Ex9NFfsJnWQ+e0+nuJzmDs7Z0JIbaVCp581/UxrniAVdCImw5KaLbPQkk/8/N9tf0E4j
    FVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oqu8OMcX/St3MP1T2yutcRHri/5uqnrBNM94IGz43js=;
    b=EAmcUdtsrz4hH6s4d6N8thbM7Y3bMCZv+tmlGtfBG62QA5rzp3POZ9hJGhU9PCu13o
    Td6i+7FRJk+rFmFryVqEcJsZ/v8EjbQIyg0YUDB/JelLIaCJeYYndVONSsL2MdcAnveT
    DL5C/3CSj1eQKk5MzqaNehW4r8b1NdGJ1ICCCQxkOTVYV5rW37NGWN1a5h73oxyl919g
    b48yXfECcDgdi1UowDIC5fO0ZrFA5rwTk4k+Mp6t/8CJRgfwLzEEQF83ulKI6+Nk1lR2
    jRair/jV6a0Hr4AUi1lQTJOlnUkwoNB41i+d9Coc0Vq5qkXWUl9S8ksoSlWOtrvLCFN0
    dlaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oqu8OMcX/St3MP1T2yutcRHri/5uqnrBNM94IGz43js=;
    b=e6F29MP1sl3VXiL8JQOqPzQz0X/p14F6UUy2FMHxdD6D+mZq2Kki/AFzIS3vGAsEa9
    0H8Go0Oo5PgQufS11+plCGVQvMfUVkyzTehJ+UB2pkya1pSnbqhopbvNRZ77eJTY8HoB
    NUR3uiANL/715VA2RROuBDyy7NDhdyqt5PcAoLVkZK8roDmtyAznXHO7s8WwbSxFbOfk
    eWCSiVf8rFCYASLIdIzm8if80O1+NOe6KDUqwpiKd1IfiWwd9juAQj13AhcYZBNhxYmf
    wlPOyst0/i5bzX4/Y2rCQkyYFSIbNokqXzRpjooE+rOwMrreq+xP8r9wFc7TxZkm/pZg
    j7Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oqu8OMcX/St3MP1T2yutcRHri/5uqnrBNM94IGz43js=;
    b=W+dq7pBXSan6284G3Rdb/p0KFmcELqwHVTcnBPRyJlCbDxUDatuTzdKrD7iLppWk1D
    FQgcKxknE5sl39zunOAA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ35pZnciHiRbfLxXMND9/QZnI+FEnHoj9hoo="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a417NAZ68w8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 12:35:06 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
	Jerry Lv <Jerry.Lv@axis.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	kernel@pyra-handheld.com,
	andreas@kemnade.info,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/2] power: supply: bq27xxx: restrict no-battery detection to bq27000
Date: Sat, 23 Aug 2025 12:34:57 +0200
Message-ID: <dd979fa6855fd051ee5117016c58daaa05966e24.1755945297.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755945297.git.hns@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

There are fuel gauges in the bq27xxx series (e.g. bq27z561) which may in some
cases report 0xff as the value of BQ27XXX_REG_FLAGS that should not be
interpreted as "no battery" like for a disconnected battery with some built
in bq27000 chip.

So restrict the no-battery detection originally introduced by

    commit 3dd843e1c26a ("bq27000: report missing device better.")

to the bq27000.

There is no need to backport further because this was hidden before

	commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")

Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
Suggested-by: Jerry Lv <Jerry.Lv@axis.com>
Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index dadd8754a73a8..3363af24017ae 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1944,8 +1944,8 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -ENODEV; /* read error */
+	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
+		cache.flags = -ENODEV; /* bq27000 hdq read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
 
-- 
2.50.1


