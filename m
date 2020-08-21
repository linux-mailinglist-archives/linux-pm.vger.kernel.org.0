Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B718F24DF14
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgHUSHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:07:31 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43354 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHUSH0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:07:26 -0400
Received: by mail-ej1-f67.google.com with SMTP id m22so3310308eje.10
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2020 11:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0QVNv4ivtfXiqlO586IdZb/AHjf+Dv/cn2vJceyvkE=;
        b=VVP2Y8cVwPa7EwVaNfg/Boxo4U79Vw9XNHQpi9HSSfzi/uVsfiUFJ3BMKB58TKTZoX
         wecXRLeEzvIxn0ux/1QZXK1dKzfOCDOOI9QKg2C842drvaYodASBFpJIRouvOfRh3rYb
         EuKPiFhC4FCMNCdJhzk7xKqP+OKOfD4m5l5xt7V1gK0qJGYY5wxZyLBHwfCF/YMtF1Cs
         RT6wfHbVCPzH8y5qd5i3txtt66QO/pFMQtX753lvouBNjLKthCOt0+o/5sgXpnGRHkgd
         jVXXhCIuTIqLXfFAGE001MGmRC2S0Rrnm2BAMHr66tDDwXQyjgd7ghGSB0Kx23KrHuod
         Yj5A==
X-Gm-Message-State: AOAM5303XgxRGw7i1up01EbNUUzHJ6MDDvZf1Hiie667ESuus3xY77wS
        47BMa8wuplReEc2dE7ys8E3Jb6lqf6x5vd8gvZU=
X-Google-Smtp-Source: ABdhPJzdDfLHD+/7VTkb622JxZ9WOvRghKNvJUVNSpOVJWGKAJzzENNhAgY0USZ8gZN6sML+yvYWhS72rBvXOlLeJOQ=
X-Received: by 2002:a17:907:2082:: with SMTP id pv2mr4005960ejb.188.1598033244777;
 Fri, 21 Aug 2020 11:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200817150348.3976515-1-antti.laakso@linux.intel.com>
In-Reply-To: <20200817150348.3976515-1-antti.laakso@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:07:13 -0400
Message-ID: <CAJvTdKm=M4zTGRNSynOMEC9KhqLCPmZAupb5D3QurYFmL4Tg7Q@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: adjust columns for Jacobsville
To:     Antti Laakso <antti.laakso@linux.intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied.

thanks!
Len Brown, Intel Open Source Technology Center
