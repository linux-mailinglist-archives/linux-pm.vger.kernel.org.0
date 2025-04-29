Return-Path: <linux-pm+bounces-26389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84985AA1BC3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B11E7A260F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E525E821;
	Tue, 29 Apr 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/3rIbRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB9254B19;
	Tue, 29 Apr 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957026; cv=none; b=VM+xIrveotyBi0b0l/Ym/M/bA5jgR+yY+/F8bqW0OmFozPnbTztYGxIV8NeQlhO9Ec0MoVLw8VX/I4yiAVsZUs1tuDjmgyI86/S5sacOSOHyLotqb89/YOmLQ/WnjRkIkBwzibfy5txnlmreiRglftY7ojtjdPy+yXsacjJNzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957026; c=relaxed/simple;
	bh=OcNmXWcVfN2D2A9bVDTuH9ng9jsYPZRLKck1S3I/5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EB7f1axxXs4KuDig0gV9ZkR+0hLuIoy+EasoEzVqcyTepiXcbr4+GgIbZ+IxMeD2nkXPSGYy4YBcE/oY2ifhj0guZyPQ/TSsgXCQ70nm6FZuHEIIWfbtlsOZy7PIa2inrkFwy0qU/1BYvxu/YOiS4i9+J+VZF7cVNSMBaJMxfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/3rIbRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB7C4CEE3;
	Tue, 29 Apr 2025 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745957025;
	bh=OcNmXWcVfN2D2A9bVDTuH9ng9jsYPZRLKck1S3I/5wY=;
	h=Date:From:To:Cc:Subject:From;
	b=T/3rIbRlMtLhstfSA8xy2NAdq1w+elubtky19lTsnOqKFaZgoJKRKfq+ohnrpg+LW
	 MTbPH9bE1P5f/8e4oc6Yd0uozAe+24FN5apRFu0gRKEzzVkRRPFRhdSnlC5x6Qa8pv
	 A2l9lyuFd7s5M1HRhjKykKIOtvV5cVV24rbFXmIHKRnmWiDE31mKZWke0zrjwkkWbu
	 66ze56nA3UN13NTz8//KPzcSIZImRJnvmFJMJ9UA7GmBXvKL/ZBMd6TuCA3S3b+lvX
	 4huVx6JBFG4M43bGuRmHr7E4U/jFoIBZWd2x/U4qxL5aiDl35QfG0fTW5Zg/cHK5ws
	 yu7er2ll2Fm4g==
Date: Tue, 29 Apr 2025 14:03:40 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] power: supply: cros_charge-control: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aBEwnKtUOTYzS7C3@kspp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Replace an on-stack definition of a flexible structure with a call
to utility function cros_ec_cmd().

So, with these changes, fix the following warning:

drivers/power/supply/cros_charge-control.c:57:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use utility function cros_ec_cmd() instead of DEFINE_RAW_FLEX(). (Thomas Weiﬂschuh)

v1:
 - Link: https://lore.kernel.org/linux-hardening/aBEmk6ixfrQ2XpTw@kspp/

 drivers/power/supply/cros_charge-control.c | 23 +++++++---------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 02d5bdbe2e8d..53e6a77e03fc 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -47,29 +47,20 @@ struct cros_chctl_priv {
 static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
 					      u8 cmd_version, struct ec_params_charge_control *req)
 {
+	int ret;
 	static const u8 outsizes[] = {
 		[1] = offsetof(struct ec_params_charge_control, cmd),
 		[2] = sizeof(struct ec_params_charge_control),
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
+	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
+			  outsizes[cmd_version], NULL, 0);
+
+	if (ret < 0)
+		return ret;
 
-	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+	return 0;
 }
 
 static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
-- 
2.43.0


