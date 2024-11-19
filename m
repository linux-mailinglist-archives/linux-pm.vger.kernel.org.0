Return-Path: <linux-pm+bounces-17784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191F9D2E46
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F2FB2EC7E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399DF1D31BA;
	Tue, 19 Nov 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="CkRxpQsP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C411D271C;
	Tue, 19 Nov 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039735; cv=none; b=Xyoa9Dq2pnAzPhgT/007oDrH6gPlKMm1bqxbdg9SmRqlWAwgej5ENwQIEOeJqc+SSnrrJAamOTbGjXSUiJVQ/Zxnqjuz8aA8hEyYG3px1kDi4c++mHPAEQ1f7Nrrfrj/cdcImuMmMLw83zOnR70LJ1W1EEaSuaRl2xwzE2ic74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039735; c=relaxed/simple;
	bh=gw1WD5Ldm/YeGGFQaUWdoi9cYdiUZEyqcl4brAa3GeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQw2F3iGuz4cvIM4gcdg385UXl/AilD/do1iNRuTtB5m/x/EQ0KNtlqFAyE9+IfsVRPTymSuoMxyK/JImJDWYlRtwd5fJRgymNWpAXzYC5J7406zQbalOCHfDu9hsC5jsCx36HWoXMDN/eRO8eW7ktMmDDS2aBoFavIhlkw0bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=CkRxpQsP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 43BEEA0155;
	Tue, 19 Nov 2024 19:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ejkHx53kYGkvJoa9CRLA
	CkaeV4X5zlY3HSi1hmtR7Pc=; b=CkRxpQsPDXHn5Schpyh6WboPjx0rjaHHaj1b
	7A+iASgAkkTLY7eY/d7mKpKx3bausl5RBduwLzFZT/AJejMN8c0WELvFk0tj84mG
	JT/fdRAA5TzbAzZBRIatbj567R6QqbldrvDX4oHXrEsvevJxJr93d+gMddZlQIgc
	21/nKSGFaN4anu8b/kkrgaY2nTmYnjLbMnfKHpH0LsnWhFffmSSOvUIcc+OBX7Lw
	2Fny8yCkwXaZbltjCAUjeE4P61ohx8YYOCXok9qOIB3zIeGRkbBHQaSJfI4tQF3a
	5yWExahtJlioT1i9QJSuy0HuRuBJu7Ub19hinmGiyJWD4yc2QvQuwgLs3QT9wPjr
	2OWIEDMDjaozCxYR5Fk/YROYANQVNvrAswokGyrGeL1jiSlYG7VlPy8tWOiAuUcQ
	lNtBL8vcZ82Yn6YUYo5Dey9Sanrsnif82G0b9aZ86XizS8v0kygerV9Ea/tzj/82
	2bVyZrubNNmi8GbQrY4489v6Zj4/clscOSOhYnro6mwk1dvvwK/ASRyX1BAxeus/
	DDVCsvjvW89kk80bMXNwXK3FBDjUZx3z68vWxq2XfipJDDOq+vWxhWYu1Cs+QfMX
	W6oC0wYlgBkVfk6K0RSKLjQ1zs/KtavEhfXqy639WeoqyH0HrEYc2K32ecFpsjgE
	NgQ+aeg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 4/8] power: ip5xxx_power: Add battery type for 4.4V
Date: Tue, 19 Nov 2024 19:07:36 +0100
Message-ID: <20241119180741.2237692-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039723;VERSION=7980;MC=1858814624;ID=46209;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

IP53xx series supports 4.4V batteries. Add support for it
to compatible parts (that have `vbat_max` set to >= 4.4 V).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index a939dbfe8d23..f64767b81c3b 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -10,6 +10,7 @@
 #define IP5XXX_BAT_TYPE_4_2V			0x0
 #define IP5XXX_BAT_TYPE_4_3V			0x1
 #define IP5XXX_BAT_TYPE_4_35V			0x2
+#define IP5XXX_BAT_TYPE_4_4V			0x3
 #define IP5XXX_CHG_STAT_IDLE			0x0
 #define IP5XXX_CHG_STAT_TRICKLE		0x1
 #define IP5XXX_CHG_STAT_CONST_VOLT		0x2
@@ -365,6 +366,9 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	case IP5XXX_BAT_TYPE_4_35V:
 		*val = 4350000;
 		break;
+	case IP5XXX_BAT_TYPE_4_4V:
+		*val = 4400000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -492,6 +496,9 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 	case 4350000:
 		rval = IP5XXX_BAT_TYPE_4_35V;
 		break;
+	case 4400000:
+		rval = IP5XXX_BAT_TYPE_4_4V;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1



