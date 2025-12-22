Return-Path: <linux-pm+bounces-39780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F2CD66D3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770C33056C7D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AEC305046;
	Mon, 22 Dec 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IdepjXYL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6dvim8nk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IdepjXYL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6dvim8nk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B13043BE
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414690; cv=none; b=L8PpKU3TpzMDv+h9i7hWb04I1NHjfIb0sKAJbBZ8ZB0pMVp9bdmXLGrV4vzYZVmH8IeNVWigBLv6oe5Z2Ah8DMqn3JC0tKEauim6gbhSHG2Pv2DXl6fSyVhryRuxSKCjdAx62F8r4pXo/mtewsP7pQ7A3ZjMa+hMbIGuuKJFHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414690; c=relaxed/simple;
	bh=ccvJ85kiH7tfA85ZrbZ0XqHjiBJ9Ss7qGPDiQDVdoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q8YVUtkwdgUQbHkv6fLJYWJug5rNvct6kGklBsLT9AK/mNqO6u/7GSvMrhyIp4csz9rpeugYvmyiohKZdLk6rwxjqIL9G/KjD/uYbbPjtjEe3XfC3GYOOKwA5BgHIH9MA95DWSBzt9FATc5odN8EURxxt/3sK0VJZNhG57GUfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IdepjXYL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6dvim8nk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IdepjXYL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6dvim8nk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F5C15BCD3;
	Mon, 22 Dec 2025 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766414686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwKkHIWaOQ7qwy6pJPd9I9du04yxkvGTN7bKQHalNHY=;
	b=IdepjXYLCtiQhCPCEN+cYtVJdIe6d8E1TraJG61NnCf8wI2uTZuGsQhFc495Dd4vzIbUDG
	7q+ezBM4jzY0H+Sy5h8ooxNc2OVk5C43z5Zckx9epRZioe7OG73Go1pQiQAYzinbykVgep
	XWgbke/CgR2M3WEBEJUZ5YwOstMNtPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766414686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwKkHIWaOQ7qwy6pJPd9I9du04yxkvGTN7bKQHalNHY=;
	b=6dvim8nkEOJ+gjVvtrlAGO2qDJKIQBgMcXFugT+I2OlRM8MtUkowXCIryUt8UzNKKVZHPY
	dS9tksiT7GNPriDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IdepjXYL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6dvim8nk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766414686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwKkHIWaOQ7qwy6pJPd9I9du04yxkvGTN7bKQHalNHY=;
	b=IdepjXYLCtiQhCPCEN+cYtVJdIe6d8E1TraJG61NnCf8wI2uTZuGsQhFc495Dd4vzIbUDG
	7q+ezBM4jzY0H+Sy5h8ooxNc2OVk5C43z5Zckx9epRZioe7OG73Go1pQiQAYzinbykVgep
	XWgbke/CgR2M3WEBEJUZ5YwOstMNtPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766414686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwKkHIWaOQ7qwy6pJPd9I9du04yxkvGTN7bKQHalNHY=;
	b=6dvim8nkEOJ+gjVvtrlAGO2qDJKIQBgMcXFugT+I2OlRM8MtUkowXCIryUt8UzNKKVZHPY
	dS9tksiT7GNPriDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1065B3EA63;
	Mon, 22 Dec 2025 14:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RJ67AV5ZSWkABAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 22 Dec 2025 14:44:46 +0000
Date: Mon, 22 Dec 2025 15:44:44 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>
Subject: Lack of Kaby Lake support in intel_pch_thermal
Message-ID: <20251222154444.496284d9@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 5F5C15BCD3
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi all,

We have this report in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=219197

which suggests that adding Kaby Lake (aka 200 Series) chipset support
to the intel_pch_thermal driver would be trivial. I asked the reporter
to send his patch to the driver maintainers last year but it does not
look like he ever did. I can clean up his patch and send it, but before
I do, I want to ask: is there a reason why Kaby Lake support was
omitted in the first place?

Thanks,
-- 
Jean Delvare
SUSE L3 Support

