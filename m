Return-Path: <linux-pm+bounces-42984-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GEzDIbym2kI+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42984-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:24:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2D172172
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E021E30832C0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687E345734;
	Mon, 23 Feb 2026 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVf5cQQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14031A56C
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827565; cv=none; b=GIEQCi2V8MaaVOEP8Qzii3B/ary2Z8Ei6+w2BBpwBy1Me8TOQO3NLUeHq9OSbvvxtlhSwJxgW5K0A9fwqu1iZcdMWFdQaASH+16jy0OQGHEyW1/9aUbQvGp8znfO/S10cSSR8/YU4OnaJgpqfrvxVbmP7aQYxyiNqXAgzlRJRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827565; c=relaxed/simple;
	bh=sT7HTPtst/zg7EmgHN1S/xyGPVLYLKf0e36YnPluPv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Et6f++MwEJ0iw1kZQ5PU35i6txEClsP0p6HkfDn5xWfLGmPwCAIB3kovV8soaZpUHuX0qjCBXwDpuzLIlncKFyIltCTeYpalyVUMQ3i/yZrlN28HUTz9dPkv2jCIwktqtr8CzVTlUhByh1256n5t5Z9ldgaU2FKD84qdVPIRiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVf5cQQM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so18801005ad.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 22:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771827564; x=1772432364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vli3G+0wOlwHpxuWTDOJRfn0EdF7sq1jdNlY7kDD5nI=;
        b=PVf5cQQMJVYWZOsE1RcHJQTxHhN/n5knKDmxAPxxBa+GUT4R6wSBgQh4k/17F4ES4y
         TQNlhOuIB9RFvMlMfe4WiwU2tPDpedcRH3t/4XxNWrRrasHMrifHOsQvkZx7n9CBQc3j
         BsHE/jDh3FtMy0aN4T5p97V83bVv6W/Nowy0vR7X+TkmUkuLYak98P78Ma6vY/Ti6OnC
         WMSJzgi3tQ+7yJ6VN3TMYYZlDGvowbgtaqWUKet6B7NQzEkOMr4fYyk6pcFWMEZ8/YsO
         Vdyv5KXBBW9O9qSdDq/BQHk+wRX3/2wxEjctTWizZP4og3xnKqpPSIQmbqHm2rFUMEGi
         OTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771827564; x=1772432364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vli3G+0wOlwHpxuWTDOJRfn0EdF7sq1jdNlY7kDD5nI=;
        b=rY7Fzafyg9ADUdaLoergfONxQZdVPdtYYssy96DqR5esAR/JisOB4y69rRbjnAn+TY
         u0JSSNu+/OfCs9+TzzjN/7HBl0ap8Re1trFISJwa7IXPIxKj7SCVYYUMar/zA5dZiFLh
         kSuZv+8Vk4TH8OBXRJ7vpHjo8+coL4s98LxWGEr0qQJw6QxY1wKKbI0mGA/1C8jCs0iB
         HoMdRkyeKZjMx50YJ+erlBKngZCso2Hp2dhk7iCjmJbCfTHhPgVyCUfpb/0aacMcKznz
         eAEnDjgDn4DyC5ynFwbgEF4BfQptKmJcbwgBCiV/F+OniWG9AehSFAMCarfRmQGyvi5V
         mpQw==
X-Forwarded-Encrypted: i=1; AJvYcCVihxrO/N2xzHQ4tPtAQma3FqAnu7d5gaqeRm74ar2OsnN9DGFirJX8RXoe0FMNBwsCvD3VvgCdAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUMIc/jcXb+MbFmmywHCdY+apgt/zmaGLypI9RIcFd+c4tgXj
	KcuWkds/8l4LRbjL2h+pFEGhGUdxIMzR9JwNh0wg84BCYLSDfdLDm3pO0J6OpuX0SKE=
X-Gm-Gg: ATEYQzw1vQJkNuAtMc8L5YLJ7qMxdMrZk+juDaq4ChFJMUXQZnAHVgJOr8OaQeNyre8
	iHMVZ+UdFjpivp8wgJWu3nDBuFXrdoCdmH8bPj3Bj0DSU4S9dRo8HOgC7Rwsy9wN4kRJ0uHuvLr
	QmuGjv09tFsWlKYASpsvXPo6tw1KghZ4WmUS4AQIG8WDVFeiK/uIbilgMEF/sB/PJYCptrtsRF+
	KtIAxNM3wKQBtA1XG/0HaN5zxkFfZPQfXU7zPpTbjJnvEcxVCX+h0/2B48uuWHAa7Dqn+kpSlCW
	py8cf6CWV1DxTJzyuHiyWUf0Xrx6e1jV8pCgDen+y/wF+XGbbQCcRweCqPkCkkkePZXMS5jhDVd
	t3budmLYBEibhlgGZOPUA7e1wAgEcWv1G+EHz92Uq9/O9ywuj31zQ88xwSX/PINC9yMrpcjZbmp
	qBnTQwQHKDauC0QhFwKaBuGUDm
X-Received: by 2002:a17:902:ef01:b0:2aa:e6fa:2f6d with SMTP id d9443c01a7336-2ad74419e58mr67592045ad.1.1771827563498;
        Sun, 22 Feb 2026 22:19:23 -0800 (PST)
Received: from localhost ([122.172.81.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm60689155ad.52.2026.02.22.22.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:19:22 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()
Date: Mon, 23 Feb 2026 11:24:41 +0530
Message-Id: <3d2398f44a2d48fb1c575a6e0bc6b38f3e689e22.1771826075.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42984-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 9FA2D172172
X-Rspamd-Action: no action

The commit ff9c512041f2 ("OPP: Use mutex locking guards")
unintentionally made the for loop run longer than required.

scoped_guard() is implemented as a for loop. The break statement now
breaks out out the scoped_guard() and not out of the outer for loop.
The outer loop always iterates to completion.

Fix it.

Fixes: ff9c512041f2 ("OPP: Use mutex locking guards")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 866641666e41..da3f5eba4341 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2742,8 +2742,8 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 					break;
 				}
 			}
-			break;
 		}
+		break;
 	}
 
 	if (IS_ERR(dest_opp)) {
-- 
2.31.1.272.g89b43f80a514


