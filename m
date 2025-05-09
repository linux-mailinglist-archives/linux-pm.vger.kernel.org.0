Return-Path: <linux-pm+bounces-26960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C5AB191C
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7140F189B658
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF321ADAB;
	Fri,  9 May 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QRmU5zst";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hg7cGgUB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QRmU5zst";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hg7cGgUB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95F223339
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805524; cv=none; b=f/hPxDxKGetjHDsokfYgDqnW95c5h2nThTL4ikYcVL2/5U9umTNHxyJs0ceWeKO2MyTo/Nupqk8SFqd2P29WG/F/xZPWSb5HmsUf1jBkY9y6inmGE6BHLCr64BewNAjPNZr4S/2ppOgeZTjpoIaoypWGtL3uzzG7rPVdBjbc6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805524; c=relaxed/simple;
	bh=iEPmrNDw6oA1zyTTQ5JrygM60YuOw7HcOeYL67WI2eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkV/cLM1GoiD/z2S8aRKVzVSZxwfmR455e5L64POJ6OHBIBsWOzXYOmbkH5c+z9YyWbLetzUqPETqA3PE6TO5YpJKE045zqQVoywkbnqOb3EWOPfoEYtJhGsYxDfBop3TraFDWXgJ1BANxvD96kNQXpU4zrU/gZSUcCHoDPH4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QRmU5zst; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hg7cGgUB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QRmU5zst; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hg7cGgUB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7686F2116B;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9PQYx18lRmS4BJShvwDOy7JslPyNKHjZOJal/XTnKo=;
	b=QRmU5zstBxxRiTo2YXW8Jy74bTkFfMdBM3UCIX8HXPQw9+k8YASx8PY2Gr3pSP/TN210Mo
	Y1bHa02WFNI2VUUYsrDjiXF/nkYARBLpPeWCjKFHvLixl4lgFmLqzgDZqcvcNXaAD4Woou
	4rzMZGyVR6uZaqhHDz1hZcECSfe0s0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9PQYx18lRmS4BJShvwDOy7JslPyNKHjZOJal/XTnKo=;
	b=hg7cGgUBwDWrSe8Lh+ewPVBd7oYzmHMRUWiVl//qxQE1HgAuhWdFs4HK/8K615rb/+k/0+
	zE6qGutoDFdZaZDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QRmU5zst;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hg7cGgUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9PQYx18lRmS4BJShvwDOy7JslPyNKHjZOJal/XTnKo=;
	b=QRmU5zstBxxRiTo2YXW8Jy74bTkFfMdBM3UCIX8HXPQw9+k8YASx8PY2Gr3pSP/TN210Mo
	Y1bHa02WFNI2VUUYsrDjiXF/nkYARBLpPeWCjKFHvLixl4lgFmLqzgDZqcvcNXaAD4Woou
	4rzMZGyVR6uZaqhHDz1hZcECSfe0s0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9PQYx18lRmS4BJShvwDOy7JslPyNKHjZOJal/XTnKo=;
	b=hg7cGgUBwDWrSe8Lh+ewPVBd7oYzmHMRUWiVl//qxQE1HgAuhWdFs4HK/8K615rb/+k/0+
	zE6qGutoDFdZaZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 378BD13A2C;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wMxhDAsjHmgrYwAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 09 May 2025 15:45:15 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	mmayer@broadcom.com,
	Wolfgang Frisch <wolfgang.frisch@suse.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Thomas Renninger <trenn@suse.de>,
	Thomas Renninger <trenn@suse.com>
Subject: [PATCH 2/3] tools/thermal/tmon: Make sure ctrl_cdev is a Null terminated string
Date: Fri,  9 May 2025 17:44:34 +0200
Message-ID: <20250509154435.14670-3-trenn@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509154435.14670-1-trenn@suse.de>
References: <20250509154435.14670-1-trenn@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7686F2116B
X-Spam-Flag: NO
X-Spam-Score: -3.46
X-Spam-Level: 
X-Spamd-Result: default: False [-3.46 / 50.00];
	BAYES_HAM(-2.95)[99.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action

Found by compiler warning:
warning: ‘strncpy’ specified bound 20 equals destination size [-Wstringop-truncation]

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/thermal/tmon/tmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index e7392c0f6388..f803f2a2fb12 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -251,6 +251,7 @@ int main(int argc, char **argv)
 		case 'c':
 			no_control = 0;
 			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
+			ctrl_cdev[CDEV_NAME_SIZE - 1] = 0;
 			break;
 		case 'd':
 			start_daemon_mode();
-- 
2.49.0


