Return-Path: <linux-pm+bounces-41340-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mINWAXjLcmlgpgAAu9opvQ
	(envelope-from <linux-pm+bounces-41340-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9536EF03
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F4B3018BD3
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88283659F8;
	Fri, 23 Jan 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DoEGKZFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B90363C64
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130856; cv=none; b=KcWEawwzazjRM3mxcpu/4gmGfhZAgg+LEPPhFHHitqbYgH2c2jzijIE/fHzuFcdgKiZlbZn7bRS9ypLzqKkS77yWgqkAfX9wTAuqyCVhfwQyEyA7UOEKtFx6Vmv9YRfBSZeAmHMM3e62CwO+R7D9Us4pFq3cmvaLuOF/JQcurUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130856; c=relaxed/simple;
	bh=He+aEhwIQiKMM6RZOhPxZk8LJB9l4Qy9dfY/jCduGYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6dLxR2UBmIpjUE+sC7wr443oC0RszUMi6SGuXH1h6k6nohen1bJZ8NIB97GrxodFL1r8mIzJED2CMtbwSgzEWZ+GFvEdPqB56rfXA50uKCq+V3hcOK//+BsGjLKsZu/Xy+n1HwbA10Xm02Q51ipC4H0MYjZf15TmpaQoHiBNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DoEGKZFv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so1478695a91.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769130849; x=1769735649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jIXagkMxzEowZbGtgfSPfOl3cdbEam+H5UuhcUy8Cw=;
        b=DoEGKZFvU1sCuSVeI1f1e651/D0ocFTgNTL2Dilm3MHgUzCUfORahQVeKnfWxgjdFQ
         n9Wb4F67rIbUSZkyvJj2NkNMdlvaN25uPe5aVqxqNAqr1hgQHWxERpx+LLiXs0+E+E33
         Rl9N2S1srNOokfQhCL+Dufy/7WxokvumGa8BZaJjT/bEfjxee2XpJzEw1hM19RcM2b0+
         JAO35qQG0Z1cpH9nmuTlBLv6+j91GUMRq1xv5sn24wHxJLu+uf7Dz37SiYnhGmEDNDYV
         kYrAU8GxXfVlB6fZlOonMKFX+zyU14SbnRgqXrq8tuyaRKugAPO6eaQCtZPAgsTS7ehS
         HStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130849; x=1769735649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jIXagkMxzEowZbGtgfSPfOl3cdbEam+H5UuhcUy8Cw=;
        b=qhDJoFllMYiYkCw1s90AXjYNQpy6IvqCznOFRY8OHMSII9OcqqesbvXL098uY6UQQs
         kSjTVVx9+UZv0KziFeocphoNVydH+1/Qt/Lqz6q7mt0URzYZfOcwKs+E0aPXp0jwy0V+
         pEYlfVUIqCKy1ZPjY8/6zPZoLpqNBOZvvvcsiFdrY/gGBVsm1Z+6qKIJhduzPEYmbUiS
         eDBTY97TSyQW7HVORWJgGpDZP6cer8I/P81iGBjLIVZnOHZDGzDCt7ajdbpXPgCHVxnZ
         hfBRVkKQUKhYP2vuB4TT18Wi8DH7e96IJSOmJVN7uWeGzflrJetjSAfN4dPKeRBrKVOP
         plEA==
X-Forwarded-Encrypted: i=1; AJvYcCX8CHaZrJxM4B32zLZ4Tuu4p7ne9rEyKgoU37Tb7FPy9lyuYjCpxom2DyQ9AFbkEEmyxArOkRDYRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyicQ+mEDydOBV+NJ7H/A4qAdZ2PA7rXGbpglONWlhnCLDHqqmP
	58Su7M62Vp5kQNoNfutxmC7pu9dcXKyT9tnBoMG7+BMbnHdCGPfn5NojvprYSOIvDs8=
X-Gm-Gg: AZuq6aLzqY6+XsTusDfhVd834f4EdmkH+2XvIR7eOmUs8Un+MI8UPKPTXUiLwx3Tnk0
	Mz1lXuXhTEG2pp/0h4N+NFK/IWDGggCgILjvJ2gYyNZd3FfijSsCOVcAFI0jBgze7NqrxWnNIF4
	4izuf95qzzJHx68BqSj6etn9HZcmKdAoV5lWe32bOEiBMnkbEpx2CNyF8L40ZdekyGlh1BJK943
	OygzJSEVPh71y7EeT/F9423m4LjmRBx3mlMcprkhQa30/KdzFGtY4p+6D1NXnr1c9xd7NDoIs0L
	xhMd62CWqOv6YyXllGCtHomEefbFTc+JuPXXT6SXfwRct7z5WuwknREW0enhepM/uALZzQN5Icp
	vzzN401vt3t6qbOssStVZteozPAHuzQV0jAPpsopOt4JDbXjwNQtZWGNGkYGCw7Fu6S/V/zkedx
	9RUBgHSPc8
X-Received: by 2002:a17:90b:3a90:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-3536894c5e5mr1159857a91.17.1769130849520;
        Thu, 22 Jan 2026 17:14:09 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335205a2fsm3478280a91.2.2026.01.22.17.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:14:08 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 22 Jan 2026 17:14:01 -0800
Subject: [PATCH RFC v5 2/2] pmdomain: arm_scmi: add support for domain
 hierarchies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-pmdomain-hierarchy-onecell-v5-2-76855ec856bd@baylibre.com>
References: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
In-Reply-To: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=He+aEhwIQiKMM6RZOhPxZk8LJB9l4Qy9dfY/jCduGYY=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcstetXh6fJOBD4eHHjr+saQFKxgmd6v0zRhkf
 ug0omaqIIqJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXLLXgAKCRBZNxia0/vG
 ZQIgD/4i6Uc4w60OsIRYYqeP8oLa2eb6CzQU8aLVsNoiDPuv5uZnYUTHquh3eLM04pOyjyL938g
 jEvUGJVhqeiMw8clJVY3pP85aE6pIqEHRh4MtNLdHFbzeMVmk7jLxOO37wW3lO6HjPj/fOKkVlj
 0hZ+eWyeo0DaLjAv20+LezZ47MUqkgRenx1FTRbkul4dY7+EvEunrgq0CW4xeSz1erh3GKCMjp3
 xhUoU0zK7IaVczg3aPfyJcNVWM2CYMxpogkEQrN9GY8tVpRRQ8k4GdjZ3y1FDHnIUCQ/XH1c4Hn
 Ep2a0POgfv0x+p444bxRdhFrasXjYcab98iS7YT90j4ONuBxfpBeQwoJRKmmpCAZodwhQMjTfsb
 NKLq/J6fZDebRb0SJvJFqq80Sa7lb6XMZpOa/jgC3vL49YUrfcv9HEUyyxyb1s+d+usdDq/F6oy
 4TeuublXmf/HOY/u/Rc9CgQoBGjNuE4vNZJrf7i+JN0snIoHtb3es1oe4QsQF0MwYQra7G4dbAA
 0pyJeB/CjLJ41MmMcQ/FlF7CYfFxLOCKv+4AUnzrBBdQj3A+xjQbMEkxeAMsOmFGA/S1AMLN1hQ
 w3BjZGZkqJ/HIcunTq8hG0EZiT2dbl6rSz9o0Hn6GIpNKMvsRCHHaNDewPA7Lwu3+Q0MDXbzeMq
 yGl7x/R9Wppf8Pg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-41340-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D9536EF03
X-Rspamd-Action: no action

After primary SCMI pmdomain is created, use new of_genpd helper to
check if there are any child domain mappings defined by
power-domain-map, and create domain hierarchy.  Also remove any child
domain mappings when SCMI domain is removed.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index b5e2ffd5ea64..a52387c45d88 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -114,8 +114,12 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 
 	dev_set_drvdata(dev, scmi_pd_data);
 
+	/* check for (optional) subdomain mapping with power-domain-map */
+	of_genpd_add_subdomain_map(np, scmi_pd_data);
+
 	return 0;
 err_rm_genpds:
+	of_genpd_remove_subdomain_map(np, scmi_pd_data);
 	for (i = num_domains - 1; i >= 0; i--)
 		pm_genpd_remove(domains[i]);
 
@@ -132,6 +136,7 @@ static void scmi_pm_domain_remove(struct scmi_device *sdev)
 	of_genpd_del_provider(np);
 
 	scmi_pd_data = dev_get_drvdata(dev);
+	of_genpd_remove_subdomain_map(np, scmi_pd_data);
 	for (i = 0; i < scmi_pd_data->num_domains; i++) {
 		if (!scmi_pd_data->domains[i])
 			continue;

-- 
2.51.0


