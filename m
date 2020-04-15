Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641011AA30F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505804AbgDONDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505788AbgDONDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 09:03:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E260C061A0F
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 06:03:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so19036844wrm.13
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5U+39TkWTU7CFl4lHYQgx2px7qcje/SDjhq9vzEPb9I=;
        b=N2rVIq8SiMSbzTNB44TC26fvAv9RrVWuy6i9RVjT2e9/6PysXAY3o0cw+pGWROjdBT
         QzuYNOW1ybVUXDbym1nHs7jnZmEcj9yMQl4lwcgD+2XpMj5fXKtoLOKFKRw8n/EbE2t9
         zWCC/2VMGbjJVcpWrjBUuOv9XEbVmwh37j3cge2Q68HSm6QnoKltgmB9pLuV69f/dohi
         +pU4kIIppcHgsVJrbc6nBBCVDeDW/19FPeZN1sQ28ssPgkfHKjNwZK5O7MwKgUuMUtXL
         5lHxtBevxCIy6Fk1UmvPiHRlkopVWcxnYeqjodhYb5FIocFN1RbPnlHNxjDxi2pUp1jL
         FSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5U+39TkWTU7CFl4lHYQgx2px7qcje/SDjhq9vzEPb9I=;
        b=uQ234u4rEW8dZNtunfPnMsnUuCTnSLqn83LR0z1hZqVzMspU6xlUTdxOOuE8vHyYoS
         dBcvKmjaRIYmPmYoVFz+2g6Nfa5kzJt5Oje5oLG6FU3OGiIAPBZR8J04K2qZPShnKWOR
         Uxj496wbSglxSXR0uLTzz90KhY9LbV/QFEnVnvTHUbSHj5L6xibfagmGG4i/uHzia6kz
         JfFU3Flh8j5F/hbHjwIhYLPNNzu92UP54gsaYqcH5wYNFTnhZ7dJCnGy4xqZripwmdVG
         cwebC+l3eCKEtioGSQeseGu0hvp+e7S+nw7gchHFv2lAne/hWpGTkNWR3TyjvwqwEMRh
         s3+Q==
X-Gm-Message-State: AGi0PuaIA9t8Np90iViJdCHRhadnz/a2ZztpWT1BWWWmsRVMIreetMj+
        XD5r0Dt+8ucu8gFTVJWo+w1I+4JG4R8=
X-Google-Smtp-Source: APiQypIMFS7NVo88wMIAGwQbRJVKFV6LPETgWFgPYzxSWsJdg9b2qrRcvaAwIC/CnCOhhpM0o6Rztg==
X-Received: by 2002:adf:f282:: with SMTP id k2mr11397809wro.133.1586955811195;
        Wed, 15 Apr 2020 06:03:31 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id b66sm23418111wmh.12.2020.04.15.06.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:03:30 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/1] interconnect: qcom: Fix uninitialized tcs_cmd::wait
Date:   Wed, 15 Apr 2020 16:03:27 +0300
Message-Id: <20200415130327.23059-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415130327.23059-1-georgi.djakov@linaro.org>
References: <20200415130327.23059-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Tipton <mdtipton@codeaurora.org>

Currently, if tcs_cmd_gen is called with commit=false, then
tcs_cmd::wait is left uninitialized. Since the tcs_cmd structures passed
to this function aren't zero-initialized, then we're left with random
wait values. This results in waiting for completion for more commands
than is necessary, depending on what's on the stack at the time.

Removing the unnecessary if-condition fixes this, but add an explicit
memset of the tcs_cmd structure as well to ensure predictable behavior
if more tcs_cmd members are added in the future.

Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200319231021.18108-1-mdtipton@codeaurora.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 2adfde8cdf19..2a11a63e7217 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -96,6 +96,8 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	if (!cmd)
 		return;
 
+	memset(cmd, 0, sizeof(*cmd));
+
 	if (vote_x == 0 && vote_y == 0)
 		valid = false;
 
@@ -112,8 +114,7 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	 * Set the wait for completion flag on command that need to be completed
 	 * before the next command.
 	 */
-	if (commit)
-		cmd->wait = true;
+	cmd->wait = commit;
 }
 
 static void tcs_list_gen(struct list_head *bcm_list, int bucket,
