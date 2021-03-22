Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD953343A84
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVHZ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCVHZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 03:25:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D5C061574;
        Mon, 22 Mar 2021 00:25:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g20so9590285qkk.1;
        Mon, 22 Mar 2021 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEWoCASMC2T8zLB90/eij3XLsw+OKMoa8MsgPayCAzY=;
        b=qkOyQRaCEuNU8oCTo98ByplCB2+M3ntAfMUW0DZTET0IAgFlB2Szwrv5YQ6FbWw8E6
         HcC6FRRQn9/S3Hdj/tJOPWIZ2jwSHZhE0/jaHgVyxdbdbeKCMwACxCJZyiQ4YTVOSNud
         VeNwnACzIn31xnRnxxLJCnmTy7vSy3nSRXboG9ic2Lzai4KldTqMR2M+fcUZ8DF4OR38
         MRWd5s6/E+guJ1PscDahZRNGP3do/h99aaO9KnlAQn7Bz3cJIz39kZK44xNgZ/O2Jlkx
         cfryzRqoaYIU+zXM3g5O5NlI4fYU/szuH/PQg37d9qrw1zZA9M6mvCeUGZKSt3za2Adg
         r91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEWoCASMC2T8zLB90/eij3XLsw+OKMoa8MsgPayCAzY=;
        b=Cy2RoQBYIEXm25ZjSwkt9qmGtvGdL6pWD9PjIvXqvTCelgAKGH2u3AtqK1u69w/5Yi
         NiOZCq4yhv8NWutbJXEge8sG7p/vVazYylZ9SuZ8iBo+3RU5w3jdYgu0SXhjruu1N7gA
         halIcpb1lW9fDmpExju+c0uptcReymkXQAX8uedSSI34rjWrFgehJmLd5pvFGBA5oGli
         iWpuh1adW0AcYN8ES79io9nZhNDpbyPXFinueUnNOYGjFBfWTc3O55pzQAINvMW5C+gB
         4h35FNpGTV8DpJrWrSgWdBKneH5VzBe2C3mvyeTmCPjKQmN7KxESFJQxz9jf141G0/Xy
         xoVQ==
X-Gm-Message-State: AOAM533+WJDygqm/iYZNzDbxrCEp6qvDXkRJCUmVRBljagh3329tGpMU
        FLjv6a+dDmkymM3khlYQlporhzTv4nK/+jzn
X-Google-Smtp-Source: ABdhPJz4Poes2lPRir3F8f48QhGvzAcdxw8LFYGyH4epXNak3HvMfge20iQPOFdD7Ysi0HkA5lGxrg==
X-Received: by 2002:a37:5884:: with SMTP id m126mr9928081qkb.459.1616397906931;
        Mon, 22 Mar 2021 00:25:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.221])
        by smtp.gmail.com with ESMTPSA id z24sm9727495qkz.65.2021.03.22.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:25:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] PM: devfreq: Fix a typo
Date:   Mon, 22 Mar 2021 12:54:54 +0530
Message-Id: <20210322072454.864068-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/stoping/stooping/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 6765c03334bc..5e1908507783 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
  * @edata	: the calculated data of devfreq-event device
  *
  * Note that this function get the calculated event data from devfreq-event dev
- * after stoping the progress of whole sequence of devfreq-event dev.
+ * after stooping the progress of whole sequence of devfreq-event dev.
  */
 int devfreq_event_get_event(struct devfreq_event_dev *edev,
 			    struct devfreq_event_data *edata)
--
2.31.0

