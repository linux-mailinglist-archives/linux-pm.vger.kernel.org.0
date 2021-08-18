Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069A53F0DAA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhHRVtW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhHRVtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 17:49:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BDEC061764;
        Wed, 18 Aug 2021 14:48:38 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so1151075ooq.13;
        Wed, 18 Aug 2021 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXeOhhO90b9jYJjZOPuzE519VVKTcSq6o+2ecDsjYcE=;
        b=n+ddOVtvlahmA+z+YjAlWc7gsVK4AGKExw+Aa93odbyAy6h8helwF1oozZqqN8ReP8
         il29Kf/7KEoBbgKAyzp3Y+OWlHHU3oD/kae28lHa+rC3EoZMEf0BRLKPXJFKd7n4Ogyv
         HxxFIZoHOPAsCpFO5UIzFTZKCkWa0aJmMX+91H5mf9GU2foWVnHhMCBqZn/q8nLND59G
         9Uu2cdLCc7OvbD/5D3+TuboxSafBd6NmRBNsvRGJzJvzUArIVP8iyiJ6s8wlvaVMvMyj
         DfSeJN1bbq1RwF/eNhKlNkJ9UIvm1m8tNCjwju32S0jQB9pTeNAaaa62oCkOkuFPluE5
         ZF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXeOhhO90b9jYJjZOPuzE519VVKTcSq6o+2ecDsjYcE=;
        b=Rhm+RNmEV6di+5o/lDFctpkkbu6yVMuryaI5Ec7QWnsCF8NsWxZVRh5QdxryySmoK7
         TLSJTtGCHu4SurmGXzPJhekAK18AaUG6G6VO48SgMn0F5BJxp1iNMBqOnYAI7kPZlXvh
         jThXqdcAkq/R8Hfykwmsn2QA7kJ7fdDZ+oaYFxZEbhP4EbXmNAvfFzwq5exkn6C+YtWQ
         KFmiIQwzQWSmxwcnsLOEABsQ3VdHpA8Uhozm3qTcKfmSwM+n97B/1mKMN/B4lNUVxtZ9
         gC7WVEr7Ji91rhdJMvSmerEyAMcHKUr8x1teRD8Njqyh8saBadoh3V55cNVQf8aSsbqN
         +UDA==
X-Gm-Message-State: AOAM532WL9XxTKUf36TR8DaIx+OCWsmTEnF1Sz7MStE/MrclqdDuP0rz
        cFl9G195iPfLRbY69n55Zxo=
X-Google-Smtp-Source: ABdhPJy1/Nm092PBE7+VydqgQjbvZxuCynfS5TBKwv4ZKKY7YhxDCPACF6ADGJ3afM7FLtgvEpcZ3g==
X-Received: by 2002:a4a:3651:: with SMTP id p17mr8533256ooe.92.1629323318438;
        Wed, 18 Aug 2021 14:48:38 -0700 (PDT)
Received: from SBox.SBox.org.net ([24.144.34.93])
        by smtp.gmail.com with ESMTPSA id 45sm277580otm.43.2021.08.18.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:48:38 -0700 (PDT)
From:   Falla Coulibaly <fallacoulibalyz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc:     Falla Coulibaly <fallacoulibalyz@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/power: Remove blk_status_to_errno in hib_wait_io
Date:   Wed, 18 Aug 2021 16:47:40 -0500
Message-Id: <20210818214740.3743-1-fallacoulibalyz@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

blk_status_to_errno doesn't appear to perform extra work besides
converting blk_status_t to integer. This patch removes that unnecessary
conversion as the return type of the function is blk_status_t.

Signed-off-by: Falla Coulibaly <fallacoulibalyz@gmail.com>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 3cb89baebc79..9ec418955556 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -306,7 +306,7 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
 	 * a plug will flush the plug list before sleeping.
 	 */
 	wait_event(hb->wait, atomic_read(&hb->count) == 0);
-	return blk_status_to_errno(hb->error);
+	return hb->error;
 }
 
 /*
-- 
2.32.0

