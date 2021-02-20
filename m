Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65767320288
	for <lists+linux-pm@lfdr.de>; Sat, 20 Feb 2021 02:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBTBeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 20:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBTBe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 20:34:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DBCC061356
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 17:33:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y7so8742839ybh.20
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tPkjdQhNlqZVXDpP5yJgn/R3eqKmcVsk79AVXI8yHkQ=;
        b=Zx50wp6habmm6+el0TIzo0u7qOHlCOm21tfyU7IeCbHpyUo7RXM/ydodtfrTNKPyGb
         MhaJpJpsJf+vI14d2qHuFRiUFuReEp0S/K7CtcPKjs2EKEuZiNStl1e/msyn3l6N46Pj
         p1pQpnZkVz8QeYowO9xojdH5MWeLZnVwsz7xFNXX5JzKFmjpwj/wIMKIZlpinnc4YaJx
         ZGAUtAy0adcnnaSP8O2yLv71fABrXaKJrXh2EBvogj1lunWMUvSAtbM0uI7qGNBjc0h3
         /AWBOgoRtEciq8n8xF7tXUUpNu91aBJPkMh0GE36bCFZgERd4YManl6OLsFCNlsclsa9
         t6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPkjdQhNlqZVXDpP5yJgn/R3eqKmcVsk79AVXI8yHkQ=;
        b=rFdP24MZsuABgANZFyn0ruspgnUKM8zuZc9oeaDlLOo+fvP6koAFzyW4x4UCMgUPmn
         WN4TIZJ7AHX82gcMZeirL61uVAdnCOBse3PHnto8RV2gl5vjvYKXUQvJ18HEbo2T5ni7
         rP8+SSNsVhHkrTXcWSFgkGLmTrqzRpfsfHw5dQ0BHxhcQnxv30zb3kxUBPeGRbQ10BTl
         xXCzlzsf45VXIWCk9yaXLGXIvifrm+0TGaGHcYjXLs925Y/Vuidmq/EXlTY/XZZW+1XY
         3JcyW43hlDi+fMb2JFnhXHaxQE38N8g4JtxiBCTE5GktWRcoFI28z+/d3B9h3FcTPBFu
         sJag==
X-Gm-Message-State: AOAM532WYLCBIWuy7e4gG+s9eIRKk+KJtv54zMgKjrLI6T7cpqnM987R
        vtz8MZUD48KduUfGa9uTPFGqw7wgHDJuPvkaXQVeqQ==
X-Google-Smtp-Source: ABdhPJzTMQoKiRt/GYbXbn1GNs0pzvQ+nRqhRk4fsDdWCk5ewihgfX4+8XyXioiXAte1nX5OIp6R/wPQ+jYr+bOPC7HGlw==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:545:: with SMTP id
 66mr17576310ybf.348.1613784791161; Fri, 19 Feb 2021 17:33:11 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:49 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 3/9] security: keys: trusted: Parse out individual components
 of the key blob
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Performing any sort of state validation of a sealed TPM blob requires
being able to access the individual members in the response. Parse the
blob sufficiently to be able to stash pointers to each member, along
with the length.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/keys/trusted-type.h               |  8 +++
 security/keys/trusted-keys/trusted_tpm2.c | 67 ++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a61d8f..020e01a99ea4 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -16,14 +16,22 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define MAX_CREATION_DATA		412
+#define MAX_TK				76
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
 	unsigned int key_len;
 	unsigned int blob_len;
+	unsigned int creation_len;
+	unsigned int creation_hash_len;
+	unsigned int tk_len;
 	unsigned char migratable;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
+	unsigned char *creation;
+	unsigned char *creation_hash;
+	unsigned char *tk;
 };
 
 struct trusted_key_options {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..6357a51a24e9 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -50,6 +50,63 @@ static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
 		tpm_buf_append(buf, hmac, hmac_len);
 }
 
+static int tpm2_unpack_blob(struct trusted_key_payload *payload)
+{
+	int tmp, offset;
+
+	/* Find the length of the private data */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[0]);
+	offset = tmp + 2;
+	if (offset > payload->blob_len)
+		return -EFAULT;
+
+	/* Find the length of the public data */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	offset += tmp + 2;
+	if (offset > payload->blob_len)
+		return -EFAULT;
+
+	/* Find the length of the creation data and store it */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	if (tmp > MAX_CREATION_DATA)
+		return -E2BIG;
+
+	if ((offset + tmp + 2) > payload->blob_len)
+		return -EFAULT;
+
+	payload->creation = &payload->blob[offset + 2];
+	payload->creation_len = tmp;
+	offset += tmp + 2;
+
+	/* Find the length of the creation hash and store it */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	if (tmp > MAX_DIGEST_SIZE)
+		return -E2BIG;
+
+	if ((offset + tmp + 2) > payload->blob_len)
+		return -EFAULT;
+
+	payload->creation_hash = &payload->blob[offset + 2];
+	payload->creation_hash_len = tmp;
+	offset += tmp + 2;
+
+	/*
+	 * Store the creation ticket. TPMT_TK_CREATION is two bytes of tag,
+	 * four bytes of handle, and then the digest length and digest data
+	 */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset + 6]);
+	if (tmp > MAX_TK)
+		return -E2BIG;
+
+	if ((offset + tmp + 8) > payload->blob_len)
+		return -EFAULT;
+
+	payload->tk = &payload->blob[offset];
+	payload->tk_len = tmp + 8;
+
+	return 0;
+}
+
 /**
  * tpm2_seal_trusted() - seal the payload of a trusted key
  *
@@ -64,6 +121,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_options *options)
 {
 	unsigned int blob_len;
+	unsigned int offset;
 	struct tpm_buf buf;
 	u32 hash;
 	int i;
@@ -139,14 +197,16 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		rc = -E2BIG;
 		goto out;
 	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+	offset = TPM_HEADER_SIZE + 4;
+	if (tpm_buf_length(&buf) < offset + blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
-	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
+	memcpy(payload->blob, &buf.data[offset], blob_len);
 	payload->blob_len = blob_len;
 
+	rc = tpm2_unpack_blob(payload);
 out:
 	tpm_buf_destroy(&buf);
 
@@ -215,7 +275,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
+	else
+		goto out;
 
+	rc = tpm2_unpack_blob(payload);
 out:
 	tpm_buf_destroy(&buf);
 
-- 
2.30.0.617.g56c4b15f3c-goog

