Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1B579289
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiGSFif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 01:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiGSFif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 01:38:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7124F05
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:38:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fz10so13730471pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9iny7g5Olb9JkpomljEFR3iuWczXP7edttdfjoOq+44=;
        b=PuXNCxDstlgmjA8EpTTV5xmIc8ZHdEZ7VhlA7wP1OexBG1BFt3F4xsfHzu7Cl7i/nN
         2eFSLgVPvLA20lQovXHIti4q2IvAvMgPnxCmAQaEXms/E57dz78UiztcMnpwwFnHHlNi
         +t25dFCv+HPh/0AW/0702L9yaorQU7qPL9hXgb0dDEPDFOT3qJ2acQyXn4AWUfWr/PfO
         fHZ/3+i5qGv0ga75u+u0IW8yQpFNl8nvsXfZ/T3QcXbwhYgqMPTEr2Nkbgns+TnxiVTH
         WbHE4IRhRJw82KdLXDxViTaDBYwQNlPIxT+HLUZ9XU+MauLvJHUK8szSc2qEo3TNqMOX
         8bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9iny7g5Olb9JkpomljEFR3iuWczXP7edttdfjoOq+44=;
        b=Wzn1NEegmnt06+FTcO81G4NI0oTHxknE570UvnQgx8IY6PwfBqbovIsdhyjrbHSlyY
         O5vXZPqG//EFE6Xuun8yAalsuXvGb50xO0xcxkP3wAP629Md/zHgY70T8NiIwn3th3vZ
         sYxkYa0EozUcbw3SamZIxvcxs1KqhBTT6ha8azoGCJw+jqEWkpWZ+jKG22k2KJujD4lh
         g0MFAuWx9Dsv/15T5jIyBw7TMukle+jiWlANMcTReViBg6nnUNJDXvYv49YeLoY3pyEL
         aiskDRQI53N+yBTZ0Ea84C8U41j0nKgq+IQMavtJlhfe8gRHiSRahEdST53KU+tO+tVK
         bdDQ==
X-Gm-Message-State: AJIora/gXLZhxcaiwGcvm16nxOyTSXSUav1TPnlB9zIWBdkfV0fcLmAb
        EnFdobn2VusVfCSCJitkszLGRjmLjonhKQ==
X-Google-Smtp-Source: AGRyM1tYP6buV52eVmzkwW4006XGTrIVjqDV1luUNypBXb1T87LxuTmT0YUygzO4JbEpVu81vXn/JQ==
X-Received: by 2002:a17:902:b10a:b0:16c:51cd:a6f with SMTP id q10-20020a170902b10a00b0016c51cd0a6fmr31306901plr.42.1658209113705;
        Mon, 18 Jul 2022 22:38:33 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79ae9000000b0052ab8525893sm10662536pfp.142.2022.07.18.22.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:38:33 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:08:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] OPP: Fix refcount leak bug for opp_table
Message-ID: <20220719053831.bfmzqfbzn7kg6lzw@vireshk-i7>
References: <20220718133632.937290-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718133632.937290-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-22, 21:36, Liang He wrote:
> In _of_init_opp_table(), of_put_node() in the last line is not
> needed as the 'opp_np' is escaped out into 'opp_table->np' and
> ’opp_table' is an out parameter. We should call the of_node_put()
> when the 'opp_table' is released in _opp_table_kref_release().
> 
> Signed-off-by: Liang He <windhl@126.com>

Applied with few changes. Thanks.

commit ce736cf71b5ab8ad9b741dc7a4a07e41c27d1421
Author: Liang He <windhl@126.com>
Date:   Mon Jul 18 21:36:31 2022 +0800

    OPP: Don't drop opp_table->np reference while it is still in use

    The OPP table contains a reference of the DT node, opp_table->np,
    throughout its lifetime. We shouldn't drop the refcount for the same
    from _of_init_opp_table(), but do that while removing the OPP table
    finally.

    Signed-off-by: Liang He <windhl@126.com>
    [ Viresh: Updated subject / commit log and drop reference from
              _of_clear_opp_table() ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 8367823a2001..e4002b075422 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -242,12 +242,12 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
        opp_table->np = opp_np;

        _opp_table_alloc_required_tables(opp_table, dev, opp_np);
-       of_node_put(opp_np);
 }

 void _of_clear_opp_table(struct opp_table *opp_table)
 {
        _opp_table_free_required_tables(opp_table);
+       of_node_put(opp_table->np);
 }

 /*

