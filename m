Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E74E9081
	for <lists+linux-pm@lfdr.de>; Mon, 28 Mar 2022 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiC1Iws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Mar 2022 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiC1Iwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2022 04:52:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F547066
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 01:51:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so10498593pgn.8
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sqx0rJwCSQ99MfRw8XtkvIUHwIx/mgTEACluM2DeFwg=;
        b=IYPA4nLVLk/FmSNQd42ARPe0FUtPYdnekvkQ+igCbtBeglZ2Dyt5HGcdy3Yr4UncDP
         ZM+jEWWgGU+nCNAGPHvMZvgwdpyXX9YIGX9StfJ9ofqsRSoHB5ZdFYC0JIcJ8NVjqRE6
         YLVD0WOG+rhAYbFI2AGreDE6qFbD9Kegv7eE55IQ/D+Q8e93KNita41B+tcdm/QLj4+8
         UToOfSGNPlKnehmqGoHk9wqtCmRqg819lrxxKkjUJ+CqHOaiLlBBBxCJFwxdvkobFlYK
         bnSObL0wAKd4N8fPJJJRscDHAilwFmVn0e8ASzvSC6ZMShnyrOF6HX0mpWjuHW1QbvUe
         homQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sqx0rJwCSQ99MfRw8XtkvIUHwIx/mgTEACluM2DeFwg=;
        b=5M8n/lfcJjMIdoUsa9MiHybw3YJd9yRgQ5s743SOAVkokTT8Erm33W4AIL5PbKDSS6
         FDKsjSKwUTz7+9mwU5Hpk12IfpC/f0QPZCgVIgHcySvHZuft8Q/gwu1OfSrlzVlkksXO
         hUpQPOzIxLkcTPq6Qh31LfYA5SzDx7k74KldNJtCbrappxLx05Tsbtrb05vEgRMZwWIK
         4r7CGL8a6Q/JkdtXabWcKu2Z7OkL+enNwhGGxYZx3WbykeiQtstus7at5Ckyp0ETmxNH
         lF4gmFrwDQfnE2wWLkinV4kXf2f+Na3aMBLtwpKpbXkZu/qs5FbwU0/V0rmdrMeluh5K
         y99w==
X-Gm-Message-State: AOAM531SGnzhVrrRRbpwVDwRYlCKwJFuiPXYqTNVWhYlU7sHwanRTDiF
        dbVByu5qTzEyA/obC7z/0xHlUtXuyN1kqA==
X-Google-Smtp-Source: ABdhPJwW/6gdtw48ET2SKpPDWicGASH5Y7hNn5I/wV4zR5H3rz3xz23kqoOlrbkKGW+qunPj7z3FiA==
X-Received: by 2002:a63:310c:0:b0:386:afa:45bb with SMTP id x12-20020a63310c000000b003860afa45bbmr9734649pgx.133.1648457459470;
        Mon, 28 Mar 2022 01:50:59 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm15524566pfu.193.2022.03.28.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 01:50:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:20:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael.j.wysocki@intel.com, sboyd@kernel.org,
        stable@vger.kernel.org, vireshk@kernel.org
Subject: Re: [PATCH] opp: fix a missing check on list iterator
Message-ID: <20220328085057.ikn3mcyz2gbftkg4@vireshk-i7>
References: <20220328031739.72togwws2u2rlluo@vireshk-i7>
 <20220328074322.25349-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328074322.25349-1-xiam0nd.tong@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-03-22, 15:43, Xiaomeng Tong wrote:
> No. the conditon to call opp_migrate_dentry(opp_dev, opp_table); is:
> if (!list_is_singular(&opp_table->dev_list)), 
> 
> while list_is_singlular is: !list_empty(head) && (head->next == head->prev);
> 
> so the condition is: list_empty(head) || (head->next != head->prev)
> 
> if the list is empty, the bug can be triggered.

List can't be empty here by design. It will be a huge bug in that
case, which should lead to crash somewhere.

-- 
viresh
