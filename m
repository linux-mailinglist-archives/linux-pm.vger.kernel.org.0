Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78A618706
	for <lists+linux-pm@lfdr.de>; Thu,  3 Nov 2022 19:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiKCSF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Nov 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKCSEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2022 14:04:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F19623E98
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 11:01:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2527534pjc.5
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2022 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StxqSkaSdW0DFiGDjZK/lcQj70SDX3h0JUZeDApr/Sw=;
        b=Sw0/EPweqq4aCp/xXOHRuhiU6FUxVaIDXlWJK64Z/fFnPkFfI5ybp5wF2pxu3WBCm3
         PtRZK1gUQfMDvU/kbYjruRG1Vx/LJZm8FR55IR90Pq1bjY/X9B2ohNi/uQjIG17537DZ
         SXRUO//XtH2rzwoYgaJiM2jSuiBq6qCklJs4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StxqSkaSdW0DFiGDjZK/lcQj70SDX3h0JUZeDApr/Sw=;
        b=H4USs2h5ZRJerZCksKrHII+VIQpcWSdxW6x4psysAynse7DpnhGvAOEOLUB4WOoj9Z
         0c60SjKRp1yf/SDb+PHUIyMJvWa9iVrDP3bxAZIApbNH31XxTJMuIRIsvxQZ+1G5Jsy7
         04sqZZyMWWw6buFiVqYbquk8vaPa3GN/09gS6PzTQW+9vYY+ZyAEkePCeIOGBcTAD3kl
         wNd9+i1mHV2glvXv0dVDQ5TbRKUzsjVox9we7nDouO/92U70a8K5DpOMnjlPH5swMZrv
         6L5dGH9hEq47Us+8xUivhrkEsLq5FnYm9QWYyaw1Rjz2dWbQMsM64IpLAzQ2LgZRCEIg
         mb3w==
X-Gm-Message-State: ACrzQf3+pDqObYWtOCbRLN88iEIL+ixuyTBR1yWedOTYIi9XDRgNfcz0
        yXzE4ZN/da+SE1ToptaPjZmqBA==
X-Google-Smtp-Source: AMsMyM5BODQ+S1selqJ7QKi8AomvhCcwI7h4z7zEPLAtp7U4Vb40XQdT74BsFk497UD1byja6mEKOA==
X-Received: by 2002:a17:90b:f06:b0:212:cb07:fb82 with SMTP id br6-20020a17090b0f0600b00212cb07fb82mr48481254pjb.221.1667498516761;
        Thu, 03 Nov 2022 11:01:56 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:56 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 10/11] PM: hibernate: Verify the digest encryption key
Date:   Thu,  3 Nov 2022 11:01:18 -0700
Message-Id: <20221103105558.v4.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We want to ensure that the key used to encrypt the digest was created by
the kernel during hibernation. To do this we request that the TPM
include information about the value of PCR 23 at the time of key
creation in the sealed blob. On resume, we can make sure that the PCR
information in the creation data blob (already certified by the TPM to
be accurate) corresponds to the expected value. Since only
the kernel can touch PCR 23, if an attacker generates a key themselves
the value of PCR 23 will have been different, allowing us to reject the
key and boot normally instead of resuming.

Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---
Matthew's original version of this patch is here:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

I moved the TPM2_CC_CERTIFYCREATION code into a separate change in the
trusted key code because the blob_handle was being flushed and was no
longer valid for use in CC_CERTIFYCREATION after the key was loaded. As
an added benefit of moving the certification into the trusted keys code,
we can drop the other patch from the original series that squirrelled
the blob_handle away.

Changes in v4:
 - Local variable reordering (Jarkko)

Changes in v3:
 - Changed funky tag to Co-developed-by (Kees). Matthew, holler if you
   want something different.

Changes in v2:
 - Fixed some sparse warnings
 - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
 - Adjusted offsets due to new ASN.1 format, and added a creation data
   length check.

 kernel/power/snapenc.c | 67 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 50167a37c5bf23..2f421061498246 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -22,6 +22,12 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* sha256(sha256(empty_pcr | known_digest)) */
+static const char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
+	0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
+	0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
+	0xf3};
+
 /* Derive a key from the kernel and user keys for data encryption. */
 static int snapshot_use_user_key(struct snapshot_data *data)
 {
@@ -486,7 +492,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 static int snapshot_create_kernel_key(struct snapshot_data *data)
 {
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
 	const struct cred *cred = current_cred();
 	struct tpm_digest *digests = NULL;
 	struct key *key = NULL;
@@ -613,6 +619,8 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
 	const struct cred *cred = current_cred();
+	struct trusted_key_payload *payload;
+	char certhash[SHA256_DIGEST_SIZE];
 	struct tpm_digest *digests = NULL;
 	char *blobstring = NULL;
 	struct key *key = NULL;
@@ -635,8 +643,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -676,6 +686,59 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret != 0)
 		goto out;
 
+	/* Verify the creation hash matches the creation data. */
+	payload = key->payload.data[0];
+	if (!payload->creation || !payload->creation_hash ||
+	    (payload->creation_len < 3) ||
+	    (payload->creation_hash_len < SHA256_DIGEST_SIZE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	sha256(payload->creation + 2, payload->creation_len - 2, certhash);
+	if (memcmp(payload->creation_hash + 2, certhash, SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We now know that the creation data is authentic - parse it */
+
+	/* TPML_PCR_SELECTION.count */
+	if (be32_to_cpu(*(__be32 *)&payload->creation[2]) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(__be16 *)&payload->creation[6]) != TPM_ALG_SHA256) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (*(char *)&payload->creation[8] != 3) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* PCR 23 selected */
+	if (be32_to_cpu(*(__be32 *)&payload->creation[8]) != 0x03000080) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(__be16 *)&payload->creation[12]) !=
+	    SHA256_DIGEST_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify PCR 23 contained the expected value when the key was created. */
+	if (memcmp(&payload->creation[14], expected_digest,
+		   SHA256_DIGEST_SIZE) != 0) {
+
+		ret = -EINVAL;
+		goto out;
+	}
+
 	data->key = key;
 	key = NULL;
 
-- 
2.38.1.431.g37b22c650d-goog

