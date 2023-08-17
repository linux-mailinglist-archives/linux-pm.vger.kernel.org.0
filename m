Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717A77FF32
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbjHQUmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 16:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354860AbjHQUl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 16:41:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACE2D72
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 13:41:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdc8081147so9783985ad.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692304911; x=1692909711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ON/HA/SiAC88+rr3DCSUlZBZfTPO/sj9aPfYnbMZ8/I=;
        b=ifRrRqspqYAUIBinX8EYU5JbgtyYEe0y4++wffwIl3rt37oHl/+RgqXM9breR7rX+q
         krMpd1nlz1emlA9qgmA5K/AbEGtrPLxs8quv32j0w09bYPp83eCyD3jEacb9OQlUOGqw
         75KFySlFi9RG5JrdT+xGx+imQzbkm09/bZsSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692304911; x=1692909711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON/HA/SiAC88+rr3DCSUlZBZfTPO/sj9aPfYnbMZ8/I=;
        b=VN/pu9MnaxUZ49+vJZrz/Fm2P2hWlCHJtmfm7yApDIJRLxkWJaXl95Vnba9hdKH1qq
         PVAMPjjKgF8xVWxxSsZUvvrQsqO3mMC/Z33b4aD46qJpT8KMOKIouhNWCJ2NtDEhqGkh
         bv3xmQBwg7N2XJYmrDcx6CWJcb8I5FrEhipPAJt7CnvoCWzH7uG6nmSMkhMAMItrSZMD
         rspORf7J9JB0nSOGlE5OT/JWMkCNxmH1fL1q/VnQrRSJttc/dGYAQF+y/4F5NFXJhrlQ
         KHYrFHmhqQETu9ra5f+9ezsBawrwKlQaFNRJewXVBN1dNyl6RZJ4EcxOLF9/jEZKHMaX
         YrCg==
X-Gm-Message-State: AOJu0YzJ0Xnyc0/jej7UkNXSIwsl4X2xH3a2/e25RHEoMLEqIR3CceIb
        Dm85W5Eq01HGFlU2h5daa8V/nQ==
X-Google-Smtp-Source: AGHT+IEixP8k42UxWzyK3z3mcCEOHUwHxuIqvnvfev8H2rv7kJis4nPd/Y0Gk5spob+OtZeOX4JsEg==
X-Received: by 2002:a17:903:234f:b0:1b8:a936:1915 with SMTP id c15-20020a170903234f00b001b8a9361915mr489582plh.22.1692304910696;
        Thu, 17 Aug 2023 13:41:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw20-20020a170903045400b001bbb25dd3a7sm183467plb.187.2023.08.17.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:41:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] interconnect: Annotate struct icc_path with __counted_by
Date:   Thu, 17 Aug 2023 13:41:47 -0700
Message-Id: <20230817204144.never.605-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GhnqOj5xKp4EZEn1rfER9M+dGNFJZhUCFss3oBsydI0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3oYLDqFtQnXUx50zr9QOolW/NLep8d1dsSx0k
 Wckz4fh3piJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6GCwAKCRCJcvTf3G3A
 JoJaD/sFm5t8BZrqSQzCw5/FVGoKyBL5QTsGTijXgA925uS5duD0gXBXcCcTT8aywtqgVBs/ZbZ
 skPWWlbIIWzalIc6snsWyyPwn5ho6fdWArF0Vm66IPXsbaF6UmfLITZm0EqXiMooiq1IxYjYjqA
 ZiF9FqpoHIlMW6fP1miZC3BAHFl6TVquIwXgiOitQn9BUXZEWLg8HfyYWTEn24ieXuQ6SYtaPkQ
 dg2aVGlI8TtexNZ0ELkV5QJymzFRC4MJgq4Z1EHBH/o1B35jE1SikZ5oKgNRCRG5T0lmMOP+UFV
 NI51WZiah10mT0iudsdM5YVGFF57Tddu2kpYvFYt5Oe9k01jzm6xm2yRxDPBK0bT/Hlwyu9ZMfk
 K1JLd3hZZ7cjG5tP2lrtsEd3Rg2Ne/dKeVt0DuA2rC7+NePaMwpD6k3knc4Xx2osA6q2LvzUHx3
 1ma9IcXCzMiW0OUo06nSBHrCBwjZ4c153OaMMQXt58WyyLDM9tIwBcCLAzW5iycKhwHc+BUF3VC
 Xwzts8qtX8jGPnnSctUC+pQ4mX8F9WV29UQQiQxq+FfY5QJXAOtFcGQS6F4zlcqipwCo6huO7ps
 6NKvF40Rvz2A4IOUKKQNDpG6Wd/LqM3gQkZDd7J7JsBpL1/EAKGv6OfI/BTKQGi4lLxIOm6wFf1
 iKBkAU0 rxCThuhQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct icc_path.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/interconnect/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index f5f82a5c939e..b30856db523d 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -38,7 +38,7 @@ struct icc_req {
 struct icc_path {
 	const char *name;
 	size_t num_nodes;
-	struct icc_req reqs[];
+	struct icc_req reqs[] __counted_by(num_nodes);
 };
 
 #endif
-- 
2.34.1

