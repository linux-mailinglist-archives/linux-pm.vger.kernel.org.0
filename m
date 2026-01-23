Return-Path: <linux-pm+bounces-41386-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAR/LV/Hc2lZygAAu9opvQ
	(envelope-from <linux-pm+bounces-41386-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 20:09:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177BB7A068
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3BB83060192
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF2280A58;
	Fri, 23 Jan 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYS3usuN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603D26D4CA
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195210; cv=none; b=HEuyvMYCp77sWnJdY0+u8q+nVM3OlvZlvsqYuAKE/fh9b88sDblhkhFqSDk1xnvOSQKwymzQIIF500cZmWnuGlRuv6H5NOzz0F9bf3KNgk/V86mfHv67zWmGNu9Z0C+YDZ5ludesLkGC5/FbP/dzGnJlIHxcTVVs2oKr2nPshSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195210; c=relaxed/simple;
	bh=qdOEb1TELuVRMyiAyReucWqeGMrYnZ8kzoChaPtElBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CIkAbDnEdi/yt7nImZ7A7eHdMpq9w5nruin0lAEU3/O/gbvhlaYdvgiZkUJuw+JL+MH6BRzbPs3zTIMMpWaf+hLc5Qskn1GI6meRW9z9wrO1o4WlyTQnqJKrY+2bpEh8Q214GNEaye2uz17Jd9IBbphJSSOVqipZvD2R5H8Ud4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYS3usuN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so1217722a91.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769195209; x=1769800009; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrGf6D6fRUKgAu958m67Gc/e+p765gm2Q2mQPt54JfY=;
        b=jYS3usuNmqaur7LrNBDwvE/oW/DSRMc2q6ykrgPmhjvxFo0pbRhqfx5BE01k5mjfRP
         lI+yHcdCh8UbFnBPJljKqcjVYuJMM4moAhmKKURRvIOppJC5pqU67q1XcMvtIiLehexk
         ZBZ9WDiMEgCYx7GmMQ0UcZJxWlNr2SPX0xwD+VjexUU/2oHnH/EUk71oPxgunWjRD9U2
         nG5BDUqJjrZ4MsHJAyUL4DZ1gxOuDGeqjdntUiE9MkhGRWnwTURlhZghcoZXNJgSUoar
         gsuKp/QvH6k4XaDeQwDhOHaaIP8vCLzEzxS5cZQG8YLSUv61VtVDK8vH6idq3GCpqbvH
         XFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195209; x=1769800009;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrGf6D6fRUKgAu958m67Gc/e+p765gm2Q2mQPt54JfY=;
        b=bNirWXobtJl9AFDgmjmZkzOnl8X5yZMGSdczcbxwA1kksEawVgpi5ghq6dbRW6+rU3
         XHQGxjGILIQm46RS2MLpHxZ8e5c4GktFgQJ+k3h+h4PQKYAtA89nDLlC3St+d0I342U+
         cbgm9IoqBMBiwvgVLNF2jmHGnpuQJRSv/TxJ3z2Kun8jwmAIZGSlew+iDGJrXKC5jN0g
         vqJc+T01CrFa0q1+09Wo3rpmIkLnTohtBe4+GAP7KgbSRBwoMXNYl5yjDAqPevgFzmVt
         mlBpkoAXdWGvQYzUz+fOACXHvgyasN+3rSUkPX1j8TV8gbYrtJIQHvXbEgEC1e9XkLUX
         1YbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4JdXR0LU3KSeWtJmUJ79al14qYIHfU96m4ss0NbyRFOUfRxgXhjKIUIVe3cpDRF8o6edRpk7DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVbWi0ixzIpqiNM+dKbcJjeywYs1hnMbMCBm/UhHAkCldOF5f
	DSa/tfDICXdUqys31pmeAIcBQUKT7VQWpQRqL/c6tLGZzQcPpooqeDo6
X-Gm-Gg: AZuq6aKsggl630Sexvv/9wImaXSFqc4r7WnynfUUt/WHdrnWx8vXXaiAn2p+jIFjUI/
	nShgy7YXqNvQ7XVRmGg2UHSBhVCtBy4GyHU8P9bDbMjF06mBHzLDPvZiprbH4lC0rlm2K+aB5Yz
	7hlolkDgLwrLk340KbPSRUqJjS9yHT1Ip0m6PJMbqoc2w62GFFuB2OKQfiiI/RluSHq9n0uAkUt
	mL0mwMFIxGdb7NxOL1yCfxShGrW+9dOZ+hXruw8IJyxY7BrfR5Ug9OqZ0AF6o0dmaRXiPQeWhuq
	m4yiVyuY9NhhyNZ0aWAXvtHowZImCXPAmcW4hJVvuuq12uitwcfv0VdwZQR60sBMdIXZb9RpB+z
	OACyVFKDJIsLcLcxqi1uJRL4hlsbp53Na9bM18P7MlXo/V/3doHq/rr87rn1KO/e4DkTxmjZY4f
	QhU2i1oXI2MWrs1PgZwrpzjrBu
X-Received: by 2002:a17:90a:dfc4:b0:352:f2a6:334 with SMTP id 98e67ed59e1d1-353676fc2fbmr3199076a91.16.1769195208687;
        Fri, 23 Jan 2026 11:06:48 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353355e1161sm5720924a91.17.2026.01.23.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:06:48 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 24 Jan 2026 03:06:40 +0800
Subject: [PATCH] thermal/of: Fix reference leak in thermal_of_cm_lookup()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL/Gc2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMT3ZKM1KLcxJz4/DRdS0Nzc5PU1ORUMwtLJaCGgqLUtMwKsGHRsbW
 1ALqxaURcAAAA
X-Change-ID: 20260124-thermal_of-91774eece689
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Yu-Che Cheng <giver@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769195203; l=1177;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=qdOEb1TELuVRMyiAyReucWqeGMrYnZ8kzoChaPtElBI=;
 b=3piP6dhLDDZmkys9vdmEphHovqfbXRPnhmzLIM794MNBLaAT+v3m+HBZ5AFou+xUAPH0i3an8
 kD7XIFV2UNwAlhulEl6XkgNN2gnwGmsJ7EdKHCh603ORjafluC3X4iH
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41386-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 177BB7A068
X-Rspamd-Action: no action

In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(). But
it never be released.
Use the __free(device_node) cleanup attribute to automatically release
the node and fix the leak.

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..b6d0c92f5522 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 				 struct cooling_spec *c)
 {
 	for_each_child_of_node_scoped(cm_np, child) {
-		struct device_node *tr_np;
 		int count, i;
 
-		tr_np = of_parse_phandle(child, "trip", 0);
+		struct device_node *tr_np __free(device_node) =
+			of_parse_phandle(child, "trip", 0);
 		if (tr_np != trip->priv)
 			continue;
 

---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20260124-thermal_of-91774eece689

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


