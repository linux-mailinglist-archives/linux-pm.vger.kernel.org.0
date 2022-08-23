Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9059EF32
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHWW02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiHWW0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 18:26:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDEC87096
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 15:25:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso16087488pjj.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xSQKGWLEW/kUQwiNWyncH9Xp5s+ASlV194q1jpJPOQw=;
        b=dMFSA6x1duIowrTxa5xI9MFep/heDTq8cj9utyAUvGpwtN0PBwCrEwYkBYtpfIA0XB
         u0o1PWf/neWzT73SL0XPQT95t6CsWbbKgg/5XtzZz8XrTQrio/0TBlopjgwfugE9iCeB
         J2ssMqpQ2fOEV3iLudF+Nrna/KhoEqJ+yPC7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSQKGWLEW/kUQwiNWyncH9Xp5s+ASlV194q1jpJPOQw=;
        b=aLISseVQU3Md6c3Ntg0BIULsXyl5SqVn9We/mE6oQiXVgU5tWTmyeRQ5Gj8Ph54d4T
         U5XNh1SCnVKT2chIwjO13mmXSOynvuCA9a/zvvQmYWGe5GntJKMkrXR7FHKurUYLvhdd
         SWqio9qHXZlmVIbwFlwmePnL8cAIDQ/ZpQzDDa/70LoVQ7yzqv0oQde57/xyjUqrUOme
         UQouZ4NSY+II9yyVBIfJsSlCaowaifW+VPilmSOZ0t0B98P/N7Gd5DX3esVR+06eJhER
         1ilQSv67OEW76NIxnxWEusCFVaMSRB29BaWUxwirz8Sap6Ms8zfIE0ge+1ZT3nfRA3za
         POQA==
X-Gm-Message-State: ACgBeo3pispz2PrEc4CVSD0JJNK5rWFaEkBFE575ckQbugbEUD81dUZH
        jsTrF/MqmxkHzJxrBwAiliS4zQ==
X-Google-Smtp-Source: AA6agR4EAufBpEOyvq0nP8MHgnnultni3r6jafYIEsU16dhG8QKjr+jH/gZgzBUiOrv2Hg5PMg0j8g==
X-Received: by 2002:a17:90a:bf0a:b0:1fa:b53c:3f3a with SMTP id c10-20020a17090abf0a00b001fab53c3f3amr5247240pjs.126.1661293555045;
        Tue, 23 Aug 2022 15:25:55 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:25:54 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: [PATCH v2 01/10] tpm: Add support for in-kernel resetting of PCRs
Date:   Tue, 23 Aug 2022 15:25:17 -0700
Message-Id: <20220823152108.v2.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Add an internal command for resetting a PCR. This will be used by the
encrypted hibernation code to set PCR23 to a known value. The
hibernation code will seal the hibernation key with a policy specifying
PCR23 be set to this known value as a mechanism to ensure that the
hibernation key is genuine. But to do this repeatedly, resetting the PCR
is necessary as well.

From: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Matthew's original version of this patch was at:
https://patchwork.kernel.org/patch/12096487/

(no changes since v1)

 drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  7 +++++++
 5 files changed, 107 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce8187052c..17b8643ee109c2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
+/**
+ * tpm_pcr_reset - reset the specified PCR
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @pcr_idx:	the PCR to be reset
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		rc = tpm2_pcr_reset(chip, pcr_idx);
+		goto out;
+	}
+
+	rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
+
+out:
+	tpm_put_ops(chip);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_pcr_reset);
+
 /**
  * tpm_send - send a TPM command
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 24ee4e1cc452a0..a80b341d38eb8c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -175,6 +175,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
+int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
@@ -217,6 +218,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c738510529..8ec743dec26544 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -478,6 +478,40 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	return rc;
 }
 
+struct tpm_pcr_selection {
+	u16 size_of_select;
+	u8  pcr_select[3];
+} __packed;
+
+#define TPM_ORD_PCR_RESET 200
+int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg)
+{
+	struct tpm_pcr_selection selection;
+	struct tpm_buf buf;
+	int i, rc;
+	char tmp;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_RESET);
+	if (rc)
+		return rc;
+
+	selection.size_of_select = 3;
+
+	for (i = 0; i < selection.size_of_select; i++) {
+		tmp = 0;
+		if (pcr_idx / 3 == i) {
+			pcr_idx -= i * 8;
+			tmp |= 1 << pcr_idx;
+		}
+		selection.pcr_select[i] = tmp;
+	}
+	tpm_buf_append(&buf, (u8 *)&selection, sizeof(selection));
+
+	rc = tpm_transmit_cmd(chip, &buf, sizeof(selection), log_msg);
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 #define TPM_ORD_GET_CAP 101
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 65d03867e114c5..69126a6770386e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -269,6 +269,42 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
+/**
+ * tpm2_pcr_reset() - reset a PCR
+ *
+ * @chip:	TPM chip to use.
+ * @pcr_idx:	index of the PCR.
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
+{
+	struct tpm_buf buf;
+	struct tpm2_null_auth_area auth_area;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+
+	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
+	auth_area.nonce_size = 0;
+	auth_area.attributes = 0;
+	auth_area.auth_size = 0;
+
+	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
+	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
+		       sizeof(auth_area));
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to reset a PCR");
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 struct tpm2_get_random_out {
 	__be16 size;
 	u8 buffer[TPM_MAX_RNG_DATA];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362dee..8320cbac6f4009 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -219,6 +219,7 @@ enum tpm2_command_codes {
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
 	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
 	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_PCR_RESET		= 0x013D,
 	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
@@ -423,6 +424,7 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
+extern int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
@@ -440,6 +442,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 	return -ENODEV;
 }
 
+static inline int tpm_pcr_reset(struct tpm_chip *chip, int pcr_idx)
+{
+	return -ENODEV;
+}
+
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 				 struct tpm_digest *digests)
 {
-- 
2.31.0

