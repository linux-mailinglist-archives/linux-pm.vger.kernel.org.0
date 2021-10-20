Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA6435005
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhJTQWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhJTQWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 12:22:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D80C06161C;
        Wed, 20 Oct 2021 09:19:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s136so19742688pgs.4;
        Wed, 20 Oct 2021 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RVskMfLvnfzVUoBAQludYY3ucNcWYtl9QzD8dZHotuc=;
        b=dZwm10x14hXd/CU/42z616E2cL27DnPxrxKJCzQxBTrEBHpRefPrZspEAHT+WWukeu
         0zK0m0flZFLx3TrDTqY848TD1979D4y0xvM6xw7i+QlplgnCQV0rz0QnzVPrJaktzTRi
         dAl0jUYzJi2/ZMjbc6Z84GREyMV2wSHmcFu5Jp0ZuB5AtGpwfzpPSYYHyHuHzlLqeBty
         DL8yvBWci+iWuVgyvtuE1xjbGfYOGpZFpWcWjNF+tph3kK1xFpKYNFWokgtdSriHWMrW
         DLbesuA/8Bm9yaTH20Eq2I8JKbD6TQG2RnGTmayJBc+U4kmLGmZZQldzm5r63yiBkHAj
         ermA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RVskMfLvnfzVUoBAQludYY3ucNcWYtl9QzD8dZHotuc=;
        b=wvDbK+fZIu8WfkcwoBlAkt70r9p+wCgTOhAwLdvyER4r2mg+rZnYaH5DjsGxlK+QFD
         BZVOSbWI73Nrl9xj5MFmrW+wAf/tyXHSnyknLJ86nVKAfFTeyeEYlj86tipzYkG//0pZ
         moXILbYog/m03yGQ651HAffi/yhAKxOZlzzeNop+a/EGYHz4YI8Ehfg8Aycx4jzzNgs0
         YnyZIsH3zUVRViusECPkFSrF3OJaS7I+d8V3aCcl44gf2ioK383v/bGb7+iDR7nYQSMH
         Q39FEytuj3zieNlZPp0WGyN9TecTCJSC3/cWsPL2m7yKyt1uxRAb9Lz8HylQfyjzChSZ
         HLVw==
X-Gm-Message-State: AOAM531skRjTWB0fpvyD5eNa6Kf5pBavdCYu+aX6OmEJXh44acDvCF9e
        tXgjZVn5Gj09AX/rUj4VBg5diICAeMCTSQ==
X-Google-Smtp-Source: ABdhPJx2EFlsrq5zQzY9KGbW9P0LIsO9N2I4cpVyrz3aUdL354bgPUcPRw1cdSbV0us8Lbgk4BI8nQ==
X-Received: by 2002:aa7:9a1d:0:b0:44c:af89:e24 with SMTP id w29-20020aa79a1d000000b0044caf890e24mr771679pfj.12.1634746791100;
        Wed, 20 Oct 2021 09:19:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i13sm2678730pgf.77.2021.10.20.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:19:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 06:19:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     jiangshanlai@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4] workqueue: Introduce show_one_worker_pool and
 show_one_workqueue.
Message-ID: <YXBBpdrxcGEfdESC@slm.duckdns.org>
References: <20211020030900.321837-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020030900.321837-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 20, 2021 at 02:09:00PM +1100, Imran Khan wrote:
> Currently show_workqueue_state shows the state of all workqueues and of
> all worker pools. In certain cases we may need to dump state of only a
> specific workqueue or worker pool. For example in destroy_workqueue we
> only need to show state of the workqueue which is getting destroyed.
> 
> So rename show_workqueue_state to show_all_workqueues(to signify it
> dumps state of all busy workqueues) and divide it into more granular
> functions (show_one_workqueue and show_one_worker_pool), that would show
> states of individual workqueues and worker pools and can be used in
> cases such as the one mentioned above.
> 
> Also, as mentioned earlier, make destroy_workqueue dump data pertaining
> to only the workqueue that is being destroyed and make user(s) of
> earlier interface(show_workqueue_state), use new interface
> (show_all_workqueues).
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Applied to wq/for-5.16.

Thank you.

-- 
tejun
