Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09B5ECA1D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiI0Qvu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI0Qun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 12:50:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606613CC8
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 09:50:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d11so9598662pll.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p+EwdeqCoE27EgkHyCYpqbbvZj82cYcu+QCeLhfwJXs=;
        b=aUL0i1ZYy8YBSietWoW55lkWRiA6ms2vaAGiwhHLSHfFYLJGBYVuEu1KknbIzTmLIu
         3tdKkYnE/QPVoN9ri1hM7KskuvlVA8EFWSdvnEJuUCSz3dmDugvG5op0xEABb8KrIkhb
         Jj0ZosfPt3fXaPg0Dyoir6cAAJqLTfyGzA5vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p+EwdeqCoE27EgkHyCYpqbbvZj82cYcu+QCeLhfwJXs=;
        b=nA5XTGPjqrFYLXltmEE7EY2ddiqKNDKNTegVuVoeSMrB8VXKhaZKe5+G5opQbU7+mK
         XveMKYOCF86nfozjnJnLynx6SwZwxlZF/4M7GHj8KkGaVRopNknZnv9Mn6Fc6/zc6qsq
         8v43PZT+AdHpN73smbpPBuktRvbRFP6b7GJ83n4FkGAgMPRwmV4T7JlCG/xKjIP5bEoV
         UbGDfHBe6e3i8P7LSljvYJB2xjrTq7OylolfJV72KVuSApf5UMDJ1kIQCEBuOp898xjJ
         hHFkHAC9Sc5iabo3qpw/LSk7MzYbtNF9WyrF1T7Y27NmYHWgSzfFxUVVrkIaXqGEfZ1o
         qidg==
X-Gm-Message-State: ACrzQf2G2MzEWtgPv3qtxw2MtkxxZr0lUnaNVabZb7m/441HCf/2XIhY
        L0NtSRB1lr0NUcLaVoOr5XaE2g==
X-Google-Smtp-Source: AMsMyM7agmtrs6Ny/a0L+p0JUaTQ87FYX8wWIlXIJvozMPPix5xwPGbzifp0Pm/ltBxODYj5CxqiHA==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id w7-20020a17090a460700b00202e22d489cmr5620580pjg.80.1664297428055;
        Tue, 27 Sep 2022 09:50:28 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:50:27 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 10/11] PM: hibernate: Verify the digest encryption key
Date:   Tue, 27 Sep 2022 09:49:21 -0700
Message-Id: <20220927094559.v3.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index e0b902d2dcf13a..1f08942450775a 100644
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
@@ -486,7 +492,7 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	struct key *key = NULL;
 	int ret, i;
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
 
 	chip = tpm_default_chip();
 	if (!chip)
@@ -605,6 +611,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	struct uswsusp_key_blob *blob)
 {
 
+	char certhash[SHA256_DIGEST_SIZE];
 	const struct cred *cred = current_cred();
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
 	struct tpm_digest *digests = NULL;
@@ -612,6 +619,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
 	struct key *key = NULL;
+	struct trusted_key_payload *payload;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -629,8 +637,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i <= chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -670,6 +680,59 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
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
2.31.0

