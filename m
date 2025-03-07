Return-Path: <linux-pm+bounces-23659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE3A575AC
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BD43AFC12
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F2259498;
	Fri,  7 Mar 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="F7v69lV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F501EBFE6;
	Fri,  7 Mar 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388551; cv=none; b=gR4HhB0MirhZowXHja1q/Y1vL+g2h1072pEo/m9Uait3sDxALKZWlCc3VdNFsykqKgsMRF1EgL7ASvsTIcu/Rj1t/ouq5kwTtPtKdZ0AM5ifo+YH4TZH6FnOjHXz2gp7kNkuc2wU7GyFhswHBFNAPM4vwIrp33nj+mODaAq+U3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388551; c=relaxed/simple;
	bh=mdMVobuWepIr7PV03x7xbJHm7C/7keEOmWcHH70aAcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ousHqFLuovtUED5KiJzPd8LZOe3u3p0HQ7L04aIdIeP083gMGDsf4G9BUb0nIOXHc8Jh+nYZQ1vf2/2MGM0CQIETQ11f7mLVRFz7i9Mmh+F3KHs2SzxQcRunU073i3Yew6uPm00JvD6ZIJ5kiHcRUGIRRsu0CKbnzAm6Z8R5VQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=F7v69lV1; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=nqjQmn5zuk4Kwr62lIq32KHD5DpJuH6RLBYrL+pZlHA=; b=F7v69lV1camihRet
	BEi7CVqtRE/GMGTZhLkw47xmKG1pwuPPUT074TETZ0YxB/o9UNJXC5afdJXirFLKEE5HmXQZGnrGa
	DntZEaBVqGH3iavPcq/zSQRvQSCpxunGSvMNOTi0Qozz+JsysXARVQCIAPHTuSk22sb+6l5Jro+FI
	TZz2MvJhPJF/4eJbRGHuoeLtDwOHG19rSslapHz2qoBynbOZt9U7bo1V2wX0obYwZpDW3wEYtTQst
	Y8Yr5c9Ud0DxSNUoGRrb+d/gAWN1NOPy4Vilf4hpf3ZYZphVPwBHKf1vt2Q62n1R2b/blqmURXnnN
	IeKabVeW+2Z/XfUlTg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqgi3-003XFb-2A;
	Fri, 07 Mar 2025 23:02:27 +0000
From: linux@treblig.org
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] power: supply: Remove unused set_charged method
Date: Fri,  7 Mar 2025 23:02:25 +0000
Message-ID: <20250307230225.128775-4-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307230225.128775-1-linux@treblig.org>
References: <20250307230225.128775-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The previous patches in this series removed the only caller
and only setter of this method.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/power_supply.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5afc5946eb03..92da3deba342 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -274,7 +274,6 @@ struct power_supply_desc {
 	int (*property_is_writeable)(struct power_supply *psy,
 				     enum power_supply_property psp);
 	void (*external_power_changed)(struct power_supply *psy);
-	void (*set_charged)(struct power_supply *psy);
 
 	/*
 	 * Set if thermal zone should not be created for this power supply.
-- 
2.48.1


