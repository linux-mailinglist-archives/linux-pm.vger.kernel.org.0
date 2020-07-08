Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662EC217D33
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgGHCqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGHCqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 22:46:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21CBC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 19:46:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so522129pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4d0/uhjpbKaMJLxvt67jf8moNVtXSC94wrjwWyBypVY=;
        b=r2+k61f1COuoC7suDeWmO1G7Y+MgyYIcfJ81IKtgAcEl7RT3B9rZ8q3WXsBHSyj55X
         WcVLBOfMMn9Zr3XNdFyTKlqA1Fu6k5cy+Kg/lPoLbZqiC/mZ5NLJFpA+RyuKfw8zqkvp
         MgJ5phMUfUmxE2GKft2QTK09mTesKT/UzRRwM25oH/IVdoZPyvd+i1cD8lG2ntO1dGZe
         pr4lvcreNHY5zxutmf4XR9u5aOCy4rGZ6db0koiHs1wEtx2gfhB7deCI9+kLzuDrjF47
         Z3Rjods11GlP1wMX74xjc9DpgXx8hRx8VKy7lQbpZGTv+wqWZHFz4Tr+bkVS0cCLF42a
         lCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4d0/uhjpbKaMJLxvt67jf8moNVtXSC94wrjwWyBypVY=;
        b=kJe8rn7+2Xar2p21H6edyf03nk+aobt0/07Uzb7UxTtnPcPDr72uh+Z1slu1iBlr5p
         oI4PcjJtYEr8yNGnRZyR7hVmOUYjNwBEWv8Ov8781rhi+IFfNSR0/r/xmTE4WDW39j7H
         re09VtNEr54fB20OLLIz32uHHpbxDpvBPPzzIMdKxweksL3JGk5Vu1Bmv2dl7uBZWE1z
         EX7OYpho6tGF4sgnddMfc+OqWtHo2lBUAv1Exht0rCjGQ+cg9XiW/Cjdh1oSNHpUVX5f
         plQRhc1HgG5quQ9nNfMnh+Cm7KgOEi1v27mmQuFr5LwTxPDpdHuUW5vH3YoyXcj/F/U2
         G7NA==
X-Gm-Message-State: AOAM531qo0XDJ6XcWDGpm3KLMaJNz/QWfMR6oVs01ZczjXPjXY+l+way
        9bfmgJs3mAO/S+ATi3ipxppRWA==
X-Google-Smtp-Source: ABdhPJzw+eidPOdhA8COAgdRYKhDbVxgc1Aq+QOqNwufhoOitpYPZy3qbfGSG0meYEC3DDCse8cMSA==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr7732080pjb.170.1594176395410;
        Tue, 07 Jul 2020 19:46:35 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id f6sm25914569pfe.174.2020.07.07.19.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 19:46:34 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:16:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: Re: [PATCH -next] cpufreq: add stub for get_cpu_idle_time() to fix
 scsi/lpfc driver build
Message-ID: <20200708024632.kutr6vyomrpsctai@vireshk-i7>
References: <3a20bf20-247d-1242-dcd0-aef1bbc6e308@infradead.org>
 <20200707030943.xkocccy6qy2c3hrx@vireshk-i7>
 <b35ed758-a964-2f76-d2d3-99c260458878@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35ed758-a964-2f76-d2d3-99c260458878@infradead.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-07-20, 11:18, Randy Dunlap wrote:
> Viresh:
> 
> James Smart replied in another email thread with lpfc explanation for using
> get_cpu_idle_time().  Please see
> https://lore.kernel.org/linux-scsi/7ae1c7e3-ce8d-836b-1ae7-d4d00bd8f95c@broadcom.com/T/#md083717b1ff3a428c3b419dcc6d11cd03fee44c7
> 
> for this text:
> ""The driver is using cpu utilization in order to choose between softirq or work queues in handling an interrupt. Less-utilized, softirq is used. higher utilized, work queue is used.  The utilization is checked periodically via a heartbeat. ""

To avoid ping pong of messages, I have instead replied to that email
directly now. Lets follow it there.

-- 
viresh
