Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0301CAFA1
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEHNSR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgEHNSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:18:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F7C05BD09
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 06:18:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so1785838wrp.12
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2020 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9nChlhKbO9BjNaYzNwfsyUYTQj0xKTlbsDHkjKVD9kg=;
        b=nANjiioTUJaVJfjULoRIi8nV/rgHwSpBvsRO6EQVlFhkUVXkfEaQdlX2OM2u0OdRMu
         uukdCy4/iM7UgCG09MdWXmIArxiuZ2VMHUo2iAZzLYAtWWkPYYfMQwDfwCNpzVM62TxG
         mUOBHTf0AF4bWdYtQe+AEnyPj8Q78QjySWZnaA+WokDwSH97xWz6Bk3vkioelikKVepJ
         9B9G3DmSUyAhDyN34cSXkOfMvqlT3VuvVxV+BxCxzXfJV3Ayi17oBZ5y1hoR5SgN6YPm
         HWHKBji3uc81BImbm/IIiPjvdk9PEJxc5/eN+NZTa2lx/ooT7XplQU8h1lpoQW2UpVOg
         x9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nChlhKbO9BjNaYzNwfsyUYTQj0xKTlbsDHkjKVD9kg=;
        b=GrtPkVhdfUoIQ6fnCuvmWPQw5V7Othje0DqrIdvNLVCwOK/jpG3czLLv0Q6utQ7NI5
         nGufVsm+DLSEet+efoN1Sj/qAFuyCV/LyssjTh5DbITssGrbabBiVSRSS3FeLtdh3B50
         VMI7tdZaceCXjRIZ/r6b9IZp99jtxQo2krqk71+TJoYxJnf2VNF1e2V74ZNIZ17lboK0
         JrIeTOwN+rSX7aq8T2qp4pZTYGvZudJ6KaeiZ49KpG7k/0VqgvhMjvPLKPtTzg3hHoSe
         yAK6Og8EEQKvY+84U6Lysfp7FdLC7AxiU2v3O6la1v2dZIwoA39D1sCCZbIbPw5nDQwP
         7f8g==
X-Gm-Message-State: AGi0PubMgwNpK9ydorv3ooS/CrXzo+FMiDlUAV3z7whYXrAET2JpoD4t
        V8VkEzXQgsh6CHZTcAA68DI7YXvRqso=
X-Google-Smtp-Source: APiQypL+1KhIUnHBdu8MermDCbWXNpBe6I70VK/mm3MUDxStvjwGwDUlBSSTUQKpESNMefoQrrDwTQ==
X-Received: by 2002:adf:fac5:: with SMTP id a5mr3115224wrs.210.1588943888335;
        Fri, 08 May 2020 06:18:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u12sm13658718wmu.25.2020.05.08.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:18:07 -0700 (PDT)
Date:   Fri, 8 May 2020 14:18:04 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508131804.GC10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508053359.ul5dbws6vkpdrbef@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053359.ul5dbws6vkpdrbef@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Friday 08 May 2020 at 11:03:59 (+0530), Viresh Kumar wrote:
> IMHO, you have over-broken the patches, like first two could be merged
> together and all exports could have been done in a single patch, etc.
> i.e. all related or similar changes together...

Right, I don't mind squashing the first patches. For the exports, I'm
guessing they'll need a case by case discussion, so it's probably
reasonable to keep them separate, at least for now.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
Quentin
