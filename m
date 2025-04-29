Return-Path: <linux-pm+bounces-26387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE0AA1B47
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 21:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0691F3A55B3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B925E472;
	Tue, 29 Apr 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKN1cbFQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473B259C9D;
	Tue, 29 Apr 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954456; cv=none; b=i88A+GMKerzwMMC/XF6PTdxNVXMRwZJ0OUr63UWvDyK1N02Blro90oFKyl0a3E4YS1Jl4zkQj6Po3ckA093OAG3/nLrmm16+IX7REzH//HpKbSh8/9UaWDERV2/0oZ1DtC5bbkWRFrrlGAOeQ1LMMe13D7fVdmtniybY7f+As5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954456; c=relaxed/simple;
	bh=1ARwXxe8pdNgLXp+etb58lUobvz2R+B72ZZn8/OpA04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k672tJhJX2p07oFXF5JB2pE0LfIxQZe1lR2MdlEhhZn9sImW6BsPkshGouD82UMr3+9AY9HXNgjxNW0bdFBEr6qUnh46yOH9hpx5UHUH5ETuM8AHbDdKdIuTssl7Xn2DiU3xxY3UtruA1UWd87pzWKyNsL4s9+rjnoMkQ22gMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKN1cbFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70424C4CEE3;
	Tue, 29 Apr 2025 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745954456;
	bh=1ARwXxe8pdNgLXp+etb58lUobvz2R+B72ZZn8/OpA04=;
	h=Date:From:To:Cc:Subject:From;
	b=iKN1cbFQwYMqjjMB8+RRbf8nUT8bU+TX4dLNIZvHoYSms7tOTa5qXtsDXNvptljTT
	 TDE+90CSU3NY8t3BGLIUcVzbCchK2e+Ue+5tFOIQulhu37PkmQL5HVoXWCMkCYwJZF
	 aCPNNifFVJQSMGJdhqkq08G5FMwwxkcUpWZzLCkvBfjBJlU/Mp4KfsN0kjlLk9p71D
	 JfkViq1CJ995Tuk5jXRxyvM5YWBElPGedgKMZOkFPiIXXf0oMPZTlZfRJDITttuNbc
	 Lf70OKATJswzMqh2du+EuZyAcVK4Zlhb4nE8nXgUDBKgdvzf5GYF6PqSpYYKoXT5LB
	 OMXys3kmuElvQ==
Date: Tue, 29 Apr 2025 13:20:51 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] power: supply: cros_charge-control: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aBEmk6ixfrQ2XpTw@kspp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of a
flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/power/supply/cros_charge-control.c:57:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/power/supply/cros_charge-control.c | 26 +++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 02d5bdbe2e8d..e33bc4c55bcc 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -53,23 +53,17 @@ static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
 		[3] = sizeof(struct ec_params_charge_control),
 	};
 
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_charge_control req;
-			struct ec_response_charge_control resp;
-		} __packed data;
-	} __packed buf = {
-		.msg = {
-			.command = EC_CMD_CHARGE_CONTROL,
-			.version = cmd_version,
-			.insize  = 0,
-			.outsize = outsizes[cmd_version],
-		},
-		.data.req = *req,
-	};
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			MAX(sizeof(struct ec_params_charge_control),
+			    sizeof(struct ec_response_charge_control)));
+
+	msg->command = EC_CMD_CHARGE_CONTROL;
+	msg->version = cmd_version;
+	msg->insize  = 0;
+	msg->outsize = outsizes[cmd_version];
+	*(struct ec_params_charge_control *)msg->data = *req;
 
-	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+	return cros_ec_cmd_xfer_status(cros_ec, msg);
 }
 
 static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
-- 
2.43.0


