Return-Path: <linux-pm+bounces-35760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC011BBFD32
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF8D74F3450
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6F23B63E;
	Tue,  7 Oct 2025 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT+zeqD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAF239E65
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795239; cv=none; b=R+d+mUs1uko5jSR1mvAN80jLlj/UgeiABYmF4ytZraJMWYcsvbtim7Urvpb4VD/EMMc+ZCk67si/q3vakC1A1+7uUSgd2Dt2n7ztu0hdR4rYfpY5zlx+WfVmsAN4C+5bJXTnI8+OBDx0pXclohDBBxzzlYPYrsWEJGhumbsEyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795239; c=relaxed/simple;
	bh=GBPMFxcyATcinHz2L3AJDSb/kMMMuAbd+drLtO73/sI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aD+B9oZUB9A4D3pdK/lbZzuv7FbTKPm24VEdQc/h7ouBk9MSqHpAHoXqpTTzRdFteCSGSo52Eq3fPvd/7cfBRfppY1KJS2woOWDLh56Wd+6ViHpYbIlL9n2EZuMk3G23bracvVgpWfvD4APwdoM8XCBahF9PgdfigQooUiVgm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT+zeqD2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27ee41e062cso64893215ad.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795237; x=1760400037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGKXpJpqBqzMfm+XRzJ9DqWA3n0QzysPqL8GwN0dGls=;
        b=HT+zeqD2rdthnBqRYpixPYr8EzjEQNI2/jO8dIvrS58zyEZXPUwivmtC0mDC9Qx2S9
         qEzkKjVmeVxmqFOggjk7hbP+d6zfm8LcOwWpLc6mBLntt81JGJoiAOVbTpuXBVahl34u
         dibtdK1P3Rojike8Es+TxmrtLD6k7jEmhfVIzBcX5x08FFjwny73QZRkerrZn+QNXh4l
         JVIYKm3MK5WuLdSwLc8Qwwj9PwUB0TX7KSH45wriOme+A21t1WSpnvPctHpWZfwHK/MK
         7ugAxhtpmuslUH9Z2puiGENceKTP/3tkDvsjelpmk2wYKM2RLuBKzO9dQUyZ6adZmjzq
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795237; x=1760400037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGKXpJpqBqzMfm+XRzJ9DqWA3n0QzysPqL8GwN0dGls=;
        b=danhZEtqhHo6KYAOCzoN7j8sVQPoKxO+yQ338TBs8M3370eT7tfEouX4z11e8cCmC8
         QeX2mmfs1r7YDo5EZpsUlV95a5toH4/8I1IJekQ9Mp7kWpBwKd7DtbSj6ftEuZgfOWvB
         HOSQPRdhGxOomjt1W2TIUBsSf6RnM1kJS+rzS18AwNyuEBh88d1jyJ5qlkntG/2JRoY3
         kPCpBsZNxAk2bkscb8yHcSk/G6LyTIsAoW1DjcI9SC6xuyR6hTkw76wUU2xf4XlpSlJ4
         8vV8r1qh51k1a3I8f9iC9uRK1vb0uCJX5i4iuyC9M63heF2LG21AL2P3eL3jZ6on1PWK
         Jzag==
X-Forwarded-Encrypted: i=1; AJvYcCWCUUWQo6o6lm6OuWIGykFAibK3kj34KnL0s9jgpolFJofIqCnVHLLnKMzniYSQt4XpAxlwJQ0fOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz9ceLVqJDlkFSfO/iwoRI9TpwuK9FYHXW5pysw0uoG/B2p6s
	hZrEIkr1+faMCxfHJxAaVP272I23eWGCKTjvii01O8gPE7LUFtgU74YxsCZKfLBTHshladtG3Rz
	QKbIFfQ==
X-Google-Smtp-Source: AGHT+IF8hGVIlChbtIhMjhLw3aZZeNeEt0jbndtu/J7HYN5bXvwyE+kZ9qVypMx6ixiiCHlMmAe0pYoqYCs=
X-Received: from plhi5.prod.google.com ([2002:a17:903:2ec5:b0:24a:b588:eefd])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac3:b0:267:f121:6a88
 with SMTP id d9443c01a7336-28e9a6dc287mr175381245ad.42.1759795236620; Mon, 06
 Oct 2025 17:00:36 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:07 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-7-jthies@google.com>
Subject: [PATCH 6/6] usb: typec: ucsi: pr_swap should check connector_status
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Power role swaps initiated by the host system doesn't generate
connection status change notifications.

From UCSIv3.0 spec, section 6.5.10 Set Power Direction Role:

The execution of this command might require PPM to initiate a power
role swap. If the power role swap fails for any reason, the command
returns, and error and the power direction should remain unchanged.
Note that if the execution of the command resulted in a successful
power role swap, it should not result in a connector status change
notification.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1a7d850b11ea..6e3797d7a144 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1526,20 +1526,40 @@ static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
 	if (ret < 0)
 		goto out_unlock;
 
-	mutex_unlock(&con->lock);
+	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &con->status, sizeof(con->status));
+	if (ret < 0)
+		goto out_unlock;
 
-	if (!wait_for_completion_timeout(&con->complete,
-					 msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
-		return -ETIMEDOUT;
+	cur_role = !!UCSI_CONSTAT(con, PWR_DIR);
 
-	mutex_lock(&con->lock);
+	/* Execution of SET_PDR should not result in connector status
+	 * notifications. However, some legacy implementations may still defer
+	 * the actual role swap and return immediately. Thus, check the
+	 * connector status in case it immediately succeeded or wait for a later
+	 * connector status change.
+	 */
+	if (cur_role != role) {
+		mutex_unlock(&con->lock);
+
+		if (!wait_for_completion_timeout(
+			    &con->complete,
+			    msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
+			return -ETIMEDOUT;
+
+		mutex_lock(&con->lock);
+	}
 
 	/* Something has gone wrong while swapping the role */
 	if (UCSI_CONSTAT(con, PWR_OPMODE) != UCSI_CONSTAT_PWR_OPMODE_PD) {
 		ucsi_reset_connector(con, true);
 		ret = -EPROTO;
+		goto out_unlock;
 	}
 
+	/* Indicate successful power role swap */
+	typec_set_pwr_role(con->port, role);
+
 out_unlock:
 	mutex_unlock(&con->lock);
 
-- 
2.51.0.618.g983fd99d29-goog


