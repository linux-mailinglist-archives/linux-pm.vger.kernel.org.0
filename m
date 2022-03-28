Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961594E918F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Mar 2022 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiC1JlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Mar 2022 05:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiC1JlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2022 05:41:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917F13FBE
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 02:39:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so9245684pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EP5YfkKndCxZoqnbL3VWe8R1MEXt2GN5QsvGnr1wr0w=;
        b=oXm00yskKak6L8KaL95CC1xM/seXvJOX+qc6d5vsaqB+cwlwpEyh+cnPyfUdt76eNV
         sUvwJpbLNKmYPyYvfDKDbdEyLAp7UZVWVPTFilnqidGlwCU9PJXEvo6UaDVHy3+vR3D9
         TFa3SZayegyW6TzSBxwegt/+E1yR3P8UtN78zy53pjkqaKJ+hgi/2Qja8RTgSdoPtvxQ
         2O5bm3gpZyXN4GFrNZqf5kiHeLmNojReF5oEPvjk9PN9GC00WR8VmSF4EeySx7V0G/pg
         8+G/zRPFNOdjHpyzkF0FyJ7f0dumh5fq7bvagHR4aGoR2rvC6k5REQmLLqDyWHlrWXmk
         eqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EP5YfkKndCxZoqnbL3VWe8R1MEXt2GN5QsvGnr1wr0w=;
        b=66C2WaxyhiFpU3i49yRf95OjJwk6gs8o2ijd8FMdHnqE5uRQLF1yxw1Xd/kSR90r45
         HI55etQFrEB/JOfh23NkgAJkEwTa8pEBTBEx8dScv7y5xnpgLX6EuU8cszsJHIkprMer
         V/H4U5Y2YqkwwpfW/AY+IufOQW6k6jqX/oUAVHWBUd2xFaXhlN8ah0hdmejV8kqn1a0N
         mg+IP8TDeRW8XV1xhkRr76E46ZEF+ZjfZwJVjjCe0uTwyanl2b5/S1VKJuZIlgQJ92wC
         jlAodXVg4woev8LOcDqXacq7YouyaXwda8w2FGEaOi5HP4HwyqfEJ2R4Wxqeo7DIhSup
         9FOA==
X-Gm-Message-State: AOAM533mKZKZf76rE6CIrsav6rB6kvNC1EOVHyuN8hUoLlpSaoO+bXrJ
        w/YB6z7N8qe7W4g7+U9wlGcMlg==
X-Google-Smtp-Source: ABdhPJwr5FDXRGP4HrnKoei9zDk0Vs/01l5Vozx+fCxRfN9uOKxOQnqlQ2vsnnJ5PI2bOlNY8xqv7w==
X-Received: by 2002:a17:903:2443:b0:154:4104:466d with SMTP id l3-20020a170903244300b001544104466dmr24860523pls.121.1648460375294;
        Mon, 28 Mar 2022 02:39:35 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a4f0b00b001c6e4898a36sm20351812pjh.28.2022.03.28.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:39:34 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:09:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael.j.wysocki@intel.com, sboyd@kernel.org,
        stable@vger.kernel.org, vireshk@kernel.org
Subject: Re: [PATCH] opp: fix a missing check on list iterator
Message-ID: <20220328093933.xa37n4dmq6o6tpel@vireshk-i7>
References: <20220328085057.ikn3mcyz2gbftkg4@vireshk-i7>
 <20220328091339.27021-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328091339.27021-1-xiam0nd.tong@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-03-22, 17:13, Xiaomeng Tong wrote:
> On Mon, 28 Mar 2022 14:20:57 +0530, Viresh Kumar wrote:
> > On 28-03-22, 15:43, Xiaomeng Tong wrote:
> > > No. the conditon to call opp_migrate_dentry(opp_dev, opp_table); is:
> > > if (!list_is_singular(&opp_table->dev_list)), 
> > > 
> > > while list_is_singlular is: !list_empty(head) && (head->next == head->prev);
> > > 
> > > so the condition is: list_empty(head) || (head->next != head->prev)
> > > 
> > > if the list is empty, the bug can be triggered.
> > 
> > List can't be empty here by design. It will be a huge bug in that
> > case, which should lead to crash somewhere.
> > 
> 
> There is anther condition to trigger this bug: the list is not empty and
> no element found (if (iter != opp_dev)).

I suggest reading the code again, considering opp_debug_unregister()
as well.

What's happening here is this:

- Several devices share the OPP table.
- One of them (devX) is going away and opp_debug_unregister() is called for this device.
- If devX is the last device for this OPP table, then we don't migrate
  and just release all resources.
- Otherwise, we migrate it to the next element in the list. i.e. any
  device which != devX.

Please tell based on this where do you see a possibility of a bug.
Surely there can be one, but I fail to see it at the moment and need
more detail of the same.

Thanks Xiaomeng.

-- 
viresh
