Return-Path: <linux-pm+bounces-32027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C5B1D276
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2852188E1D1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90238214210;
	Thu,  7 Aug 2025 06:28:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5011537A7;
	Thu,  7 Aug 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548108; cv=none; b=WUzFIMimJ2CRkcDYlBCrHpaqcga0Q4ZPVFySCk1UEmxusCQXK42QFVqHQDYDBsbDt8nUergTqVIzR9mjgdtQD9pdr8tIsZ7VPN2WUGwDVbqYcCBjniQGqxd79J2Ern14ndcaJAhUk2+4pWFq5g3aC/RKnLWuZSg8bKiH7nalO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548108; c=relaxed/simple;
	bh=FHSzj2+uxGBEBWEriAJDUivjnkjAxqOXb9ZQeEInDdc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ucj7GXrMEihGs+EqZ1OgItwBnNd60mpSe6s0prxGrkFvkzY8YH6xtlcWjLseeW4smYkP+cd63ynQBQnfVHkQEDBYSwbkZDqPGb6MCXBkdWCJSl4C7awm9JqUAO3RAanFNS2UM1qLZJZAsGKe1t34At6XUyvCN9VSL3fOY0OIvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4byH6t4ztBz57f5;
	Thu, 07 Aug 2025 14:19:02 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4byH6l453WzBQkJw;
	Thu, 07 Aug 2025 14:18:55 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4byH6W0pfzz8Xs7T;
	Thu, 07 Aug 2025 14:18:43 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 5776IWJt037114;
	Thu, 7 Aug 2025 14:18:32 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 7 Aug 2025 14:18:33 +0800 (CST)
Date: Thu, 7 Aug 2025 14:18:33 +0800 (CST)
X-Zmail-TransId: 2af9689445396e7-b3571
X-Mailer: Zmail v1.0
Message-ID: <20250807141833927wb2idY1sZi1OpUKkrXk44@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <djakov@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpbnRlcmNvbm5lY3Q6IGNvcmU6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5776IWJt037114
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.121 unknown Thu, 07 Aug 2025 14:19:02 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68944555.001/4byH6t4ztBz57f5

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Make use of device_match_of_node() instead of open coding its
functionality.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 3ebf37ddfc18..6cc979b26151 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -385,7 +385,7 @@ struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spe

        mutex_lock(&icc_lock);
        list_for_each_entry(provider, &icc_providers, provider_list) {
-               if (provider->dev->of_node == spec->np) {
+               if (device_match_of_node(provider->dev, spec->np)) {
                        if (provider->xlate_extended) {
                                data = provider->xlate_extended(spec, provider->data);
                                if (!IS_ERR(data)) {
-- 
2.25.1

