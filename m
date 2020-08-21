Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102A24DF1D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHUSKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:10:53 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:45842 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHUSKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:10:52 -0400
Received: by mail-ej1-f66.google.com with SMTP id si26so3312910ejb.12;
        Fri, 21 Aug 2020 11:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0QVNv4ivtfXiqlO586IdZb/AHjf+Dv/cn2vJceyvkE=;
        b=jMvGZY6FNYgLlm+8+LeMIg54LfbYW/23NeeCKgxjYfWPNyBgjemIEo05osmzgSth1Q
         FFmdll67i/FPOBgtcP9oy/qsKRS3mIrVpezy6+UcscX1PSTXAiAwh96JpDLeWyMjMQ+E
         u8jeBHy4CzPGRzshL8Zfm3vgPxBxICQSxfedpOIJ9pBm4YWvLAuuzjgTOaYqnrT8gAUf
         mrGw9p2nwdhXZcrWMvt9USTSOnQZ/b2EGko7MUe2ity3beELDYwIt2EFGkfJjH1V69HB
         pnue8YuzlSBc+EhJpEz9pXtF7ufYeLsps1uaeq1qtjPEMQ2vxCXwwt1Np6moibvaq5K6
         AMtw==
X-Gm-Message-State: AOAM532Mj/cYu8Nz77ecCrnwUQTzFg92t8dr/YVYgg9yF6M7dIRZRfEc
        qXQuNfqT2lqWD6LipapQztW0OZ3+KuhWShPInXc=
X-Google-Smtp-Source: ABdhPJy7lkdHStvlZtrXc2EKNnTXrF8S1Y0ii0pNLJURJL9dCSjFvSZ6lR5XKX7mb8iivk5nhn8ZONZP9Tzt5KLRJO8=
X-Received: by 2002:a17:906:98c1:: with SMTP id zd1mr4260319ejb.410.1598033451189;
 Fri, 21 Aug 2020 11:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200817224215.11207-1-kim.phillips@amd.com>
In-Reply-To: <20200817224215.11207-1-kim.phillips@amd.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:10:39 -0400
Message-ID: <CAJvTdK=aGow5w+zGXKmdcnwfftFYn5ke7KK3z6HDtt=PV3aAdA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Support AMD Family 19h
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied.

thanks!
Len Brown, Intel Open Source Technology Center
